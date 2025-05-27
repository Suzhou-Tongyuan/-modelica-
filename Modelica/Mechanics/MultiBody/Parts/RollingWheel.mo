within Modelica.Mechanics.MultiBody.Parts;
model RollingWheel 
  "理想情况下在平面z=0上滚动的轮子(5个位置自由度，3个速度自由度)"

  parameter Boolean animation=true 
    "=true，如果要启用轮子的动画";

  parameter SI.Radius radius "轮子半径";
  parameter SI.Mass m "轮子质量";
  parameter SI.Inertia I_axis "沿轮子轴的转动惯量";
  parameter SI.Inertia I_long "垂直于轮子轴的转动惯量";
  parameter StateSelect stateSelect=StateSelect.always 
    "优先使用广义坐标作为状态" 
    annotation (HideResult=true, Evaluate=true);

  SI.Position x(
    start=0, 
    fixed=true, 
    stateSelect=stateSelect) "轮子轴的x坐标";

  SI.Position y(
    start=0, 
    fixed=true, 
    stateSelect=stateSelect) "轮子轴的y坐标";

  SI.Angle angles[3](
    start={0,0,0}, 
    each fixed=true, 
    each stateSelect=stateSelect) 
    "旋转全局坐标系到frame_a坐标系的角度，围绕z、y、x轴" 
    annotation (Dialog(group="初始值",showStartAttribute=true));

  SI.AngularVelocity der_angles[3](
    start={0,0,0}, 
    each fixed=true, 
    each stateSelect=stateSelect) "角度的导数" 
    annotation (Dialog(group="初始值",showStartAttribute=true));


  parameter SI.Distance width=0.035 "轮子宽度" annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  parameter Real hollowFraction=0.8 
    "用于环形可视化：轮子半径/内孔半径；即1.0：完全中空，0.0：完全实心" annotation (Dialog(
      tab="动画", 
      group="如果animation=true", 
      enable=animation));
  parameter Types.Color color={30,30,30} "轮子颜色" 
    annotation (Dialog(
      colorSelector=true, 
      tab="动画", 
      group="如果animation=true", 
      enable=animation));

  Modelica.Mechanics.MultiBody.Parts.Body body(
    final r_CM={0,0,0}, 
    final m=m, 
    final I_11=I_long, 
    final I_22=I_axis, 
    final I_33=I_long, 
    final I_21=0, 
    final I_31=0, 
    final I_32=0, 
    animation=false) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a 
    "固定在轮子中心点的参考坐标系(y轴：沿轮子轴，z轴：向上)" 
    annotation (Placement(transformation(extent={{-16,-16},{16,16}})));
  Modelica.Mechanics.MultiBody.Joints.RollingWheel rollingWheel(
    radius=radius, stateSelect=StateSelect.avoid) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape fixedShape(
    final animation=animation, 
    final r_shape={0,-width,0}, 
    final lengthDirection={0,1,0}, 
    final widthDirection={1,0,0}, 
    final length=2*width, 
    final width=2*radius, 
    final height=2*radius, 
    final color=color, 
    final extra=hollowFraction, 
    final shapeType="pipe") if animation 
    annotation (Placement(transformation(extent={{20,20},{40,40}})));

equation
  rollingWheel.x = x;
  rollingWheel.y = y;
  rollingWheel.angles = angles;
  rollingWheel.der_angles = der_angles;

  connect(body.frame_a, frame_a) annotation (Line(
      points={{20,0},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rollingWheel.frame_a, frame_a) annotation (Line(
      points={{-30,0},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedShape.frame_a, frame_a) annotation (Line(
      points={{20,30},{0,30},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (defaultComponentName="wheel", Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,-80},{100,-100}}, 
          fillColor={175,175,175}, 
          fillPattern=FillPattern.Solid, 
          pattern=LinePattern.None), 
        Ellipse(
          extent={{-80,80},{80,-80}}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Sphere, 
          lineColor={175,175,175}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-100,-80},{100,-80}}), 
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={64,64,64})}), 
    Documentation(info="<html>
<p>
一个轮子在全局坐标系的x-y平面上滚动，包括轮子质量和简单可视化。
滚动接触被视为理想化，即轮子和地面之间没有滑动。
轮子不能脱离地面，但可以向地面倾斜。
参考坐标系frame_a放置在轮子中心点，并随着轮子本身一起旋转。
因此，应使用带有旋转轴<code>n={0,1,0}</code>的<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Revolute\">rotational joint</a>将轮子连接到载体。
</p>

<h4>注意</h4>
<p>
为了正常工作，世界的重力加速度矢量 g 必须指向负 z 轴，即</p>
<blockquote><pre>
<span style=\"font-family:'Courier New',courier; color:#0000ff;\">inner</span> <span style=\"font-family:'Courier New',courier; color:#ff0000;\">Modelica.Mechanics.MultiBody.World</span> world(n={0,0,-1});
</pre></blockquote>
</html>"));
end RollingWheel;