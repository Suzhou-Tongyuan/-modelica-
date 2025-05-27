within Modelica.Mechanics.Rotational.Components;
model IdealPlanetary "理想行星齿轮箱"
  parameter Real ratio(start=100/50) 
    "行星齿轮齿数与太阳轮齿数的比值（例如，ratio=100/50）";

  // 运动学关系
  Interfaces.Flange_a sun "太阳轮一维转动接口" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.Flange_a carrier "行星架一维转动接口" annotation (
      Placement(transformation(extent={{-110,30},{-90,50}})));
  Interfaces.Flange_b ring "齿圈一维转动接口" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));

equation
  (1 + ratio)*carrier.phi = sun.phi + ratio*ring.phi;

  // 扭矩平衡（无惯性）
  ring.tau = ratio*sun.tau;
  carrier.tau = -(1 + ratio)*sun.tau;
  annotation (
    Documentation(info="<html>
<p>
理想行星齿轮箱是一种理想齿轮箱，没有惯性、弹性、阻尼或齿隙，由内部的<strong>太阳</strong>齿轮、外部的<strong>内齿圈</strong>和位于太阳轮和内齿圈轮之间的<strong>行星</strong>齿轮组成。行星齿轮轴承固定在行星<strong>载体</strong>上。
该组件可以连接到太阳轮、内齿圈和/或载体一维转动接口上的其他元素。不可能连接到行星轮。
如果不想忽略惯性，可以通过将惯性（=Model Inertia）连接到相应的连接器来轻松添加太阳齿轮、内齿圈和载体的惯性。行星轮的惯性始终被忽略。
</p>
<p>
行星齿轮箱的图标表示太阳轮和载体的一维转动接口位于齿轮箱的左侧，而内齿圈的一维转动接口位于右侧。然而，此组件是通用的，并且与实际上一维转动接口的放置方式无关（例如，太阳轮实际上可能位于右侧而不是左侧）。
</p>
<p>
理想行星齿轮箱由内齿圈齿数zr与太阳轮齿数zs的比率唯一确定。例如，如果内齿圈齿数为100和太阳轮齿数为50，则ratio = zr/zs = 2。行星齿数zp必须满足以下关系：
</p>
<blockquote><pre>
<strong>zp := (zr - zs) / 2</strong>
</pre></blockquote>
<p>
因此，在上面的示例中，需要zp = 25。
</p>
<p>
根据总体约定，所有向量的正方向，特别是一维转动接口中的绝对角速度和切向力矩，都沿着图标中显示的轴向量。
</p>

</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Rectangle(lineColor={160,160,164}, 
      fillColor={160,160,164}, 
      fillPattern=FillPattern.Solid, 
      extent={{-50.0,100.0},{50.0,105.0}}), 
    Rectangle(lineColor={160,160,164}, 
      fillColor={160,160,164}, 
      fillPattern=FillPattern.Solid, 
      extent={{-50.0,-105.0},{50.0,-100.0}}), 
    Line(points={{-90.0,40.0},{-70.0,40.0}}), 
    Line(points={{-80.0,50.0},{-60.0,50.0}}), 
    Line(points={{-70.0,50.0},{-70.0,40.0}}), 
    Line(points={{-80.0,80.0},{-59.0,80.0}}), 
    Line(points={{-70.0,100.0},{-70.0,80.0}}), 
    Text(textColor={0,0,255}, 
      extent={{-150.0,110.0},{150.0,150.0}}, 
      textString="%name"), 
    Text(extent={{-150.0,-150.0},{150.0,-110.0}}, 
      textString="ratio=%ratio"), 
    Rectangle(lineColor={64,64,64}, 
      fillColor={255,255,255}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{10.0,-100.0},{50.0,100.0}}), 
    Rectangle(lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-100.0,-10.0},{-50.0,10.0}}), 
    Rectangle(lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{50.0,-10.0},{100.0,10.0}}), 
    Rectangle(lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-80.0,60.0},{-50.0,70.0}}), 
    Rectangle(origin={-30.0,65.0}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-20.0,-19.0},{20.0,19.0}}), 
    Rectangle(origin={-30.0,48.0}, 
      fillColor={153,153,153}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-2.0},{20.0,2.0}}), 
    Rectangle(origin={-30.0,82.0}, 
      fillColor={204,204,204}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-2.0},{20.0,2.0}}), 
    Rectangle(origin={-30.0,59.0}, 
      fillColor={204,204,204}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-4.0},{20.0,4.0}}), 
    Rectangle(origin={-30.0,73.0}, 
      fillColor={255,255,255}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-3.0},{20.0,3.0}}), 
    Rectangle(origin={-30.0,-1.0}, 
      fillColor={255,255,255}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-20.0,-35.0},{20.0,35.0}}), 
    Rectangle(origin={-30.0,32.0}, 
      fillColor={153,153,153}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-2.0},{20.0,2.0}}), 
    Rectangle(origin={-30.0,23.0}, 
      fillColor={204,204,204}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-3.0},{20.0,3.0}}), 
    Rectangle(origin={-30.0,-10.0}, 
      fillColor={204,204,204}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-4.0},{20.0,4.0}}), 
    Rectangle(origin={-30.0,-34.0}, 
      fillColor={102,102,102}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-2.0},{20.0,2.0}}), 
    Rectangle(origin={-30.0,-25.0}, 
      fillColor={153,153,153}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-3.0},{20.0,3.0}}), 
    Rectangle(origin={-30.0,8.0}, 
      fillColor={255,255,255}, 
      fillPattern=FillPattern.Solid, 
      extent={{-20.0,-4.0},{20.0,4.0}}), 
    Rectangle(origin = {-30,65}, 
      fillColor = {192,192,192}, 
      extent = {{-20,-19},{20,19}}), 
    Rectangle(origin = {-30,-1}, 
      fillColor = {255,255,255}, 
      extent = {{-20,-35},{20,35}}), 
    Rectangle(lineColor = {64,64,64}, 
      fillColor = {255,255,255}, 
      extent = {{10,-100},{50,100}})}), 
  Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
    Polygon(lineColor = {128,128,128}, 
      fillColor = {128,128,128}, 
      fillPattern = FillPattern.Solid, 
      points = {{58,130},{28,140},{28,120},{58,130}}), 
    Line(points = {{-52,130},{28,130}})}));
end IdealPlanetary;