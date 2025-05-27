within Modelica.ComplexBlocks.Sources;
block ComplexExpression "将输出信号设置为随时间变化的复数表达式"

  Modelica.ComplexBlocks.Interfaces.ComplexOutput y = Complex(0) 
    "复数输出值" annotation(Dialog(group = "时变输出信号"), 
    Placement(transformation(extent = {{100, -10}, {120, 10}})));

  annotation(defaultComponentName = "complexExpr", 
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, 
    -100}, {100, 100}}), graphics = {Rectangle(
    extent = {{-100, 40}, {100, -40}}, 
    lineThickness = 5.0, 
    fillColor = {235, 235, 235}, 
    fillPattern = FillPattern.Solid, 
    borderPattern = BorderPattern.Raised), Text(
    extent = {{-96, 15}, {96, -15}}, 
    textString = "%y"), Text(
    extent = {{-150, 90}, {140, 50}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), Documentation(info = "<html>
<p>
该模块的(时间变化的)复数输出信号可以通过其参数菜单中的变量 <strong>y</strong> 来定义。
其目的是支持在模块图中轻松定义复杂表达式。
请注意，“time”是一个内置变量，始终可访问，代表“model time”，
</p>
</html>"));

end ComplexExpression;