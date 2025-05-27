within Modelica.Mechanics.Translational.Sources;
model EddyCurrentForce "简单的直线涡流制动器模型"
  import Modelica.Electrical.Machines.Thermal.linearTemperatureDependency;
  parameter SI.Force f_nominal 
    "最大制动力(始终制动)";
  parameter SI.Velocity v_nominal(min=Modelica.Constants.eps) 
    "参考温度下的额定速度(导致最大力)";
  parameter SI.Temperature TRef(start=293.15) 
    "参考温度";
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20(start=0) "材料的温度系数";
  extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort;
  SI.Velocity v 
    "相对于支撑的速度(= der(s))";
  Real v_normalized "相对速度 v/v_nominal";
equation
  v = der(s);
  v_normalized = v/(v_nominal*linearTemperatureDependency(1, TRef, alpha20, TheatPort));
  f = 2*f_nominal*v_normalized/(1 + v_normalized*v_normalized);
  lossPower = f*v;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
          Line(points={{-75,0},{75,0}}, color={192,192,192}), 
          Line(points={{0,60},{0,-50}}, color={192,192,192}), 
        Line(points={{0,0},{4,25},{8,41},{12,48},{16,50},{20,49},{24,46},{28,42},{32,38},{36,34},{46,25},{56,18},{66,12},{76,8}}, color={0,0,127}, smooth=Smooth.Bezier), 
        Line(points={{0,0},{-4,-25},{-8,-41},{-12,-48},{-16,-50},{-20,-49},{-24,-46},{-28,-42},{-32,-38},{-36,-34},{-46,-25},{-56,-18},{-66,-12},{-76,-8}}, color={0,0,127}, smooth=Smooth.Bezier)}), 
    Documentation(info="<html>
<p>这是一个简单的直线涡流制动器模型。力与速度的特性由 Kloss 方程定义。</p>
<p><strong>热行为：</strong><br>
制动片的电阻受实际温度 Theatport 的影响，从而使得发生最大扭矩的速度 v_nominal 发生偏移。<br>
如果未使用 heatPort(useHeatPort = false)，操作温度保持在给定温度 T。<br>
然而，最大扭矩发生的速度 v_nominal 从参考温度 TRef 调整为操作温度。</p>
</html>"));
end EddyCurrentForce;