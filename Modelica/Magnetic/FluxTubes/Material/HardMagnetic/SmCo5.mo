within Modelica.Magnetic.FluxTubes.Material.HardMagnetic;
record SmCo5 "烧结SmCo5，示例值"
  extends FluxTubes.Material.HardMagnetic.BaseData(
    H_cBRef=720000, 
    B_rRef=0.95, 
    T_ref=20 + 273.15, 
    alpha_Br=-0.0004);
  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a>查看本封装的所有永磁材料特性的描述。
</p>
</html>"));
end SmCo5;