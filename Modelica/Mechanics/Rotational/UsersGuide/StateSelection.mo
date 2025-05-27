within Modelica.Mechanics.Rotational.UsersGuide;
class StateSelection "状态选择"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html><p>
旋转库的只有少数组件使用了 der(…) 运算符， 因此可能有部分组件含有状态。最重要的是， 组件<a href=\"modelica://Modelica.Mechanics.Rotational.Components.Inertia\" target=\"\">Inertia</a>将该组件的绝对旋转角度和绝对角速度作为状态的候选变量进行了定义。在“高级”菜单中，内置的 StateSelect 枚举变量可以设置使用这些变量作为状态的优先级。在大多数情况下，如果没有进一步的操作，系统将自动选择这些变量的值作为状态。
</p>
<p>
对于定位驱动系统，目标是定位负载(例如机器人的传动系统或电梯的传动系统)，组件的绝对角度是有界的，并且下面讨论中不涉及这个方面。
</p>
<p>
对于驱动系统，目标是控制负载的速度(例如车辆的传动系统或发动机的曲轴角度)，在操作过程中，组件的绝对角度会快速增加。这是至关重要的，因为这样来看，时间积分器的步长控制可能不再适当。
</p>
<p>
具有步长控制的积分器会自动调整其时间步长大小，以满足用户定义的误差界限(\"公差\")。通常，局部误差估计 EST_i 与绝对误差和相对误差的混合界限进行比较。
</p>
<pre><code >EST_i ≤ abstol_i + reltol_i*|x_i|
</code></pre><p>
这里，abstol_i 和 reltol_i 分别表示状态变量 x_i 的绝对误差和相对误差的界限。 使用这种混合误差界限是因为如果名义值 x_i (非常)接近 0，比起基于纯相对误差的误差界限更加稳健。 在 Modelica 仿真模型中，通常所有状态都使用相同的相对公差 reltol，并且绝对公差是使用相对公差和状态的名义值计算的：
</p>
<pre><code >reltol_i = reltol
abstol_i = reltol*x_i(nominal)*0.01
</code></pre><p>
如果状态变量 x_i 没有界限地增长(例如在驱动系统或车辆曲轴角度)，则此错误控制会导致失败，因为此时允许的误差也会无界增长。结果是对该变量的误差控制实际上被关闭了。 正确处理的方法是在这样的状态变量上设置reltol_i=0，并且仅对步长的控制使用绝对公差。
</p>
<p>
在库设计时，还没有在Modelica提供此信息的可能性。为了减少这种影响，建议不要使用绝对角度，而是使用相对角度作为状态。用户可以通过组件 <a href=\"modelica://Modelica.Mechanics.Rotational.Components.RelativeStates\" target=\"\">RelativeStates</a> 明确定义相对变量作为状态。 此外，所有符合规范的组件，例如 <a href=\"modelica://Modelica.Mechanics.Rotational.Components.SpringDamper\" target=\"\">SpringDamper</a>， 都将相对角度和相对角速度定义为首选状态。 因此，工具在大多数情况下将选择相对角度作为状态。
</p>
<p>
符合规范的组件的相对角度通常很小。例如，典型弹性组件的变形量为 1e-4 rad。 如果不采取进一步的措施，误差控制将无法正确地在如此小的变量上工作(因此经常关闭误差控制)。解决方法是在相对角度上明确定义一个名义值。此定义在符合规范的组件的“高级”菜单中提供，使用参数“phi_nominal”。 默认值为 1e-4 rad，以便与驱动的弹性变形量数量级相符。对于某些组件，例如 <a href=\"modelica://Modelica.Mechanics.Rotational.Components.Clutch\" target=\"\">Clutch</a>，这可能太小了，此时phi_nominal=1rad的值可能更合适(phi_nominal=1e-4rad不会有问题，但只是使误差控制变得不必要严格)。
</p>
<p>
<br>
</p>
</html>"));
end StateSelection;