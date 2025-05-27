within Modelica.Electrical.PowerConverters.ACDC;
model DiodeCenterTap2Pulse "具有中心引线的双脉冲二极管整流器"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  parameter SI.Resistance RonDiode(final min=0) = 1e-05 
    "闭合二极管电阻";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05 
    "开启二极管导纳";
  parameter SI.Voltage VkneeDiode(final min=0) = 0 
    "二极管正向阈值电压";
  extends PowerConverters.Interfaces.ACDC.ACtwoPin;
  extends PowerConverters.Interfaces.ACDC.DCpin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_p(
    final Ron=RonDiode, 
    final Goff=GoffDiode, 
    final Vknee=VkneeDiode, 
    final useHeatPort=useHeatPort) 
    "导通正极交流电位的二极管" annotation (Placement(
        transformation(
        origin={0,60}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_n(
    final Ron=RonDiode, 
    final Goff=GoffDiode, 
    final Vknee=VkneeDiode, 
    final useHeatPort=useHeatPort) 
    "导通负极交流电位的二极管" annotation (Placement(
        transformation(
        origin={0,-60}, 
        extent={{-10,-10},{10,10}})));
equation
  if not useHeatPort then
    LossPower = diode_p.LossPower + diode_n.LossPower;
  end if;
  connect(ac_p, diode_p.p) annotation (Line(
      points={{-100,60},{-10,60}}, color={0,0,255}));
  connect(ac_n, diode_n.p) annotation (Line(
      points={{-100,-60},{-10,-60}}, color={0,0,255}));
  connect(diode_p.n, dc_p) annotation (Line(
      points={{10,60},{100,60},{100,0}}, color={0,0,255}));
  connect(diode_n.n, dc_p) annotation (Line(
      points={{10,-60},{100,-60},{100,0}}, color={0,0,255}));
  connect(diode_n.heatPort, heatPort) annotation (Line(
      points={{0,-70},{0,-100}}, color={191,0,0}));
  connect(diode_p.heatPort, heatPort) annotation (Line(
      points={{0,50},{0,40},{20,40},{20,-100},{
          0,-100}}, color={191,0,0}));
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
          color={0,0,255})}), 
    Documentation(info="<html>
<p>
有关交流/直流转换器的一般信息，请参阅
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">交流/直流转换器概念</a>
</p>

<p>
这是一个具有中心引线的两脉冲二极管整流器。要操作此整流器，需要具有中心引线的电压。中心引线必须与负载的负极引线连接。电路拓扑与
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">示例.ACDC.RectifierCenterTap2Pulse</a>
中相同。
</p>
</html>"));
end DiodeCenterTap2Pulse;