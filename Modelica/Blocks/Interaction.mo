within Modelica.Blocks;
package Interaction 
  "用户交互模块库，用于在图表动画中输入和显示变量"
  extends Modelica.Icons.Package;

  package Show "在图示动画中显示变量的模块库"
    extends Modelica.Icons.Package;

    block RealValue 
      "在图表层动态显示来自numberPort或数字输入栏的实数值"
      parameter Boolean use_numberPort = true "= true，当启用了numberPort" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      input Real number = 0.0 
        "当use_numberPort=false，则数字是可视化的(随时间变化)" 
        annotation(Dialog(enable = not use_numberPort), HideResult = true);
      parameter Integer significantDigits(min = 1) = 2 
        "显示的有效数字个数";

      Modelica.Blocks.Interfaces.RealInput numberPort if use_numberPort 
        "当use_numberPort=true，图表层中要显示编号" 
        annotation(HideResult = true, Placement(transformation(extent = {{-130, -15}, {-100, 15}})));
      Modelica.Blocks.Interfaces.RealOutput showNumber;
    equation
      if use_numberPort then
        connect(numberPort, showNumber);
      else
        showNumber = number;
      end if;

      annotation(Icon(
        coordinateSystem(preserveAspectRatio = false, 
        extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
        graphics = {
        Rectangle(lineColor = {0, 0, 127}, 
        fillColor = {236, 233, 216}, 
        fillPattern = FillPattern.Solid, 
        lineThickness = 5.0, 
        borderPattern = BorderPattern.Raised, 
        extent = {{-100.0, -40.0}, {100.0, 40.0}}), 
        Text(extent = {{-94.0, -34.0}, {96.0, 34.0}}, 
        textString = DynamicSelect("0.0", String(showNumber, significantDigits = significantDigits))), 
        Text(visible = not use_numberPort, 
        extent = {{-150.0, -70.0}, {150.0, -50.0}}, 
        textString = "%number")}), Documentation(info="<html><p>
本模块通过图表动画将实数可视化。 可通过以下方式定义要可视化的数字：
</p>
<ul><li>
当useNumberPort=true(默认值)，则会出现一个实数输入值， 并显示该输入变量。</li>
<li>
如果useNumberPort=<strong>false</strong>， 则不会出现输入连接器，而是在参数菜单中激活一个实数输入栏， 并显示该输入菜单中的实数表达式。</li>
</ul><p>
本模块的两个版本如下图所示 (在右边的变体中，变量值名称也显示在图标下方)：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/Show/RealValue.png\" alt=\"RealValue.png\" data-href=\"\" style=\"\">
</p>
<p>
演示用法，例如示例 <a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\" target=\"\">Modelica.Blocks.Examples.RealNetwork1</a>
</p>
</html>"  ));
    end RealValue;

    block IntegerValue 
      "在图表层中动态显示来自numberPort或数字输入字段的整数值"
      parameter Boolean use_numberPort = true "=true，当启用了numberPort" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      input Integer number = 0 
        "如果use_numberPort=false，则数字是可视化的(随时间变化)" 
        annotation(Dialog(enable = not use_numberPort), HideResult = true);
      Modelica.Blocks.Interfaces.IntegerInput numberPort if use_numberPort 
        "如果use_numberPort=true，则图表层中要显示编号" 
        annotation(HideResult = true, Placement(transformation(extent = {{-130, -15}, {-100, 15}})));
      Modelica.Blocks.Interfaces.IntegerOutput showNumber;
    equation
      if use_numberPort then
        connect(numberPort, showNumber);
      else
        showNumber = number;
      end if;

      annotation(Icon(
        coordinateSystem(preserveAspectRatio = false, 
        extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
        graphics = {
        Rectangle(lineColor = {0, 0, 127}, 
        fillColor = {236, 233, 216}, 
        fillPattern = FillPattern.Solid, 
        lineThickness = 5.0, 
        borderPattern = BorderPattern.Raised, 
        extent = {{-100.0, -40.0}, {100.0, 40.0}}), 
        Text(extent = {{-94.0, -34.0}, {96.0, 34.0}}, 
        textString = DynamicSelect("0", String(showNumber))), 
        Text(visible = not use_numberPort, 
        extent = {{-150.0, -70.0}, {150.0, -50.0}}, 
        textString = "%number")}), Documentation(info="<html><p>
本模块在图表动画中将整数可视化。 可通过以下方式定义要可视化的数字：
</p>
<ul><li>
当useNumberPort=true(默认值)，则会出现整数输入值，并显示该输入变量。</li>
<li>
当useNumberPort=false，则不会出现输入连接器。 取而代之的是在参数菜单中激活一个整数输入域， 并显示该输入菜单中的整数表达式。</li>
</ul><p>
本模块的两个版本如下图所示 (在右边的变体中，变量值名称也显示在图标下方)：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/Show/IntegerValue.png\" alt=\"IntegerValue.png\" data-href=\"\" style=\"\">
</p>
<p>
演示用法，例如示例 <a href=\"modelica://Modelica.Blocks.Examples.IntegerNetwork1\" target=\"\">Modelica.Blocks.Examples.IntegerNetwork1</a>。
</p>
</html>"  ));
    end IntegerValue;

    block BooleanValue 
      "在图表层动态显示来自numberPort或数字输入框的布尔值"
      parameter Boolean use_activePort = true "=true，当activePort已启用" 
        annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
      input Boolean active = false 
        "布尔变量显示use_activePort=false(随时间变化)" 
        annotation(Dialog(enable = not use_activePort), HideResult = true);
      Modelica.Blocks.Interfaces.BooleanInput activePort if use_activePort 
        "当use_activePort=true，图层中将显示布尔变量" 
        annotation(HideResult = true, Placement(transformation(extent = {{-130, -15}, {-100, 15}})));

      Modelica.Blocks.Interfaces.BooleanOutput showActive;
    equation
      if use_activePort then
        connect(activePort, showActive);
      else
        showActive = active;
      end if;

      annotation(Icon(
        coordinateSystem(preserveAspectRatio = false, 
        extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
        graphics = {
        Text(visible = not use_activePort, 
        extent = {{-188.0, -80.0}, {62.0, -60.0}}, 
        textString = "%active"), 
        Ellipse(lineColor = {64, 64, 64}, 
        fillColor = DynamicSelect({192, 192, 192}, if showActive then {0, 255, 0} else {235, 235, 235}), 
        pattern = LinePattern.None, 
        fillPattern = FillPattern.Sphere, 
        extent = {{-100.0, -40.0}, {-20.0, 40.0}})}), Documentation(info="<html><p>
本模块在图表动画中显示一个布尔变量。 要可视化的布尔变量可以通过以下方式定义:
</p>
<li>
当useActivePort = true(这是默认值)，则会显示一个布尔输入并显示这个输入变量。</li>
<li>
如果useActivePort=false，则没有输入连接器存在。 相反，参数菜单中会激活一个布尔输入字段 ，并显示该输入菜单中的布尔表达式。</li>
<p>
如果布尔变量为<strong>false</strong>， 则模块为\"灰\"，否则为\"绿\"。 本模块的两个版本如下图所示(在右边的变体中，变量值名称也显示在图标下方)：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Interaction/Show/BooleanValue.png\" alt=\"BooleanValue.png\" data-href=\"\" style=\"\">
</p>
<p>
演示用法，例如示例 <a href=\"modelica://Modelica.Blocks.Examples.BooleanNetwork1\" target=\"\">Modelica.Blocks.Examples.BooleanNetwork1</a>&nbsp;。
</p>
</html>"));
    end BooleanValue;
    annotation(Documentation(info="<html><p>
<br>
</p>
</html>"      ));
  end Show;
  annotation(Icon(graphics = {Text(
    extent = {{-98, -30}, {96, 34}}, 
    textString = "0")}));
end Interaction;