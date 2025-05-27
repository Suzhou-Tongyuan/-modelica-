within Modelica.Mechanics.MultiBody.Visualizers;
model Rectangle "可视化平面矩形表面"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialVisualizer;

  parameter Boolean animation=true "=true，则启用动画";
  parameter MultiBody.Types.Axis direction_u={1,0,0} 
    "在frame_a中沿着u轴的矩形矢量" 
    annotation(Evaluate=true, Dialog(enable=animation));
  parameter MultiBody.Types.Axis direction_v={0,1,0} 
    "在frame_a中沿着v轴的矩形矢量" 
    annotation(Evaluate=true, Dialog(enable=animation));

  parameter SI.Distance length_u=3 "在u方向上的矩形长度" annotation(Dialog(enable=animation));
  parameter SI.Distance length_v=1 "在v方向上的矩形长度" annotation(Dialog(enable=animation));
  parameter Integer nu(min=2)=3 "u方向上的点数" annotation(Dialog(enable=animation,group="离散化"));
  parameter Integer nv(min=2)=2 "v方向上的点数" annotation(Dialog(enable=animation,group="离散化"));

  parameter Boolean wireframe=false 
    "=true:以无面模式显示3D模型" 
    annotation (Dialog(enable=animation, group="材料属性"),choices(checkBox=true));
  input Modelica.Mechanics.MultiBody.Types.RealColor color={0,128,255} 
    "表面颜色" annotation(Dialog(enable=animation and not multiColoredSurface,colorSelector=true,group="材料属性"));
  input Types.SpecularCoefficient specularCoefficient = 0.7 
    "环境光反射率(=0：光完全被吸收)" annotation(Dialog(enable=animation,group="材料属性"));
  input Real transparency=0 
    "形状的透明度：0(=不透明)...1(=完全透明)" 
    annotation(Dialog(enable=animation,group="材料属性"));

protected
  Advanced.Surface surface(
    final multiColoredSurface=false, 
    final wireframe=wireframe, 
    final color=color, 
    final specularCoefficient=specularCoefficient, 
    final transparency=transparency, 
    final R=Modelica.Mechanics.MultiBody.Frames.absoluteRotation(
        frame_a.R,Modelica.Mechanics.MultiBody.Frames.from_nxy(direction_u, direction_v)), 
    final r_0=frame_a.r_0, 
    final nu=nu, 
    final nv=nv, 
    redeclare function surfaceCharacteristic = Advanced.SurfaceCharacteristics.rectangle (
      lu=length_u, lv=length_v)) if world.enableAnimation and animation 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.MultiBody.Forces.Internal.ZeroForceAndTorque zeroForceAndTorque annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

equation
  connect(frame_a, zeroForceAndTorque.frame_a) annotation (Line(
      points={{-100,0},{-80,0}}, 
      color={95,95,95}, 
      thickness=0.5));
  annotation (
    Icon(graphics={
          Text(
          extent={{-150,80},{150,40}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Polygon(
          points={{-50,20},{-90,-60},{70,-60},{90,20},{-50,20}}, 
          lineColor={95,95,95}, 
          fillColor={175,175,175}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-2,-18},{2,-22}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-100,0},{0,0},{0,-20}}, color={95,95,95}), 
        Text(
          extent={{-140,-60},{140,-90}}, 
          lineThickness=0.5, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          textString="%length_ux%length_v")}), 
    Documentation(info="<html>
<p>
这个模型可视化了一个平面矩形。
矩形的中心位于连接器frame_a处(在下图中由红色坐标系表示)。
下图显示了两个具有相同参数的矩形：</p>
<blockquote><pre>
nu=8,
nv=3,
length_u=3,
length_v=2.
</pre></blockquote>
<p>
右侧的绿色矩形以线框形式进行可视化，从而突出了离散化的影响。
此外，该矩形的u轴被修改，使得矩形绕着frame_a的z轴旋转。
</p>


<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Rectangle.png\">
</blockquote>
</html>"));
end Rectangle;