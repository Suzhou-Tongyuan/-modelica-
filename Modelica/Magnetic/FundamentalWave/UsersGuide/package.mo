within Modelica.Magnetic.FundamentalWave;
package UsersGuide "用户指南"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
这个库包含了电磁基波建模的组件
多相应用的模型
<a href=\"modelica://Modelica.Magnetic.FundamentalWave. BasicMachines\">electric machines</a>。
阶段的数量不限于三个。直流机器(目前)不包括在内
在这个图书馆。FundamentalWave库是
<a href=\"modelica://Modelica.Electrical.Machines\">Modelica.Electrical. Machines</a>库机器。
这个库的一大优点是严格的面向对象的电气和
组成电机模型的磁性元件。
从教学的角度来看，这个图书馆对学生非常有益
电气工程领域。
</p>

<p>
有关更多详细信息，请参阅<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Concept\">.</a>
</p>

<h5>Note</h5>

<ul>
<li>本库中所提供的电机模型均为等效的两极电机。
因此，连接器的磁电位差也指等效的两极机</li>
<li>在<strong>大于三相</strong>的机器中，只考虑电流和电压对磁性<strong>基波</strong>的影响。其他由高次谐波引起的磁效应不考虑在内.</li>
</ul>

</html>"));
end UsersGuide;