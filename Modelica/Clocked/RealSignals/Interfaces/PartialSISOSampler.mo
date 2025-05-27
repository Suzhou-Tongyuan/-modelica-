within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialSISOSampler 
  "用于实数信号采样的基本模块"
extends Clocked.RealSignals.Interfaces.SamplerIcon;
  Modelica.Blocks.Interfaces.RealInput u 
    "连续时间、实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation();
equation

end PartialSISOSampler;