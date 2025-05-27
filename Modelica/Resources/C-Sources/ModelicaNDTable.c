
#ifndef MODELICA_NDTABLE_C
#define MODELICA_NDTABLE_C

#include "NDTable.h"
#include "NDTable.c"

#define NDTABLE_INTERPSTATUS_OK 0
#include "Interpolation.c"

#define MAX_LINE_LENGTH 4096
#define MAX_COLUMNS 100
#define NO_FILE_NAME "none"

//NDTable_h TY_Modelica1DTable(
//	char* file_name,
//	int table_col,
//	int break1_col,
//	double* break1,
//	int break1_size,
//	double* table,
//	int table_size);

double abc(double a, double b)
{
	return a * b;
}


NDTable_h ModelicaNDTable_open(const int ndims, const double *data, const int size) {

	int rank, i, numel, dims[32];
	const double *scales[32];
	NDTable_h table = NULL;

	if (size < 2) {
		////ModelicaError("The number of elements in data must be >= 2 123");
		return NULL;
	}

	rank = *data++;

	// check the rank
	if (rank < 0 || rank > 32) {
		////ModelicaError("The first element in data must be in the range [0;32]");
		return NULL;
	}

	if (rank != ndims) {
		//ModelicaFormatError("The first element in data must match the number of inputs. Expected %d but was %d.", ndims, rank);
		return NULL;
	}

	// check the size
	if (size < 1 + rank) {
		////ModelicaError("Data has not enough elements for the given number of dimensions");
		return NULL;
	}

	// check the dimensions
	for (i = 0; i < rank; i++) {
		dims[i] = *data++;

		if (dims[i] < 1) {
			//ModelicaFormatError("The first element in data must match the number of inputs. %d.", dims[i]);
			//ModelicaError("The size of the dimensions must be >= 1");
			return NULL;
		}
	}

	// check the number of elements
	numel = 1;

	for (i = 0; i < rank; i++) {
		numel *= dims[i]; // data
	}

	for (i = 0; i < rank; i++) {
		numel += dims[i]; // scales
	}

	numel += rank; // dims
	numel++; // ndims

	if (size != numel) {
		//ModelicaFormatError("Data has the wrong number of elements for the given dimensions. Expected %d but was %d.", numel, size);
		return NULL;
	}

	for (i = 0; i < rank; i++) {
		scales[i] = data;
		data += dims[i];
	}

	table = NDTable_create_table(ndims, dims, data, scales);

	if (!table) {
		//ModelicaError(NDTable_get_error_message());
	}

	return table;
}

NDTable_h ModelicaNDTable_one(const int ndims, int x_size, double* x, int y_size, double* y)
{
	double vim = 1;
	int vim_size = 1;

	int data_size = 1 + 1 + y_size + x_size;
	double *data = (double*)malloc(data_size * sizeof(double));

	double x_size_double = (double)x_size;
	memcpy(data, &vim, sizeof(double));
	memcpy(data + 1, &x_size_double, sizeof(double));
	memcpy(data + 1 + 1, x, x_size * sizeof(double));
	memcpy(data + 1 + 1 + x_size, y, y_size * sizeof(double));

	NDTable_h result = ModelicaNDTable_open(ndims, data, data_size);
	free(data);
	return result;
}

void ModelicaNDTable_close(NDTable_h externalTable) {

	NDTable_free_table(externalTable);

}

double ModelicaNDTable_evaluate(
	NDTable_h table,
	int nparams,
	const double params[],
	NDTable_InterpMethod_t interp_method,
	NDTable_ExtrapMethod_t extrap_method) {

	double value;

	if (NDTable_evaluate(table, nparams, params, interp_method, extrap_method, &value)) {
		//ModelicaError(NDTable_get_error_message());
	}

	return value;
}

double ModelicaNDTable_evaluate_derivative(
	NDTable_h table,
	int nparams,
	const double params[],
	NDTable_InterpMethod_t interp_method,
	NDTable_ExtrapMethod_t extrap_method,
	const double delta_params[]) {

	double value;

	if (NDTable_evaluate_derivative(table, nparams, params, delta_params, interp_method, extrap_method, &value)) {
		//ModelicaError(NDTable_get_error_message());
	}

	return value;
}

