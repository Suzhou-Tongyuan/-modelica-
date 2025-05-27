within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
connector MagneticPort "准静磁口"
  SI.ComplexMagneticPotential V_m 
  "端口处的复磁势";
  flow SI.ComplexMagneticFlux Phi 
  "复合磁通量流入端口";
  annotation (Documentation(info="<html>
<p>复准静态磁口的基本定义。
势变量为复磁位差<code>V_m</code>与流量变量
为复磁通量<code>Phi</code>.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.MagneticPort\">Magnetic.FluxTubes.Interfaces.MagneticPort</a>
</p>

</html>"));
end MagneticPort;