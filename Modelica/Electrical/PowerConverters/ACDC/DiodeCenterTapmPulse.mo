within Modelica.Electrical.PowerConverters.ACDC;
model DiodeCenterTapmPulse "带中心引线的m脉冲二极管整流器"
  import Modelica.Constants.pi;
  extends Icons.Converter;
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  parameter SI.Resistance RonDiode(final min=0) = 1e-05 
    "闭合二极管电阻";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05 
    "开启二极管导纳";
  parameter SI.Voltage VkneeDiode(final min=0) = 0 
    "二极管正向阈值电压";
  extends PowerConverters.Interfaces.ACDC.ACplug;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode(
    final m=m, 
    final Ron=fill(RonDiode, m), 
    final Goff=fill(GoffDiode, m), 
    final Vknee=fill(VkneeDiode, m), 
    final useHeatPort=useHeatPort) 
    "连接到正直流电位的二极管" annotation (Placement(
        transformation(
        origin={-10,0}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) 
    annotation (Placement(transformation(extent={{70,10},{90,-10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector 
    thermalCollector(final m=m) if useHeatPort 
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
equation
  assert(mod(m, 2) == 1, 
    "DiodeCenterTapmPulse: 只允许奇数相数");
  if not useHeatPort then
    LossPower = sum(diode.idealDiode.LossPower);
  end if;
  connect(diode.plug_n, star.plug_p) annotation (Line(
      points={{0,0},{70,0}}, color={0,0,255}));
  connect(star.pin_n, dc_p) annotation (Line(
      points={{90,0},{100,0}}, color={0,0,255}));
  connect(heatPort, thermalCollector.port_b) annotation (Line(
      points={{0,-100},{30,-100}}, color={191,0,0}));
  connect(diode.heatPort, thermalCollector.port_a) annotation (Line(
      points={{-10,-10},{-10,-20},{30,-20},{30,-80}}, color={191,0,0}));
  connect(ac, diode.plug_p) annotation (Line(
      points={{-100,0},{-20,0}}, color={0,0,255}));
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
这是一个带中心引线的 m 脉冲二极管整流器。所有电压源必须具有一个相互连接的插头（引线）。由于在
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a> 中实施的偶数相数的对称约束，该整流器仅适用于奇数相数。电路拓扑与
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse\">Examples.ACDC.RectifierCenterTapmPulse</a> 中相同。
</p>
</html>"));
end DiodeCenterTapmPulse;