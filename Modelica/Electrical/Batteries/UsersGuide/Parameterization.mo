within Modelica.Electrical.Batteries.UsersGuide;
class Parameterization "电池模型的参数化"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
来自<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks\">BatteryStacks</a>的<strong>堆栈</strong>由<code>Ns*Np</code><strong>相同的单元</strong>构建，
其中<code>Np</code>描述了并联连接的单元数量，<code>Ns</code>描述了串联连接的单元数量。
</p>
<p>
由<code>Np*Ns</code>相同单元构建的堆栈的参数计算如下：
</p>
<table>
<tr><td>描述</td>             <td>单元</td>         <td>堆栈</td></tr>
<tr><td>名义OCV</td>             <td><code>OCVmax</code></td> <td><code>OCVmax*Ns</code></td></tr>
<tr><td>放电终点电压</td><td><code>OCVmmin</code></td><td><code>OCVmin*Ns</code></td></tr>
<tr><td>容量</td>                <td><code>Qnom</code></td>   <td><code>Qnom*Np</code></td></tr>
<tr><td>内部电阻</td>        <td><code>Ri</code></td>     <td><code>Ri*Ns/Np</code></td></tr>
</table>
<h4>单元参数</h4>
<p>
一个单元的参数总结在参数记录<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a>中。
OCV对SOC的依赖性可以选择线性(<code>useLinearSOCDependency=true</code>)或基于查找表。<br>
默认情况下，定义了线性的OCV与SOC特性(类似于电容器)，即<code>OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1]</code>。<br>
OCV对SOC的查找表必须用第1列=升序的SOC值，第2列=相应的OCV值与OCVmax相关。<br>
在进行表插值时，请小心使用参数<code>smoothness</code>，检查所得到的特性。<br>
OCV的其他依赖关系(例如温度)不予考虑，这将需要二维表查找。
</p>
<p>
自放电被指定为在<code>SOC=SOCmax</code>时的放电电流<code>Idis</code>。从这些值中，计算自放电电导。<br>
如果应忽略自放电，请将<code>Idis=0</code>。
</p>
<p>
内部电阻的线性温度依赖性可以由参考温度<code>T_ref</code>和温度系数<code>alpha</code>指定：<br>
<code>R = R_ref*(1 + alpha*(T - T_ref))</code>。
</p>
<h4>瞬态参数</h4>
<p>
瞬态电池模型的一个单元的参数记录<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData\">cellData</a>
从<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">基本cellData</a>记录扩展，添加了附加RC元素的参数。
这些是由参数记录<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a>的数组指定的：
</p>
<ul>
<li><code>R</code> .. RC元件的电阻</li>
<li><code>C</code> .. RC元件的电容</li>
</ul>
<p>
<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a>数组的大小必须作为参数<code>nRC</code>定义。
这些RC元件的参数是经过精密测量的结果，例如电池阻抗谱分析。<br>
电阻的温度依赖性假定与内部电阻<code>Ri</code>相同。
</p>
<h4>锂离子电池的典型参数</h4>
<table>
<tr><td>充电终点电压</td>   <td>&nbsp;</td>              <td>4.2 V</td></tr>
<tr><td>名义电压</td>         <td>&nbsp;</td>              <td>3.6 V</td></tr>
<tr><td>放电终点电压</td><td><code>OCVmmin</code></td><td>2.5 V</td></tr>
</table>
<p>
容量(即名义电荷)<code>Qnom</code>，内部电阻<code>Ri</code>和短路电流<code>Isc</code>取决于电池尺寸。<br>
某种电池尺寸的典型(估计)值，例如：
</p>
<table>
<tr><td>容量</td>             <td><code>Qnom</code></td><td>5 A.h</td></tr>
<tr><td>内部电阻</td>     <td><code>Ri</code></td>  <td>3 m&Omega;</td></tr>
</table>
<p>
自放电率通常为每月1%。
</p>
<h4>从<code>Ns</code> x <code>Np</code>单元矩阵构建的堆栈的参数：</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors\">BatteryStacksWithSensors</a>中的<strong>堆栈</strong>是由<code>Ns*Np</code>单元构建的
排列在一个矩阵中，其中<code>Np</code>描述了并联连接的单元数量，<code>Ns</code>描述了串联连接的单元数量。
这样一个堆栈的参数总结在参数记录<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.StackData\">stackData</a>中。
这里编译了<code>Ns</code> x <code>Np</code>单元参数记录的矩阵。
<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">原始单元数据</a>的参数传播到除了那些
在数组<code>kDegraded[:,2]</code>中指定索引的单元之外的所有单元。
对于这些退化单元，传播<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">退化单元数据</a>的参数。<br>
<strong>注意：</strong>参数数组<code>kDegraded[:,2]</code>的任何成员都会被忽略范围外的范围<code>1&le;kDegraded[:,1]&le;Ns</code>和<code>1&le;kDegraded[:,2]&le;Np</code>。
</p>
</html>"));
end Parameterization;