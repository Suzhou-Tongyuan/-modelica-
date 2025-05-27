within Modelica.Mechanics.Rotational.Sources;
model TorqueStep "阶跃扭矩，不依赖于速度"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  parameter SI.Torque stepTorque(start=1) 
    "扭矩阶跃的高度(如果为负值，则扭矩作为负载作用)";
  parameter SI.Torque offsetTorque(start=0) 
    "扭矩的偏移量";
  parameter SI.Time startTime=0 
    "当时间小于startTime时，Torque = offset";
  SI.Torque tau 
    "作用在一维转动接口上的加速扭矩(= -flange.tau)";

equation
  tau = -flange.tau;
  tau = offsetTorque + (if time < startTime then 0 else stepTorque);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}), 
          Line(points={{-75,-30},{0,-30},{0,45},{65,45}}, color={0,0,127}), 
          Text(
          extent={{0,-40},{100,-10}}, 
          textColor={128,128,128}, 
          textString="time")}), 
    Documentation(info="<html>
<p>
在 startTime 时刻的扭矩阶跃模型。
正扭矩在<code>flange</code>旋转的正方向上加速。
</p>
</html>"));
end TorqueStep;