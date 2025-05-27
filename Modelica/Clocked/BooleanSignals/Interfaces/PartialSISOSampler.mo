within Modelica.Clocked.BooleanSignals.Interfaces;
partial block PartialSISOSampler 
  "用于布尔信号采样的基本模块"
extends Clocked.BooleanSignals.Interfaces.SamplerIcon;
  Modelica.Blocks.Interfaces.BooleanInput u 
    "连续时间、实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y 
    "时钟、实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation();
end PartialSISOSampler;