within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortSMEE 
  "电励磁同步电机热端口"
  extends 
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  parameter Boolean useDamperCage(start=true) 
    "启用/禁用阻尼笼" annotation (Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a 
    heatPortRotorWinding if useDamperCage 
    "阻尼笼的热端口（可选）" 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortExcitation 
    "励磁热端口" 
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush 
    "（可选）刷子损耗的热端口" 
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  annotation (Documentation(info="<html>
电励磁同步电机热端口
</html>"));
end ThermalPortSMEE;