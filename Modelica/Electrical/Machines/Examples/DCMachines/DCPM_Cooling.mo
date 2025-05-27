within Modelica.Electrical.Machines.Examples.DCMachines;
model DCPM_Cooling "测试示例：DCPM电机的冷却"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Va=100 "实际电枢电压";
  parameter SI.Voltage Ve=100 "实际励磁电压";
  parameter SI.AngularVelocity w0= 
      Modelica.Units.Conversions.from_rpm(1500) "空载转速";
  parameter SI.Torque TLoad=63.66 "额定负载转矩";
  parameter SI.Inertia JLoad=0.15 
    "负载的转动惯量";
  parameter SI.Temperature TAmbient=293.15 
    "环境温度";
  parameter SI.HeatCapacity Ca=20 
    "电枢的热容量";
  parameter SI.HeatCapacity Cc=50 "磁芯的热容量";
  final parameter SI.Power Losses=dcpm.Ra*dcpm.IaNominal^2 
    "额定损耗";
  final parameter SI.Temperature T0=293.15 
    "参考温度20°C";
  final parameter SI.TemperatureDifference dTCoolant=10 
    "冷却剂温升";
  final parameter SI.TemperatureDifference dTArmature=dcpm.TaNominal 
       - T0 - dTCoolant/2 "电枢温度升高";
  parameter SI.ThermalConductance G_armature_core=2*Losses/ 
      dTArmature "电枢-磁芯的热导";
  parameter SI.ThermalConductance G_core_cooling=2*Losses/ 
      dTArmature "磁芯-冷却的热导";
  parameter SI.VolumeFlowRate CoolantFlow=50 "冷却剂流量";
  Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(
    wMechanical(start=w0, fixed=true), 
    VaNominal=dcpmData.VaNominal, 
    IaNominal=dcpmData.IaNominal, 
    wNominal=dcpmData.wNominal, 
    TaNominal=dcpmData.TaNominal, 
    Ra=dcpmData.Ra, 
    TaRef=dcpmData.TaRef, 
    La=dcpmData.La, 
    Jr=dcpmData.Jr, 
    useSupport=false, 
    Js=dcpmData.Js, 
    frictionParameters=dcpmData.frictionParameters, 
    coreParameters=dcpmData.coreParameters, 
    strayLoadParameters=dcpmData.strayLoadParameters, 
    brushParameters=dcpmData.brushParameters, 
    phiMechanical(fixed=true), 
    ia(fixed=true), 
    TaOperational=293.15, 
    alpha20a=dcpmData.alpha20a, 
    useThermalPort=true) "DC机器数据" 
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage armatureVoltage(V=Va) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,70})));
  Modelica.Electrical.Analog.Basic.Ground groundArmature annotation (
      Placement(transformation(
        origin={-80,40}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Mechanics.Rotational.Sources.Torque loadTorque(useSupport= 
        false) annotation (Placement(transformation(extent={{60,20},{40, 
            40}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-1.5*TLoad, 
    offset=0, 
    period=1) 
    annotation (Placement(transformation(extent={{90,20},{70,40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor armature(C=Ca, T(
        start=TAmbient, fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={-50,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor armatureCore(
      G=G_armature_core) 
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor core(C=Cc, T(
        start=TAmbient, fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={-10,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor coreCooling(G= 
       G_core_cooling) 
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient inlet(
      constantAmbientTemperature=TAmbient, constantAmbientPressure=0) 
    annotation (Placement(transformation(extent={{-10,-80},{-30,-60}})));
  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow(
    T0=TAmbient, 
    constantVolumeFlow=CoolantFlow, 
    m=0) annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Thermal.FluidHeatFlow.Components.Pipe cooling(
    tapT=0.5, 
    T0=TAmbient, 
    m=0, 
    h_g=0, 
    V_flowLaminar=0.1, 
    dpLaminar(displayUnit="Pa") = 0.1, 
    V_flowNominal=1, 
    dpNominal(displayUnit="Pa") = 1, 
    T0fixed=false, 
    useHeatPort=true) 
    annotation (Placement(transformation(extent={{30,-60},{50,-80}})));
  Modelica.Thermal.FluidHeatFlow.Sources.Ambient outlet(
      constantAmbientTemperature=TAmbient, constantAmbientPressure=0) 
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
      T=TAmbient) 
    annotation (Placement(transformation(extent={{42,-10},{22,10}})));
protected
  Machines.Interfaces.DCMachines.ThermalPortDCPM thermalPort 
    annotation (Placement(transformation(extent={{-14,-4},{-6,4}})));
public
  parameter Utilities.ParameterRecords.DcPermanentMagnetData dcpmData(
    alpha20a(displayUnit="1/K")=Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper, 
    TaNominal=353.15, 
    TaRef=353.15) 
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));

equation
  connect(loadInertia.flange_b, loadTorque.flange) 
    annotation (Line(points={{30,30},{30,30},{40,30}}));
  connect(dcpm.flange, loadInertia.flange_a) annotation (Line(
      points={{0,30},{10,30}}));
  connect(armatureVoltage.n, groundArmature.p) annotation (Line(
      points={{-80,60},{-80,50}}, color={0,0,255}));
  connect(armatureVoltage.p, dcpm.pin_ap) annotation (Line(
      points={{-80,80},{-4,80},{-4,40}}, color={0,0,255}));
  connect(armatureVoltage.n, dcpm.pin_an) annotation (Line(
      points={{-80,60},{-16,60},{-16,40}}, color={0,0,255}));
  connect(armature.port, armatureCore.port_a) annotation (Line(
      points={{-50,-30},{-40,-30}}, color={191,0,0}));
  connect(armatureCore.port_b, core.port) annotation (Line(
      points={{-20,-30},{-10,-30}}, color={191,0,0}));
  connect(core.port, coreCooling.port_a) annotation (Line(
      points={{-10,-30},{0,-30}}, color={191,0,0}));
  connect(pulse.y, loadTorque.tau) annotation (Line(
      points={{69,30},{62,30}}, color={0,0,127}));
  connect(coreCooling.port_b, cooling.heatPort) annotation (Line(
      points={{20,-30},{40,-30},{40,-60}}, color={191,0,0}));
  connect(cooling.flowPort_b, outlet.flowPort) annotation (Line(
      points={{50,-70},{60,-70}}, color={255,0,0}));
  connect(inlet.flowPort, volumeFlow.flowPort_a) annotation (Line(
      points={{-10,-70},{0,-70}}, color={255,0,0}));
  connect(volumeFlow.flowPort_b, cooling.flowPort_a) annotation (Line(
      points={{20,-70},{30,-70}}, color={255,0,0}));
  connect(armature.port, thermalPort.heatPortArmature) annotation (Line(
      points={{-50,-30},{-50,0},{-10,0}}, color={191,0,0}));
  connect(core.port, thermalPort.heatPortCore) annotation (Line(
      points={{-10,-30},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, thermalPort.heatPortStrayLoad) 
    annotation (Line(
      points={{22,0},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, thermalPort.heatPortFriction) 
    annotation (Line(
      points={{22,0},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, thermalPort.heatPortBrush) annotation (
      Line(
      points={{22,0},{-10,0}}, color={191,0,0}));
  connect(fixedTemperature.port, thermalPort.heatPortPermanentMagnet) 
    annotation (Line(
      points={{22,0},{6,0},{6,-0.8},{-10.4,-0.8}}, color={191,0,0}));
  connect(dcpm.thermalPort, thermalPort) annotation (Line(points={{-10,20}, 
          {-10,10},{-10,0}}, color={191,0,0}));
  annotation (experiment(StopTime=25, Interval=1E-4, Tolerance=1E-6), Documentation(info= 
         "<html>
<p>
电机以空载转速启动，然后施加负载脉冲。</p>
<p>冷却电路由电枢热容、电枢和磁芯之间的热导、磁芯热容以及磁芯和冷却介质之间的热导组成。
冷却剂流动电路由入口、体积流量、连接到磁芯的管道和出口组成。</p>
<p><strong>请注意：</strong>
<ul>
<li>热端口的所有未使用的热源(即，机器中没有损耗源的端口：刷子、漂移、摩擦、永磁体)必须连接到恒温源。</li>
<li>热容(即，时间常数)异常小以提供较短的仿真时间！</li>
<li>冷却剂是理论冷却剂，其比热为1 J/kg.K。</li>
<li>热导率以及冷却剂流量参数化方式如下：</li>
</ul>
<ol>
<li>冷却剂的总温升为10K(超过冷却剂入口)</li>
<li>磁芯的温升为27.5K(超过入口和出口之间冷却剂的平均温度)</li>
<li>电枢的温升为55K(超过入口和出口之间冷却剂的平均温度)</li>
</p>
<p>该示例的仿真时间为25秒，用户可以在特定界面绘制以下变量的图像(相对于时间)：
<li>armature.T：电枢温度</li>
<li>core.T：磁芯温度</li>
<li>cooling.T：出口处冷却剂温度</li>
</p>
<p>当电枢温度将达到额定电枢温度，负载保持恒定。
使用默认机器参数，但：
<li>电枢绕组材料设置为铜。</li>
<li>电枢参考温度设置为80°C。</li>
<li>额定电枢温度设置为80°C。</li>
</p>
</html>"));
end DCPM_Cooling;