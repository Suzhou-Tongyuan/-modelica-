within Modelica.Mechanics.Rotational.Sources;
model LinearSpeedDependentTorque "转矩与转速之间的线性关系"
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
    tau = tau_nominal*abs(w/w_nominal);
  else
    tau = tau_nominal*(w/w_nominal);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
          Line(points={{0,60},{0,-50}}, color={192,192,192}), 
          Line(points={{-75,0},{75,0}}, color={192,192,192}), 
          Line(points={{-60,-45},{60,45}}, color={0,0,127})}), 
    Documentation(info="<html>
<p>
一维转动接口角速度线性相关的转矩模型。<br>
参数 TorqueDirection 选择转矩在两个旋转方向上的方向是否相同。
</p>
</html>"));
end LinearSpeedDependentTorque;