within Modelica.Electrical.Batteries.Interfaces;
expandable connector StackBusArrays "电池堆栈的测量信号总线，以矩阵形式排列"
  extends Modelica.Icons.SignalBus;
  parameter Integer Ns(final min=1) = 1 "串联电池的数量";
  parameter Integer Np(final min=1) = 1 "并联电池的数量";
  SI.Voltage v[Ns, Np] "电池电压";
  SI.Current i[Ns, Np] "电池电流";
  Real soc[Ns, Np] "电池的充电状态";
  SI.Power power[Ns, Np] "电池功率";
  SI.Power lossPower[Ns, Np] "电池损耗";
  SI.Temperature T[Ns, Np] "电池温度";
  annotation (Documentation(info="<html>
<p>
堆栈的测量总线，包含以矩阵形式排列的测量值数组，尺寸为<code>Ns</code>x<code>Np</code>，
与堆栈由电池构建的方式相同。
</p>
</html>"));
end StackBusArrays;