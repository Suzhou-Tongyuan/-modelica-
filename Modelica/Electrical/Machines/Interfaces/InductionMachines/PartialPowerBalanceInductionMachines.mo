within Modelica.Electrical.Machines.Interfaces.InductionMachines;
record PartialPowerBalanceInductionMachines 
  "异步电机部分功率平衡"
  extends Modelica.Icons.Record;
  SI.Power powerStator=0 "电气功率(定子)";
  SI.Power powerMechanical=0 "机械功率";
  SI.Power powerInertiaStator=0 "定子惯性功率";
  SI.Power powerInertiaRotor=0 "转子惯性功率";
  SI.Power lossPowerTotal=0 "总损耗功率";
  SI.Power lossPowerStatorWinding=0 "定子铜损";
  SI.Power lossPowerStatorCore=0 "定子铁损";
  SI.Power lossPowerRotorCore=0 "转子铁损";
  SI.Power lossPowerStrayLoad=0 "杂散负载损耗";
  SI.Power lossPowerFriction=0 "摩擦损耗";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
异步电机的部分功率平衡。
 </html>"));
end PartialPowerBalanceInductionMachines;