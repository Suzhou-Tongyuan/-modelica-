within Modelica.Electrical.Analog.Sources;
model TableVoltage "线性插值表电压源"
  extends Interfaces.VoltageSource;
  parameter Real table[:,:] = [0, 0; 1, 1; 2, 4] 
    "表格数据(时间位于第一列，电压位于第二列)";

  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {Line(points = {{-58, -36}, {-58, 84}, {42, 84}, {42, -36}, 
    {-58, -36}, {-58, -6}, {42, -6}, {42, 24}, {-58, 24}, {-58, 54}, {42, 54}, {
    42, 84}, {-8, 84}, {-8, -37}}, color = {192, 192, 192})}), 
    Documentation(info = "<html>
<p>这个电压源使用了Modelica.Blocks.Sources库中相应的信号源。关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。
</p>

<p><br>这个模块通过在表格中进行</strong>线性插值</strong>来生成一个电压源。时间点和电压值存储在一个矩阵表格<strong>table[i,j]</strong>中，其中第一列<strong>table[i,j]</strong>包含时间点，第二列包含要进行插值的电压值。表格插值具有以下属性：
<ul>

<li>表格中的时间点必须是按<strong>时间顺序</strong>排列的;
</li>

<li>允许存在<strong>不连续性</strong>，可以通过在表格中重复提供同一时间点来实现；
</li>

<li>当要查找的时间点<strong>不在插值表格的范围内</strong>时，可以通过对表格末尾或最开始两个点的<strong>外推</strong>来计算该时间点对应的值。
</li>

<li>如果插值表只有<strong>一行</strong>，那么我们无法执行任何插值运算，因为插值需要至少两个数据点才能进行。在这种情况下，我们只能直接返回表中唯一一行的电压值，而不考虑实际的时间点。
</li>

<li>通过参数<strong>startTime</strong>和<strong>offset</strong>，可以沿时间和电压轴对曲线进行平移。
</li>

<li>该表是通过在时间间隔的边界生成<strong>时间事件</strong>来实现的，这保证了积分器产生连续可微分的值。这意味着，当我们对表进行插值时，得到的函数值是连续可微分的，这在数值计算中是非常重要的。
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
If, e.g., time = 1.0, the voltage v =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the voltage v =  2.5,
    e.g., time = 2.0, the voltage v =  4.0,
    e.g., time = 5.0, the voltage v = 23.0 (i.e., extrapolation).
</pre></blockquote>

<p><br>这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。 
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/TableVoltage.png\"
     alt=\"TableVoltage.png\">
</div>
</html>", 
    revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>"));
end TableVoltage;