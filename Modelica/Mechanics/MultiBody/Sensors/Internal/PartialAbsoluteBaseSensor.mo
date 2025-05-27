within Modelica.Mechanics.MultiBody.Sensors.Internal;
model PartialAbsoluteBaseSensor 
  "由方程式定义的绝对传感器模型的基类(frame_resolve必须连接一次)"
  extends Modelica.Icons.RoundSensor;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "测量运动量的坐标系" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve 
    "用于可选地解析输出矢量的坐标系" 
    annotation (Placement(transformation(extent={{-16,-16},{16,16}}, 
        rotation=-90, 
        origin={0,-100})));

equation
  assert(cardinality(frame_a) > 0, "连接器frame_a必须至少连接一次");
  assert(cardinality(frame_resolve) == 1, "连接器frame_resolve必须恰好连接一次");
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-108,43},{-72,18}}, 
          textColor={95,95,95}, 
          textString="a"), 
        Line(
          points={{-70,0},{-96,0},{-96,0}}), 
        Line(
          points={{0,15},{0,-15}}, 
          color={0,0,127}, 
          origin={85,0}, 
          rotation=90), 
        Line(
          points={{0,-95},{0,-95},{0,-70},{0,-70}}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{0,-75},{131,-100}}, 
          textColor={95,95,95}, 
          textString="resolve")}), Documentation(info="<html>
<p>
由方程式定义的绝对传感器模型的部分基类。
连接器frame_resolve始终启用，必须恰好连接一次。
</p>
</html>"));
end PartialAbsoluteBaseSensor;