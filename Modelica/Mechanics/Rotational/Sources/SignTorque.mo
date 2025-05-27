within Modelica.Mechanics.Rotational.Sources;
model SignTorque "随速度改变符号的恒定转矩"
  extends Rotational.Interfaces.PartialTorque;
  import Modelica.Constants.pi;
  parameter SI.Torque tau_nominal 
    "额定转矩（如果为负值，则转矩在旋转正方向上作为负载）";
  parameter Modelica.Blocks.Types.Regularization reg=Modelica.Blocks.Types.Regularization.Exp 
    "正则化类型" annotation(Evaluate=true);
  parameter SI.AngularVelocity w0(final min=Modelica.Constants.eps, start=0.1) 
    "在 w0 以下进行正则化";
  SI.AngularVelocity w 
    "一维转动接口相对于支撑的角速度（= der(phi)）";
  SI.Torque tau 
    "作用于一维转动接口的加速转矩（= -flange.tau）";
equation
  w = der(phi);
  tau = -flange.tau;
  if reg==Modelica.Blocks.Types.Regularization.Exp then
    tau = tau_nominal*(2/(1 + Modelica.Math.exp(-w/(0.01*w0)))-1);
  elseif reg==Modelica.Blocks.Types.Regularization.Sine then
    tau = tau_nominal*smooth(1, (if abs(w)>=w0 then sign(w) else Modelica.Math.sin(pi/2*w/w0)));
  elseif reg==Modelica.Blocks.Types.Regularization.Linear then
    tau = tau_nominal*(if abs(w)>=w0 then sign(w) else (w/w0));
  else//如果 reg==Modelica.Blocks.Types.Regularization.CoSine
    tau = tau_nominal*(if abs(w)>=w0 then sign(w) else sign(w)*(1 - Modelica.Math.cos(pi/2*w/w0)));
  end if;
  annotation (
    Icon(
      coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), 
        graphics={
          Text(
            extent={{-120,-50},{120,-20}}, 
          textString="%tau_nominal"), 
          Line(points={{-75,24},{75,24}}, 
                                        color={192,192,192}), 
          Line(points={{0,66},{0,-20}}, color={192,192,192}), 
        Line(points={{-74,-12},{-8,-12},{-6,-10},{6,58},{8,60},{48,60}})}), Documentation(info="<html>
<p>根据旋转方向改变符号的恒定转矩模型。</p>
<p>请注意：<br>
正转矩在两个旋转方向上都会加速。<br>
负转矩在两个旋转方向上都会制动。</p>
<p>在零速度附近进行正则化可以避免数值问题。</p>
</html>"));
end SignTorque;