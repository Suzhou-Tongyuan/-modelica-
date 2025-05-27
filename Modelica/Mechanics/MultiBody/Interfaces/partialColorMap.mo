within Modelica.Mechanics.MultiBody.Interfaces;
partial function partialColorMap 
  "返回颜色映射的函数接口"
  extends Modelica.Icons.Function;
  input Integer n_colors=64 "颜色映射中的颜色个数";
  output Real colorMap[n_colors,3] "颜色映射，将标量映射到颜色";
  annotation (Documentation(info="<html>
<p>
此部分函数定义了返回颜色映射的函数接口。预定义的颜色映射函数在包
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps</a>
中定义。
</p>
</html>"));
end partialColorMap;