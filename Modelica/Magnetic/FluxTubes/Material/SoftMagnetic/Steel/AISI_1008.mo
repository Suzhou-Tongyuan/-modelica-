within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Steel;
record AISI_1008 "AISI 1008 (1.0204)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=200, 
    B_myMax=1.17, 
    c_a=8100, 
    c_b=2.59, 
    n=10);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material. SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述.
</p>
</html>"));
end AISI_1008;