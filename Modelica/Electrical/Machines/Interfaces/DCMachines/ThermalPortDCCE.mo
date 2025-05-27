within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector ThermalPortDCCE 
  "直流电机复合励磁的热端口"
  extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a 
    heatPortShuntExcitation "（分励）励磁的热端口" 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a 
    heatPortSeriesExcitation "串励励磁的热端口" 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

  annotation (Documentation(info="<html>
直流电机复合励磁的热端口
</html>"));
end ThermalPortDCCE;