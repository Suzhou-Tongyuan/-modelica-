within Modelica.Magnetic.FluxTubes.Material.HardMagnetic;
record BaseData "永磁材料数据的记录"
  extends Modelica.Icons.Record;

  parameter SI.MagneticFieldStrength H_cBRef=1 
    "参考温度下的矫顽力";
  parameter SI.MagneticFluxDensity B_rRef=1 
    "参考温度下的剩余物";
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha_Br=0 
    "参考温度下的残余温度系数";

  parameter SI.Temperature T_op=293.15 "工作温度";

  final parameter SI.MagneticFluxDensity B_r=B_rRef*(1 + alpha_Br*(T_op 
       - T_ref)) "Remanence at operating temperature";
  final parameter SI.MagneticFieldStrength H_cB=H_cBRef*(1 + alpha_Br*(
      T_op - T_ref)) "Coercivity at operating temperature";
  final parameter SI.RelativePermeability mu_r=B_r/(mu_0*H_cB) 
    "相对渗透率";

  annotation (Documentation(info="<html>
<p>
请参阅所附包装的说明<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">HardMagnetic</a>查看本封装的所有永磁材料特性的描述。
</p>
</html>"));
end BaseData;