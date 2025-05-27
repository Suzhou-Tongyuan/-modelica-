within Modelica.Electrical.Analog.Sources;
model TableCurrent "线性插值表电流源"
  extends Interfaces.CurrentSource;
  parameter Real table[:,:] = [0, 0; 1, 1; 2, 4] 
    "表格矩阵(时间位于第一列，电流位于第二列";
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(points = {{-66, -36}, {-66, 84}, {34, 84}, {34, -36}, 
    {-66, -36}, {-66, -6}, {34, -6}, {34, 24}, {-66, 24}, {-66, 54}, {34, 54}, {
    34, 84}, {-16, 84}, {-16, -37}}, color = {192, 192, 192})}), 
    Documentation(info = "<html>
<p>这个电流源使用了Modelica.Blocks.Sources库中相应的信号源。关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。
</p>

<p><br>这个块通过<strong>线性插值</strong>在表格中生成一个电流源。时间点和电流值存储在一个矩阵<strong>table[i,j]</strong>中，其中第一列table[:,1]包含时间点，而第二列包含需要插值的电流值。表格插值具有以下特性：

<ul>
<li>时间节点需要<strong>单调递增</strong>；
</li>
<li>允许在表格中<strong>重复给出相同</strong>的时间点，以表示某个时间点上出现了间断点或跳跃，而不是连续的变化；
</li>

<li>如果要查询的值<strong>超出了</strong>表格中的范围，那么这个值将通过表格中的最后一对或前两对数据点进行<strong>外推</strong>计算得到。这意味着，如果要查询的值比表格中最大的值还要大，或比表格中最小的值还要小，那么就会使用表格中最后两个数据点(或最前两个数据点)的趋势来估算这个值；
</li>

<li>如果表格中<strong>只有一行</strong>，则不会进行插值运算，而是直接返回当前值，无论实际时间点如何，即这是一个常量电流源。
</li>

<li>通过参数<strong>startTime</strong>和<strong>offset</strong>，可以沿时间和电流轴上移动由表格定义的曲线。
</li>

<li>该表以数值上可靠的方式实现，通过在间隔边界生成<strong>时间事件</strong>来实现。这为积分器生成了连续可微的值。
</li>

</ul>
<p>示例：</p>
<blockquote><pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the current i =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the current i =  2.5,
    e.g., time = 2.0, the current i =  4.0,
    e.g., time = 5.0, the current i = 23.0 (i.e., extrapolation).
</pre></blockquote>
<p><br>这个电流源使用了Modelica.Blocks.Sources库中相应的信号源。关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TableCurrent.png\"
     alt=\"TableCurrent.png\">
</div>
</html>", 
    revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>"));
end TableCurrent;