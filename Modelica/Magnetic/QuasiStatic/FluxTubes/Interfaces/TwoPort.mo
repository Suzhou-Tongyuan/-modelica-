within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model TwoPort "两个用于文本建模的磁性端口"
  extends TwoPortElementary;

equation
  Complex(0) = port_p.Phi + port_n.Phi;

  annotation (Documentation(info="<html>
<p>
假设流入<code>port_p</code>的磁通量
与从<code>port_n</code>流出的通量相同.
</p>
</html>"));
end TwoPort;