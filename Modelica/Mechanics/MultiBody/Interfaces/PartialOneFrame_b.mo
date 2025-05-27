within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialOneFrame_b 
  "提供一个frame_b连接器+外部world+确保组件被连接的断言的组件基础模型"

  Interfaces.Frame_b frame_b "固定在组件上的坐标系，带有一个局部力和局部力矩" annotation(Placement(transformation(extent = {{84, -16}, {116, 16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  assert(cardinality(frame_b) > 0, 
    "组件的连接器frame_b未被连接");
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Text(
    extent = {{94, -20}, {130, -45}}, 
    textColor = {128, 128, 128}, 
    textString = "b")}), 
    Documentation(info = "<html>
<p>
该部分模型提供了一个frame_b连接器，world对象访问和一个断言来检查frame_b连接器是否被连接。
因此，如果需要frame_b连接器，且该连接器在正确的模型中应被连接，则继承该部分模型。
</p>
</html>"));
end PartialOneFrame_b;