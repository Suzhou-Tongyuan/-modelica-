within Modelica.Thermal.HeatTransfer.Icons;
model FixedTemperature "固定温度源图标"
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}}, 
          pattern=LinePattern.None, 
          fillColor={159,159,223}, 
          fillPattern=FillPattern.Backward), 
        Line(
          points={{-42,0},{66,0}}, 
          color={191,0,0}, 
          thickness=0.5), 
        Polygon(
          points={{52,-20},{52,20},{90,0},{52,-20}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html><p>
该图标代表固定温度边界模型。
</p>
</html>"));
end FixedTemperature;