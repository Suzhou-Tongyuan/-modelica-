within Modelica.Magnetic.FluxTubes.Examples.SolenoidActuator.Components;
model SimpleSolenoid 
  "带有平面衔铁端面的起重磁铁的简单网络模型"

  parameter SI.Resistance R=10 "电枢线圈电阻";
  parameter Real N=957 "转数";

  //yoke
  parameter SI.Radius r_yokeOut=15e-3 "外轭半径" annotation (
      Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/Solenoid_dimensions.png"));
  parameter SI.Radius r_yokeIn=13.5e-3 "内轭半径";
  parameter SI.Length l_yoke=35e-3 "轴轭长";
  parameter SI.Length t_yokeBot=3.5e-3 "轭底轴向厚度";

  //pole
  parameter SI.Length l_pole=6.5e-3 "磁极轴向长度";
  parameter SI.Length t_poleBot=3.5e-3 
    "极边底部轴向厚度";

  parameter SI.Length t_airPar=0.65e-3 
    "滑动导轨造成的寄生气隙径向厚度";

  parameter FluxTubes.Material.SoftMagnetic.BaseData material= 
      Material.SoftMagnetic.Steel.Steel_9SMnPb28() 
    "铁磁材料特性" 
    annotation (choicesAllMatching=true, Dialog(group="Material"));

  //电枢
  parameter SI.Radius r_arm=5e-3 "电枢半径 = 磁极半径" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Length l_arm=26e-3 "电枢长度" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalSpringConstant c=1e11 
    "冲击副之间的弹簧刚度" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.TranslationalDampingConstant d=400 
    "冲击副之间的阻尼系数" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_min=0.25e-3 
    "电枢最小位置的限位器" 
    annotation (Dialog(group="Armature and stopper"));
  parameter SI.Position x_max=5e-3 
    "电枢最大位置的限位器" 
    annotation (Dialog(group="Armature and stopper"));

  SI.Position x(start=x_max, stateSelect=StateSelect.prefer) 
    "电枢位置，法兰位置的别名（与工作气隙长度相同）";

protected
  parameter SI.Density rho_steel=7853 
    "根据几何形状计算电枢质量的密度";

public
  FluxTubes.Basic.Ground ground annotation (Placement(transformation(
          extent={{50,10},{70,30}})));
  FluxTubes.Basic.ElectroMagneticConverter coil(final N=N, i(fixed=true)) 
    "电磁转换器" annotation (Placement(transformation(
        origin={0,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Electrical.Analog.Basic.Resistor r(final R=R) 
    "线圈电阻" annotation (Placement(transformation(extent={{-70, 
            -30},{-50,-10}})));
  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeYokeSide(
    final nonLinearPermeability=true, 
    final material=material, 
    final l=l_yoke - (t_poleBot + t_yokeBot)/2, 
    final r_i=r_yokeIn, 
    final r_o=r_yokeOut) 
    "铁磁磁轭空心圆柱形截面的磁导率" 
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));

  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFeArm(
    final nonLinearPermeability=true, 
    final material=material, 
    final l=l_yoke - (t_yokeBot + t_poleBot)/2 - l_pole - (x_max + 
        x_min)/2, 
    final r_i=0, 
    final r_o=r_arm) "Permeance of ferromagnetic armature" annotation (
      Placement(transformation(
        origin={16,40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));

  FluxTubes.Shapes.Force.HollowCylinderAxialFlux g_mAirWork(
    final mu_r=1, 
    final dlBydx=1, 
    final r_i=0, 
    final r_o=r_arm, 
    final useSupport=false, 
    final l=flange.s) 
    "工作气隙（电枢和磁极端面之间）的渗透率" 
    annotation (Placement(transformation(
        origin={-30,30}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFeYokeBot(
    final nonLinearPermeability=true, 
    final material=material, 
    final l=t_yokeBot, 
    final r_i=r_arm + t_airPar, 
    final r_o=r_yokeIn) 
    "铁磁轭底面的磁导率" annotation (
      Placement(transformation(
        origin={80,80}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));

  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mAirPar(
    final nonLinearPermeability=false, 
    final mu_rConst=1, 
    final l=t_yokeBot, 
    final r_i=r_arm, 
    final r_o=r_arm + t_airPar) 
    "滑动导轨造成的寄生径向气隙的渗透率" 
    annotation (Placement(transformation(
        origin={80,50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  FluxTubes.Shapes.FixedShape.HollowCylinderRadialFlux g_mFePoleBot(
    final l=t_poleBot, 
    final r_i=r_arm, 
    final r_o=r_yokeIn, 
    final nonLinearPermeability=true, 
    final material=material) "Permeance of bottom side of pole" 
    annotation (Placement(transformation(
        origin={-72,80}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));

  FluxTubes.Shapes.FixedShape.HollowCylinderAxialFlux g_mFePole(
    final nonLinearPermeability=true, 
    final material=material, 
    final l=l_pole, 
    final r_i=0, 
    final r_o=r_arm) "Permeance of ferromagnetic pole" annotation (
      Placement(transformation(
        origin={-72,40}, 
        extent={{10,-10},{-10,10}}, 
        rotation=270)));

  FluxTubes.Examples.Utilities.TranslatoryArmatureAndStopper armature(
    final m=rho_steel*l_arm*pi*r_arm^2, 
    final x_max=x_max, 
    final x_min=x_min, 
    final L=0, 
    final c=c, 
    final d=d, 
    n=2, 
    v(fixed=true)) 
    "电枢和挡块在冲程范围末端的惯性" 
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
  FluxTubes.Shapes.Leakage.QuarterCylinder g_mLeak1(l=2*pi*(r_arm + 
        t_airPar/2)) 
    "轭孔内缘与电枢侧表面之间的泄漏渗透率" 
    annotation (Placement(transformation(
        origin={60,50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  FluxTubes.Shapes.Leakage.QuarterHollowCylinder g_mLeak2(final l=2*pi* 
        r_arm, final ratio=8) 
    "磁轭底部内侧与电枢侧之间的泄漏磁导率（r_i = t_airPar）" 
    annotation (Placement(transformation(
        origin={40,50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  FluxTubes.Shapes.Force.LeakageAroundPoles g_mLeakWork(
    final mu_r=1, 
    final dlBydx=1, 
    final w=2*pi*(r_arm + 0.0015), 
    final r=0.003, 
    final l=flange.s, 
    final useSupport=false) 
    "工作气隙（电枢和磁极侧表面之间）周围泄漏气隙的渗透率" 
    annotation (Placement(transformation(
        origin={-30,70}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p 
    "电气连接器" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n 
    "电气连接器" annotation (Placement(transformation(extent={{-90,-110},{-110,-90}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange 
    "组件法兰" annotation (Placement(transformation(extent={
            {90,-10},{110,10}})));
equation
  x = flange.s;
  connect(r.p, p) annotation (Line(points={{-70,-20},{-90,-20},{-90,100},{-100,100}}, 
                      color={0,0,255}));
  connect(armature.flange_b, flange) annotation (Line(points={{84,0},{
          88,0},{92,0},{100,0}}, color={0,127,0}));
  connect(armature.flange_a, g_mAirWork.flange) annotation (Line(points= 
         {{64,0},{34,0},{34,52},{-30,52},{-30,40}}, color={0,127,0}));
  connect(g_mAirWork.flange, g_mLeakWork.flange) annotation (Line(
        points={{-30,40},{-30,52},{34,52},{34,80},{-30,80}}, color={0, 
          127,0}));
  connect(r.n, coil.p) annotation (Line(points={{-50,-20},{-10,-20},{-10,10}}, 
                color={0,0,255}));
  connect(coil.n, n) annotation (Line(points={{10,10},{10,-100},{-100,-100}}, 
                                                                          color={0,0,255}));
  connect(coil.port_p, g_mAirWork.port_p) 
    annotation (Line(points={{-10,30},{-20,30}},color={255,127,0}));
  connect(g_mAirWork.port_p, g_mLeakWork.port_p) 
    annotation (Line(points={{-20,30},{-20,70}}, color={255,127,0}));
  connect(g_mAirWork.port_n, g_mLeakWork.port_n) 
    annotation (Line(points={{-40,30},{-40,70}}, color={255,127,0}));
  connect(g_mFePole.port_p, g_mAirWork.port_n) 
    annotation (Line(points={{-72,30},{-40,30}}, color={255,127,0}));
  connect(g_mFePoleBot.port_p, g_mFePole.port_n) 
    annotation (Line(points={{-72,70},{-72,50}}, color={255,127,0}));
  connect(g_mFePoleBot.port_n, g_mFeYokeSide.port_p) 
    annotation (Line(points={{-72,90},{-10,90}}, color={255,127,0}));
  connect(g_mFeYokeSide.port_n, g_mFeYokeBot.port_n) 
    annotation (Line(points={{10,90},{80,90}}, color={255,127,0}));
  connect(g_mFeYokeBot.port_p, g_mAirPar.port_n) 
    annotation (Line(points={{80,70},{80,60}}, color={255,127,0}));
  connect(g_mFeArm.port_p, g_mLeak2.port_p) 
    annotation (Line(points={{26,40},{40,40}}, color={255,127,0}));
  connect(g_mLeak2.port_p, g_mLeak1.port_p) 
    annotation (Line(points={{40,40},{60,40}}, color={255,127,0}));
  connect(g_mLeak1.port_p, g_mAirPar.port_p) 
    annotation (Line(points={{60,40},{80,40}}, color={255,127,0}));
  connect(g_mLeak2.port_n, g_mLeak1.port_n) 
    annotation (Line(points={{40,60},{60,60}}, color={255,127,0}));
  connect(g_mLeak1.port_n, g_mAirPar.port_n) 
    annotation (Line(points={{60,60},{80,60}}, color={255,127,0}));
  connect(g_mFeArm.port_n, coil.port_n) annotation (Line(points={{6,40},{6,30},{10,30}}, 
                          color={255,127,0}));
  connect(ground.port, g_mLeak1.port_p) annotation (Line(
      points={{60,30},{60,40}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(
      preserveAspectRatio=true, 
      extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
        extent={{-90,100},{90,-100}}, 
        lineColor={255,255,255}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{90,-30},{-4,30}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{-40,-30},{-90,30}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{-80,-100},{-90,100}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{90,90},{-90,100}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{90,-100},{-90,-90}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{90,40},{80,100}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{90,-100},{80,-40}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{-70,80},{70,40}}, 
        lineColor={255,213,170}, 
        fillColor={255,213,170}, 
        fillPattern=FillPattern.Solid), 
      Rectangle(
        extent={{-70,-40},{70,-80}}, 
        lineColor={255,213,170}, 
        fillColor={255,213,170}, 
        fillPattern=FillPattern.Solid), 
      Text(
        extent={{150,150},{-150,110}}, 
        textColor={0,0,255}, 
        textString="%name")}), Documentation(info="<html>
<p>
请参阅<strong>参数</strong>部分，了解这种轴对称起重磁铁的原理图。
在下面的半剖面图中，推杆磁路的磁通管元件叠加在通过有限元分析获得的磁场图上。线圈施加的磁动力被模拟为一个块状元件。因此，无法正确考虑电枢和磁轭之间的径向漏磁通，尤其是在工作气隙较大的情况下。与有限元分析相比，这导致在工作气隙较大（即电枢接近 x_max）时，总磁阻较高，电感较低。请参阅与各个模型组件相关的注释，简要了解它们在模型中的作用.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/SolenoidActuator/SimpleSolenoidModel_fluxTubePartitioning.png\" alt=\"Field lines and assigned flux tubes of the simple solenoid model\">
</div>

<p>
在本例中，线圈中的耦合系数 c_coupl 设为 1，因为通量管元素 G_mLeakWork 明确考虑了泄漏通量。虽然这个泄漏模型相当简单，但它充分描述了泄漏磁场引起的磁阻力，尤其是在大气隙情况下。随着气隙长度的减小，由于主工作气隙 G_mAirWork 的影响增大，泄漏磁通对致动器净磁阻力的影响也随之减小。.
</p>

<p>
在基于模型的推杆设计过程中，通量管元件的半径和长度（以及它们的横截面积和通量密度）应该用参数方程来指定，以便满足通用的设计规则（例如，铁磁性部件中允许的通量密度、允许的电流密度和所需的绕组横截面积）。为简单起见，示例中省略了这些方程。取而代之的是将找到的值直接分配给模型元素.
</p>
</html>"));
end SimpleSolenoid;