within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector ThermalPortDCEE 
  "电励磁直流电机的热端口"
  extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortExcitation 
    "（分励）励磁的热端口" 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));

  annotation (Documentation(info="<html>
电励磁（分励）直流电机的热端口
</html>"));
end ThermalPortDCEE;