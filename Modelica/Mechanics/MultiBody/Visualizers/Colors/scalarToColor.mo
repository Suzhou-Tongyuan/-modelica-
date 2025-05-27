within Modelica.Mechanics.MultiBody.Visualizers.Colors;
function scalarToColor "将标量映射到颜色，使用颜色映射"
  extends Modelica.Icons.Function;

  input Real T "标量值" annotation(Dialog);
  input Real T_min "T<=T_min映射到colorMap[1,:]" annotation(Dialog);
  input Real T_max "T>=T_max映射到colorMap[end,:]" annotation(Dialog);
  input Real colorMap[:,3] "颜色映射" annotation(Dialog);
  output Real color[3] "标量值T对应的颜色";
algorithm
  /* 旧版本，可能会出错
  color :=colorMap[integer((size(colorMap, 1) - 1)/(T_max - T_min)*
  min((max(T,T_min) - T_min), T_max) + 1), :];
  */
  color := colorMap[1 + integer((size(colorMap, 1) - 1) * (max(T_min, min(T, T_max)) - T_min) 
    / (T_max - T_min)),:];
  annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
//RealT,T_min,T_max,colorMap[:,3];
Colors.<strong>scalarToColor</strong>(T,T_min,T_max,colorMap);
</pre></blockquote>
<h4>描述</h4>
<p>
此函数返回一个rgb颜色Real[3]，对应于\"T\"的值。
颜色是通过插值从colorMap中选择的，以便\"T_min\"对应于\"colorMap[1,:]\"，并且\"T_max\"对应于\"colorMap[end,:]\"。
</p>

<h4>另请参阅</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">PipeWithScalarField</a>.

</html>"));
end scalarToColor;