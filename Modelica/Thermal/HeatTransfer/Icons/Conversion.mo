within Modelica.Thermal.HeatTransfer.Icons;
model Conversion "温度换算"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-40,40},{40,-40}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={191,0,0}), 
        Line(points={{-40,0},{-100,0}}, color={0,0,127}), 
        Line(points={{100,0},{40,0}}, color={0,0,127}), 
        Text(
          extent={{-150,100},{150,60}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-20,4},{20,4},{0,14}}, color={191,0,0}), 
        Line(points={{-20,-4},{20,-4},{0,-16}}, color={191,0,0})}), 
    Documentation(info="<html>
<p>
该图标代表温度转换模型的一部分。
</p>
</html>"));
end Conversion;