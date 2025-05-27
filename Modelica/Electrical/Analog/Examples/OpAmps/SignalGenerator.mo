within Modelica.Electrical.Analog.Examples.OpAmps;
model SignalGenerator "矩形三角波发生器"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vps=+15 "正输入";
  parameter SI.Voltage Vns=-Vps "负输入";
  parameter SI.Voltage VAmp=10 "输出所需的峰值电压";
  parameter SI.Resistance R1=1000 "Schmitt-Trigger的可调电阻";
  parameter SI.Resistance R2=R1*Vps/VAmp "为达到VAmp的Schmitt触发器所需电阻";
  parameter SI.Frequency f=10 "所需频率";
  parameter SI.Resistance R=1000 "积分器部分的可变电阻";
  parameter SI.Capacitance C=Vps/VAmp/(4*f*R) "为达到频率f计算所需电容";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp1(
    Vps=Vps, 
    Vns=Vns, 
    strict=false, 
    homotopyType=Modelica.Blocks.Types.LimiterHomotopy.LowerLimit) 
    annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=R2, i(start=Vps/R2)) 
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={-50,30})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-50,50})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp2(
    Vps=Vps, 
    Vns=Vns, 
    v_in(start=0), 
    strict=false) 
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(fixed=true, start=0)) 
    annotation (Placement(transformation(extent={{50,20},{30,40}})));
  Modelica.Electrical.Analog.Basic.Resistor r(R=R) 
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOutRectangle annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={-30,-20})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOutTriangle annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={60,-18})));
equation
  connect(opAmp1.out, r2.n) annotation (Line(
      points={{-40,0},{-30,0},{-30,30},{-40,30}}, color={0,0,255}));
  connect(opAmp1.in_p, r2.p) annotation (Line(
      points={{-60,6},{-70,6},{-70,30},{-60,30}}, color={0,0,255}));
  connect(opAmp1.in_n, ground.p) annotation (Line(
      points={{-60,-6},{-70,-6},{-70,-40},{0,-40}}, color={0,0,255}));
  connect(opAmp1.out, r.p) annotation (Line(
      points={{-40,0},{-30,0},{-30,30},{-10,30}}, color={0,0,255}));
  connect(r.n, c.n) annotation (Line(
      points={{10,30},{30,30}}, color={0,0,255}));
  connect(c.p, opAmp2.out) annotation (Line(
      points={{50,30},{60,30},{60,0},{50,0}}, color={0,0,255}));
  connect(ground.p, opAmp2.in_p) annotation (Line(
      points={{0,-40},{20,-40},{20,-6},{30,-6}}, color={0,0,255}));
  connect(c.n, opAmp2.in_n) annotation (Line(
      points={{30,30},{20,30},{20,6},{30,6}}, color={0,0,255}));
  connect(r2.p, r1.p) annotation (Line(
      points={{-60,30},{-70,30},{-70,50},{-60,50}}, color={0,0,255}));
  connect(opAmp2.out, r1.n) annotation (Line(
      points={{50,0},{60,0},{60,50},{-40,50}}, color={0,0,255}));
  connect(opAmp1.out, vOutRectangle.p) annotation (Line(
      points={{-40,0},{-30,0},{-30,-10}}, color={0,0,255}));
  connect(ground.p, vOutRectangle.n) annotation (Line(
      points={{0,-40},{-30,-40},{-30,-30}}, color={0,0,255}));
  connect(opAmp2.out, vOutTriangle.p) annotation (Line(
      points={{50,0},{60,0},{60,-8}}, color={0,0,255}));
  connect(ground.p, vOutTriangle.n) annotation (Line(
      points={{0,-40},{60,-40},{60,-28}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>这个信号发生器由一个Schmitt触发器和一个积分器组成。Schmitt触发器部分的运算放大器(opAmp1)输出一个幅度为VAmp、频率为f的矩形信号。积分器部分的运算放大器(opAmp2)输出一个幅度也为Vamp、频率也为f的三角形信号。</p>
<p>参考文献：</p>
<p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 14.5.2</p>
</html>"), 
    experiment(
      StartTime=0, 
      StopTime=1, 
      Tolerance=1e-006, 
      Interval=0.001));
end SignalGenerator;