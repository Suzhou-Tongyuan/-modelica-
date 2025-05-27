within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector ThermalPortDCPM 
  "永磁直流电机的热端口"
  extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a 
    heatPortPermanentMagnet "永磁的热端口" 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));

  annotation (Documentation(info="<html>
永磁直流电机的热端口
</html>"));
end ThermalPortDCPM;