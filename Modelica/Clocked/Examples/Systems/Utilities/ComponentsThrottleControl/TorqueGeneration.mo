within Modelica.Clocked.Examples.Systems.Utilities.ComponentsThrottleControl;
block TorqueGeneration "扭矩生成"
extends Modelica.Blocks.Icons.Block;
  parameter Real AFR = 14.6 
    "空燃比";
  parameter Real sigma = 15.0 
    "点火时刻，BTDC";
  Modelica.Blocks.Interfaces.RealInput m_a(unit="g") 
    "气缸中的充气质量（曲轴旋转180度的延迟）(g)" 
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput N(unit="rad/s") "发动机转速(rad/sec)" 
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_torque_e(unit="N.m") 
    "发动机产生的扭矩" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation();
equation

 T_torque_e = -181.3 + 379.36*m_a + 21.91*AFR - 0.85*AFR^2 + 0.26*sigma 
 - 0.0028*sigma^2 + 0.027*N - 0.000107*N^2 + 0.00048*N*sigma 
 + 2.55*sigma*m_a - 0.05*sigma^2*m_a;
end TorqueGeneration;