within Modelica.Magnetic.FundamentalWave.Components;
model Ground "磁性接地"
  Interfaces.PositiveMagneticPort port_p "复杂的磁性端口" 
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  port_p.V_m = Complex(0, 0);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{0,100},{0,50}}, color={255,128,0}), 
        Line(points={{-60,50},{60,50}}, color={255,128,0}), 
        Line(points={{-40,30},{40,30}}, color={255,128,0}), 
        Line(points={{-20,10},{20,10}}, color={255,128,0}), 
        Text(
          extent={{-150,-10},{150,-50}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>

<p>
复合磁势接地。每个磁路至少有一点必须接地.
</p>

</html>"));
end Ground;