within Modelica.Clocked.BooleanSignals.Interfaces;
partial block PartialClockedSISO 
  "带时钟单输入和时钟单输出布尔信号的模块"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.BooleanInput u 
    "时钟、实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y 
    "时钟、实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation();

end PartialClockedSISO;