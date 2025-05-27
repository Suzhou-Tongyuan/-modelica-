within Modelica.Electrical.Machines.Interfaces;
partial model PartialBasicMachine "所有电机的基类模型"
  import Modelica.Constants.pi;
  extends Machines.Icons.TransientMachine;
  parameter SI.Inertia Jr "转子的惯性矩";
  parameter Boolean useSupport = false 
    "启用/禁用(即固定定子)支撑" annotation(Evaluate = true);
  parameter SI.Inertia Js = Jr "定子的惯性矩" 
    annotation(Dialog(enable = useSupport));
  parameter Boolean useThermalPort = false 
    "启用/禁用（即固定温度）热端口" 
    annotation(Evaluate = true);
  parameter Machines.Losses.FrictionParameters frictionParameters 
    "摩擦损失参数记录" annotation(Dialog(tab = "Losses"));
  output SI.Angle phiMechanical(start = 0) = flange.phi - 
    internalSupport.phi "转子与定子之间的机械角度";
  output SI.AngularVelocity wMechanical(
    displayUnit = "rev/min", 
    start = 0) = der(phiMechanical) 
    "转子与定子之间的机械角速度";
  output SI.Torque tauElectrical = inertiaRotor.flange_a.tau 
    "电磁转矩";
  output SI.Torque tauShaft = -flange.tau "轴转矩";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "轴" 
    annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J = Jr) 
    annotation(Placement(transformation(
    origin = {80, 0}, 
    extent = {{10, 10}, {-10, -10}}, 
    rotation = 180)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport 
    "反应转矩作用的支撑" annotation(Placement(
    transformation(extent = {{90, -110}, {110, -90}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J = Js) 
    annotation(Placement(transformation(
    origin = {80, -100}, 
    extent = {{10, 10}, {-10, -10}}, 
    rotation = 180)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport) 
    annotation(Placement(transformation(
    extent = {{10, 10}, {-10, -10}}, 
    rotation = 180, 
    origin = {50, -100})));
  Machines.Losses.Friction friction(final frictionParameters = frictionParameters) 
    annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {90, 
    -40})));
protected
  Modelica.Mechanics.Rotational.Interfaces.Support internalSupport 
    annotation(Placement(transformation(extent = {{56, -104}, {64, -96}})));
equation
  connect(inertiaRotor.flange_b, flange) annotation(Line(points = {{90, 0}, {
    92, 0}, {92, 0}, {100, 0}}));
  connect(inertiaStator.flange_b, support) 
    annotation(Line(points = {{90, -100}, {100, -100}}));
  connect(internalSupport, fixed.flange) annotation(Line(
    points = {{60, -100}, {50, -100}}));
  connect(internalSupport, inertiaStator.flange_a) annotation(Line(
    points = {{60, -100}, {70, -100}}));
  connect(inertiaRotor.flange_b, friction.flange) annotation(Line(
    points = {{90, 0}, {90, -30}}));
  connect(friction.support, internalSupport) annotation(Line(
    points = {{90, -50}, {90, -90}, {60, -90}, {60, -100}}));
  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
    -100}, {100, 100}}), graphics = {
    Text(
    extent = {{-150, -120}, {150, -160}}, 
    textColor = {0, 0, 255}, 
    textString = "%name"), 
    Rectangle(
    extent = {{80, -80}, {120, -120}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(
    visible = not useSupport, 
    points = {{80, -100}, {120, -100}}), 
    Line(
    visible = not useSupport, 
    points = {{90, -100}, {80, -120}}), 
    Line(
    visible = not useSupport, 
    points = {{100, -100}, {90, -120}}), 
    Line(
    visible = not useSupport, 
    points = {{110, -100}, {100, -120}}), 
    Line(
    visible = not useSupport, 
    points = {{120, -100}, {110, -120}})}), Documentation(info = "<html>
基础部分模型：直流电机：
<ul>
<li>图标的主要部分</li>
<li>机械轴</li>
<li>机械支撑</li>
</ul>
除了机械连接器<em>flange</em>（即轴），电机还拥有第二个机械连接器<em>support</em>。<br>
如果<em>useSupport</em> = false，假设定子是固定的。<br>
否则，反应转矩（即气隙转矩，减去定子惯性矩的加速度转矩）可以在<em>support</em>处测量。<br>
也可以固定轴并让定子旋转；当定子旋转时，参数Js才会起作用。
</html>"));
end PartialBasicMachine;