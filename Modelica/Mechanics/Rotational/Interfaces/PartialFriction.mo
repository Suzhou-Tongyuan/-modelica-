within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialFriction "Coulomb摩擦元件的部分模型"

  // parameter SI.AngularVelocity w_small=1 "接近零时的相对角速度（请参阅模型信息文本）";
  parameter SI.AngularVelocity w_small=1.0e10 
    "如果由于速度的重新初始化（reinit(..)）而可能发生跃变，则接近零的相对角速度（仅在出现这样的冲击时设置为低值）" 
    annotation (Dialog(tab="高级"));
  // 下列变量的定义方程必须在子类中定义
  SI.AngularVelocity w_relfric 
    "摩擦表面之间的相对角速度";
  SI.AngularAcceleration a_relfric 
    "摩擦表面之间的相对角加速度";
  //SI.Torque tau "摩擦力矩（正向时为负）";
  SI.Torque tau0 "w_relfric=0且正向滑动时的摩擦力矩";
  SI.Torque tau0_max "w_relfric=0且锁定时的最大摩擦力矩";
  Boolean free "= true，如果摩擦元件未激活";
  // 下列变量的定义方程在该类中给出
  Real sa(final unit="1") 
    "摩擦特性tau = f(a_relfric)";
  Boolean startForward(start=false, fixed=true) 
    "= true，如果w_relfric=0且正向滑动开始";
  Boolean startBackward(start=false, fixed=true) 
    "= true，如果w_relfric=0且反向滑动开始";
  Boolean locked(start=false) "= true，如果w_rel=0且未滑动";
  constant Integer Unknown=3 "模式的值未知";
  constant Integer Free=2 "元素未激活";
  constant Integer Forward=1 "w_relfric > 0（正向滑动）";
  constant Integer Stuck=0 
    "w_relfric = 0（正向滑动、锁定或反向滑动）";
  constant Integer Backward=-1 "w_relfric < 0（反向滑动）";
  Integer mode(
    final min=Backward, 
    final max=Unknown, 
    start=Unknown, 
    fixed=true) 
    "摩擦的模式（-1：反向滑动，0：锁定，1：正向滑动，2：未激活，3：未知）";
protected
  constant SI.AngularAcceleration unitAngularAcceleration=1 
    annotation (HideResult=true);
  constant SI.Torque unitTorque=1 annotation (HideResult=true);
equation
  /* 摩擦特性
   locked是为了帮助Modelica翻译器确定
   不同的结构配置，
   如果为每个配置生成特殊代码
*/
  startForward = pre(mode) == Stuck and (sa > tau0_max/unitTorque or pre(
    startForward) and sa > tau0/unitTorque) or pre(mode) == Backward and 
    w_relfric > w_small or initial() and (w_relfric > 0);
  startBackward = pre(mode) == Stuck and (sa < -tau0_max/unitTorque or pre(
    startBackward) and sa < -tau0/unitTorque) or pre(mode) == Forward and 
    w_relfric < -w_small or initial() and (w_relfric < 0);
  locked = not free and not (pre(mode) == Forward or startForward or pre(
    mode) == Backward or startBackward);

  a_relfric/unitAngularAcceleration = if locked then 0 else if free then sa 
     else if startForward then sa - tau0_max/unitTorque else if 
    startBackward then sa + tau0_max/unitTorque else if pre(mode) == 
    Forward then sa - tau0_max/unitTorque else sa + tau0_max/unitTorque;

  /* 摩擦力矩必须在子类中定义。例如，对于离合器：
   tau = if locked then sa else
         if free then   0 else
         cgeo*fn*(if startForward then          Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w_relfric, 1) else
                  if startBackward then        -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -w_relfric, 1) else
                  if pre(mode) == Forward then  Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], w_relfric, 1) else
                                               -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -w_relfric, 1));
*/
  // 有限状态机确定配置
  mode = if free then Free else (if (pre(mode) == Forward or pre(mode) == 
    Free or startForward) and w_relfric > 0 then Forward else if (pre(mode) 
     == Backward or pre(mode) == Free or startBackward) and w_relfric < 0 
     then Backward else Stuck);
  annotation (Documentation(info="<html><p>
Coulomb摩擦的基本模型，以可靠的方式模拟了卡滞阶段。
</p>
<p>
这个过程通过状态事件以\"十分清晰\"的方式实现，并且 如果摩擦元件动态耦合，则导致混合连续/离散的方程系统， 必须通过适当的数值方法求解。该方法在以下文献中有描述 （请参见<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\" target=\"\">UsersGuide.ModelingOfFriction</a>中的简要概述）：
</p>
<p>
Otter M., Elmqvist H., and Mattsson S.E. (1999):
</p>
<p>
<strong>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle</strong>. CACSD\\'99, Aug. 22.-26, Hawaii.
</p>
</html>"));
end PartialFriction;