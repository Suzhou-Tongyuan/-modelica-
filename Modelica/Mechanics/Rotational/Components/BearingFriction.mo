within Modelica.Mechanics.Rotational.Components;
model BearingFriction "轴承中的库仑摩擦"
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;

  parameter Real tau_pos[:,2] = [0, 1] 
    "正滑动摩擦特性 [N·m]，作为 w [rad/s] 的函数（w>=0）";
  parameter Real peak(final min = 1) = 1 
    "在 w==0 时最大摩擦力矩的峰值（tau0_max = peak*tau_pos[1,2]）";

  extends Rotational.Interfaces.PartialFriction;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

  SI.Angle phi 
    "轴承一维转动接口（flange_a, flange_b）与支撑之间的角度";
  SI.Torque tau "摩擦力矩";
  SI.AngularVelocity w "一维转动接口 flange_a 和 flange_b 的绝对角速度";
  SI.AngularAcceleration a 
    "一维转动接口 flange_a 和 flange_b 的绝对角加速度";

equation
  // 常数辅助变量
  tau0 = Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], 0, 1);
  tau0_max = peak * tau0;
  free = false;

  phi = flange_a.phi - phi_support;
  flange_b.phi = flange_a.phi;

  // 一维转动接口的角速度和角加速度
  w = der(phi);
  a = der(w);
  w_relfric = w;
  a_relfric = a;

  // 摩擦力矩
  flange_a.tau + flange_b.tau - tau = 0;

  // 摩擦力矩
  tau = if locked then sa * unitTorque else (
    if startForward then 
    Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], w, 1) 
    else if startBackward then 
    -Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], -w, 1) 
    else if pre(mode) == Forward then 
    Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], w, 1) 
    else 
    -Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], -w, 1));
  lossPower = tau * w_relfric;

  annotation(Documentation(info = "<html>
<p>
该元素描述了轴承中的库仑摩擦，即一维转动接口和轴承座之间的摩擦力矩。
正的滑动摩擦力矩“tau”必须通过表“tau_pos”定义为绝对角速度“w”的函数。
例如：
</p>
<blockquote><pre>
 w | tau
---+-----
 0 |   0
 1 |   2
 2 |   5
 3 |   8
</pre></blockquote>
<p>
给出了以下表格：
</p>
<blockquote><pre>
tau_pos = [0, 0; 1, 2; 2, 5; 3, 8];
</pre></blockquote>
<p>
目前，仅支持表格中的线性插值。
在表格之外，通过最后两个表格条目进行外推。假设负的滑动摩擦力具有相同的特性和负值。摩擦的建模方式如下：
</p>
<p>
当绝对角速度“w”不为零时，摩擦力矩是w和常数法向力的函数。该依赖关系通过tau_pos表定义，并可以通过测量确定，例如，通过以恒定速度驱动齿轮并测量所需电机转矩（=摩擦转矩）。
</p>
<p>
当绝对角速度变为零时，通过摩擦元素连接的元素变得卡住，即绝对角度保持不变。在这个阶段，摩擦力矩是根据扭矩平衡计算的，要求绝对加速度为零。当摩擦力矩超过阈值时，元素开始滑动，该阈值称为最大静摩擦力矩，通过以下方式计算：
</p>
<blockquote><pre>
maximum_static_friction = <strong>peak</strong> * sliding_friction(w=0)  (<strong>peak</strong> >= 1)
</pre></blockquote>
<p>
这个过程通过状态事件以“十分清晰”的方式实现，并且通过连续/离散方程组导致摩擦元素动态耦合，这些方程组必须通过适当的数值方法解决。该方法的描述在以下位置：
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle. </strong> CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
<p>
更精确的摩擦模型考虑了当两个元素“卡住”时的材料弹性以及其他效应，如滞后。这样做的好处是，摩擦元素可以完全由微分方程描述，而不需要事件。缺点是系统变得刚性（模拟速度慢大约10-20倍），并且需要提供更多的材料常数，这需要更复杂的识别。有关更多详细信息，请参阅以下参考文献，特别是（Armstrong and Canudas de Wit 1996）：
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><strong>Control of Machines with Friction</strong>. Kluwer Academic
    Press, Boston MA.<br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><strong>Friction Modeling and Compensation.</strong>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br></dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995):</dt>
<dd><strong>A new model for control of systems with friction.</strong>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.</dd>
</dl>

</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio = true, 
    extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
    graphics = {
    Rectangle(lineColor = {64, 64, 64}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.HorizontalCylinder, 
    extent = {{-100.0, -10.0}, {100.0, 10.0}}), 
    Rectangle(extent = {{-60.0, -60.0}, {60.0, -10.0}}), 
    Rectangle(fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-60.0, -25.0}, {60.0, -10.0}}), 
    Rectangle(fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-60.0, -61.0}, {60.0, -45.0}}), 
    Rectangle(fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-50.0, -50.0}, {50.0, -18.0}}), 
    Polygon(fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid, 
    points = {{60.0, -60.0}, {60.0, -70.0}, {75.0, -70.0}, {75.0, -80.0}, {-75.0, -80.0}, {-75.0, -70.0}, {-60.0, -70.0}, {-60.0, -60.0}, {60.0, -60.0}}), 
    Line(points = {{-75.0, -10.0}, {-75.0, -70.0}}), 
    Line(points = {{75.0, -10.0}, {75.0, -70.0}}), 
    Rectangle(extent = {{-60.0, 10.0}, {60.0, 60.0}}), 
    Rectangle(fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-60.0, 45.0}, {60.0, 60.0}}), 
    Rectangle(fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-60.0, 10.0}, {60.0, 25.0}}), 
    Rectangle(fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-50.0, 19.0}, {50.0, 51.0}}), 
    Line(points = {{-75.0, 70.0}, {-75.0, 10.0}}), 
    Polygon(fillColor = {160, 160, 164}, 
    fillPattern = FillPattern.Solid, 
    points = {{60.0, 60.0}, {60.0, 70.0}, {75.0, 70.0}, {75.0, 80.0}, {-75.0, 80.0}, {-75.0, 70.0}, {-60.0, 70.0}, {-60.0, 60.0}, {60.0, 60.0}}), 
    Line(points = {{75.0, 70.0}, {75.0, 10.0}}), 
    Text(textColor = {0, 0, 255}, 
    extent = {{-150.0, 90.0}, {150.0, 130.0}}, 
    textString = "%name"), 
    Line(points = {{0.0, -80.0}, {0.0, -100.0}}), 
    Line(visible = useHeatPort, 
    points = {{-100.0, -100.0}, {-100.0, -35.0}, {2.0, -35.0}}, 
    color = {191, 0, 0}, 
    pattern = LinePattern.Dot)}));
end BearingFriction;