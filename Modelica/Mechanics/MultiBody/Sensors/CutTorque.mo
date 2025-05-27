within Modelica.Mechanics.MultiBody.Sensors;
model CutTorque "测量局部力矩矢量"

  Modelica.Blocks.Interfaces.RealOutput torque[3] 
    "在resolveInFrame定义的坐标系中解析的局部力矩" 
       annotation (Placement(transformation(
        origin={-80,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

  parameter Boolean animation=true 
    "=true，如果启用动画(显示箭头)";
  parameter Boolean positiveSign=true 
    "=true，如果返回具有正号的力矩(=frame_a.t)，否则返回具有负号的力矩(=frame_b.t)";
  input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor 
    "力矩箭头的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光被完全吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;

protected
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color=torqueColor, 
    specularCoefficient=specularCoefficient, 
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque, 
    R=frame_b.R, 
    r=frame_b.r_0, 
    headAtOrigin=true, 
    r_head=-frame_a.t*(if positiveSign then +1 else -1)) if world.enableAnimation and animation;
  Internal.BasicCutTorque cutTorque(resolveInFrame=resolveInFrame, positiveSign= 
       positiveSign) 
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(cutTorque.frame_a, frame_a) annotation (Line(
      points={{-62,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cutTorque.frame_b, frame_b) annotation (Line(
      points={{-42,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cutTorque.torque, torque) annotation (Line(
      points={{-60,-11},{-60,-80},{-80,-80},{-80,-110}}, color={0,0,127}));
  connect(cutTorque.frame_resolve, frame_resolve) annotation (Line(
      points={{-44,-10},{-44,-74},{80,-74},{80,-100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, cutTorque.frame_resolve) annotation (Line(
      points={{-20,-30},{-44,-30},{-44,-10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,100}}), 
      graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="N.m")}), 
    Documentation(info="<html>
<p>
该模型连接的两个坐标系之间的局部力矩由该模型确定并在输出信号连接器<strong>torque</strong>(=frame_a.t)处提供。
如果参数<strong>positiveSign</strong>=<strong>false</strong>，则提供负的局部力矩(=frame_b.t)。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了力矩矢量在哪个坐标系中解析：</p>

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
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则条件连接器\"frame_resolve\"被启用，并且输出力矩在与frame_resolve连接的坐标系中解析。
请注意，如果启用了此连接器，则必须将其连接。
</p>

<p>
下图显示了CutTorque传感器的动画。
深蓝色坐标系是frame_b，绿色箭头是作用在frame_b上的局部力矩，并且在frame_a上带有负号。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutTorque.png\">
</div>

</html>"));
end CutTorque;