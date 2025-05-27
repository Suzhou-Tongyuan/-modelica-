within Modelica.Thermal.FluidHeatFlow.Examples;
model TwoTanks "两个连接的OpenTank"
  extends Modelica.Icons.Example;
  output SI.VolumeFlowRate V_flow=pipe.V_flow "容积流量罐1 ->罐2";
  output SI.Length level1=openTank1.level "1号罐液位";
  output SI.Temperature T1(displayUnit="degC")=openTank1.TTank "1号储罐温度";
  output SI.Length level2=openTank2.level "2号罐液位";
  output SI.Temperature T2(displayUnit="degC")=openTank2.TTank "2号储罐温度";
  FluidHeatFlow.Components.OpenTank openTank1(
    ATank=1, 
    hTank=1, 
    useHeatPort=false, 
    g=10, 
    level(fixed=true, start=0.9), 
    T0=313.15, 
    T0fixed=true, 
    pAmbient=100000) 
    annotation (Placement(transformation(extent={{-60,12},{-40,32}})));
  FluidHeatFlow.Components.OpenTank openTank2(
    ATank=1, 
    hTank=1, 
    useHeatPort=false, 
    g=10, 
    level(fixed=true, start=0.1), 
    T0=293.15, 
    T0fixed=true, 
    pAmbient=100000) 
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  FluidHeatFlow.Components.Pipe pipe(
    m=0, 
    h_g=0, 
    T0=293.15, 
    V_flowLaminar=2, 
    dpLaminar=10, 
    V_flowNominal=4, 
    dpNominal=30) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(openTank1.flowPort, pipe.flowPort_a) 
    annotation (Line(points={{-50,12},{-50,0},{-10,0}}, color={255,0,0}));
  connect(pipe.flowPort_b, openTank2.flowPort) 
    annotation (Line(points={{10,0},{50,0},{50,10}}, color={255,0,0}));
  annotation (experiment(StopTime=1.5), 
    Documentation(info="<html><p>
两个储罐用一根管道连接:
</p>
<li>
储罐 1: 初始液位 = 0.9 m, T = 40°C</li>
<li>
储罐 2: 初始液位 = 0.1 m, T = 20°C</li>
<p>
在1.5 s内(取决于管道的流动阻力)，两个罐内的液位= 0.5 m相同，介质从储罐 1流向储罐 2。储罐 1温度保持不变，储罐 2温度升高.
</p>
</html>"));
end TwoTanks;