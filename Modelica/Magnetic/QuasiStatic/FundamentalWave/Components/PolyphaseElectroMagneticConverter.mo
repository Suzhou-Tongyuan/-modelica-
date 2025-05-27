within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model PolyphaseElectroMagneticConverter 
  "多相电磁转换器"
  import Modelica.Constants.pi;
  constant Complex j=Complex(0, 1);
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug 
    plug_p(final m=m) "正极插头" annotation (Placement(transformation(
        origin={-100,100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug 
    plug_n(final m=m) "负极插头" annotation (Placement(transformation(
        origin={-100,-100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  FundamentalWave.Interfaces.PositiveMagneticPort port_p 
    "正复磁端口" annotation (Placement(transformation(
          extent={{90,90},{110,110}})));
  FundamentalWave.Interfaces.NegativeMagneticPort port_n 
    "负复合磁端口" annotation (Placement(transformation(
          extent={{90,-110},{110,-90}})));
  parameter Integer m=3 "阶段数" annotation(Evaluate=true);
  parameter Real effectiveTurns "有效转数";
  constant SI.Angle orientation=0 
    "第一绕组轴的方向";
  // 局部电多相量
  SI.ComplexVoltage v[m] "复合电压";
  SI.Voltage abs_v[m]=Modelica.ComplexMath.abs(v) 
    "复合电压的幅度";
  SI.Angle arg_v[m]=Modelica.ComplexMath.arg(v) 
    "复合电压论证";

  SI.ComplexCurrent i[m] "复杂电流";
  SI.Current abs_i[m]=Modelica.ComplexMath.abs(i) 
    "复合电流强度";
  SI.Angle arg_i[m]=Modelica.ComplexMath.arg(i) 
    "复合电流参数";

  SI.ActivePower P[m]={Modelica.ComplexMath.real(v[k]* 
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Active power";
  SI.ActivePower P_total=sum(P) "总有功功率";
  SI.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]* 
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Reactive power";
  SI.ReactivePower Q_total=sum(Q) "总无功功率";
  SI.ApparentPower S[m]={Modelica.ComplexMath.abs(v[k]* 
      Modelica.ComplexMath.conj(i[k])) for k in 1:m} 
    "复合视在功率的大小";
  SI.ApparentPower S_total=sqrt(P_total^2 + Q_total^2) 
    "总复合视在功率的大小";
  Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 1:m} 
    "功率因数";

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

  SI.AngularVelocity omega=der(port_p.reference.gamma);
  // 使用旋转器的技术解决方案无法应用于下面的方程式
  final parameter Complex N=effectiveTurns*Modelica.ComplexMath.exp(Complex(
      0, orientation)) "Complex effective number of turns";
  SI.ComplexVoltage vSymmetricalComponent[m] 
    "电压的对称分量";
  SI.ComplexCurrent iSymmetricalComponent[m] 
    "电流的对称分量";
protected
  final parameter Complex sTM[m,m]= 
    Modelica.Electrical.Polyphase.Functions.symmetricTransformationMatrix(m);
  final parameter Integer indexNonPos[:]= 
      Modelica.Electrical.Polyphase.Functions.indexNonPositiveSequence(
                                                              m) 
    "所有非正序列成分的指数";
  final parameter Integer indexPos[:]= 
      Modelica.Electrical.Polyphase.Functions.indexPositiveSequence(
                                                           m) 
    "所有正序列成分的指数";
equation
  // 对称组件（首选）: vSymmetricalComponent = sTM*v; iSymmetricalComponent = sTM*i;
  for j in 1:m loop
    vSymmetricalComponent[j] = Complex(sum({sTM[j,k].re*v[k].re - sTM[j,k].im*v[k].im for k in 1:m}), 
                                       sum({sTM[j,k].re*v[k].im + sTM[j,k].im*v[k].re for k in 1:m}));
    iSymmetricalComponent[j] = Complex(sum({sTM[j,k].re*i[k].re - sTM[j,k].im*i[k].im for k in 1:m}), 
                                       sum({sTM[j,k].re*i[k].im + sTM[j,k].im*i[k].re for k in 1:m}));
  end for;
  // 磁端口的磁通量和磁通量平衡
  port_p.Phi = Phi;
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // 磁端口的磁势差
  port_p.V_m - port_n.V_m = V_m;
  // 电气插头之间的电压降
  v = plug_p.pin.v - plug_n.pin.v;
  // 电插头的电流和电流平衡
  i = plug_p.pin.i;
  plug_p.pin.i + plug_n.pin.i = {Complex(0, 0) for k in 1:m};
  V_m.re = sqrt(2)*(2.0/pi)*Modelica.ComplexMath.real(N* 
    iSymmetricalComponent[1])*m/2;
  V_m.im = sqrt(2)*(2.0/pi)*Modelica.ComplexMath.imag(N* 
    iSymmetricalComponent[1])*m/2;
  for k in 1:size(indexNonPos, 1) loop
    iSymmetricalComponent[indexNonPos[k]] = Complex(0, 0);
  end for;
  for k in 2:size(indexPos, 1) loop
    vSymmetricalComponent[indexPos[1]] = vSymmetricalComponent[indexPos[k]];
  end for;
  // 来自复合磁通的感应电压，匝数
  // 和绕组方向角
  -sqrt(2)*Complex(Modelica.ComplexMath.real(vSymmetricalComponent[indexPos[
    1]]), Modelica.ComplexMath.imag(vSymmetricalComponent[indexPos[1]])) = 
    Modelica.ComplexMath.conj(N)*j*omega*Phi;
  // 不使用势根，而是处理参考角
  // 通过电插头_p 和磁端口_p 之间的连接支路
  // 必须检查是否符合 Modelica
  //   Connections.potentialRoot(plug_p.reference);
  //   Connections.potentialRoot(port_p.reference);
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  Connections.branch(plug_p.reference, plug_n.reference);
  plug_p.reference.gamma = plug_n.reference.gamma;
  Connections.branch(plug_p.reference, port_p.reference);
  plug_p.reference.gamma = port_p.reference.gamma;
  annotation (defaultComponentName="converter", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={    Line(points={{100,-100},{94,-100}, 
          {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
          30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}}, 
          color={255,170,85}),Line(points={{-20,60},{-20,100},{-100,100}}, 
          color={85,170,255}),Line(points={{-20,-60},{-20,-100},{-100,-100}}, 
          color={85,170,255}), 
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier, 
          origin={-13,45}, 
          rotation=270), 
        Line(
          points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}}, 
          color={85,170,255}, 
          smooth=Smooth.Bezier, 
          origin={-13,-15}, 
          rotation=270), 
        Text(
          extent={{150,150},{-150,110}}, 
          textColor={0,0,255}, 
          textString="%name")}),     Documentation(info="<html>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k.png\">的每个相位<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\">绕组具有有效匝数，<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns_k.png\">和各自的翅膀角度<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation_k.png\">和相电流<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\">.
</p>

<p>
多相绕组的总复磁势差由以下公式确定:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/polyphaseconverter_vm.png\">
</p>

<p>
在这个方程中
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/i_sc1.png\">
是电流的正对称分量吗.
</p>

<p>
电压的正序
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/v_sc1.png\">
每个绕组的感应电流与复磁通量和匝数成正比。这种关系可以通过</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Components/polyphaseconverter_phi.png\">.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">
Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.QuasiStaticAnalogElectroMagneticConverter\">
QuasiStaticAnalogElectroMagneticConverter</a>
</p>
</html>"));
end PolyphaseElectroMagneticConverter;