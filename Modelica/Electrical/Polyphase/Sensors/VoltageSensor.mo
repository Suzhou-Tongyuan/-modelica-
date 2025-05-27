within Modelica.Electrical.Polyphase.Sensors;
model VoltageSensor "多相电压传感器"
  extends Modelica.Icons.RoundSensor; // 使用圆形传感器图标

  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true); // 相数参数，至少为1
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}))); // 正极插头定义，连接到多个相
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}))); // 负极插头定义，连接到多个相
  Modelica.Blocks.Interfaces.RealOutput v[m](each unit="V") 
    "Voltage between pin p and n (= p.v - n.v) as output signal" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90))); // 输出电压信号
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}))); // 多个电压传感器定义
equation
  connect(voltageSensor.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255})); // 连接传感器的负极插头到电源插头
  connect(voltageSensor.p, plug_p.pin) 
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255})); // 连接传感器的正极插头到电源插头
  connect(voltageSensor.v, v) annotation (Line(
      points={{0,-11},{0,-110}}, color={0,0,127})); // 连接传感器的电压信号到输出
  annotation (
    Icon(graphics={Line(points={{-70,0},{-90,0}}), 
          Line(points={{70,0},{90,0}}),Line(points={{0,-100}, 
          {0,-70}}, color={0,0,127}), 
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
          textColor={64,64,64})}),Documentation(info="<html>
<p>
包含m个电压传感器(Modelica.Electrical.Analog.Sensors.VoltageSensor)，
从而测量插头plug_p和plug_n之间的m个电压差v[m]。
</p>
</html>"));
end VoltageSensor;