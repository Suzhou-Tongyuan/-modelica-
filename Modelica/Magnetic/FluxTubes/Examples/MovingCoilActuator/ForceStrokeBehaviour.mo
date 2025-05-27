within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator;
model ForceStrokeBehaviour 
  "恒定电流下渗透模型的力-行程特性"

  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-70,-30},{-50,-10}})));
  FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator actuator(x(start=0), 
      material=Material.HardMagnetic.PlasticNdFeB()) annotation (
      Placement(transformation(extent={{-30,0},{-10,20}})));
  Modelica.Electrical.Analog.Sources.ConstantCurrent source(I=3) 
    annotation (Placement(transformation(
        origin={-60,10}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Blocks.Sources.Ramp sweepX(
    height=7.99e-3, 
    duration=8, 
    offset=-3.995e-3, 
    startTime=-4) annotation (Placement(transformation(extent={{70,0},{50, 
            20}})));
  Modelica.Mechanics.Translational.Sources.Position feedX(exact=true) 
    annotation (Placement(transformation(extent={{30,0},{10,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[-0.004, -8.8729,
        -9.07503, 0.00332; -0.0035, -9.05239, -9.25042, 0.00352; -0.003,
        -9.1915, -9.38558, 0.00371; -0.0025, -9.28247, -9.47266, 0.0039;
        -0.002, -9.3587, -9.54503, 0.00409; -0.0015, -9.41568, -9.59782,
        0.00429; -0.001, -9.45496, -9.6331, 0.00448; -0.0005, -9.47427, -9.64839,
        0.00467; 0, -9.48639, -9.65616, 0.00486; 0.0005, -9.48623, -9.65174,
        0.00505; 0.001, -9.4732, -9.63435, 0.00524; 0.0015, -9.44143, -9.59825,
        0.00543; 0.002, -9.39915, -9.55226, 0.00562; 0.0025, -9.33166, -9.47988,
        0.00581; 0.003, -9.23707, -9.38112, 0.006; 0.0035, -9.09497, -9.23417,
        0.00619; 0.004, -8.91839, -9.05337, 0.00638]) 
    "第 1 栏：位置，第 2 栏：非线性定子铁芯受力，第 3 栏：mu_rFe=const.=1000 时的受力，第 4 栏：mu_rFe=const.=1000 时的电感。" 
    annotation (Placement(transformation(extent={{50,30},{70,50}})));
equation
  connect(ground.p, source.n) 
    annotation (Line(points={{-60,-10},{-60,0}}, color={0,0,255}));
  connect(source.n, actuator.n) annotation (Line(points={{-60,0},{-46,0},{-46,0},{-30,0}}, 
                            color={0,0,255}));
  connect(source.p, actuator.p) annotation (Line(points={{-60,20},{-46,20},{-46,20},{-30,20}}, 
                              color={0,0,255}));
  connect(sweepX.y, feedX.s_ref) 
    annotation (Line(points={{49,10},{32,10}}, color={0,0,127}));
  connect(feedX.flange, actuator.flange) 
    annotation (Line(points={{10,10},{-10,10}}, color={0,127,0}));
  connect(feedX.s_ref, comparisonWithFEA.u) 
    annotation (Line(points={{32,10},{40,10},{40,40},{48,40}}, 
                                                       color={0,0,127}));
  annotation (experiment(
      StartTime=-4, 
      StopTime=4, 
      Tolerance=1e-007), Documentation(info="<html>
<p>
看一下<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. ConstantActuator\">ConstantActuator</a> 和<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. PermeanceActuator\">PermeanceActuator</a> 两个转换器模型的解释.<br>
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. PermeanceActuator\">PermeanceActuator</a>恒定电流I=3A和强制电枢运动(类似于现实中的测量)的PermeanceActuator显示了产生力的磁通G_ma和G_mb以及电感L对电枢位置x的依赖关系。<strong>模拟8 s</strong>和<strong>图与</strong>电枢位置<strong>feedX.flange_b。S </strong>(相同的物理量放在一个共同的图中进行比较):</p>
<blockquote><pre>
feedX.flange_b.f            // 磁导率模型力（该模型忽略了定子铁的磁导率）
comparisonWithFEA.y[1]      // 带有非线性定子铁的有限元模型力 1.0718
comparisonWithFEA.y[2]      // 在 mu_rFe=const.=1000 条件下的有限元模型的力
actuator.g_ma.G_m           // 磁导率 G_ma
actuator.g_mb.G_m           // 磁导率 G_mb
actuator.L                  // 磁导模型的电感
comparisonWithFEA.y[3]      // 用于比较的有限元分析模型电感（mu_rFe=const.=1000）.
</pre></blockquote>
</html>"));
end ForceStrokeBehaviour;