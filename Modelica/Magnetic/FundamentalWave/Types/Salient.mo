within Modelica.Magnetic.FundamentalWave.Types;
record Salient "带有 d 和 q 分量的典型性基本记录"
  replaceable Real d "d 轴（直接）的分量，与实部对齐";
  replaceable Real q 
    "q（正交）轴的分量，与虚部对齐";
  annotation (Documentation(info="<html>
<p>
与正交的 d 轴和 q 轴相关的显著性定义。然而，显著性指的是 d 轴和 q 轴的不同特性，因此考虑了各向异性行为.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientCurrent\">SalientCurrent</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientVoltage\">SalientVoltage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientInductance\">SalientInductance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientReluctance\">SalientReluctance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientResistance\">SalientResistance</a>
</p>

</html>"));
end Salient;