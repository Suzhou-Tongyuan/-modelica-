within Modelica.Magnetic.QuasiStatic.FundamentalWave.Sensors;
model MagneticFluxSensor "测量磁通量的传感器"
  extends Modelica.Icons.RoundSensor;
  extends Interfaces.TwoPortElementary;
  SI.ComplexMagneticPotentialDifference V_m 
    "复磁势差";
  Modelica.ComplexBlocks.Interfaces.ComplexOutput Phi 
    "从 p 端口到 n 端口的复磁通量作为输出信号" 
    annotation (Placement(transformation(
        origin={0,-100}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
 SI.MagneticFlux abs_Phi=Modelica.ComplexMath.abs(Phi) 
    "复合磁通量的大小";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi) 
    "复合磁通论证";

equation
  // 流入正端口的流量
  port_p.V_m - port_n.V_m = V_m;
  // 磁动力
  port_p.Phi = Phi;
  // 当地通量平衡
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // 传感器无磁势差
  V_m = Complex(0, 0);
  annotation (defaultComponentName="magFluxSensor", 
    Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        grid={2,2}), graphics={ Line(points={{-70,0},{-90,0}}, color={255,170,85}), 
          Text(
              extent={{-140,120},{140,80}}, 
              textString="%name", 
              textColor={0,0,255}),Line(points={{70,0},{90,0}}, color={255,170,85}), 
          Line(points={{0,-90},{0,-70}}, color={85,170,255}), 
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="Wb"), 
        Line(points={{100,0},{-100,0}},color={255,170,85})}), 
    Documentation(info="<html>
<p>磁通量传感器.</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticPotentialDifferenceSensor\">MagneticPotentialDifferenceSensor</a>
</p>
</html>"));
end MagneticFluxSensor;