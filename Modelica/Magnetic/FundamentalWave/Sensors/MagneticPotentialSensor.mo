within Modelica.Magnetic.FundamentalWave.Sensors;
model MagneticPotentialSensor "测量磁势的传感器"
  extends Modelica.Icons.RoundSensor;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m 
    "作为输出信号的复磁势" annotation (Placement(
        transformation(
        origin={0,-100}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Interfaces.PositiveMagneticPort port_p "传感器的磁性连接器" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  // 传感器无磁通量
  port_p.Phi = Complex(0, 0);
  // 磁势
  V_m = port_p.V_m;
  annotation (defaultComponentName="magPotentialSensor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
                                Line(points={{-70,0},{-90,0}}, color={255,128,0}), 
          Line(points={{0,-90},{0,-70}}, color={85,170,255}), 
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
end MagneticPotentialSensor;