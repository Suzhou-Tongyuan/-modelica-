within Modelica.Electrical.Machines.Interfaces.DCMachines;
connector ThermalPortDCSE 
  "串励直流电机的热端口"
  extends Machines.Interfaces.DCMachines.PartialThermalPortDCMachines;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a 
    heatPortSeriesExcitation "串励励磁的热端口" 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

  annotation (Documentation(info="<html>
串励直流电机的热端口
</html>"));
end ThermalPortDCSE;