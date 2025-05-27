within Modelica.Mechanics.MultiBody.Joints;
model RollingWheelSet 
"描述理想的滚动轮组的连接件(无质量，无转动惯量)(两个理想的滚动轮由轴连接在一起)"
 Modelica.Mechanics.MultiBody.Interfaces.Frame_a frameMiddle 
  "固定在连接两个轮子的轴中间的参考坐标系(y轴：沿轮子轴，z轴：向上)" 
    annotation (Placement(transformation(extent={{-16,16},{16,-16}}), 
        iconTransformation(extent={{-16,-16},{16,16}}, 
      rotation=90, 
      origin={0,-20})));

  parameter Boolean animation=true 
  "=true，如果要启用轮组的动画";

  parameter SI.Radius radius "一个轮子的半径";
  parameter SI.Distance track "两个轮子之间的距离(轴距)";

  parameter StateSelect stateSelect = StateSelect.default 
  "优先使用广义坐标作为状态";

  SI.Position x(start=0, stateSelect=stateSelect) 
  "两个轮子之间中心的x坐标";
  SI.Position y(start=0, stateSelect=stateSelect) 
  "两个轮子之间中心的y坐标";
  SI.Angle phi(start=0, stateSelect=stateSelect) 
  "轮子轴沿z轴的方向角";
  SI.Angle theta1(start=0, stateSelect=stateSelect) 
  "轮子1的角度";
  SI.Angle theta2(start=0, stateSelect=stateSelect) 
  "轮子2的角度";
  SI.AngularVelocity der_theta1(start=0, stateSelect=stateSelect) 
  "theta1的导数";
  SI.AngularVelocity der_theta2(start=0, stateSelect=stateSelect) 
  "theta2的导数";


 Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame1 
  "左滚轮中心固定的参考系(y轴：沿轮轴方向，z轴：向上)" 
    annotation (Placement(transformation(extent={{-96,16},{-64,-16}}), 
        iconTransformation(extent={{-96,16},{-64,-16}})));
Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame2 
  "右滚轮中心固定的参考系(y轴：沿轮轴方向，z轴：向上)" 
    annotation (Placement(transformation(extent={{64,16},{96,-16}})));
Modelica.Mechanics.MultiBody.Parts.Fixed fixed(
    r={0,0,radius}, animation=animation) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={0,-90})));
Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod1(
    r={0,track/2,0}, animation=animation) 
    annotation (Placement(transformation(extent={{-10,-10},{-30,10}})));
Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic1(animation=animation) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={0,-66})));
Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic2(n={0,1,0}, animation=animation) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={-24,-50})));
Modelica.Mechanics.MultiBody.Joints.Revolute revolute(animation=animation) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={0,-22})));
Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
    r={0,-track/2,0}, animation=animation) 
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(
    n={0,1,0}, 
    useAxisFlange=true, 
    animation=animation) annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(
    n={0,1,0}, 
    useAxisFlange=true, 
    animation=animation) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
Modelica.Mechanics.MultiBody.Joints.Internal.RollingConstraintVerticalWheel rolling1(radius=radius) annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
Modelica.Mechanics.MultiBody.Joints.Internal.RollingConstraintVerticalWheel rolling2(radius=radius, lateralSlidingConstraint=false) annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1 
  "驱动运动副的一维旋转一维接口" 
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2 
  "驱动运动副的一维旋转一维接口" 
    annotation (Placement(transformation(extent={{90,90},{110,110}})));
Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D 
    annotation (Placement(transformation(extent={{-10,38},{10,58}})));
Modelica.Mechanics.Rotational.Interfaces.Flange_b support 
  "一维轴的支撑" annotation (Placement(transformation(extent={{-10,70}, 
          {10,90}}), iconTransformation(extent={{-10,70},{10,90}})));

