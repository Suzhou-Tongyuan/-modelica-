within Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors;
model MagneticPotentialDifferenceSensor 
  "测量磁势差的传感器"
  extends Modelica.Icons.RoundSensor;
  extends Interfaces.TwoPortElementary;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m 
    "端口_p 和端口_n 之间的复磁势差作为输出信号" 
    annotation (Placement(transformation(
        origin={0,-100}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  SI.MagneticPotentialDifference abs_V_m= 
      Modelica.ComplexMath.abs(V_m) 
    "复合磁势差的大小";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m) 
    "复磁势差论证";
  SI.ComplexMagneticFlux Phi "复合磁通量";
equation
  // 流入正端口的流量
  port_p.V_m - port_n.V_m = V_m;
  // 磁场力
  port_p.Phi = Phi;
  // 局部通量平衡
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // 传感器无磁通量
  Phi = Complex(0, 0);
  annotation (defaultComponentName="magVoltageSensor", Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        grid={2,2}), graphics={ Line(points={{-70,0},{-90,0}}, color={255,170,85}), 
          Line(points={{70,0},{90,0}}, color={255,170,85}), 
                                       Line(points={{0,-90}, 
          {0,-70}}, color={85,170,255}), 
                    Text(
              extent={{-140,120},{140,80}}, 
              textString="%name", 
              textColor={0,0,255}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="A")}), Documentation(info="<html>
<p>磁电势差传感器.</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticFluxSensor\">MagneticFluxSensor</a>
</p></html>"));
end MagneticPotentialDifferenceSensor;