within Modelica.Mechanics.MultiBody.Interfaces;
partial model PartialLineForce "无质量线性力元素的基础模型"
  extends LineForceBase;

  SI.Position r_rel_a[3] 
    "从frame_a原点到frame_b原点的位置矢量，在frame_a中解析";
  Real e_a[3](each final unit = "1") 
    "沿着连接frame_a原点和frame_b原点的线，在frame_a中解析的单位向量(从frame_a指向frame_b)";
  SI.Force f 
    "作用在frame_a和frame_b上的线力(正值表示作用在frame_b上且方向从frame_a指向frame_b)";
equation
  // 计算两个坐标系之间的相对位置矢量
  r_rel_a = Frames.resolve2(frame_a.R, r_rel_0);
  e_a = r_rel_a / s;

  // 计算frame_a和frame_b上的力和力矩
  frame_a.f = -e_a * f;
  frame_b.f = -Frames.resolve2(Frames.relativeRotation(frame_a.R, frame_b.R), frame_a.f);

  annotation(Documentation(info = "<html>
<p>
所有无质量的<strong>线性力</strong>元素应该基于这个基础模型。
该模型定义了frame_a和frame_b，计算了相对距离<strong>s</strong>，
并提供了frame_a和frame_b上的局部力和局部力矩平衡。
在子模型中，只需要定义作用在frame_b上的线性力<strong>f</strong>，作为从frame_a指向frame_b直线的函数，其参数是相对距离<strong>s</strong>及其导数<strong>der</strong>(<strong>s</strong>)。
示例：
</p>
<blockquote><pre>
<strong>model</strong> Spring
   <strong>parameter</strong> Real c \"spring constant\",
   <strong>parameter</strong> Real s_unstretched \"unstretched spring length\";
   <strong>extends</strong> Modelica.Mechanics.MultiBody.Interfaces.PartialLineForce;
<strong>equation</strong>
   f = c*(s-s_unstretched);
<strong>end</strong> Spring;
</pre></blockquote>
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
end PartialLineForce;