#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void getRealArray(char* line, double** data, void* _csv, size_t m, size_t n, size_t row_start, size_t col_start);
void* ED_createCSV(const char* fileName);
void ED_destroyCSV(void* _csv);
void ED_getDoubleArray2DFromCSV(void* _csv, int* field, double* a, size_t m, size_t n);
void ED_getArray2DDimensionsFromCSV(void* _csv, int* m, int* n);
int csv_row = 0, csv_col = 0;

void getRealArray(char* line, double** data, void* _csv, size_t m, size_t n, size_t row_start, size_t col_start)
{
	FILE* stream = (FILE*)_csv;
	int i = 0;
	int col_tmp = 0;
	while (fgets(line, 4096, stream))//逐行读取
	{
		int j = 0;
		char* tok;
#ifdef _WIN32
		char* tmp = _strdup(line);
#else 
		char* tmp = strdup(line);
#endif

		if (i >= row_start)
		{
			for (tok = strtok(line, ","); tok && *tok; j++, tok = strtok(NULL, ",\n"))
			{
				if (j >= col_start && i - row_start < m && j - col_start < n)
				{
					data[i - row_start][j - col_start] = atof(tok);
					
					//printf("%f\n", data[i - row_start][j - col_start]);
				}
				col_tmp++;
			}
		}
		i++;
		csv_row++;
		free(tmp);
		
	}
	csv_col = col_tmp / csv_row;
}

void* ED_createCSV(const char* fileName)
{
	FILE* stream = fopen(fileName, "r");

	return stream;
}

void ED_destroyCSV(void* _csv)
{
	FILE* stream = (FILE*)_csv;
	fclose(stream);
}

void ED_getDoubleArray2DFromCSV(void* _csv, int* field, double* a, size_t m, size_t n)
{
	FILE* stream = (FILE*)_csv;
	char line[4096];
	int row = m, col = n;
	int row_start = field[0] - 1, col_start = field[1] - 1;

	/* 动态申请二维数组 */
	double** data = (double**)malloc(row * sizeof(int*));
	int i = 0;
	for (i = 0; i < row; ++i) {
		data[i] = (double*)malloc(col * sizeof(double));
	}

	/* 读取CSV数据到data数组 */
	getRealArray(line, data, _csv, row, col, row_start, col_start);

	/* data数组的值拷贝至a数组 */
	size_t ii, jj;
	for (ii = 0; ii < m; ii++)
	{
		for (jj = 0; jj < n; jj++)
		{
			*a = data[ii][jj];
			a++;
		}
		printf("\n");
	}
}

void ED_getArray2DDimensionsFromCSV(void* _csv, int* m, int* n)
{

	FILE* stream = (FILE*)_csv;
	char line[4096];
	int row = 0, col = 0;

	if (csv_row == 0 && csv_col == 0)
	{
		while (fgets(line, 4096, stream)) {
			row++;
			if (row == 1)
			{
				char* token = strtok(line, ",");
				while (token) {
					token = strtok(NULL, ",");
					col++;
				}
			}
		}
		*m = row;
		*n = col;
	}
	else
	{
		*m = csv_row;
		*n = csv_col;
	}

}

