within Modelica.Clocked.BooleanSignals.Sampler.Utilities;
block UpSample 
  "对时钟驱动的布尔输入信号进行上采样，并将其作为时钟驱动的输出信号提供。"
  parameter Boolean inferFactor = true 
    "= true，如果上采样因子是推导出来的" annotation(Evaluate = true, choices(checkBox = true));
  parameter Integer factor(min = 1) = 1 
    "上采样因子 >= 1（如果inferFactor=false）" annotation(Evaluate = true, Dialog(enable = not inferFactor));
  Modelica.Blocks.Interfaces.BooleanInput 
    u "时钟布尔输入信号的连接器" 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.BooleanOutput 
    y "时钟布尔输出信号的连接器(y的时钟比u的时钟快)" 
    annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
protected
  Boolean dummy annotation(HideResult = true);
  Boolean b(start = false);
  Boolean b_super(start = false);
  Boolean u_super;
equation
  when Clock() then  // u的时钟
    dummy = u;
    b = not previous(b);
  end when;

  when Clock() then  // y的时钟
    b_super = superSample(b);
    if inferFactor then
      u_super = superSample(u);
    else
      u_super = superSample(u, factor);
    end if;
    y = if b_super <> previous(b_super) then u_super else false;
  end when;

  annotation(
    defaultComponentName = "upSample1", 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}, 
    initialScale = 0.06), 
    graphics = {
    Line(
    points = {{-78, -60}, {40, -60}, {40, 0}, {40, 0}}, 
    color = {215, 215, 215}, 
    pattern = LinePattern.Dot), Line(points = {{-80, -60}, {-40, -60}, {-40, -60}, {-40, 0}, 
    {-40, 0}, {0, 0}, {40, 0}, {40, 80}, {40, 80}, {40, 80}, {80, 80}, {80, 0}, {80, 0}, 
    {100, 0}}, color = {255, 0, 255}, 
    pattern = LinePattern.Dot), Line(
    points = {{-80, -60}, {-80, 0}, {-100, 0}}, 
    color = {255, 0, 255}, 
    pattern = LinePattern.Dot), 
    Text(
    extent = {{-200, 175}, {200, 110}}, 
    textColor = {0, 0, 255}, 
    textString = "%name"), 
    Ellipse(
    extent = {{-95, -45}, {-65, -75}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-83, -57}, {-77, -63}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 0, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{25, 96}, {55, 66}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{37, 83}, {43, 77}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 0, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-55, 16}, {-25, -14}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-6, 16}, {24, -14}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{64, 16}, {94, -14}}, 
    lineColor = {255, 0, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(visible = not inferFactor, 
    extent = {{-200, -80}, {200, -145}}, 
    textString = "%factor"), 
    Line(
    points = {{80, 80}, {120, 80}}, 
    color = {215, 215, 215}, 
    pattern = LinePattern.Dot), 
    Polygon(
    points = {{25, 0}, {5, 20}, {5, 10}, {-25, 10}, {-25, -10}, {5, -10}, {5, -20}, 
    {25, 0}}, 
    fillColor = {95, 95, 95}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {95, 95, 95}, 
    origin = {-71, 52}, 
    rotation = 90)}), 
    Documentation(info = "<html>
<p>
这个布尔信号块的工作原理类似于对应的实数信号块（见 
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\">RealSignals.Sampler.Utilities.UpSample</a>）。
</p>
<p>
类似于对应的实数信号块示例，存在一个关于这个布尔块的基本 
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.UpSample\">示例</a>。
</p>
</html>"));
end UpSample;