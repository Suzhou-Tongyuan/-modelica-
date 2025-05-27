within Modelica.Electrical.Polyphase.Sensors;
model PotentialSensor "多相电位传感器"
  extends Modelica.Icons.RoundSensor; // 使用圆形传感器图标

  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true); // 相数参数，至少为1
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}))); // 正极插头定义，连接到多个相
  Modelica.Blocks.Interfaces.RealOutput phi[m](each unit="V") 
    "Absolute voltage potential as output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}}))); // 输出电压信号
  Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}))); // 多个电位传感器定义
equation
  connect(potentialSensor.p, plug_p.pin) 
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255})); // 连接传感器的正极插头到电源插头
  connect(potentialSensor.phi, phi) annotation (Line(
      points={{11,0},{110,0}}, color={0,0,127})); // 连接传感器的电位信号到输出
  annotation (
    Icon(graphics={Line(points={{70,0},{100,0}}, color={0,0,127}), 
          Line(points={{-70,0},{-90,0}}, color={0,0,255}), 
        Text(
          extent={{150,-100},{-150,-70}}, 
          textString="m=%m"), 
        Text(
          extent={{-150,80},{150,120}}, 
              textString="%name", 
              textColor={0,0,255}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textString="V", 
          textColor={64,64,64})}),    Documentation(info="<html>
<p>
包含m个电位传感器(Modelica.Electrical.Analog.Sensors.PotentialSensor)，
从而测量插头plug_p的m个电位phi[m]。
</p>
</html>"));
end PotentialSensor;