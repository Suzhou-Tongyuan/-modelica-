within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components;
model SymmetricPolyphaseWinding 
  "耦合电场和磁场的对称绕组模型"
  // 方向改变
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug 
    plug_p(final m=m) "正极插头" annotation (Placement(
        transformation(
        origin={-100,100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug 
    plug_n(final m=m) "负极插头" annotation (Placement(
        transformation(
        origin={-100,-100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Interfaces.NegativeMagneticPort port_n "负复合磁端口" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Interfaces.PositiveMagneticPort port_p "正复磁端口" 
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  parameter Integer m=3 "阶段数" annotation(Evaluate=true);
  parameter Boolean useHeatPort=false 
    "启用/禁用（=固定温度）热敏端口" 
    annotation (Evaluate=true);
  // 电阻器型号
  parameter SI.Resistance RRef 
    "TRef 时每相的绕组电阻";
  parameter SI.Temperature TRef(start=293.15) 
    "绕组参考温度";
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20(start=0) "20 摄氏度时的绕组温度系数";
  final parameter SI.LinearTemperatureCoefficient alphaRef= 
      Modelica.Electrical.Machines.Thermal.convertAlpha(
            alpha20, 
            TRef, 
            293.15) "Temperature coefficient of winding at reference temperature";
  parameter SI.Temperature TOperational(start=293.15) 
    "绕组工作温度" 
    annotation (Dialog(enable=not useHeatPort));
  parameter SI.Inductance Lsigma 
    "每相绕组杂散电感";
  parameter Real effectiveTurns=1 "每相有效转数";
  parameter SI.Conductance GcRef 
    "电气基准磁芯损耗磁阻";

  SI.ComplexVoltage v[m]=plug_p.pin.v - plug_n.pin.v 
    "复合电压";
  SI.Voltage abs_v[m]=Modelica.ComplexMath.abs(v) 
    "复合电压的幅度";
  SI.Angle arg_v[m]=Modelica.ComplexMath.arg(v) 
    "复合电压论证";
  SI.ComplexCurrent i[m]=plug_p.pin.i "复杂电流";
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
  Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 
          1:m} "功率因数";

  SI.ComplexMagneticPotentialDifference V_m=port_p.V_m - 
      port_n.V_m "复磁势差";
  SI.MagneticPotentialDifference abs_V_m= 
      Modelica.ComplexMath.abs(V_m) 
    "复合磁势差的大小";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m) 
    "复磁势差论证";
  SI.ComplexMagneticFlux Phi=port_p.Phi 
    "复合磁通量";
  SI.MagneticFlux abs_Phi= 
      Modelica.ComplexMath.abs(Phi) 
    "复合磁通量的大小";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi) 
    "复合磁通论证";

  Magnetic.QuasiStatic.FundamentalWave.Components.PolyphaseElectroMagneticConverter 
    electroMagneticConverter(final m=m, final effectiveTurns=effectiveTurns) 
    "对称绕组" 
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistor(
    final m=m, 
    final useHeatPort=useHeatPort, 
    final T_ref=fill(TRef, m), 
    final T=fill(TOperational, m), 
    R_ref=fill(RRef, m), 
    final alpha_ref=fill(alphaRef, m)) "Winding resistor" annotation (
      Placement(transformation(
        origin={-20,70}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding[m] if 
       useHeatPort "绕组电阻器的散热口" 
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore if 
    useHeatPort "绕组电阻器的散热口" 
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  Magnetic.QuasiStatic.FundamentalWave.Components.EddyCurrent core(final
      useHeatPort=useHeatPort, final G=(m/2)*GcRef*effectiveTurns^2) 
    "磁芯损耗模型（目前仅有涡流）" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={50,-40})));
  Modelica.Magnetic.QuasiStatic.FundamentalWave.Components.Permeance stray(final G_m(
        d=2*Lsigma/m/effectiveTurns^2, q=2*Lsigma/m/effectiveTurns^2)) "Stray permeance equivalent to ideally coupled stray inductances" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={80,30})));
equation
  connect(resistor.heatPort, heatPortWinding) annotation (Line(
      points={{-30,70},{-40,70},{-40,-100}}, color={191,0,0}));
  connect(core.heatPort, heatPortCore) annotation (Line(
      points={{40,-50},{40,-100}}, color={191,0,0}));
  connect(stray.port_n, core.port_n) 
    annotation (Line(points={{80,20},{80,-40},{60,-40}}, color={255,170,85}));
  connect(electroMagneticConverter.plug_p, resistor.plug_n) annotation (
      Line(
      points={{-10,-20},{-20,-20},{-20,60}}, color={85,170,255}));
  connect(plug_n, electroMagneticConverter.plug_n) annotation (Line(
      points={{-100,-100},{-100,-40},{-10,-40}}, color={85,170,255}));
  connect(plug_p, resistor.plug_p) annotation (Line(
      points={{-100,100},{-20,100},{-20,80}}, color={85,170,255}));
  connect(port_p, electroMagneticConverter.port_p) annotation (Line(
      points={{100,100},{10,100},{10,-20}}, color={255,170,85}));
  connect(stray.port_p, port_p) 
    annotation (Line(points={{80,40},{80,100},{100,100}}, color={255,170,85}));
  connect(port_n, core.port_n) annotation (Line(
      points={{100,-100},{100,-40},{60,-40}}, color={255,170,85}));
  connect(electroMagneticConverter.port_n, core.port_p) annotation (Line(
      points={{10,-40},{40,-40}}, color={255,170,85}));
  annotation (defaultComponentName="winding", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={
        Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50, 
              -72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46, 
              66},{62,84},{78,96},{90,100},{100,100}}, color={255,170,85}), 
        Line(points={{40,60},{-100,60},{-100,100}}, color={85,170,255}), 
        Line(points={{40,-60},{-100,-60},{-100,-98}}, color={85,170,255}), 
        Line(points={{40,60},{100,20},{40,-20},{0,-20},{-40,0},{0,20},{40, 
              20},{100,-20},{40,-60}}, color={85,170,255}), 
        Text(
          extent={{150,150},{-150,110}}, 
          textColor={0,0,255}, 
          textString="%name")}), 
    Documentation(info="<html>
<p>
对称多相绕组包括一个对称绕组
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor\">resistor</a>,一个
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components. Reluctance\">stray reluctance</a>，一对称
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components. PolyphaseElectroMagneticConverter\">polyphase electromagnetic coupling</a>和a
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Components. EddyCurrent\">core loss</a>模型包括
heat <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">port</a>。
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components.QuasiStaticAnalogWinding\">
QuasiStaticAnalogWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">
Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding</a>
</p>
</html>"));
end SymmetricPolyphaseWinding;