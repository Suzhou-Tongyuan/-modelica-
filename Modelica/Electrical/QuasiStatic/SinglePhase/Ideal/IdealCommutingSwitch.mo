within Modelica.Electrical.QuasiStatic.SinglePhase.Ideal;
model IdealCommutingSwitch "理想切换开关"
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  parameter SI.Resistance Ron(final min=0) = 1e-5 "闭合状态下的电阻";
  parameter SI.Conductance Goff(final min=0) = 1e-5 "断开状态下的导纳";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  QuasiStatic.SinglePhase.Interfaces.PositivePin p 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin n2 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin n1 annotation (Placement(
        transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{
            90,30},{110,50}})));
  Modelica.Blocks.Interfaces.BooleanInput control "true => p--n2 connected, false => p--n1 connected" 
                                                        annotation (
      Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
protected
  Complex s1(re(final unit="1"), im(final unit="1"));
  Complex s2(re(final unit="1"), im(final unit="1")) "辅助变量";
  constant SI.ComplexVoltage unitVoltage=Complex(1, 0) 
    annotation (HideResult=true);
  constant SI.ComplexCurrent unitCurrent=Complex(1, 0) 
    annotation (HideResult=true);
equation
  Connections.branch(p.reference, n1.reference);
  p.reference.gamma = n1.reference.gamma;
  Connections.branch(p.reference, n2.reference);
  p.reference.gamma = n2.reference.gamma;
  p.i + n2.i + n1.i = Complex(0, 0);
  p.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
  n1.i = -(s1*unitVoltage)*(if (control) then Goff else 1);
  p.v - n2.v = (s2*unitCurrent)*(if (control) then Ron else 1);
  n2.i = -(s2*unitVoltage)*(if (control) then 1 else Goff);
  LossPower = real(p.v*conj(p.i)) + real(n1.v*conj(n1.i)) + real(n2.v*conj(
    n2.i));
  annotation (defaultComponentName="switch", 
    Documentation(info="<html>
<p>
这个换位开关有一个正引脚 p 和两个负引脚 n1 和 n2。
开关行为由输入信号 control 控制。如果 control 为 true，则引脚 p 与负引脚 n2 连接。
否则，引脚 p 与负引脚 n1 连接。
</p>
<p>
为了在换位过程中防止奇点，打开的开关具有（非常低的）导纳 Goff，
闭合的开关具有（非常低的）电阻 Ron。
极限情况也是允许的，即，闭合开关的电阻 Ron 可以恰好为零，断开开关的导纳 Goff 也可以恰好为零。
请注意，有些电路不可能用零 Ron 或零 Goff 来描述。
<br><br>
<strong>请注意：</strong>
如果 useHeatPort=true，则不模拟电气行为的温度依赖性。参数不随温度变化。
</p>
<p>
<strong>谨慎使用：</strong>
此开关仅用于结构更改，不用于快速换位序列，因为其准静态表述。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,255}), 
        Line(points={{-100,0},{-44,0}}, color={85,170,255}), 
        Line(points={{-37,2},{40,40}}, color={85,170,255}), 
        Line(points={{40,40},{100,40}}, color={85,170,255}), 
        Line(points={{40,0},{100,0}}, color={85,170,255}), 
        Line(
          visible=useHeatPort, 
          points={{0,-100},{0,25}}, 
          color={127,0,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end IdealCommutingSwitch;