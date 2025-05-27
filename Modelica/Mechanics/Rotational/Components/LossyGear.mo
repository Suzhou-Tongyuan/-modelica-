within Modelica.Mechanics.Rotational.Components;
model LossyGear 
  "带啮合效率和轴承摩擦的齿轮（可能发生卡滞/滚动）"

  extends Modelica.Mechanics.Rotational.Icons.Gear;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;

  parameter Real ratio(start = 1) 
    "传动比（flange_a.phi/flange_b.phi）";
  parameter Real lossTable[:,5] = [0, 1, 1, 0, 0] 
    "速度相关的啮合效率和轴承摩擦的数组";
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
  SI.Angle phi_a 
    "左轴法兰和支撑之间的角度";
  SI.Angle phi_b 
    "右轴法兰和支撑之间的角度";

  Real sa(final unit = "1") "用于加速度和扭矩损失的路径参数";
  SI.AngularVelocity w_a 
    "相对于支撑的flange_a的角速度";
  SI.AngularAcceleration a_a 
    "相对于支撑的flange_a的角加速度";

  Real interpolation_result[1,4] 
    "在lossTable中的插值结果（= [eta_mf1, eta_mf2, tau_bf1, tau_bf2]）";
  Real eta_mf1(unit = "1") "在flange_a驱动时的啮合效率";
  Real eta_mf2(unit = "1") "在flange_b驱动时的啮合效率";
  SI.Torque tau_bf_a "flange_a侧的轴承摩擦扭矩";
  SI.Torque tau_eta 
    "确定驱动端的扭矩（=如果forwardSliding则flange_a.tau-tau_bf_a，如果backwardSliding则flange_a.tau+tau_bf_a，否则flange_a.tau）";

  SI.Torque tau_bf1 
    "在flange_a驱动时，相对于flange_a的绝对轴承摩擦扭矩（= |tau_bf_a*eta_mf1 + tau_bf_b/i|）";
  SI.Torque tau_bf2 
    "在flange_b驱动时，相对于flange_a的绝对轴承摩擦扭矩（= |tau_bf_a/eta_mf2 + tau_bf_b/i|）";

  SI.Torque quadrant1 "如果w_a > 0且flange_a.tau >= 0，则扭矩损失";
  SI.Torque quadrant2 "如果w_a > 0且flange_a.tau < 0，则扭矩损失";
  SI.Torque quadrant3 "如果w_a < 0且flange_a.tau >= 0，则扭矩损失";
  SI.Torque quadrant4 "如果w_a < 0且flange_a.tau < 0，则扭矩损失";

  // 在接近零时角速度的象限值处的结果摩擦扭矩
  SI.Torque quadrant1_p 
    "用于确定驱动端（flange_a.tau >= 0）的w_a = 0+时的扭矩损失";
  SI.Torque quadrant2_p 
    "用于确定驱动端（flange_a.tau < 0）的w_a = 0+时的扭矩损失";
  SI.Torque quadrant3_m 
    "用于确定驱动端（flange_a.tau >= 0）的w_a = 0-时的扭矩损失";
  SI.Torque quadrant4_m 
    "用于确定驱动端（flange_a.tau < 0）的w_a = 0-时的扭矩损失";

  SI.Torque tauLoss 
    "由于齿轮齿和轴承摩擦导致的扭矩损失";
  SI.Torque tauLossMax "正速度的扭矩损失";
  SI.Torque tauLossMin "负速度的扭矩损失";

  SI.Torque tauLossMax_p "正

速度的扭矩损失";
  SI.Torque tauLossMin_m "负速度的扭矩损失";

  Boolean tau_aPos(start = true) 
    "仅用于向后兼容性（以前是：如果flange_a的扭矩不为负，则为true）";
  Boolean tau_etaPos(start = true) "= 如果tau_eta不为负，则为true";
  Boolean startForward(start = false) "= 如果开始向前滚动，则为true";
  Boolean startBackward(start = false) "= 如果开始向后滚动，则为true";
  Boolean locked(start = false) "= 如果齿轮被卡住，则为true";

  Boolean ideal 
    "= 如果忽略损失（即lossTable = [0, 1, 1, 0, 0]）";

  constant Integer Unknown = 3 "模式值未知";
  constant Integer Free = 2 "元素未激活";
  constant Integer Forward = 1 "w_a > 0（向前滚动）";
  constant Integer Stuck = 0 
    "w_a = 0（向前滚动，锁定或向后滚动）";
  constant Integer Backward = -1 "w_a < 0（向后滚动）";
  Integer mode(
    final min = Backward, 
    final max = Unknown, 
    start = Free, 
    fixed = true) 
    "摩擦元素的模式（未知，未激活，向前/向后滚动，卡住）";

  SI.Torque tau_eta_p "假定角速度为正的tau_eta";
  SI.Torque tau_eta_m "假定角速度为负的tau_eta";
