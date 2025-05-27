within Modelica.Mechanics.MultiBody.Examples.Loops;
model EngineV6_analytic 
  "V6发动机，具有6个气缸、6个平面运动环、1个自由度以及对运动环的解析处理"

  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, 如果要启用动画效果";
  output Modelica.Units.NonSI.AngularVelocity_rpm 
    engineSpeed_rpm= 
         Modelica.Units.Conversions.to_rpm(load.w) "发动机转速";
  output SI.Torque engineTorque = filter.u 
    "发动机产生的扭矩";
  output SI.Torque filteredEngineTorque = filter.y 
    "发动机产生的过滤扭矩";

  inner Modelica.Mechanics.MultiBody.World world(animateWorld=false, 
      animateGravity =                                                              false) 
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Utilities.EngineV6_analytic engine(redeclare model Cylinder = 
        Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.Cylinder_analytic_CAD) 
    annotation (Placement(transformation(extent={{-40,0},{0,40}})));
  Modelica.Mechanics.Rotational.Components.Inertia load(
                                             phi(
      start=0, 
      fixed=true), w(
      start=10, 
      fixed=true), 
    stateSelect=StateSelect.always, 
    J=1) annotation (Placement(transformation(
          extent={{40,10},{60,30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque load2(
                                                 tau_nominal=-100, w_nominal= 
        200, 
    useSupport=false) 
             annotation (Placement(transformation(extent={{90,10},{70,30}})));
  Rotational.Sensors.TorqueSensor torqueSensor 
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
  Blocks.Continuous.CriticalDamping filter(
    n=2, 
    initType=Modelica.Blocks.Types.Init.SteadyState, 
    f=5) annotation (Placement(transformation(extent={{30,-20},{50,0}})));
equation

  connect(world.frame_b, engine.frame_a) 
    annotation (Line(
      points={{-60,-10},{-20,-10},{-20,-0.2}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(load2.flange, load.flange_b) 
    annotation (Line(points={{70,20},{60,20}}));
  connect(torqueSensor.flange_a, engine.flange_b) 
    annotation (Line(points={{10,20},{2,20}}));
  connect(torqueSensor.flange_b, load.flange_a) 
    annotation (Line(points={{30,20},{40,20}}));
  connect(torqueSensor.tau, filter.u) annotation (Line(points={{12,9},{12,-10},{28,-10}}, 
                     color={0,0,127}));
  annotation (
    Documentation(info="<html><p>
这个模型与“EngineV6”示例类似。然而，气缸是通过组件Modelica.Mechanics.MultiBody.Joints.Assemblies.JointRRR构建的，该组件通过集合三个旋转关节来<strong>解析</strong>地解决非线性方程组，并且仅使用一个包含曲轴总质量的刚体。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6_CAD_small.png\">
</p>
<p style=\"text-align: start;\">这个模型的运行速度大约是“EngineV6”示例的20倍，并且不会出现线性或非线性方程组。相比之下，“EngineV6”示例导致产生6个非线性方程组(每个方程组的维度为5，当Evaluate=false时；维度为1，当Evaluate=true时)，以及一个包含大约40个方程的线性方程组。这显示了解析循环处理的强大功能。
</p>
<p style=\"text-align: start;\">以大约50000个输出间隔模拟3秒，并绘制变量<strong>engineSpeed_rpm</strong>、<strong>engineTorque</strong>和<strong>filteredEngineTorque</strong>的图形。请注意，在此情况下，结果文件的大小约为240 Mbyte。默认设置StopTime = 1.01秒(使用工具对于输出点数量的默认设置)，以便(自动)回归测试不必处理大型结果文件。
</p>
</html>"), experiment(StopTime=1.01));
end EngineV6_analytic;