within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model QuasiStaticAnalogElectroMagneticConverter 
  "电磁变换器只(!)准静态模拟，忽略感应电压"
  // 注:它有无暂态电压感应和
  //   本模型是否考虑漏电感应.
  //   此模型适用于电励磁同步电机(SMEE)。
  import Modelica.Constants.pi;
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "正针" 
    annotation (Placement(transformation(
        origin={-100,100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "负极引脚" 
    annotation (Placement(transformation(
        origin={-100,-100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Interfaces.PositiveMagneticPort port_p "正复磁端口" 
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  Interfaces.NegativeMagneticPort port_n "负复合磁端口" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  parameter Real effectiveTurns "有效转数" 
    annotation (Evaluate=true);
  // 本地单相电量
  SI.Voltage v "压降";
  SI.Current i "电流";

  // 局域电磁基波量
  SI.ComplexMagneticPotentialDifference V_m 
    "复磁势差";
  SI.MagneticPotentialDifference abs_V_m= 
      Modelica.ComplexMath.abs(V_m) 
    "复合磁势差的大小";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m) 
    "复磁势差论证";

  SI.ComplexMagneticFlux Phi "复合磁通量";
  SI.MagneticPotentialDifference abs_Phi= 
      Modelica.ComplexMath.abs(Phi) "复合磁通量的大小";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi) 
    "复合磁通论证";

  SI.Angle gamma "V_m 固定参照系的角度";
  SI.AngularVelocity omega=der(port_p.reference.gamma);
equation
  // 磁端口的磁通量和磁通量平衡
  port_p.Phi = Phi;
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // 磁端口的磁势差
  port_p.V_m - port_n.V_m = V_m;
  // 电气引脚之间的电压降
  v = pin_p.v - pin_n.v;
  // 电针的电流和电流平衡
  i = pin_p.i;
  pin_p.i + pin_n.i = 0;
  // 复磁势差是由电流、数
  // 磁势差的匝数和方向角
  V_m = (2/pi)*effectiveTurns*i*Modelica.ComplexMath.fromPolar(1, -gamma);
  // 由于准静态模拟电路，感应电压为零
  v = 0;
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  // 与磁动势固定框架的参考角
  gamma = port_p.reference.gamma;
  annotation (
    defaultComponentName="converter", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={           Line(points={{100,-100},{94,-100}, 
          {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
          30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}}, 
          color={255,170,85}), 
                             Line(points={{-20,60},{-20,100},{-100,100}}, 
          color={0,0,255}),Line(points={{-20,-60},{-20,-100},{-100,-100}}, 
          color={0,0,255}), 
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-13,45}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-13,-15}, 
          rotation=270), 
        Text(
          extent={{150,150},{-150,110}}, 
          textColor={0,0,255}, 
          textString="%name")}), 
    Documentation(info="<html>
<p>
模拟单相绕组具有有效匝数<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\">和绕组的各自方向<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation.png\">。绕组中的电流<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i.png\">.
</p>

<p>
单相绕组的总复磁位差由:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/singlephaseconverter_vm.png\">
</p>

<p>
在哪里
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma.png\">
分别为电系统和磁系统的参考角。感应电压<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v.png\">等于零.
</p>

<h4>另外</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">
PolyphaseElectroMagneticConverter</a>
</p>

</html>"));
end QuasiStaticAnalogElectroMagneticConverter;