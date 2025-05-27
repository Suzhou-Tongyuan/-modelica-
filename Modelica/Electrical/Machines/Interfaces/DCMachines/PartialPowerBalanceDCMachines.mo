within Modelica.Electrical.Machines.Interfaces.DCMachines;
record PartialPowerBalanceDCMachines 
  "直流机器的部分功率平衡"
  extends Modelica.Icons.Record;
  SI.Power powerArmature=0 "电枢电功率";
  SI.Power powerMechanical=0 "机械功率";
  SI.Power powerInertiaStator=0 "定子惯性功率";
  SI.Power powerInertiaRotor=0 "转子惯性功率";
  SI.Power lossPowerTotal=0 "总损耗功率";
  SI.Power lossPowerArmature=0 "电枢铜损";
  SI.Power lossPowerCore=0 "铁芯损耗";
  SI.Power lossPowerStrayLoad=0 "杂散负载损耗";
  SI.Power lossPowerFriction=0 "摩擦损耗";
  SI.Power lossPowerBrush=0 "刷子损耗";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
直流机器的部分功率平衡。
 </html>"));
end PartialPowerBalanceDCMachines;