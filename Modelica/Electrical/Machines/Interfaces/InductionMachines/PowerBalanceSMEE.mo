within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceSMEE 
  "电励磁同步电机功率平衡"
  extends 
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore + 
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction + 
        lossPowerRotorWinding + lossPowerExcitation + lossPowerBrush);
  SI.Power lossPowerRotorWinding "转子铜损";
  SI.Power powerExcitation "电励磁功率";
  SI.Power lossPowerExcitation "励磁损耗";
  SI.Power lossPowerBrush "刷子损耗";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
电励磁同步电机功率平衡。
</html>"));
end PowerBalanceSMEE;