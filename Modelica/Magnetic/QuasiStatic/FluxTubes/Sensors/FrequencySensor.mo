within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model FrequencySensor "频率传感器"
  extends FluxTubes.Interfaces.AbsoluteSensor;
  import Modelica.Constants.pi;
  Modelica.Blocks.Interfaces.RealOutput y(unit="Hz") annotation (Placement(transformation(
          extent={{100,-10},{120,10}})));
equation
  2*pi*y = omega;
  annotation (Documentation(info="<html>
<p>
该传感器可用于测量参考系统的频率。
准静磁系统的角频率积分等于参考角.
</p>
</html>"), 
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}}, 
          textColor={64,64,64}, 
          textString="Hz")}));
end FrequencySensor;