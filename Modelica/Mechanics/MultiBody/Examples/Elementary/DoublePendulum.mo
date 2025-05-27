within Modelica.Mechanics.MultiBody.Examples.Elementary;
model DoublePendulum 
  "带有两个摆动构件和两个转动副的简单双摆模型"

  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange=true,phi(fixed=true), 
      w(fixed=true)) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(
                                              d=0.1) 
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06) 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(phi(fixed=true), w(
        fixed=true)) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody2(r={0.5,0,0}, width=0.06) 
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation

  connect(damper.flange_b, revolute1.axis) annotation (Line(points={{-40,40},{-40,20},{-50,20},{-50,10}}));
  connect(revolute1.support, damper.flange_a) annotation (Line(points={{-56,10},{-56,20},{-60,20},{-60,40}}));
  connect(revolute1.frame_b, boxBody1.frame_a) 
    annotation (Line(
      points={{-40,0},{-20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(revolute2.frame_b, boxBody2.frame_a) 
    annotation (Line(
      points={{40,0},{60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(boxBody1.frame_b, revolute2.frame_a) 
    annotation (Line(
      points={{0,0},{20,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, revolute1.frame_a) 
    annotation (Line(
      points={{-80,0},{-60,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    experiment(StopTime=3), 
    Documentation(info="<html>
<p>
这个例子演示了通过使用关节(joint)和构件(body)元素来自动实现动画。
这个例子还展示了旋转关节的动画效果。
注意，可以通过将第一个参数<strong>animation</strong>设置为<strong>false</strong>，或者将<strong>world</strong>
对象中的<strong>enableAnimation</strong>设置为<strong>false</strong>来关闭每个组件的动画。
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulum.png\"
alt=\"model Examples.Elementary.DoublePendulum\">
</blockquote>
</html>"));
  end DoublePendulum;