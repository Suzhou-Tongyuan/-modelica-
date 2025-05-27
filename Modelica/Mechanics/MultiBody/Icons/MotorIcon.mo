partial class MotorIcon "电机图标"

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          lineColor={64,64,64}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{30.0,-10.0},{90.0,10.0}}), 
        Rectangle(
          lineColor={82,0,2}, 
          fillColor={252,37,57}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-100.0,-50.0},{30.0,50.0}}, 
          radius=10.0), 
        Polygon(
          fillColor={64,64,64}, 
          fillPattern=FillPattern.Solid, 
          points={{-100,-60},{-90,-60},{-60,-20},{-10,-20},{20,-60},{30,-60},{30,-70},{-100,-70},{-100,-60}})}), 
    Documentation(info="<html>
<p>
该图标设计用于<strong>电机</strong>模型。
</p>
</html>"));
end MotorIcon;