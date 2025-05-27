within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceSMR 
  "带有磁阻转子的同步电机功率平衡"
  extends 
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore + 
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction + 
        lossPowerRotorWinding);
  SI.Power lossPowerRotorWinding "转子铜损";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
带有磁阻转子的同步电机功率平衡。
</html>"));
end PowerBalanceSMR;