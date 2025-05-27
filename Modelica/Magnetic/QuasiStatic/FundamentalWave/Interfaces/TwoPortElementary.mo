within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
partial model TwoPortElementary "部分两个端口用于图形化编程"
  SI.AngularVelocity omega=der(port_p.reference.gamma) 
    "参考角速度 (= der(port_p.reference.gamma))";
  FundamentalWave.Interfaces.PositiveMagneticPort port_p 
    "基波机的正准静态磁口" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  FundamentalWave.Interfaces.NegativeMagneticPort port_n 
    "基波机的负准静态磁口" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
equation
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  annotation (
    Documentation(info="<html>
<p>
部分双端口模型由一个正磁端口和一个负磁端口组成。两个端口的参考角度设置为相等，并通过<code>Connections.branch</code>连接.
</p>
</html>"));
end TwoPortElementary;