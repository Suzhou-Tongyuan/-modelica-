within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components;
model PermeanceActuator 
  "用于推杆粗磁设计和系统仿真的详细推杆模型"

  parameter Real N=140 "转数" annotation (Dialog(group= 
          "Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MovingCoilActuator/MovingCoilActuator_dimensions.png"));
  parameter SI.Resistance R=2.86 "线圈电阻";

  parameter SI.Radius r_core=12.5e-3 
    "铁磁定子铁芯半径";

  parameter SI.Length l_PM=3.5e-3 
    "永磁环径向厚度";
  parameter SI.Length t=0.02 
    "永磁环和气隙的轴向长度分别为";

  parameter SI.Length l_air=3e-3 
    "电枢气隙径向总长度";

  parameter SI.Length l_FeOut=4e-3 
    "外背铁径向厚度（用于估算泄漏渗透率）";

  parameter FluxTubes.Material.HardMagnetic.BaseData material= 
      Material.HardMagnetic.BaseData() 
    "铁磁材料特性" 
    annotation (choicesAllMatching=true, Dialog(group="Material"));

  parameter SI.Mass m_a=0.012 "电枢质量" 
    annotation (Dialog(group="Armature and stopper"));

  parameter SI.TranslationalSpringConstant c=1e11 
    "冲击副之间的弹簧刚度" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalDampingConstant d=400 
    "冲击副之间的阻尼系数" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_min=-4e-3 
    "电枢最小位置时的挡块位置" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_max=4e-3 
    "电枢最大位置时的挡块位置" 
    annotation (Dialog(group="Armature and stopper"));

  SI.Position x(start=x_min, stateSelect=StateSelect.prefer) 
    "电枢位置，法兰位置的别名";

  SI.Inductance L "线圈电感";

  FluxTubes.Sources.ConstantMagneticPotentialDifference mmf_PM(final V_m= 
       material.H_cB*l_PM) "Permanent magnet's magnetomotive force" 
    annotation (Placement(transformation(
        origin={10,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));

  FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
    final L=0, 
    final m=m_a, 
    final c=c, 
    final d=d, 
    n=2, 
    final x_max=x_max, 
    final x_min=x_min) 
    "移动线圈+线圈架的惯性；行程范围末端的挡块" 
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Electrical.Analog.Basic.Resistor r(final R=R) annotation (
      Placement(transformation(
        origin={-80,30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));

  Basic.Ground ground annotation (Placement(transformation(extent={{30, 
            -38},{50,-18}})));
  FluxTubes.Basic.ElectroMagneticConverter coil(final N=N) annotation (
      Placement(transformation(
        origin={0,-20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  FluxTubes.Shapes.Force.HollowCylinderRadialFlux g_ma(
    final dlBydx=1, 
    final l=t/2 + x, 
    final r_i=r_core, 
    final r_o=r_core + l_air + l_PM, 
    final mu_r=1.05, 
    final useSupport=false) annotation (Placement(transformation(
        origin={-20,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  FluxTubes.Shapes.Force.HollowCylinderRadialFlux g_mb(
    final r_i=r_core, 
    final r_o=r_core + l_air + l_PM, 
    final dlBydx=-1, 
    final l=t/2 - x, 
    final mu_r=1.05, 
    final useSupport=false) annotation (Placement(transformation(
        origin={30,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  FluxTubes.Shapes.Leakage.CoaxCylindersEndFaces g_mLeak1(
    final r_1=r_core + l_air + l_PM, 
    final r_2=r_core + l_air + l_PM + l_FeOut, 
    final r_0=r_core) 
    "铁磁定子铁芯同轴端面与外侧背铁之间的泄漏" 
    annotation (Placement(transformation(
        origin={-60,10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  FluxTubes.Shapes.Leakage.HalfCylinder g_mLeak2(final l=2*pi*(r_core + 
        (l_air + l_PM)/2)) 
    "铁磁定子铁芯边缘与外侧背铁之间的泄漏" 
    annotation (Placement(transformation(
        origin={-40,10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));

  Modelica.Electrical.Analog.Interfaces.PositivePin p 
    "电气连接器" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n 
    "电气连接器" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange 
    "部件法兰" annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
equation
  x = flange.s;
  L = coil.N^2*(g_ma.G_m + g_mLeak1.G_m + g_mLeak2.G_m);

  connect(armature.flange_b, flange) annotation (Line(
      points={{80,0},{100,0}}, color={0,127,0}));
  connect(r.p, p) annotation (Line(points={{-80,40},{-80,100},{-100,100}}, 
                                                                         color={0,0,255}));
  connect(armature.flange_a, g_mb.flange) 
    annotation (Line(points={{60,0},{40,0}}, color={0,127,0}));
  connect(g_mb.flange, g_ma.flange) annotation (Line(points={{40,0},{40, 
          40},{-10,40},{-10,0}}, color={0,127,0}));
  connect(g_mLeak1.port_n, g_ma.port_n) annotation (Line(points={{-60,0}, 
          {-60,-10},{-20,-10}}, color={255,127,0}));
  connect(g_mLeak2.port_n, g_ma.port_n) annotation (Line(points={{-40,0}, 
          {-40,-10},{-20,-10}}, color={255,127,0}));
  connect(g_ma.port_n, coil.port_p) annotation (Line(points={{-20,-10},{-18,-10},{-18,-12},{-14,-12},{-14,-10},{-10,-10}}, 
                                                             color={255, 
          127,0}));
  connect(coil.port_n, g_mb.port_n) 
    annotation (Line(points={{10,-10},{30,-10}},color={255,127,0}));
  connect(g_mb.port_n, mmf_PM.port_p) annotation (Line(points={{30,-10}, 
          {50,-10},{50,30},{10,30}}, color={255,127,0}));
  connect(mmf_PM.port_p, g_mLeak2.port_p) annotation (Line(points={{10, 
          30},{-40,30},{-40,20}}, color={255,127,0}));
  connect(mmf_PM.port_p, g_mLeak1.port_p) annotation (Line(points={{10, 
          30},{-60,30},{-60,20}}, color={255,127,0}));
  connect(g_ma.port_p, mmf_PM.port_n) 
    annotation (Line(points={{-20,10},{10,10}}, color={255,127,0}));
  connect(mmf_PM.port_n, g_mb.port_p) 
    annotation (Line(points={{10,10},{30,10}}, color={255,127,0}));
  connect(r.n, coil.p) annotation (Line(points={{-80,20},{-80,-30},{-10,-30}}, 
                 color={0,0,255}));
  connect(coil.n, n) annotation (Line(points={{10,-30},{10,-100},{-100,-100}}, 
                                                                           color={0,0,255}));
  connect(ground.port, g_mb.port_n) annotation (Line(
      points={{40,-18},{40,-10},{30,-10}}, color={255,127,0}));
  annotation (Documentation(info="<html>
<p>
在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator\">ConstantActuator</a> 模型的力F与电流i严格成正比，如变换器常数c所示。然而，由于线圈电感L与电枢位置x的依赖关系，在这种执行器中存在额外的非线性力分量。电感随着电枢进入定子而增加。总力是
</p>

<blockquote><pre>
    1  2 dL
F = - i  --  + c i
    2    dx
</pre></blockquote>

<p>
如下图所示，这两个力分量都可以通过一个简单的磁导模型来正确考虑。图 (a) 展示了磁导模型中所需的轴对称移动线圈致动器的尺寸。图 (b) 显示了磁通管和无电流永久磁场的划分。G_ma 和 G_mb 都是永磁体和气隙部分串联后产生的磁导率。图 (c) 显示了线圈施加的磁场图，其中没有永磁磁场（H_cB=0）。图（d）中磁网络元件的位置保留了致动器的几何结构。在图（e）中，对磁导模型进行了重组和简化.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/MovingCoilActuator/MovingCoilActuator_PermeanceModel.png\" alt=\"Structure, assigned flux tubes and field plots of the moving coil actuator\">
</div>
</html>"), 
   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Rectangle(
                  extent={{-90,100},{90,-100}}, 
                  lineColor={255,128,0}, 
                  fillColor={255,255,255}, 
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-90,100},{-50,-100}}, 
                  lineColor={0,0,255}, 
                  pattern=LinePattern.None, 
                  fillColor={255,128,0}, 
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{90,80},{-90,100}}, 
                  lineColor={0,0,255}, 
                  pattern=LinePattern.None, 
                  fillColor={255,128,0}, 
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{90,-80},{-90,-100}}, 
                  lineColor={0,0,255}, 
                  pattern=LinePattern.None, 
                  fillColor={255,128,0}, 
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{70,34},{-90,-34}}, 
                  lineColor={0,0,255}, 
                  pattern=LinePattern.None, 
                  fillColor={255,128,0}, 
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{90,52},{-16,64}}, 
                  lineColor={0,0,255}, 
                  pattern=LinePattern.None, 
                  fillColor={255,213,170}, 
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{90,-64},{-12,-52}}, 
                  lineColor={0,0,255}, 
                  pattern=LinePattern.None, 
                  fillColor={255,213,170}, 
                  fillPattern=FillPattern.Solid),Text(
                  extent={{150,150},{-150,110}}, 
                  textColor={0,0,255}, 
                  textString="%name")}));
end PermeanceActuator;