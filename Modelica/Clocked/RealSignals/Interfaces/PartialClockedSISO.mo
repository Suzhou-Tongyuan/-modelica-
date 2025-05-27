within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialClockedSISO 
  "带时钟单路输入和时钟单路输出实型信号的模块"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.RealInput u 
    "时钟实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation();

end PartialClockedSISO;