within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model TwoPortElementary "两个磁性端口用于图形化建模"
  PositiveMagneticPort port_p "基波机的正磁端口" annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}})));
  NegativeMagneticPort port_n "基波机的负磁端口" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));
  annotation (Documentation(info="<html>
<p>
这种双端口磁性元件由一个
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> 和
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a> 和
考虑了两个端口的磁通平衡。此外，还定义了（正负端口的）磁势差和（进入正磁端口的）磁通量。该模型主要用于扩展，以建立更复杂的图形模型.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortExtended\">TwoPortExtended</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPort\">TwoPort</a>
</p></html>"));
end TwoPortElementary;