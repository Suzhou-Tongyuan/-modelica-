within Modelica.Mechanics.MultiBody.Sensors.Internal;
partial model PartialAbsoluteSensor "绝对传感器模型的基类"
  extends Modelica.Icons.RoundSensor;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "测量绝对运动量的坐标系a" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));

equation
  assert(cardinality(frame_a) > 0, "连接器frame_a必须至少连接一次");

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, 
          extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-108,43},{-72,18}}, 
          textColor={128,128,128}, 
          textString="a"), Line(
          points={{-70,0},{-96,0},{-96,0}})}), Documentation(info="<html>
<p>
这是一个具有一个名为<strong>frame_a</strong>的三维机械组件的基类，用于测量该连接器的绝对量。
这个部分类可以用于由组件或方程式定义的传感器。
</p>
</html>"));
end PartialAbsoluteSensor;