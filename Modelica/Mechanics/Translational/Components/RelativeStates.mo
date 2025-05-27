within Modelica.Mechanics.Translational.Components;
model RelativeStates "相对状态变量的定义"
  extends Translational.Interfaces.PartialTwoFlanges;
  parameter StateSelect stateSelect=StateSelect.prefer 
    "优先使用相对角度和相对速度作为状态";
  SI.Position s_rel(start=0, stateSelect=StateSelect.prefer) 
    "作为状态变量使用的相对位置";
  SI.Velocity v_rel(start=0, stateSelect=StateSelect.prefer) 
    "作为状态变量使用的相对速度";
  SI.Acceleration a_rel(start=0) "相对角加速度";

equation
  s_rel = flange_b.s - flange_a.s;
  v_rel = der(s_rel);
  a_rel = der(v_rel);
  flange_a.f = 0;
  flange_b.f = 0;
  annotation (
    Documentation(info="<html>
<p>
通常，Modelica.Mechanics.Translational.Inertia 模型的绝对位置和绝对速度作为状态变量使用。
在某些情况下，相对数量更合适，例如，因为可能更容易提供初始值。
在这种情况下，模型 <strong>RelativeStates</strong> 允许以下方式定义状态变量：
</p>
<ul>
<li> 在两个一维平动接口连接器之间连接此模型的实例。</li>
<li> 使用两个连接器之间的<strong>相对位置</strong>和<strong>相对速度</strong>作为<strong>状态变量</strong>。</li>
</ul>
<p>
下图给出了一个示例
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Components/relativeStates.png\" alt=\"Relative states\">
</div>

<p>
这里，两个质量之间的相对位置和相对速度被用作状态变量。另外，模拟器选择模型 mass1 或模型 mass2 的绝对位置和绝对速度作为状态变量。
</p>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={ Line(
              points={{-100,0},{100,0}}, 
              pattern=LinePattern.Dot, 
          color={0,127,0}), 
        Ellipse(
          extent={{-40,40},{40,-40}}, 
          lineColor={52,219,218}, 
          fillColor={52,219,218}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-40,40},{40,-40}}, 
          textString="S", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end RelativeStates;