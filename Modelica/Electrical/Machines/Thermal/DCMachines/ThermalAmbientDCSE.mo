within Modelica.Electrical.Machines.Thermal.DCMachines;
model ThermalAmbientDCSE 
  "具有串励的直流电机的热环境"
  extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
      redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE 
      thermalPort);
  parameter SI.Temperature Tse(start=TDefault) 
    "串励的温度" 
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowSeriesExcitation= 
      temperatureSeriesExcitation.port.Q_flow 
    "串励的热流量";
  output SI.HeatFlowRate Q_flowTotal=Q_flowArmature + 
      Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush + 
      Q_flowSeriesExcitation;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature 
    temperatureSeriesExcitation annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,30})));
  Modelica.Blocks.Sources.Constant constTse(final k=Tse) if not 
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,-10})));
  Modelica.Blocks.Interfaces.RealInput T_se(unit="K") if useTemperatureInputs 
    "串励的温度" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120}), iconTransformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
equation
  connect(constTse.y, temperatureSeriesExcitation.T) annotation (Line(
      points={{-50,1},{-50,18}}, color={0,0,127}));
  connect(T_se, temperatureSeriesExcitation.T) annotation (Line(
      points={{0,-120},{0,-60},{-70,-60},{-70,8},{-50,8},{-50,18}}, color={0,0,127}));
  connect(temperatureSeriesExcitation.port, thermalPort.heatPortSeriesExcitation) 
    annotation (Line(
      points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
  annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}}, 
                textString="DCSE")}), Documentation(info="<html>
具有串联励磁的直流电机的热环境，可以通过常数或信号连接器指定绕组温度。此外，所有损耗(热流)已经被记录。
</html>"));
end ThermalAmbientDCSE;