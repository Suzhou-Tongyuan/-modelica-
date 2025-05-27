within Modelica.Mechanics.Rotational.Examples;
model First "第一个案例：简单的传动系统"
    extends Modelica.Icons.Example;
  parameter SI.Torque amplitude=10 
    "驱动扭矩幅度";
  parameter SI.Frequency f=5 "驱动扭矩频率";
  parameter SI.Inertia Jmotor(min=0) = 0.1 "电机一维惯性转动组件";
  parameter SI.Inertia Jload(min=0) = 2 "负载一维惯性转动组件";
  parameter Real ratio=10 "齿轮比";
  parameter Real damping=10 "齿轮轴承的阻尼";

  Rotational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{38,-48},{54,-32}})));
  Rotational.Sources.Torque torque(useSupport=true) annotation (Placement(
        transformation(extent={{-68,-8},{-52,8}})));
  Rotational.Components.Inertia inertia1(J=Jmotor) annotation (Placement(
        transformation(extent={{-38,-8},{-22,8}})));
  Rotational.Components.IdealGear idealGear(ratio=ratio, useSupport=true) 
    annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
  Rotational.Components.Inertia inertia2(
    J=2, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
            22,-8},{38,8}})));
  Rotational.Components.Spring spring(c=1.e4, phi_rel(fixed=true)) 
    annotation (Placement(transformation(extent={{52,-8},{68,8}})));
  Rotational.Components.Inertia inertia3(J=Jload, w(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{82,-8},{98,8}})));
  Rotational.Components.Damper damper(d=damping) annotation (Placement(
        transformation(
        origin={46,-22}, 
        extent={{-8,-8},{8,8}}, 
        rotation=270)));
  Modelica.Blocks.Sources.Sine sine(amplitude=amplitude, f=f) 
    annotation (Placement(transformation(extent={{-98,-8},{-82,8}})));
equation
  connect(inertia1.flange_b, idealGear.flange_a) 
    annotation (Line(points={{-22,0},{-8,0}}));
  connect(idealGear.flange_b, inertia2.flange_a) 
    annotation (Line(points={{8,0},{22,0}}));
  connect(inertia2.flange_b, spring.flange_a) 
    annotation (Line(points={{38,0},{52,0}}));
  connect(spring.flange_b, inertia3.flange_a) 
    annotation (Line(points={{68,0},{82,0}}));
  connect(damper.flange_a, inertia2.flange_b) 
    annotation (Line(points={{46,-14},{46,0},{38,0}}));
  connect(damper.flange_b, fixed.flange) 
    annotation (Line(points={{46,-30},{46,-40}}));
  connect(sine.y, torque.tau) 
    annotation (Line(points={{-81.2,0},{-69.6,0}}, color={0,0,127}));
  connect(torque.support, fixed.flange) 
    annotation (Line(points={{-60,-8},{-60,-40},{46,-40}}));
  connect(idealGear.support, fixed.flange) 
    annotation (Line(points={{0,-8},{0,-40},{46,-40}}));
  connect(torque.flange, inertia1.flange_a) annotation (Line(
      points={{-52,0},{-38,0}}));
  annotation (
    Documentation(info="<html><p>
传动系统由含转动惯量的电机组成， 该电机由正弦波电机扭矩驱动。 通过齿轮箱，转动能量传递给带一维惯性转动的负载。 齿轮箱的弹性通过弹簧元件进行建模。 线性阻尼器用于模拟齿轮箱的轴承中的阻尼。
</p>
<p>
请注意，作用在轴和壳体之间的力（如本示例中的阻尼器）必须通过组件Fixed在壳体上的一侧固定。
</p>
<p>
模拟1秒并绘制以下变量：<br> 一维惯性转动组件(inertia2和inertia3)的角速度：inertia2.w，inertia3.w
</p>
</html>"), 
    experiment(StopTime=1.0, Interval=0.001));
end First;