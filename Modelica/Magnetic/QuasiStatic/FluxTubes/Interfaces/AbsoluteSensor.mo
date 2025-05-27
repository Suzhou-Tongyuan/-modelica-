within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model AbsoluteSensor "部分电位传感器"
  extends Modelica.Icons.RoundSensor;
  SI.AngularVelocity omega;
  FluxTubes.Interfaces.PositiveMagneticPort port "准静磁口" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  omega = der(port.reference.gamma);
  port.Phi = Complex(0);
  annotation (Icon(graphics={
        Line(points={{-70,0},{-90,0}}, color={255,170,85}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          pattern=LinePattern.None, 
          fillColor={170,85,255}, 
          fillPattern=FillPattern.Solid, 
          textString="%name")}), Documentation(info="<html>
<p>
传感器的绝对部分模型提供了一个单一的
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>
来测量复磁势。此外，该模型包含一个基本图标和一个定义
角频率的.
</p></html>"));
end AbsoluteSensor;