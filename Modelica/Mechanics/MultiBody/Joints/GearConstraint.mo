within Modelica.Mechanics.MultiBody.Joints;
model GearConstraint "理想的三维齿轮箱(任意轴方向)"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Interfaces.Frame_a bearing "在轴承中固定的坐标系" 
   annotation (Placement(transformation(
        origin={0,-100}, 
        extent={{-16,-16},{16,16}}, 
        rotation=90)));

  parameter Real ratio(start=2) "齿轮速比";

  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={1,0,0} 
    "轴a的旋转轴(在frame_a、frame_b、bearing中具有相同的坐标)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={1,0,0} 
    "轴b的旋转轴(在frame_a、frame_b、bearing中具有相同的坐标)";

  parameter SI.Position r_a[3]={0,0,0} 
    "从轴承到frame_a的矢量，在轴承中解析";
  parameter SI.Position r_b[3]={0,0,0} 
    "从轴承到frame_b的矢量，在轴承中解析";
  parameter StateSelect stateSelect=StateSelect.default 
    "使用运动副坐标(phi_a、phi_b、w_a、w_b)作为状态的优先级选择" annotation(Dialog(tab="高级"));
  parameter Boolean checkTotalPower=false 
    "=true，如果要确定流入此组件的总功率(必须为零)" 
    annotation (Dialog(tab="高级"));

 SI.Angle phi_b(start=0, stateSelect=stateSelect) 
    "frame_b处转动副的相对旋转角度";
SI.AngularVelocity w_b(start=0, stateSelect=stateSelect) 
    "角度phi_b的一阶导数(相对角速度b)";
SI.AngularAcceleration a_b(start=0) 
    "角度phi_b的二阶导数(相对角加速度b)";
SI.Power totalPower 
    "如果checkTotalPower=true，则流入此元素的总功率(否则为虚拟)";

Modelica.Mechanics.MultiBody.Joints.Revolute actuatedRevolute_a(
    useAxisFlange=true, 
    n=n_a, 
    animation=false) annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
Modelica.Mechanics.MultiBody.Joints.Revolute actuatedRevolute_b(
    useAxisFlange=true, 
    n=n_b, 
    animation=false) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
