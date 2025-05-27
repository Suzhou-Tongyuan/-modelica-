within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.PureIron;
record VacoferS2 "VACOFER S2 (99.95% Fe)"
  extends FluxTubes.Material.SoftMagnetic.BaseData(
    mu_i=2666, 
    B_myMax=1.15, 
    c_a=187000, 
    c_b=4.24, 
    n=19);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic\">SoftMagnetic</a>有关本封装的所有软磁材料特性的描述。
</p>
<dl>
<dt>B(H)特性的来源:</dt>
    <dd><p><em>Boll, R.</em>: 软磁性材料:VAC材料在磁性中的应用，第四版，柏林，慕尼黑:西门子Aktiengesellschaft 1990。</p>
    </dd>
</dl>
</html>"));
end VacoferS2;