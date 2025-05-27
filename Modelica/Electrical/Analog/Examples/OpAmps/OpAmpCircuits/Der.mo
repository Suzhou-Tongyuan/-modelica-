within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Der "微分运算放大器电路"
  extends PartialOpAmp;
  import Modelica.Constants.pi;
  parameter Real k(final min=0)=1 "对实现频率f时所需的放大倍数";
  parameter SI.Frequency f "频率";
  parameter SI.Resistance R=1000 "OpAmp的输出电阻";
  parameter SI.Capacitance C=k/(2*pi*f*R) "计算电容(为达到所需的放大电阻k)";
  SI.Voltage v(start=0)=c.v "电容电压(state=0)";
  Basic.Capacitor                            c(final C=C) 
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Basic.Resistor                            r(final R=R) 
    annotation (Placement(transformation(extent={{30,20},{10,40}})));
equation
  connect(n1, n2) 
    annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
  connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}}, 
        color={0,0,255}));
  connect(c.n, opAmp.in_n) 
    annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
  connect(opAmp.in_n, r.n) 
    annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
  connect(opAmp.out, r.p) 
    annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
  connect(c.p, p1) annotation (Line(points={{-50,30},{-80,30},{-80,100},{
          -100,100}}, color={0,0,255}));
  connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{
          -10,-6}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>该模型为反相微分器，模型基于<a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a>搭建。</p>
<p><code>vOut=-k*der(vIn)</code></p>
</html>"), Icon(graphics={Text(
          extent={{-60,40},{20,-40}}, 
          textColor={0,0,255}, 
          textString="der")}));
end Der;