within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialCompliant 
  "具有两个一维转动接口的弹性连接的部分模型"

  SI.Angle phi_rel(start=0) 
    "相对旋转角度（= flange_b.phi - flange_a.phi）";
  SI.Torque tau "一维转动接口之间的扭矩（= flange_b.tau）";
  Flange_a flange_a "具有弹性连接的一维旋转组件的左侧一维转动接口" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "具有弹性连接的一维旋转组件的右侧一维转动接口" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  phi_rel = flange_b.phi - flange_a.phi;
  flange_b.tau = tau;
  flange_a.tau = -tau;
  annotation (Documentation(info="<html>
<p>
这是一个具有弹性连接的一维旋转组件，其中有两个一维旋转轴的转动接口，忽略了两个一维转动接口之间的惯性影响。
基本假设是两个一维转动接口的局部力矩总和为零，即它们具有相同的绝对值但相反的符号：flange_a.tau + flange_b.tau = 0。
此基类用于构建诸如弹簧、减震器、摩擦等力元素。
</p>
</html>"));
end PartialCompliant;