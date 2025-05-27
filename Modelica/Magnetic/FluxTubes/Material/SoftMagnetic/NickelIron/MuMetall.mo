within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.NickelIron;
record MuMetall "MUMETALL (77% NiFe)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=27300, 
    B_myMax=0.46, 
    c_a=1037500, 
    c_b=3.67, 
    n=10);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述.
</p>
<p>
B(H)特性的来源:
</p>
<ul>
<li><em>Boll, R.</em>: 软磁性材料:VAC材料在磁性中的应用，第四版，柏林，慕尼黑:西门子Aktiengesellschaft 1990。</li>
</ul>
</html>"));
end MuMetall;