within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model TwoPortExtended "两个磁性端口，用于使用附加变量进行图形建模"
  extends TwoPortElementary;
  SI.ComplexMagneticPotentialDifference V_m = port_p.V_m - port_n.V_m 
    "复磁势差";
  SI.MagneticPotentialDifference abs_V_m = Modelica.ComplexMath.abs(V_m) 
    "复合磁势差的大小";
  SI.Angle arg_V_m = Modelica.ComplexMath.arg(V_m) 
    "复磁势差论证";
  SI.ComplexMagneticFlux Phi = port_p.Phi 
    "复合磁通量";
  SI.MagneticFlux abs_Phi = Modelica.ComplexMath.abs(Phi) 
    "复合磁通量的大小";
  SI.Angle arg_Phi = Modelica.ComplexMath.arg(Phi) 
    "复合磁通论证";

  annotation (Documentation(info="<html>
<p>这个磁性双端口元素由一个<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> 和 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces. NegativeMagneticPort\">negative magnetic port</a>和一些额外的变量，但没有物理平衡方程。</p>
<h4>See also</h4>
<p><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPort\">TwoPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortElementary\">TwoPortElementary</a></p>
</html>"));
end TwoPortExtended;