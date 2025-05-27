within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialElementaryJoint 
  "用于运动副的基础模型(具有两个坐标系+外部world+确保运动副已被连接的断言)"

  Interfaces.Frame_a frame_a "固定在运动副上的坐标系，带有一个局部力和局部力矩" annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b "固定在运动副上的坐标系，带有一个局部力和局部力矩" annotation (Placement(transformation(extent={{84,-16},{116,16}})));

protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  Connections.branch(frame_a.R, frame_b.R);
  assert(cardinality(frame_a) > 0, 
    "运动副对象的连接器frame_a未被连接");
  assert(cardinality(frame_b) > 0, 
    "运动副对象的连接器frame_b未被连接");
  annotation (Documentation(info="<html>
<p>
所有<strong>基本运动副</strong>都应该从这个基础模型继承，即直接由方程定义的运动副。
这个运动副成立的条件是它们可以从frame_a的旋转对象和相对量(或反之亦然)计算frame_b的旋转对象，或者在两个坐标系的旋转对象之间存在约束方程。
另一种情况，运动副对象应该继承自<strong>Interfaces.PartialTwoFrames</strong>(例如，球副Spherical，因为frame_a和frame_b的旋转对象之间没有约束，或圆柱副Cylindrical，因为它不是基本运动副)。
</p>
<p>
这个部分模型提供了两个坐标系连接器，用于frame_a和frame_b之间的\"Connections.branch\"，对world对象的访问，以及用于检查两个坐标系是否被连接的断言。
</p>
</html>"));
end PartialElementaryJoint;