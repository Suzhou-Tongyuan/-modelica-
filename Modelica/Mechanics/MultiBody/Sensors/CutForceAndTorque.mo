within Modelica.Mechanics.MultiBody.Sensors;
model CutForceAndTorque "测量局部力和局部扭矩的矢量"


  import Modelica.Mechanics.MultiBody.Types;

  Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N") 
    "在由resolveInFrame定义的坐标系中分解的局部力" 
       annotation (Placement(transformation(
        origin={-80,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput torque[3] 
    "在由resolveInFrame定义的坐标系中分解的局部扭矩" 
       annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

  parameter Boolean animation=true 
    "=true，如果要启用动画(显示力和扭矩箭头)";
  parameter Boolean positiveSign=true 
    "=true，如果返回带正号的力和扭矩(=frame_a.f/.t)，否则返回带负号的力和扭矩(=frame_b.f/.t)";
  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor 
    "力箭头的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor 
    "扭矩箭头的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;


protected
  parameter Integer csign=if positiveSign then +1 else -1;
  Visualizers.Advanced.Arrow forceArrow(
    color=forceColor, 
    specularCoefficient=specularCoefficient, 
    R=frame_b.R, 
    r=frame_b.r_0, 
    headAtOrigin=true, 
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force, 
    r_head=-frame_a.f*csign) if world.enableAnimation and animation;
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color=torqueColor, 
    specularCoefficient=specularCoefficient, 
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque, 
    R=frame_b.R, 
    r=frame_b.r_0, 
    headAtOrigin=true, 
    r_head=-frame_a.t*csign) if world.enableAnimation and animation;
  Internal.BasicCutForce cutForce(resolveInFrame=resolveInFrame, positiveSign= 
        positiveSign) 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Internal.BasicCutTorque cutTorque(resolveInFrame=resolveInFrame, positiveSign= 
       positiveSign) 
    annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) 
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
equation
  connect(cutForce.frame_a, frame_a) annotation (Line(
      points={{-60,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cutForce.frame_b, cutTorque.frame_a) annotation (Line(
      points={{-40,0},{-2,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cutTorque.frame_b, frame_b) annotation (Line(
      points={{18,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cutForce.force, force) annotation (Line(
      points={{-58,-11},{-58,-20},{-80,-20},{-80,-110}}, color={0,0,127}));
  connect(cutTorque.torque, torque) annotation (Line(
      points={{0,-11},{0,-110}}, color={0,0,127}));
  connect(zeroPosition.frame_resolve, cutTorque.frame_resolve) annotation (Line(
      points={{60,40},{32,40},{32,-20},{16,-20},{16,-10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (Line(
      points={{60,40},{-26,40},{-26,-20},{-42,-20},{-42,-10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
      points={{-42,-10},{-42,-70},{80,-70},{80,-100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(cutTorque.frame_resolve, frame_resolve) annotation (Line(
      points={{16,-10},{16,-70},{80,-70},{80,-100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}), 
        Line(points={{0,-100},{0,-70}}, color={0,0,127}), 
        Text(
          extent={{-60,-60},{0,-100}}, 
          textColor={64,64,64}, 
          textString="N.m"), 
        Text(
          extent={{-120,-60},{-80,-100}}, 
          textColor={64,64,64}, 
          textString="N")}), 
    Documentation(info="<html>
<p>
此模型连接的两个坐标系之间的局部力和局部扭矩通过输出信号连接器<strong>force</strong>(=frame_a.f)和<strong>torque</strong>(=frame_a.t)确定并提供。
如果参数<strong>positiveSign</strong>=<strong>false</strong>，则提供负的局部力和局部扭矩(=frame_b.f，frame_b.t)。
</p>
<p>
通过参数<strong>resolveInFrame</strong>定义了两个矢量在哪个坐标系中解析：</p>

<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>resolveInFrame=<br>Types.ResolveInFrameA.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
<td>在全局坐标系中解析矢量</td></tr>

<tr><td>frame_a</td>
<td>在frame_a中解析矢量</td></tr>

<tr><td>frame_resolve</td>
<td>在frame_resolve中解析矢量</td></tr>
</table>

<p>
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则条件连接器“frame_resolve”被启用，并且输出矢量force和torque在与frame_resolve连接的坐标系中解析。
请注意，如果启用了此连接器，则必须连接它。
</p>

<p>
下图显示了CutForceAndTorque传感器的动画。
深蓝色坐标系是frame_b，绿色箭头分别是局部力和局部扭矩，在frame_b处以负号在frame_a处。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForceAndTorque.png\">
</div>

</html>"));
end CutForceAndTorque;