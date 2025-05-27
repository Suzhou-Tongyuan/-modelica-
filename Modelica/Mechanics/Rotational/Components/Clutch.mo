within Modelica.Mechanics.Rotational.Components;
model Clutch"基于库仑摩擦的离合器"
  extends Modelica.Mechanics.Rotational.Icons.Clutch;
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;

  parameter Real mu_pos[:, 2]=[0, 0.5] 
    "正向滑动摩擦系数 [-] 作为 w_rel [rad/s] 的函数（w_rel>=0）";
  parameter Real peak(final min=1) = 1 
    "在 w==0 时 mu 的最大值峰值（mu0_max = peak*mu_pos[1,2])";
  parameter Real cgeo(final min=0) = 1 
    "包含摩擦分布假设的几何常数";
  parameter SI.Force fn_max(final min=0, start=1) "最大法向力";

  extends Rotational.Interfaces.PartialFriction;
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  Real mu0 "当 w=0 时的摩擦系数和正向滑动";
  SI.Force fn "法向力 (fn=fn_max*f_normalized)";
  Modelica.Blocks.Interfaces.RealInput f_normalized 
    "归一化力信号 0..1 (法向力 = fn_max*f_normalized; 当 > 0 时离合器已接合)" 
    annotation (Placement(transformation(
        origin={0,110}, 
        extent={{20,-20},{-20,20}}, 
        rotation=90)));

equation
  // 常量辅助变量
  mu0 = Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], 0, 1);

  // 相对量
  w_relfric = w_rel;
  a_relfric = a_rel;

  // 当 w_rel=0 时的法向力和摩擦力矩
  fn = fn_max*f_normalized;
  free = fn <= 0;
  tau0 = mu0*cgeo*fn;
  tau0_max = peak*tau0;

  // 摩擦力矩

  tau = if locked then sa*unitTorque else if free then 0 else cgeo*fn*(
    if startForward then 
      Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w_rel, 1) 
    else if startBackward then 
      -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w_rel, 1) 
    else if pre(mode) == Forward then 
      Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w_rel, 1) 
    else 
      -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -w_rel, 1));
  lossPower = tau*w_relfric;
  annotation (Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), 
        graphics={
      Text(extent={{-150,-110},{150,-70}}, 
        textString="%name", 
        textColor={0,0,255}), 
      Line(visible=useHeatPort, 
        points={{-100,-100},{-100,-40},{0,-40}}, 
        color={191,0,0}, 
        pattern=LinePattern.Dot)}), Documentation(info="<html><p>
这个组件模拟了<strong>离合器</strong>，即一个有两个一维转动接口的组件，在这两个一维转动接口之间存在摩擦，并且通过法向力将这些一维转动接口压在一起。 法向力fn必须以标准化形式作为输入信号f_normalized提供（0≤ fnormalized≤1），fn=fn_max*f_normalized，其中fn_max必须作为参数提供。离合器中的摩擦系统按如下建模：
</p>
<p>
当相对角速度不为零时，摩擦扭矩是与速度相关的摩擦系数 mu(w_rel)、法向力 \"fn\" 和几何常数 \"cgeo\" 的函数，它考虑了设备的几何形状和摩擦分布的假设：
</p>
<pre><code >frictional_torque = cgeo * mu(w_rel) * fn
</code></pre><p>
典型的摩擦系数<strong>mu</strong>的值：
</p>
<ul><li>
干摩擦运行时为 0.2 到 0.4，</li>
<li>
油润滑条件下运行时为 0.05 到 0.1。</li>
</ul><p>
当摩擦片被挤压在一起时，其中 <strong>ri</strong> 是内半径，<strong>ro</strong> 是外半径，<strong>N</strong> 是摩擦界面的数量，假设摩擦界面上的磨损速率均匀时，几何常数如下计算：
</p>
<pre><code >cgeo = N*(r0 + ri)/2
</code></pre><p>
摩擦特性 <strong>mu</strong>(w_rel) 的正部分，即 w_rel &gt;= 0，通过表 mu_pos（第一列 = w_rel，第二列 = mu）定义。目前，仅支持表中的线性插值。
</p>
<p>
当相对角速度变为零时，连接在摩擦元件上的元素变得卡住，即相对角度保持不变。在这个阶段，摩擦扭矩是根据要求相对加速度为零的扭矩平衡计算的。当摩擦扭矩超过阈值时，元素开始滑动，这个阈值称为最大静摩擦扭矩，通过以下方式计算：
</p>
<pre><code >frictional_torque = peak * cgeo * mu(w_rel=0) * fn   (peak &gt;= 1)
</code></pre><p>
该过程通过状态事件以“十分清晰”的方式实现，并且如果摩擦元素动态耦合，则导致连续/离散方程组。该方法的描述见 （另请参阅<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\" target=\"\">UsersGuide.ModelingOfFriction</a>中的简短草图）：
</p>
<p>
Otter M., Elmqvist H., and Mattsson S.E. (1999):
</p>
<p>
<strong>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle.</strong>CACSD\\'99, Aug. 22.-26, Hawaii.
</p>
<p>
更精确的摩擦模型考虑了当两个元素“卡住”时材料的弹性以及其他效应，如滞后效应。这样做的优点是摩擦元素可以完全由微分方程描述，无需事件。缺点是系统变得僵硬（模拟速度慢大约10-20倍），并且需要提供更多的材料常数，这需要更复杂的辨识。有关更多详细信息，请参阅以下参考文献，特别是（Armstrong and Canudas de Wit 1996）：<br>&lt;
</p>
<p>
Otter M., Elmqvist H., and Mattsson S.E. (1999):
</p>
<p>
<strong>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle</strong>. CACSD\\'99, Aug. 22.-26, Hawaii.
</p>
<p>
有关 <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\" target=\"\">State Selection</a> 的讨论，请参考Rotational库中的用户指南
</p>
<p>
<br>
</p>
</html>"));
end Clutch;