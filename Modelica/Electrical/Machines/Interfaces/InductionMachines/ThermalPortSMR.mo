within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortSMR 
  "带有磁阻转子的同步电机热端口"
  extends 
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  parameter Boolean useDamperCage(start=true) 
    "启用/禁用阻尼笼" annotation (Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a 
    heatPortRotorWinding if useDamperCage 
    "阻尼笼的热端口（可选）" 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  annotation (Documentation(info="<html>
带有磁阻转子的同步电机热端口
</html>"));
end ThermalPortSMR;