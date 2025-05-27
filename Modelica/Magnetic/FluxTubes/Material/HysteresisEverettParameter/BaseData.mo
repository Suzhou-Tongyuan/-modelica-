within Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter;
record BaseData "基础数据记录"
  extends Modelica.Icons.Record;
  parameter SI.MagneticFieldStrength Hsat=100 
    "-Hsat ... Hsat 之间的滞后区域";
  parameter Real M(final unit="1")=0.95 
    "与磁化饱和值有关";
  parameter Real r(final unit="1")=0.55 
    "Hc 附近直线区域的比例";
  parameter Real q(final unit="m/A")=2.4e-1 
    "Hc 附近直线区域的斜率";
  parameter Real p1(final unit="m/A")=1.2e-1 "主要环路的清晰度";
  parameter Real p2(final unit="m/A")=8e-1 "主要环路的清晰度";
  parameter SI.MagneticFieldStrength Hc=7.4 "主要回路矫顽力";
  parameter Real K(final unit="1")=1 
    "饱和区域的斜率 mu_0*K";
  parameter SI.Conductivity sigma = 1 
    "材料的导电性";

  annotation (Documentation(info="<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisEverettParameter/hyst_BaseData.png\">
   </td>
  </tr>
</table>
</html>"));
end BaseData;