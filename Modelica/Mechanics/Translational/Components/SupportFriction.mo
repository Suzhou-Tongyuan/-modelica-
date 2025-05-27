within Modelica.Mechanics.Translational.Components;
model SupportFriction "支撑组件中的库仑摩擦"
  extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  parameter Real f_pos[:, 2]=[0, 1] 
    "作为绝对速度 [m/s] 函数的正向滑动摩擦特性 [N] (v>=0)";
  parameter Real peak(final min=1) = 1 
    "在 v==0 时最大摩擦力的峰值 (f0_max = peak*f_pos[1,2])";
  extends Translational.Interfaces.PartialFriction;

  SI.Position s "= flange_a.s - support.s";
  SI.Force f "摩擦力";
  SI.Velocity v "flange_a 和 flange_b 的绝对速度";
  SI.Acceleration a "flange_a 和 flange_b 的绝对加速度";
equation
  // 常量辅助变量
  f0 = Modelica.Math.Vectors.interpolate(
        f_pos[:, 1], 
        f_pos[:, 2], 
        0, 
        1);
  f0_max = peak*f0;
  free = false;

  s = flange_a.s - s_support;
  flange_a.s = flange_b.s;

  // flanges 的速度和加速度
  v = der(s);
  a = der(v);
  v_relfric = v;
  a_relfric = a;

  // 摩擦力
  flange_a.f + flange_b.f - f = 0;

  // 摩擦力
  f = if locked then sa*unitForce else (
    if startForward then 
      Modelica.Math.Vectors.interpolate(f_pos[:, 1], f_pos[:, 2], v, 1) 
    else if startBackward then 
      -Modelica.Math.Vectors.interpolate(f_pos[:, 1], f_pos[:, 2], -v, 1) 
    else if pre(mode) == Forward then 
      Modelica.Math.Vectors.interpolate(f_pos[:, 1], f_pos[:, 2], v, 1) 
    else 
      -Modelica.Math.Vectors.interpolate(f_pos[:, 1], f_pos[:, 2], -v, 1));

  lossPower = f*v_relfric;
  annotation (
    Documentation(info="<html>
<p>
该元件描述了支撑组件中的库仑摩擦，即支撑组件和外部物体之间的摩擦力。正向滑动摩擦力 \"f\" 必须通过表 \"f_pos\" 以绝对速度 \"v\" 的函数进行定义。
例如：
</p>
<blockquote><pre>
 v |   f
---+-----
 0 |   0
 1 |   2
 2 |   5
 3 |   8
</pre></blockquote>
<p>
这将给出以下表：
</p>
<blockquote><pre>
f_pos = [0, 0; 1, 2; 2, 5; 3, 8];
</pre></blockquote>
<p>
当前只支持表中的线性插值。在表之外，通过最后两个表条目进行外推。假设在负的滑动摩擦力具有相同的特性但是具有负值。
摩擦是通过以下方式建模的：
</p>
<p>
当绝对速度 \"v\" 不为零时，摩擦力是v和恒定法向力的函数。这种依赖性通过表f_pos定义，并且可以通过测量确定，
例如，通过以恒定速度驱动齿轮并测量所需的驱动力（即摩擦力）。
</p>
<p>
当绝对速度变为零时，连接摩擦元件的元素被锁定，即绝对位置保持不变。在这种情况下，摩擦力通过要求绝对加速度为零进行计算。
当摩擦力超过一个阈值时，即最大静摩擦力，由以下方式计算：
</p>
<blockquote><pre>
maximum_static_friction = <strong>peak</strong> * sliding_friction(v=0)  (<strong>peak</strong> >= 1)
</pre></blockquote>
<p>
这个过程通过状态事件以\"十分干净\"的方式实现，如果摩擦元件被动态耦合，它会导致连续/离散的方程系统，必须通过适当的数值方法求解。
该方法在以下文献中有描述（另请参阅<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>中的简短概述）：
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
<p>
更精确的摩擦模型考虑了两个元素在\"卡住\"时的弹性以及其他效应，例如滞后。这样做的好处是摩擦元件可以完全通过一个不需要事件的微分方程来描述。
缺点是系统变得僵硬（模拟速度变慢约10-20倍），需要提供更多的材料常数，这需要更复杂的识别。有关更多详细信息，请参见以下文献，特别是（Armstrong and Canudas de Wit 1996）：
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><strong>Control of Machines with Friction</strong>. Kluwer Academic
    Press, Boston MA.<br><br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><strong>Friction Modeling and Compensation.</strong>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br><br></dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995):</dt>
<dd><strong>A new model for control of systems with friction.</strong>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br><br></dd>
</dl>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Polygon(
          points={{-50,-50},{-10,-90},{-10,-100},{10,-100},{10,-90},{50,-50},{-50,-50}}, 
          lineColor={95,95,95}, 
          fillColor={131,175,131}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-48,-10},{-28,-30}}, 
          lineColor={0,127,0}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={255,255,255}), 
        Ellipse(
          extent={{-10,-10},{10,-30}}, 
          lineColor={0,127,0}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={255,255,255}), 
        Ellipse(
          extent={{30,-10},{50,-30}}, 
          lineColor={0,127,0}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={255,255,255}), 
        Ellipse(
          extent={{-50,30},{-30,10}}, 
          lineColor={0,127,0}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={255,255,255}), 
        Ellipse(
          extent={{-10,30},{10,10}}, 
          lineColor={0,127,0}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={255,255,255}), 
        Ellipse(
          extent={{30,30},{50,10}}, 
          lineColor={0,127,0}, 
          fillPattern=FillPattern.Sphere, 
          fillColor={255,255,255}), 
        Rectangle(
          extent={{-90,10},{90,-10}}, 
          lineColor={0,127,0}, 
          fillColor={160,215,160}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-150,100},{150,60}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(
          points={{-60,30},{60,30},{60,20},{80,20},{80,50},{-80,50},{-80,20},{-60,20},{-60,30}}, 
          lineColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          fillColor={131,175,131}), 
        Line(
          visible=useHeatPort, 
          points={{-100,-100},{-100,-20},{0,-20}}, 
          color={191,0,0}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{-60,-30},{60,-30},{60,-20},{80,-20},{80,-50},{-80,-50},{-80,-20},{-60,-20},{-60,-30}}, 
          lineColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          fillColor={131,175,131})}));
end SupportFriction;