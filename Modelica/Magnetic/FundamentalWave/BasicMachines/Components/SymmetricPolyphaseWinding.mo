within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model SymmetricPolyphaseWinding 
  "耦合电场和磁场的对称绕组模型"
  // 方向改变
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m) 
    "正极插头" annotation (Placement(transformation(
        origin={-100,100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m) 
    "负极插头" annotation (Placement(transformation(
        origin={-100,-100}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
  Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port_n 
    "负复合磁端口" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port_p 
    "正复磁端口" 
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
  parameter SI.Inductance Lzero 
    "绕组的零序电感";
  parameter Real effectiveTurns=1 "每相有效转数";
  parameter SI.Conductance GcRef 
    "电气基准磁芯损耗磁阻";
  final parameter Integer nBase=Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m) 
    "基地系统数量";
  final parameter Integer mBase=integer(m/nBase) 
    "基础系统的阶段数";

  SI.Voltage v[m]=plug_p.pin.v - plug_n.pin.v "电压";
  SI.Current i[m]=plug_p.pin.i "电流";

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

  Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter electroMagneticConverter(
    final m=m, 
    final effectiveTurns=fill(effectiveTurns, m), 
    final orientation= 
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m)) 
    "对称绕组" 
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Electrical.Polyphase.Basic.ZeroInductor zeroInductor(final m=m, final Lzero=Lzero) if 
       mBase<>2 "绕组的零序电感" 
    annotation (Placement(transformation(
        origin={-30,30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Ideal.Short short(final m=m) if mBase == 2 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-10,30})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor(
    final m=m, 
    final useHeatPort=useHeatPort, 
    final R=fill(RRef, m), 
    final T_ref=fill(TRef, m), 
    final alpha=fill(alphaRef, m), 
    final T=fill(TOperational, m)) "Winding resistor" annotation (
      Placement(transformation(
        origin={-20,70}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding[m] if 
    useHeatPort "绕组电阻器的散热口" 
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore if 
    useHeatPort "核心的散热口" 
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  Magnetic.FundamentalWave.Components.EddyCurrent core(final useHeatPort= 
        useHeatPort, final G=(m/2)*GcRef*effectiveTurns^2) 
    "磁芯损耗模型（目前仅有涡流）" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={50,-40})));
  Modelica.Magnetic.FundamentalWave.Components.Permeance stray(
    final G_m(d=2*Lsigma/m/effectiveTurns^2, q=2*Lsigma/m/effectiveTurns^2)) 
    "杂散磁导相当于理想耦合的杂散电感" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={80,30})));

equation
  connect(plug_p, resistor.plug_p) annotation (Line(points={{-100,100},{-20, 
          100},{-20,80}}, color={0,0,255}));
  connect(resistor.plug_n, zeroInductor.plug_p) annotation (Line(points={{-20,60}, 
          {-20,55},{-20,40},{-30,40}}, color={0,0,255}));
  connect(electroMagneticConverter.plug_n, plug_n) annotation (Line(
        points={{-10,-40},{-10,-40},{-100,-40},{-100,-100}}, color={0,0, 
          255}));
  connect(electroMagneticConverter.port_p, port_p) annotation (Line(
        points={{10,-20},{10,100},{100,100}}, color={255,128,0}));
  connect(resistor.heatPort, heatPortWinding) annotation (Line(
      points={{-30,70},{-40,70},{-40,-100}}, color={191,0,0}));
  connect(electroMagneticConverter.port_n, core.port_p) annotation (Line(
      points={{10,-40},{40,-40}}, color={255,128,0}));
  connect(core.port_n, port_n) annotation (Line(
      points={{60,-40},{100,-40},{100,-100}}, color={255,128,0}));
  connect(core.heatPort, heatPortCore) annotation (Line(
      points={{40,-50},{40,-100}}, color={191,0,0}));
  connect(stray.port_n, core.port_n) annotation (Line(points={{80,20},{80,-40},{60,-40}}, color={255,128,0}));
  connect(stray.port_p, electroMagneticConverter.port_p) annotation (Line(points={{80,40},{80,100},{10,100},{10,-20}}, color={255,128,0}));
  connect(zeroInductor.plug_n, electroMagneticConverter.plug_p) annotation (
      Line(points={{-30,20},{-20,20},{-20,-20},{-10,-20}}, color={0,0,255}));
  connect(resistor.plug_n, short.plug_p) 
    annotation (Line(points={{-20,60},{-20,40},{-10,40}}, color={0,0,255}));
  connect(electroMagneticConverter.plug_p, short.plug_n) annotation (Line(
        points={{-10,-20},{-20,-20},{-20,20},{-10,20}}, color={0,0,255}));
  annotation (defaultComponentName="winding", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50, 
              -72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46, 
              66},{62,84},{78,96},{90,100},{100,100}}, color={255,128,0}), 
        Line(points={{40,60},{-100,60},{-100,100}}, color={0,0,255}), 
        Line(points={{40,-60},{-100,-60},{-100,-98}}, color={0,0,255}), 
        Line(points={{40,60},{100,20},{40,-20},{0,-20},{-40,0},{0,20},{40, 
              20},{100,-20},{40,-60}}, color={0,0,255}), 
          Text(
              extent={{-150,110},{150,150}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
                                 Documentation(info="<html>
<p>
对称多相绕组包括一个对称绕组
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Resistor\">resistor</a>, a
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.ZeroInductor\">zero inductor</a> 以及对称的
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter\">polyphase electromagnetic coupling</a> 和
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Reluctance\">stray reluctance</a> 和
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">core loss</a> 模型包括
heat <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">port</a>.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">SymmetricPolyphaseCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SymmetricPolyphaseWinding;