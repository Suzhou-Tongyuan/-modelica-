within Modelica.Magnetic.FluxTubes.Material;
package HysteresisTableData "磁滞数据表"
  extends Modelica.Icons.MaterialPropertiesPackage;
  annotation (Documentation(info="<html>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystTellinenTable\">GenericHystTellinenTable</a>磁通管元素。记录包含两个数据表<code>tabris</code>和<code>tabfal</code>，分别描述了相应材料的滞回包线曲线的上升支路和下降支路。第一列是磁场强度H，必须严格单调递增。第二列为磁通密度b的对应值，两条曲线不能相交。
</p>

<p>
图1和图2显示了基于自己在两个不同磁场强度范围内测量几种钢板质量的库条目。根据DIN EN 60404-2的要求，使用25厘米的爱泼斯坦框架进行测量。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 1:</strong> Static hysteresis envelope curves of several steel sheets</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops01.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 2:</strong> Static hysteresis envelope curves of several steel sheets</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops02.png\">
    </td>
  </tr>
</table>

<p>
图3显示了从<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Va01]</a>中提取的软磁钴铁合金静态磁滞回线库条目。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 3:</strong> Soft magnetic cobalt iron library entries <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Va01]</a></caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HysteresisTableData/StaticLoops03.png\">
    </td>
  </tr>
</table>

</html>"));
end HysteresisTableData;