within Modelica.Electrical.QuasiStatic.SinglePhase.Ideal;
model IdealClosingSwitch "理想电气闭合开关"
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  extends QuasiStatic.SinglePhase.Interfaces.OnePort;
  parameter SI.Resistance Ron(final min=0) = 1e-5 "闭合开关电阻";
  parameter SI.Conductance Goff(final min=0) = 1e-5 "开启开关电导";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  Modelica.Blocks.Interfaces.BooleanInput control "true => p--n 连接，false => 开关开启" 
                                                   annotation (Placement(
        transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
protected
  Complex s(re(final unit="1"), im(final unit="1")) "辅助变量";
  constant SI.ComplexVoltage unitVoltage=Complex(1, 0) 
    annotation (HideResult=true);
  constant SI.ComplexCurrent unitCurrent=Complex(1, 0) 
    annotation (HideResult=true);
equation
  v = (s*unitCurrent)*(if control then Ron else 1);
  i = (s*unitVoltage)*(if control then 1 else Goff);

  LossPower = real(v*conj(i));
  annotation (defaultComponentName="switch", 
    Documentation(info="<html>
<p>
理想闭合开关有一个正极 p 和一个负极 n。
开关行为由输入信号 control 控制。
如果 control 为 true，则将正极 p 连接到负极 n。
否则，正极 p 将不连接到负极 n。
</p>
<p>
为了在开关过程中避免奇点，开启状态的开关具有（非常低的）电导 Goff，
闭合状态的开关具有（非常低的）电阻 Ron。
允许极限情况，即闭合开关的电阻 Ron 可以为零，开启开关的电导 Goff 也可以为零。
请注意，有些电路无法描述为电阻 Ron 或电导 Goff 为零的情况。
<br><br>
<strong>请注意：</strong>
如果 useHeatPort=true，则不会模拟电气行为的温度依赖性。参数不随温度变化。
</p>
<p>
<strong>慎重使用：</strong>
此开关仅用于结构更改，不适用于由于准静态公式而导致的快速开关序列。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,255}), 
        Line(points={{-90,0},{-44,0}}, color={85,170,255}), 
        Line(points={{-37,2},{40,40}}, color={85,170,255}), 
        Line(points={{40,0},{90,0}}, color={85,170,255}), 
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
end IdealClosingSwitch;