within Modelica.Mechanics.Rotational.Components;
model Disc 
  "没有惯性的一维转动刚性组件，其中右侧一维转动接口相对于左侧一维转动接口以固定角度旋转"
  extends Rotational.Interfaces.PartialTwoFlanges;
  parameter SI.Angle deltaPhi=0 
    "左侧一维转动接口相对于右侧一维转动接口的固定旋转角度(= flange_b.phi - flange_a.phi)";
  SI.Angle phi "组件的绝对旋转角度";

equation
  flange_a.phi = phi - deltaPhi/2;
  flange_b.phi = phi + deltaPhi/2;
  0 = flange_a.tau + flange_b.tau;
  annotation (Documentation(info="<html>
<p>
带有两个刚性连接一维转动接口的旋转组件<strong>没有惯性</strong>。
右侧一维转动接口相对于左侧一维转动接口以固定角度\"deltaPhi\"旋转。
</p>
</html>"), 
       Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
        Rectangle(lineColor={64,64,64}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-30.0,10.0},{-10.0,50.0}}), 
        Rectangle(lineColor={64,64,64}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{10.0,-50.0},{30.0,-10.0}}), 
        Rectangle(
          lineColor={64,64,64}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-100.0,-10.0},{100.0,10.0}}), 
        Rectangle(lineColor={64,64,64}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-10.0,-50.0},{10.0,50.0}}), 
        Text(extent={{-160.0,-87.0},{160.0,-62.0}}, 
          textString="deltaPhi = %deltaPhi"), 
        Text(textColor={0,0,255}, 
          extent={{-150.0,60.0},{150.0,100.0}}, 
          textString="%name")}));
end Disc;