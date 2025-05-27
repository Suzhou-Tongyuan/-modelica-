within Modelica.Mechanics.MultiBody.Interfaces;
partial model LineForceBase "用于线性力元素的基础模型"
  extends PartialTwoFrames;
  parameter SI.Distance s_small = 1e-10 
    "如果frame_a和frame_b之间的距离为零，则防止零除法" 
    annotation(Dialog(tab = "高级"));
  parameter Boolean fixedRotationAtFrame_a = false 
    "= true，如果旋转frame_a.R固定(直接连接线性力)" 
    annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级", group = "如果启用，可能会导致错误结果，请参阅MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));
  parameter Boolean fixedRotationAtFrame_b = false 
    "= true，如果旋转frame_b.R固定(直接连接线性力)" 
    annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级", group = "如果启用，可能会导致错误结果，请参阅MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));

  SI.Distance length 
    "frame_a的原点到frame_b的原点之间的距离";
  SI.Position s 
    "frame_a的原点到frame_b的原点之间的(受保护的)距离（>= s_small))";
  SI.Position r_rel_0[3] 
    "从frame_a到frame_b的位置向量，在世界坐标系中解析";
  Real e_rel_0[3](each final unit = "1") 
    "从frame_a指向frame_b的单位向量，在世界坐标系中解析";
equation
  assert(noEvent(length > s_small), "
线性力组件的frame_a原点和frame_b原点之间的距离变到和参数\"s_small\"(在\"高级\"菜单中定义为一个小数字)一样小。
尽管距离更小，但仍将其设置为\"s_small\"，这样可避免在计算线性力方向时发生除以零的情况。造成这种情况的可能原因有：
- 初始时，距离可能已经为零：更改此元素连接的物体的初始位置。
- 坚硬阻挡物未被建模或模型刚度不够。包括阻挡物，例如，刚性弹簧，或者增加已有的刚度。
- 模型中的另一个错误可能导致不现实地产生较大的力和力矩，实际上会破坏阻挡物。
- flange_b接口可能由预定义的运动定义，例如，使用Modelica.Mechanics.Translational.Position，并且预定义的flange_b.s为零或负值。
");

  // 确定两个坐标系之间的相对位置矢量
  r_rel_0 = frame_b.r_0 - frame_a.r_0;
  length = Modelica.Math.Vectors.length(r_rel_0);
  s = Frames.Internal.maxWithoutEvent(length, s_small);
  e_rel_0 = r_rel_0 / s;

  // 如果直接连接线性力，则添加额外方程
  if fixedRotationAtFrame_a then
    Connections.root(frame_a.R);
    frame_a.R = Frames.nullRotation();
  else
    frame_a.t = zeros(3);
  end if;

  if fixedRotationAtFrame_b then
    Connections.root(frame_b.R);
    frame_b.R = Frames.nullRotation();
  else
    frame_b.t = zeros(3);
  end if;

  annotation(Documentation(info = "<html>
<p>
所有<strong>线性力</strong>元件都应基于此基本模型。
该模型定义了frame_a和frame_b，并计算相对距离<strong>s</strong>。
如果相对距离<strong>length</strong>变小到参数<strong>s_small</strong>，则会引发断言。
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {
    Ellipse(visible = fixedRotationAtFrame_a, extent = {{-70, 30}, {-130, -30}}, lineColor = {255, 0, 0}), 
    Text(visible = fixedRotationAtFrame_a, 
    extent = {{-62, 50}, {-140, 30}}, 
    textColor = {255, 0, 0}, 
    textString = "R=0"), 
    Ellipse(visible = fixedRotationAtFrame_b, extent = {{70, 30}, {130, -30}}, lineColor = {255, 0, 0}), 
    Text(visible = fixedRotationAtFrame_b, 
    extent = {{62, 50}, {140, 30}}, 
    textColor = {255, 0, 0}, 
    textString = "R=0")}));
end LineForceBase;