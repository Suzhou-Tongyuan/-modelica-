within Modelica.Electrical.Batteries.BatteryStacksWithSensors;
model Cell "带测量的电池单体"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseCellWithSensors(
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellData, 
    redeclare Modelica.Electrical.Batteries.BatteryStacks.CellStack cell(
      cellData=cellData, 
      SOC(start=SOC0, fixed=true), 
      SOCtolerance=SOCtolerance, 
      useHeatPort=true, 
      T=T));
 annotation (Documentation(info="<html>
<p>
这是一个带有测量的单个<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellStack\">电池单体[Np=1, Ns=1]</a>。
</p>
</html>"));
end Cell;