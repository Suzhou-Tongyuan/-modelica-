within Modelica.Electrical.Analog.Interfaces;
partial model AbsoluteSensor 
  "用于测量引脚变量绝对值的基类"

  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "电气正引脚" 
  annotation(Placement(
    transformation(extent = {{-110, -10}, {-90, 10}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "所测量量为实际输出信号"annotation(Placement(
    transformation(extent = {{100, -10}, {120, 10}})));
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-70, 0}, {-90, 0}}), 
    Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 80}, {150, 120}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-70, 0}, {-96, 0}}), 
    Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 255})}), 
    Documentation(revisions = "<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
    info = "<html>
<p>绝对传感器是一种部分模型，用于将从一个引脚计算出的值转换为实际信号值。特殊的计算必须在继承自绝对传感器的模型中进行描述。它常用于传感器设备中。为了成为一个真正的传感器，模型设计者必须确保传感器模型不会影响所要测量的电气行为。
</p>

</html>"));

end AbsoluteSensor;