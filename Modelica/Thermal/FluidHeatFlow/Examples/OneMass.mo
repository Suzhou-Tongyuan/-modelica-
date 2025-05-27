within Modelica.Thermal.FluidHeatFlow.Examples;
model OneMass "一个热物体的冷却"
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
    "冷却介质" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15 
    "环境温度";
  parameter SI.Temperature TMass(displayUnit="degC")=313.15 
    "初始质量温度";
  output SI.TemperatureDifference dTMass= 
    heatCapacitor.port.T-TAmb "环境质量";
  output SI.TemperatureDifference dTtoPipe=heatCapacitor.port.T-pipe.T_q 
    "过冷剂质量";
  output SI.TemperatureDifference dTCoolant=pipe.dT 
    "冷却剂温度升高";
  FluidHeatFlow.Sources.Ambient ambient1(
    constantAmbientTemperature=TAmb, 
    medium=medium, 
    constantAmbientPressure=0) 
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
  FluidHeatFlow.Sources.VolumeFlow pump(
    medium=medium, 
    m=0, 
    T0=TAmb, 
    useVolumeFlowInput=true, 
    constantVolumeFlow=1) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  FluidHeatFlow.Components.Pipe pipe(
    medium=medium, 
    m=0.1, 
    T0=TAmb, 
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
    C=0.1, T(start=TMass, fixed=true)) 
    annotation (Placement(transformation(
        origin={10,-60}, 
        extent={{10,-10},{-10,10}}, 
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=1) 
    annotation (Placement(transformation(
        origin={10,-30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  FluidHeatFlow.Examples.Utilities.DoubleRamp volumeFlow(
    offset=0, 
    height_1=1, 
    height_2=-2) 
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
equation
  connect(ambient1.flowPort, pump.flowPort_a) 
    annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
  connect(pump.flowPort_b, pipe.flowPort_a) 
    annotation (Line(points={{-20,0},{0,0}}, color={255,0,0}));
  connect(pipe.flowPort_b, ambient2.flowPort) 
    annotation (Line(points={{20,0},{40,0}}, color={255,0,0}));
  connect(thermalConductor.port_a, heatCapacitor.port) annotation (Line(
        points={{10,-40},{10,-45},{10,-50}}, color={191,0,0}));
  connect(pipe.heatPort, thermalConductor.port_b) 
    annotation (Line(points={{10,-10},{10,-20}}, color={191,0,0}));
  connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
      points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
annotation (Documentation(info="<html><p>
第七个测试示例: OneMass<br>热容量与冷却液流耦合。<br>热容量和管道中的冷却液具有不同的初始温度，并最终达到环境温度，且其时间行为取决于冷却液流量。<br>
</p>
</html>"),    experiment(StopTime=1.0, Interval=0.001));
end OneMass;