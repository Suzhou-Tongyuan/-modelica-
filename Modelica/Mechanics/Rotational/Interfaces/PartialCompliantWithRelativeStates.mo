within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialCompliantWithRelativeStates 
    "具有相对角度和角速度作为首选状态的两个一维转动接口的弹性连接的部分模型"

  SI.Angle phi_rel(
    start=0, 
    stateSelect=stateSelect, 
    nominal=if phi_nominal >= Modelica.Constants.eps then phi_nominal else 
        1) "相对转动角度（= flange_b.phi - flange_a.phi）";
  SI.AngularVelocity w_rel(start=0, stateSelect=stateSelect) 
    "相对角速度（= der(phi_rel))";
  SI.AngularAcceleration a_rel(start=0) 
    "相对角加速度（= der(w_rel))";
  SI.Torque tau "一维转动接口之间的扭矩（= flange_b.tau）";
  Flange_a flange_a "具有弹性连接的一维转动组件的左侧一维转动接口" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "具有弹性连接的一维转动组件的右侧一维转动接口" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  parameter SI.Angle phi_nominal(
    displayUnit="rad", 
    min=0.0) = 1e-4 "phi_rel的标称值（用于缩放）" 
    annotation (Dialog(tab="高级"));
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用phi_rel和w_rel作为状态" 
    annotation (HideResult=true, Dialog(tab="高级"));

equation
  phi_rel = flange_b.phi - flange_a.phi;
  w_rel = der(phi_rel);
  a_rel = der(w_rel);
  flange_b.tau = tau;
  flange_a.tau = -tau;
  annotation (Documentation(info="<html><p>
这是一个具有弹性连接的一维转动组件，其中有两个一维转动接口，并忽略了两个一维转动接口之间的惯性影响。基本假设是两个一维转动接口的局部力矩总和为零，即它们具有相同的绝对值但相反的符号：flange_a.tau + flange_b.tau = 0。此基类用于构建诸如弹簧、减震器、摩擦等力元素。
</p>
<p>
相对角度和相对速度被定义为首选状态的原因是对于某些传动系统，例如车辆中的传动系统，绝对角度在运行过程中会快速增加。从数值上讲，使用传动系统组件之间的相对角度作为状态变量更好，因为它们保持在有限的大小范围内。因此，对于该组件的相对角度，将StateSelect.prefer设置为优先。
</p>
<p>
为了改善数值计算，可以通过高级菜单中的参数<strong>phi_nominal</strong>提供相对角度的标称值。默认值为1e-4 rad，因为相对角度通常在此数量级，如果使用默认值1 rad，则积分器的步长控制实际上将被关闭。此标称值也可以从其他值计算得出，例如“phi_nominal = tau_nominal / c”，如果tau_nominal和c对用户更有意义。
</p>
<p>
还请参阅Rotational库中用户指南的<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\" target=\"\">State Selection</a>的讨论。
</p>
</html>"));
end PartialCompliantWithRelativeStates;