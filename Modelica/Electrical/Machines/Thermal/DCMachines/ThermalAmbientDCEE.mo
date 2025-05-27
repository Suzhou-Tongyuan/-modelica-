within Modelica.Electrical.Machines.Thermal.DCMachines;
model ThermalAmbientDCEE 
  "具有电励磁的直流电机的热环境"
  extends Machines.Interfaces.DCMachines.PartialThermalAmbientDCMachines(
      redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE 
      thermalPort);
  parameter SI.Temperature Te(start=TDefault) 
    "(并励)励磁的温度" 
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowExcitation= 
      temperatureExcitation.port.Q_flow 
    "(并励)励磁的热流量";
  output SI.HeatFlowRate Q_flowTotal=Q_flowArmature + 
      Q_flowCore + Q_flowStrayLoad + Q_flowFriction + Q_flowBrush + 
      Q_flowExcitation;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature 
    temperatureExcitation annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-20,30})));
  Modelica.Blocks.Sources.Constant constTe(final k=Te) if not 
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-20,-10})));
  Modelica.Blocks.Interfaces.RealInput TExcitation(unit="K") if 
    useTemperatureInputs "(并励)励磁的温度" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
equation
  connect(constTe.y, temperatureExcitation.T) annotation (Line(
      points={{-20,1},{-20,18}}, color={0,0,127}));
  connect(TExcitation, temperatureExcitation.T) annotation (Line(
      points={{0,-120},{0,-60},{-40,-60},{-40,8},{-20,8},{-20,18}}, color={0,0,127}));
  connect(temperatureExcitation.port, thermalPort.heatPortExcitation) 
    annotation (Line(
      points={{-20,40},{-20,100},{0,100}}, color={191,0,0}));
  annotation (Icon(graphics={Text(
                extent={{-100,-20},{100,-80}}, 
                textString="DCEE")}), Documentation(info="<html>
具有电(并励)励磁的直流电机的热环境，可通过常数或信号连接器指定绕组温度。此外，所有损耗(热流)已经被记录。
</html>"));
end ThermalAmbientDCEE;