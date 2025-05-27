within Modelica.Magnetic.FluxTubes.Material.HardMagnetic;
record PlasticHardFerrite "塑料结合的硬铁氧体，示例值"
  extends FluxTubes.Material.HardMagnetic.BaseData(
    H_cBRef=130000, 
    B_rRef=0.21, 
    T_ref=20 + 273.15, 
    alpha_Br=-0.002);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a>查看本封装的所有永磁材料特性的描述。
</p>
</html>"));
end PlasticHardFerrite;