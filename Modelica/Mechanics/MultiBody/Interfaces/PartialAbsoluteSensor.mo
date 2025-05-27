within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialAbsoluteSensor 
  "用于测量绝对坐标系变量的基础模型"
  extends Modelica.Icons.RoundSensor;
  parameter Integer n_out = 1 "输出信号数量";
  Interfaces.Frame_a frame_a "用于提供绝对量作为输出信号的坐标系" annotation(Placement(transformation(extent = {{-116, -16}, {-84, 16}})));

  Modelica.Blocks.Interfaces.RealOutput y[n_out] 
    "作为信号向量的测量数据" 
    annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
protected
  outer Modelica.Mechanics.MultiBody.World world;

equation
  assert(cardinality(frame_a) > 0, 
    "绝对传感器对象的连接器frame_a未被连接");
  annotation(
    Documentation(info = "<html>
<p>
这是一个带有一个坐标系和一个输出端口的三维力学组件的基类，
用于在坐标系连接器中测量绝对量，并将测量信号作为输出，
以便与Modelica.Blocks包中的模块进一步处理。
</p>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-70, 0}, {-100, 0}}), 
    Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-132, -125}, {131, -79}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end PartialAbsoluteSensor;