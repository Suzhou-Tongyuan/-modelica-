within Modelica.Mechanics.Rotational.Components;
model Damper "线性一维转动阻尼器"
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
  parameter SI.RotationalDampingConstant d(final min = 0, start = 0) 
    "阻尼系数";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
equation
  tau = d * w_rel;
  lossPower = tau * w_rel;
  annotation(
    Documentation(info = "<html>
<p>
与<strong>速度相关的线性阻尼器</strong>元件。它可以连接在一维惯性转动组件或齿轮与轴承座（组件Fixed）之间，或者
在两个一维惯性转动组件或齿轮元件之间。
</p>

<p>
请参阅旋转库用户指南中的讨论
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>。
</p>
</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {-60, 0}}), 
    Line(points = {{-60, -30}, {-60, 30}}), 
    Line(points = {{-60, -30}, {60, -30}}), 
    Line(points = {{-60, 30}, {60, 30}}), 
    Rectangle(extent = {{-60, 30}, {30, -30}}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{30, 0}, {90, 0}}), 
    Text(extent = {{-150, 80}, {150, 40}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(extent = {{-150, -50}, {150, -90}}, 
    textString = "d=%d"), 
    Line(visible = useHeatPort, 
    points = {{-100, -100}, {-100, -40}, {-20, -40}, {-20, 0}}, 
    color = {191, 0, 0}, 
    pattern = LinePattern.Dot)}));
end Damper;