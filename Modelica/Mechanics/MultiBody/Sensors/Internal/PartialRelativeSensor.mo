within Modelica.Mechanics.MultiBody.Sensors.Internal;
partial model PartialRelativeSensor 
  "相对传感器模型的基类"
  extends Modelica.Icons.RoundSensor;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "坐标系a" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b 
    "坐标系b" annotation (Placement(
        transformation(extent={{84,-16},{116,16}})));

equation
  assert(cardinality(frame_a) > 0, "连接器frame_a必须至少连接一次");
  assert(cardinality(frame_b) > 0, "连接器frame_b必须至少连接一次");
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
          points={{60,36},{60,36},{60,80},{95,80}}, 
          pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
这是一个具有两个坐标系<strong>frame_a</strong>和<strong>frame_b</strong>的三维机械组件的基类，用于测量这两个连接器之间的相对量。
这个部分类可以用于由组件或方程式定义的传感器。
</p>
</html>"));
end PartialRelativeSensor;