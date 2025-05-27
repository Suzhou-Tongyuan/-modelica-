within Modelica.Mechanics.Translational.Sources;
model ConstantForce "恒定力，不依赖于速度"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  parameter SI.Force f_constant 
    "标称力（如果为负，则力作用为正向运动的负载）";
equation
  f = -f_constant;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
          Line(points={{-75,10},{75,10}}, 
                                        color={192,192,192}), 
          Line(points={{0,60},{0,0}}, color={192,192,192}), 
          Line(points={{-75,30},{75,30}}, color={0,0,127}), 
          Text(extent={{-120,-40},{120,-10}}, 
          textString="%f_constant")}),            Documentation(info="<html><p>
恒定力的模型，不依赖于接口速度。
</p>
<p>
请注意：<br> 正力加速正向运动，但在反向运动中制动。<br> 负力在正向运动中制动，但在反向运动中加速。
</p>
</html>"));
end ConstantForce;