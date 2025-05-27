within Modelica.Electrical.Analog.Examples.OpAmps;
model Multivibrator "Schmitt触发器多谐振荡器"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "正输入";
  parameter SI.Voltage Vns=-15 "夫输入";
  parameter SI.Frequency f=10 "所需频率";
  parameter SI.Resistance R1=1000 "用于调整Schmitt触发器电压电平的电阻1";
  parameter SI.Resistance R2=1000 "用于调整Schmitt触发器电压电平的电阻2";
  parameter SI.Resistance R=1000 "可变电阻";
  parameter SI.Capacitance C=1/f/(2*R*log(1 + 2*R1/R2)) "促使达到期望频率f的计算电容值";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
    Vps=Vps, 
    Vns=Vns, 
    homotopyType = Modelica.Blocks.Types.LimiterHomotopy.LowerLimit, 
    strict = true) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={50,-20})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=R1, i(start=0)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-10,-40})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}}, 
        origin={10,-20})));
  Modelica.Electrical.Analog.Basic.Resistor r(R=R) 
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(start=1, fixed=true)) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-30,-40})));
equation
  connect(ground.p, r1.n) annotation (Line(
      points={{-10,-60},{-10,-50}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-60},{50,-60},{50,-30}}, color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
  connect(ground.p, c.n) annotation (Line(
      points={{-10,-60},{-30,-60},{-30,-50}}, color={0,0,255}));
  connect(opAmp.out, r.p) annotation (Line(
      points={{20,0},{30,0},{30,30},{20,30}}, color={0,0,255}));
  connect(r.n, opAmp.in_n) annotation (Line(
      points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
  connect(opAmp.out, r2.p) annotation (Line(
      points={{20,0},{30,0},{30,-20},{20,-20}}, color={0,0,255}));
  connect(r2.n, opAmp.in_p) annotation (Line(
      points={{0,-20},{-10,-20},{-10,-6},{0,-6}}, color={0,0,255}));
  connect(opAmp.in_p, r1.p) annotation (Line(
      points={{0,-6},{-10,-6},{-10,-30}}, color={0,0,255}));
  connect(r.n, c.p) annotation (Line(
      points={{0,30},{-30,30},{-30,-30}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>这是一款根据Schmitt触发器原理设计的多谐振荡器，在设计时参考的参考文献如下：</p>
<p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.3</p>
<p>在初始化系统中存在两种解：一种是运放输出处于较低饱和极限状态的解，另一种是两个电压输入非常接近的解。为了使求解器收敛到前者，即所需的解，设置了<code>homotopyType</code>的参数。</p>
</html>"), 
    experiment(
      StartTime=0, 
      StopTime=1, 
      Tolerance=1e-006, 
      Interval=0.001));
end Multivibrator;