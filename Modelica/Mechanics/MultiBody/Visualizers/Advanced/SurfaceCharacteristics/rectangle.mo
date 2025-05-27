within Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics;
function rectangle "定义平面矩形表面特性的函数"
  extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic(
    final multiColoredSurface=false);
  input SI.Distance lu=1 "u方向的长度" annotation(Dialog);
  input SI.Distance lv=3 "v方向的长度" annotation(Dialog);
algorithm
  X[:,:] := lu/2 * transpose(fill(linspace(-1,1,nu), nv));
  Y[:,:] := lv/2 * fill(linspace(-1,1,nv), nu);
  Z[:,:] := fill(0, nu, nv);

  annotation (Documentation(info="<html>
<p>
函数<strong>rectangle</strong>计算X、Y和Z数组以可视化一个矩形，使用模型<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Rectangle\">Rectangle</a>。
下图显示了两个矩形，其中</p>
<blockquote><pre>
nu=8,
nv=3,
lu=3,
lv=2.
</pre></blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Rectangle.png\">
</blockquote>
</html>"));
end rectangle;