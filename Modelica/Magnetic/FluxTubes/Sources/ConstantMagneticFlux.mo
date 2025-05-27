within Modelica.Magnetic.FluxTubes.Sources;
model ConstantMagneticFlux "恒定磁通的来源"

  extends Interfaces.TwoPortElementary;
  parameter SI.MagneticFlux Phi=1 "磁通";
  SI.MagneticPotentialDifference V_m 
    "两个端口之间的磁电位差";

equation
  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;
  0 = port_p.Phi + port_n.Phi;
  annotation (
    defaultComponentName="magFluxSource", 
    Icon(coordinateSystem(
      preserveAspectRatio=false, 
      extent={{-100,-100},{100,100}}), graphics={
      Text(
        extent={{-150,60},{150,100}}, 
        textString="%name", 
        textColor={0,0,255}), 
      Polygon(
        points={{80,0},{60,6},{60,-6},{80,0}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{-100,0},{-50,0}}, color={255,127,0}), 
      Line(points={{50,0},{100,0}}, color={255,127,0}), 
      Ellipse(
        extent={{-50,-50},{50,50}}, 
        lineColor={255,127,0}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{0,50},{0,-50}}, color={255,127,0})}), 
    Diagram(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}), graphics={Line(points={{-125,0},{-115,0}}, color={160,160,164}), 
          Line(points={{-120,-5},{-120,5}}, color={160,160,164}), 
          Line(points={{115,0},{125,0}}, color={160,160,164})}), 
    Documentation(info="<html>
<p>
恒定磁通的来源对于用Norton</em>磁等效电路模拟永磁体是有用的.
</p>
</html>"));
end ConstantMagneticFlux;