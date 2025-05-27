within Modelica.Electrical.Analog.Examples.OpAmps;
model LCOscillator "LC振荡器"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage VAmp=10 "输出电压幅值";
  parameter SI.Frequency f=1000 "所需频率";
  parameter Real A=1.001 "放大系数：A>1表示放大；A=1意味着纯正弦波振荡；而A<0则表示衰减或阻尼";
  parameter SI.Inductance L=0.001 "可变电感>0";
  parameter SI.Capacitance C=1/((2*pi*f)^2*L) "计算电容(为达到频率f)";
  parameter SI.Resistance R=10000.0 "阻尼阻抗";
  parameter SI.Resistance R1=10000.0 "可变高电阻";
  parameter SI.Resistance R2=(A - 1)*R1 "计算所需电阻值(以达到放大器放大比A)";
  parameter Real gamma=(1 - A)/(2*R*C) "特征参数";
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={20,-50}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp 
    annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
  Modelica.Electrical.Analog.Basic.Resistor r(R=R) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=R2, i(start=0)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-20,-20})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={0,-40})));
  Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(start=VAmp, fixed=true)) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,-20})));
  Modelica.Electrical.Analog.Basic.Inductor l(L=L, i(fixed=true, start=0)) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={20,-20})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={60,-20})));
equation
  connect(opAmp.out, r.p) annotation (Line(
      points={{-30,0},{-10,0}}, color={0,0,255}));
  connect(opAmp.out, r2.p) annotation (Line(
      points={{-30,0},{-20,0},{-20,-10}}, color={0,0,255}));
  connect(r2.n, r1.p) annotation (Line(
      points={{-20,-30},{-20,-40},{-10,-40}}, color={0,0,255}));
  connect(r2.n, opAmp.in_n) annotation (Line(
      points={{-20,-30},{-20,-40},{-60,-40},{-60,-6},{-50,-6}}, color={0,0,255}));
  connect(r1.n, ground.p) annotation (Line(
      points={{10,-40},{20,-40}}, color={0,0,255}));
  connect(r.n, opAmp.in_p) annotation (Line(
      points={{10,0},{20,0},{20,20},{-60,20},{-60,6},{-50,6}}, color={0,0,255}));
  connect(l.n, ground.p) annotation (Line(
      points={{20,-30},{20,-40}}, color={0,0,255}));
  connect(r.n, l.p) annotation (Line(
      points={{10,0},{20,0},{20,-10}}, color={0,0,255}));
  connect(c.p, l.p) annotation (Line(
      points={{40,-10},{20,-10}}, color={0,0,255}));
  connect(c.n, l.n) annotation (Line(
      points={{40,-30},{20,-30}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{20,-40},{60,-40},{60,-30}}, color={0,0,255}));
  connect(r.n, vOut.p) annotation (Line(
      points={{10,0},{60,0},{60,-10}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>这是一个LC振荡器，构建时参考的参考文献为：</p>
<p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 14.1</p>
</html>"), 
    experiment(
      StartTime=0, 
      StopTime=0.01, 
      Tolerance=0.0001, 
      Interval=1e-005));
end LCOscillator;