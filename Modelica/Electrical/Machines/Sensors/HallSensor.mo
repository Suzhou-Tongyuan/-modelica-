within Modelica.Electrical.Machines.Sensors;
model HallSensor "霍尔传感器"
  import Modelica.Constants.pi;
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  parameter Integer p(final min=1, start=2) "极对数";
  parameter SI.Angle phi0=-pi/p "初始机械角度";
  Modelica.Blocks.Interfaces.RealOutput y(
    quantity="Angle", 
    final unit="rad", 
    displayUnit="deg") "\"电气角\"" 
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
equation
  flange.tau=0;
  y=rem((flange.phi - phi_support - phi0)*p, 2*pi);
   annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(extent={{-70,70},{70,-70}}, lineColor={95,95,95}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{0,0},{0,70}},  color={95,95,95}), 
        Line(points={{0,-70},{0,0}}, color={95,95,95}), 
        Line(points={{-70,0},{-100,0}}, color={95,95,95}), 
        Line(points={{100,0},{70,0}}, color={95,95,95}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          fillColor={255,255,255}, 
          textString="%name"), 
        Line(points={{0,-30},{-0.545517,38.9449}}, 
                                     color={95,95,95}, 
          origin={-26,15}, 
          rotation=60), 
        Line(points={{0,-30},{-0.545517,38.9449}}, 
                                     color={95,95,95}, 
          origin={34,-19}, 
          rotation=60), 
        Line(points={{0,-30},{0.545517,38.9449}}, 
                                     color={95,95,95}, 
          origin={26,15}, 
          rotation=-60), 
        Line(points={{0,-30},{0.545517,38.9449}}, 
                                     color={95,95,95}, 
          origin={-34,-19}, 
          rotation=-60), 
        Ellipse(extent={{-20,20},{20,-20}}, lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="rad")}), 
    Documentation(info="<html>
<p>
简单的霍尔传感器模型，即测量法兰角度(相对于可选支撑)，乘以相数p以获得电气角度，
并添加一个校正项，即法兰的初始角度phi0。
</p>
<p>
请注意，phi0必须设置为使得在轴位phi0时，相1的磁链是最大的。
</p>
</html>"));
end HallSensor;