equation
  prismatic1.s  = x;
  prismatic2.s  = y;
  revolute.phi  = phi;
  revolute1.phi = theta1;
  revolute2.phi = theta2;
  der_theta1 = der(theta1);
  der_theta2 = der(theta2);

  connect(revolute.frame_b, frameMiddle) annotation (Line(
      points={{0,-12},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod1.frame_a, frameMiddle) annotation (Line(
      points={{-10,0},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod2.frame_a, frameMiddle) annotation (Line(
      points={{10,0},{0,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rod1.frame_b, revolute1.frame_a) annotation (Line(
      points={{-30,0},{-40,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute1.frame_b, frame1) annotation (Line(
      points={{-60,0},{-80,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute2.frame_a, rod2.frame_b) annotation (Line(
      points={{40,0},{30,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute2.frame_b, frame2) annotation (Line(
      points={{60,0},{80,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(prismatic1.frame_a, fixed.frame_b) annotation (Line(
      points={{0,-76},{0,-80}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(prismatic1.frame_b, prismatic2.frame_a) annotation (Line(
      points={{0,-56},{0,-50},{-14,-50}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(prismatic2.frame_b, revolute.frame_a) annotation (Line(
      points={{-34,-50},{-40,-50},{-40,-36},{0,-36},{0,-32}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rolling1.frame_a, revolute1.frame_b) annotation (Line(
      points={{-70,-48},{-70,0},{-60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(rolling2.frame_a, revolute2.frame_b) annotation (Line(
      points={{70,-48},{70,0},{60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute1.axis, axis1) annotation (Line(
      points={{-50,10},{-50,100},{-100,100}}));
  connect(revolute2.axis, axis2) annotation (Line(
      points={{50,10},{50,100},{100,100}}));
  connect(frameMiddle, mounting1D.frame_a) annotation (Line(
      points={{0,0},{0,38}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(mounting1D.flange_b, support) annotation (Line(
      points={{10,48},{16,48},{16,80},{0,80}}));
  annotation (defaultComponentName="wheelSet",Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,-80},{100,-100}}, 
          fillColor={175,175,175}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-146,-98},{154,-138}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Ellipse(
          extent={{42,80},{118,-80}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{86,24},{64,24},{64,12},{56,12}}), 
        Line(points={{86,-24},{64,-24},{64,-12},{56,-12}}), 
        Line(
          points={{100,100},{80,100},{80,-2}}), 
        Line(
          points={{0,76},{0,4}}), 
      Polygon(
        points={{-62,6},{64,6},{64,-6},{6,-6},{6,-20},{-6,-20},{-6,-6},{-62,-6},{-62,6}}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-118,80},{-42,-80}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-96,100},{-80,100},{-80,4}})}), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Line(
          points={{-68,24},{-68,52}}, 
          color={0,0,255}), 
        Polygon(
          points={{-68,70},{-74,52},{-62,52},{-68,70}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-68,70},{-50,58}}, 
          textColor={0,0,255}, 
          textString="x"), 
        Line(
          points={{-62,30},{-94,30}}, 
          color={0,0,255}), 
        Polygon(
          points={{-90,36},{-90,24},{-108,30},{-90,36}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-114,50},{-96,38}}, 
          textColor={0,0,255}, 
          textString="y")}), 
  Documentation(info="<html>
一个在全局坐标系的x-y平面上滚动的滚轮组装连接点。
<br>frame1和frame2坐标系连接到旋转的滚轮；frameMiddle在与世界的x-y平面平行的平面中移动，且应连接到物体上。
<br>

<h4>注意</h4>
<p>
为了正常工作，世界的重力加速度矢量g必须指向负z轴，即：</p>
<blockquote><pre>
<span style=\"font-family:'Courier New',courier; color:#0000ff;\">inner</span><span style=\"font-family:'Courier New',courier; color:#ff0000;\">Modelica.Mechanics.MultiBody.World</span>world(n={0,0,-1});
</pre></blockquote>
</html>"));
end RollingWheelSet;