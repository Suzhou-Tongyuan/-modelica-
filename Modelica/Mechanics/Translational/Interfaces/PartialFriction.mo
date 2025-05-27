within Modelica.Mechanics.Translational.Interfaces;
partial model PartialFriction "库仑摩擦元件的基础模型"

  //扩展自 Translational.Interfaces.PartialRigid;
  parameter SI.Velocity v_small=1e-3 
    "接近零时的相对速度（请参阅模型信息文本）" 
    annotation (Dialog(tab="高级"));
  // 必须在子类中定义以下变量的方程式
  SI.Velocity v_relfric "摩擦表面之间的相对速度";
  SI.Acceleration a_relfric 
    "摩擦表面之间的相对加速度";
  //SI.Force f "摩擦力（正方向，如果朝相对速度的反方向）";
  SI.Force f0 "当 v_relfric=0 且正向滑动时的摩擦力";
  SI.Force f0_max "当 v_relfric=0 且锁定时的最大摩擦力";
  Boolean free "= true，如果摩擦元件不活跃";
  // Equations to define the following variables are given in this class
  Real sa(unit="1") 
    "摩擦特性的路径参数 f = f(a_relfric)";
  Boolean startForward(start=false, fixed=true) 
    "= true，如果 v_relfric=0 并且开始正向滑动";
  Boolean startBackward(start=false, fixed=true) 
    "= true，如果 v_relfric=0 并且开始反向滑动";
  Boolean locked(start=false) "= true，如果 v_relfric=0 并且不滑动";
  constant Integer Unknown=3 "模式的值未知";
  constant Integer Free=2 "元件不活跃";
  constant Integer Forward=1 "v_relfric > 0（正向滑动）";
  constant Integer Stuck=0 
    "v_relfric = 0（正向滑动，锁定或反向滑动）";
  constant Integer Backward=-1 "v_relfric < 0（反向滑动）";
  Integer mode(
    final min=Backward, 
    final max=Unknown, 
    start=Unknown, 
    fixed=true) 
    "摩擦的模式（-1: 反向滑动，0: 锁定，1: 正向滑动，2: 不活跃，3: 未知）";
protected
  constant SI.Acceleration unitAcceleration=1 annotation (HideResult=true);
  constant SI.Force unitForce=1 annotation (HideResult=true);
equation
  /* 摩擦特性
   （引入 locked 是为了帮助 Modelica 翻译器确定不同的结构配置，
   如果每个配置都要生成特殊代码）
*/
  startForward = pre(mode) == Stuck and (sa > f0_max/unitForce or pre(
    startForward) and sa > f0/unitForce) or pre(mode) == Backward and 
    v_relfric > v_small or initial() and (v_relfric > 0);
  startBackward = pre(mode) == Stuck and (sa < -f0_max/unitForce or pre(
    startBackward) and sa < -f0/unitForce) or pre(mode) == Forward and 
    v_relfric < -v_small or initial() and (v_relfric < 0);
  locked = not free and not (pre(mode) == Forward or startForward or pre(
    mode) == Backward or startBackward);

  a_relfric/unitAcceleration = if locked then 0 else if free then sa else 
    if startForward then sa - f0_max/unitForce else if startBackward then 
    sa + f0_max/unitForce else if pre(mode) == Forward then sa - f0_max/ 
    unitForce else sa + f0_max/unitForce;

  /* 摩擦力矩必须在子类中定义。例如，对于离合器：
   f = if locked then sa else
       if free then   0 else
       cgeo*fn*(if startForward then          Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], v_relfric, 1) else
                if startBackward then        -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -v_relfric, 1) else
                if pre(mode) == Forward then  Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], v_relfric, 1) else
                                             -Modelica.Math.Vectors.interpolate(mu_pos[:,1], mu_pos[:,2], -v_relfric, 1));
*/
  // 有限状态机以确定配置
  mode = if free then Free else (if (pre(mode) == Forward or pre(mode) == 
    Free or startForward) and v_relfric > 0 then Forward else if (pre(mode) 
     == Backward or pre(mode) == Free or startBackward) and v_relfric < 0 
     then Backward else Stuck);
  annotation (Documentation(info="<html>
<p>
基于状态事件可靠方式模拟卡死相位的库仑摩擦的基本模型。
</p>

<p>
通过状态事件实现了这一过程，并且通过适当的数值方法解决了耦合动态摩擦元件的混合连续/离散方程。该方法在以下文献中有描述：
（也可以参见<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a> 中的简短概述）：
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
</html>"));
end PartialFriction;