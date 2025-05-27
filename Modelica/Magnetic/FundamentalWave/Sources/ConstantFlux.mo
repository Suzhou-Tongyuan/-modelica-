within Modelica.Magnetic.FundamentalWave.Sources;
model ConstantFlux "恒定磁通源"
  extends Magnetic.FundamentalWave.Interfaces.TwoPortElementary;
  SI.ComplexMagneticPotentialDifference V_m 
    "复磁势差";
  SI.MagneticPotentialDifference abs_V_m= 
      Modelica.ComplexMath.abs(V_m) 
    "复合磁势差的大小";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m) 
    "复磁势差论证";
  parameter SI.ComplexMagneticFlux Phi=Complex(re=1, im=0) 
    "复合磁通量";
  SI.MagneticPotentialDifference abs_Phi= 
      Modelica.ComplexMath.abs(Phi) "复合磁通量的大小";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi) 
    "复合磁通论证";

equation
  // 流入正端口的流量
  port_p.V_m - port_n.V_m = V_m;
  // 磁场力
  port_p.Phi = Phi;
  // 局部通量平衡
  port_p.Phi + port_n.Phi = Complex(0, 0);
  annotation (defaultComponentName="magFluxSource", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={Ellipse(
              extent={{-50,-50},{50,50}}, 
              lineColor={255,128,0}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}}, 
          color={255,128,0}),Line(points={{-50,0},{-100,0}}, color={255,128,0}), 
          Line(points={{0,50},{0,-50}}, color={255,128,0}),Polygon(
              points={{80,0},{60,6},{60,-6},{80,0}}, 
              lineColor={255,128,0}, 
              fillColor={255,128,0}, 
              fillPattern=FillPattern.Solid), 
          Text(
              extent={{-150,70},{150,110}}, 
              textColor={0,0,255}, 
              textString="%name")}),  Documentation(info="<html>
<p>
恒定磁通源.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">
   ConstantMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
   SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.SignalFlux\">SignalFlux</a>
</p>

</html>"));
end ConstantFlux;