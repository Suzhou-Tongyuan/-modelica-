within Modelica.Mechanics.Rotational.Components;
model SpringDamper "平行连接的线性一维转动弹簧阻尼器"
  parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5) 
    "弹簧刚度系数";
  parameter SI.RotationalDampingConstant d(final min=0, start=0) 
    "阻尼系数";
  parameter SI.Angle phi_rel0=0 "未拉伸弹簧角度";
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
protected
  SI.Torque tau_c "弹簧扭矩";
  SI.Torque tau_d "阻尼器扭矩";
equation
  tau_c = c*(phi_rel - phi_rel0);
  tau_d = d*w_rel;
  tau = tau_c + tau_d;
  lossPower = tau_d*w_rel;
  annotation (
    Documentation(info="<html>
<p>
<strong>平行连接的弹簧</strong>和<strong>阻尼器</strong>元件。
该组件可以连接在两个一维惯性转动组件/齿轮之间，描述轴的弹性和阻尼，
或者在一维惯性转动组件/齿轮与轴承座（组件Fixed）之间，描述元素通过弹簧/阻尼器与轴承座的耦合。
</p>

<p>
请参阅旋转库用户指南中的讨论
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>。
</p>
</html>"), 
    Icon(
      coordinateSystem(preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), 
        graphics={
    Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,40},{80,40}}), 
    Line(points={{-80,40},{-80,-40}}), 
    Line(points={{-80,-40},{-50,-40}}), 
    Rectangle(extent={{-50,-10},{40,-70}}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.Solid), 
    Line(points={{-50,-10},{70,-10}}), 
    Line(points={{-50,-70},{70,-70}}), 
    Line(points={{40,-40},{80,-40}}), 
    Line(points={{80,40},{80,-40}}), 
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
      pattern=LinePattern.Dot)}));
end SpringDamper;