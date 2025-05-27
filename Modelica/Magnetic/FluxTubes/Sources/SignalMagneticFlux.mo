within Modelica.Magnetic.FluxTubes.Sources;
model SignalMagneticFlux "信号控制磁通源"

  extends Interfaces.TwoPortElementary;
  Modelica.Blocks.Interfaces.RealInput Phi(unit="Wb") "磁通" annotation (
      Placement(transformation(
        origin={0,110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={0,110})));
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
      Polygon(
        points={{80,0},{60,6},{60,-6},{80,0}}, 
        lineColor={255,128,0}, 
        fillColor={255,128,0}, 
        fillPattern=FillPattern.Solid), 
      Text(
        extent={{-150,50},{150,90}}, 
        textString="%name", 
        textColor={0,0,255}), 
      Line(points={{-100,0},{-50,0}}, color={255,127,0}), 
      Line(points={{50,0},{100,0}}, color={255,127,0}), 
      Ellipse(
        extent={{-50,-50},{50,50}}, 
        lineColor={255,127,0}, 
        fillColor={255,255,255}, 
        fillPattern=FillPattern.Solid), 
      Line(points={{0,50},{0,-50}}, color={255,127,0})}), 
    Documentation(info="<html>
<p>
这种磁通源用于测试目的，例如，如果与非线性磁阻元件一起使用，则用于模拟和随后绘制软磁材料的磁化特性.
</p>
</html>"));
end SignalMagneticFlux;