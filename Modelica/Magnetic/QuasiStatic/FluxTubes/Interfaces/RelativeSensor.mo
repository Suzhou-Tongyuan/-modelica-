within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model RelativeSensor "部分磁电压或磁通传感器"
  extends Modelica.Icons.RoundSensor;
  extends TwoPort;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
        transformation(
        origin={0,-110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), 
                   graphics={
        Line(points={{-70,0},{-90,0}}, color={255,170,85}), 
        Line(points={{70,0},{90,0}}, color={255,170,85}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          pattern=LinePattern.None, 
          fillColor={170,85,255}, 
          fillPattern=FillPattern.Solid, 
          textString="%name"), 
        Line(
          points={{0,-70},{0,-100}}, color={85,170,255})}), 
      Documentation(info="<html>
<p>
相对传感器部分模型依赖于
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.TwoPort\">TwoPort</a>
测量复磁电压、磁通或功率。此外，该模型包含一个基本图标和一个定义
角频率的.
</p></html>"));
end RelativeSensor;