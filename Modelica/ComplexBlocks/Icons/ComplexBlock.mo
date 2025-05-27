within Modelica.ComplexBlocks.Icons;
partial block ComplexBlock "复数输入/输出模块的基本图形布局"
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
    100, 100}}), graphics = {Rectangle(
    extent = {{-100, -100}, {100, 100}}, 
    lineColor = {85, 170, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255})}), 
    Documentation(info = "<html>
<p>
该模块仅包含复数输入/输出模块的基本图标(没有声明，没有方程)。Modelica.ComplexBlocks包的大多数模块直接或间接继承自此模块。
</p>
</html>"));
end ComplexBlock;