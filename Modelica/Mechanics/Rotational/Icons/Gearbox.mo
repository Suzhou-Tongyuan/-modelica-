within Modelica.Mechanics.Rotational.Icons;
model Gearbox "齿轮箱的图标"

  annotation (Icon(
      coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}, 
        preserveAspectRatio=true), 
        graphics={
      Rectangle(
        lineColor={64,64,64}, 
        fillColor={192,192,192}, 
        fillPattern=FillPattern.HorizontalCylinder, 
        extent={{-100,-10},{100,10}}), 
      Polygon(fillColor={192,192,192}, 
        fillPattern=FillPattern.HorizontalCylinder, 
        points={{-60.0,10.0},{-60.0,20.0},{-40.0,40.0},{-40.0,-40.0},{-60.0,-20.0},{-60.0,10.0}}), 
      Rectangle(lineColor={64,64,64}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.HorizontalCylinder, 
        extent={{-40.0,-60.0},{40.0,60.0}}, 
        radius=10.0), 
      Rectangle(lineColor={64,64,64}, 
        extent={{-40.0,-60.0},{40.0,60.0}}, 
        radius=10.0), 
      Polygon(fillColor={192,192,192}, 
        fillPattern=FillPattern.HorizontalCylinder, 
        points={{60.0,20.0},{40.0,40.0},{40.0,-40.0},{60.0,-20.0},{60.0,20.0}}), 
      Polygon(
        fillColor={64,64,64}, 
        fillPattern=FillPattern.Solid, 
        points={{-60,-80},{-50,-80},{-20,-20},{20,-20},{48,-80},{60,-80},{60,-90},{-60,-90},{-60,-80}})}),                                       Documentation(info="<html>
<p>
这是Rotation包中齿轮箱的图标。
</p>
</html>"));

end Gearbox;