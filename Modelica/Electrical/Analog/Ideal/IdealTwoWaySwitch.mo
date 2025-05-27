within Modelica.Electrical.Analog.Ideal;
model IdealTwoWaySwitch "理想双向开关"
    parameter SI.Resistance Ron(final min=0) = 1e-5 "闭合开关电阻";
  parameter SI.Conductance Goff(final min=0) = 1e-5 
    "断开开关导纳";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
        293.15);
  Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110, 
            -10},{-90,10}})));
  Interfaces.NegativePin n2 annotation (Placement(transformation(extent={{90, 
            -10},{110,10}})));
  Interfaces.NegativePin n1 annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.BooleanInput control 
    "true=>p--n2连接，false=>p--n1连接" annotation (Placement(
        transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
protected
  Real s1(final unit="1");
  Real s2(final unit="1") "辅助变量";
  constant SI.Voltage unitVoltage=1 annotation (HideResult=true);
  constant SI.Current unitCurrent=1 annotation (HideResult=true);
equation
  0 = p.i + n2.i + n1.i;

  p.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
  n1.i = -(s1*unitVoltage)*(if (control) then Goff else 1);
  p.v - n2.v = (s2*unitCurrent)*(if (control) then Ron else 1);
  n2.i = -(s2*unitVoltage)*(if (control) then 1 else Goff);
  LossPower = p.i*p.v + n1.i*n1.v + n2.i*n2.v;
  annotation (defaultComponentName="switch", 
    Documentation(info="<html>
<p>
双路开关有一个正引脚p和两个负引脚n1和n2。
开关行为由输入信号control控制。
如果control为true，则引脚p连接到负引脚n2。否则，引脚p连接到负引脚n1。
</p>
<p>
为了在开关过程中防止奇异性，打开的开关具有(非常低的)导纳Goff，
闭合的开关具有(非常低的)电阻Ron。
极限情况也是允许的，即闭合开关的电阻Ron可以完全为零，
打开开关的导纳Goff也可以完全为零。注意，有些电路无法用零Ron或零Goff进行描述。
<br><br>
<strong>请注意：</strong>
如果useHeatPort=true，则不建模电气行为的温度依赖性。
参数不依赖于温度。
</p>
</html>", 
        revisions="<html>
<ul>
<li><em>2009年3月11日</em>
       由Christoph Clauss添加了条件热端口<br>
       </li>
<li><em>1998年</em>
       由Christoph Clauss最初实现<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}), 
        Line(points={{-90,0},{-44,0}}, color={0,0,255}), 
        Line(points={{-37,2},{40,40}}, color={0,0,255}), 
        Line(points={{40,40},{90,40}}, color={0,0,255}), 
        Line(points={{40,0},{90,0}}, color={0,0,255}), 
        Line(
          visible=useHeatPort, 
          points={{0,-100},{0,25}}, 
          color={127,0,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end IdealTwoWaySwitch;