within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model ReferenceSensor "参考角度伽马传感器"
  extends FluxTubes.Interfaces.AbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput y(unit="rad") "参考角" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = port.reference.gamma;
  annotation (Documentation(info="<html>
<p>该传感器确定所连接的准静态磁系统的参考角度。
准静磁系统的角频率积分等于参考角.
</p>
</html>"), 
    Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="rad"), Line(points={{70,0},{100,0}}, color={0,0,127})}));
end ReferenceSensor;