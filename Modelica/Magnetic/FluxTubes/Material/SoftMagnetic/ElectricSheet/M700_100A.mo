within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M700_100A "M700-100A (1.0826) @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=1120, 
    B_myMax=1.2, 
    c_a=20750, 
    c_b=3.55, 
    n=13.15);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述。
</p>
<p>
样品:薄板带<br>
测量:爱泼斯坦框架
</p>
</html>"));
end M700_100A;