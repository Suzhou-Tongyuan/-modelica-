within Modelica.Magnetic.FundamentalWave.BasicMachines.Components;
model PermanentMagnet 
  "永磁体由磁势差表示"
  extends Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference;
  extends 
    Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses;
  annotation (defaultComponentName="pm", Documentation(info="<html>
<p>
永磁体的简单模型，包含:
</p>
<ul>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">constant magnetomotive force</a></li>
<li><a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses\">loss model</a></li>
</ul>
<p>
永磁体通过磁势差建模。永磁体的内部磁阻并未考虑在内。内部磁阻需要在永磁体模型之外建模，例如通过气隙模型中考虑的机器总磁阻来建模.
</p>
</html>"));
end PermanentMagnet;