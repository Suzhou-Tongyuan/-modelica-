within Modelica.Electrical.QuasiStatic.SinglePhase.Ideal;
model IdealOpeningSwitch "理想电气开关"
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  extends QuasiStatic.SinglePhase.Interfaces.OnePort;
  parameter SI.Resistance Ron(final min=0) = 1e-5 "闭合开关电阻";
  parameter SI.Conductance Goff(final min=0) = 1e-5 "断开开关导纳";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  Modelica.Blocks.Interfaces.BooleanInput control "true => 开关断开, false => p--n 连接" 
                                                   annotation (Placement(
        transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
protected
  Complex s(re(final unit="1"),im(final unit="1")) "辅助变量";
  constant SI.ComplexVoltage unitVoltage=Complex(1, 0) 
    annotation (HideResult=true);
  constant SI.ComplexCurrent unitCurrent=Complex(1, 0) 
    annotation (HideResult=true);
equation
  v = (s*unitCurrent)*(if control then 1 else Ron);
  i = (s*unitVoltage)*(if control then Goff else 1);

  LossPower = real(v*conj(i));
  annotation (defaultComponentName="switch", 
    Documentation(info="<html>
<p>
理想断开开关有一个正极 p 和一个负极 n。
开关行为由输入信号 control 控制。
如果 control 为 true，则针脚 p 未连接
负极 n。否则，针脚 p 连接
负极 n。
</p>
<p>
为了在开关过程中避免奇异性，打开的
开关具有（非常低的）导纳 Goff
和闭合的开关具有（非常低的）电阻 Ron。
也允许极限情况，即，闭合开关的电阻 Ron
可以完全为零，打开开关的导纳 Goff
也可以完全为零。请注意，有些电路，
描述为零 Ron 或零 Goff 是不可能的。
<br><br>
<strong>请注意：</strong>
如果 useHeatPort=true，则不建模电气行为的温度依赖性。
参数不随温度变化。
</p>
<p>
<strong>小心使用：</strong>
此开关仅用于结构更改，不适用于快速开关序列，由于准静态公式的形式。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,255}), 
        Line(points={{-100,0},{-44,0}}, color={85,170,255}), 
        Line(points={{-37,2},{40,40}}, color={85,170,255}), 
        Line(points={{40,0},{100,0}}, color={85,170,255}), 
        Line(points={{40,20},{40,0}}, color={85,170,255}), 
        Line(
          visible=useHeatPort, 
          points={{0,-100},{0,25}}, 
          color={127,0,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Text(
          extent={{-100,-40},{100,-79}}, 
          textString="%name", 
          textColor={0,0,255})}));
end IdealOpeningSwitch;