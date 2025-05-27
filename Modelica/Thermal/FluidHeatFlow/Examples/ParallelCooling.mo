within Modelica.Thermal.FluidHeatFlow.Examples;
model ParallelCooling "并联分支的冷却回路"
  extends Modelica.Icons.Example;

  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
    "冷却介质" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15 
    "环境温度";
  output SI.TemperatureDifference dTSource1= 
    prescribedHeatFlow1.port.T-TAmb "过热源1";
  output SI.TemperatureDifference dTtoPipe1=prescribedHeatFlow1.port.T-pipe1.T_q 
    "过冷源1";
  output SI.TemperatureDifference dTCoolant1=pipe1.dT 
    "冷却剂1温度升高";
  output SI.TemperatureDifference dTSource2= 
    prescribedHeatFlow2.port.T-TAmb "过热源2";
  output SI.TemperatureDifference dTtoPipe2=prescribedHeatFlow2.port.T-pipe2.T_q 
    "过冷源2";
  output SI.TemperatureDifference dTCoolant2=pipe2.dT 
    "冷却剂2温度升高";
  output SI.TemperatureDifference dTmixedCoolant=ambient2.T_port-ambient1.T_port 
    "混合冷却剂温度升高";
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
  FluidHeatFlow.Components.Pipe pipe1(
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
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  FluidHeatFlow.Components.Pipe pipe2(
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
    annotation (Placement(transformation(extent={{0,20},{20,0}})));
  FluidHeatFlow.Components.Pipe pipe3(
    medium=medium, 
    m=0.1, 
    T0=TAmb, 
    V_flowLaminar=0.1, 
    dpLaminar(displayUnit="Pa") = 0.1, 
    V_flowNominal=1, 
    dpNominal(displayUnit="Pa") = 1, 
    h_g=0, 
    T0fixed=true, 
    useHeatPort=false) 
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  FluidHeatFlow.Sources.Ambient ambient2(
    constantAmbientTemperature=TAmb, 
    medium=medium, 
    constantAmbientPressure=0) 
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(
                   C=0.1, T(start=TAmb, fixed=true)) 
    annotation (Placement(transformation(
        origin={40,-60}, 
        extent={{-10,10},{10,-10}}, 
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow 
    prescribedHeatFlow1 
    annotation (Placement(transformation(
        origin={-20,-60}, 
        extent={{10,-10},{-10,10}}, 
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection1 
    annotation (Placement(transformation(
        origin={10,-40}, 
        extent={{10,10},{-10,-10}}, 
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(
                   C=0.1, T(start=TAmb, fixed=true)) 
    annotation (Placement(transformation(
        origin={38,60}, 
        extent={{10,-10},{-10,10}}, 
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow 
    prescribedHeatFlow2 
    annotation (Placement(transformation(
        origin={-20,60}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection2 
    annotation (Placement(transformation(
        origin={10,40}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Blocks.Sources.Constant volumeFlow(k=1) 
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Constant heatFlow1(k=5) 
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Sources.Constant heatFlow2(k=10) 
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.Constant thermalConductance1(k=1) 
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Blocks.Sources.Constant thermalConductance2(k=1) 
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
equation
  connect(ambient1.flowPort, pump.flowPort_a) 
    annotation (Line(points={{-60,0},{-40,0}}, color={255,0,0}));
  connect(pump.flowPort_b, pipe1.flowPort_a) 
    annotation (Line(points={{-20,0},{-10,0},{-10,-10},{0,-10}}, color={255, 
          0,0}));
  connect(pump.flowPort_b, pipe2.flowPort_a) 
    annotation (Line(points={{-20,0},{-10,0},{-10,10},{0,10}}, color={255,0, 
          0}));
  connect(heatFlow2.y,prescribedHeatFlow2. Q_flow) 
    annotation (Line(points={{-39,60},{-30,60}}, color={0,0,255}));
  connect(heatFlow1.y,prescribedHeatFlow1. Q_flow) 
    annotation (Line(points={{-39,-60},{-30,-60}}, color={0,0,255}));
  connect(thermalConductance2.y, convection2.Gc) 
    annotation (Line(points={{-9,40},{0,40}}, color={0,0,127}));
  connect(thermalConductance1.y, convection1.Gc) 
                                annotation (Line(points={{-9,-40},{0,-40}}, color={0,0,127}));
  connect(pipe1.heatPort,convection1. fluid) annotation (Line(points={{10,-20},{
          10,-30}}, color={191,0,0}));
  connect(convection2.fluid,pipe2. heatPort) annotation (Line(points={{10, 
          30},{10,20}}, color={191,0,0}));
  connect(convection2.solid,prescribedHeatFlow2. port) annotation (Line(
        points={{10,50},{10,60},{-10,60}}, color={191,0,0}));
  connect(convection2.solid,heatCapacitor2. port) annotation (Line(points={{10,50}, 
          {10,60},{28,60}}, color={191,0,0}));
  connect(convection1.solid,prescribedHeatFlow1. port) annotation (Line(
        points={{10,-50},{10,-60},{-10,-60}}, color={191,0,0}));
  connect(convection1.solid,heatCapacitor1. port) annotation (Line(points={{10,-50}, 
          {10,-60},{30,-60}}, color={191,0,0}));
  connect(pipe2.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,10}, 
          {30,10},{30,0},{40,0}},     color={255,0,0}));
  connect(pipe1.flowPort_b,pipe3. flowPort_a) annotation (Line(points={{20,-10}, 
          {30,-10},{30,0},{40,0}},      color={255,0,0}));
  connect(pipe3.flowPort_b,ambient2. flowPort) 
    annotation (Line(points={{60,0},{80,0}}, color={255,0,0}));
  connect(volumeFlow.y, pump.volumeFlow) annotation (Line(
      points={{-39,20},{-30,20},{-30,10}}, color={0,0,127}));
annotation (Documentation(info="<html><p>
第二个测试案例: ParallelCooling<br>两个规定的热源通过导热体将其热量散发到冷却液流中。冷却液流来自环境，由规定质量流量的泵驱动，分成与两个热源相连的两个冷却液流，然后合并。两管道的压降特性决定了冷却液的分流。<br><strong>结果</strong>:<br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>输出</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>名称</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>公式</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>实际的稳态值</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTSource1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">过热源1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTCoolant1 + dTtoPipe1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">15 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTtoPipe1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">过冷源1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Losses1 / ThermalConductor1.G</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> 5 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTCoolant1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">冷却剂1温度升高</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Losses * cp * totalMassFlow/2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">10 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTSource2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">过热源2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTCoolant2 + dTtoPipe2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">30 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTtoPipe2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">过冷源2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Losses2 / ThermalConductor2.G</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">10 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTCoolant2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">冷却剂2温度升高</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Losses * cp * totalMassFlow/2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">20 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTmixedCoolant</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">混合冷却剂温度升高</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">(dTCoolant1+dTCoolant2)/2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">15 K</td></tr></tbody></table><p>
<br>
</p>
</html>"),    experiment(StopTime=1.0, Interval=0.001));
end ParallelCooling;