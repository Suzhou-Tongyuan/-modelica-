within Modelica.Mechanics.MultiBody.Examples.Loops;
model EngineV6 
  "V6发动机，具有6个气缸、6个平面运动环和1个自由度"

  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, 如果要启用动画效果";
  output Modelica.Units.NonSI.AngularVelocity_rpm 
    engineSpeed_rpm= 
         Modelica.Units.Conversions.to_rpm(load.w) "发动机转速";
  output SI.Torque engineTorque = filter.u 
    "发动机产生的扭矩";
  output SI.Torque filteredEngineTorque = filter.y 
    "发动机产生的过滤扭矩";

  Modelica.Mechanics.MultiBody.Joints.Revolute bearing(useAxisFlange=true, 
    n={1,0,0}, 
    cylinderLength=0.02, 
    cylinderDiameter=0.06, 
    animation=animation) annotation (Placement(transformation(extent={{-80,30},{-60,10}})));
  inner Modelica.Mechanics.MultiBody.World world(animateWorld=false, 
      animateGravity = false) 
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  Utilities.Cylinder cylinder1(
    crankAngleOffset=Cv.from_deg(-30), 
    cylinderInclinationAngle=Cv.from_deg(-30), 
    animation=animation) annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Utilities.Cylinder cylinder2(
    crankAngleOffset=Cv.from_deg(90), 
    cylinderInclinationAngle=Cv.from_deg(30), 
    animation=animation) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Utilities.Cylinder cylinder3(
    cylinderInclinationAngle=Cv.from_deg(-30), 
    animation=animation, 
    crankAngleOffset=Cv.from_deg(210)) 
                         annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Utilities.Cylinder cylinder4(
    cylinderInclinationAngle=Cv.from_deg(30), 
    animation=animation, 
    crankAngleOffset=Cv.from_deg(210)) 
                         annotation (Placement(transformation(extent={{40,20},{61,40}})));
  Utilities.Cylinder cylinder5(
    cylinderInclinationAngle=Cv.from_deg(-30), 
    animation=animation, 
    crankAngleOffset=Cv.from_deg(90)) 
                         annotation (Placement(transformation(extent={{70,20},{90,40}})));
  Utilities.Cylinder cylinder6(
    cylinderInclinationAngle=Cv.from_deg(30), 
    animation=animation, 
    crankAngleOffset=Cv.from_deg(-30)) 
                         annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Mechanics.Rotational.Components.Inertia load(
                          phi(
      start=0, 
      fixed=true), w(
      start=10, 
      fixed=true), 
    stateSelect=StateSelect.always, 
    J=1) annotation (Placement(transformation(
          extent={{-30,-30},{-10,-10}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque load2(
                                                 tau_nominal=-100, w_nominal= 
        200, 
    useSupport=false) 
             annotation (Placement(transformation(extent={{20,-30},{0,-10}})));
  Rotational.Sensors.TorqueSensor torqueSensor 
    annotation (Placement(transformation(extent={{-62,-30},{-42,-10}})));
  Blocks.Continuous.CriticalDamping filter(
    n=2, 
    initType=Modelica.Blocks.Types.Init.SteadyState, 
    f=5) annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
equation

  connect(bearing.frame_b, cylinder1.crank_a) 
    annotation (Line(
      points={{-60,20},{-50,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder1.crank_b, cylinder2.crank_a) 
    annotation (Line(
      points={{-30,20},{-20,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder2.crank_b, cylinder3.crank_a) 
    annotation (Line(
      points={{0,20},{10,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder3.crank_b, cylinder4.crank_a) 
    annotation (Line(
      points={{30,20},{40,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder4.crank_b, cylinder5.crank_a) 
    annotation (Line(
      points={{61,20},{70,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder5.crank_b, cylinder6.crank_a) 
    annotation (Line(
      points={{90,20},{100,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder5.cylinder_b, cylinder6.cylinder_a) 
    annotation (Line(
      points={{90,40},{100,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder4.cylinder_b, cylinder5.cylinder_a) 
    annotation (Line(
      points={{61,40},{70,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder4.cylinder_a, cylinder3.cylinder_b) 
    annotation (Line(
      points={{40,40},{30,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder3.cylinder_a, cylinder2.cylinder_b) 
    annotation (Line(
      points={{10,40},{0,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cylinder2.cylinder_a, cylinder1.cylinder_b) 
    annotation (Line(
      points={{-20,40},{-30,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, cylinder1.cylinder_a) annotation (Line(
      points={{-100,30},{-90,30},{-90,40},{-50,40}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(world.frame_b, bearing.frame_a) annotation (Line(
      points={{-100,30},{-90,30},{-90,20},{-80,20}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(load2.flange, load.flange_b) 
    annotation (Line(points={{0,-20},{-10,-20}}));
  connect(torqueSensor.flange_b, load.flange_a) 
    annotation (Line(points={{-42,-20},{-30,-20}}));
  connect(torqueSensor.tau,filter. u) annotation (Line(points={{-60,-31},{-60,-50},{-52,-50}}, 
                           color={0,0,127}));
  connect(torqueSensor.flange_a, bearing.axis) annotation (Line(points={{-62,-20},{-70,-20},{-70,10}}));
  annotation (
    Documentation(info="<html><p>
这是一个具有6个气缸的V6发动机。它通过使用单个气缸的实例来分层构建。
有关单个气缸建模的更多详细信息，请参阅示例
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b\" target=\"\">Engine1b</a>。
以下图例中展示了发动机的动画效果。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6.png\" alt=\"model Examples.Loops.EngineV6\">
</p>
<p>
以大约50000个输出间隔模拟3秒，并绘制变量<strong>engineSpeed_rpm</strong>
<strong>engineTorque</strong>和<strong>filteredEngineTorque</strong>的图形。
请注意，在这种情况下，结果文件的大小约为300 Mbyte。默认设置StopTime = 1.01秒(使用工具对于输出点数量的默认设置)，以便(自动)回归测试不必处理大型结果文件。
</p>
</html>"), experiment(StopTime=1.01), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})));
end EngineV6;