within Modelica.Mechanics.Rotational.Sources;
model EddyCurrentTorque "旋转式涡流制动器的简单模型"
  import Modelica.Electrical.Machines.Thermal.linearTemperatureDependency;
  parameter SI.Torque tau_nominal 
    "最大转矩（始终为制动）";
  parameter SI.AngularVelocity w_nominal(min=Modelica.Constants.eps) 
    "参考温度下的额定转速（产生最大转矩）";
  parameter SI.Temperature TRef(start=293.15) 
    "参考温度";
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20(start=0) "材料的温度系数";
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort;
  SI.Torque tau 
    "作用在一维转动接口上的加速转矩（= flange.tau）";
  SI.AngularVelocity w 
    "一维转动接口相对于支撑组件的角速度（= der(phi)）";
  Real w_normalized "相对转速 w/w_nominal";
equation
  tau = flange.tau;
  w = der(phi);
  w_normalized = w/(w_nominal*linearTemperatureDependency(1, TRef, alpha20, TheatPort));
  tau = 2*tau_nominal*w_normalized/(1 + w_normalized*w_normalized);
  lossPower = tau*w;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}), 
          Line(points={{0,60},{0,-50}}, color={192,192,192}), 
        Line(points={{0,0},{4,25},{8,41},{12,48},{16,50},{20,49},{24,46},{28,42},{32,38},{36,34},{46,25},{56,18},{66,12},{76,8}}, color={0,0,127}, smooth=Smooth.Bezier), 
        Line(points={{0,0},{-4,-25},{-8,-41},{-12,-48},{-16,-50},{-20,-49},{-24,-46},{-28,-42},{-32,-38},{-36,-34},{-46,-25},{-56,-18},{-66,-12},{-76,-8}}, color={0,0,127}, smooth=Smooth.Bezier)}), 
    Documentation(info="<html>
<p>这是一个简单的<strong>旋转式涡流制动器</strong>模型。转矩与速度的特性由Kloss方程定义。</p>
<p><strong>热行为：</strong><br>
制动盘的电阻受到实际温度Theatport的影响，这反过来又改变了发生（未改变）最大转矩的转速w_nominal。<br>
如果未使用heatPort（useHeatPort = false），则工作温度保持在给定的温度T。但是，发生最大转矩的转速w_nominal会根据参考温度TRef调整至工作温度。</p>
</html>"));
end EddyCurrentTorque;