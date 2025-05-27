within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortIMC 
  "带鼠笼的异步电机热端口"
  extends 
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a 
    heatPortRotorWinding "转子热端口(鼠笼)" 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  annotation (Documentation(info="<html>
带鼠笼的异步电机热端口
</html>"));
end ThermalPortIMC;