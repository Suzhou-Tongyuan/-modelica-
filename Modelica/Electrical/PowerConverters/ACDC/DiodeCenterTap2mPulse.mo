within Modelica.Electrical.PowerConverters.ACDC;
model DiodeCenterTap2mPulse "2*m脉冲中心引线二极管整流器"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  parameter SI.Resistance RonDiode(final min=0) = 1e-05 
    "闭合二极管电阻";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05 
    "开启二极管导纳";
  parameter SI.Voltage VkneeDiode(final min=0) = 0 
    "二极管正向阈值电压";
  extends PowerConverters.Interfaces.ACDC.ACtwoPlug;
  extends PowerConverters.Interfaces.ACDC.DCpin;
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
        origin={-10,60}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode_n(
    final m=m, 
    final Ron=fill(RonDiode, m), 
    final Goff=fill(GoffDiode, m), 
    final Vknee=fill(VkneeDiode, m), 
    final useHeatPort=useHeatPort) 
    "连接到负直流电势的二极管" annotation (Placement(
        transformation(
        origin={-10,-60}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Star star_p(final m=m) 
    annotation (Placement(transformation(extent={{70,70},{90,50}})));
  Modelica.Electrical.Polyphase.Basic.Star star_n(final m=m) 
    annotation (Placement(transformation(extent={{72,-50},{92,-70}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector 
    thermalCollector(final m=m) if useHeatPort 
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
equation
  if not useHeatPort then
    LossPower = sum(diode_p.idealDiode.LossPower) + sum(diode_n.idealDiode.LossPower);
  end if;
  connect(diode_p.plug_n, star_p.plug_p) annotation (Line(
      points={{0,60},{70,60}}, color={0,0,255}));
  connect(star_p.pin_n, dc_p) annotation (Line(
      points={{90,60},{100,60},{100,0}}, color={0,0,255}));
  connect(heatPort, thermalCollector.port_b) annotation (Line(
      points={{0,-100},{30,-100}}, color={191,0,0}));
  connect(thermalCollector.port_a, diode_n.heatPort) annotation (Line(
      points={{30,-80},{-10,-80},{-10,-70}}, color={191,0,0}));
  connect(diode_p.heatPort, thermalCollector.port_a) annotation (Line(
      points={{-10,50},{-10,40},{30,40},{30,-80}}, color={191,0,0}));
  connect(ac_p, diode_p.plug_p) annotation (Line(
      points={{-100,60},{-20,60}}, color={0,0,255}));
  connect(star_n.pin_n, dc_p) annotation (Line(
      points={{92,-60},{100,-60},{100,0}}, color={0,0,255}));
  connect(diode_n.plug_p, ac_n) annotation (Line(
      points={{-20,-60},{-100,-60}}, color={0,0,255}));
  connect(diode_n.plug_n, star_n.plug_p) annotation (Line(
      points={{0,-60},{72,-60}}, color={0,0,255}));
  annotation (defaultComponentName="rectifier", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,70},{0,50}}, 
          textColor={0,0,255}, 
          textString="AC"), 
        Text(
          extent={{0,-50},{100,-70}}, 
          textColor={0,0,255}, 
          textString="DC"), 
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
关于交流/直流转换器的一般信息，请参阅
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">交流/直流转换器概念</a>。
</p>

<p>
这是一个 2*m 脉冲中心引线二极管整流器。为了操作此整流器，需要一个带有中心引线的电压源。中心引线必须连接到负载的负引脚。电路拓扑结构与
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse\">Examples.ACDC.RectifierCenterTap2mPulse</a>
中相同。
</p>
</html>"));
end DiodeCenterTap2mPulse;