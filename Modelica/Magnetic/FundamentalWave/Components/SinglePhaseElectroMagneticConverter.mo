within Modelica.Magnetic.FundamentalWave.Components;
model SinglePhaseElectroMagneticConverter 
  "单相电磁转换器"
  import Modelica.Constants.pi;
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "正极引脚" 
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
  parameter SI.Angle orientation 
    "由此产生的基波 V_m 相位的方向" 
    annotation (Evaluate=true);
  // 本地单相电量
  SI.Voltage v "电压";
  SI.Current i "当前";

  // 局部电磁基波量
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

  final parameter Complex N=effectiveTurns*Modelica.ComplexMath.exp(Complex(
      0, orientation)) "Complex number of turns";
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
  // 绕组的匝数和方向角
  // V_m.re = (2/pi) * effectiveTurns*cos(orientation)*i;
  // V_m.im = (2/pi) * effectiveTurns*sin(orientation)*i;
  V_m = (2.0/pi)*N*i;
  // 感应电压由复数磁通量、匝数确定
  // 和绕组方向角
  // -v = effectiveTurns*cos(orientation)*der(Phi.re)
  //    + effectiveTurns*sin(orientation)*der(Phi.im);
  -v = Modelica.ComplexMath.real(Modelica.ComplexMath.conj(N)*Complex(der(
    Phi.re), der(Phi.im)));
  annotation (
    defaultComponentName="converter", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={           Line(points={{100,-100},{94,-100}, 
          {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
          30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}}, 
          color={255,128,0}),Line(points={{-20,60},{-20,100},{-100,100}}, 
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
              extent={{-150,120},{150,160}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
    Documentation(info="<html>
<p>
单相绕组具有有效匝数<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\">和绕组的各自方向<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation.png\">。绕组中的电流<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i.png\">.
</p>

<p>
单相绕组的总复磁位差由:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/singlephaseconverter_vm.png\">
</p>

<p>
在这个方程中，磁动势与绕组的方向一致.
</p>

<p>
绕组中产生的电压<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v.png\">取决于绕组方向与复磁通量角度之间的余弦值。此外，感应电压的大小与各自的匝数成正比。这种关系可以通过</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/singlephaseconverter_phi.png\">
</p>

<p>而单相电磁变换器是其中的一个特例
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">PolyphaseElectroMagneticConverter</a>
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">PolyphaseElectroMagneticConverter</a>
</p>

</html>"));
end SinglePhaseElectroMagneticConverter;