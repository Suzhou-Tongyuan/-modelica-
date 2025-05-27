within Modelica.Mechanics.Translational.Sources;
model ForceStep "恒定力，不依赖于速度"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter SI.Force stepForce(start=1) 
    "力阶跃值（如果为负，则力作用为正向运动的负载）";
  parameter SI.Force offsetForce(start=0) "力的偏移量";
  parameter SI.Time startTime=0 
    "时间 < startTime 时的力偏移";
equation
  f = -offsetForce - (if time < startTime then 0 else stepForce);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}), 
                                  Line(points={{-75,-30},{0,-30},{0,45},{65,45}}, color={0,0,127}), 
                                      Text(
          extent={{0,-40},{100,-10}}, 
          textColor={128,128,128}, 
          textString="time")}),     Documentation(info="<html>
<p>
在startTime时间发生的阶跃力的模型。
正向力加速一维平动接口正向的运动
</p>
</html>"));
end ForceStep;