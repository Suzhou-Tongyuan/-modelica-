within Modelica.Thermal.HeatTransfer.Icons;
model PrescribedTemperature "规定温度源图标"
  extends FixedTemperature;
  annotation (Icon(graphics={Line(points={{-100,0},{-42,0}}, color={191,0,0})}), Documentation(info="<html><p>
该图标代表设定温度边界模型。
</p>
</html>"));
end PrescribedTemperature;