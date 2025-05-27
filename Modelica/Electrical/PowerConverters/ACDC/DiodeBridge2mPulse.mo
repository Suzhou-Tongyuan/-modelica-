within Modelica.Electrical.PowerConverters.ACDC;
model DiodeBridge2mPulse "2*m脉冲二极管整流桥"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  parameter SI.Resistance RonDiode(final min=0) = 1e-05 
    "闭合二极管电阻";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05 
    "开启二极管导纳";
  parameter SI.Voltage VkneeDiode(final min=0) = 0 
    "二极管正向阈值电压";
  extends PowerConverters.Interfaces.ACDC.ACplug;
  extends PowerConverters.Interfaces.ACDC.DCtwoPin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_p(
    final m=m, 
    final Ron=fill(RonDiode, m), 
    final Goff=fill(GoffDiode, m), 
    final Vknee=fill(VkneeDiode, m), 
    final useHeatPort=useHeatPort) 
    "连接到正直流电势的二极管" annotation (Placement(
        transformation(
        origin={0,40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_n(
    final m=m, 
    final Ron=fill(RonDiode, m), 
    final Goff=fill(GoffDiode, m), 
    final Vknee=fill(VkneeDiode, m), 
    final useHeatPort=useHeatPort) 
    "连接到负直流电势的二极管" annotation (Placement(
        transformation(
        origin={0,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m) 
    annotation (Placement(transformation(extent={{70,70},{90,50}})));
  Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m) 
    annotation (Placement(transformation(extent={{70,-50},{90,-70}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector 
    thermalCollector(final m=m) if useHeatPort 
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
equation
  if not useHeatPort then
    LossPower = sum(diode_p.idealDiode.LossPower) + sum(diode_n.idealDiode.LossPower);
  end if;
  connect(ac, diode_p.plug_p) annotation (Line(
      points={{-100,0},{-100,0},{0,0},{0,30}}, color={0,0,255}));
  connect(diode_p.plug_p, diode_n.plug_n) annotation (Line(
      points={{0,30},{0,-30}}, color={0,0,255}));
  connect(diode_p.plug_n, star_p.plug_p) annotation (Line(
      points={{0,50},{0,60},{70,60}}, color={0,0,255}));
  connect(star_p.pin_n, dc_p) annotation (Line(
      points={{90,60},{100,60}}, color={0,0,255}));
  connect(diode_n.plug_p, star_n.plug_p) annotation (Line(
      points={{0,-50},{0,-60},{70,-60}}, color={0,0,255}));
  connect(star_n.pin_n, dc_n) annotation (Line(
      points={{90,-60},{100,-60}}, color={0,0,255}));
  connect(thermalCollector.port_a, diode_n.heatPort) annotation (Line(
      points={{20,-80},{20,-40},{10,-40}}, color={191,0,0}));
  connect(thermalCollector.port_b, heatPort) annotation (Line(
      points={{20,-100},{0,-100}}, color={191,0,0}));
  connect(diode_p.heatPort, thermalCollector.port_a) annotation (Line(
      points={{10,40},{20,40},{20,-80}}, color={191,0,0}));
  annotation (defaultComponentName="rectifier", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,70},{0,50}}, 
          textColor={0,0,255}, 
          textString="交流"), 
        Text(
          extent={{0,-50},{100,-70}}, 
          textColor={0,0,255}, 
          textString="直流"), 
        Rectangle(
          extent={{-40,24},{40,-24}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-40,0},{40,0}}, 
          color={0,0,255}), 
        Line(
          points={{20,24},{20,-24}}, 
          color={0,0,255}), 
        Line(
          points={{20,0},{-20,24},{-20,-24},{20,0}}, 
          color={0,0,255})}), 
    Documentation(info="<html>
<p>
有关交流/直流转换器的一般信息，请参阅
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">交流/直流转换器概念</a>。
</p>

<p>
这是一个 2*m 脉冲二极管整流桥。为了操作此整流器，需要一个带有中心引线的电压源。电路拓扑与
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse\">Examples.ACDC.RectifierBridge2mPulse</a> 中相同。重要的是要注意，对于相数大于三的偶数相数的多相电路，应使用
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStarResistance\">MultiStarResistance</a> 进行接地。
</p>
</html>"));
end DiodeBridge2mPulse;