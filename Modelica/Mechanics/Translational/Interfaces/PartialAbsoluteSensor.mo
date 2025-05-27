within Modelica.Mechanics.Translational.Interfaces;
partial model PartialAbsoluteSensor 
  "单个绝对一维平动接口变量的测量传感器"

  extends Modelica.Icons.RectangularSensor;

  Interfaces.Flange_a flange 
    "要测量的一维平动接口(一维平动接口轴向切平面，例如从左到右)" 
    annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));

equation
  0 = flange.f;
  annotation(Documentation(info = "<html><p>
这是一个具有一个一维平动接口和一个输出信号的一维平动组件的基类，用于测量一维平动接口中的绝对运动量，并将测量信号作为输出信号提供给Modelica.Blocks块以进行进一步处理。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {Line(points = {{-100, -90}, {-20, -90}}, color = {95, 127, 95}), 
    Polygon(
    points = {{10, -90}, {-20, -80}, {-20, -100}, {10, -90}}, 
    lineColor = {95, 127, 95}, 
    fillColor = {95, 127, 95}, 
    fillPattern = FillPattern.Solid), Line(points = {{-70, 0}, {-100, 0}}, color = {0, 127, 0}), 
    Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 127}), 
    Text(
    extent = {{-150, 80}, {150, 40}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end PartialAbsoluteSensor;