within Modelica.Mechanics.MultiBody.Sensors;
model CutForce "测量局部力矢量"

  Modelica.Blocks.Interfaces.RealOutput force[3](each final quantity="Force", each final unit="N") 
    "在由resolveInFrame定义的坐标系中解析的局部力" 
       annotation (Placement(transformation(
        origin={-80,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

  parameter Boolean animation=true 
    "=true，如果启用动画(显示箭头)";
  parameter Boolean positiveSign=true 
    "=true，如果返回带有正号的力(=frame_a.f)，否则带有负号(=frame_b.f)";

  input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.
      ForceColor "力箭头的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(=0：光完全被吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));

  extends Modelica.Mechanics.MultiBody.Sensors.Internal.PartialCutForceSensor;


protected
  Visualizers.Advanced.Arrow forceArrow(
    color=forceColor, 
    specularCoefficient=specularCoefficient, 
    R=frame_b.R, 
    r=frame_b.r_0, 
    headAtOrigin=true, 
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force, 
    r_head=-frame_a.f*(if positiveSign then +1 else -1)) if world.enableAnimation and animation;

  Internal.BasicCutForce cutForce(resolveInFrame=resolveInFrame, positiveSign= 
        positiveSign) 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Mechanics.MultiBody.Interfaces.ZeroPosition zeroPosition if 
    not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_resolve) 
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(cutForce.frame_a, frame_a) annotation (Line(
      points={{-50,0},{-100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cutForce.frame_b, frame_b) annotation (Line(
      points={{-30,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(cutForce.frame_resolve, frame_resolve) annotation (Line(
      points={{-32,-10},{-32,-60},{80,-60},{80,-100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(cutForce.force, force) annotation (Line(
      points={{-48,-11},{-48,-60},{-80,-60},{-80,-110}}, color={0,0,127}));
  connect(zeroPosition.frame_resolve, cutForce.frame_resolve) annotation (
      Line(
      points={{0,-30},{-32,-30},{-32,-10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Line(points={{-80,-100},{-80,0}}, color={0,0,127}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="N")}), 
    Documentation(info="<html>
<p>
连接到此模型的两个坐标系之间的局部力由输出信号连接器<strong>force</strong>(=frame_a.f)确定并提供。
如果参数<strong>positiveSign</strong>=<strong>false</strong>，则提供负局部力(=frame_b.f)。
</p>

<p>
通过参数<strong>resolveInFrame</strong>定义了力矢量在哪个坐标系中解析：</p>

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
如果resolveInFrame=Types.ResolveInFrameAB.frame_resolve，则启用条件连接器\"frame_resolve\"，并将输出力解析到连接到frame_resolve的坐标系中。
请注意，如果启用了此连接器，则必须连接它。
</p>

<p>
下图显示了CutForce传感器的动画。
深蓝色坐标系是frame_b，绿色箭头是作用在frame_b上的局部力，并且在frame_a上具有负号。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/CutForce.png\">
</div>
</html>"));
end CutForce;