within Modelica.Electrical.Machines.Thermal.InductionMachines;
model ThermalAmbientIMC 
  "感应电机带松鼠笼的热环境"
  extends 
    Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines(
      redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMC 
      thermalPort);
  parameter SI.Temperature Tr(start=TDefault) 
    "转子(松鼠笼)的温度" 
    annotation (Dialog(enable=not useTemperatureInputs));
  output SI.HeatFlowRate Q_flowRotorWinding= 
      temperatureRotorWinding.port.Q_flow 
    "转子(松鼠笼)的热流量";
  output SI.HeatFlowRate Q_flowTotal=Q_flowStatorWinding + 
      Q_flowRotorWinding + Q_flowStatorCore + Q_flowRotorCore + 
      Q_flowStrayLoad + Q_flowFriction;
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature 
    temperatureRotorWinding annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,30})));
  Modelica.Blocks.Interfaces.RealInput TRotorWinding(unit="K") if 
    useTemperatureInputs "松鼠笼的温度" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={100,-120})));
  Modelica.Blocks.Sources.Constant constTr(final k=Tr) if not 
    useTemperatureInputs annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-50,-10})));
equation
  connect(constTr.y, temperatureRotorWinding.T) annotation (Line(
      points={{-50,1},{-50,18}}, color={0,0,127}));
  connect(temperatureRotorWinding.port, thermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{-50,40},{-50,100},{0,100}}, color={191,0,0}));
  connect(TRotorWinding, temperatureRotorWinding.T) annotation (Line(
      points={{100,-120},{100,8},{-50,8},{-50,18}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-100,-20},{100,-80}}, 
          textString="IMC")}), Documentation(info="<html>
用于松鼠笼感应电机的热环境，可通过常数或信号连接器指定绕组温度。
此外，所有损耗(热流量)已经被记录。
</html>"));
end ThermalAmbientIMC;