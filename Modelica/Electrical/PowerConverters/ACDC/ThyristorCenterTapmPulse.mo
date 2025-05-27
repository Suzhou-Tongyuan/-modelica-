within Modelica.Electrical.PowerConverters.ACDC;
model ThyristorCenterTapmPulse 
  "带中心引线的m脉冲晶闸管整流器"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  // parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  parameter SI.Resistance RonThyristor(final min=0) = 1e-05 
    "闭合晶闸管电阻";
  parameter SI.Conductance GoffThyristor(final min=0) = 1e-05 
    "开启晶闸管导纳";
  parameter SI.Voltage VkneeThyristor(final min=0) = 0 
    "晶闸管正向阈值电压";
  parameter Boolean offStart[m]=fill(true, m) 
    "变量 thyristor_p[:].off 的布尔初始值" 
    annotation (choices(checkBox=true));
  extends PowerConverters.Interfaces.ACDC.ACplug;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  extends Interfaces.Enable.Enable1m;
  Modelica.Electrical.Polyphase.Ideal.IdealThyristor thyristor(
    final m=m, 
    final Ron=fill(RonThyristor, m), 
    final Goff=fill(GoffThyristor, m), 
    final Vknee=fill(VkneeThyristor, m), 
    final useHeatPort=useHeatPort, 
    final idealThyristor(off(start=offStart, fixed=fill(true, m)))) 
    "导通交流电位的晶闸管" annotation (Placement(transformation(
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
    "ThyristorCenterTapmPulse: 只允许奇数相数");
  if not useHeatPort then
    LossPower = sum(thyristor.idealThyristor.LossPower);
  end if;
  connect(thyristor.plug_n, star.plug_p) annotation (Line(
      points={{0,0},{70,0}}, color={0,0,255}));
  connect(star.pin_n, dc_p) annotation (Line(
      points={{90,0},{100,0}}, color={0,0,255}));
  connect(heatPort, thermalCollector.port_b) annotation (Line(
      points={{0,-100},{30,-100}}, color={191,0,0}));
  connect(thyristor.heatPort, thermalCollector.port_a) annotation (Line(
      points={{-10,-10},{-10,-20},{30,-20},{30,-80}}, color={191,0,0}));
  connect(ac, thyristor.plug_p) annotation (Line(
      points={{-100,0},{-20,0}}, color={0,0,255}));
  connect(andCondition_p.y, thyristor.fire) annotation (Line(
      points={{-60,-69},{-60,20},{1.77636e-15,20},{1.77636e-15,11.8}}, 
                                                   color={255,0,255}));
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
          color={0,0,255}), 
        Line(
          points={{0,12},{0,28}}, 
          color={0,0,255})}), 
    Documentation(info="<html>
<p>
有关交流/直流转换器的一般信息，请参阅
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">交流/直流转换器概念</a>。
</p>

<p>
这是一个带中心引线的 m 脉冲晶闸管整流器。所有电压源必须具有一个相互连接的插头（引线）。由于在
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a> 中实施的偶数相数的对称约束，该整流器仅适用于奇数相数。查看示例
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse\">Examples.ACDC.RectifierCenterTapmPulse</a>。
</p>
</html>"));
end ThyristorCenterTapmPulse;