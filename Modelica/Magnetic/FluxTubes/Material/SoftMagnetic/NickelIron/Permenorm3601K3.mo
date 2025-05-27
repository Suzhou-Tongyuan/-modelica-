within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.NickelIron;
record Permenorm3601K3 "PERMENORM 3601 K3 (36% NiFe)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=3000, 
    B_myMax=0.67, 
    c_a=50000, 
    c_b=2.39, 
    n=9.3);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material. SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述。
</p>
<p>
B(H)特性的来源:
</p>
<ul>
<li><em>Boll, R.</em>: 软磁性材料:VAC材料在磁性中的应用，第四版，柏林，慕尼黑:西门子Aktiengesellschaft 1990。</li>
</ul>
</html>"));
end Permenorm3601K3;