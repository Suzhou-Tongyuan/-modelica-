within Modelica.Mechanics.Rotational.UsersGuide;
class ModelingOfFriction "摩擦建模"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
该库的几个元素使用以下方法对<strong>库仑摩擦</strong>进行建模:
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>基于同步数据流原理的 Modelica 混合建模</strong>。CACSD'99，1999 年 8 月 22 日至 26 日，夏威夷。</dd>
</dl>

<p>
摩擦方程在基础模型<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialFriction\">Interfaces.PartialFriction</a>中定义。
以下是说明。
</p>

<p>
首先假设最简单的摩擦问题：一个块在表面上滑动。
摩擦力 f 作用在物体表面和环境表面之间，并且应该是相对速度v的线性函数。
当相对速度变为零时，两个表面粘在一起，摩擦力不再是v的函数。如果摩擦力大于最大静摩擦力f_0（在下面的方程中用 <code>f0</code> 表示），
则该元素再次开始滑动。此元素可以使用参数化曲线描述，并导致以下方程：
</p>

<blockquote><pre>
forward  = s &gt;  1;
backward = s &lt; -1;
v = if forward  then s-1 elseif backward then s+1 else 0;
f = if forward  then  f0 + f1*(s-1) elseif
       backward then -f0 + f1*(s+1) else f0*s;
</pre></blockquote>

<p>
该模型完全以声明方式描述了简化的摩擦元素。不幸的是，目前尚不清楚如何将这样的元素描述自动转换为可模拟的形式：
</p>

<p>
该块由以下方程描述：
</p>

<blockquote><pre>
m*der(v) = u - f
</pre></blockquote>

<p>
注意，m 是块的质量，u(t) 是给定的驱动力。
如果元素处于其“前向滑动”模式，即 s&nbsp;&ge;&nbsp;1，
则该模型描述为：
</p>

<blockquote><pre>
m*der(v) = u - f
       v = s - 1
       f = f_0 + f_1*(s-1)
</pre></blockquote>

<p>
可以将其轻松转换为状态空间形式，其中 v 是状态。
如果块被卡住，即 -1&nbsp;&le;&nbsp;s&nbsp;&le;&nbsp;1，
方程 v&nbsp;=&nbsp;0 将变为激活状态，因此 v 不能再是状态，即索引发生变化。
除了处理变量状态变化的困难外，还存在一个更严重的问题：
</p>

<p>
假设块被卡住，并且s将大于一。
在事件发生之前，s&nbsp;&le;&nbsp;1 且 v&nbsp;=&nbsp;0；
在事件s&nbsp;&gt;&nbsp;1，瞬间 因为这个关系是事件触发条件。
该元素切换到正向滑动模式，其中 v 是一个状态，其初始化为其上一个值 v&nbsp;=&nbsp;0。
由于 v 是一个状态，通过 s&nbsp;:=&nbsp;v&nbsp;+&nbsp;1 计算 s，
结果为 s&nbsp;=&nbsp;1，即关系 s&nbsp;&gt;&nbsp;1 变为 false，元素切换回卡住模式。
换句话说，永远不可能切换到正向滑动模式。考虑到数值误差，情况甚至更糟。
</p>

<p>
解决方案的关键在于观察到在卡住模式和正向滑动开始时 v&nbsp;=&nbsp;0，
但当滑动开始时 der(v)&nbsp;&gt;&nbsp;0，而在卡住的状态下 der(v)&nbsp;=&nbsp;0。
由于零速度时的摩擦特性没有功能关系，因此再次必须使用带有新的曲线参数 s_a（下面也称为 <code>sa</code>）的参数化曲线描述，
导致以下方程（注意：速度为零时）：
</p>

<blockquote><pre>
startFor  = sa &gt;  1;
startBack = sa &lt; -1;
        a = der(v);
        a = if startFor then sa-1 elseif startBack then sa+1 else 0;
        f = if startFor then  f0  elseif startBack then  -f0 else f0*sa;
</pre></blockquote>

<p>
在零速度下，这些方程和块的方程形成了一组混合连续/离散方程，必须在事件瞬间解决（例如，通过不动点迭代）。
当从滑动模式切换到卡住模式时，速度很小或为零。
由于约束方程的导数 der(v) = 0 在卡住状态下满足，
即使没有明确考虑到 v = 0，速度仍然保持很小。
使用加速度 der(v) = 0 作为“约束”而不是 v = 0 的方法，在多体软件中经常使用。
好处是速度 v 在所有切换配置中仍然是一个状态（有一个小的线性漂移，但摩擦元素必须在产生足够的线性漂移前保持卡住状态）。
因此，当从卡住模式切换到滑动模式时，v很小但可能具有正负号；
如果摩擦元素开始滑动，比如向前方向，必须等到速度真正为正后才能切换到向前模式（注意，即使在没有数值误差的情况下，
进行准确计算也需要一个“等待”阶段，因为当滑动开始时，v = 0）。
由于 der(v) > 0，这将在一个小的时间段后发生。
这个“等待”过程可以用一个状态机来描述。
将所有部分收集在一起，最终得到了一个简单摩擦元素的以下方程：
</p>

<blockquote><pre>
// part of mixed system of equations
startFor  = pre(mode) == Stuck and sa &gt;  1;
startBack = pre(mode) == Stuck and sa &lt; -1;
        a = der(v);
        a = if pre(mode) == Forward  or startFor  then  sa - 1    elseif
               pre(mode) == Backward or startBack then  sa + 1    else 0;
        f = if pre(mode) == Forward or startFor   then  f0 + f1*v elseif
               pre(mode) == Backward or startBack then -f0 + f1*v else f0*sa;

// state machine to determine configuration
mode = if (pre(mode) == Forward  or startFor)  and v&gt;0 then Forward  elseif
          (pre(mode) == Backward or startBack) and v&lt;0 then Backward else Stuck;
</pre></blockquote>


<p>
以上方法对简化摩擦元素的建模稍微进行了泛化，模型
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialFriction\">Interfaces.PartialFriction</a>：
</p>


<ul>
<li>滑动摩擦力具有非线性特性，而不是线性特性，通过在 f(v) 值的表中进行插值。</li>
<li>从卡住模式切换到滑动模式时，摩擦力可能会跳跃（用参数 peak 描述）。</li>
</ul>

</html>"));
end ModelingOfFriction;