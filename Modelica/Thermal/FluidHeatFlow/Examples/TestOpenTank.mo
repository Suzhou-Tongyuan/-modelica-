within Modelica.Thermal.FluidHeatFlow.Examples;
model TestOpenTank "测试OpenTank模型"
  extends Modelica.Icons.Example;
  output SI.VolumeFlowRate V_flow=volumeFlow.V_flow "罐的容积流量";
  output SI.Length level=openTank.level "罐内液面";
  output SI.Temperature T(displayUnit="degC")=openTank.TTank "罐内温度";
  FluidHeatFlow.Components.OpenTank openTank(
    ATank=1, 
    hTank=1, 
    useHeatPort=false, 
    pAmbient=0, 
    g=10, 
    level(fixed=true, start=0.5), 
    T0=313.15, 
    T0fixed=true) 
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  FluidHeatFlow.Sources.Ambient ambient(constantAmbientPressure=0, 
      constantAmbientTemperature=293.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={0,-60})));
  FluidHeatFlow.Sources.VolumeFlow volumeFlow(
    m=0, 
    useVolumeFlowInput=true, 
    constantVolumeFlow=1, 
    T0=293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=[0,0; 0.5,0; 0.5,-1; 0.75, -1; 0.75,1; 1,1; 1,0; 1.5,0]) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(combiTimeTable.y[1], volumeFlow.volumeFlow) 
    annotation (Line(points={{-19,0},{-10,0}}, color={0,0,127}));
  connect(openTank.flowPort, volumeFlow.flowPort_b) 
    annotation (Line(points={{0,50},{0,10}}, color={255,0,0}));
  connect(volumeFlow.flowPort_a, ambient.flowPort) 
    annotation (Line(points={{0,-10},{0,-50}}, color={255,0,0}));
  annotation (experiment(StopTime=1.5), 
    Documentation(info="<html><p>
首先，将介质从罐内(初始液位= 0.5 m，T= 40℃)泵出至(无限)环境(T= 20℃):
</p>
<li>
罐内介质的液位降低</li>
<li>
罐内介质的温度保持不变</li>
<p>
随后，介质从(无限)环境中被泵入罐中:
</p>
<li>
罐内介质的液位再次升高</li>
<li>
罐内介质温度降低(混合温度)</li>
</html>"));
end TestOpenTank;