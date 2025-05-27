within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model TwoPort "两个用于文本建模的磁性端口"
  extends Magnetic.FundamentalWave.Interfaces.TwoPortExtended;
equation
  // 局部通量平衡
  port_p.Phi + port_n.Phi = Complex(0, 0);
  annotation (Documentation(info="<html>
<p>
这种磁性双端口元件只由a组成
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> 和
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces. NegativeMagneticPort\">negative magnetic port</a>。
该模型主要用于扩展，以便建立更复杂的基于方程的模型.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortElementary\">TwoPortElementary</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortExtended\">TwoPortExtended</a>
</p>
</html>"));
end TwoPort;