within Modelica.Mechanics.MultiBody.Forces;
model SpringDamperSeries 
  "串联连接的线性弹簧和线性阻尼器"
  import Modelica.Mechanics.MultiBody.Types;
  parameter Boolean animation=true "= true，如果启用动画";
  parameter SI.TranslationalSpringConstant c(final min=0) "弹簧常数";
  parameter SI.Length s_unstretched=0 "未拉伸的弹簧长度";
  parameter SI.TranslationalDampingConstant d(final min=0) = 0 
    "阻尼器常数";
  parameter SI.Length s_damper_start=0 "阻尼器初始长度";
  SI.Position s_damper(start=s_damper_start, fixed=true) 
    "阻尼器的实际长度(frame_a - damper - spring - frame_b)";
  parameter SI.Distance length_a=world.defaultForceLength 
    "frame_a端阻尼器圆柱体的长度" 
    annotation (Dialog(tab="动画", group="如果animation = true", enable=animation));
  input SI.Diameter diameter_a=world.defaultForceWidth 
    "frame_a端阻尼器圆柱体的直径" 
    annotation (Dialog(tab="动画", group="如果animation = true", enable=animation));
  input SI.Diameter diameter_b=0.6*diameter_a 
    "阻尼器-弹簧端阻尼器圆柱体的直径" 
    annotation (Dialog(tab="动画", group="如果animation = true", enable=animation));
  input Types.Color color_a={100,100,100} "frame_a端阻尼器圆柱体的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation = true", enable=animation));
  input Types.Color color_b={155,155,155} "阻尼器-弹簧端阻尼器圆柱体的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "环境光的反射(= 0：光完全被吸收)" 
    annotation (Dialog(tab="动画", group="如果animation = true", enable=animation));
  input SI.Distance width=world.defaultForceWidth "弹簧的宽度" 
    annotation (Dialog(tab="动画", group="如果animation = true", enable=animation));
  input SI.Distance coilWidth=width/10 "弹簧线圈的宽度" 
    annotation (Dialog(tab="动画", group="如果animation = true", enable=animation));
  parameter Integer numberOfWindings=5 "弹簧匝数" 
    annotation (Dialog(tab="动画", group="如果animation = true", enable=animation));
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.SpringColor 
    "弹簧的颜色" 
    annotation (Dialog(colorSelector=true, tab="动画", group="如果animation = true", enable=animation));
  extends Interfaces.PartialLineForce;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
     final T=293.15);

protected
  Visualizers.Advanced.Shape shape_a(
    shapeType="cylinder", 
    color=color_a, 
    specularCoefficient=specularCoefficient, 
    length=noEvent(min(length_a, s_damper)), 
    width=diameter_a, 
    height=diameter_a, 
    lengthDirection=e_a, 
    widthDirection={0,1,0}, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_b(
    shapeType="cylinder", 
    color=color_b, 
    specularCoefficient=specularCoefficient, 
    length=noEvent(max(s_damper - length_a, 0)), 
    width=diameter_b, 
    height=diameter_b, 
    lengthDirection=e_a, 
    widthDirection={0,1,0}, 
    r_shape=e_a*noEvent(min(length_a, s_damper)), 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape(
    shapeType="spring", 
    color=color, 
    specularCoefficient=specularCoefficient, 
    length=s - s_damper, 
    width=width, 
    height=coilWidth*2, 
    lengthDirection=e_a, 
    widthDirection={0,1,0}, 
    extra=numberOfWindings, 
    r_shape=e_a*s_damper, 
    r=frame_a.r_0, 
    R=frame_a.R) if world.enableAnimation and animation;
equation
  f = c*(s - s_unstretched - s_damper);
  d*der(s_damper) = f;
  lossPower = f*der(s_damper);
  annotation (
    Documentation(info="<html>
<p>
<strong>线性弹簧</strong>和<strong>线性阻尼器</strong>串联连接，
作为frame_a和frame_b之间的线性力：
</p>
<blockquote><pre>
frame_a --> damper ----> spring --> frame_b
        |              |
        |-- s_damper --|  (s_damper is the state variable of this system)
</pre></blockquote>
<p>
根据以下方程，在frame_b的原点施加一个<strong>力f</strong>，并且在frame_a的原点施加相反符号的力，
沿着从frame_a原点到frame_b原点的方向：
</p>
<blockquote><pre>
f = c*(s - s_unstretched - s_damper);
f = d*der(s_damper);
</pre></blockquote>
<p>
其中\"c\"，\"s_unstretched\"和\"d\"是参数，\"s\"是frame_a原点到frame_b原点的距离。
\"s_damper\"是阻尼器的长度(该力元素的内部状态变量)，der(s_damper)是s_damper的时间导数。
</p>
</html>"), 
         Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-100,0},{-15,0}}), 
        Line(points={{-60,-30},{-15,-30}}), 
        Line(points={{-60,30},{-15,30}}), 
        Rectangle(
          extent={{-60,30},{-30,-30}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-15,0},{-5,0},{5,-30},{25,30},{45,-30},{65,30},{75,0},{
              100,0}}), 
        Text(
          extent={{-150,50},{150,90}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-65},{150,-35}}, 
          textString="c=%c"), 
        Line(visible=useHeatPort, 
          points={{-100,-99},{-100,-24},{-45,-24}}, 
          color={191,0,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,-100},{150,-70}}, 
          textString="d=%d")}));
end SpringDamperSeries;