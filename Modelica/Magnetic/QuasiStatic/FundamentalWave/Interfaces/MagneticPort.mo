within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
connector MagneticPort "基波机的准静态磁端口"
  SI.ComplexMagneticPotential V_m 
    "端口处的复磁势";
  flow SI.ComplexMagneticFlux Phi 
    "流入端口的复合磁通量";
  annotation (Documentation(info="<html>
<p>复准静态磁口的基本定义。势变量是复磁势
<code>V_m</code>流变量为复磁通量<code>Phi</code>.</p>

<h4>另见</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
end MagneticPort;