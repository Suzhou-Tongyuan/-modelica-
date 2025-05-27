within Modelica.Thermal.FluidHeatFlow.Examples;
model TestCylinder "双缸系统"
  extends Modelica.Icons.Example;
  output SI.Force f1=-10*cylinder1.f "10 x 活塞1受力";
  output SI.Position s1=0.1*cylinder1.s "0.1 x 活塞1位置";
  output SI.Position s2=cylinder2.s "活塞2位置";
  output SI.Force f2=-cylinder2.f "活塞2受力";
  output SI.Force f=springDamper.f "弹簧减振器力";
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 0.25,-1; 0.5,0; 0.75,0], 
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) 
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Mechanics.Translational.Sources.Force force 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  FluidHeatFlow.Components.Cylinder cylinder1(
    A=0.1, 
    L=10, 
    s(fixed=true, start=cylinder1.L/2), 
    T0=313.15, 
    T0fixed=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={-20,0})));
  FluidHeatFlow.Components.Cylinder cylinder2(
    T(fixed=true), 
    A=1, 
    L=1, 
    T0=313.15, 
    T0fixed=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={10,0})));
  Modelica.Mechanics.Translational.Components.Mass mass(m=1) 
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Mechanics.Translational.Components.SpringDamper springDamper(
    s_rel0=cylinder2.L/2, 
    c=100, 
    s_rel(fixed=true, start=cylinder2.L/2), 
    v_rel(fixed=true, start=0), 
    d=10) annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed 
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
equation
  connect(cylinder1.flowPort, cylinder2.flowPort) annotation (Line(points={
          {-10,-1.33227e-15},{-4,-1.33227e-15},{-4,0},{0,0}}, color={255,0,0}));
  connect(force.flange, cylinder1.flange) annotation (Line(points={{-40,0}, 
          {-34,0},{-34,1.33227e-15},{-30,1.33227e-15}}, color={0,127,0}));
  connect(combiTimeTable.y[1], force.f) 
    annotation (Line(points={{-69,0},{-62,0}}, color={0,0,127}));
  connect(cylinder2.flange, mass.flange_a) 
    annotation (Line(points={{20,0},{30,0}}, color={0,127,0}));
  connect(springDamper.flange_b, mass.flange_b) 
    annotation (Line(points={{60,0},{50,0}}, color={0,127,0}));
  connect(springDamper.flange_a, fixed.flange) 
    annotation (Line(points={{80,0},{90,0}}, color={0,127,0}));
  annotation (Documentation(info="<html><p>
双缸系统测试(体积相同):
</p>
<li>
油缸1: A = 0.1 m2, L=10. m, 初始活塞位置 s=L/2</li>
<li>
油缸2: A = 1.0 m2, L=1.0 m, 初始活塞位置 s=L/2</li>
<p>
在活塞1上施加1 Nm的力，从0.25 s到0.50 s。 因为面积比是10:1
</p>
<li>
作用于活塞2的力是作用于活塞1的力的十倍</li>
<li>
活塞1的运动是活塞2运动的十倍</li>
<p>
在活塞2上安装了一个物体，它移动并按压弹簧阻尼器。 当活塞1上的力被移开时，弹簧减振器将质量向后推，产生阻尼振荡.
</p>
<p>
注释: 注意初始条件。未拉伸的弹簧长度为圆柱2，L / 2, i.e. 当活塞2处于气缸中间时，弹簧对质量(和活塞2)不施加任何力。.
</p>
</html>"), experiment(StopTime=2, Interval=0.001));
end TestCylinder;