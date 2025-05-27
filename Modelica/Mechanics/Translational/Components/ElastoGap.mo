within Modelica.Mechanics.Translational.Components;
model ElastoGap "具有间隙的一维线性平动弹簧阻尼器组合"
  extends Modelica.Mechanics.Translational.Interfaces.PartialCompliantWithRelativeStates;
  parameter SI.TranslationalSpringConstant c(final min=0, start=1) 
    "弹簧刚度系数";
  parameter SI.TranslationalDampingConstant d(final min=0, start=1) 
    "阻尼系数";
  parameter SI.Position s_rel0=0 "未拉伸弹簧长度";
  parameter Real n(final min=1) = 1 
    "弹簧力的指数（ f_c = -c*|s_rel-s_rel0|^n ）";
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  /*
请注意，由于非线性弹簧特性（s_rel>s_rel0时弹簧力为零），初始化可能会失败，
如果正力作用于元件且没有其他力平衡此力（例如，将初始速度和加速度都设置为0）。
*/
  Boolean contact "= true, 如果接触，则为真，否则为假";
protected
  SI.Force f_c "弹簧力";
  SI.Force f_d2 "线性阻尼力";
  SI.Force f_d 
    "被弹簧力限制的线性阻尼力（|f_d| <= |f_c|）";
