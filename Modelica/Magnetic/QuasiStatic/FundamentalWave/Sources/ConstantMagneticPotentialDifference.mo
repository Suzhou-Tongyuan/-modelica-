within Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources;
model ConstantMagneticPotentialDifference 
  "恒定磁势差源"
  extends Interfaces.TwoPortElementary;
  parameter SI.Frequency f(start=1) "信号源频率";
  parameter SI.ComplexMagneticPotentialDifference V_m=Complex(
      re=1, im=0) "Complex magnetic potential difference";
  SI.MagneticPotentialDifference abs_V_m= 
      Modelica.ComplexMath.abs(V_m) 
    "复合磁势差的大小";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m) 
    "复磁势差论证";
  SI.ComplexMagneticFlux Phi "复合磁通量";
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
  // 参考角速度和角度
  omega = 2*Modelica.Constants.pi*f;
  Connections.root(port_p.reference);
  annotation (defaultComponentName="magVoltageSource", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
                              Ellipse(
              extent={{-50,-50},{50,50}}, 
              lineColor={255,127,0}, 
              fillColor={255,255,255}, 
              fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}}, 
          color={255,127,0}),Line(points={{-50,0},{-100,0}}, color={255,127,0}), 
          Line(points={{-50,0},{50,0}}, color={255,127,0}), 
        Text(
          extent={{150,108},{-150,68}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(points={{-80,20},{-60,20}}, color={255,127,0}), 
        Line(points={{-70,30},{-70,10}}, color={255,127,0}), 
        Line(points={{60,20},{80,20}}, color={255,127,0})}), 
                                      Documentation(info="<html>
<p>
恒定磁动力源 .
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.ConstantFlux\">
ConstantFlux</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Sources.SignalFlux\">
SignalFlux</a>
</p>
</html>"));
end ConstantMagneticPotentialDifference;