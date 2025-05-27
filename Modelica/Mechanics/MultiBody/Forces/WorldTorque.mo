within Modelica.Mechanics.MultiBody.Forces;
model WorldTorque 
  "作用在frame_b上的外部力矩，由3个输入信号定义，并在world坐标系、frame_b或frame_resolve中解析"

  extends Interfaces.PartialOneFrame_b;

  Interfaces.Frame_resolve frame_resolve if 
       resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve 
    "输入信号可以选择在此坐标系中解析" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{16,-16},{-16,16}}, 
        rotation=270)));
  Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit="N.m") 
    "在由resolveInFrame定义的坐标系中解析的力矩的x、y、z坐标" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Boolean animation=true "= true时，启用动画";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world 
    "输入力矩在哪个坐标系中解析(1: world, 2: frame_b, 3: frame_resolve)";
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor 
    "箭头的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射率(= 0: 光完全被吸收)" 
    annotation (Dialog(group="如果animation = true", enable=animation));

protected
  Visualizers.Advanced.DoubleArrow arrow(
    color=color, 
    specularCoefficient=specularCoefficient, 
    R=frame_b.R, 
    r=frame_b.r_0, 
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque, 
    headAtOrigin=true, 
    r_head=-frame_b.t) if world.enableAnimation and animation;
public
  Internal.BasicWorldTorque basicWorldTorque(resolveInFrame=resolveInFrame) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
protected
  Interfaces.ZeroPosition zeroPosition if 
       not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve) 
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
equation
  connect(basicWorldTorque.frame_b, frame_b) annotation (Line(
      points={{10,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(basicWorldTorque.torque, torque) annotation (Line(
      points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(frame_resolve, basicWorldTorque.frame_resolve) annotation (Line(
      points={{0,100},{0,10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicWorldTorque.frame_resolve) 
    annotation (Line(
      points={{20,20},{0,20},{0,10}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  annotation (defaultComponentName="torque", 
    Documentation(info="<html>

<p>
<strong>torque</strong>连接器的<strong>3</strong>个信号被解析为作用在坐标系连接器上的<strong>力矩</strong>的x、y和z坐标，
该坐标系连接器与本组件的frame_b相连接。
通过参数<strong>resolveInFrame</strong>可以定义这些坐标值应在哪个坐标系中解析：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
    <td>在world坐标系中解析输入的力矩(默认设置)</td></tr>

<tr><td>frame_b</td>
    <td>在frame_b中解析输入力矩</td></tr>

<tr><td>frame_resolve</td>
    <td>在frame_resolve中解析输入力矩(frame_resolve必须已连接)</td></tr>
</table>

<p>
如果resolveInFrame = Types.ResolveInFrameB.frame_resolve，那么力矩坐标将相对于与
<strong>frame_resolve</strong>连接的坐标系进行解析。
</p>

<p>
如果torque={100,0,0}，并且所有参数都使用默认设置，则代表：沿着frame_b的正x轴作用大小为100 N.m的力矩。
</p> 
<p> 
请注意，frame_b中的局部力(frame_b.f)始终设置为零。
从概念上讲，作用在全局坐标系上的力和力矩是平衡的， 
这满足了world.frame_b和frame_b之间的力和力矩平衡。
然而，出于效率考虑，这个反作用力矩并不进行计算。
</p>

<p>
这个力矩组件默认会被可视化为一个作用在连接器上的<strong>双箭头</strong>，该连接器与力矩组件相连接。
箭头的颜色可以通过变量<strong>color</strong>来定义。双箭头的指向由力矩向量定义的方向决定。
双箭头的长度与力矩向量的长度成正比，这取决于一个全局工具中相关的缩放因子。

</p>
<p>
以下图例展示了如何使用这个模型：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldTorque1.png\">
</div>

<p>
这会产生如下的动画效果
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldTorque2.png\">
</div>

</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-61,64},{46,27}}, 
          textColor={192,192,192}, 
          textString="resolve"), 
        Text(
          extent={{-150,-40},{150,-80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{0,95},{0,82}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Line(
          points={{-100,0},{-94,13},{-86,28},{-74,48},{-65,60},{-52,72},{-35, 
              81},{-22,84},{-8,84},{7,80},{19,73},{32,65},{44,55},{52,47},{58, 
              40}}, 
          thickness=0.5), 
        Polygon(
          points={{94,10},{75,59},{41,24},{94,10}}, 
          fillPattern=FillPattern.Solid)}));
end WorldTorque;