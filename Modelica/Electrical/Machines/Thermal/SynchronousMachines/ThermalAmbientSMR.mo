within Modelica.Electrical.Machines.Thermal.SynchronousMachines;
model ThermalAmbientSMR 
  "具有磁阻转子的同步机的热环境"
  parameter Boolean useDamperCage(start=true) 
    "启用/禁用阻尼笼" annotation (Evaluate=true);
  extends 
    Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
      redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMR 
      thermalPort(final useDamperCage=useDamperCage));
  parameter SI.Temperature Tr(start=TDefault) 
    "阻尼笼的温度(可选)" annotation (Dialog(enable=(
          not useTemperatureInputs and useDamperCage)));
  output SI.HeatFlowRate Q_flowRotorWinding= 
      temperatureRotorWinding.port.Q_flow 
    "阻尼笼的热流量(可选)";
  output SI.HeatFlowRate Q_flowTotal=Q_flowStatorWinding + 
      Q_flowRotorWinding + Q_flowStatorCore + Q_flowRotorCore + 
      Q_flowStrayLoad + Q_flowFriction;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature 
    temperatureRotorWinding annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-20,30})));
  Modelica.Blocks.Interfaces.RealInput TRotorWinding(unit="K") if (
    useTemperatureInputs and useDamperCage) 
    "阻尼笼的温度(可选)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={100,-120})));
  Modelica.Blocks.Sources.Constant constTr(final k=if useDamperCage then 
        Tr else TDefault) if (not useTemperatureInputs or not 
    useDamperCage) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-20,-10})));
equation
  connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
      points={{-20,1},{-20,18}}, color={0,0,127}));
  connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
  connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
      points={{100,-120},{100,10},{-20,10},{-20,18}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-100,-20},{100,-80}}, 
          textString="SMR")}), Documentation(info="<html>
具有磁阻转子的同步机的热环境，用于指定绕组温度，可以通过常数或信号连接器进行设置。
此外，所有损耗(热流)已经被记录。
</html>"));
end ThermalAmbientSMR;