within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model GearType2 "r3机器人关节4、5、6的电机的惯性和齿轮箱模型"
  extends Modelica.Mechanics.Rotational.Icons.Gearbox;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

  parameter Real i=-99 "传动比";
  parameter SI.Torque Rv0=21.8 "零速度时的粘性摩擦扭矩";
  parameter Real Rv1(unit="N.m.s/rad")=9.8 
    "粘性摩擦系数(R=Rv0+Rv1*abs(qd))";
  parameter Real peak=(26.7/21.8) 
    "最大静摩擦扭矩是 peak*Rv0 (peak >= 1)";

  constant SI.AngularVelocity unitAngularVelocity = 1;
  constant SI.Torque unitTorque = 1;
  Modelica.Mechanics.Rotational.Components.IdealGear gear(
    ratio=i, useSupport=false) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(
    tau_pos=[0,
         Rv0/unitTorque; 1, (Rv0 + Rv1*unitAngularVelocity)/unitTorque], peak=peak, 
    useSupport=false) 
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(gear.flange_b, bearingFriction.flange_a) 
    annotation (Line(points={{-20,0},{20,0}}));
  connect(bearingFriction.flange_b, flange_b) 
    annotation (Line(points={{40,0},{100,0}}));
  connect(gear.flange_a, flange_a) 
    annotation (Line(points={{-40,0},{-100,0}}));
  annotation (
    Documentation(info="<html>
<p>
机器人最外侧三个关节的齿轮箱中的弹性和阻尼被忽略。
对于关节4，给出了所有参数的默认值。
</p>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,100},{150,60}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-30,-30},{30,-80}}, 
          textString="2", 
          textColor={255,255,255})}));
end GearType2;