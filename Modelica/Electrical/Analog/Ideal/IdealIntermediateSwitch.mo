within Modelica.Electrical.Analog.Ideal;
model IdealIntermediateSwitch "理想的中间开关"
  parameter SI.Resistance Ron(final min=0) = 1e-5 "关闭开关电阻";
  parameter SI.Conductance Goff(final min=0) = 1e-5 
    "打开开关导通";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
        293.15);
  Interfaces.PositivePin p1 annotation (Placement(transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,50}})));
  Interfaces.PositivePin p2 annotation (Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePin n1 annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
  Interfaces.NegativePin n2 annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput control 
    "如果true，p1--n2连接,否则p1--n1, p2--n2连接" 
    annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=270, 
        origin={0,120})));
protected
  Real s1(final unit="1");
  Real s2(final unit="1");
  Real s3(final unit="1");
  Real s4(final unit="1") "辅助变量";
  constant SI.Voltage unitVoltage=1 annotation (HideResult=true);
  constant SI.Current unitCurrent=1 annotation (HideResult=true);
equation
  p1.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
  p2.v - n2.v = (s2*unitCurrent)*(if (control) then 1 else Ron);
  p1.v - n2.v = (s3*unitCurrent)*(if (control) then Ron else 1);
  p2.v - n1.v = (s4*unitCurrent)*(if (control) then Ron else 1);

  p1.i = if control then s1*unitVoltage*Goff + s3*unitCurrent else s1* 
    unitCurrent + s3*unitVoltage*Goff;
  p2.i = if control then s2*unitVoltage*Goff + s4*unitCurrent else s2* 
    unitCurrent + s4*unitVoltage*Goff;
  n1.i = if control then -s1*unitVoltage*Goff - s4*unitCurrent else -s1* 
    unitCurrent - s4*unitVoltage*Goff;
  n2.i = if control then -s2*unitVoltage*Goff - s3*unitCurrent else -s2* 
    unitCurrent - s3*unitVoltage*Goff;

  LossPower = p1.i*p1.v + p2.i*p2.v + n1.i*n1.v + n2.i*n2.v;
  annotation (defaultComponentName="switch", 
    Documentation(info="<html>
<p>中间开关具有四个切换接触引脚p1、p2、n1和n2。切换行为由输入信号控制。如果控制为真，则引脚p1连接到引脚n2，引脚p2连接到引脚 n1。否则，如果控制为假，则引脚p1连接到n1，引脚p2连接到n2。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/IdealIntermediateSwitch1.png\"
     alt=\"IdealIntermediateSwitch1.png\">
</div>

<p>为了在切换时防止奇点，打开的开关具有(非常低)的导纳 Goff，关闭的开关具有(非常低)的电阻Ron。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/IdealIntermediateSwitch2.png\"
     alt=\"IdealIntermediateSwitch2.png\">
</div>

<p>极限情况也是允许的，即关闭的开关的电阻Ron可以完全为零，打开的开关的导纳Goff也可以完全为零。需要注意的是，有些电路中描述为零Ron或零Goff是不可能的。
</p>
<p><strong>请注意：</strong>如果设置useHeatPort为true，那么电气行为的温度依赖性将<strong>不</strong>被模拟。参数不受温度影响。
</p>
</html>", 
        revisions="<html>
<ul>
<li><em>2009年3月11日</em>
       Christoph Clauss<br>添加了条件热口<br>
       </li>
<li><em>1998年</em>
       Christoph Clauss<br>最初实现<br>
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255}),   Ellipse(extent={{-4,24},{4,16}}, lineColor= 
          {0,0,255}),Line(points={{-96,0},{-40,0}}, color={0,0,255}),Line(
          points={{-96,40},{-40,40}}, color={0,0,255}),Line(points={{-40,0},{40,40}}, 
                   color={0,0,255}),Line(points={{-40,40},{40,0}}, color={0,0,255}), 
          Line(points={{40,40},{96,40}}, color={0,0,255}), 
                                           Line(points={{40,0},{96,0}}, color= 
           {0,0,255})}));
end IdealIntermediateSwitch;