within Modelica.Mechanics.MultiBody.Forces;
model Damper "线性(速度相关)阻尼器"
  import Modelica.Mechanics.MultiBody.Types;
  parameter Boolean animation = true "= true，如果要启用动画";
  parameter SI.TranslationalDampingConstant d(final min = 0, start = 0) 
    "阻尼常数";
  parameter SI.Distance length_a = world.defaultForceLength 
    "frame_a 侧圆柱的长度" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true ", enable = animation));
  input SI.Diameter diameter_a = world.defaultForceWidth 
    "frame_a 侧圆柱的直径" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true ", enable = animation));
  input SI.Diameter diameter_b = 0.6 * diameter_a 
    "frame_b 侧圆柱的直径" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true ", enable = animation));
  input Types.Color color_a = {100, 100, 100} "frame_a 的颜色" 
    annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animation = true ", enable = animation));
  input Types.Color color_b = {155, 155, 155} "frame_b 的颜色" 
    annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animation = true ", enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射 (= 0: 光完全被吸收)" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true ", enable = animation));
  extends Interfaces.PartialLineForce;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
    final T = 293.15);

protected
  SI.Position r0_b[3] = e_a * noEvent(min(length_a, s));
  Visualizers.Advanced.Shape shape_a(
    shapeType = "cylinder", 
    color = color_a, 
    specularCoefficient = specularCoefficient, 
    length = noEvent(min(length_a, s)), 
    width = diameter_a, 
    height = diameter_a, 
    lengthDirection = e_a, 
    widthDirection = {0, 1, 0}, 
    r = frame_a.r_0, 
    R = frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_b(
    shapeType = "cylinder", 
    color = color_b, 
    specularCoefficient = specularCoefficient, 
    length = noEvent(max(s - length_a, 0)), 
    width = diameter_b, 
    height = diameter_b, 
    lengthDirection = e_a, 
    widthDirection = {0, 1, 0}, 
    r_shape = r0_b, 
    r = frame_a.r_0, 
    R = frame_a.R) if world.enableAnimation and animation;
equation
  f = d * der(s);
  lossPower = f * der(s);
  annotation(
    Documentation(info = "<html>
<p>
  <strong>线性阻尼器</strong>作为frame_a和frame_b之间的线性力。根据以下方程式，<strong>力f</strong>在frame_b的原点上施加，在frame_a的原点上以相反的符号沿着从frame_a的原点到frame_b的原点的直线上施加：
</p>
<blockquote><pre>
f = d*<strong>der</strong>(s);
</pre></blockquote>
<p>
  其中\"d\"是一个参数，\"s\"是frame_a的原点和frame_b的原点之间的距离，
  而der(s)是\"s\"的时间导数。
</p>
<p>
  在下图中，显示了一个典型的动画，
  其中一个质量悬挂在一个阻尼器上。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Damper.png\">
</div>

</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-101, 0}, {-60, 0}}), 
    Line(points = {{-60, -30}, {-60, 30}}), 
    Line(points = {{-60, -30}, {60, -30}}), 
    Line(points = {{-60, 30}, {60, 30}}), 
    Rectangle(
    extent = {{-60, 30}, {30, -30}}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{30, 0}, {100, 0}}), 
    Text(
    extent = {{-150, 50}, {150, 90}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(
    extent = {{-150, -75}, {150, -45}}, 
    textString = "d=%d"), 
    Line(visible = useHeatPort, 
    points = {{-100, -99}, {-100, -25}, {-10, -25}}, 
    color = {191, 0, 0}, 
    pattern = LinePattern.Dot)}));
end Damper;