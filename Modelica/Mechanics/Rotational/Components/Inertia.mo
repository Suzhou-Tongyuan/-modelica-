within Modelica.Mechanics.Rotational.Components;
model Inertia "带惯性的一维转动组件"
  extends Rotational.Interfaces.PartialTwoFlanges;
  parameter SI.Inertia J(min=0, start=1) "转动惯量";
  parameter StateSelect stateSelect=StateSelect.default 
    "优先使用phi和w作为状态" 
    annotation (HideResult=true, Dialog(tab="高级"));
  SI.Angle phi(stateSelect=stateSelect) 
    "组件的绝对旋转角度" 
    annotation (Dialog(group="初始值", showStartAttribute=true));
  SI.AngularVelocity w(stateSelect=stateSelect) 
    "组件的绝对角速度(= der(phi))" 
    annotation (Dialog(group="初始值", showStartAttribute=true));
  SI.AngularAcceleration a 
    "组件的绝对角加速度(= der(w))" 
    annotation (Dialog(group="初始值", showStartAttribute=true));

equation
  phi = flange_a.phi;
  phi = flange_b.phi;
  w = der(phi);
  a = der(w);
  J*a = flange_a.tau + flange_b.tau;
  annotation (Documentation(info="<html>
<p>
带有<strong>惯性</strong>和两个刚性连接接口的转动组件。
</p>
</html>"), 

       Icon(
  coordinateSystem(preserveAspectRatio=true, 
    extent={{-100.0,-100.0},{100.0,100.0}}), 
  graphics={
    Rectangle(lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-100.0,-10.0},{-50.0,10.0}}), 
    Rectangle(lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{50.0,-10.0},{100.0,10.0}}), 
    Line(points={{-80.0,-25.0},{-60.0,-25.0}}), 
    Line(points={{60.0,-25.0},{80.0,-25.0}}), 
    Line(points={{-70.0,-25.0},{-70.0,-70.0}}), 
    Line(points={{70.0,-25.0},{70.0,-70.0}}), 
    Line(points={{-80.0,25.0},{-60.0,25.0}}), 
    Line(points={{60.0,25.0},{80.0,25.0}}), 
    Line(points={{-70.0,45.0},{-70.0,25.0}}), 
    Line(points={{70.0,45.0},{70.0,25.0}}), 
    Line(points={{-70.0,-70.0},{70.0,-70.0}}), 
    Rectangle(lineColor={64,64,64}, 
      fillColor={255,255,255}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-50.0,-50.0},{50.0,50.0}}, 
      radius=10.0), 
    Text(textColor={0,0,255}, 
      extent={{-150.0,60.0},{150.0,100.0}}, 
      textString="%name"), 
    Text(extent={{-150.0,-120.0},{150.0,-80.0}}, 
      textString="J=%J"), 
    Rectangle(
      lineColor = {64,64,64}, 
      fillColor = {255,255,255}, 
      extent = {{-50,-50},{50,50}}, 
      radius = 10)}));
end Inertia;