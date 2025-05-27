within Modelica.Electrical.Batteries.Interfaces;
expandable connector CellBus "单个电池的测量信号总线"
  extends Modelica.Icons.SignalSubBus;
  SI.Voltage v "电池电压";
  SI.Current i "电池电流";
  Real soc "电池的充电状态";
  SI.Power power "电池功率";
  SI.Power lossPower "电池损耗";
  SI.Temperature T "电池温度";
  annotation (Documentation(info="<html>
<p>
单个电池的测量总线。
</p>
</html>"));
end CellBus;