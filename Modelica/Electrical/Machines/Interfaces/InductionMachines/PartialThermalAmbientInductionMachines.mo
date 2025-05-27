within Modelica.Electrical.Machines.Interfaces.InductionMachines;
model PartialThermalAmbientInductionMachines 
  "感应电机的部分热环境"
  parameter Integer m=3 "定子相数" annotation(Evaluate=true);
  parameter Boolean useTemperatureInputs=false 
    "如果为真，则使用温度输入；否则，温度为常数" 
    annotation (Evaluate=true);
  constant SI.Temperature TDefault=293.15 
    "默认温度";
  parameter SI.Temperature Ts(start=TDefault) 
    "定子绕组的温度" 
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowStatorWinding= 
      temperatureStatorWinding.port.Q_flow 
    "定子绕组的热流率";
  output SI.HeatFlowRate Q_flowStatorCore= 
      temperatureStatorCore.port.Q_flow 
    "定子铁心损耗的热流率";
  output SI.HeatFlowRate Q_flowRotorCore= 
      temperatureRotorCore.port.Q_flow 
    "转子铁心损耗的热流率";
  output SI.HeatFlowRate Q_flowStrayLoad= 
      temperatureStrayLoad.port.Q_flow 
    "杂散负载损耗的热流率";
  output SI.HeatFlowRate Q_flowFriction=temperatureFriction.port.Q_flow 
    "摩擦损耗的热流率";
  replaceable
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines thermalPort(final m=m) 
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature 
    temperatureStatorWinding annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,30})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature 
    temperatureStatorCore(final T=TDefault) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={20,50})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature 
    temperatureRotorCore(final T=TDefault) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={40,30})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature 
    temperatureStrayLoad(final T=TDefault) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={60,50})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature 
    temperatureFriction(final T=TDefault) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={80,30})));
  Modelica.Blocks.Interfaces.RealInput TStatorWinding(unit="K") if 
    useTemperatureInputs "定子绕组的温度" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={-100,-120}), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={-100,-120})));
  Modelica.Blocks.Sources.Constant constTs(final k=Ts) if not 
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,-10})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector 
    thermalCollectorStator(final m=m) 
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
equation
  connect(constTs.y, temperatureStatorWinding.T) annotation (Line(
      points={{-80,1},{-80,18}}, color={0,0,127}));
  connect(TStatorWinding, temperatureStatorWinding.T) annotation (Line(
      points={{-100,-120},{-100,-120},{-100,8},{-80,8},{-80,18}}, color={0,0,127}));

  connect(temperatureStrayLoad.port, thermalPort.heatPortStrayLoad) 
    annotation (Line(
      points={{60,60},{60,100},{1,100}}, color={191,0,0}));
  connect(temperatureFriction.port, thermalPort.heatPortFriction) 
    annotation (Line(
      points={{80,40},{80,96},{0,96}}, color={191,0,0}));
  connect(thermalCollectorStator.port_b, temperatureStatorWinding.port) 
    annotation (Line(
      points={{-80,60},{-80,40}}, color={191,0,0}));
  connect(thermalCollectorStator.port_a, thermalPort.heatPortStatorWinding) 
    annotation (Line(
      points={{-80,80},{-80,102},{-1,102}}, color={191,0,0}));
  connect(temperatureStatorCore.port, thermalPort.heatPortStatorCore) 
    annotation (Line(
      points={{20,60},{20,102},{1,102}}, color={191,0,0}));
  connect(temperatureRotorCore.port, thermalPort.heatPortRotorCore) 
    annotation (Line(
      points={{40,40},{40,98},{1,98}}, color={191,0,0}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}}, 
          pattern=LinePattern.None, 
          fillColor={159,159,223}, 
          fillPattern=FillPattern.Backward), 
        Line(
          points={{-14,0},{54,0}}, 
          color={191,0,0}, 
          thickness=0.5, 
          origin={0,-6}, 
          rotation=90), 
        Polygon(
          points={{-20,-20},{-20,20},{20,0},{-20,-20}}, 
          lineColor={191,0,0}, 
          fillColor={191,0,0}, 
          fillPattern=FillPattern.Solid, 
          origin={0,68}, 
          rotation=90)}), Documentation(info="<html>
感应电机的部分热环境
</html>"));
end PartialThermalAmbientInductionMachines;