within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M350_50A "M350-50A (1.0810) @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=1210, 
    B_myMax=1.16, 
    c_a=24630, 
    c_b=2.44, 
    n=14);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material. SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述.
</p>
<p>
样品:薄板带<br>
Measurement: Epstein frame
</p>
</html>"));
end M350_50A;