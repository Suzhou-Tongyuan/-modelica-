within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
model Add "加法运算放大器电路"
  extends PartialOpAmp;
  SI.Voltage v1_2=p1_2.v - n1.v "电压降(= p1_2.v - n1.v)";
  SI.Current i1_2=p1_2.i "电流从端口1_2的正极流向负极";
  parameter Real k1(final min=0)=1 "输入1的权重";
  parameter Real k2(final min=0)=1 "输入2的权重";
  parameter SI.Resistance R=1000 "OpAmp输出的电阻值";
  parameter SI.Resistance R1=R/k1 "计算电阻(为达到权重1)";
  parameter SI.Resistance R2=R/k2 "计算电阻(为达到权重2)";
  Basic.Resistor  r1(final R=R1) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        origin={-40,70})));
  Basic.Resistor  r2(final R=R2) 
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, 
        rotation=180, 
        origin={-40,30})));
  Interfaces.PositivePin p1_2 "Positive electrical pin 1.2" annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}), 
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Basic.Resistor r(final R=R) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        origin={20,30})));
equation
  connect(n1, n2) 
    annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
  connect(p1, r1.p) annotation (Line(points={{-100,100},{-80,100},{-80,70},{-50, 
          70}}, color={0,0,255}));
  connect(p1_2, r2.p) annotation (Line(points={{-100,0},{-80,0},{-80,30},{-50,30}}, 
        color={0,0,255}));
  connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}}, 
        color={0,0,255}));
  connect(r2.n, opAmp.in_n) 
    annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
  connect(opAmp.in_n, r1.n) 
    annotation (Line(points={{-10,6},{-10,70},{-30,70}}, color={0,0,255}));
  connect(opAmp.in_n, r.n) 
    annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
  connect(opAmp.out, r.p) 
    annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
  connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}}, 
        color={0,0,255}));
  annotation (Documentation(info="<html>
<p>反相加法器，基于<a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a>搭建的模型。</p>
<p><code>-vOut=k1*vIn1+k2*vIn2</code></p>
</html>"), Icon(graphics={Text(
          extent={{-40,40},{40,-40}}, 
          textColor={0,0,255}, 
          textString="+")}));
end Add;