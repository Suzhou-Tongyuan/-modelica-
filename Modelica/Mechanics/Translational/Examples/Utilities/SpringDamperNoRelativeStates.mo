within Modelica.Mechanics.Translational.Examples.Utilities;
model SpringDamperNoRelativeStates 
  "平行连接的线性一维平移弹簧和阻尼器（s 和 v 不作为状态使用）"
  parameter SI.TranslationalSpringConstant c(final min=0, start=1.0e5) "弹簧常数";
  parameter SI.TranslationalDampingConstant d(final min=0, start=0) "阻尼常数";
  parameter SI.Length s_rel0=0 
    "未拉伸弹簧长度";
  SI.Velocity v_rel(start=0) 
    "相对速度 (= der(s_rel))";
  extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  SI.Force f_c "弹簧力";
  SI.Force f_d "阻尼力";
equation
  v_rel = der(s_rel);
  f_c = c*(s_rel - s_rel0);
  f_d = d*v_rel;
  f = f_c + f_d;
  lossPower = f_d*v_rel;
  annotation (
    Documentation(info="<html>
<p>
<strong>弹簧</strong>和<strong>阻尼器</strong>元件<strong>并联连接</strong>。
该组件可以连接在两个质量块之间，描述它们之间的弹性和阻尼，也可以连接在质量和壳体（即组件Fixed）之间，
描述元件通过弹簧/阻尼器与壳体的耦合。
</p>
<p>
这个元件与<a href=\"modelica://Modelica.Mechanics.Translational.Components.SpringDamper\">Translational.Components.SpringDamper</a> 
是相同的，唯一的区别在于，相对量不作为状态使用。如果相对状态可能作为状态使用，“a_rel = der(v_rel)” 
会存在，那么导出此模型作为FMU需要在一维平动接口处输入加速度，但这通常对于力元件是不希望的。
</p>
</html>"), 
    Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), 
        graphics={
    Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,40},{80,40}}, color={0,127,0}), 
    Line(points={{-80,40},{-80,-60}}, color={0,127,0}), 
    Line(points={{-80,-60},{-50,-60}}, color={0,127,0}), 
    Rectangle(extent={{-50,-40},{40,-80}}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.Solid, 
          lineColor={0,127,0}), 
    Line(points={{-50,-40},{70,-40}}, color={0,127,0}), 
    Line(points={{-50,-80},{70,-80}}, color={0,127,0}), 
    Line(points={{40,-60},{80,-60}}, color={0,127,0}), 
    Line(points={{80,40},{80,-60}}, color={0,127,0}), 
    Line(points={{-90,0},{-80,0}}, color={0,127,0}), 
    Line(points={{80,0},{90,0}}, color={0,127,0}), 
    Text(origin={0,-9}, 
      extent={{-150,-144},{150,-104}}, 
      textString="d=%d"), 
    Text(extent={{-190,110},{190,70}}, 
      textColor={0,0,255}, 
      textString="%name"), 
    Text(
      origin={0,-7}, 
      extent={{-150,-108},{150,-68}}, 
          textString="c=%c"), 
    Line(visible=useHeatPort, 
      points={{-100,-100},{-100,-55},{-5,-55}}, 
      color={191,0,0}, 
      pattern=LinePattern.Dot), 
        Polygon(
          points={{51,-10},{21,0},{21,-20},{51,-10}}, 
          lineColor={95,127,95}, 
          fillColor={95,127,95}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-59,-10},{21,-10}}, color={95,127,95})}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,32}, 
              {80,32}}, 
          thickness=0.5), 
        Line(points={{-68,32},{-68,97}}, color={128,128,128}), 
        Line(points={{72,32},{72,97}}, color={128,128,128}), 
        Line(points={{-68,92},{72,92}}, color={128,128,128}), 
        Polygon(
          points={{62,95},{72,92},{62,89},{62,95}}, 
          lineColor={128,128,128}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-44,79},{29,91}}, 
          textColor={0,0,255}, 
          textString="s_rel"), 
        Rectangle(
          extent={{-50,-20},{40,-80}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-50,-80},{68,-80}}), 
        Line(points={{-50,-20},{68,-20}}), 
        Line(points={{40,-50},{80,-50}}), 
        Line(points={{-80,-50},{-50,-50}}), 
        Line(points={{-80,32},{-80,-50}}), 
        Line(points={{80,32},{80,-50}}), 
        Line(points={{-96,0},{-80,0}}), 
        Line(points={{96,0},{80,0}})}));
end SpringDamperNoRelativeStates;