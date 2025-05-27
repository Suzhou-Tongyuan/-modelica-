within Modelica.Mechanics.MultiBody.Visualizers;
package Colors "颜色操作函数库"
  extends Modelica.Icons.FunctionsPackage;

  annotation(Documentation(info = "<html>
<p>
该包含有操作颜色的函数。
注意，颜色被表示为一个包含3个元素的Real数组，其中的元素是RGB颜色模型的红色、绿色、蓝色值。
每个元素必须在0&nbsp;&hellip;&nbsp;255的范围内。
颜色的类型是Real而不是Integer，这样可以在模型中使用颜色时更少地出现问题，因为在模型中Integer类型只能在when子句中使用。
颜色值的典型声明方式：</p>

<blockquote><pre>
Realcolor[3](eachmin=0,eachmax=255);
</pre></blockquote>

<p>
这个定义也可以作为类型<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.RealColor\">Modelica.Mechanics.MultiBody.Types.RealColor</a>来使用。
</p>
</html>"));
end Colors;