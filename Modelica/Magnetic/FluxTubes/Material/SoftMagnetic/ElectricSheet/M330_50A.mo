within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M330_50A "M330-50A (1.0809) @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=500, 
    B_myMax=0.7, 
    c_a=24000, 
    c_b=9.38, 
    n=9.6);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material. SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述.
</p>
<p>
样品:经过加工和封装后的完整芯<br>
</p>
</html>"));
end M330_50A;