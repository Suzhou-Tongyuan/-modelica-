within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Steel;
record AISI_12L14 "AISI 12L14 (1.0718)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=10, 
    B_myMax=0.94, 
    c_a=5900, 
    c_b=4.19, 
    n=6.4);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述.
</p>
</html>"));
end AISI_12L14;