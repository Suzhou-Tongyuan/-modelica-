within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.PureIron;
record RFe80 "Hyperm 0 (RFe80)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=123, 
    B_myMax=1.27, 
    c_a=44410, 
    c_b=6.4, 
    n=10);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述。
</p>
<p>
B(H)特性来源:产品目录<em>Magnequench</em>， 2000
</p>
</html>"));
end RFe80;