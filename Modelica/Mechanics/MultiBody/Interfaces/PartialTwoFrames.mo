within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialTwoFrames 
  "提供两个坐标系连接器+外部world+确保组件被连接的断言的组件基础模型"

  Interfaces.Frame_a frame_a "坐标系a，固定在具有一个局部力和局部力矩的组件上" annotation(Placement(transformation(extent = {{-116, -16}, {-84, 16}})));
  Interfaces.Frame_b frame_b "坐标系b，固定在具有一个局部力和局部力矩的组件上" annotation(Placement(transformation(extent = {{84, -16}, {116, 16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  assert(cardinality(frame_a) > 0, 
    "组件的连接器frame_a未被连接");
  assert(cardinality(frame_b) > 0, 
    "组件的连接器frame_b未被连接");
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Text(
    extent = {{-136, -25}, {-100, -50}}, 
    textColor = {128, 128, 128}, 
    textString = "a"), Text(
    extent = {{100, -25}, {136, -50}}, 
    textColor = {128, 128, 128}, 
    textString = "b")}), 
    Documentation(info = "<html>
<p>
这个部分模型提供两个坐标系连接器，world对象访问和一个断言来检查两个坐标系连接器是否被连接。
因此，如果需要两个坐标系连接器，并且两个坐标系连接器在正确的模型中应该被连接，请继承此部分模型。
</p>
</html>"));
end PartialTwoFrames;