within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PowerBalanceIMS 
  "带滑环的异步电机功率平衡"
  extends 
    Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines(
      final lossPowerTotal=lossPowerStatorWinding + lossPowerStatorCore + 
        lossPowerRotorCore + lossPowerStrayLoad + lossPowerFriction + 
        lossPowerRotorWinding + lossPowerBrush);
  SI.Power lossPowerRotorWinding "转子铜损";
  SI.Power lossPowerBrush "刷子损耗";
  SI.Power powerRotor "电气功率(转子)";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
带滑环的异步电机功率平衡。
</html>"));
end PowerBalanceIMS;