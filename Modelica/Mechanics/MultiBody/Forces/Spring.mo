within Modelica.Mechanics.MultiBody.Forces;
model Spring "具有可选质量的线性平动弹簧"
  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.PartialTwoFrames;
  parameter Boolean animation = true "= true, 如需要启用动画";
  parameter Boolean showMass = true 
    "= true, 如果启用动画且m>0，则应将质点质量可视化为球体。";

  parameter SI.TranslationalSpringConstant c(final min = 0) "弹性系数";
  parameter SI.Length s_unstretched = 0 "未拉伸的弹簧长度";
  parameter SI.Mass m(min = 0) = 0 
    "位于frame_a原点和frame_b原点之间连接线上的弹簧质量";
  parameter Real lengthFraction(
    min = 0, 
    max = 1) = 0.5 
    "弹簧质量相对于frame_a的位置，是frame_a到frame_b距离的分数(=0：在frame_a；=1：在frame_b)";
  input SI.Distance width = world.defaultForceWidth "弹簧宽度" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input SI.Distance coilWidth = width / 10 "弹簧线圈宽度" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  parameter Integer numberOfWindings = 5 "弹簧圈数" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input Types.Color color = Modelica.Mechanics.MultiBody.Types.Defaults.SpringColor 
    "弹簧颜色" 
    annotation(Dialog(colorSelector = true, tab = "动画", group = "如果 animation = true", enable = animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射 (= 0: 光完全被吸收)" 
    annotation(Dialog(tab = "动画", group = "如果 animation = true", enable = animation));
  input SI.Diameter massDiameter = max(0, (width - 2 * coilWidth) * 0.9) 
    "质点球体的直径" annotation(Dialog(tab = "动画", group = 
    "如果 animation = true and showMass = true", enable = animation and showMass));
  input Types.Color massColor = Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "质点颜色t" annotation(Dialog(colorSelector = true, tab = "动画", group = 
    "如果 animation = true and showMass = true", enable = animation and showMass));
  parameter SI.Distance s_small = 1e-10 
    "如果frame_a和frame_b之间的距离为零，则防止零除法" 
    annotation(Dialog(tab = "高级"));
  parameter Boolean fixedRotationAtFrame_a = false 
    "= true, 如果固定frame_a.R的旋转 (用于直接连接线力)" 
    annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级", group = "如果启用，可能会给出错误的结果，请参阅 MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));
  parameter Boolean fixedRotationAtFrame_b = false 
    "= true, 如果固定frame_b.R的旋转 (用于直接连接线力)" 
    annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级", group = "如果启用，可能会给出错误的结果，请参阅 MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));

  SI.Position r_rel_a[3] 
    "从 frame_a 的原点到 frame_b 的原点的位置向量，在 frame_a 中解析";
  Real e_a[3](each final unit = "1") 
    "连接 frame_a 原点与 frame_b 原点的直线上的单位向量，在 frame_a 中解析(从 frame_a 指向 frame_b)";
  SI.Force f 
    "作用于 frame_a 和 frame_b 上的线性力(如果作用于 frame_b 并且指向从 frame_a 到 frame_b，则为正)";
  SI.Distance length 
    "frame_a 原点与 frame_b 原点之间的距离";
  SI.Position s 
    "frame_a 原点与 frame_b 原点之间的(保护的)距离(>= s_small)";
  SI.Position r_rel_0[3] 
    "从 frame_a 到 frame_b 的位置向量，在世界坐标系中解析";
  Real e_rel_0[3](each final unit = "1") 
    "从 frame_a 指向 frame_b 的单位向量，在世界坐标系中解析";

  Forces.LineForceWithMass lineForce(
    animateLine = animation, 
    animateMass = showMass, 
    m = m, 
    lengthFraction = lengthFraction, 
    lineShapeType = "spring", 
    lineShapeHeight = coilWidth * 2, 
    lineShapeWidth = width, 
    lineShapeExtra = numberOfWindings, 
    lineShapeColor = color, 
    specularCoefficient = specularCoefficient, 
    massDiameter = massDiameter, 
    massColor = massColor, 
    s_small = s_small, 
    fixedRotationAtFrame_a = fixedRotationAtFrame_a, 
    fixedRotationAtFrame_b = fixedRotationAtFrame_b) annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}})));
  Modelica.Mechanics.Translational.Components.Spring spring(
    s_rel0 = s_unstretched, 
    c = c) annotation(Placement(transformation(extent = {{-8, 40}, {12, 60}})));

equation
  // Results
  r_rel_a = Frames.resolve2(frame_a.R, r_rel_0);
  e_a = r_rel_a / s;
  f = spring.f;
  length = lineForce.length;
  s = lineForce.s;
  r_rel_0 = lineForce.r_rel_0;
  e_rel_0 = lineForce.e_rel_0;

  connect(lineForce.frame_a, frame_a) 
    annotation(Line(
    points = {{-20, 0}, {-100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(lineForce.frame_b, frame_b) 
    annotation(Line(
    points = {{20, 0}, {100, 0}}, 
    color = {95, 95, 95}, 
    thickness = 0.5));
  connect(spring.flange_b, lineForce.flange_b) 
    annotation(Line(points = {{12, 50}, {12, 20}}, color = {0, 191, 0}));
  connect(spring.flange_a, lineForce.flange_a) 
    annotation(Line(points = {{-8, 50}, {-12, 50}, {-12, 20}}, color = {0, 191, 0}));

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
    graphics = {
    Line(
    points = {{-100, 0}, {-58, 0}, {-43, -30}, {-13, 30}, {17, -30}, {47, 30}, {62, 0}, 
    {100, 0}}), 
    Text(
    extent = {{-150, 56}, {150, 96}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Text(
    extent = {{-150, -80}, {150, -50}}, 
    textString = "c=%c"), 
    Ellipse(
    extent = {{-8, 8}, {8, -8}}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(visible = fixedRotationAtFrame_a, extent = {{-70, 30}, {-130, -30}}, lineColor = {255, 0, 0}), 
    Text(visible = fixedRotationAtFrame_a, 
    extent = {{-62, 50}, {-140, 30}}, 
    textColor = {255, 0, 0}, 
    textString = "R=0"), 
    Ellipse(visible = fixedRotationAtFrame_b, extent = {{70, 30}, {130, -30}}, lineColor = {255, 0, 0}), 
    Text(visible = fixedRotationAtFrame_b, 
    extent = {{62, 50}, {140, 30}}, 
    textColor = {255, 0, 0}, 
    textString = "R=0")}), 
    Documentation(info = "<html>
<p>
<strong>线性弹簧</strong>作为frame_a和frame_b之间的线性力。
根据以下方程，在frame_b的原点施加<strong>力f</strong>，并且在从frame_a到frame_b的线上，在frame_a的原点上施加相反符号的力：
</p>
<blockquote><pre>
f = c*(s - s_unstretched);
</pre></blockquote>
<p>
其中\"c\"和\"s_unstretched\"是参数，\"s\"是frame_a的原点与frame_b的原点之间的距离。
</p>
<p>
可选地，通过位于frame_a和frame_b之间的线上的一个点质量来考虑弹簧的质量(默认：在线段的中间)。如果弹簧质量为零，则移除处理质量的额外方程。
</p>
<p>
在下图中，显示了弹簧的典型动画。弹簧中间的蓝色球体表示点质量的位置。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringWithMass.png\"
alt=\"model Examples.Elementary.SpringWithMass\">
</div>

</html>"));
end Spring;