within Modelica.Magnetic.FluxTubes.Shapes;
package Force "带磁阻力的磁通管；恒定磁导率"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
<p>
请查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReluctanceForceCalculation\">UsersGuide.ReluctanceForceCalculation</a>的不同磁通管类别和产生的子包的解释.
</p>
<p>
磁通管元件可产生磁阻力，分别用于平移推杆中与位置相关的气隙部分和永磁体部分的建模。默认情况下，机械连接器法兰.s 的位置坐标与封装磁通管元件的尺寸 l 相同。如有必要，可以用执行机构的特定等式来代替 l=flange.s 的特性，例如，当磁通管长度随电枢位置的减小而增加时。在大多数情况下，元件平移接头法兰 s 的位置坐标与电枢位置 x 相同，如以下示例所示.</p>
<p>
每个元件的磁导率对电枢位置<code>dGmBydx</code>的导数由磁通管的磁导率对其变化尺寸dGmBydl的导数和该尺寸对电枢位置<code>dlBydx</code>的导数计算得到。:</p>

<blockquote><pre>
dG_m   dG_m   dl
---- = ---- * --
 dx     dl    dx
</pre></blockquote>

<p>
必须根据电枢坐标的定义和元件在设备磁路中的位置，将每个磁通管元件中的参数 <code>dlBydx</code> 设置为 +1 或 -1。电枢运动与磁通管长度变化之间的适当匹配可确保元件磁阻力的作用方向正确.
</p>
<p>
在这个包中定义的磁通管的形状相当简单。只有一个维度随电枢运动而变化。可以通过扩展基类 <a href=\"modelica://Modelica.Magnetic.FluxTubes.BaseClasses.Force\">BaseClasses. Force</a>。对于这些通量管，解析导数dGmBydl的测定可能会变得更加复杂.
</p>
</html>"));
end Force;