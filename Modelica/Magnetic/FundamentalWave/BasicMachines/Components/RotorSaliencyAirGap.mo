within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model RotorSaliencyAirGap "带有转子显著性的气隙模型"
  import Modelica.Constants.pi;
  Interfaces.PositiveMagneticPort port_sp 
    "正复磁定子端口" annotation (Placement(
        transformation(extent={{-110,-110},{-90,-90}})));
  Interfaces.NegativeMagneticPort port_sn 
    "负复式磁性定子端口" annotation (Placement(
        transformation(extent={{-110,90},{-90,110}})));
  Interfaces.PositiveMagneticPort port_rp 
    "正复磁转子端口" annotation (Placement(
        transformation(extent={{90,90},{110,110}})));
  Interfaces.NegativeMagneticPort port_rn 
    "负复磁转子端口" annotation (Placement(
        transformation(extent={{90,-110},{110,-90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
    "转子法兰" annotation (Placement(transformation(extent={{-10, 
            110},{10,90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support 
    "反作用扭矩作用的支撑点" annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}})));
  parameter Integer p "极对数";
  parameter Magnetic.FundamentalWave.Types.SalientInductance L0(d(start=1), q(
        start=1)) 
    "单个无弦线圈相对于基波的突出电感量";
  final parameter Magnetic.FundamentalWave.Types.SalientReluctance R_m(d=1/L0.d, 
      q=1/L0.q) "Reluctance of the air gap model";
  // 磁势差的复相位
  SI.ComplexMagneticPotentialDifference V_mss 
    "定子相对于定子固定框架的复磁势差";
  SI.ComplexMagneticPotentialDifference V_msr 
    "定子相对于转子固定框架的复磁势差";
  SI.ComplexMagneticPotentialDifference V_mrr 
    "转子与转子固定框架之间的复磁势差";
  // 磁通量的复相位
  SI.ComplexMagneticFlux Phi_ss 
    "定子固定框架的复磁通量";
  SI.ComplexMagneticFlux Phi_sr 
    "定子相对于转子固定框架的复磁通量";
  SI.ComplexMagneticFlux Phi_rr 
    "转子固定框架的复磁通量";
  // 电气扭矩和机械角度
  SI.Torque tauElectrical "电气扭矩";
  SI.Angle gamma 
    "转子和定子之间的电角度";
  Complex rotator "方向的等效矢量表示法";
equation
  port_sp.Phi = Phi_ss "进入定子正端口的定子磁通";
  port_sp.Phi + port_sn.Phi = Complex(0, 0) "定子磁通平衡";
  port_rp.Phi = Phi_rr "进入正转子端口的转子磁通";
  port_rp.Phi + port_rn.Phi = Complex(0, 0) "转子磁通平衡";
  port_sp.V_m - port_sn.V_m = V_mss "定子的磁动力";
  port_rp.V_m - port_rn.V_m = V_mrr "转子的磁动力";
  // 定子和转子固定框架之间的变换
  V_msr = V_mss*Modelica.ComplexMath.conj(rotator);
  Phi_sr = Phi_ss*Modelica.ComplexMath.conj(rotator);
  // 定子磁通和转子磁通相等
  Phi_sr = Phi_rr;
  // 磁动力的局部平衡
  (pi/2.0)*(V_mrr.re + V_msr.re) = Phi_rr.re*R_m.d;
  (pi/2.0)*(V_mrr.im + V_msr.im) = Phi_rr.im*R_m.q;
  // 扭矩
  tauElectrical = -(pi*p/2.0)*(Phi_ss.im*V_mss.re - Phi_ss.re*V_mss.im);
  flange_a.tau = -tauElectrical;
  support.tau = tauElectrical;
  // 定子和转子之间的电角度
  gamma = p*(flange_a.phi - support.phi);
  rotator = Modelica.ComplexMath.exp(Complex(0, gamma));
  annotation (defaultComponentName="airGap", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-100,90},{-100,60},{-80,60}}, color={255,128,0}), 
        Line(points={{-100,-90},{-100,-60},{-80,-60}}, color={255,128,0}), 
        Line(points={{40,60},{100,60},{100,90}}, color={255,128,0}), 
        Line(points={{40,-60},{100,-60},{100,-90}}, color={255,128,0}), 
        Ellipse(
          extent={{-60,80},{60,-80}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{0,80},{0,90}})}), Documentation(info="<html>
<p>
这种突出气隙模型既可用于气隙均匀的机器，也可用于转子突出的机器。气隙模型对定子和转子并不对称，因为假定显著性总是指转子。气隙的显著性由 d 轴和 q 轴的主磁场电感表示.
</p>

<p>
气隙模型与定子和转子之间的机械相互作用配备了两个
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_a\">rotational connectors</a>. 作用在两个连接器上的扭矩绝对值相同，但符号不同。定子和转子角度之差,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/gamma.png\">, 需要将定子磁性量转换到转子侧.</p>

<p>
气隙模型有两个磁性定子和两个磁性转子
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">ports</a>. 定子（上标 s）的磁势差和磁通量被转换到转子固定参考框架（上标 r）。然后在平衡方程中考虑主磁场相对于 d 轴和 q 轴的有效磁阻
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap.png\">
</p>

<p>
如下图所示.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig:</strong> 气隙模型的磁等效电路</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap_phasors.png\">
    </td>
  </tr>
</table>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">SymmetricPolyphaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">SymmetricPolyphaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>
</p>

</html>"));
end RotorSaliencyAirGap;