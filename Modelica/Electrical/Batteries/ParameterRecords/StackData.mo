within Modelica.Electrical.Batteries.ParameterRecords;
record StackData "电池堆栈参数(包括衰减的参数)"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseStackData(
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellDataOriginal, 
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellDataDegraded, 
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellData);
  annotation(defaultComponentPrefixes="parameter");
end StackData;