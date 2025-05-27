within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.CobaltIron;
record Vacoflux50 "Vacoflux 50 (50% CoFe)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=3850, 
    B_myMax=1.75, 
    c_a=11790, 
    c_b=2.63, 
    n=15.02);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述。
</p>
<p>
B(H)特性来源:VACUUMSCHMELZE GmbH &德国KG公司
</p>
</html>"));
end Vacoflux50;