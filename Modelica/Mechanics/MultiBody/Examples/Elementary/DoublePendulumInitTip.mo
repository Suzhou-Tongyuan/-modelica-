within Modelica.Mechanics.MultiBody.Examples.Elementary;
model DoublePendulumInitTip 
  "演示如何初始化双摆，使其尖端从预定义位置开始。"
  extends Modelica.Icons.Example;
  inner World world annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}})));
  Joints.Revolute revolute1(useAxisFlange=true) 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Rotational.Components.Damper damper(d=0.1) 
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06) 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Joints.Revolute revolute2(phi(start=Modelica.Constants.pi/2)) 
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Parts.BodyBox boxBody2(r={0.5,0,0}, width=0.06) 
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit freeMotionScalarInit(
    use_r=true, 
    r_rel_a_1(start=0.7, fixed=true), 
    r_rel_a_2(start=0.3, fixed=true), 
    use_v=true, 
    v_rel_a_1(fixed=true), 
    v_rel_a_2(fixed=true)) 
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
equation
  connect(damper.flange_b,revolute1. axis) annotation (Line(points={{-40,40},{-40,20},{-50,20},{-50,10}}));
  connect(revolute1.support,damper. flange_a) annotation (Line(points={{-56,10},{-56,20},{-60,20},{-60,40}}));
  connect(revolute1.frame_b,boxBody1. frame_a) 
    annotation (Line(
      points={{-40,0},{-20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute2.frame_b,boxBody2. frame_a) 
    annotation (Line(
      points={{40,0},{60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(boxBody1.frame_b,revolute2. frame_a) 
    annotation (Line(
      points={{0,0},{20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b,revolute1. frame_a) 
    annotation (Line(
      points={{-80,0},{-60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, freeMotionScalarInit.frame_a) annotation (Line(
      points={{-80,0},{-70,0},{-70,-40},{-20,-40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(freeMotionScalarInit.frame_b, boxBody2.frame_b) annotation (Line(
      points={{0,-40},{90,-40},{90,0},{80,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    experiment(StopTime=5), 
    Documentation(info="<html><p>
这个例子通过一个双摆演示了如何定义非标准初始化；摆尖的绝对位置和其绝对速度应该最初定义的。
这可以通过初始化其相对矢量的各个元素的<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit\" target=\"\">Joints.FreeMotionScalarInit</a>的关节来执行。
在这种情况下，相对位置矢量的x和y坐标(在下图中用黄色箭头表示)以及其导数应该在初始时间具有定义的值。
初始时间的双摆的配置如下所示，其中要求尖端位置具有坐标x=0.7，y=0.3。
</p>
<p>
只设置尖端的起始位置会导致初始化不明确，因为<code>revolute1.phi</code>和<code>revolute2.phi</code>存在两个有效解。
此外，计算的角度 <code>revolute1.phi</code>和<code>revolute2.phi</code>可能是预期解<code>phi1</code>和<code>phi2</code>的倍数，
</p>
<ul><li>
revolute1.phi(k1) = phi1 + 2 π k1,</li>
<li>
revolute2.phi(k2) = phi2 + 2 π k2.</li>
</ul><p>
为了清楚地确定首选解决方案，可以额外给出初始角度的猜测值。
在这个例子中，可以简单地通过<code>revolute2.phi.start = Modelica.Constants.pi/2</code> 来实现。
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulumInitTip.png\">
</blockquote>
</html>"));
end DoublePendulumInitTip;