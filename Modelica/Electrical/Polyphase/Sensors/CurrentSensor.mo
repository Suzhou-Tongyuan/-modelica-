within Modelica.Electrical.Polyphase.Sensors;
model CurrentSensor "多相电流传感器"
  extends Modelica.Icons.RoundSensor;
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput i[m](each unit="A") 
    "从p到n分支中的电流作为输出信号" annotation (
      Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p.pin, currentSensor.p) 
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(currentSensor.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(currentSensor.i, i) annotation (Line(
      points={{0,-11},{0,-110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
                                       Line(points={{0,-100}, 
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
          textColor={64,64,64}, 
          textString="A"),  Line(points={{100,0},{-100,0}}, color={0,0,255})}), 
                                  Documentation(info="<html>
<p>
包含m个电流传感器(Modelica.Electrical.Analog.Sensors.CurrentSensor)，
因此测量从plug_p的m个引脚到plug_n的m个引脚的m个电流<em>i[m]</em>。
</p>
</html>"));
end CurrentSensor;