within Modelica.Mechanics.Rotational.Components;
model Fixed "在给定角度处固定的一维转动接口"
  parameter SI.Angle phi0=0 "一维转动接口固定在轴承座上的偏移角度";

  Interfaces.Flange_b flange "(右侧) 固定在轴承座内的一维转动接口" annotation (
      Placement(transformation(extent={{10,-10},{-10,10}})));

equation
  flange.phi = phi0;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-90},{150,-130}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(points={{-80,-40},{80,-40}}), 
        Line(points={{80,-40},{40,-80}}), 
        Line(points={{40,-40},{0,-80}}), 
        Line(points={{0,-40},{-40,-80}}), 
        Line(points={{-40,-40},{-80,-80}}), 
        Line(points={{0,-40},{0,-10}})}), 
    Documentation(info="<html>
<p>
一维转动机械系统的<strong>一维转动接口</strong>在<strong>轴承座</strong>中的角度<strong>固定</strong>在角度phi0处。
可用于以下用途：
</p>
<ul>
<li>连接弹性元件，如弹簧或阻尼器，以及一维转动惯性组件或齿轮箱组件与轴承座之间。</li>
<li>将刚性元件，如一维转动惯性组件，与轴承座固定在特定角度上。</li>
</ul>

</html>"));
end Fixed;