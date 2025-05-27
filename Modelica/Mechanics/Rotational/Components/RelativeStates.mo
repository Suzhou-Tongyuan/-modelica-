within Modelica.Mechanics.Rotational.Components;
model RelativeStates "相对状态变量的定义"
  extends Rotational.Interfaces.PartialTwoFlanges;
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用相对角度和相对速度作为状态";
  parameter SI.Angle phi_nominal(
    displayUnit="rad", 
    min=0.0) = 1.0 "相对角度的标称值（用于缩放）";

  SI.Angle phi_rel(
start=0, 
stateSelect=stateSelect, 
nominal=if phi_nominal >= Modelica.Constants.eps then phi_nominal else 
1) "用作状态变量的相对旋转角度";
SI.AngularVelocity w_rel(start=0, stateSelect=stateSelect) 
"用作状态变量的相对角速度";
SI.AngularAcceleration a_rel(start=0) "用作状态变量的相对角加速度";

equation
  phi_rel = flange_b.phi - flange_a.phi;
  w_rel = der(phi_rel);
  a_rel = der(w_rel);
  flange_a.tau = 0;
  flange_b.tau = 0;
  annotation (
    Documentation(info="<html>
<p>
Modelica.Mechanics.Rotational.Components.Inertia模型的绝对角度和绝对角速度被用作状态变量。在某些情况下，
作为相对量更合适被用作状态变量，因为其更容易提供初始值。在这种情况下，model <strong>RelativeStates</strong>允许以以下方式定义状态变量：
</p>
<ul>
<li> 将此模型的实例连接在两个一维转动接口连接器之间。</li>
<li> 两个连接器之间的<strong>相对旋转角度</strong>和<strong>相对角速度</strong>被用作<strong>状态变量</strong>。</li>
</ul>
<p>
下图中给出了一个示例
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/Components/relativeStates.png\" alt=\"带有相对状态的模型\">
</div>

<p>
在这里，两个一维转动惯性组件之间的相对角度和相对角速度被用作状态变量。此外，模拟器会选择model inertia1或model inertial2的绝对角度和绝对角速度作为状态变量。
</p>

<p>
有关
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
的讨论请见Rotation库中的用户指南
</p>
</html>"), 
    Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Line(points={{-100,0},{100,0}}, 
      pattern=LinePattern.Dot), 
    Ellipse(
      lineColor={52,219,218}, 
      fillColor={52,219,218}, 
      fillPattern=FillPattern.Solid, 
      extent={{-40.0,-40.0},{40.0,40.0}}), 
    Text(textColor={0,0,255}, 
      extent={{-40,-40},{40,40}}, 
      textString="S"), 
    Text(
      extent={{-150,90},{150,50}}, 
      textString="%name", 
      textColor={0,0,255})}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={Ellipse(
          extent={{-40,40},{40,-40}}, 
          lineColor={52,219,218}, 
          fillColor={52,219,218}, 
          fillPattern=FillPattern.Solid), 
            Text(
              extent={{-40,40},{40,-40}}, 
              textString="S", 
              textColor={0,0,255}),Line(
              points={{40,0},{96,0}}, 
              pattern=LinePattern.Dash),Line(points={{-100,-10},{-100,-80}}, 
          color={160,160,164}),Line(points={{100,-10},{100,-80}}, color={
          160,160,164}),Polygon(
              points={{80,-65},{80,-55},{100,-60},{80,-65}}, 
              lineColor={160,160,164}, 
              fillColor={160,160,164}, 
              fillPattern=FillPattern.Solid),Line(points={{-100,-60},{80,-60}}, 
          color={160,160,164}),Text(
              extent={{-30,-70},{30,-90}}, 
              textString="w_rel", 
              textColor={0,0,255}),Line(points={{-76,80},{-5,80}}, color={
          128,128,128}),Polygon(
              points={{14,80},{-6,85},{-6,75},{14,80}}, 
              lineColor={128,128,128}, 
              fillColor={128,128,128}, 
              fillPattern=FillPattern.Solid),Text(
              extent={{18,87},{86,74}}, 
              textColor={128,128,128}, 
              textString="rotation axis"),Line(
              points={{-96,0},{-40,0}}, 
              pattern=LinePattern.Dash)}));
end RelativeStates;