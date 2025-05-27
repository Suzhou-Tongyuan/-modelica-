within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model ElectroMagneticConverter "电磁能量转换"

  constant Complex j=Complex(0, 1);
  FluxTubes.Interfaces.PositiveMagneticPort port_p "正磁端口" annotation (Placement(transformation(extent={{90,90},{110,110}}), iconTransformation(extent={{90,90},{110,110}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "负磁端口" annotation (Placement(transformation(extent={{110,-110},{90,-90}}), iconTransformation(extent={{110,-110},{90,-90}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin pin_p 
  "正极电针" annotation (Placement(transformation(extent={{-90,90},{-110,110}}), iconTransformation(extent={{-90,90},{-110,110}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin pin_n 
  "负极电针"   annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,-110},{-90,-90}})));
  SI.ComplexVoltage v "电压";
  SI.ComplexCurrent i(re(start=0, stateSelect=StateSelect.prefer), 
                                    im(start=0, stateSelect=StateSelect.prefer)) 
  "电流";
  SI.ComplexMagneticPotentialDifference V_m 
  "磁电势差";
  SI.ComplexMagneticFlux Phi 
  "耦合到磁路中的磁通量";
  SI.AngularVelocity omega;

  parameter Real N=1 "转数";

  //仅供参考:
  SI.ComplexMagneticFlux Psi 
  "通量连接，仅供参考";
  SI.Inductance L_stat "静态电感 abs(Psi/i) 仅供参考";

protected
  Real eps=100*Modelica.Constants.eps;
equation
  v = pin_p.v - pin_n.v;
  Complex(0) = pin_p.i + pin_n.i;
  i = pin_p.i;

  V_m = port_p.V_m - port_n.V_m;
  Complex(0) = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  // 来自复合磁通的感应电压，匝数
  // 和绕组方向角
  v = -j*omega*N*Phi;
  // 安培定律
  V_m = N*i;
  // 仅供参考:
  Psi = N*Phi;
  // 使用 abs 可获得正面结果；这是由于 Modelica 对流入连接器的符号约定所致:
  L_stat = noEvent(if Modelica.ComplexMath.abs(i) > eps then Modelica.ComplexMath.abs(Psi/i) else Modelica.ComplexMath.abs(Psi/eps));

  omega = der(port_p.reference.gamma);

  // 不使用势根，而是处理参考角
  // 通过电气引脚_p 和磁性端口_p 之间的连接支路
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  Connections.branch(pin_p.reference, pin_n.reference);
  pin_p.reference.gamma = pin_n.reference.gamma;
  Connections.branch(port_p.reference, pin_p.reference);
  port_p.reference.gamma = pin_p.reference.gamma;
  annotation (
    defaultComponentName="converter", 
    Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{-30,100},{-30,60}},color={85,170,255}), 
      Line(points={{-30,-60},{-30,-100}},color={85,170,255}), 
      Line(points={{-30,100},{-90,100}}, 
                                       color={85,170,255}), 
      Line(points={{-30,-100},{-88,-100}}, 
                                         color={85,170,255}), 
      Ellipse(extent={{-4,-34},{64,34}}, lineColor={255,170,85}), 
      Line(points={{30,-100},{30,0}},  color={255,170,85}), 
      Line(points={{30,0},{30,100}}, color={255,170,85}), 
      Line(points={{30,100},{90,100}},color={255,170,85}), 
      Line(points={{30,-100},{90,-100}}, 
                                       color={255,170,85}), 
      Text(
        extent={{-150,150},{150,110}}, 
        textString="%name", 
          pattern=LinePattern.None, 
          textColor={0,0,255}), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier, 
          origin={-23,45}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier, 
          origin={-23,15}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier, 
          origin={-23,-15}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier, 
          origin={-23,-45}, 
          rotation=270)}), 
    Documentation(info="<html>
<p>
电磁能量转换分别由<em>安培</em>定律和<em>法拉第</em>定律给出:
</p>

<pre>
    V<sub>m</sub> = N * i
    N * d&Phi;/dt = -v
</pre>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Basic/converter_signs.png\" alt=\"converter signs\">
</div>

<p>
V<sub>m</sub>是由于通过线圈的电流i(安培定律)而施加到磁路上的磁电位差。
在电流i(手指)和磁位差V<sub>m</sub>(拇指)之间存在一个左赋值。<br>
<strong>注意:</strong>在通过线圈i(手指)的电流和磁动势mmf之间存在右赋值。
mmf与V<sub>m</sub>方向相反。Modelica中没有使用它.
</p>

<p>
对于整个磁路，在参考方向上以正确符号计数的所有磁位差之和等于零:sum(V<sub>m</sub>) = 0。<br>
磁通量&Phi;与磁电位差V<sub>m</sub>按等效欧姆定律有关:V<sub>m</sub> = R<sub>m</sub> * &Phi;<br>
<strong>注:</strong>磁阻R<sub>m</sub>取决于几何形状和材料性能。对于铁磁材料，由于饱和，R<sub>m</sub>不是恒定的.
</p>

<p>
因此符号(实际方向)&;(通过变换器的磁通量)取决于磁路的相关支路。<br>
v是线圈中感应电压，这是由磁通量&Phi的导数引起的;(法拉第定律)。< br >
<strong>注:</strong>感应电压v的负号是由<em>Lenz</em>定律引起的.
</p>

<p>
<strong>注释:</strong> 图像显示一个右旋线圈。
如果必须建模左手线圈而不是右手线圈，则参数N(匝数)可以设置为负值.
</p>

<p>
磁链&Psi;和静态电感L_stat = |&Psi;/i|仅供参考。注意，L_stat被设置为|&Psi;/eps| if |i| &lt;每股收益
(= 100 * Modelica.Constants.eps).
</p>
</html>"));
end ElectroMagneticConverter;