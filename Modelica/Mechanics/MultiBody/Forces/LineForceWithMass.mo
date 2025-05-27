within Modelica.Mechanics.MultiBody.Forces;
model LineForceWithMass 
  "连接线上具有1个可选点质量的通用线性力组件"

  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.LineForceBase;
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b 
    "一维平动接口(平动库中flange_a和flange_b之间的连接力)" 
    annotation(Placement(transformation(
    origin = {60, 100}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_a 
    "一维平动接口(平动库中flange_a和flange_b之间的连接力)" 
    annotation(Placement(transformation(
    origin = {-60, 100}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 90)));

  parameter Boolean animateLine = true 
    "= true，如果在frame_a和frame_b之间可视化为线的形状";
  parameter Boolean animateMass = true 
    "= true，如果将点质量可视化为球，条件是m > 0";
  parameter SI.Mass m(min = 0) = 0 
    "连接线上质点的质量，位于frame_a原点和frame_b原点之间";
  parameter Real lengthFraction(
    unit = "1", 
    min = 0, 
    max = 1) = 0.5 
    "点质量相对于frame_a所在的位置，距离为frame_a到frame_b长度的比例";
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(= 0：光完全被吸收)" 
    annotation(Dialog(tab = "动画", enable = animateLine or animateMass));
  parameter Types.ShapeType lineShapeType = "cylinder" 
    "可视化从frame_a到frame_b的线形状的类型" 
    annotation(Dialog(tab = "动画", group = "如果animateLine = true", enable = animateLine));
  input SI.Length lineShapeWidth = world.defaultArrowDiameter "形状的宽度" 
    annotation(Dialog(tab = "动画", group = "如果animateLine = true", enable = animateLine));
  input SI.Length lineShapeHeight = lineShapeWidth "形状的高度" 
    annotation(Dialog(tab = "动画", group = "如果animateLine = true", enable = animateLine));
  parameter Types.ShapeExtra lineShapeExtra = 0.0 "形状的额外参数" 
    annotation(Dialog(tab = "动画", group = "如果animateLine = true", enable = animateLine));
  input Types.Color lineShapeColor = Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "线形状的颜色" 
    annotation(Dialog(colorSelector = true, tab = "动画", group = "如果animateLine = true", enable = animateLine));
  input Real massDiameter = world.defaultBodyDiameter 
    "点质量球的直径" 
    annotation(Dialog(tab = "动画", group = "如果animateMass = true", enable = animateMass));
  input Types.Color massColor = Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor 
    "点质量的颜色" 
    annotation(Dialog(colorSelector = true, tab = "动画", group = "如果animateMass = true", enable = animateMass));

protected
  SI.Force fa "flange_a 上的力";
  SI.Force fb "flange_b 上的力";
  SI.Position r_CM_0[3](each stateSelect = StateSelect.avoid) 
    "从世界坐标系到质点的位置矢量，在世界坐标系中解析";
  SI.Velocity v_CM_0[3](each stateSelect = StateSelect.avoid) 
    "r_CM_0 的一阶导数";
  SI.Acceleration ag_CM_0[3] "der(v_CM_0) - gravityAcceleration";


  Visualizers.Advanced.Shape lineShape(
    shapeType = lineShapeType, 
    color = lineShapeColor, 
    specularCoefficient = specularCoefficient, 
    length = length, 
    width = lineShapeWidth, 
    height = lineShapeHeight, 
    lengthDirection = e_rel_0, 
    widthDirection = Frames.resolve1(frame_a.R, {0, 1, 0}), 
    extra = lineShapeExtra, 
    r = frame_a.r_0) if world.enableAnimation and animateLine;

  Visualizers.Advanced.Shape massShape(
    shapeType = "sphere", 
    color = massColor, 
    specularCoefficient = specularCoefficient, 
    length = massDiameter, 
    width = massDiameter, 
    height = massDiameter, 
    lengthDirection = e_rel_0, 
    widthDirection = {0, 1, 0}, 
    r_shape = e_rel_0 * (length * lengthFraction - massDiameter / 2), 
    r = frame_a.r_0) if world.enableAnimation and animateMass and m > 0;

equation
  flange_a.s = 0;
  flange_b.s = length;

  // Determine translational flange forces
  if cardinality(flange_a) > 0 and cardinality(flange_b) > 0 then
    fa = flange_a.f;
    fb = flange_b.f;
  elseif cardinality(flange_a) > 0 and cardinality(flange_b) == 0 then
    fa = flange_a.f;
    fb = -fa;
  elseif cardinality(flange_a) == 0 and cardinality(flange_b) > 0 then
    fa = -fb;
    fb = flange_b.f;
  else
    fa = 0;
    fb = 0;
  end if;

  /* Force and torque balance of point mass
     - Kinematics for center of mass CM of point mass including gravity
       r_CM_0 = frame_a.r0 + r_rel_CM_0;
       v_CM_0 = der(r_CM_0);
       ag_CM_0 = der(v_CM_0) - world.gravityAcceleration(r_CM_0);
     - Power balance for the connection line
       (f1=force on frame_a side, f2=force on frame_b side, h=lengthFraction)
       0 = f1*va - m*ag_CM*(va+(vb-va)*h) + f2*vb
         = (f1 - m*ag_CM*(1-h))*va + (f2 - m*ag_CM*h)*vb
       since va and vb are completely independent from other
       the parenthesis must vanish:
         f1 := m*ag_CM*(1-h)
         f2 := m*ag_CM*h
     - Force balance on frame_a and frame_b finally results in
         0 = frame_a.f + e_rel_a*fa - f1_a
         0 = frame_b.f + e_rel_b*fb - f2_b
       and therefore
         frame_a.f = -e_rel_a*fa + m*ag_CM_a*(1-h)
         frame_b.f = -e_rel_b*fb + m*ag_CM_b*h
  */

  if m > 0 then
    r_CM_0 = frame_a.r_0 + r_rel_0 * lengthFraction;
    v_CM_0 = der(r_CM_0);
    ag_CM_0 = der(v_CM_0) - world.gravityAcceleration(r_CM_0);
    frame_a.f = Frames.resolve2(frame_a.R, (m * (1 - lengthFraction)) * ag_CM_0 - e_rel_0 * fa);
    frame_b.f = Frames.resolve2(frame_b.R, (m * lengthFraction) * ag_CM_0 - e_rel_0 * fb);
  else
    r_CM_0 = zeros(3);
    v_CM_0 = zeros(3);
    ag_CM_0 = zeros(3);
    frame_a.f = -Frames.resolve2(frame_a.R, e_rel_0 * fa);
    frame_b.f = -Frames.resolve2(frame_b.R, e_rel_0 * fb);
  end if;

  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Ellipse(
    extent = {{-95, -40}, {-15, 40}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {192, 192, 192}), 
    Ellipse(
    extent = {{-85, -30}, {-25, 30}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{15, -40}, {95, 40}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {192, 192, 192}), 
    Ellipse(
    extent = {{23, -30}, {83, 29}}, 
    lineColor = {128, 128, 128}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-150, -50}, {150, -90}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Rectangle(
    extent = {{-40, 41}, {44, -40}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-70, 15}, {-41, -13}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {192, 192, 192}), 
    Ellipse(
    extent = {{40, 14}, {69, -14}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {192, 192, 192}), 
    Line(points = {{-56, 0}, {-56, 23}, {-30, 23}, {-30, 70}, {-60, 70}, {-60, 101}}), 
    Line(points = {{55, -1}, {55, 20}, {30, 20}, {30, 70}, {60, 70}, {60, 100}}), 
    Line(
    points = {{-56, 0}, {55, -1}}, 
    pattern = LinePattern.Dot), 
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
    Diagram(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-60, 80}, {46, 80}}, color = {0, 0, 255}), 
    Polygon(
    points = {{60, 80}, {45, 86}, {45, 74}, {60, 80}}, 
    lineColor = {0, 0, 255}, 
    fillColor = {0, 0, 255}, 
    fillPattern = FillPattern.Solid), 
    Text(
    extent = {{-40, 98}, {40, 82}}, 
    textString = "length", 
    textColor = {0, 0, 255}), 
    Ellipse(
    extent = {{-100, -40}, {-20, 40}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {192, 192, 192}), 
    Ellipse(
    extent = {{-90, -30}, {-30, 30}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{20, -40}, {100, 40}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {192, 192, 192}), 
    Ellipse(
    extent = {{31, -29}, {91, 30}}, 
    lineColor = {128, 128, 128}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Rectangle(
    extent = {{-50, 39}, {50, -41}}, 
    lineColor = {255, 255, 255}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid), 
    Ellipse(
    extent = {{-74, 15}, {-45, -13}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {192, 192, 192}), 
    Ellipse(
    extent = {{45, 15}, {74, -13}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {192, 192, 192}), 
    Line(points = {{-60, 0}, {-60, 24}, {-40, 24}, {-40, 60}, {-60, 60}, {-60, 100}}), 
    Line(points = {{60, 1}, {60, 21}, {40, 21}, {40, 60}, {60, 60}, {60, 100}}), 
    Line(
    points = {{-60, 0}, {60, 0}}, 
    pattern = LinePattern.Dot), 
    Ellipse(
    extent = {{-8, 8}, {8, -8}}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-60, 0}, {-31, 0}}, color = {0, 0, 255}), 
    Polygon(points = {{-19, 0}, {-31, 3}, {-31, -3}, {-19, 0}}, lineColor = {0, 0, 255}), 
    Line(points = {{-60, 16}, {0, 16}}, color = {0, 0, 255}), 
    Line(points = {{0, 0}, {0, 20}}, color = {0, 0, 255}), 
    Text(
    extent = {{-49, -11}, {-8, -21}}, 
    textString = "e_rel_0"), 
    Polygon(points = {{0, 16}, {-12, 19}, {-12, 13}, {0, 16}}, lineColor = {0, 0, 255}), 
    Text(
    extent = {{-50, 35}, {51, 26}}, 
    textString = "length*lengthFraction"), 
    Line(
    points = {{-17, 26}, {-26, 16}}, 
    pattern = LinePattern.Dot, 
    color = {0, 0, 255}), 
    Line(
    points = {{-31, -13}, {-40, 0}}, 
    pattern = LinePattern.Dot, 
    color = {0, 0, 255})}), 
    Documentation(info = "<html>
<p>
这个组件用于在frame_a原点和frame_b原点之间施加一个<strong>线性力</strong>，
通过将 Modelica的<strong>一维平动</strong>机械库(Modelica.Mechanics.Translational)的组件连接在两个一维接口连接器<strong>flange_a</strong>和<strong>flange_b</strong>之间来实现。
可选地，在连接frame_a的原点和frame_b的原点之间的线上有一个<strong>质点</strong>。这个质点近似于<strong>力元素</strong>的<strong>质量</strong>。
质点与frame_a的距离与frame_a到frame_b的距离的比例系数通过参数<strong>lengthFraction</strong>来定义(默认值为0.5，即质点位于线的中间)。
</p>
<p>
在一维平动库中，有一个隐含的假设，
即仅具有一个一维接口连接器的组件的力会以相反的符号作用于组件的轴承上。
这个假设也适用于LineForceWithMass组件：如果只连接到一个一维接口连接器，
则在另一个一维接口连接器中的力会隐式地以相反的符号作用。
</p>

</html>"));
end LineForceWithMass;