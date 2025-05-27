within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialTwoFramesDoubleSize 
  "提供两个坐标系连接器+外部world+确保组件被连接的断言的基础模型(默认图标大小为常规的两倍)"

  Interfaces.Frame_a frame_a "固定在组件上的坐标系，带有一个局部力和局部力矩" annotation(Placement(transformation(extent = {{-108, -8}, {-92, 8}})));
  Interfaces.Frame_b frame_b "固定在组件上的坐标系，带有一个局部力和局部力矩" annotation(Placement(transformation(extent = {{92, -8}, {108, 8}})));

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
    extent = {{-100, -100}, {100, 100}}, 
    initialScale = 0.2), graphics = {Text(
    extent = {{-117, -13}, {-106, -23}}, 
    textColor = {128, 128, 128}, 
    textString = "a"), Text(
    extent = {{110, -15}, {122, -25}}, 
    textColor = {128, 128, 128}, 
    textString = "b")}), 
    Documentation(info = "<html>
<p>
这个部分模型提供两个坐标系连接器，world对象访问和一个断言来检查两个坐标系连接器是否被连接。
因此，如果需要两个坐标系连接器，并且两个坐标系连接器应该连接以确保模型正确，则从该部分模型继承。
</p>
<p>
当拖动 \"PartialTwoFrames\"时，其默认大小是通常大小的两倍。
该部分模型被关节装配体模型Joint.Assemblies所使用。
</p>
</html>"));
end PartialTwoFramesDoubleSize;