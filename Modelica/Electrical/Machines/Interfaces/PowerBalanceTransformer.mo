within Modelica.Electrical.Machines.Interfaces;
record PowerBalanceTransformer "变压器的功率平衡"
  extends Modelica.Icons.Record;
  SI.Power power1 "一次侧功率";
  SI.Power power2 "二次侧功率";
  SI.Power lossPowerTotal=lossPower1 + lossPower2 + 
      lossPowerCore "总损耗功率";
  SI.Power lossPower1 "一次侧铜损";
  SI.Power lossPower2 "二次侧铜损";
  SI.Power lossPowerCore "铁心损耗";
  annotation (defaultComponentPrefixes="output", Documentation(info="<html>
变压器的功率平衡。
</html>"));
end PowerBalanceTransformer;