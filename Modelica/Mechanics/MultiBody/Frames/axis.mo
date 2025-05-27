within Modelica.Mechanics.MultiBody.Frames;
function axis "返回x轴、y轴或z轴的单位矢量"
  extends Modelica.Icons.Function;
  input Integer axis(min=1, max=3) "要返回的轴矢量";
  output Real e[3](each final unit="1") "单位轴矢量";
algorithm
  e := if axis == 1 then {1,0,0} else (if axis == 2 then {0,1,0} else {0,0,1});
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
e = Frames.<strong>axis</strong>(axis);
</pre></blockquote>

<h4>描述</h4>
<p>
根据需要返回x轴、y轴或z轴的单位矢量&nbsp;e。
</p>
<blockquote><pre>
 axis  |    e
-------+-----------
  1    |  {1,0,0}
  2    |  {0,1,0}
  3    |  {0,0,1}
</pre></blockquote>
</html>"));
end axis;