within Modelica.Mechanics.Translational.Sources;
model LinearSpeedDependentForce "速度与力之间的线性依赖关系"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter SI.Force f_nominal 
    "标称力（如果为负，则力作用为正向运动的负载）";
  parameter Boolean ForceDirection=true 
    "在运动的两个方向中力的方向是否相同";
  parameter SI.Velocity v_nominal(min=Modelica.Constants.eps) 
    "标称速度";
  SI.Velocity v 
    "一维平动接口相对于支撑组件的速度（= der(s))";

equation
  v = der(s);
  if ForceDirection then
    f = -f_nominal*abs(v/v_nominal);
  else
    f = -f_nominal*(v/v_nominal);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}), 
          Line(points={{0,60},{0,-50}}, color={192,192,192}), 
          Line(points={{-60,-45},{60,45}}, color={0,0,127})}), 
      Documentation(info="<html>
<p>
力的模型，与一维平动接口速度线性相关。<br>
参数 ForceDirection 选择力在运动的两个方向中是否相同。
</p>
</html>"));
end LinearSpeedDependentForce;