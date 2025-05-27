within Modelica.Magnetic.FluxTubes.Interfaces;
partial model TwoPortExtended "扩展的带有磁电压和磁通别名变量的TwoPort接口模型"

  extends TwoPortElementary;
  SI.MagneticPotentialDifference V_m "端口磁电位差";
  SI.MagneticFlux Phi(start=0) "从port_p到port_n的磁通量";

equation
  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;

  annotation (Documentation(info="<html>
<p>
假设流入port_p的磁通量与流出port_n的磁通量相同。
这个磁通量被明确地表示为通量.
</p>
</html>"));
end TwoPortExtended;