within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components;
model RotorSaliencyAirGap "带有转子突出的气隙模型"
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
  parameter Integer p "磁极对数";
  parameter Magnetic.FundamentalWave.Types.SalientInductance L0(d(start=1), q(
        start=1)) 
    "单个无弦线圈相对于基波的突出电感量";
  final parameter Magnetic.FundamentalWave.Types.SalientReluctance R_m(d=1/L0.d, 
      q=1/L0.q) "Reluctance of the air gap model";
  // 磁势差的复相位
  SI.ComplexMagneticPotentialDifference V_ms 
    "定子相对于定子固定框架的复磁势差";
  SI.ComplexMagneticPotentialDifference V_msr=V_ms* 
      Modelica.ComplexMath.fromPolar(1, gammar) 
    "定子相对于转子固定框架的复磁势差";
  SI.ComplexMagneticPotentialDifference V_mr 
    "转子与转子固定框架之间的复磁势差";
  SI.ComplexMagneticPotentialDifference V_mrr=V_mr* 
      Modelica.ComplexMath.fromPolar(1, gammar) 
    "转子与转子固定框架之间的复磁势差";
  // 磁通量的复相位
  SI.ComplexMagneticFlux Phi_s 
    "定子固定框架的复磁通量";
  SI.ComplexMagneticFlux Phi_sr=Phi_s* 
      Modelica.ComplexMath.fromPolar(1, gammar) 
    "定子相对于转子固定框架的复磁通量";
  SI.ComplexMagneticFlux Phi_r 
    "转子固定框架的复磁通量";
  SI.ComplexMagneticFlux Phi_rr=Phi_r* 
      Modelica.ComplexMath.fromPolar(1, gammar) 
    "转子固定框架的复磁通量";
  // 电气扭矩和机械角度
  SI.Torque tauElectrical "电气扭矩";
  SI.Angle gamma=p*(flange_a.phi - support.phi) 
    "转子和定子之间的电角度";
  SI.Angle gammas=port_sp.reference.gamma 
    "定子固定框架中的角度电气量";
  SI.Angle gammar=port_rp.reference.gamma 
    "转子固定框架中的角度电气量";
equation
  port_sp.Phi = Phi_s "进入定子正端口的定子磁通";
  port_sp.Phi + port_sn.Phi = Complex(0, 0) "定子磁通平衡";
  port_rp.Phi = Phi_r "进入正转子端口的转子磁通";
  port_rp.Phi + port_rn.Phi = Complex(0, 0) "转子磁通平衡";
  port_sp.V_m - port_sn.V_m = V_ms "定子的磁动力";
  port_rp.V_m - port_rn.V_m = V_mr "转子的磁动力";
  // 定子磁通和转子磁通相等
  Phi_s = Phi_r;
  // 磁动力的局部平衡
  (pi/2.0)*(V_mrr.re + V_msr.re) = Phi_rr.re*R_m.d;
  (pi/2.0)*(V_mrr.im + V_msr.im) = Phi_rr.im*R_m.q;
  // Torque
  tauElectrical = -(pi*p/2.0)*(Phi_s.im*V_ms.re - Phi_s.re*V_ms.im);
  flange_a.tau = -tauElectrical;
  support.tau = tauElectrical;
  // 转子电位根已拆除。只有定子正极
  // 插头是一个潜在的根，因此作为根决定了不是根
  // 电定子根从外部连接;在这种情况下
  // 机器作为发电机运行，转子角度设为零。
  // 磁性定子和转子端口(再次)通过连接
  // 连接。分支，尽管目前尚不清楚这是否
  // 实现是Modelica兼容的
  Connections.potentialRoot(port_sp.reference);
  // Connections.potentialRoot(port_rp.reference);
  Connections.branch(port_sp.reference, port_sn.reference);
  port_sp.reference.gamma = port_sn.reference.gamma;
  Connections.branch(port_rp.reference, port_rn.reference);
  port_rp.reference.gamma = port_rn.reference.gamma;
  Connections.branch(port_sp.reference, port_rp.reference);
  gammas = gammar + gamma;
  if Connections.isRoot(port_sp.reference) then
    gammar = 0;
  end if;
  annotation (defaultComponentName="airGap", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={
        Ellipse(
          extent={{-100,100},{100,-100}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-100,90},{-100,60},{-80,60}}, color={255,170,85}), 
        Line(points={{-100,-90},{-100,-60},{-80,-60}}, color={255,170,85}), 
        Line(points={{40,60},{100,60},{100,90}}, color={255,170,85}), 
        Line(points={{40,-60},{100,-60},{100,-90}}, color={255,170,85}), 
        Ellipse(
          extent={{-60,80},{60,-80}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{0,80},{0,90}})}), 
    Documentation(info="<html>
<p>
这种突出气隙模型既可用于气隙均匀的机器，也可用于转子突出的机器。气隙模型对定子和转子并不对称，因为假定显著性总是指转子。气隙的显著性由 d 轴和 q 轴的主磁场电感表示.
</p>

<p>
对于力学相互作用的气隙模型，设有定子和转子两种
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces. Flange_a\">rotational connectors</a>旋转连接器。作用在两个连接器上的扭矩具有相同的绝对值，但符号不同。定子和转子参考角，
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_s.png\"> 和
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_r.png\">与
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_relationship.png\">
在哪里
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma.png\">
定子和转子之间的电角是多少.
</p>

<p>
气隙模型具有两个磁性定子和两个磁性转子
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.MagneticPort\">ports</a>的端口。定子和转子的磁位差和磁通分别为等复数，但参考角度不同;参见<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide.Concept\">Concept</a>。d轴和q轴相对于转子固定参考系(上标r)的分量由定子(上标s)和转子(上标r)参考量由
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/V_m_transformation.png\">.
</p>

<p>
d 轴和 q 轴磁势差分量和磁通量分量与磁通量的关系为:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap.png\">
</p>

<h4>另外</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">
Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap</a>
</p>

</html>"));
end RotorSaliencyAirGap;