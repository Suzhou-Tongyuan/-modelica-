within Modelica.Mechanics.Translational.Sources;
model QuadraticSpeedDependentForce 
  "速度与力之间的二次依赖关系"
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
    f = -f_nominal*(v/v_nominal)^2;
  else
    f = -f_nominal*smooth(1, if v >= 0 then (v/v_nominal)^2 else -(v/v_nominal)^2);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
          Line(points={{-60,50},{-60,-40}}, color={192,192,192}), 
          Line(points={{-75,-30},{75,-30}}, color={192,192,192}), 
        Line(
          points={{-60,-30},{-40,-28},{-20,-22},{0,-10},{20,6},{40,26},{58,52}}, 
          color={0,0,127}, 
          smooth=Smooth.Bezier)}),     Documentation(info="<html>
<p>
力的模型，与一维平动接口速度的二次相关。<br>
参数 ForceDirection 选择力在运动的两个方向中是否相同。
</p>
</html>"));
end QuadraticSpeedDependentForce;