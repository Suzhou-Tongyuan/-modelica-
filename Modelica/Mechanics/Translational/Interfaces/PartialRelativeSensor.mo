within Modelica.Mechanics.Translational.Interfaces;
partial model PartialRelativeSensor 
  "测量两个一维平动接口之间单个相对变量的传感器"

  extends Modelica.Icons.RectangularSensor;
  extends Translational.Interfaces.PartialTwoFlanges;
equation
  0 = flange_a.f + flange_b.f;
  annotation(Documentation(info = "<html><p>
这是一个具有两个刚性连接一维平动接口和一个输出信号的一维平动组件的基类，用于测量两个一维平动接口之间的相对运动量或一维平动接口中的局部力，并将测量信号作为输出信号提供给Modelica.Blocks块以进行进一步处理。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {Line(points = {{-51, 34}, {29, 34}}, color = {95, 127, 95}), 
    Polygon(
    points = {{59, 34}, {29, 44}, {29, 24}, {59, 34}}, 
    fillColor = {95, 127, 95}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {95, 127, 95}), Line(points = {{-70, 0}, {-100, 0}}, color = {0, 127, 0}), 
    Line(points = {{70, 0}, {100, 0}}, color = {0, 127, 0}), 
    Text(
    extent = {{-150, 100}, {150, 60}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}));
end PartialRelativeSensor;