within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.ElectricSheet;
record M530_50A "M530-50A (1.0813) @ 50Hz"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=2120, 
    B_myMax=1.25, 
    c_a=12400, 
    c_b=1.6, 
    n=13.5);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material. SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述。
</p>
<p>
样品:薄板带<br>
测量:爱泼斯坦框架
</p>
</html>"));
end M530_50A;