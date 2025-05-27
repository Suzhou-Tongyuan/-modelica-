within Modelica.Electrical.Analog.Examples.OpAmps;
model Comparator "比较器"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vps=+15 "正电压";
  parameter SI.Voltage Vns=-15 "负电压";
  parameter SI.Voltage Vin=5 "输入电压幅值";
  parameter SI.Frequency f=10 "输入电压频率";
  parameter SI.Voltage Vref=0 "参考电压";
  parameter Real k=(Vref - Vns)/(Vps - Vns) "计算达到参考电压所需的电位器比率。";
  parameter SI.Resistance R=1000 "电位器的电阻";
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(Vps=Vps, Vns= 
        Vns) annotation (Placement(transformation(extent={{0,10},{20,-10}})));
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
  Modelica.Electrical.Analog.Basic.Potentiometer potentiometer(R=R, rConstant= 
       k) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        origin={-10,-30})));
  Modelica.Electrical.Analog.Sources.SupplyVoltage supplyVoltage(Vps=Vps, Vns= 
       Vns) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-10,-50})));
equation
  connect(vIn.p, opAmp.in_p) annotation (Line(
      points={{-80,10},{-10,10},{-10,6},{0,6}}, color={0,0,255}));
  connect(opAmp.out, vOut.p) annotation (Line(
      points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
  connect(ground.p, vOut.n) annotation (Line(
      points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
  connect(ground.p, vIn.n) annotation (Line(
      points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
  connect(potentiometer.contact, opAmp.in_n) annotation (Line(
      points={{0,-20},{0,-6}}, color={0,0,255}));
  connect(potentiometer.pin_p, supplyVoltage.pin_p) annotation (Line(
      points={{-20,-30},{-20,-50}}, color={0,0,255}));
  connect(potentiometer.pin_n, supplyVoltage.pin_n) annotation (Line(
      points={{0,-30},{0,-50}}, color={0,0,255}));
  connect(ground.p, supplyVoltage.ground) annotation (Line(
      points={{-10,-80},{-10,-50}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>这是一个比较器。用户可在结果窗口勾选R1后查看仿真结果。R2由所需参考电压Vref决定。输出在输入电压小于Vref时切换到Vn，在输入电压大于Vref时切换到Vp。.</p>
</html>"), 
    experiment(
      StartTime=0, 
      StopTime=1, 
      Tolerance=1e-006, 
      Interval=0.001));
end Comparator;