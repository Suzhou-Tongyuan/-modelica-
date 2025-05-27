within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Steel;
record DC01 "DC01 (1.0330, previously St2)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=5, 
    B_myMax=1.1, 
    c_a=6450, 
    c_b=3.65, 
    n=7.7);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material. SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述.
</p>
</html>"));
end DC01;