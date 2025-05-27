within Modelica.Electrical.Analog.Examples.OpAmps;
model InvertingSchmittTrigger "(反相)滞回触发器"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "正电压";
  parameter SI.Voltage Vns=-15 "负电压";
  parameter SI.Voltage Vin=5 "输入电压的幅值";
  parameter SI.Frequency f=10 "输入电压的频率";
  parameter SI.Voltage vHys=1 "滞回电压(数值为正)";
  parameter Real k=vHys/Vps "用于R2计算的辅助计算参数";
  parameter SI.Resistance R1=1000 "可变电阻";
  parameter SI.Resistance R2=(1 - k)/k*R1 "达到滞回电压时所需电阻值";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
    Vps=Vps, 
    Vns=Vns, 
    out(i(start=0))) 
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
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
        rotation=270, 
        origin={30,-60})));
  Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=90, 
        origin={30,-20})));
equation
  connect(r2.n, r1.p) annotation (Line(
      points={{30,-30},{30,-50}}, color={0,0,255}));
  connect(ground.p, r1.n) annotation (Line(
      points={{-10,-80},{30,-80},{30,-80},{30,-80},{30,-70},{30,-70}}, color={0,0,255}));
  connect(opAmp.out, r2.p) annotation (Line(
      points={{20,0},{30,0},{30,-10}}, color={0,0,255}));
  connect(r2.n, opAmp.in_p) annotation (Line(
      points={{30,-30},{30,-40},{-10,-40},{-10,-6},{0,-6}}, color={0,0,255}));
  connect(vIn.p, opAmp.in_n) annotation (Line(
      points={{-80,10},{-20,10},{-20,6},{0,6}}, color={0,0,255}));
  connect(ground.p, vIn.n) annotation (Line(
      points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>这是一个(反相)滞回触发器。用户可以在仿真界面勾选电阻R1以查看仿真结果。滞回电压由电阻R2定义。当输入电压大于vHys(vHys>0)时，输出为Vn，当输入电压小于(vHys*Vns/Vps)时，输出为Vp。</p>
<p>这个例子选自：U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.2</p>
</html>"), 
    experiment(
      StartTime=0, 
      StopTime=1, 
      Tolerance=1e-006, 
      Interval=0.001));
end InvertingSchmittTrigger;