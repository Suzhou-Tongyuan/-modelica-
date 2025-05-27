within Modelica.Electrical.Analog.Interfaces;
partial model RelativeSensor 
  "用于测量两个引脚之间相对变量的基类"

  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "电气正引脚" annotation(Placement(
    transformation(extent = {{-110, -10}, {-90, 10}})));
  Interfaces.NegativePin n "电气负引脚" annotation(Placement(
    transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "测量量作为实数输出信号" 
    annotation(Placement(
    transformation(
    origin = {0, -100}, 
    extent = {{10, -10}, {-10, 10}}, 
    rotation = 90)));
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-70, 0}, {-90, 0}}), 
    Line(points = {{70, 0}, {90, 0}}), 
    Line(points = {{0, -90}, {0, -70}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 80}, {150, 120}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-70, 0}, {-96, 0}}), 
    Line(points = {{0, -90}, {0, -70}}, color = {0, 0, 255}), 
    Line(points = {{70, 0}, {96, 0}})}), 
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>

<p>RelativeSensor 是一种部分模型，用于将可从两个引脚计算出的值转换为实数值信号。由于建模基于RelativeSensor，其特殊的计算必须在继承RelativeSensor的模型中描述。它常用于传感器设备中。为了成为一个真正的传感器，建模者必须确保传感器模型不会影响要测量的电气行为。
</p>

</html>"));
end RelativeSensor;