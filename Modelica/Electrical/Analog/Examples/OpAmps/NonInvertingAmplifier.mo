within Modelica.Electrical.Analog.Examples.OpAmps;
model NonInvertingAmplifier "非反相放大器"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vin=5 "输入电压的幅值";
  parameter SI.Frequency f=10 "输入电压的频率";
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
    V=2*Vin, 
    rising=0.2/f, 
    width=0.3/f, 
    falling=0.2/f, 
    period=1/f, 
    nperiod=-1, 
    offset=-Vin, 
    startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-40,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={40,0})));
  OpAmpCircuits.Buffer buffer(k=2) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(vIn.n, buffer.n1) 
    annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
  connect(vIn.p, buffer.p1) 
    annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
  connect(buffer.p2, vOut.p) 
    annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
  connect(buffer.n2, vOut.n) 
    annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
  connect(buffer.n1, ground.p) 
    annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>这是一个非反相放大器。</p>
</html>"), 
    experiment(
      StartTime=0, 
      StopTime=1, 
      Tolerance=1e-006, 
      Interval=0.001));
end NonInvertingAmplifier;