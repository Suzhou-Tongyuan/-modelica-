within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M940_100A "M940-100A @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=680, 
    B_myMax=1.26, 
    c_a=17760, 
    c_b=3.13, 
    n=13.9);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述。
</p>
<p>
样品:薄板带<br>
测量:爱泼斯坦框架
</p>
</html>"));
end M940_100A;