protected
  constant SI.AngularAcceleration unitAngularAcceleration = 1;
  constant SI.Torque unitTorque = 1;

  // 获取角速度为0时的摩擦和eta信息
  parameter Real eta_mf1_0(unit = "1") = Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,2], 0, 1);
  parameter Real eta_mf2_0(unit = "1") = Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,3], 0, 1);
  parameter SI.Torque tau_bf1_0 = abs(Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,4], 0, 1));
  parameter SI.Torque tau_bf2_0 = abs(Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,5], 0, 1));
  parameter SI.Torque tau_bf_a_0 = if Modelica.Math.isEqual(
    eta_mf1_0, 
    1.0, 
    Modelica.Constants.eps) and Modelica.Math.isEqual(
    eta_mf2_0, 
    1.0, 
    Modelica.Constants.eps) then tau_bf1_0 / 2 else (tau_bf1_0 - 
    tau_bf2_0) / (eta_mf1_0 - 1.0 / eta_mf2_0);
  // 对于eta_mf1_0=eta_mf2_0=1，给定的轴承摩擦无法分离为A面或B面的一部分，因此是任意的。
  // 从以下方程计算tau_bf_a_0
  // tau_bf1_0=eta_mf1_0*tau_bf_a_0 + 1/ratio a_0
  // tau_bf2_0=1/eta_mf2*tau_bf_a_0 + 1/ratio tau_bf_a_0
