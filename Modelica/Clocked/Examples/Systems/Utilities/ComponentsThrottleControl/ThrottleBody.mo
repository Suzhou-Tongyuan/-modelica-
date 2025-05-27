within Modelica.Clocked.Examples.Systems.Utilities.ComponentsThrottleControl;
block ThrottleBody "节流阀体基本方程"
  extends Modelica.Blocks.Icons.Block;

parameter Modelica.Units.NonSI.Pressure_bar P_0 = 1 "大气压力（bar）";
protected
  Real m_ai(start=0, fixed=true, unit="g") "质量";
  Modelica.Units.NonSI.Angle_deg f_Theta "辅助变量";
  Real g_Pm "辅助变量";
public
  Modelica.Blocks.Interfaces.RealInput Theta(unit="deg") "节流阀角度（deg）" 
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Pm(unit="bar") 
    "进气歧管压力（bar）" 
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput m_ai_der(unit="g/s") 
    "进入歧管的空气质量流量（g/s）" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

protected
  Real tmp1;
  Real tmp2;
  Real pratio;
  Real gpratio;
  annotation();
equation

der(m_ai) = f_Theta * g_Pm;
f_Theta = 2.821 - 0.05231*Theta + 0.10299*Theta^2 - 0.00063*Theta^3; // different to paper 0.0063*Theta^3
// 注：如果流量方向发生变化，即 Pm>P_0 逻辑将失败，因为 sqrt(-x)
tmp1 = Pm / P_0;
tmp2 = P_0 / Pm;
pratio = min(tmp1, tmp2);
gpratio = if pratio >= 0.5 then 2*sqrt(pratio - pratio^2) else 1;
g_Pm = sign(P_0 - Pm) * gpratio;
/*
g_Pm = if Pm <= P_0/2 then 1.0 else 2/P_0*sqrt(Pm*P_0 - Pm^2);
*/
m_ai_der = der(m_ai);
end ThrottleBody;