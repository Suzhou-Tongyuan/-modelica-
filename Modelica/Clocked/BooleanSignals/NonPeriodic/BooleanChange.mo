within Modelica.Clocked.BooleanSignals.NonPeriodic;
block BooleanChange "指示布尔信号变化"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.BooleanInput u 
    "布尔输入信号连接器。" 
    annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y 
    "布尔输出信号连接器。" 
    annotation (Placement(transformation(extent = {{100,-10},{120,10}})));

equation
  if firstTick() then
    y = false;
  else
    y = not (u == previous(u));
  end if;

  annotation (
    Icon(graphics={
      Text(
        extent = {{-90,36},{90,-36}}, 
        textColor = {160,160,164}, 
        textString = "change()")}), 
    Documentation(info="<html><p>
这个模块是 <a href=\"modelica://Modelica.Blocks.Math.BooleanChange\" target=\"\">Modelica.Blocks.Math.BooleanChange</a>&nbsp; 的同步版本。 它使用 <code>previous</code> 而不是 <code>change</code> 的隐式 <code>pre</code> 来设置 布尔输出 <code>y</code>，当布尔输入 <code>u</code> 发生变化时，将 <code>y</code> 设置为 <code>true</code>。 因此，它的逻辑是：
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
<span style=\"color: rgb(51, 51, 51);\"><strong>当时钟离散时间分区的</strong></span><code><strong>change</strong></code><span style=\"color: rgb(51, 51, 51);\"><strong>语义得到放宽并明确定义时，这个模块可能是多余的，可以由 </strong></span><code><strong>Modelica.Blocks.Math.BooleanChange</strong></code><span style=\"color: rgb(51, 51, 51);\"><strong>替代。</strong></span>
</p>
</html>"));
end BooleanChange;