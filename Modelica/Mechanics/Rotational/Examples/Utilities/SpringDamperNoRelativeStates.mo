within Modelica.Mechanics.Rotational.Examples.Utilities;
model SpringDamperNoRelativeStates 
  "线性一维转动弹簧和阻尼器并联（phi和w不用作状态）"
  parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5) "弹簧常数";
  parameter SI.RotationalDampingConstant d(final min=0, start=0) "阻尼常数";
  parameter SI.Angle phi_rel0=0 
    "未拉伸的弹簧角度";
  SI.AngularVelocity w_rel(start=0) 
    "相对角速度(= der(phi_rel))";
  extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  SI.Torque tau_c "弹簧扭矩";
  SI.Torque tau_d "阻尼器扭矩";
equation
  w_rel = der(phi_rel);
  tau_c = c*(phi_rel - phi_rel0);
  tau_d = d*w_rel;
  tau = tau_c + tau_d;
  lossPower = tau_d*w_rel;
  annotation (
    Documentation(info="<html>
<p>
<strong>弹簧</strong>和<strong>阻尼器</strong>元件<strong>并联连接</strong>。
该组件可连接在两个质量块之间，用于描述连接处的弹性和阻尼，或者连接在质量块和轴承座（Fixed组件）之间，
以描述元件通过弹簧/阻尼器与外壳的耦合关系。
</p>

<p>
这是与<a href=\"modelica://Modelica.Mechanics.Rotational.Components.SpringDamper\">Rotational.Components.SpringDamper</a>
相同的元件，唯一的区别在于，相对量不用作状态。如果相对状态可能用作状态，则存在\"a_rel = der(w_rel)\"，
那么将此模型导出为FMU要求在一维转动接口中也具有加速度作为输入，通常不希望将力元件用于此。
</p>
</html>"
), 
    Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), 
        graphics={
    Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,40},{80,40}}), 
    Line(points={{-80,40},{-80,-60}}), 
    Line(points={{-80,-60},{-50,-60}}), 
    Rectangle(extent={{-50,-40},{40,-80}}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.Solid), 
    Line(points={{-50,-40},{70,-40}}), 
    Line(points={{-50,-80},{70,-80}}), 
    Line(points={{40,-60},{80,-60}}), 
    Line(points={{80,40},{80,-60}}), 
    Line(points={{-90,0},{-80,0}}), 
    Line(points={{80,0},{90,0}}), 
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
          lineColor={128,128,128}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-59,-10},{21,-10}})}), 
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