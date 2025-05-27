within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCSE 
  "串励直流电机的功率平衡"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad + 
        lossPowerFriction + lossPowerBrush + lossPowerSeriesExcitation);

  SI.Power powerSeriesExcitation 
    "电气串励励磁功率";

  SI.Power lossPowerSeriesExcitation 
    "串励励磁损耗";

  annotation (defaultComponentPrefixes="output", 
             Documentation(info="<html>
串励直流电机的功率平衡。
</html>"));
end PowerBalanceDCSE;