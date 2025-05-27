within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Gain "反相运算放大器电路"
  extends PartialOpAmp;
  parameter Real k(final min=0)=1 "所需放大倍数";
  parameter SI.Resistance R1=1000 "在负极的电阻";
  parameter SI.Resistance R2=k*R1 "计算电阻(为达到所需放大倍数k)";
  Basic.Resistor                            r1(final R=R1) 
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Basic.Resistor                            r2(final R=R2) 
    annotation (Placement(transformation(extent={{30,20},{10,40}})));
equation
  connect(opAmp.out, r2.p) 
    annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
  connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}}, 
        color={0,0,255}));
  connect(r1.n, opAmp.in_n) 
    annotation (Line(points={{-30,30},{-10,30},{-10,6}}, 
                                                color={0,0,255}));
  connect(r1.n, r2.n) 
    annotation (Line(points={{-30,30},{10,30}}, color={0,0,255}));
  connect(r1.p, p1) annotation (Line(points={{-50,30},{-80,30},{-80,100},{
          -100,100}}, 
        color={0,0,255}));
  connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}}, 
        color={0,0,255}));
  connect(n1, n2) 
    annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>该反相放大器为增益型放大器，该放大器的构建是基于<a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a>模型。</p>
<p><code>vOut=-k*vIn</code></p>
</html>"), 
       Icon(graphics={
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}), 
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}), 
        Line(points={{-80,-80},{-80,40},{60,40}},                color = {0,0,127})}));
end Gain;