double* GetDataFromCSVFile(char* file_name, int table_col, int* table_row)
{
	FILE* file = fopen(file_name, "r");
	if (!file)
	{
		return NULL;
	}
	char line[MAX_LINE_LENGTH];
	char* token;
	double* column_data = NULL;
	int column_count = 0;
	*table_row = 0;

	// 逐行读取CSV文件
	while (fgets(line, MAX_LINE_LENGTH, file) != NULL)
	{
		column_count = 0;
		token = strtok(line, ",");

		while (token != NULL && column_count < MAX_COLUMNS)
		{
			if (column_count == table_col - 1)
			{
				// 分配内存并将指定列的数据保存到数组中
				if (column_data == NULL)
				{
					column_data = (double*)malloc(sizeof(double));
				}
				else
				{
					column_data = (double*)realloc(column_data, (*table_row + 1) * sizeof(double));
				}

				column_data[*table_row] = atof(token);
				(*table_row)++;
				break;
			}
			column_count++;
			token = strtok(NULL, ",");
		}
	}
	fclose(file);
	return column_data;
}

int sum(int* bp_sizes, int ndims)
{
	int sizesum = 0;
	int i = 0;
	for (i = 0; i < ndims; i++)
	{
		sizesum += bp_sizes[i];
	}

	return sizesum;
}

int prod(int* bp_sizes, int ndims)
{
	int sizeprod = 1;
	int i = 0;
	for (i = 0; i < ndims; i++)
	{
		sizeprod *= bp_sizes[i];
	}

	return sizeprod;
}

NDTable_h TY_ModelicaNDTable(
	char* file_name,
	int table_col,
	int* break_cols,
	int ndims,
	double* breakpoints[],
	int* bp_sizes,
	double* table,
	int table_size)
{
	NDTable_h result = NULL;
	int offset = 0;
	int i = 0;
	//获取数据
	if (table_col > 0 && file_name != NO_FILE_NAME)
	{
		table = GetDataFromCSVFile(file_name, table_col, &table_size);
	}

	for (i = 0; i < ndims; i++)
	{
		if (break_cols[i] > 0 && file_name != NO_FILE_NAME)
		{
			breakpoints[i] = GetDataFromCSVFile(file_name, break_cols[i], &bp_sizes[i]);
		}
	}

	//表格数据维度检查
	if (prod(bp_sizes, ndims) != table_size)
	{
		return NULL;
	}

	//拼接数据
	int data_size = 1 + ndims + sum(bp_sizes, ndims) + table_size;
	double* data = (double*)malloc(data_size * sizeof(double));
	double* first = data;

	data[0] = (double)ndims;
	offset++;
	for (i = 0; i < ndims; i++)
	{
		data[offset] = (double)bp_sizes[i];
		offset++;
	}
	for (i = 0; i < ndims; i++)
	{
		memcpy(data + offset, breakpoints[i], bp_sizes[i] * sizeof(double));
		offset += bp_sizes[i];
	}
	memcpy(data + offset, table, table_size * sizeof(double));

	result = ModelicaNDTable_open(ndims, data, data_size);

	////释放内存
	free(data);

	if (file_name != NO_FILE_NAME)
	{
		if (table_col > 0)
		{
			free(table);
		}

		for (i = 0; i < ndims; i++)
		{
			if (break_cols[i] > 0)
			{
				free(breakpoints[i]);
			}
		}
	}

	return result;
}

NDTable_h TY_Modelica1DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 1;
	double* breakpoints[1] = { break1 };
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica2DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 2;
	double* breakpoints[2] = { break1,break2 };
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica3DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 3;
	double* breakpoints[3] = { break1,break2,break3 };
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica4DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	double* break4,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 4;
	double* breakpoints[4] = { break1,break2,break3,break4 };
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica5DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	double* break4,
	double* break5,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 5;
	double* breakpoints[5] = { break1,break2,break3,break4,break5 };
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica6DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	double* break4,
	double* break5,
	double* break6,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 6;
	double* breakpoints[6] = { break1,break2,break3,break4,break5,break6 };
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

NDTable_h TY_Modelica7DTable(
	char* file_name,
	int table_col,
	int* break_cols,
	double* break1,
	double* break2,
	double* break3,
	double* break4,
	double* break5,
	double* break6,
	double* break7,
	int* bp_sizes,
	double* table,
	int table_size)
{
	int ndims = 7;
	double* breakpoints[7] = { break1,break2,break3,break4,break5,break6,break7 };
	NDTable_h result = NULL;
	result = TY_ModelicaNDTable(file_name, table_col, break_cols, ndims, breakpoints, bp_sizes, table, table_size);

	return result;
}

#endif // MODELICA_NDTABLE_C
