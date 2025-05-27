within Modelica.Mechanics.Rotational.Components;
model Spring "线性一维转动弹簧"
  extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;
  parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5) 
    "弹簧刚度系数";
  parameter SI.Angle phi_rel0=0 "未拉伸弹簧角度";

equation
  tau = c*(phi_rel - phi_rel0);
  annotation (
    Documentation(info="<html>
<p>
这是一个<strong>线性一维转动弹簧</strong>。该组件可以连接在两个一维转动惯性组件/齿轮之间，用以描述轴的弹性。
或者在一维惯性转动组件/齿轮与轴承座（组件Fixed）之间通过弹簧实现两者之间的耦合。
</p>

</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
    Text(extent={{-150,80},{150,40}}, 
      textString="%name", 
      textColor={0,0,255}), 
    Text(extent={{-150,-40},{150,-80}}, 
      textString="c=%c"), 
    Line(points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},{100,0}})}));
end Spring;