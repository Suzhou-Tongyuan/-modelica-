within Modelica.Blocks;
package Icons "模块图标"
  extends Modelica.Icons.IconsPackage;
  partial block Block "输入/输出模块的基本图形布局"

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
      100, 100}}), graphics = {Rectangle(
      extent = {{-100, -100}, {100, 100}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), 
      Documentation(info = "<html>
<p>
只有输入/输出块基本图标(无声明、无方程)的模块。
Modelica.Blocks包中的大多数模块都直接或间接继承自此模块。
</p>
</html>"  ));

  end Block;

  partial block BooleanBlock "布尔模块的基本图形布局"

    annotation(
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
      100, 100}}), graphics = {Rectangle(
      extent = {{-100, -100}, {100, 100}}, 
      lineColor = {255, 0, 255}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), 
      Documentation(info = "<html>
<p>
仅包含输入/输出的基本图标的布尔模块(无声明、无方程)。
</p>
</html>"  ));

  end BooleanBlock;

  partial block DiscreteBlock 
    "离散模块组件图标的图形布局"

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Rectangle(
      extent = {{-100, -100}, {100, 100}}, 
      lineColor = {0, 0, 127}, 
      fillColor = {223, 211, 169}, 
      borderPattern = BorderPattern.Raised, 
      fillPattern = FillPattern.Solid), Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), 
      Documentation(info = "<html>
<p>
一个仅包含基本输入/输出图标的离散模块(无声明，无方程)，
比如Blocks.Discrete。
</p>
</html>"));
  end DiscreteBlock;

  partial block IntegerBlock "整数模块的基本图形布局"

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Rectangle(
      extent = {{-100, -100}, {100, 100}}, 
      lineColor = {255, 127, 0}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), 
      Documentation(info = "<html>
<p>
一个仅包含基本输入/输出图标的整数模块(无声明，无方程)。
</p>
</html>"));
  end IntegerBlock;

  partial block PartialBooleanBlock "逻辑模块的基本图形布局"

    annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Rectangle(
      extent = {{-100, 100}, {100, -100}}, 
      fillColor = {210, 210, 210}, 
      fillPattern = FillPattern.Solid, 
      borderPattern = BorderPattern.Raised), Text(
      extent = {{-150, 150}, {150, 110}}, 
      textString = "%name", 
      textColor = {0, 0, 255})}), Documentation(info = "<html>
<p>
一个仅包含基本输入/输出图标的布尔模块(无声明，无方程)， 
尤其使用于Blocks.Logical库。
</p>
</html>"  ));
  end PartialBooleanBlock;
  annotation();
end Icons;