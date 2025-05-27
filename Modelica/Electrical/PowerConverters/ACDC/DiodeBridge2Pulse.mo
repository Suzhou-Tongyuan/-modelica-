within Modelica.Electrical.PowerConverters.ACDC;
model DiodeBridge2Pulse "双脉冲格雷兹二极管整流桥"
  extends Icons.Converter;
  import Modelica.Constants.pi;
  parameter SI.Resistance RonDiode(final min=0) = 1e-05 
    "导通二极管电阻";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05 
    "截止二极管导纳";
  parameter SI.Voltage VkneeDiode(final min=0) = 0 
    "二极管正向阈值电压";
  extends PowerConverters.Interfaces.ACDC.ACtwoPin;
  extends PowerConverters.Interfaces.ACDC.DCtwoPin;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_p1(
    final Goff=GoffDiode, 
    final Vknee=VkneeDiode, 
    final useHeatPort=useHeatPort, 
    final Ron=RonDiode) 
    "连接正交流输入引脚与正直流输出的二极管" 
    annotation (Placement(transformation(
        origin={10,50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_p2(
    final Ron=RonDiode, 
    final Goff=GoffDiode, 
    final Vknee=VkneeDiode, 
    final useHeatPort=useHeatPort) 
    "连接负交流输入引脚与正直流输出的二极管" 
    annotation (Placement(transformation(
        origin={40,50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_n1(
    final Ron=RonDiode, 
    final Goff=GoffDiode, 
    final Vknee=VkneeDiode, 
    final useHeatPort=useHeatPort) 
    "连接正交流输入引脚与负直流输出的二极管" 
    annotation (Placement(transformation(
        origin={10,-50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode_n2(
    final Ron=RonDiode, 
    final Goff=GoffDiode, 
    final Vknee=VkneeDiode, 
    final useHeatPort=useHeatPort) 
    "连接负交流输入引脚与负直流输出的二极管" 
    annotation (Placement(transformation(
        origin={40,-50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
equation
  if not useHeatPort then
    LossPower = diode_p1.LossPower + diode_p2.LossPower + diode_n1.LossPower 
       + diode_n2.LossPower;
  end if;
  connect(diode_p2.n, diode_p1.n) annotation (Line(
      points={{40,60},{10,60}}, color={0,0,255}));
  connect(diode_n1.p, diode_n2.p) annotation (Line(
      points={{10,-60},{40,-60}}, color={0,0,255}));
  connect(diode_n2.n, diode_p2.p) annotation (Line(
      points={{40,-40},{40,40}}, color={0,0,255}));
  connect(diode_p1.p, diode_n1.n) annotation (Line(
      points={{10,40},{10,-40}}, color={0,0,255}));
  connect(diode_p1.n, dc_p) annotation (Line(
      points={{10,60},{100,60}}, color={0,0,255}));
  connect(diode_n1.p, dc_n) annotation (Line(
      points={{10,-60},{100,-60}}, color={0,0,255}));
  connect(diode_n1.heatPort, heatPort) annotation (Line(
      points={{20,-50},{20,-100},{0,-100}}, color={191,0,0}));
  connect(diode_n2.heatPort, heatPort) annotation (Line(
      points={{50,-50},{50,-100},{0,-100}}, color={191,0,0}));
  connect(diode_p1.heatPort, heatPort) annotation (Line(
      points={{0,50},{-50,50},{-50,-100},{0,-100}}, color={191,0,0}));
  connect(diode_p2.heatPort, heatPort) annotation (Line(
      points={{30,50},{30,30},{-50,30},{-50,-100},{0,-100}}, color={191,0,0}));
  connect(ac_p, diode_p1.p) annotation (Line(
      points={{-100,60},{-60,60},{-60,20},{10,20},{10,40}}, color={0,0,255}));
  connect(ac_n, diode_p2.p) annotation (Line(
      points={{-100,-60},{-60,-60},{-60,-20},{40,-20},{40,40}}, color={0,0,255}));
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
<a href=\"modelica://Modelica.Electrical.PowerConverters.UsersGuide.ACDCConcept\">交流/直流转换器概念</a>
</p>

<p>
这是一个双脉冲格雷茨二极管整流桥。电路拓扑与
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse\">Examples.ACDC.RectifierCenterTap2Pulse</a>
中的一样。
</p>
</html>"));
end DiodeBridge2Pulse;