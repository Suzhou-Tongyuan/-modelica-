within Modelica.Electrical.PowerConverters.ACDC;
model ThyristorCenterTap2Pulse 
  "具有中心引线的双脉冲可控硅整流器"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  parameter SI.Resistance RonThyristor(final min=0) = 1e-05 
    "闭合可控硅电阻";
  parameter SI.Conductance GoffThyristor(final min=0) = 1e-05 
    "开启可控硅导纳";
  parameter SI.Voltage VkneeThyristor(final min=0) = 0 
    "可控硅正向阈值电压";
  parameter Boolean offStart_p=true 
    "变量 thyristor_p.off 的布尔启动值" 
    annotation (choices(checkBox=true));
  parameter Boolean offStart_n=true 
    "变量 thyristor_n.off 的布尔启动值" 
    annotation (choices(checkBox=true));
  extends PowerConverters.Interfaces.ACDC.ACtwoPin;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  extends Interfaces.Enable.Enable2;
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_p(
    final Ron=RonThyristor, 
    final Goff=GoffThyristor, 
    final Vknee=VkneeThyristor, 
    final useHeatPort=useHeatPort, 
    final off(start=offStart_p, fixed=true)) 
    "导通正极交流电位的可控硅" annotation (
      Placement(transformation(
        origin={0,60}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor_n(
    final Ron=RonThyristor, 
    final Goff=GoffThyristor, 
    final Vknee=VkneeThyristor, 
    final useHeatPort=useHeatPort, 
    final off(start=offStart_n, fixed=true)) 
    "导通负极交流电位的可控硅" annotation (
      Placement(transformation(
        origin={0,-60}, 
        extent={{-10,-10},{10,10}})));
equation
  if not useHeatPort then
    LossPower = thyristor_p.LossPower + thyristor_n.LossPower;
  end if;
  connect(ac_p, thyristor_p.p) annotation (Line(
      points={{-100,60},{-10,60}}, color={0,0,255}));
  connect(ac_n, thyristor_n.p) annotation (Line(
      points={{-100,-60},{-10,-60}}, color={0,0,255}));
  connect(thyristor_p.n, dc_p) annotation (Line(
      points={{10,60},{100,60},{100,0}}, color={0,0,255}));
  connect(thyristor_n.n, dc_p) annotation (Line(
      points={{10,-60},{100,-60},{100,0}}, color={0,0,255}));
  connect(thyristor_n.heatPort, heatPort) annotation (Line(
      points={{0,-70},{0,-100}}, color={191,0,0}));
  connect(thyristor_p.heatPort, heatPort) annotation (Line(
      points={{0,50},{0,40},{20,40},{20,-100},{
          0,-100}}, color={191,0,0}));
  connect(andCondition_p.y, thyristor_p.fire) annotation (Line(
      points={{-60,-69},{-60,80},{10,80},{10,72}}, 
                                                 color={255,0,255}));
  connect(andCondition_n.y, thyristor_n.fire) annotation (Line(
      points={{60,-69},{60,-40},{10,-40},{10,-48}}, 
                                                  color={255,0,255}));
  annotation (defaultComponentName="rectifier", 
    Icon(coordinateSystem(
        extent={{-100,-100},{100,100}}, 
        preserveAspectRatio=true, 
        grid={2,2}), graphics={
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
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">交流/直流转换器概念</a>
</p>

<p>This a two pulse thyristor rectifier with center tap. In order to operate this rectifier a voltage with center tap is required. The center tap has to be connected with the negative pin of the load. The circuit topology is the same as in
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>.
</p>
</html>"));
end ThyristorCenterTap2Pulse;