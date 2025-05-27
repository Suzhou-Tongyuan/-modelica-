within Modelica.Electrical.Batteries.ParameterRecords.TransientData;
record StackData "瞬态堆栈(包括退化的参数)"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseStackData(
    redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellDataOriginal, 
    redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellDataDegraded, 
    redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellData);
  extends Modelica.Electrical.Batteries.Icons.TransientStackRecord;
  annotation(defaultComponentPrefixes="parameter");
end StackData;