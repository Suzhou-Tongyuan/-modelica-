within Modelica.Electrical.Analog.Examples.OpAmps;
model DifferentialAmplifier "差分放大器"
  extends Modelica.Icons.Example;
  parameter
    Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits.DifferentialAmplifierData 
    data "用于源、运算放大器和测量的参数" 
     annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sourceVoltage1(
    V=sqrt(2/3)*data.VSource, 
    phase=1.0471975511966, 
    f=data.fSource) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-120,-40})));
  Modelica.Electrical.Analog.Sources.SineVoltage sourceVoltage2(
    V=sqrt(2/3)*data.VSource, 
    phase=-1.0471975511966, 
    f=data.fSource) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-100,-40})));
  Modelica.Electrical.Analog.Basic.Resistor resistanceLoad(R=data.RLoad) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-110,60})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensorSource 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,0})));
  Modelica.Blocks.Math.Gain gain(k=-1/data.k) 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistorGround(R=data.RGround, 
    i(start=0, fixed=false)) 
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
    V0=data.V0, 
    useSupply=true, 
    Vps=+data.VSupply, 
    Vns=-data.VSupply) 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=data.R1, 
    i(start=0, fixed=false)) 
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=data.R2, 
    i(start=0, fixed=false)) 
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor3(R=data.R3) 
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor4(R=data.R4) 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage positiveSupply(V=+data.VSupply) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={40,-30})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage negativeSupply(V=-data.VSupply) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={20,-30})));
  Modelica.Electrical.Analog.Basic.Resistor resistanceInstrument(R=data.RInstrument) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={60,-30})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={80,-30})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquare(f=data.fSource) 
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-120,-90},{-100,-70}})));
protected
  Modelica.Electrical.Analog.Interfaces.NegativePin groundSource 
    "负电气引脚" 
    annotation (Placement(transformation(extent={{-114,-64},{-106,-56}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin groundOpAmp 
    "负电气引脚" 
    annotation (Placement(transformation(extent={{-4,-64},{4,-56}})));
equation
  connect(voltageSensor.v, rootMeanSquare.u) 
    annotation (Line(points={{91,-30},{98,-30}}, color={0,0,127}));
  connect(resistor4.n, groundOpAmp) 
    annotation (Line(points={{0,-30},{0,-60}},   color={0,0,255}));
  connect(groundOpAmp, resistorGround.n) 
    annotation (Line(points={{0,-60},{-40,-60}},  color={0,0,255}));
  connect(groundOpAmp, resistanceInstrument.n) 
    annotation (Line(points={{0,-60},{60,-60},{60,-40}}, color={0,0,255}));
  connect(groundOpAmp, voltageSensor.n) 
    annotation (Line(points={{0,-60},{80,-60},{80,-40}},  color={0,0,255}));
  connect(groundOpAmp, positiveSupply.n) 
    annotation (Line(points={{0,-60},{40,-60},{40,-40}}, 
                                                 color={0,0,255}));
  connect(groundOpAmp, negativeSupply.n) 
    annotation (Line(points={{0,-60},{20,-60},{20,-40}}, 
                                                 color={0,0,255}));
  connect(negativeSupply.p, opAmp.s_n) 
    annotation (Line(points={{20,-20},{20,-10},{-10,-10}}, 
                                                     color={0,0,255}));
  connect(opAmp.s_p, positiveSupply.p) 
    annotation (Line(points={{-10,10},{40,10},{40,-20}}, 
                                                       color={0,0,255}));
  connect(sourceVoltage1.n, groundSource) 
    annotation (Line(points={{-120,-50},{-120,-60},{-110,-60}}, 
                                                     color={0,0,255}));
  connect(groundSource,sourceVoltage2. n) annotation (Line(points={{-110,-60},{-100, 
          -60},{-100,-50}},color={0,0,255}));
  connect(groundSource, resistorGround.p) 
    annotation (Line(points={{-110,-60},{-60,-60}}, color={0,0,255}));
  connect(groundSource, ground.p) 
    annotation (Line(points={{-110,-60},{-110,-70}}, color={0,0,255}));
  connect(sourceVoltage1.p, resistor1.p) 
    annotation (Line(points={{-120,-30},{-120,30},{-60,30}}, color={0,0,255}));
  connect(sourceVoltage2.p, resistor2.p) 
    annotation (Line(points={{-100,-30},{-60,-30}},color={0,0,255}));
  connect(voltageSensorSource.v, gain.u) 
    annotation (Line(points={{-69,0},{-62,0}}, color={0,0,127}));
  connect(sourceVoltage2.p, voltageSensorSource.n) annotation (Line(points={{-100, 
          -30},{-100,-20},{-80,-20},{-80,-10}}, color={0,0,255}));
  connect(sourceVoltage1.p, voltageSensorSource.p) annotation (Line(points={{-120, 
          -30},{-120,20},{-80,20},{-80,10}}, color={0,0,255}));
  connect(sourceVoltage1.p, resistanceLoad.p) annotation (Line(points={{-120,-30}, 
          {-120,40},{-130,40},{-130,60},{-120,60}}, color={0,0,255}));
  connect(sourceVoltage2.p, resistanceLoad.n) annotation (Line(points={{-100,-30}, 
          {-100,40},{-90,40},{-90,60},{-100,60}}, color={0,0,255}));
  connect(resistor3.n, resistanceInstrument.p) annotation (Line(points={{0,30}, 
          {20,30},{20,0},{60,0},{60,-20}}, color={0,0,255}));
  connect(resistor3.n, voltageSensor.p) annotation (Line(points={{0,30},{20, 
          30},{20,0},{80,0},{80,-20}}, color={0,0,255}));
  connect(resistor3.n, opAmp.out) 
    annotation (Line(points={{0,30},{20,30},{20,0},{0,0}}, color={0,0,255}));
  connect(resistor1.n, resistor3.p) 
    annotation (Line(points={{-40,30},{-20,30}}, color={0,0,255}));
  connect(resistor2.n, resistor4.p) 
    annotation (Line(points={{-40,-30},{-20,-30}}, color={0,0,255}));
  connect(resistor2.n, opAmp.in_p) annotation (Line(points={{-40,-30},{-30, 
          -30},{-30,-6},{-20,-6}}, color={0,0,255}));
  connect(resistor1.n, opAmp.in_n) annotation (Line(points={{-40,30},{-30,30}, 
          {-30,6},{-20,6}}, color={0,0,255}));
  annotation (experiment(
      StopTime=0.2, 
      Interval=0.0001, 
      Tolerance=1e-06), 
    Diagram(coordinateSystem(extent={{-140,-100},{140,100}})), 
    Documentation(info="<html>
<p>
该模型演示了差分放大器，将输入电压衰减到测量仪器可以处理的水平。
</p>
<p>
两个正弦源电压，相位差为120°(例如三相系统的两个相位)，馈送负载电阻。
负载电阻处的电压需要测量，但对于直接测量来说太高了。
</p>
<h4>备注</h4>
<ul>
<li>放大器的输出相对于差分输入是反相的，并且衰减因子为1/data.k。</li>
<li>测量仪器的输入电阻对测量结果的影响很小。</li>
<li>在源电路中，放大器输入的电流消耗很小(<code>resistor1.i</code>和<code>resistor2.i</code>)。</li>
<li>源和放大器的共地通过地面电阻连接。如果这个电阻很低，放大器的共地和源的共地之间会有一小电流流动(<code>resistorGround.i</code>)。如果这个电阻很高，放大器的共地与源的共地之间会有很高的电压漂移(<code>resistorGround.v</code>)。</li>
</ul>
</html>"));
end DifferentialAmplifier;