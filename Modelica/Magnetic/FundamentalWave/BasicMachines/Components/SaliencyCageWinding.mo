within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model SaliencyCageWinding "d 轴和 q 轴突出的转子笼"
  extends Magnetic.FundamentalWave.Interfaces.TwoPortExtended;
  parameter Boolean useHeatPort=false 
    "启用/禁用（=固定温度）热敏端口" 
    annotation (Evaluate=true);
  parameter Magnetic.FundamentalWave.Types.SalientResistance RRef(d(start=1), q(
        start=1)) "Salient cage resistance";
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
  parameter Magnetic.FundamentalWave.Types.SalientInductance Lsigma(d(start=1), 
      q(start=1)) "Salient cage stray inductance";
  parameter Real effectiveTurns=1 "有效转数";
  Modelica.Blocks.Interfaces.RealOutput i[2](
    each final quantity="ElectricCurrent", 
    each final unit="A") = electroMagneticConverter.i 
    "从风门流出的电流";
  Modelica.Blocks.Interfaces.RealOutput iRMS(
    final quantity="ElectricCurrent", 
    final unit="A") = sqrt(i[1]^2+i[2]^2)/sqrt(2) 
    "阻尼器输出的有效值电流";
  Modelica.Blocks.Interfaces.RealOutput lossPower(
    final quantity="Power", 
    final unit="W") = sum(resistor.resistor.LossPower) "Damper losses";
  Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter electroMagneticConverter(
    final m=2, 
    final orientation={0,Modelica.Constants.pi/2}, 
    final effectiveTurns=fill(effectiveTurns, 2)) annotation (Placement(
        transformation(
        origin={0,-10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor(
    final useHeatPort=useHeatPort, 
    final m=2, 
    final R={RRef.d,RRef.q}, 
    final T_ref=fill(TRef, 2), 
    final alpha=fill(alphaRef, 2), 
    final T=fill(TOperational, 2)) annotation (Placement(transformation(
        origin={-20,-50}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=2) annotation (
      Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={60,-20}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if 
    useHeatPort "绕组电阻器的散热口" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(final m=2) 
    if useHeatPort "热转子电阻热端口连接器" 
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Magnetic.FundamentalWave.Components.Reluctance strayReluctance(final R_m(d= 
          effectiveTurns^2/Lsigma.d, q=effectiveTurns^2/Lsigma.q)) 
    "等效于理想耦合杂散电感的杂散磁阻" 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0, 
            20})));
equation
  connect(port_p, electroMagneticConverter.port_p) 
    annotation (Line(points={{-100,0},{-10,0}}, color={255,128,0}));
  connect(electroMagneticConverter.port_n, port_n) 
    annotation (Line(points={{10,0},{100,0}}, color={255,128,0}));
  connect(ground.p, star.pin_n) 
    annotation (Line(points={{50,-20},{40,-20}}, color={0,0,255}));
  connect(electroMagneticConverter.plug_n, resistor.plug_n) annotation (
      Line(
      points={{10,-20},{20,-20},{20,-60},{-20,-60}}, color={0,0,255}));
  connect(star.plug_p, electroMagneticConverter.plug_n) annotation (Line(
      points={{20,-20},{20,-20},{10,-20}}, color={0,0,255}));
  connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
      points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
  connect(resistor.heatPort, thermalCollector.port_a) annotation (Line(
      points={{-30,-50},{-40,-50},{-40,-70}}, color={191,0,0}));
  connect(electroMagneticConverter.plug_p, resistor.plug_p) annotation (
      Line(
      points={{-10,-20},{-20,-20},{-20,-40}}, color={0,0,255}));
  connect(strayReluctance.port_p, port_p) annotation (Line(
      points={{-10,20},{-30,20},{-30,0},{-100,0}}, color={255,128,0}));
  connect(strayReluctance.port_n, port_n) annotation (Line(
      points={{10,20},{30,20},{30,0},{100,0}}, color={255,128,0}));
  annotation (defaultComponentName="cage", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Ellipse(
                extent={{-80,80},{80,-80}}, 
                fillColor={175,175,175}, 
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{-20,76},{20,36}}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{28,46},{68,6}}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{28,-8},{68,-48}}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{-20,-36},{20,-76}}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{-68,-6},{-28,-46}}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{-66,50},{-26,10}}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Line(points={{-80,0},{-100, 
          0}}, color={255,128,0}),Line(points={{100,0},{80,0}}, color={
          255,128,0}), 
          Text(
              extent={{-150,100},{150,140}}, 
              textColor={0,0,255}, 
              textString="%name")}), 
    Documentation(info="<html>

<p>
突出笼模型是一个具有两个相位的双轴模型。因此，电磁耦合也是两相耦合模型。两个方向的角度分别为 0 和 <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/pi_over_2.png\">。通过这种方法，可以模拟在 d 轴和 q 轴上具有不同电阻和杂散电感的不对称转子笼。.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseWinding\">SymmetricPolyphaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricPolyphaseCageWinding\">SymmetricPolyphaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
end SaliencyCageWinding;