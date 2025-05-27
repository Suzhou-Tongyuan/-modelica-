within Modelica.Electrical.QuasiStatic.SinglePhase.Ideal;
model IdealIntermediateSwitch "理想中间开关"
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  parameter SI.Resistance Ron(final min=0) = 1e-5 "闭合开关电阻";
  parameter SI.Conductance Goff(final min=0) = 1e-5 "打开开关导纳";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  QuasiStatic.SinglePhase.Interfaces.PositivePin p1 annotation (Placement(
        transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent= 
            {{-110,30},{-90,50}})));
  QuasiStatic.SinglePhase.Interfaces.PositivePin p2 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin n1 annotation (Placement(
        transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{
            90,30},{110,50}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin n2 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput control "true => p1--n2, p2--n1 连接，否则 p1--n1, p2--n2 连接" 
    annotation (Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
protected
  Complex s1(re(final unit="1"), im(final unit="1"));
  Complex s2(re(final unit="1"), im(final unit="1"));
  Complex s3(re(final unit="1"), im(final unit="1"));
  Complex s4(re(final unit="1"), im(final unit="1")) "辅助变量";
  constant SI.ComplexVoltage unitVoltage=Complex(1, 0) 
    annotation (HideResult=true);
  constant SI.ComplexCurrent unitCurrent=Complex(1, 0) 
    annotation (HideResult=true);
equation
  Connections.branch(p1.reference, n1.reference);
  p1.reference.gamma = n1.reference.gamma;
  Connections.branch(p2.reference, n2.reference);
  p2.reference.gamma = n2.reference.gamma;
  Connections.branch(n1.reference, n2.reference);
  n1.reference.gamma = n2.reference.gamma;

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

  LossPower = real(p1.v*conj(p1.i)) + real(p2.v*conj(p2.i)) + real(n1.v* 
    conj(n1.i)) + real(n2.v*conj(n2.i));
  annotation (defaultComponentName="switch", 
    Documentation(info="<html>
<p>
中间开关具有四个切换接点 p1、p2、n1 和 n2。
切换行为由输入信号 control 控制。如果 control 为 true，则引脚 p1 连接到引脚 n2，并且引脚 p2 连接到引脚 n2。否则，引脚 p1 连接到 n1，引脚 p2 连接到 n2。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Ideal/IdealIntermediateSwitch1.png\" alt=\"IdealIntermediateSwitch1\">
</div>

<p>
为了在切换过程中防止奇点出现，打开的开关具有（非常低的）导纳 Goff，而闭合的开关具有（非常低的）电阻 Ron。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Ideal/IdealIntermediateSwitch2.png\" alt=\"IdealIntermediateSwitch2\">
</div>

<p>
也允许极限情况，即闭合开关的电阻 Ron 可以完全为零，打开开关的导纳 Goff 也可以完全为零。请注意，有些电路无法用零 Ron 或零 Goff 来描述。
<br><br>
<strong>请注意：</strong>
如果 useHeatPort=true，则不会对电气行为进行温度相关的建模。参数不受温度影响。
</p>
<p>
<strong>谨慎使用：</strong>
由于准静态的制定方式，此开关仅用于结构更改，而不适用于快速切换序列。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(extent={{-4,24},{4,16}}, lineColor={85,170,255}), 
        Line(points={{-90,0},{-40,0}}, color={85,170,255}), 
        Line(points={{-90,40},{-40,40}}, color={85,170,255}), 
        Line(points={{-40,0},{40,40}}, color={85,170,255}), 
        Line(points={{-40,40},{40,2}}, color={85,170,255}), 
        Line(points={{40,40},{90,40}}, color={85,170,255}), 
        Line(points={{40,0},{90,0}}, color={85,170,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end IdealIntermediateSwitch;