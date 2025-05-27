within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceSMPM 
  "永磁同步电机功率平衡"
  extends 
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore + 
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction + 
        lossPowerRotorWinding + lossPowerPermanentMagnet);
  SI.Power lossPowerRotorWinding "转子铜损";
  SI.Power lossPowerPermanentMagnet 
    "永磁体损耗";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
永磁同步电机功率平衡。
</html>"));
end PowerBalanceSMPM;