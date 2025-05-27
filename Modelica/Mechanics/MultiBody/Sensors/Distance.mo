within Modelica.Mechanics.MultiBody.Sensors;
model Distance 
  "测量两个连接器原点之间的距离"

  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFrames;
  extends Modelica.Icons.RectangularSensor;
  Modelica.Blocks.Interfaces.RealOutput distance 
    "frame_a的原点和frame_b的原点之间的距离" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));

  parameter Boolean animation=true 
    "=true,如果启用动画(显示箭头)" ;
  input Types.Color arrowColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor 
    "从frame_a到frame_b的相对箭头的颜色" 
    annotation (Dialog(colorSelector=true, group="如果animation=true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
    "反射环境光的程度(=0：光完全被吸收)" 
    annotation (Dialog(group="如果animation=true", enable=animation));
  input SI.Position s_small(min=sqrt(Modelica.Constants.small))=1e-10 
    "如果frame_a和frame_b之间的距离为零，则防止零除法" 
    annotation (Dialog(tab="高级"));
protected
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Arrow arrow(
    r=frame_a.r_0, 
    r_head=frame_b.r_0 - frame_a.r_0, 
    color=arrowColor, 
    specularCoefficient=specularCoefficient) if world.enableAnimation and animation;

protected
  SI.Position r_rel_0[3] = frame_b.r_0 - frame_a.r_0 
    "在全局坐标系中解析的从frame_a到frame_b的位置矢量";
  SI.Area L2 = r_rel_0*r_rel_0;
  SI.Area s_small2 = s_small^2;
equation
  frame_a.f = zeros(3);
  frame_b.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.t = zeros(3);

  distance =  smooth(1,if noEvent(L2 > s_small2) then sqrt(L2) else L2/(2*s_small)*(3-L2/s_small2));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{0,-60},{0,-100}}, color={0,0,127}), 
        Line(points={{-70,0},{-101,0}}), 
        Line(points={{70,0},{100,0}}), 
        Text(
          extent={{-128,30},{133,78}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-30,10},{70,-30}}, 
          textColor={64,64,64}, 
          textString="m")}), 
    Documentation(info="<html>
<p>
输出信号连接器<strong>distance</strong>提供了frame_a和frame_b原点之间的距离。
这个距离始终为正值。
可以通过连接块<a href=\"modelica://Modelica.Blocks.Continuous.Der\">Modelica.Blocks.Continuous.Der</a>到“distance”来轻松获得该信号的导数(该块使用der(&hellip;)运算符对输入信号进行解析微分)。
</p>
<p>
在下图中显示了距离传感器的动画。
浅蓝色坐标系是frame_a，深蓝色坐标系是frame_b，黄色箭头是动画传感器。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Sensors/Distance.png\">
</div>

<p>
如果距离小于参数<strong>s_small</strong>(在“高级”菜单中)，则近似计算，使得其导数在零距离处有限。
如果没有这样的近似计算，导数将是无限的，会发生除以零的情况。
近似计算如下：如果distance>s_small，则计算为sqrt(r*r)，其中r是从frame_a原点到frame_b原点的位置矢量。
如果距离小于s_small，则将“sqrt()”函数近似为一个二阶多项式，使得在s_small处，sqrt()和多项式的函数值及其一阶导数相同。
此外，多项式经过零点。
这样做的效果是，距离函数在任何地方都是连续可微的。
零距离处的导数为3/(2*s_small)。
</p>

</html>"));
end Distance;