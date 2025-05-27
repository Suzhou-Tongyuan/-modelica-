within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCPM 
  "永磁直流电机的功率平衡"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad + 
        lossPowerFriction + lossPowerBrush + lossPowerPermanentMagnet);

  SI.Power lossPowerPermanentMagnet 
    "永磁损耗";

  annotation (defaultComponentPrefixes="output", 
             Documentation(info="<html>
永磁直流电机的功率平衡。
</html>"));
end PowerBalanceDCPM;