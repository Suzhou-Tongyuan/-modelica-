within Modelica.Clocked.IntegerSignals.NonPeriodic;
block IntegerChange "显示整数信号变化"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.IntegerInput u(start = 0) 
    "整数输入信号连接器" 
    annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y 
    "布尔输出信号连接器" 
    annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));

equation
  if firstTick() then
    y = false;
  else
    y = not (u == previous(u));
  end if;

  annotation(
    Icon(graphics = {
    Text(
    extent = {{-90, 36}, {90, -36}}, 
    textColor = {160, 160, 164}, 
    textString = "change()")}), 
    Documentation(info="<html><p>
这个模块是<a href=\"modelica://Modelica.Blocks.Math.IntegerChange\" target=\"\">Modelica.Blocks.Math.IntegerChange</a>&nbsp;的同步版本。 它使用 <code>previous</code> 而不是 <code>change</code> 的隐含 <code>pre</code>， 用于设置布尔输出 <code>y</code>， 在整数输入 <code>u</code> 发生变化时为 <code>true</code>。 因此，它的逻辑是：
</p>
<p>
<br>
</p>
<pre><code >if firstTick() then
  y = false;
else
  y = not (u == previous(u));
end if;
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\"><strong>当时钟离散时间分区的</strong></span><code>change</code><strong> </strong><span style=\"color: rgb(51, 51, 51);\"><strong>语义放宽并明确定义时，该模块可能是多余的，可以被 </strong></span><code><strong>Modelica.Blocks.Math.IntegerChange</strong></code><span style=\"color: rgb(51, 51, 51);\"><strong> 替代。</strong></span>
</p>
<p>
<br>
</p>
</html>"));
end IntegerChange;