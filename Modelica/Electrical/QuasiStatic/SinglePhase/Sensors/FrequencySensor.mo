within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model FrequencySensor "频率传感器"
  extends Interfaces.AbsoluteSensor; // 继承绝对传感器接口
  import Modelica.Constants.pi; // 导入π常数
  Modelica.Blocks.Interfaces.RealOutput f(unit="Hz") "频率" // 频率输出端口，单位为Hz
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  2*pi*f = omega; // 计算角速度
  annotation (Documentation(info="<html>

<p>
该传感器可用于测量参考系统的频率。
</p>

<h4>另请参见</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"), 
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="Hz"), 
        Line(points={{100,0},{70,0}}, color={0,0,127})}));
end FrequencySensor;