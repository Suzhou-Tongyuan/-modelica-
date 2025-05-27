within Modelica.Electrical.Batteries.Interfaces;
expandable connector StackBus "电池堆栈的测量信号总线"
  extends Modelica.Icons.SignalBus;
  parameter Integer Ns(final min=1) = 1 "串联电池的数量";
  parameter Integer Np(final min=1) = 1 "并联电池的数量";
  CellBus cellBus[Ns, Np] "电池总线";
  annotation (Documentation(info="<html>
<p>
堆栈的测量总线，包含每个电池一个<a href=\"modelica://Modelica.Electrical.Batteries.Interfaces.CellBus\">cellBus</a>。
</p>
</html>"));
end StackBus;