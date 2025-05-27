within Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps;
function hot "返回\"hot\"颜色映射"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialColorMap;
protected
  Real a = ceil(n_colors / 3);
  Real d = 1 / a;
  Real v1[:] = 0 + d:d:1;
  Real cm[integer(ceil(n_colors / 3)) * 3,3];
algorithm
  cm := 255 * [v1, zeros(size(v1, 1)), zeros(size(v1, 1));
    fill(1., size(v1, 1)), v1, zeros(size(v1, 1));
    fill(1., size(v1, 1)), fill(1., size(v1, 1)), v1];
  colorMap := cm[1:n_colors,:];

  annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
ColorMaps.<strong>hot</strong>();
ColorMaps.<strong>hot</strong>(n_colors=64);
</pre></blockquote>
<h4>描述</h4>
<p>
该函数返回颜色映射\"hot\"。
颜色映射是一个Real[:,3]数组，其中每一行代表一种颜色。
可选参数\"n_colors\"定义了返回数组的行数。
默认值为\"n_colors=64\"(通常最好n_colors是4的倍数)。
\"hot\"颜色映射的图像：</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Colors/ColorMaps/hot.png\">
</blockquote>

<h4>参见</h4>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.ColorMaps\">ColorMaps</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.colorMapToSvg\">colorMapToSvg</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Colors.scalarToColor\">scalarToColor</a>.
</html>"));
end hot;