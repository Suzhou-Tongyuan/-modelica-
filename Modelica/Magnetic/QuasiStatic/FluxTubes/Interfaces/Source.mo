within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model Source "部分磁电压或磁通源"
  FluxTubes.Interfaces.PositiveMagneticPort port_p "正磁口" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "负磁口" annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  SI.AngularVelocity omega;
  SI.Angle gamma(start=0) = port_p.reference.gamma;
equation
  Connections.root(port_p.reference);
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  omega = der(port_p.reference.gamma);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), 
                   graphics={
        Text(
          extent={{150,60},{-150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-90,0},{-50,0}}, 
          color={255,170,85}), 
        Line(
          points={{50,0},{90,0}}, 
          color={255,170,85}), 
        Ellipse(
          extent={{-50,50},{50,-50}}, 
          lineColor={255,170,85}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}),            Documentation(info="<html>
<p>
源模型提供一个正负磁端口。此外，这个模型包含一个基本图标
以及角频率的定义.
</p></html>"));
end Source;