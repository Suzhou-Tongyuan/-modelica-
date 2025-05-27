within Modelica.Electrical.Batteries.BatteryStacksWithSensors;
model Stack "带传感器的电池堆栈"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseStackWithSensors(
    redeclare Modelica.Electrical.Batteries.BaseClasses.BaseStackData stackData, 
    redeclare Modelica.Electrical.Batteries.BatteryStacksWithSensors.Cell cell(
      cellData=stackData.cellData, 
      SOC0=SOC0, 
      each SOCtolerance=SOCtolerance, 
      each useHeatPort=useHeatPort, 
      each T=T));
  annotation (Documentation(info="<html>
<p>
这是一个带有测量的<code>Ns</code>x<code>Np</code><a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors.Cell\">cell[Np=1, Ns=1]</a> 电池堆栈，排列成矩阵。
</p>
</html>"));
end Stack;