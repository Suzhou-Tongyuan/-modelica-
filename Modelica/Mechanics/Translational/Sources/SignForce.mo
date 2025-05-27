within Modelica.Mechanics.Translational.Sources;
model SignForce "随速度改变符号的恒定力"
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  import Modelica.Constants.pi;
  parameter SI.Force f_nominal 
    "标称力（如果为负，则力作用为负载）";
  parameter Modelica.Blocks.Types.Regularization reg=Modelica.Blocks.Types.Regularization.Exp 
    "正则化类型" annotation(Evaluate=true);
  parameter SI.Velocity v0(final min=Modelica.Constants.eps, start=0.1) 
    "速度小于 v0 时进行正则化";
  SI.Velocity v 
    "一维平动接口相对于支撑组件的速度（= der(s))";
equation
  v = der(s);
  if reg==Modelica.Blocks.Types.Regularization.Exp then
    f = -f_nominal*(2/(1 + Modelica.Math.exp(-v/(0.01*v0)))-1);
  elseif reg==Modelica.Blocks.Types.Regularization.Sine then
    f = -f_nominal*smooth(1, (if abs(v)>=v0 then sign(v) else Modelica.Math.sin(pi/2*v/v0)));
  elseif reg==Modelica.Blocks.Types.Regularization.Linear then
    f = -f_nominal*(if abs(v)>=v0 then sign(v) else (v/v0));
  else//if reg==Modelica.Blocks.Types.Regularization.CoSine
    f = -f_nominal*(if abs(v)>=v0 then sign(v) else sign(v)*(1 - Modelica.Math.cos(pi/2*v/v0)));
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
          Line(points={{0,66},{0,-20}}, color={192,192,192}), 
          Line(points={{-75,24},{75,24}}, 
                                        color={192,192,192}), 
        Line(points={{-74,-12},{-8,-12},{-6,-10},{6,58},{8,60},{74,60}})}), Documentation(info="<html>
<p>具有随运动方向改变符号的恒定力模型。</p>
<p>请注意：<br>
正力在两个运动方向中加速。<br>
负力在两个运动方向中制动。</p>
<p>在零速度附近的正则化避免了数值问题。</p>
</html>"));
end SignForce;