equation
  // 修改接触力，使其只“推”而不是“拉/粘”，并使其连续
  contact = s_rel < s_rel0;
  f_c = smooth(1, noEvent(if contact then -c*abs(s_rel - s_rel0)^n else 0));
  f_d2 = if contact then d*v_rel else 0;
  f_d = smooth(0, noEvent(if contact then (if f_d2 < f_c then f_c else if 
    f_d2 > -f_c then -f_c else f_d2) else 0));
  f = f_c + f_d;
  lossPower = f_d*v_rel;
  annotation (
    Documentation(info="<html>
<p>
该组件模拟了一个可以脱离的弹簧阻尼器组合。
它可以连接在滑动质量和壳体（模型<a href=\"modelica://Modelica.Mechanics.Translational.Components.Fixed\">Fixed</a>）之间，
以描述滑动质量块与壳体的接触。
</p>

<p>
只要s_rel>s_rel0，就不会施加力（s_rel = flange_b.s - flange_a.s）。
如果s_rel≤s_rel0，则接触力基本上是使用线性弹簧/阻尼器特性计算的。
通过参数n≥1（弹簧力指数），可以建模非线性弹簧力：
</p>

<blockquote><pre>
desiredContactForce = c*|s_rel - s_rel0|^n + d*<strong>der</strong>(s_rel)
</pre></blockquote>

<p>
注意，赫兹接触由以下描述：
</p>

<ul>
<li> 两个金属球之间的接触：n=1.5</li>
<li> 两个金属板之间的接触：n=1</li>
</ul>

<p>
上述力学定律导致了以下问题：
</p>

<ol>
<li> 如果阻尼力变大，并且与弹簧力的符号相反，接触力将是“拉/粘”的，这是不符合物理规律的，
    因为在接触时只能产生推力。</li>

<li> 当接触发生时具有非零相对速度（这是通常的情况），阻尼力具有非零值，因此在 s_rel = s_rel0 处，
    接触力会不连续地变化。再次强调，这个组件不是一个理想化模型，用来将陡峭的特性近似为不连续，
    而是要模拟陡峭的特性。</li>
</ol>

<p>
在文献中有几种解决问题（2）的建议。特别地，经常使用以下模型（参见，例如，
Lankarani, Nikravesh: Continuous Contact Force Models for Impact
Analysis in Multibody Systems, Nonlinear Dynamics 5, pp. 193-207, 1994，
<a href=\"https://link.springer.com/article/10.1007/BF00045676\">pdf-download</a>）：
</p>

<blockquote><pre>
f = c*s_rel^n + (d*s_rel^n)*<strong>der</strong>(s_rel)
</pre></blockquote>

<p>
然而，这个和其他文献中提出的模型违反了问题（1），即会出现不合理的拉力（如果 d*<strong>der</strong>(s_rel)
变得足够大）。请注意，如果力学定律是 \"f = f_c + f_d\" 形式的话，
一个必要的条件是 |f_d| ≤ |f_c|，否则问题（1）和（2）将会违反。
因此，ElastoGap模型中使用了直接在力学定律中使用这个必要条件来解决这两个问题的最简单的方法。
如果 s_rel0 = 0，则方程如下：
</p>

<blockquote><pre>
<strong>if</strong> s_rel &ge; 0 <strong>then</strong>
   f = 0;    // contact force
<strong>else</strong>
   f_c  = -c*|s_rel|^n;          // contact spring force (Hertzian contact force)
   f_d2 = d*<strong>der</strong>(s_rel);         // linear contact damper force
   f_d  = <strong>if</strong> f_d2 &lt;  f_c <strong>then</strong>  f_c <strong>else</strong>
          <strong>if</strong> f_d2 &gt; -f_c <strong>then</strong> -f_c <strong>else</strong> f_d2;  // bounded damper force
   f    = f_c + f_d;            // contact force
<strong>end if</strong>;
</pre></blockquote>

<p>
注意，由于 |f_d| ≤ |f_c|，所以不能发生拉力，并且接触力始终连续，尤其是在开始渗透时 s_rel = s_rel0 处。
</p>

<p>
在下图中，显示了ElastoGap模型的典型模拟（<a href=\"modelica://Modelica.Mechanics.Translational.Examples.ElastoGap\">Examples.ElastoGap</a>），
对其中的不同效应进行了可视化：
</p>

<ol>
<li>曲线1（elastoGap1.f）是未修改的接触力，即线性弹簧/阻尼器特性。在接触结束时存在拉力/粘附力。</li>
<li>曲线2（elastoGap2.f）是接触力，当拉/粘附发生时，力被显式地设置为零。当接触开始时，接触力不连续。</li>
<li>曲线3（elastoGap3.f）是此库的ElastoGap模型。不会发生不连续和拉力/粘附。</li>
</ol>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Components/ElastoGap.png\" alt=\"Elasto gap\">
</div>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-98,0},{-48,0}}, color={0,127,0}), 
          Line(
              points={{-48,36},{-48,-38}}, 
              thickness=1, 
          color={0,127,0}),                Line(
              points={{-12,-38},{-12,36}}, 
              thickness=1, 
          color={0,127,0}),Line(points={{-12,-28},{70,-28},{70,24}}, color={0,127,0}), 
                                          Line(points={{70,0},{98,0}}, 
                   color={0,127,0}), 
          Line(points={{-12,24},{0,24},{6,34},{18,14},{30,34},{42,14},{54,34},{60,24},{70,24}}, color={0,127,0}), 
          Rectangle(
              extent={{10,-6},{50,-50}}, 
              fillColor={192,192,192}, 
              fillPattern=FillPattern.Solid, 
          lineColor={0,127,0}),              Line(points={{-52,-70},{28,-70}}, color={95,127,95}), 
                                                                               Polygon(
          points={{58,-70},{28,-60},{28,-80},{58,-70}}, 
          lineColor={95,127,95}, 
          fillColor={95,127,95}, 
          fillPattern=FillPattern.Solid),    Text(
              extent={{-150,100},{150,60}}, 
              textString="%name", 
              textColor={0,0,255}), Text(
              extent={{-150,-125},{150,-95}}, 
              textString="c=%c"),Text(
              extent={{-150,-160},{150,-130}}, 
              textString="d=%d"), 
          Line(
              visible=useHeatPort, 
              points={{-100,-100},{-100,-44},{22,-44},{22,-28}}, 
              color={191,0,0}, 
              pattern=LinePattern.Dot), 
          Line(points={{0,-50},{50,-50},{50,-6},{0,-6}}, color={0,127,0})}));
end ElastoGap;