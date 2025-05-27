within Modelica.Mechanics.Rotational.Sources;
model ConstantTorque "恒定转矩，不依赖于转速"
  extends Rotational.Interfaces.PartialTorque;
  parameter SI.Torque tau_constant 
    "恒定转矩（如果为负值，则转矩在旋转正方向上作为负载）";
  SI.AngularVelocity w 
    "一维转动接口相对于支撑组件的角速度（= der(phi)）";
  SI.Torque tau 
    "作用于一维转动接口的加速转矩（= -flange.tau）";
equation
  w = der(phi);
  tau = -flange.tau;
  tau = tau_constant;
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), 
        graphics={
          Line(points={{-75,10},{75,10}}, 
                                        color={192,192,192}), 
          Line(points={{0,60},{0,0}}, color={192,192,192}), 
          Line(points={{-75,30},{75,30}}, color={0,0,127}), 
          Text(extent={{-120,-40},{120,-10}}, textString="%tau_constant")}), 
    Documentation(info="<html>
<p>不依赖于一维转动接口角速度的恒定转矩模型。</p>
<p>请注意:<br>
正转矩在旋转正方向上加速，但在反向旋转方向上制动。<br>
负转矩在旋转正方向上制动，但在反向旋转方向上加速。</p>
</html>"));
end ConstantTorque;