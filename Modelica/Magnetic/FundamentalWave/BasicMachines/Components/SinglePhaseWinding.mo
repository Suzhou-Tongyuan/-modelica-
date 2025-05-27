within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model SinglePhaseWinding 
  "耦合电场和磁场的对称绕组模型"

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
  Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port_n 
    "负复合磁端口" 
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port_p 
    "正复磁端口" 
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
  parameter Boolean useHeatPort=false 
    "启用/禁用（=固定温度）热敏端口" 
    annotation (Evaluate=true);
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
  parameter SI.Angle orientation 
    "由此产生的基波场相位的方向";

  SI.Voltage v=pin_p.v - pin_n.v "电压";
  SI.Current i=pin_p.i "电流";

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

  Modelica.Electrical.Analog.Basic.Resistor resistor(
    final useHeatPort=useHeatPort, 
    final R=RRef, 
    final T_ref=TRef, 
    final alpha=alphaRef, 
    final T=TOperational) annotation (Placement(transformation(
        origin={-10,70}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90)));
  Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter electroMagneticConverter(final
      effectiveTurns=effectiveTurns, final orientation=orientation) "Winding" 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if 
    useHeatPort "绕组电阻器的散热口" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Magnetic.FundamentalWave.Components.Permeance stray(final G_m(d= 
          Lsigma/effectiveTurns^2, q=Lsigma/effectiveTurns^2)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={30,0})));
equation
  connect(pin_p, resistor.p) annotation (Line(points={{-100,100},{-10,100}, 
          {-10,80}}, color={0,0,255}));
  connect(electroMagneticConverter.pin_n, pin_n) annotation (Line(points= 
          {{-10,-10},{-10,-100},{-100,-100}}, color={0,0,255}));
  connect(electroMagneticConverter.port_p, port_p) annotation (Line(
        points={{10,10},{10,100},{100,100}}, color={255,128,0}));
  connect(electroMagneticConverter.port_n, port_n) annotation (Line(
        points={{10,-10},{10,-100},{100,-100}}, color={255,128,0}));
  connect(heatPortWinding, resistor.heatPort) annotation (Line(
      points={{0,-100},{0,-60},{-40,-60},{-40,70},{-20,70}}, color={191,0,0}));
  connect(resistor.n, electroMagneticConverter.pin_p) annotation (Line(
      points={{-10,60},{-10,10}}, color={0,0,255}));
  connect(electroMagneticConverter.port_p, stray.port_p) 
    annotation (Line(points={{10,10},{30,10}}, color={255,128,0}));
  connect(electroMagneticConverter.port_n, stray.port_n) 
    annotation (Line(points={{10,-10},{30,-10}}, color={255,128,0}));
  annotation (defaultComponentName="winding", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={      Line(points={{100,-100},{
          94,-100},{84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40}, 
          {30,-18},{30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100}, 
          {100,100}}, color={255,128,0}),Line(points={{40,60},{-100,60},{
          -100,100}}, color={0,0,255}),Line(points={{40,-60},{-100,-60},{
          -100,-98}}, color={0,0,255}),Line(points={{40,60},{100,20},{40, 
          -20},{0,-20},{-40,0},{0,20},{40,20},{100,-20},{40,-60}}, color= 
          {0,0,255}), 
          Text(
              extent={{-150,110},{150,150}}, 
              textColor={0,0,255}, 
              textString="%name")}),   Documentation(info="<html>
<p>
单相绕组包括一个绕组
<a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">resistor</a>, a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">single-phase electromagnetic coupling</a> and a <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Reluctance\">stray reluctance</a>.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">SymmetricPolyphaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">SymmetricPolyphaseCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SinglePhaseWinding;