equation
  assert(abs(ratio) > 0, 
    "初始化LossyGear时出错：ratio不能为零");

  ideal = Modelica.Math.Matrices.isEqual(
    lossTable, 
    [0, 1, 1, 0, 0], 
    Modelica.Constants.eps);

  if ideal then
    interpolation_result = [1, 1, 0, 0];
    eta_mf1 = 1;
    eta_mf2 = 1;
    tau_bf1 = 0;
    tau_bf2 = 0;
  else
    interpolation_result = [
      Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,2], noEvent(abs(w_a)), 1),
      Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,3], noEvent(abs(w_a)), 1),
      Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,4], noEvent(abs(w_a)), 1),
      Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,5], noEvent(abs(w_a)), 1)];
    eta_mf1 = interpolation_result[1,1];
    eta_mf2 = interpolation_result[1,2];
    tau_bf1 = noEvent(abs(interpolation_result[1,3]));
    tau_bf2 = noEvent(abs(interpolation_result[1,4]));
  end if;

  if Modelica.Math.isEqual(
    eta_mf1, 
    1.0, 
    Modelica.Constants.eps) and Modelica.Math.isEqual(
    eta_mf2, 
    1.0, 
    Modelica.Constants.eps) then
    // 对于eta_mf1=eta_mf2=1，给定的轴承摩擦无法分离为A面或B面的一部分，因此是任意的。
    tau_bf_a = tau_bf1 / 2;
  else
    //从以下方程计算tau_bf_a
    //tau_bf1 = eta_mf1*tau_bf_a + tau_bf_b / ratio
    //tau_bf2 = 1/eta_mf2*tau_bf_a + tau_bf_b / ratio
    tau_bf_a = (tau_bf1 - tau_bf2) / (eta_mf1 - 1.0 / eta_mf2);
  end if;

  phi_a = flange_a.phi - phi_support;
  phi_b = flange_b.phi - phi_support;
  phi_a = ratio * phi_b;

  // 扭矩平衡（无惯性）
  0 = flange_b.tau + ratio * (flange_a.tau - tauLoss);

  // 摩擦元素的速度
  w_a = der(phi_a);
  a_a = der(w_a);

  // 确定驱动端
  //假设角速度为正
  tau_eta_p = flange_a.tau - tau_bf_a_0;
  //假设角速度为负
  tau_eta_m = flange_a.tau + tau_bf_a_0;

  // 假设w>=0，取w=0时的值来确定滚动/卡住模式
  quadrant1_p = (1 - eta_mf1_0) * flange_a.tau + tau_bf1_0;
  quadrant2_p = (1 - 1 / eta_mf2_0) * flange_a.tau + tau_bf2_0;
  tauLossMax_p = if noEvent(tau_eta_p > 0) then quadrant1_p else 
    quadrant2_p;

  // 假设w<=0，取w=0时的值来确定滚动/卡住模式
  quadrant4_m = (1 - 1 / eta_mf2_0) * flange_a.tau - tau_bf2_0;
  quadrant3_m = (1 - eta_mf1_0) * flange_a.tau - tau_bf1_0;
  tauLossMin_m = if noEvent(tau_eta_m > 0) then quadrant4_m else 
    quadrant3_m;

  quadrant1 = (1 - eta_mf1) * flange_a.tau + tau_bf1;
  quadrant2 = (1 - 1 / eta_mf2) * flange_a.tau + tau_bf2;
  quadrant4 = (1 - 1 / eta_mf2) * flange_a.tau - tau_bf2;
  quadrant3 = (1 - eta_mf1) * flange_a.tau - tau_bf1;

  //tau eta: 仅用于确定驱动端以计算tauloss
  tau_eta = if ideal then flange_a.tau else (if locked then flange_a.tau 
    else (if (startForward or pre(mode) == Forward) then flange_a.tau - 
    tau_bf_a else flange_a.tau + tau_bf_a));

  // 扭矩损失
  tau_etaPos = tau_eta >= 0;
  tau_aPos = tau_etaPos;
  tauLossMax = if tau_etaPos then quadrant1 else quadrant2;
  tauLossMin = if tau_etaPos then quadrant4 else quadrant3;

  // 在计算下述方程之后，确定w_rel = 0时的滚动/卡住模式
  startForward = pre(mode) == Stuck and sa > tauLossMax_p / unitTorque or 
    initial() and w_a > 0;
  startBackward = pre(mode) == Stuck and sa < tauLossMin_m / unitTorque or 
    initial() and w_a < 0;
  locked = not (ideal or pre(mode) == Forward or startForward or pre(mode) 
    == Backward or startBackward);

  /* 参数化的曲线描述 a_a = f1(sa), tauLoss = f2(sa)
  与Modelica.Mechanics.Rotational.FrictionBase相比，可以简化以下表达式，因为在startForward或startBackward的情况下，mode == Stuck是有保证的 */
  tauLoss = if ideal then 0 else (if locked then sa * unitTorque else (if (
    startForward or pre(mode) == Forward) then tauLossMax else tauLossMin));

  a_a = unitAngularAcceleration * (if locked then 0 else sa - tauLoss / 
    unitTorque);

  /* 有限状态机，用于在上述计算之后固定配置
  上述方程仅依赖于pre(mode)而不是mode的实际值。 这可以防止循环。 因此，可以在一步中确定模式。 */
  mode = if ideal then Free else (if (pre(mode) == Forward or startForward) 
    and w_a > 0 then Forward else if (pre(mode) == Backward or 
    startBackward) and w_a < 0 then Backward else Stuck);

  lossPower = tauLoss * w_a;
  annotation(
    Documentation(info="<html><p>
这个组件以一种<strong>可靠的</strong>方式模拟了标准齿轮箱的传动比和<strong>损耗</strong>，包括可能发生的零速度阶段。 可以处理的固定在地面或运动支架上的齿轮箱，具有一个输入和一个输出轴，并且基本特性由以下方程描述：
</p>
<pre><code >flange_a.phi  = i*flange_b.phi;
-(flange_b.tau - tau_bf_b) = i*eta_mf*(flange_a.tau - tau_bf_a);

// or        -flange_b.tau = i*eta_mf*(flange_a.tau - tau_bf_a - tau_bf_b/(i*eta_mf));
</code></pre><p>
其中
</p>
<ul><li>
<strong>i</strong> 是常数 <strong>齿轮传动比</strong>,</li>
<li>
<strong>eta_mf</strong> = eta_mf(w_a) 是由齿轮轮齿之间的摩擦引起的<strong>效率</strong>,</li>
<li>
<strong>tau_bf_a</strong> = tau_bf_a(w_a) 是flange_a侧的<strong>轴承摩擦扭矩</strong>,</li>
<li>
<strong>tau_bf_b</strong> = tau_bf_b(w_a) 是flange_b侧的<strong>轴承摩擦扭矩</strong>，和</li>
<li>
<strong>w_a</strong> = der(flange_a.phi) 是flange_a的速度</li>
</ul><p>
损耗项“eta_mf”、“tau_bf_a”和“tau_bf_b”是输入轴速度w_a的<em>绝对值</em>和能量流方向的函数。 它们由参数<strong>lossTable[:,5]</strong>定义，其具体参数项如下：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">|w_a|</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">eta_mf1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">eta_mf2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">tau_bf1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">tau_bf2</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">eta_mf1_0</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">eta_mf2_0</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">tau_bf1_0</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">tau_bf2_0</td></tr></tbody></table><p>
然后可以使用Interpolate函数插值出表中的其他值（例如Modelica.Math.Vectors.interpolate）。 <br> <em>Important:</em> 为了适应反向滑动，tau_bf1_0和tau_bf2_0的符号应为负。 <br>
</p>
<p>
如果支撑组件不带传热，或者将模型与传热扩展配合使用，则无需（不必）使用连杆法则来定义HeatPort。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end LossyGear;