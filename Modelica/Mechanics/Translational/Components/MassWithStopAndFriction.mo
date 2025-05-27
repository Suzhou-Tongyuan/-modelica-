within Modelica.Mechanics.Translational.Components;
model MassWithStopAndFriction 
  "带硬性止动和 Stribeck 摩擦的滑动质量"
  extends PartialFrictionWithStop;
  SI.Velocity v(start = 0, stateSelect = StateSelect.always) 
    "flange_a 和 flange_b 的绝对速度";
  SI.Acceleration a(start = 0) 
    "flange_a 和 flange_b 的绝对加速度";
  parameter SI.Mass m(start = 1) "质量";
  parameter Real F_prop(
    final unit = "N.s/m", 
    final min = 0, 
    start = 1) "速度相关的摩擦";
  parameter SI.Force F_Coulomb(start = 5) 
    "常数摩擦：库仑力";
  parameter SI.Force F_Stribeck(start = 10) "Stribeck 效应";
  parameter Real fexp(
    final unit = "s/m", 
    final min = 0, 
    start = 2) "指数衰减";
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
  Integer stopped 
    "停止模式（-1：flange_a 处硬性止动，0：无止动，+1：flange_b 处硬性止动）";
  encapsulated partial model PartialFrictionWithStop 
    "带止动的库仑摩擦元件的基础模型"

    import Modelica;
    import Modelica.Mechanics.Translational.Interfaces.PartialRigid;
    parameter Modelica.Units.SI.Position smax(start = 25) 
      "滑动质量（滑动端的右端）的右止";
    parameter Modelica.Units.SI.Position smin(start = -25) 
      "滑动质量（滑动端的左端）的左止";
    parameter Modelica.Units.SI.Velocity v_small = 1e-3 
      "接近零的相对速度（请参阅模型信息文本）" 
      annotation(Dialog(tab = "高级"));
    // 定义以下变量的方程必须在子类中定义
    Modelica.Units.SI.Velocity v_relfric "摩擦表面之间的相对速度";
    Modelica.Units.SI.Acceleration a_relfric 
      "摩擦表面之间的相对加速度";
    Modelica.Units.SI.Force f 
      "摩擦力（正向，如果与 v_rel 相反方向）";
    Modelica.Units.SI.Force f0 "v=0 且向前滑动时的摩擦力";
    Modelica.Units.SI.Force f0_max "v=0 且锁定时的最大摩擦力";
    Boolean free "= true，如果摩擦元件未激活";
    // 定义以下变量的方程在此类中给出
    Real sa(unit = "1") 
      "摩擦特性的路径参数 f = f(a_relfric)";
    Boolean startForward(start = false, fixed = true) 
      "= true，如果 v_rel=0 且开始向前滑动或 v_rel > v_small";
    Boolean startBackward(start = false, fixed = true) 
      "= true，如果 v_rel=0 且开始向后滑动或 v_rel < -v_small";
    Boolean locked(start = false) "= true，如果 v_rel=0 且不滑动";
    extends PartialRigid(s(start = 0, stateSelect = StateSelect.always));
    constant Integer Unknown = 3 "模式值未知";
    constant Integer Free = 2 "元素未激活";
    constant Integer Forward = 1 "v_rel > 0（向前滑动）";
    constant Integer Stuck = 0 
      "v_rel = 0（向前滑动，锁定或向后滑动）";
    constant Integer Backward = -1 "v_rel < 0（向后滑动）";
    Integer mode(
      final min = Backward, 
      final max = Unknown, 
      start = Unknown, 
      fixed = true) 
      "摩擦模式（-1：向后滑动，0：锁定，1：向前滑动，2：不活动，3：未知）";
  protected
    constant Modelica.Units.SI.Acceleration unitAcceleration = 1 annotation(HideResult = true);
    constant Modelica.Units.SI.Force unitForce = 1 annotation(HideResult = true);
  equation
    /* 摩擦特性
    （引入 locked 是为了帮助 Modelica 翻译器确定
    不同的结构配置，如果要为每个配置生成特殊代码）
    */
    startForward = pre(mode) == Stuck and (sa > f0_max / unitForce and s < (
      smax - L / 2) or pre(startForward) and sa > f0 / unitForce and s < (smax 
      - L / 2)) or pre(mode) == Backward and v_relfric > v_small or initial() 
      and (v_relfric > 0);
    startBackward = pre(mode) == Stuck and (sa < -f0_max / unitForce and s > 
      (smin + L / 2) or pre(startBackward) and sa < -f0 / unitForce and s > (
      smin + L / 2)) or pre(mode) == Forward and v_relfric < -v_small or 
      initial() and (v_relfric < 0);
    locked = not free and not (pre(mode) == Forward or startForward or pre(
      mode) == Backward or startBackward);

    a_relfric / unitAcceleration = if locked then 0 else if free then sa 
      else if startForward then sa - f0_max / unitForce else if 
      startBackward then sa + f0_max / unitForce else if pre(mode) == Forward 
      then sa - f0_max / unitForce else sa + f0_max / unitForce;

    /* 摩擦力矩必须在子类中定义。例如对于离合器：
    f = if locked then sa else
    if free then   0 else
    cgeo*fn*(if startForward then          Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], v_relfric, 1) else
    if startBackward then        -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -v_relfric, 1) else
    if pre(mode) == Forward then  Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], v_relfric, 1) else
    -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -v_relfric, 1));
    */
    // 确定配置的有限状态机
    mode = if free then Free else (if (pre(mode) == Forward or pre(mode) 
      == Free or startForward) and v_relfric > 0 and s < (smax - L / 2) 
      then Forward else if (pre(mode) == Backward or pre(mode) == Free or 
      startBackward) and v_relfric < 0 and s > (smin + L / 2) then Backward 
      else Stuck);
    annotation(Documentation(info = "<html>
<p>
用于可靠地描述处于困住阶段的库仑摩擦的基本模型。<br>
此外，还处理了左右止动。
</p>
</html>") );
  end PartialFrictionWithStop;
equation
  // 常量辅助变量
  f0 = (F_Coulomb + F_Stribeck);
  f0_max = f0 * 1.001;
  free = f0 <= 0 and F_prop <= 0 and s > smin + L / 2 and s < smax - L / 2;
  // flanges 的速度和加速度
  v = der(s);
  a = der(v);
  v_relfric = v;
  a_relfric = a;
  // 力的平衡
  0 = flange_a.f + flange_b.f - f - m * der(v);
  // 摩擦力
  f = if locked then sa * unitForce else if free then 0 else (if startForward 
    then F_prop * v + F_Coulomb + F_Stribeck else if startBackward then 
    F_prop * v - F_Coulomb - F_Stribeck else if pre(mode) == Forward then 
    F_prop * v + F_Coulomb + F_Stribeck * Modelica.Math.exp(-fexp * abs(v)) else F_prop * v - 
    F_Coulomb - F_Stribeck * Modelica.Math.exp(-fexp * abs(v)));
  lossPower = f * v_relfric;
  when (initial()) then
    assert(s > smin + L / 2 or s >= smin + L / 2 and v >= 0, 
      "硬性止动初始化错误。 (s - L/2) 必须 >= smin\n" 
      + "(s=" + String(s) + ", L=" + String(L) + ", smin=" + String(smin) 
      + ")");
    assert(s < smax - L / 2 or s <= smax - L / 2 and v <= 0, 
      "硬性止动初始化错误。 (s + L/2) 必须 <= smax\n" 
      + "(s=" + String(s) + ", L=" + String(L) + ", smax=" + String(smax) 
      + ")");
  end when;

  // 定义硬性止动的事件并重新初始化状态变量速度 v 和位置 s
  stopped = if s <= smin + L / 2 then -1 else if s >= smax - L / 2 then +1 
    else 0;
  when stopped <> 0 then
    reinit(s, if stopped < 0 then smin + L / 2 else smax - L / 2);
    reinit(v, 0);
  end when;
  /*
  Version 1:
  
  when not (s < smax - L/2) then
  reinit(s, smax - L/2);
  if (not initial() or v>0) then
  reinit(v, 0);
  end if;
  end when;
  
  when not (s > smin + L/2) then
  reinit(s, smin + L/2);
  if (not initial() or v<0) then
  reinit(v, 0);
  end if;
  end when;
  
  Version 2:
  stopped := if s <= smin + L/2 then -1 else if s >= smax - L/2 then +1 else 0;
  when (initial()) then
  assert(s > smin + L/2 or s >= smin + L/2 and v >= 0,
  "Error in initialization of hard stop. (s - L/2) must be >= smin\n"+
  "(s=" + String(s) + ", L=" + String(L) + ", smin=" + String(smin) + ")");
  assert(s < smax - L/2 or s <= smax - L/2 and v <= 0,
  "Error in initialization of hard stop. (s + L/2) must be <= smax\n"+
  "(s=" + String(s) + ", L=" + String(L) + ", smax=" + String(smax) + ")");
  end when;
  when stopped <> 0 then
  reinit(s, if stopped < 0 then smin + L/2 else smax - L/2);
  if (not initial() or stopped*v>0) then
  reinit(v, 0);
  end if;
  end when;
  */
  annotation(
    Documentation(info = "<html>
<p>此元件描述了滑动质量的 <em>Stribeck 摩擦特性</em>，即滑动质量与支撑之间的摩擦力。
包括一个 <em>硬性止动</em> 以限制位置。</p>
<p>
表面固定，滑动质量与表面之间存在摩擦。
对于正速度 v，摩擦力 f 为：
</p>
<blockquote><pre>
f = F_Coulomb + F_prop * v + F_Stribeck * exp (-fexp * v)
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Components/Stribeck.png\" alt=\"Stribeck 摩擦\">
</div>

<p>
左右连接器之间的距离由参数 L 给出。
质心位置坐标 s 在两个一维平动接口之间的中间。</p>
<p>
在 smax 和 smin 处有硬性止动，即如果
<em><code>flange_a.s &gt;= smin</code></em> 和 <em><code>flange_b.s &lt;= xmax </code></em>，则滑动质量可以自由移动。</p>
<p>当绝对速度变为零时，滑动质量变为卡死状态，即绝对位置保持不变。在此阶段，
摩擦力是通过要求绝对加速度为零来计算的，即摩擦力保持相对不变。
摩擦元素开始滑动时，摩擦力超过一个阈值，称为最大静摩擦力，通过以下方式计算：</p>
<blockquote><pre>
maximum_static_friction =  F_Coulomb + F_Stribeck
</pre></blockquote>
<p>
<font color=\"#ff0000\"> <strong>这需要状态 Stop.s 和 Stop.v</strong> </font> 。 如果在索引降级过程中消除了这些状态，
模型将无法工作。 为了避免这种情况，任何惯性都应通过弹簧连接到 Stop 元素，
应避免其他滑动质量、减震器或液压腔。 
</p>
<p>有关所用摩擦模型的更多详细信息，请参见以下参考文献：</p>

<dl>
<dt>Beater P. (1999):</dt>
<dd><em>Entwurf hydraulischer Maschinen</em>（德文），Springer Verlag Berlin Heidelberg New York，<a href=\"https://doi.org/10.1007/978-3-642-58395-7\">DOI 10.1007/978-3-642-58395-7</a>。</dd>
</dl>

<p>通过状态事件实现的摩擦模型的实现方式非常简洁，会产生连续/离散的方程系统，需要通过适当的数值方法进行求解。
该方法在以下文献中有描述（还可以在 <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a> 中找到简要说明）：</p>

<dl>
<dt>Otter M., Elmqvist H. 和 Mattsson S.E. (1999):</dt>
<dd><em>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle</em>。CACSD'99，8月22.-26，夏威夷。</dd>
</dl>

<p>更精确的摩擦模型考虑了两个元素处于 \"卡死 \"状态时的材料弹性以及其他效应，如滞后效应。 这样做的好处是摩擦元件可以完全通过一个微分方程来描述，而不需要事件。
缺点是系统变得刚性（模拟速度变慢约 10-20 倍），
并且必须提供更多的材料常数，这需要更复杂的识别。
有关更多详细信息，请参见以下参考文献，特别是(Armstrong and Canudas de Wit 1996)：</p>
<dl>
<dt>
Armstrong B. (1991):</dt>
<dd><em>Control of Machines with Friction</em>。 Kluwer Academic Press，波士顿 MA。<br>
</dd>
<dt>Armstrong B. 和 Canudas de Wit C. (1996): </dt>
<dd><em>Friction Modeling and Compensation.</em>《The Control Handbook》，编辑 W.S.Levine，CRC Press，pp. 1369-1382。<br>
</dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J. 和 Lischinsky P. (1995): </dt>
<dd><em>A new model for control of systems with friction.</em>《IEEE Transactions on Automatic Control》，第 40 卷，第 3 期，pp. 419-425。<br>
</dd>
</dl>

<h4>可选的热连接</h4>
<p>
耗散的能量以热的形式传递到可选的 heatPort 连接器，
可以通过参数 \"useHeatPort\" 启用。 无论启用还是未启用 heatPort，
耗散功率都是通过变量 \"lossPower\" 定义的。
如果在硬性止动处发生接触，则此时的 lossPower 模拟不正确，
因为硬性止动会在 lossPower 中引入 Dirac 脉冲，
由于质量的动能发生不连续变化（lossPower 是质量动能在撞击时刻的导数）。
</p>

</html>", 
    revisions = "<html>
<h4>版本说明</h4>
<ul>
<li><em>1999 年 12 月 7 日首次发布，由 P. Beater 制作（基于 Rotational.BearingFriction）</em></li>
<li><em>2001 年 7 月 14 日，由 P. Beater 制作，添加了初始化断言，修改了图表</em></li>
<li><em>2001 年 10 月 11 日，由 Hans Olsson, Dassault Syst&egrave;mes AB 制作，修改了初始化断言以处理止动开始的情况，修改了事件逻辑，如果摩擦参数等于零，则不会在止动之间获得事件。</em></li>
<li><em>2002 年 6 月 10 日，由 P. Beater 制作，为变量 s 和 v 添加了 StateSelect.always（而不是 fixed=true）。</em></li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
    graphics = {
    Line(points = {{-100, 0}, {100, 0}}, color = {0, 127, 0}), 
    Polygon(
    points = {{80, -100}, {50, -90}, {50, -110}, {80, -100}}, 
    lineColor = {95, 127, 95}, 
    fillColor = {95, 127, 95}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-40, -100}, {50, -100}}, color = {95, 127, 95}), 
    Rectangle(
    extent = {{-30, 30}, {30, -30}}, 
    fillPattern = FillPattern.Sphere, 
    fillColor = {166, 221, 166}, 
    lineColor = {0, 127, 0}), 
    Rectangle(
    extent = {{-64, -16}, {-56, -46}}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 127, 0}, 
    fillColor = {0, 127, 0}), 
    Rectangle(
    extent = {{56, -16}, {64, -46}}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 127, 0}, 
    fillColor = {0, 127, 0}), 
    Text(extent = {{-150, 80}, {150, 40}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(points = {{-50, -90}, {-28, -68}}, color = {0, 127, 0}), 
    Line(points = {{-30, -90}, {-8, -68}}, color = {0, 127, 0}), 
    Line(points = {{-10, -90}, {12, -68}}, color = {0, 127, 0}), 
    Line(points = {{10, -90}, {32, -68}}, color = {0, 127, 0}), 
    Text(
    extent = {{-150, -110}, {150, -140}}, 
    textString = "m=%m"), 
    Line(
    visible = useHeatPort, 
    points = {{-100, -100}, {-100, -40}, {3, -40}}, 
    color = {191, 0, 0}, 
    pattern = LinePattern.Dot), 
    Rectangle(
    extent = {{-70, -46}, {70, -70}}, 
    fillColor = {160, 215, 160}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 127, 0})})

    );
end MassWithStopAndFriction;