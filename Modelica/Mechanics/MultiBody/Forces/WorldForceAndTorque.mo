within Modelica.Mechanics.MultiBody.Forces;
model WorldForceAndTorque 
  "作用在frame_b的外部力和力矩，由3+3个输入信号定义，并在world坐标系、frame_b或frame_resolve中解析"

  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.PartialOneFrame_b;
  Interfaces.Frame_resolve frame_resolve if 
       resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve 
    "该输入信号可选项在此坐标系中解析" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{16,-16},{-16,16}}, 
        rotation=270)));
  Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit= 
                   "N") 
    "在由resolveInFrame定义的坐标系中解析的力的x-、y-、z-坐标" 
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit= 
                   "N.m") 
    "在由resolveInFrame定义的坐标系中解析的力矩的x-、y-、z-坐标" 
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

  parameter Boolean animation=true "= true时，启用动画";
  parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame= 
    Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world 
    "定义输入力和力矩解析的坐标系(1: world, 2: frame_b, 3: frame_resolve)";

input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor 
    "力的箭头颜色" annotation (Dialog(colorSelector=true, group="如果 animation = true", enable=animation));
input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor 
    "力矩的箭头颜色" annotation (Dialog(colorSelector=true, group="如果 animation = true", enable=animation));
input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射系数(= 0: 光完全被吸收)" 
    annotation (Dialog(group="如果 animation = true", enable=animation));

protected
  Visualizers.Advanced.Arrow forceArrow(
    color=forceColor, 
    specularCoefficient=specularCoefficient, 
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Force, 
    R=frame_b.R, 
    r=frame_b.r_0, 
    r_head=-frame_b.f, 
    headAtOrigin=true) if world.enableAnimation and animation;
  Visualizers.Advanced.DoubleArrow torqueArrow(
    color=torqueColor, 
    specularCoefficient=specularCoefficient, 
    quantity=Modelica.Mechanics.MultiBody.Types.VectorQuantity.Torque, 
    R=frame_b.R, 
    r=frame_b.r_0, 
    r_head=-frame_b.t, 
    headAtOrigin=true) if world.enableAnimation and animation;
public
  Internal.BasicWorldForce basicWorldForce(resolveInFrame=resolveInFrame) 
    annotation (Placement(transformation(extent={{18,-50},{38,-70}})));
  Internal.BasicWorldTorque basicWorldTorque(resolveInFrame=resolveInFrame) 
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
protected
  Interfaces.ZeroPosition zeroPosition if 
       not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve) 
    annotation (Placement(transformation(extent={{58,70},{78,90}})));
equation
  connect(basicWorldForce.frame_b, frame_b) annotation (Line(
      points={{38,-60},{60,-60},{60,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(basicWorldForce.force, force) annotation (Line(
      points={{16,-60},{-120,-60}}, color={0,0,127}));
  connect(basicWorldTorque.frame_b, frame_b) 
    annotation (Line(
      points={{10,60},{60,60},{60,0},{100,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  connect(basicWorldTorque.torque, torque) 
    annotation (Line(
      points={{-12,60},{-120,60}}, color={0,0,127}));
  connect(basicWorldForce.frame_resolve, frame_resolve) annotation (Line(
      points={{28,-50},{28,80},{0,80},{0,100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(basicWorldTorque.frame_resolve, frame_resolve) 
    annotation (Line(
      points={{0,70},{0,100}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicWorldTorque.frame_resolve) 
    annotation (Line(
      points={{58,80},{0,80},{0,70}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  connect(zeroPosition.frame_resolve, basicWorldForce.frame_resolve) 
    annotation (Line(
      points={{58,80},{40,80},{40,-40},{28,-40},{28,-50}}, 
      color={95,95,95}, 
      pattern=LinePattern.Dot));
  annotation (defaultComponentName="forceAndTorque", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Text(
          extent={{-63,56},{44,19}}, 
          textColor={192,192,192}, 
          textString="resolve"), 
        Text(
          extent={{-150,-75},{150,-115}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-100,60},{-86,68},{-80,72},{-70,78},{-64,82},{-46,86},{-34, 
              88},{-16,88},{-2,86},{12,80},{24,74},{34,68},{46,58},{52,54},{
              58,48}}, 
          thickness=0.5), 
        Polygon(
          points={{89,17},{64,76},{30,41},{89,17}}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{0,95},{0,-26}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Line(
          points={{0,0},{96,0}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{-104,-48},{54,0},{46,20},{96,0},{66,-42},{60,-22},{-96,-72}, 
              {-104,-48}}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
<strong>力</strong>和<strong>力矩</strong>在连接器上的<strong>3</strong>个信号被解释为作用在坐标系连接器上的<strong>力</strong>和<strong>力矩</strong>的x-、y-和z-坐标，
此组件的frame_b与该坐标系连接器相连。通过参数<strong>resolveInFrame</strong>可以定义这些坐标应在哪个坐标系中进行解析：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.ResolveInFrameB.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>world</td>
    <td>将输入力和力矩解析为全局坐标系下的值 (= default)</td></tr>

<tr><td>frame_b</td>
    <td>将输入力和力矩解析为frame_b坐标系下的值</td></tr>

<tr><td>frame_resolve</td>
    <td>将输入力和力矩解析为frame_resolve坐标系下的值(frame_resolve必须已连接)</td></tr>
</table>

<p>
如果resolveInFrame = Types.ResolveInFrameB.frame_resolve，
那么力和力矩的坐标将相对于与<strong>frame_resolve</strong>相连的坐标系来确定。

</p>

<p> 如果force={100,0,0}，且所有参数均使用默认设置，
那么其解释就是沿frame_b的正x轴方向作用着一个大小为100 N的力。 
</p>

<p> 从概念上讲，力和力矩作用于全局坐标系，使得world.frame_b和frame_b之间的力和力矩达到平衡。
然而，出于效率考虑，该反作用力矩并不会被计算。 
</p> 

<p> 默认情况下，力和力矩会以箭头的形式(力)和双箭头的形式(力矩)进行可视化，它们作用在连接器上。
箭头的颜色可以通过<strong>forceColor</strong>和<strong>torqueColor</strong>来定义。
箭头指向由力和力矩向量定义的方向。
箭头的长度分别与力和力矩向量的长度成正比，具体比例取决于系统使用的缩放因子。
</p>
<p>
以下是使用此模型的一个示例图：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldForceAndTorque1.png\">
</div>

<p>
结果为以下动画效果：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/WorldForceAndTorque2.png\">
</div>

</html>"));
end WorldForceAndTorque;