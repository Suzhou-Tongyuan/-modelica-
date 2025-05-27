within Modelica.Mechanics.MultiBody.Sensors.Internal;
model PartialRelativeBaseSensor 
   "由方程定义的相对传感器模型的基类(frame_resolve必须恰好连接一次)"
  extends Modelica.Icons.RoundSensor;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "坐标系a(测量位于frame_a和frame_b之间)" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b 
     "坐标系b(测量位于frame_a和frame_b之间)"  annotation (Placement(
        transformation(extent={{84,-16},{116,16}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve 
    "可选地解析矢量的坐标系" 
    annotation (Placement(transformation(extent={{84,64},{116,96}})));

equation
  assert(cardinality(frame_a) > 0,  "连接器frame_a必须至少连接一次");
  assert(cardinality(frame_b) > 0, "连接器frame_b必须至少连接一次");
  assert(cardinality(frame_resolve) == 1, "连接器frame_resolve必须恰好连接一次");
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-108,43},{-72,18}}, 
          textColor={128,128,128}, 
          textString="a"), 
        Text(
          extent={{72,43},{108,18}}, 
          textColor={128,128,128}, 
          textString="b"), 
        Line(
          points={{-70,0},{-96,0},{-96,0}}), 
        Line(
          points={{96,0},{70,0},{70,0}}), 
        Line(
          points={{0,-70},{0,-100}}, 
          color={0,0,127}), 
        Line(
          points={{60,36},{60,36},{60,80},{95,80}}, 
          pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
由方程定义的相对传感器模型的部分基类。
连接器frame_resolve始终启用，必须恰好连接一次。
</p>
</html>"));
end PartialRelativeBaseSensor;