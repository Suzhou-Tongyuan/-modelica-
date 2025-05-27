within Modelica.Electrical.Machines.Thermal.DCMachines;
model ThermalAmbientDCPM 
  "具有永磁体的直流电机的热环境"
  extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
      redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM 
      thermalPort);
  parameter SI.Temperature Tpm(start=TDefault) 
    "永磁体的温度" 
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowPermanentMagnet= 
      temperaturePermanentMagnet.port.Q_flow 
    "永磁体的热流量";
  output SI.HeatFlowRate Q_flowTotal=Q_flowArmature + 
      Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush + 
      Q_flowPermanentMagnet;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature 
    temperaturePermanentMagnet annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-20,30})));
  Modelica.Blocks.Sources.Constant constTpm(final k=Tpm) if not 
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-20,-10})));
  Modelica.Blocks.Interfaces.RealInput TPermanentMagnet(unit="K") if 
    useTemperatureInputs "永磁体的温度" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
equation
  connect(temperaturePermanentMagnet.port, thermalPort.heatPortPermanentMagnet) 
    annotation (Line(
      points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
  connect(constTpm.y, temperaturePermanentMagnet.T) annotation (Line(
      points={{-20,1},{-20,18}}, color={0,0,127}));
  connect(TPermanentMagnet, temperaturePermanentMagnet.T) annotation (
      Line(
      points={{0,-120},{0,-60},{-40,-60},{-40,8},{-20,8},{-20,18}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}}, 
                textString="DCPM")}), Documentation(info="<html>
具有永磁体的直流电机的热环境，可通过常数或信号连接器指定绕组温度。此外，所有损耗(热流)已经被记录。
</html>"));
end ThermalAmbientDCPM;