within Modelica.Mechanics.Rotational.Sources;
model QuadraticSpeedDependentTorque 
  "转矩与转速之间的二次关系"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  parameter SI.Torque tau_nominal 
    "额定转矩（如果为负值，则转矩在旋转正方向上作为负载）";
  parameter Boolean TorqueDirection=true 
    "转矩在两个旋转方向上的方向相同";
  parameter SI.AngularVelocity w_nominal(min=Modelica.Constants.eps) 
    "额定转速";
  SI.AngularVelocity w 
    "一维转动接口相对于支撑组件的角速度（= der(phi)）";
  SI.Torque tau 
    "作用于一维转动接口的加速转矩（= -flange.tau）";
equation
  w = der(phi);
  tau = -flange.tau;
  if TorqueDirection then
    tau = tau_nominal*(w/w_nominal)^2;
  else
    tau = tau_nominal*smooth(1, if w >= 0 then (w/w_nominal)^2 else -(w/w_nominal)^2);
  end if;
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
          Line(points={{-60,40},{-60,-50}}, color={192,192,192}), 
          Line(points={{-75,-40},{75,-40}}, color={192,192,192}), 
        Line(
          points={{-60,-40},{-40,-38},{-20,-32},{0,-20},{20,-4},{40,16},{58,42}}, 
          color={0,0,127}, 
          smooth=Smooth.Bezier)}), 
    Documentation(info="<html>
<p>
一维转动接口角速度二次相关的转矩模型。<br>
参数 TorqueDirection 选择转矩在两个旋转方向上的方向是否相同。
</p>
</html>"));
end QuadraticSpeedDependentTorque;