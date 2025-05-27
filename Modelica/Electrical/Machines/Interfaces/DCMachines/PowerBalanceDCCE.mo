within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCCE 
  "直流电机复合励磁的功率平衡"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad + 
        lossPowerFriction + lossPowerBrush + lossPowerShuntExcitation + 
        lossPowerSeriesExcitation);

  SI.Power powerShuntExcitation 
    "电气（分励）励磁功率";

  SI.Power powerSeriesExcitation 
    "电气（串励）励磁功率";

  SI.Power lossPowerShuntExcitation 
    "(分励) 励磁损耗";

  SI.Power lossPowerSeriesExcitation 
    "串励励磁损耗";

  annotation (defaultComponentPrefixes="output", 
             Documentation(info="<html>
直流电机复合励磁的功率平衡。
</html>"));
end PowerBalanceDCCE;