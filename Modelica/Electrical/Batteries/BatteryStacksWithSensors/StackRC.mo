within Modelica.Electrical.Batteries.BatteryStacksWithSensors;
model StackRC "带传感器的电池堆栈"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseStackWithSensors(
      redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.StackData stackData, 
      redeclare Modelica.Electrical.Batteries.BatteryStacksWithSensors.CellRC cell(
        cellData=stackData.cellData, 
        SOC0=SOC0, 
        each SOCtolerance=SOCtolerance, 
        each useHeatPort=useHeatPort, 
        each T=T));
  extends Modelica.Electrical.Batteries.Icons.TransientModel;
  annotation (Documentation(info="<html>
<p>
这是一个<code>Ns</code> x <code>Np</code>的瞬态<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors.CellRC\">cellRC[Np=1, Ns=1]</a>(带有RC元素)带测量的堆栈，排列成矩阵。
</p>
</html>"));
end StackRC;