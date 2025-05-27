within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceIMC 
  "带鼠笼的异步电机功率平衡"
  extends 
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore + 
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction + 
        lossPowerRotorWinding);
  SI.Power lossPowerRotorWinding "转子铜损";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
带鼠笼的异步电机功率平衡。
</html>"));
end PowerBalanceIMC;