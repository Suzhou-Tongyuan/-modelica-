within Modelica.Electrical.Analog.Examples.Utilities;
model NonlinearResistor "Chua电阻"
  extends Interfaces.OnePort;

  parameter SI.Conductance Ga "内电压范围内的导纳";
  parameter SI.Conductance Gb "外电压范围内的导纳";
  parameter SI.Voltage Ve "内部电压范围限制";
equation
  i = if (v < -Ve) then Gb*(v + Ve) - Ga*Ve else if (v > Ve) then Gb*(v - Ve) 
     + Ga*Ve else Ga*v;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-70,0}}, color={0,0,255}), 
        Line(points={{70,0},{90,0}}, color={0,0,255}), 
        Line(points={{-50,-60},{50,60}}, color={0,0,255}), 
        Polygon(
          points={{50,60},{38,52},{44,46},{50,60}}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Text(
          extent={{-170,110},{150,70}}, 
          textColor={0,0,255}, 
          textString="%name")}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}), 
        Line(points={{-90,0},{-70,0}}, color={0,0,255}), 
        Line(points={{70,0},{90,0}}, color={0,0,255}), 
        Line(points={{-50,-60},{50,60}}, color={0,0,255}), 
        Polygon(
          points={{50,60},{38,52},{44,46},{50,60}}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Text(
          extent={{-100,100},{100,70}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>这是Chua电路中唯一的非线性元件。该非线性电阻器具有分段线性特性。其特性基于两个电压范围，分别是内部电压范围和外部电压范围。其电导率在内部和外部范围内由参数所决定，保证了电阻特性的连续性。在Chua电路中，这两个范围的电导率均需为负值以确保电路的正常运行。</p>
</html>"));
end NonlinearResistor;