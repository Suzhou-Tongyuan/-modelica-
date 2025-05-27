within Modelica.Magnetic.FluxTubes.Interfaces;
partial model TwoPort "界面组件包括通量平衡方程"

  extends TwoPortExtended;

equation
  0 = port_p.Phi + port_n.Phi;

  annotation (Documentation(info="<html>
<p>
假设流入port_p的磁通量与流出port_n的磁通量相同。
这个磁通量被明确地表示为通量.
</p>
</html>"));
end TwoPort;