Modelica.Mechanics.Rotational.Components.IdealGear idealGear(
                                                    ratio=ratio) 
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation1(animation=false, r=r_b) 
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation2(animation=false, r=r_a) 
    annotation (Placement(transformation(
        origin={-20,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));

equation
  /* 实现说明：

     GearConstraint 模型主要由两个转动副组成，它们连接在一起并与支撑/安装件连接。
在这个第一阶段中，这两个转动副可以独立于彼此旋转，因此有两个自由度。
如果这些运动副的旋转角度被用作广义坐标 phi_a、phi_b，以及相关的广义力矩 tau_a、tau_b(绕旋转轴的力矩)，那么运动方程(Kane方程或第二类Lagrange方程)中 phi_a、phi_b 的行是：
        .... = ... + {...., tau_a, tau_b, ....}

     现在添加齿轮的运动约束：

         0 = phi_a - ratio*phi_b;

     或在速度级别上：

         0 = G * {der(phi_a), der(phi_b)};   G = [1, -ratio]

     根据第一类Lagrange方程，广义力必须被 G'*lambda 替换，其中 lambda 是由于此约束而产生的新约束力。
因此，运动方程变为

       .... = .... + {...., G'*lambda, .....}

     这相当于添加方程

       tau_a = lambda
       tau_b = -ratio*lambda

     或

       0 = tau_b + ratio*tau_a;

     两个方程

       0 = phi_a - ratio*phi_b
       0 = tau_b + ratio*tau_a

     与理想齿轮(不带安装)的方程完全相同，它连接了两个转动副的轴一维接口。
这反过来意味着两个转动副的旋转一维接口只需通过一个IdealGear组件(不带安装)连接。
  */
  assert(cardinality(bearing) > 0, 
    "组件的连接轴承未连接");

  phi_b = actuatedRevolute_b.phi;
  w_b = der(phi_b);
  a_b = der(w_b);

  // 用于测试目的的功率测量
  if checkTotalPower then
    totalPower = 
      frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) + 
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + 
      bearing.f*Frames.resolve2(bearing.R, der(bearing.r_0)) + 
      frame_a.t*Frames.angularVelocity2(frame_a.R) + 
      frame_b.t*Frames.angularVelocity2(frame_b.R) + 
      bearing.t*Frames.angularVelocity2(bearing.R);
  else
    totalPower = 0;
  end if;


  connect(actuatedRevolute_a.axis, idealGear.flange_a) 
    annotation (Line(points={{-50,10},{-50,40},{-10,40}}));
  connect(idealGear.flange_b, actuatedRevolute_b.axis) 
    annotation (Line(points={{10,40},{50,40},{50,10}}));
  connect(actuatedRevolute_a.frame_a,fixedTranslation2. frame_b) annotation (Line(
      points={{-40,0},{-35,0},{-30,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation2.frame_a, bearing) annotation (Line(
      points={{-10,0},{-4,0},{0,0},{0,-100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation1.frame_a, bearing) 
    annotation (Line(
      points={{10,0},{0,0},{0,-100}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(fixedTranslation1.frame_b, actuatedRevolute_b.frame_a) 
    annotation (Line(
      points={{30,0},{40,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(frame_a, actuatedRevolute_a.frame_b) 
    annotation (Line(
      points={{-100,0},{-80,0},{-80,0},{-60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(actuatedRevolute_b.frame_b, frame_b) 
    annotation (Line(
      points={{60,0},{80,0},{80,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
      Text(origin = {0,-20}, 
        textColor = {0,0,255}, 
        extent = {{-150,135},{150,175}}, 
        textString = "%name"), 
      Text(origin = {0,12}, 
        extent = {{-150,-94},{150,-64}}, 
        textString = "%ratio"), 
      Rectangle(origin = {-35,60}, 
        fillColor = {255,255,255}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        extent = {{-15,-40},{15,40}}), 
      Rectangle(origin = {-35,0}, 
        fillColor = {255,255,255}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        extent = {{-15,-21},{15,21}}), 
      Line(points = {{-80,20},{-60,20}}), 
      Line(points = {{-80,-20},{-60,-20}}), 
      Line(points = {{-70,-20},{-70,-86}}), 
      Line(points = {{0,40},{0,-100}}), 
      Line(points = {{-10,40},{10,40}}), 
      Line(points = {{-10,80},{10,80}}), 
      Line(points = {{60,-20},{80,-20}}), 
      Line(points = {{60,20},{80,20}}), 
      Line(points = {{70,-20},{70,-86}}), 
      Rectangle(origin = {-75,0}, 
        lineColor = {64,64,64}, 
        fillColor = {191,191,191}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        extent = {{-25,-10},{25,10}}), 
      Rectangle(origin = {75,0}, 
        lineColor = {64,64,64}, 
        fillColor = {191,191,191}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        extent = {{-25,-10},{25,10}}), 
      Rectangle(origin = {-35,-19}, 
        fillColor = {153,153,153}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-2},{15,2}}), 
      Rectangle(origin = {-35,-8}, 
        fillColor = {204,204,204}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-3},{15,3}}), 
      Rectangle(origin = {-35,19}, 
        fillColor = {204,204,204}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-2},{15,2}}), 
      Rectangle(origin = {-35,8}, 
        fillColor = {255,255,255}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-3},{15,3}}), 
      Rectangle(origin = {0,60}, 
        lineColor = {64,64,64}, 
        fillColor = {191,191,191}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        extent = {{-20,-10},{20,10}}), 
      Rectangle(origin = {-35,98}, 
        fillColor = {153,153,153}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-2},{15,2}}), 
      Rectangle(origin = {-35,87}, 
        fillColor = {204,204,204}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-3},{15,3}}), 
      Rectangle(origin = {-35,50}, 
        fillColor = {204,204,204}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-4},{15,4}}), 
      Rectangle(origin = {-35,22}, 
        fillColor = {102,102,102}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-2},{15,2}}), 
      Rectangle(origin = {-35,33}, 
        fillColor = {153,153,153}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-3},{15,3}}), 
      Rectangle(origin = {-35,70}, 
        fillColor = {255,255,255}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-4},{15,4}}), 
      Rectangle(origin = {35,60}, 
        fillColor = {255,255,255}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        extent = {{-15,-21},{15,21}}), 
      Rectangle(origin = {35,41}, 
        fillColor = {153,153,153}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-2},{15,2}}), 
      Rectangle(origin = {35,52}, 
        fillColor = {204,204,204}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-3},{15,3}}), 
      Rectangle(origin = {35,79}, 
        fillColor = {204,204,204}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-2},{15,2}}), 
      Rectangle(origin = {35,68}, 
        fillColor = {255,255,255}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-3},{15,3}}), 
      Rectangle(origin = {35,0}, 
        fillColor = {255,255,255}, 
        fillPattern = FillPattern.HorizontalCylinder, 
        extent = {{-15,-40},{15,40}}), 
      Rectangle(origin = {35,38}, 
        fillColor = {153,153,153}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-2},{15,2}}), 
      Rectangle(origin = {35,27}, 
        fillColor = {204,204,204}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-3},{15,3}}), 
      Rectangle(origin = {35,-10}, 
        fillColor = {204,204,204}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-4},{15,4}}), 
      Rectangle(origin = {35,-27}, 
        fillColor = {153,153,153}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-3},{15,3}}), 
      Rectangle(origin = {35,10}, 
        fillColor = {255,255,255}, 
        fillPattern = FillPattern.Solid, 
        extent = {{-15,-4},{15,4}}), 
      Rectangle(origin = {-35,40}, 
        fillColor = {255,255,255}, 
        extent = {{-15,-61},{15,60}}), 
      Rectangle(origin = {35,21}, 
        fillColor = {255,255,255}, 
        extent = {{-15,-61},{15,60}}), 
      Line(points = {{70,-86},{-70,-86}})}), 
    Documentation(info="<html>
<p>
这个理想的无质量运动副在<code>frame_a</code>和<code>frame_b</code>之间提供了一个齿轮约束。
<code>frame_a</code>和<code>frame_b</code>的旋转轴可以是任意的。
</p>
<p>
<strong>参考文献</strong><br><span style=\"font-variant:small-caps\">Schweiger</span>,Christian;<span style=\"font-variant:small-caps\">Otter</span>,Martin:<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling3DMechanicalEffectsof1-dim.Powertrains</a>.In:<em>Proceedingsofthe3rdInternationalModelicaConference</em>.Link&ouml;ping:TheModelicaAssociationandLink&ouml;pingUniversity,November3-4,2003,pp.149-158</p>
</html>"));
end GearConstraint;