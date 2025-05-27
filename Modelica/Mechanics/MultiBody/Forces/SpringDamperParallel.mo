within Modelica.Mechanics.MultiBody.Forces;
model SpringDamperParallel "并联连接的线性弹簧和线性阻尼器"
  import Modelica.Mechanics.MultiBody.Types;
  parameter Boolean animation = true "= true，如果要启用动画";
  parameter SI.TranslationalSpringConstant c(final min = 0) "弹簧常数";
  parameter SI.Length s_unstretched = 0 "未拉伸弹簧长度";
  parameter SI.TranslationalDampingConstant d(final min = 0) = 0 
    "阻尼常数";
  parameter SI.Distance length_a = world.defaultForceLength 
    "在frame_a侧的阻尼圆柱体长度" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input SI.Diameter diameter_a = world.defaultForceWidth 
    "在frame_a侧的阻尼圆柱体直径" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input SI.Diameter diameter_b = 0.6 * diameter_a 
    "在frame_b侧的阻尼圆柱体直径" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input Types.Color color_a = {100, 100, 100} "frame_a处的阻尼圆柱体颜色" 
    annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animation = true", enable = animation));
  input Types.Color color_b = {155, 155, 155} "frame_b处的阻尼圆柱体颜色" 
    annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animation = true", enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射 (= 0: 光完全被吸收)" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input SI.Distance width = world.defaultForceWidth "弹簧宽度" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input SI.Distance coilWidth = width / 10 "弹簧线圈宽度" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  parameter Integer numberOfWindings = 5 "弹簧的线圈数" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input Types.Color color = Modelica.Mechanics.MultiBody.Types.Defaults.SpringColor 
    "弹簧颜色" 
    annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animation = true", enable = animation));
  extends Interfaces.PartialLineForce;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
    final T = 293.15);

protected
  SI.Force f_d "阻尼力";
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
    r_shape = e_a * noEvent(min(length_a, s)), 
    r = frame_a.r_0, 
    R = frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape(
    shapeType = "spring", 
    color = color, 
    specularCoefficient = specularCoefficient, 
    length = s, 
    width = width, 
    height = coilWidth * 2, 
    lengthDirection = e_a, 
    widthDirection = {0, 1, 0}, 
    extra = numberOfWindings, 
    r = frame_a.r_0, 
    R = frame_a.R) if world.enableAnimation and animation;
equation
  f_d = d * der(s);
  f = c * (s - s_unstretched) + f_d;
  lossPower = f_d * der(s);
  annotation(
    Documentation(info = "<html>
<p>
  <strong>线性弹簧</strong>和<strong>线性阻尼器</strong>并联，作为frame_a和frame_b之间的线性力作用。
  在frame_b的原点上施加一个<strong>力f</strong>，并在frame_a的原点上施加相反符号的力，沿着从frame_a原点到frame_b原点的线段，根据以下方程计算：
</p>
<blockquote>
  <pre>
f = c*(s - s_unstretched) + d*<strong>der</strong>(s);
  </pre>
</blockquote>
<p>
  其中\"c\"、\"s_unstretched\"和\"d\"是参数，\"s\"是frame_a原点到frame_b原点之间的距离，der(s)是s的时间导数。
</p>
</html>"), 
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Text(
    extent = {{-150, -150}, {150, -110}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(points = {{-80, 40}, {-60, 40}, {-45, 10}, {-15, 70}, {15, 10}, {45, 70}, {60, 
    40}, {80, 40}}), 
    Line(points = {{-80, 40}, {-80, -70}}), 
    Line(points = {{-80, -70}, {-52, -70}}), 
    Rectangle(
    extent = {{-52, -40}, {38, -100}}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-52, -40}, {68, -40}}), 
    Line(points = {{-52, -100}, {68, -100}}), 
    Line(points = {{38, -70}, {80, -70}}), 
    Line(points = {{80, 40}, {80, -70}}), 
    Line(points = {{-100, 0}, {-80, 0}}), 
    Line(points = {{80, 0}, {100, 0}}), 
    Text(
    extent = {{-150, 70}, {150, 100}}, 
    textString = "d=%d"), 
    Line(visible = useHeatPort, 
    points = {{-100, -101}, {-100, -80}, {-6, -80}}, 
    color = {191, 0, 0}, 
    pattern = LinePattern.Dot), 
    Text(
    extent = {{-150, 105}, {150, 135}}, 
    textString = "c=%c")}));
end SpringDamperParallel;