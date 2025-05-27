within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialOneFrame_a 
  "提供一个frame_a连接器+外部world+确保组件被连接的断言的组件基础模型"

  Interfaces.Frame_a frame_a "固定在组件上的坐标系，带有一个局部力和局部力矩" annotation(Placement(transformation(extent = {{-116, -16}, {-84, 16}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;
equation
  assert(cardinality(frame_a) > 0, 
    "组件的连接器frame_a未被连接");
  annotation(Documentation(info = "<html>
<p>
该部分模型提供了一个frame_a连接器，world对象访问和一个断言来检查frame_a连接器是否被连接。
因此，如果需要frame_a连接器，且该连接器在正确的模型中应被连接，则继承该部分模型。
</p>
</html>"));
end PartialOneFrame_a;