within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PowerBalanceDCEE 
  "电励磁直流电机的功率平衡"
  extends Machines.Interfaces.DCMachines.PartialPowerBalanceDCMachines(final
      lossPowerTotal=lossPowerArmature + lossPowerCore + lossPowerStrayLoad + 
        lossPowerFriction + lossPowerBrush + lossPowerExcitation);

  SI.Power powerExcitation 
    "电励（分励）励磁功率";

  SI.Power lossPowerExcitation "励磁损耗";

  annotation (defaultComponentPrefixes="output", 
             Documentation(info="<html>
电励磁直流电机的功率平衡。
</html>"));
end PowerBalanceDCEE;