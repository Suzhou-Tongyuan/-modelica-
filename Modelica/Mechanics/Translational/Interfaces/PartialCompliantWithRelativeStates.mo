within Modelica.Mechanics.Translational.Interfaces;
partial model PartialCompliantWithRelativeStates 
  "两个一维平动接口的相对状态弹性连接的基础模型，其中相对位置和相对速度用作状态"

  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用 s_rel 和 v_rel 作为状态" 
    annotation (HideResult=true, Dialog(tab="高级"));
  parameter SI.Distance s_nominal=1e-4 
    "s_rel 的标称值 (用于缩放)" 
    annotation (Dialog(tab="高级"));

  SI.Position s_rel(
    start=0, 
    stateSelect=stateSelect, 
    nominal=s_nominal) "相对距离 (= flange_b.s - flange_a.s)";
  SI.Velocity v_rel(start=0, stateSelect=stateSelect) 
    "相对速度(= der(s_rel))";

  SI.Force f "一维平动接口之间的力 (= flange_b.f)";
  extends Translational.Interfaces.PartialTwoFlanges;
equation
  s_rel = flange_b.s - flange_a.s;
  v_rel = der(s_rel);
  flange_b.f = f;
  flange_a.f = -f;
  annotation (Documentation(info="<html><p>
这是一个一维传动组件，具有两个传动式一维平动接口的相对状态弹性连接，其中两个一维平动接口之间的惯性效应被忽略。 基本假设是两个一维平动接口的切割力相加为零，即它们的绝对值相同但符号相反：flange_a.f + flange_b.f = 0。 这个基类用于建立诸如弹簧、阻尼器、摩擦等力元素。
</p>
<p>
与基类“PartialCompliant”不同的是，相对距离和相对速度被定义为首选状态。 原因是对于大多数传动系统，绝对位置在操作过程中会迅速增加。 在数值上，最好使用传动系统组件之间的相对距离，因为它们保持在一个有限的范围内。 因此，对于此组件的相对距离设置了 StateSelect.prefer。
</p>
<p>
为了改善数值稳定性，应设置相对距离的标称值，因为传动系统的距离都是小量， 这样一来，积分器的步长控制实际上就关闭了。 定义了默认的标称值 s_nominal = 1e-4。 此标称值也可以从其他值计算得出，例如对于弹簧，可以计算出 s_nominal = f_nominal / c， 其中 f_nominal 和 c 对用户有更有意义的值。
</p>
</html>"));
end PartialCompliantWithRelativeStates;