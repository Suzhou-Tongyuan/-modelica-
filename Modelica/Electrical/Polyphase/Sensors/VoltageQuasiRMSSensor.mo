within Modelica.Electrical.Polyphase.Sensors;
model VoltageQuasiRMSSensor 
    "多相系统的连续准有效电压RMS传感器"
  extends Modelica.Icons.RoundSensor;
  extends Polyphase.Interfaces.TwoPlug;
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);

  Modelica.Blocks.Interfaces.RealOutput V(unit="V") "电压的连续准RMS" 
    annotation (Placement(transformation(
        origin={-2,-110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-110})));
  Polyphase.Sensors.VoltageSensor voltageSensor(final m=m) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Polyphase.Blocks.QuasiRMS quasiRMS(final m=m) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,-50})));
equation
  connect(plug_p, voltageSensor.plug_p) annotation (Line(points={{-100, 
          0},{-100,0},{-10,0}}, color={0,0,255}));
  connect(voltageSensor.plug_n, plug_n) annotation (Line(points={{10,0},{
          100,0},{100,0}}, color={0,0,255}));
  connect(voltageSensor.v, quasiRMS.u) annotation (Line(
      points={{0,-11},{0,-38}}, color={0,0,127}));
  connect(quasiRMS.y, V) annotation (Line(
      points={{0,-61},{0,-86},{0,-110},{-2,-110}}, color={0,0,127}));
  annotation (defaultComponentName="voltageRMSSensor", Icon(graphics={Text(
              extent={{-160,-70},{160,-100}}, 
              textString="m=%m"),Line(points={{0,-70},{0,-100}}), 
          Line(points={{-90,0},{-70,0}}, color={0,0,255}),Line(points={{70, 
          0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,80},{150,120}}, 
              textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textString="V", 
          textColor={64,64,64})}),Documentation(revisions="<html>
</html>", 
      info="<html>
<p>
该传感器确定多相电压系统的连续准<a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a>值，表示等效RMS电压<code>V</code>向量或相量。如果电压波形偏离正弦曲线，则传感器的输出将不会完全等于平均RMS值。
</p>
<blockquote><pre>
V=sqrt(sum(v[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end VoltageQuasiRMSSensor;