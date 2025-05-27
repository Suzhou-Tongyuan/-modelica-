within Modelica.Thermal.FluidHeatFlow.Examples;
model IndirectCooling "间接冷却回路"
  extends Modelica.Icons.Example;
  parameter FluidHeatFlow.Media.Medium outerMedium=FluidHeatFlow.Media.Medium() 
    "外部媒介" annotation (choicesAllMatching=true);
  parameter FluidHeatFlow.Media.Medium innerMedium=FluidHeatFlow.Media.Medium() 
    "内部媒介" annotation (choicesAllMatching=true);
  parameter SI.Temperature TAmb(displayUnit="degC")=293.15 
    "环境温度";
  output SI.TemperatureDifference dTSource= 
    prescribedHeatFlow.port.T-TAmb "过热源";
  output SI.TemperatureDifference dTtoPipe=prescribedHeatFlow.port.T-pipe1.T_q 
    "内过冷源";
  output SI.TemperatureDifference dTinnerCoolant=pipe1.dT 
    "内冷却液温度升高";
  output SI.TemperatureDifference dTCooler=innerPipe.T_q-outerPipe.T_q 
    "冷却器在内外管道之间的温度升高";
  output SI.TemperatureDifference dTouterCoolant=outerPipe.dT 
    "外冷却液温度升高";
  FluidHeatFlow.Sources.Ambient ambient1(
    constantAmbientTemperature=TAmb, 
    medium=outerMedium, 
    constantAmbientPressure=0) 
    annotation (Placement(transformation(extent={{-60,60},{-80,80}})));
  FluidHeatFlow.Sources.VolumeFlow outerPump(
    medium=outerMedium, 
    m=0, 
    T0=TAmb, 
    useVolumeFlowInput=true, 
    constantVolumeFlow=1) 
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  FluidHeatFlow.Sources.Ambient ambient2(
    constantAmbientTemperature=TAmb, 
    medium=outerMedium, 
    constantAmbientPressure=0) 
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor 
    thermalConductor(G=1) 
    annotation (Placement(transformation(
        origin={10,-70}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
    C=0.05, T(start=TAmb, fixed=true)) 
    annotation (Placement(transformation(
        origin={40,-90}, 
        extent={{-10,10},{10,-10}}, 
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow 
    prescribedHeatFlow 
    annotation (Placement(transformation(
        origin={-20,-90}, 
        extent={{10,-10},{-10,10}}, 
        rotation=180)));
  FluidHeatFlow.Components.Pipe pipe1(
    medium=innerMedium, 
    m=0.1, 
    T0=TAmb, 
    V_flowLaminar=1, 
    V_flowNominal=2, 
    h_g=0, 
    T0fixed=true, 
    useHeatPort=true, 
    dpLaminar=1000, 
    dpNominal=2000) 
    annotation (Placement(transformation(extent={{20,-50},{0,-30}})));
  FluidHeatFlow.Sources.AbsolutePressure absolutePressure(p=10000, medium= 
        innerMedium) 
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  FluidHeatFlow.Sources.VolumeFlow innerPump(
    medium=innerMedium, 
    m=0, 
    T0=TAmb, 
    useVolumeFlowInput=true, 
    constantVolumeFlow=1) annotation (Placement(transformation(
        origin={-20,-30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Blocks.Sources.Constant heatFlow(k=10) 
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Blocks.Sources.Constant outerVolumeFlow(k=1) 
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Sources.Constant innerVolumeFlow(k=1) 
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant outerGc(k=2) 
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Sources.Constant innerGc(k=2) 
    annotation (Placement(transformation(extent={{-40,20},{-20,0}})));
  FluidHeatFlow.Components.Pipe outerPipe(
    medium=outerMedium, 
    m=0.1, 
    T0=TAmb, 
    V_flowLaminar=0.1, 
    dpLaminar(displayUnit="Pa") = 0.1, 
    V_flowNominal=1, 
    dpNominal(displayUnit="Pa") = 1, 
    h_g=0, 
    T0fixed=true, 
    useHeatPort=true) 
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  FluidHeatFlow.Components.Pipe innerPipe(
    medium=innerMedium, 
    m=0.1, 
    T0=TAmb, 
    V_flowLaminar=0.1, 
    dpLaminar(displayUnit="Pa") = 0.1, 
    V_flowNominal=1, 
    dpNominal(displayUnit="Pa") = 1, 
    h_g=0, 
    T0fixed=true, 
    useHeatPort=true) 
    annotation (Placement(transformation(extent={{0,-10},{20,-30}})));
  Modelica.Thermal.HeatTransfer.Components.Convection innerConvection 
    annotation (Placement(transformation(
        origin={10,10}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.Convection outerConvection 
    annotation (Placement(transformation(
        origin={10,40}, 
        extent={{10,10},{-10,-10}}, 
        rotation=270)));
equation
  connect(ambient1.flowPort, outerPump.flowPort_a) 
    annotation (Line(points={{-60,70},{-40,70}}, color={255,0,0}));
  connect(prescribedHeatFlow.port, thermalConductor.port_a) 
    annotation (Line(points={{-10,-90},{10,-90},{10,-80}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalConductor.port_a) 
    annotation (Line(points={{30,-90},{10,-90},{10,-80}}, color={191,0,0}));
  connect(pipe1.heatPort, thermalConductor.port_b) 
    annotation (Line(points={{10,-50},{10,-60}}, color={191,0,0}));
  connect(pipe1.flowPort_b, innerPump.flowPort_a) 
    annotation (Line(points={{0,-40},{-20,-40}}, color={255,0,0}));
  connect(absolutePressure.flowPort, pipe1.flowPort_a) 
    annotation (Line(points={{40,-30},{40,-40},{20,-40}}, color={255,0,0}));
  connect(heatFlow.y, prescribedHeatFlow.Q_flow) 
    annotation (Line(points={{-39,-90},{-30,-90}}, color={0,0,255}));
  connect(innerPump.flowPort_b, innerPipe.flowPort_a) 
    annotation (Line(points={{-20,-20},{0,-20}}, color={255,0,0}));
  connect(innerPipe.flowPort_b, absolutePressure.flowPort) annotation (Line(
        points={{20,-20},{40,-20},{40,-30}}, color={255,0,0}));
  connect(outerPump.flowPort_b, outerPipe.flowPort_a) 
    annotation (Line(points={{-20,70},{0,70}}, color={255,0,0}));
  connect(outerPipe.flowPort_b,ambient2. flowPort) 
    annotation (Line(points={{20,70},{40,70}}, color={255,0,0}));
  connect(outerPipe.heatPort, outerConvection.fluid) 
    annotation (Line(points={{10,60},{10,55},{10,50}}, color={191,0,0}));
  connect(outerConvection.solid, innerConvection.solid) 
    annotation (Line(points={{10,30},{10,20},{10,20}}, color={191,0,0}));
  connect(innerConvection.fluid, innerPipe.heatPort) 
    annotation (Line(points={{10,0},{10,-5},{10,-10}}, color={191,0,0}));
  connect(innerGc.y, innerConvection.Gc) 
    annotation (Line(points={{-19,10},{-9.5,10},{-9.5,10},{0,10}}, color={0,0,127}));
  connect(outerGc.y, outerConvection.Gc) 
    annotation (Line(points={{-19,40},{0,40}}, color={0,0,127}));
  connect(outerVolumeFlow.y, outerPump.volumeFlow) annotation (Line(
      points={{-39,90},{-30,90},{-30,80}}, color={0,0,127}));
  connect(innerVolumeFlow.y, innerPump.volumeFlow) annotation (Line(
      points={{-39,-30},{-30,-30}}, color={0,0,127}));
annotation (Documentation(info="<html><p>
第三个测试示例: IndirectCooling<br> 规定的热源通过热导体将其热量散发到内部冷却剂循环。有必要确定内冷却剂循环的压力水平。内部冷却剂循环通过热导体耦合到外部冷却剂流动。<br><br>内冷却液在源附近的温度上升与冷却器附近的温度下降相同。
</p>
<p>
<strong>结果</strong>:<br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>输出</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>名称</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>公式</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>实际的稳态值</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTSource</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">过热源</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dtouterCoolant + dtCooler + dTinnerCoolant + dtToPipe</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">40 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTtoPipe</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">内过冷源</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Losses / ThermalConductor.G</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">10 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTinnerColant</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">内冷却液温度升高</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Losses * cp * innerMassFlow</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">10 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTCooler</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">冷却器在内外管道之间的温度升高</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Losses * (innerGc + outerGc)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">10 K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">dTouterColant</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">外冷却液温度升高</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Losses * cp * outerMassFlow</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">10 K</td></tr></tbody></table><p>
<br>
</p>
<p>
<br>
</p>
</html>"),    experiment(StopTime=1.5, Interval=0.001));
end IndirectCooling;