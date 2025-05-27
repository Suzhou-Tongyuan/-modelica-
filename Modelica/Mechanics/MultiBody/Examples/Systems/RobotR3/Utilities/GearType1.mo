within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model GearType1 "r3机器人关节1、2、3的电机的惯性和齿轮箱模型"
  extends Modelica.Mechanics.Rotational.Icons.Gearbox;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

  parameter Real i=-105 "传动比";
  parameter SI.RotationalSpringConstant c = 43 "弹性系数";
  parameter SI.RotationalDampingConstant d = 0.005 "阻尼系数";
  parameter SI.Torque Rv0=0.4 "零速度时的粘性摩擦扭矩";
  parameter Real Rv1(unit="N.m.s/rad") = (0.13/160) 
    "粘性摩擦系数 (R=Rv0+Rv1*abs(qd))";
  parameter Real peak=1 
    "最大静摩擦扭矩 peak*Rv0 (peak >= 1)";
  SI.AngularAcceleration a_rel=der(spring.w_rel) 
    "弹簧的相对角加速度";
  constant SI.AngularVelocity unitAngularVelocity = 1;
  constant SI.Torque unitTorque = 1;

  Modelica.Mechanics.Rotational.Components.IdealGear gear(
    ratio=i, useSupport=false) 
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Components.SpringDamper spring(
    c=c, d=d) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
    tau_pos=[0,
         Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque], 
      useSupport=false) annotation (Placement(
        transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(spring.flange_b, gear.flange_a) 
    annotation (Line(points={{10,0},{40,0}}));
  connect(bearingFriction.flange_b, spring.flange_a) 
    annotation (Line(points={{-40,0},{-10,0}}));
  connect(gear.flange_b, flange_b) 
    annotation (Line(points={{60,0},{100,0}}));
  connect(bearingFriction.flange_a, flange_a) 
    annotation (Line(points={{-60,0},{-100,0}}));
initial equation
  spring.w_rel = 0;
  a_rel = 0;
  annotation (
    Documentation(info="<html>
<p>
该模型模拟了前三个关节所使用的齿轮箱及其所有影响，如弹性和摩擦。
库仑摩擦通过作用在“电机”侧的摩擦元件来近似。
在现实中，还应在齿轮箱的驱动侧加入轴承摩擦。
然而，这将需要付出相当大的代价来测量摩擦参数。
对于关节1，给出了所有参数的默认值。
模型relativeStates用于定义弹簧(=齿轮弹性)上的相对角度和相对角速度作为状态变量。
其原因是，这些状态的默认初始值为零总是有意义的。
如果将模型Jmotor的绝对角度和绝对角速度用作状态，并且负载角度(=机器人的关节角度)不为零，那么必须始终确保电机角度和关节角度的初始值相应地进行了修改。
否则，弹簧在初始时刻会有一个不符合实际的偏转。
由于使用相对量作为状态变量，这大大简化了初始值的定义。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-30,-30},{30,-80}}, 
          textColor={255,255,255}, 
          textString="1"), 
        Line(points={{-24,0},{-16,0},{-12,14},{-4,-14},{4,14},{12,-14},{16,0},{24,0}}, color={95,95,95})}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{72,30},{130,22}}, 
          textString="flange of joint axis"), Text(
          extent={{-128,26},{-70,18}}, 
          textString="flange of motor axis")}));
end GearType1;