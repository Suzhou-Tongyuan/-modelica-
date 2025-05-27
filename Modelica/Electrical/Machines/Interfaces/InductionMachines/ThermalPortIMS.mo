within Modelica.Electrical.Machines.Interfaces.InductionMachines;
connector ThermalPortIMS 
  "带滑环的异步电机热端口"
  extends 
    Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines;
  parameter Integer mr=m "转子相数" annotation(Evaluate=true);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a 
    heatPortRotorWinding[mr] "转子绕组热端口" 
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortBrush 
    "(可选)刷子损耗热端口" 
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  annotation (Documentation(info="<html>
带滑环转子的异步电机热端口
</html>"));
end ThermalPortIMS;