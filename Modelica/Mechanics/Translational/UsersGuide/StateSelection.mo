within Modelica.Mechanics.Translational.UsersGuide;
class StateSelection "状态选择"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
Translational库的组件中只有很少一部分使用der(&hellip;)运算符，因此它们可以有具有状态的能力。
最重要的是，组件<a href=\"modelica://Modelica.Mechanics.Translational.Components.Mass\">Mass</a>
将该组件的绝对位置和绝对速度定义为状态的候选变量。在“高级”菜单中，可以设置内置的StateSelect枚举来定义将这些变量用作状态的优先级。
在没有进一步操作的情况下，大多数情况工具将选择这些变量作为状态。
</p>

<p>
对于旨在定位负载的定位传动，组件的绝对位置是有界的，
因此下面讨论的问题不存在。
</p>

<p>
对于旨在控制负载速度的驱动传动，
组件的绝对位置在操作过程中会迅速增加。
这是关键的，因为时间积分器的步长控制可能不再适当。
</p>

<p>
具有步长控制的积分器会自动调整其时间步长
以满足用户定义的误差界限(“容差”)。
通常，本地误差估计值 <var>EST<sub>i</sub></var> 与混合绝对和相对误差的界限进行比较。
</p>

<blockquote><pre>
EST_i &le; abstol_i + reltol_i*|x_i|
</pre></blockquote>

<p>
这里，abstol_i和reltol_i分别表示状态变量x<sub>i</sub>的绝对误差和相对误差的界限。
由于混合误差界限比基于纯相对误差的误差界限更加稳健，所以通常使用相同的相对容差reltol来处理所有状态，
并且使用相对容差和状态的名义值计算绝对容差：
</p>

<blockquote><pre>
reltol_i = reltol
abstol_i = reltol*x_i(nominal)*0.01
</pre></blockquote>

<p>
如果状态变量x<sub>i</sub>的增长没有界限(例如对于驱动传动)，那么此错误控制将失败，因为允许的误差也将无限增长。
其结果是，该变量的误差控制实际上被关闭。正确处理此问题的方法是在此类状态变量上设置reltol<sub>i</sub>=0，并仅使用绝对容差进行步长控制。
</p>

<p>
在库设计时，还没有在Modelica中提供此信息的可能性。
为了减少这种影响，建议不要使用绝对位置，而是使用相对位置作为状态。用户可以通过组件<a href=\"modelica://Modelica.Mechanics.Translational.Components.RelativeStates\">RelativeStates</a>明确地定义相对变量作为状态。
此外，为兼容所有组件，例如<a href=\"modelica://Modelica.Mechanics.Translational.Components.SpringDamper\">SpringDamper</a>都将相对位置和相对速度定义为首选状态。
因此，在大多数情况下，工具将选择相对位置作为状态。
</p>

<p>
兼容组件的相对位置通常很小。
在没有进一步操作的情况下，误差控制在如此小的变量上将无法正常工作(因此经常关闭误差控制)。解决方法是在相对位置上明确定义名义值。此定义在兼容组件的“高级”菜单中提供，参数为“s_nominal”。
默认值为1e-4&nbsp;m，以符合驱动的弯曲顺序。
</p>
</html>"));
end StateSelection;