﻿within Modelica.Mechanics.Translational.Examples;
model PreLoad "使用ElastoGap模型预载一个滑阀"

  extends Modelica.Icons.Example;

  Translational.Components.ElastoGap innerContactA(
    c=1000e3, 
    d=250, 
    s_rel0=0.001) annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  Translational.Components.ElastoGap innerContactB(
    c=1000e3, 
    d=250, 
    s_rel0=0.001) annotation (Placement(transformation(extent={{50,0},{70,20}})));
  Translational.Components.Mass spool(
    L=0.19, 
    m=0.150, 
    s(start=0.01475, fixed=true), 
    v(fixed=true)) annotation (Placement(transformation(extent={{10,-70},{50,-30}})));
  Translational.Components.Fixed fixedLe(s0=-0.0955) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-90,70})));
  Translational.Components.Mass springPlateA(
    m=10e-3, 
    L=0.002, 
    s(start=-0.093, fixed=true), 
    v(fixed=true)) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Translational.Components.Mass springPlateB(
    m=10e-3, 
    s(start=-0.06925, fixed=true), 
    L=0.002, 
    v(fixed=true)) annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Translational.Components.Spring spring(c=20e3, s_rel0=0.025) annotation (
      Placement(transformation(extent={{-10,40},{10,60}})));
  Translational.Components.ElastoGap outerContactA(
    c=1000e3, 
    d=250, 
    s_rel0=0.0015) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Translational.Components.ElastoGap outerContactB(
    c=1000e3, 
    d=250, 
    s_rel0=0.0015) annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Translational.Components.Rod rod1(L=0.007) annotation (Placement(
        transformation(extent={{-40,10},{-20,30}})));
  Translational.Components.Damper friction(d=2500) annotation (Placement(
        transformation(
        origin={-80,30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Translational.Sources.Force force annotation (Placement(transformation(
          extent={{-38,-60},{-18,-40}})));
  Translational.Components.Rod housing(L=0.0305) annotation (Placement(
        transformation(extent={{-10,60},{10,80}})));
  Translational.Components.Rod rod3(L=0.00575) annotation (Placement(
        transformation(extent={{-40,-20},{-20,0}})));
  Translational.Components.Rod rod4(L=0.00575) annotation (Placement(
        transformation(extent={{20,-20},{40,0}})));
  Translational.Components.Rod rod2(L=0.007) annotation (Placement(
        transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Sources.Sine sineForce(amplitude=150, f=0.01) 
    annotation (Placement(transformation(extent={{-78,-60},{-58,-40}})));
equation
  connect(outerContactA.flange_b, springPlateA.flange_a) 
    annotation (Line(points={{-50,50},{-40,50}}, color={0,127,0}));
  connect(springPlateA.flange_b, spring.flange_a) annotation (Line(points={{-20,50},{-10,50}}, 
                                       color={0,127,0}));
  connect(spring.flange_b, springPlateB.flange_a) 
    annotation (Line(points={{10,50},{20,50}}, color={0,127,0}));
  connect(springPlateB.flange_b, outerContactB.flange_a) 
    annotation (Line(points={{40,50},{50,50}},         color={0,127,0}));
  connect(outerContactB.flange_b, housing.flange_b) 
    annotation (Line(points={{70,50},{80,50},{80,70},{10,70}}, 
                                                       color={0,127,0}));
  connect(springPlateA.flange_b, rod1.flange_a) annotation (Line(points={{-20,50},{-20,32},{-40,32},{-40,20}}, 
                                           color={0,127,0}));
  connect(innerContactA.flange_a, rod3.flange_a) annotation (Line(points={{-70,10},{-80,10},{-80,-10},{-40,-10}}, 
                                             color={0,127,0}));
  connect(innerContactA.flange_b, rod1.flange_b) annotation (Line(points={{-50,10},{-20,10},{-20,20}}, 
                                      color={0,127,0}));
  connect(rod2.flange_a, innerContactB.flange_a) 
    annotation (Line(points={{20,20},{20,10},{50,10}}, color={0,127,0}));
  connect(rod4.flange_b, innerContactB.flange_b) 
    annotation (Line(points={{40,-10},{80,-10},{80,10},{70,10}}, 
                                                     color={0,127,0}));
  connect(friction.flange_b, rod3.flange_a) 
    annotation (Line(points={{-80,20},{-80,-10},{-40,-10}}, 
                                                        color={0,127,0}));
  connect(rod3.flange_b, rod4.flange_a) 
    annotation (Line(points={{-20,-10},{20,-10}}, 
                                              color={0,127,0}));
  connect(rod2.flange_b, springPlateB.flange_a) annotation (Line(points={{40,20},{40,32},{20,32},{20,50}}, 
                                           color={0,127,0}));
  connect(spool.flange_a, rod4.flange_a) 
    annotation (Line(points={{10,-50},{0,-50},{0,-10},{20,-10}}, 
                                                    color={0,127,0}));
  connect(sineForce.y, force.f) annotation (Line(points={{-57,-50},{-40,-50}}, 
                      color={0,0,127}));
  connect(force.flange, spool.flange_a) annotation (Line(
      points={{-18,-50},{10,-50}},color={0,127,0}));
  connect(outerContactA.flange_a, fixedLe.flange) annotation (Line(
      points={{-70,50},{-80,50},{-80,70},{-90,70}}, 
                                           color={0,127,0}));
  connect(housing.flange_a, fixedLe.flange) annotation (Line(
      points={{-10,70},{-90,70}}, color={0,127,0}));
  connect(friction.flange_a, fixedLe.flange) annotation (Line(
      points={{-80,40},{-80,70},{-90,70}}, 
                                  color={0,127,0}));
  annotation (
    Documentation(info="<html>
<p>
设计液压阀时，通常需要在外部力低于阈值时将滑阀保持在某个位置。
如果该力超过阈值，则希望力与位置之间存在线性关系。
在有一些设计中只需要一个弹簧就可以完成这项任务。使用 ElastoGap 元素，
可以轻松地建模此设计。
下图为滑阀绘制。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Examples/PreLoad1.png\" alt=\"Preload 1\"><br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Examples/PreLoad3.png\" alt=\"Preload 3\"><br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Examples/PreLoad4.png\" alt=\"Preload 4\"><br>
</div>

<p>
模拟 100&nbsp;秒并绘制滑阀位置 <code>spool.s</code>
作为工作力 <code>force.f</code> 的函数。
对于正向力，滑阀朝正向移动 - 在下图中，起始值 <code>spool.s.start</code> 影响偏移量。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Examples/PreLoad2.png\" alt=\"Preload 2\">
</div>
</html>"), 
    experiment(StopTime=100, Interval=0.1));
end PreLoad;