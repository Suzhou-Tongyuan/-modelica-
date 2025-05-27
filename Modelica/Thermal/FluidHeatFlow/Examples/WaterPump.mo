within Modelica.Thermal.FluidHeatFlow.Examples;
model WaterPump "抽水站"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  output SI.VolumeFlowRate V_flow=volumeFlowSensor.y "体积流量";
  output SI.Pressure p(displayUnit="bar")=pressureSensor.y "泵出口压力";
  output SI.AngularVelocity w(displayUnit="1/min")=multiSensor.w "泵速";
  output SI.Torque tau=multiSensor.tau "泵的转矩";
  output SI.Power power=multiSensor.power "泵浦功率";
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    period=2, 
    nperiod=1, 
    offset=0, 
    rising=0.6, 
    width=0.6, 
    falling=0.6, 
    startTime=0.1, 
    amplitude=1.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-70,-50})));
  Modelica.Blocks.Math.Gain gain(k=idealPump.wNominal) 
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true) 
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensor(w(displayUnit="1/min")) 
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  FluidHeatFlow.Sources.Ambient ambient1(
    medium=FluidHeatFlow.Media.Water(), 
    constantAmbientPressure=100000, 
    constantAmbientTemperature=293.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={50,-80})));
  FluidHeatFlow.Sources.IdealPump idealPump(
    medium=FluidHeatFlow.Media.Water(), 
    m=0, 
    V_flow0=0.18, 
    T0=293.15, 
    wNominal=104.71975511966, 
    dp0=500000) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=90, 
        origin={50,-50})));
  FluidHeatFlow.Sensors.VolumeFlowSensor volumeFlowSensor(medium= 
        FluidHeatFlow.Media.Water()) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={50,-20})));
  FluidHeatFlow.Sensors.PressureSensor pressureSensor(medium= 
        FluidHeatFlow.Media.Water()) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={20,0})));
  FluidHeatFlow.Components.OneWayValve oneWayValve(
    medium=FluidHeatFlow.Media.Water(), 
    m=0, 
    frictionLoss=0, 
    T0=293.15, 
    V_flowNominal=0.18, 
    dpForward=10000, 
    dpNominal=500000, 
    V_flowBackward=1e-6) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=270, 
        origin={50,20})));
  FluidHeatFlow.Components.Pipe pipe(
    m=0, 
    V_flowLaminar=0.09, 
    V_flowNominal=0.18, 
    h_g=25, 
    medium=FluidHeatFlow.Media.Water(), 
    T0=293.15, 
    dpLaminar=10000, 
    dpNominal=30000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={50,50})));
  FluidHeatFlow.Sources.Ambient ambient2(
    medium=FluidHeatFlow.Media.Water(), 
    constantAmbientPressure=100000, 
    constantAmbientTemperature=293.15) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=270, 
        origin={50,82})));
equation
  connect(idealPump.flowPort_a, ambient1.flowPort) 
    annotation (Line(points={{50,-60},{50,-70}}, color={255,0,0}));
  connect(speed.flange, multiSensor.flange_a) 
    annotation (Line(points={{0,-50},{10,-50}}));
  connect(oneWayValve.flowPort_a, volumeFlowSensor.flowPort_b) 
    annotation (Line(points={{50,10},{50,-10}}, color={255,0,0}));
  connect(volumeFlowSensor.flowPort_a, idealPump.flowPort_b) 
    annotation (Line(points={{50,-30},{50,-40}}, color={255,0,0}));
  connect(ambient2.flowPort, pipe.flowPort_b) 
    annotation (Line(points={{50,72},{50,60}}, color={255,0,0}));
  connect(pipe.flowPort_a, oneWayValve.flowPort_b) 
    annotation (Line(points={{50,40},{50,30}}, color={255,0,0}));
  connect(multiSensor.flange_b, idealPump.flange_a) 
    annotation (Line(points={{30,-50},{40,-50}}));
  connect(oneWayValve.flowPort_a, pressureSensor.flowPort) 
    annotation (Line(points={{50,10},{50,0},{30,0}}, color={255,0,0}));
  connect(gain.y, speed.w_ref) 
    annotation (Line(points={{-29,-50},{-22,-50}}, color={0,0,127}));
  connect(trapezoid.y, gain.u) 
    annotation (Line(points={{-59,-50},{-52,-50}}, color={0,0,127}));
  annotation (experiment(
      StopTime=2, 
      Interval=0.001, 
      Tolerance=1e-06), Documentation(info="<html><p>
在常压下有两个储层，第二个储层比第一个高25 m。 理想的泵是由一个速度源驱动，从零开始，上升到1.2倍的公称速度。为了避免水倒流，使用单向阀。
</p>
</html>"));
end WaterPump;