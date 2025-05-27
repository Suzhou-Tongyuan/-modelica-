within Modelica.Electrical.Analog.Examples.OpAmps;
model SchmittTrigger "带滞回的Schmitt触发器"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "正输入";
  parameter SI.Voltage Vns=-15 "负输入";
  parameter SI.Voltage Vin=5 "输入电压幅值";
  parameter SI.Frequency f=10 "输入电压频率";
  parameter SI.Voltage vHys=1 "正向滞后电压";
  parameter Real k=vHys/Vps "辅助计算参数(用于在R2计算中使用)";
  parameter SI.Resistance R1=1000 "可变电阻";
  parameter SI.Resistance R2=R1/k "计算达到滞回电压要求的电阻";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
    Vps=Vps, 
    Vns=Vns, 
    out(i(start=0))) 
    annotation (Placement(transformation(extent={{0,10},{20,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
    rising=0.2/f, 
    width=0.3/f, 
    falling=0.2/f, 
    period=1/f, 
    nperiod=-1, 
    startTime=-(vIn.rising + vIn.width/2), 
    V=2*Vin, 
    offset=-Vin) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={50,-20})));
  Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-30,20})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={10,20})));
equation
  connect(ground.p, vIn.n) annotation (Line(
      points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
  connect(opAmp.in_n, ground.p) annotation (Line(
      points={{0,-6},{-10,-6},{-10,-80}}, color={0,0,255}));
  connect(opAmp.out, r2.n) annotation (Line(
      points={{20,0},{30,0},{30,20},{20,20}}, color={0,0,255}));
  connect(r2.p, opAmp.in_p) annotation (Line(
      points={{0,20},{-10,20},{-10,6},{0,6}}, color={0,0,255}));
  connect(r2.p, r1.n) annotation (Line(
      points={{0,20},{-20,20}}, color={0,0,255}));
  connect(r1.p, vIn.p) annotation (Line(
      points={{-40,20},{-80,20},{-80,10}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>这是一个(非反相)Schmitt trigger。用户可以自由选择电阻 R1的值，而电阻R2的值则是由所需的滞回电压决定的。当输入电压超过滞回电压时，触发器输出电压为Vp，当输入电压低于滞回电压的一定比例时，输出电压为Vn。</p>
<p>这个示例选自：U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.2</p>
</html>"), 
    experiment(
      StartTime=0, 
      StopTime=1, 
      Tolerance=1e-006, 
      Interval=0.001));
end SchmittTrigger;