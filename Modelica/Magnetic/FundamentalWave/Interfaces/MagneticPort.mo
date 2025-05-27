within Modelica.Magnetic.FundamentalWave.Interfaces;
connector MagneticPort "基波机的磁端口"
  SI.ComplexMagneticPotential V_m 
    "端口处的复磁势";
  flow SI.ComplexMagneticFlux Phi 
    "进入端口的复合磁通量";
  annotation (Documentation(info="<html>
<p>
磁端口的势量是复磁势差 <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\">。相应的流动量是磁通量 <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Phi.png\">.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
end MagneticPort;