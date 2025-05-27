within Modelica.Thermal.FluidHeatFlow.Examples;
model PumpAndValve "带有泵和阀门的冷却回路"
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
    "冷却介质" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15 
    "环境温度";
  output SI.TemperatureDifference dTSource= 
    prescribedHeatFlow.port.T-TAmb "过热源";
  output SI.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe.T_q 
    "过冷源";
  output SI.TemperatureDifference dTCoolant=pipe.dT 
    "冷却剂温度升高";
  FluidHeatFlow.Sources.Ambient ambient1(
    constantAmbientTemperature=TAmb, 
    medium=medium, 
    constantAmbientPressure=0) 
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  FluidHeatFlow.Sources.IdealPump idealPump(
    medium=medium, 
    m=0, 
    T0=TAmb, 
    V_flow0=2, 
    wNominal(displayUnit="rad/s") = 1, 
    dp0(displayUnit="Pa") = 2) 
    annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
  FluidHeatFlow.Components.Valve valve(
    medium=medium, 
    m=0, 
    T0=TAmb, 
    LinearCharacteristic=false, 
    y1=1, 
    Kv1=1, 
    kv0=0.01, 
    dp0(displayUnit="Pa") = 1, 
    rho0=10, 
    frictionLoss=0) 
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  FluidHeatFlow.Components.Pipe pipe(
    medium=medium, 
    T0=TAmb, 
    m=0.1, 
    V_flowLaminar=0.1, 
    dpLaminar(displayUnit="Pa") = 0.1, 
    V_flowNominal=1, 
    dpNominal(displayUnit="Pa") = 1, 
    h_g=0, 
    T0fixed=true, 
    useHeatPort=true) 
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  FluidHeatFlow.Sources.Ambient ambient2(
    constantAmbientTemperature=TAmb, 
    medium=medium, 
    constantAmbientPressure=0) 
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
    C=0.1, T(start=TAmb, fixed=true)) 
    annotation (Placement(transformation(
        origin={40,-50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow 
    annotation (Placement(transformation(extent={{-30,-40},{-10,-60}})));
  Modelica.Blocks.Sources.Constant heatFlow(k=10) 
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection 
    annotation (Placement(transformation(
        origin={10,-30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Blocks.Sources.Constant thermalConductance(k=1) 
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true, useSupport= 
        false) 
    annotation (Placement(transformation(
        origin={-50,30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Blocks.Sources.Ramp speedRamp(
    height=0.5, 
    offset=0.5, 
    duration=0.1, 
    startTime=0.4) annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Ramp valveRamp(
    height=0.5, 
    offset=0.5, 
    duration=0.1, 
    startTime=0.9) annotation (Placement(transformation(extent={{12,40},{-8,60}})));
equation
  connect(pipe.flowPort_b, ambient2.flowPort) 
    annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
  connect(heatFlow.y, prescribedHeatFlow.Q_flow) annotation (Line(points={
          {-39,-50},{-30,-50}}, color={0,0,255}));
  connect(convection.solid, prescribedHeatFlow.port) annotation (Line(
        points={{10,-40},{10,-50},{-10,-50}}, color={191,0,0}));
  connect(convection.solid, heatCapacitor.port) annotation (Line(points={
          {10,-40},{10,-50},{30,-50}}, color={191,0,0}));
  connect(pipe.heatPort, convection.fluid) annotation (Line(points={{10, 
          -10},{10,-20}}, color={191,0,0}));
  connect(thermalConductance.y, convection.Gc) 
    annotation (Line(points={{-9,-30},{0,-30}}, color={0,0,127}));
  connect(ambient1.flowPort, idealPump.flowPort_a) 
    annotation (Line(points={{-70,0},{-60,0}}, color={255,0,0}));
  connect(idealPump.flowPort_b, valve.flowPort_a) 
    annotation (Line(points={{-40,0},{-30,0}}, color={255,0,0}));
  connect(valve.flowPort_b, pipe.flowPort_a) 
    annotation (Line(points={{-10,0},{0,0}}, color={255,0,0}));
  connect(speedRamp.y, speed.w_ref) 
    annotation (Line(points={{-59,50},{-50,50},{-50,42}}, color={0,0,127}));
  connect(valveRamp.y, valve.y) 
    annotation (Line(points={{-9,50},{-20,50},{-20,10}},color={0,0,127}));
  connect(speed.flange, idealPump.flange_a) 
    annotation (Line(points={{-50,20},{-50,10}}));
annotation (Documentation(info="<html>
<p>
第四个测试示例: PumpAndValve
</p>
泵半速运行0.4 s;
之后全速(使用0.1秒的斜坡).<br>
阀门半开0.9秒，然后全开(使用0.1秒的斜坡).<br>
你可以尝试去做:
<ul>
<li>以变速驱动泵，使阀门全开，调节冷却剂的体积流量</li>
<li>恒速驱动泵，节流阀调节冷却液的体积流量</li>
</ul>
</html>"),    experiment(StopTime=2.0, Interval=0.001));
end PumpAndValve;