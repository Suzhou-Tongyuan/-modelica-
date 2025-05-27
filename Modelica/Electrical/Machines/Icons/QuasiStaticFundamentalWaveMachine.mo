within Modelica.Electrical.Machines.Icons;
partial model QuasiStaticFundamentalWaveMachine 
  "准静态基波电机的图标"

  annotation (Icon(graphics={
        Rectangle(
          extent={{-40,60},{80,-60}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={255,206,120}), 
        Rectangle(
          extent={{-40,60},{-60,-60}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={128,128,128}), 
        Rectangle(
          extent={{80,10},{100,-10}}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          fillColor={95,95,95}), 
        Rectangle(
          extent={{-40,70},{40,50}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90}, 
              {80,-100},{-50,-100},{-50,-90}}, 
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
这个图标是为<strong>quasi-static fundamental wave machine</strong>模型设计的。
</p>
</html>"));
end QuasiStaticFundamentalWaveMachine;