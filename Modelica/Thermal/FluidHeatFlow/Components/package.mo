within Modelica.Thermal.FluidHeatFlow;
package Components "基本部件(管道、阀门)"
  extends Modelica.Icons.Package;
  annotation (Documentation(info="<html><p>
该子库包含组件。
</p>
<p>
压降取自局部模型SimpleFriction。 热力学方程在局部模型中定义(baseclass包)。
</p>
</html>"), 
         Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
    Polygon(
      origin = {6,40}, 
      lineColor = {0,0,255}, 
      fillColor = {0,128,255}, 
      fillPattern = FillPattern.Solid, 
      points = {{-56,10},{-56,-90},{-6,-40},{44,10},{44,-90},{-56,10}}), 
    Polygon(
      origin = {6,40}, 
      lineColor = {0,0,127}, 
      fillColor = {0,0,127}, 
      fillPattern = FillPattern.Solid, 
      points = {{-16,10},{4,10},{-6,-10},{-16,10}}), 
    Line(
      origin = {6,40}, 
      points = {{-6,-10},{-6,-40},{-6,-38}}, 
      color = {0,0,127})}));
end Components;