within Modelica.Electrical.PowerConverters.DCDC;
model ChopperStepDown "降压斩波器"
  import Modelica.Constants.pi;
  extends Icons.Converter;
  parameter SI.Resistance RonTransistor=1e-05 
    "晶体管闭合电阻";
  parameter SI.Conductance GoffTransistor=1e-05 
    "晶体管开启电导";
  parameter SI.Voltage VkneeTransistor=0 
    "晶体管阈值电压";
  parameter SI.Resistance RonDiode(final min=0) = 1e-05 
    "二极管闭合电阻";
  parameter SI.Conductance GoffDiode(final min=0) = 1e-05 
    "二极管开启电导";
  parameter SI.Voltage VkneeDiode(final min=0) = 0 
    "二极管正向阈值电压";
  extends PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends PowerConverters.Interfaces.DCDC.DCtwoPin2;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T= 
       293.15);
  extends Interfaces.Enable.Enable1;
  Modelica.Electrical.Analog.Ideal.IdealGTOThyristor transistor(
    useHeatPort=useHeatPort, 
    Ron=RonTransistor, 
    Goff=GoffTransistor, 
    Vknee=VkneeTransistor) "开关晶体管" annotation (Placement(
        transformation(
        origin={0,60}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode diode(
    Ron=RonDiode, 
    Goff=GoffDiode, 
    Vknee=VkneeDiode, 
    useHeatPort=useHeatPort) "自由轮二极管" annotation (Placement(
        transformation(
        origin={40,0}, 
        extent={{-10,10},{10,-10}}, 
        rotation=90)));
equation
  if not useHeatPort then
    LossPower = diode.LossPower + transistor.LossPower;
  end if;
  connect(diode.n, transistor.n) annotation (Line(
      points={{40,10},{40,60},{10,60}}, color={0,0,255}));
  connect(transistor.n, dc_p2) annotation (Line(
      points={{10,60},{100,60}}, color={0,0,255}));
  connect(transistor.heatPort, heatPort) annotation (Line(
      points={{0,50},{0,-100}}, color={191,0,0}));
  connect(diode.heatPort, heatPort) annotation (Line(
      points={{30,0},{0,0},{0,-100}}, color={191,0,0}));
  connect(dc_p1, transistor.p) annotation (Line(
      points={{-100,60},{-10,60}}, color={0,0,255}));
  connect(dc_n1, diode.p) annotation (Line(
      points={{-100,-60},{40,-60},{40,-10}}, color={0,0,255}));
  connect(dc_n1, dc_n2) annotation (Line(
      points={{-100,-60},{100,-60}}, color={0,0,255}));
  connect(andCondition_p.y, transistor.fire) annotation (Line(
      points={{-60,-69},{-60,80},{10,80},{10,72}}, 
                                                 color={255,0,255}));
  annotation (defaultComponentName="dcdc", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Text(
          extent={{-100,70},{0,50}}, 
          textColor={0,0,255}, 
          textString="DC in"), 
        Text(
          extent={{0,-50},{100,-70}}, 
          textColor={0,0,255}, 
          textString="DC out"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Rectangle(
          extent={{-40,40},{40,-40}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-30,20},{-30,0}}, color={255,0,255}), 
        Line(points={{-40,30},{-30,20},{-20,30}}, color={0,0,255}), 
        Polygon(
          points={{-20,30},{-26,26},{-24,24},{-20,30}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(points={{20,10},{10,-10},{30,-10},{20,10}}, lineColor={0,0, 
              255}), 
        Line(points={{10,10},{30,10}}, color={0,0,255}), 
        Line(points={{-20,30},{60,30}}, color={0,0,255}), 
        Line(points={{-60,30},{-40,30}}, color={0,0,255}), 
        Line(points={{-60,-30},{60,-30}}, color={0,0,255}), 
        Line(points={{20,30},{20,-30}}, color={0,0,255}), 
        Ellipse(extent={{-62,32},{-58,28}}, lineColor={0,0,255}), 
        Ellipse(extent={{-62,-28},{-58,-32}}, lineColor={0,0,255}), 
        Ellipse(extent={{18,-28},{22,-32}}, lineColor={0,0,255}), 
        Ellipse(extent={{58,-28},{62,-32}}, lineColor={0,0,255}), 
        Ellipse(extent={{58,32},{62,28}}, lineColor={0,0,255}), 
        Ellipse(extent={{18,32},{22,28}}, lineColor={0,0,255}), 
        Ellipse(extent={{-44,40},{-16,12}}, lineColor={0,0,255}), 
        Line(points={{-40,20},{-20,20}}, color={0,0,255})}), 
    Documentation(info="<html>
<p>
这是一个传统的降压斩波器（降压变换器）模型。它由一个晶体管和一个自由轮二极管组成。
</p>
</html>"));
end ChopperStepDown;