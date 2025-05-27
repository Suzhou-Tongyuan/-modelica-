within Modelica.Electrical.Batteries.BatteryStacks;
model CellRCStack 
  "电池，其开路电压取决于电荷状态、自放电、内阻和一系列RC元件"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseCellStack(r0(final R=Ns*cellData.R0/Np), 
    redeclare Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData cellData);
  extends Modelica.Electrical.Batteries.Icons.TransientModel;
  Modelica.Electrical.Analog.Basic.Resistor resistor[cellData.nRC](
    final R=Ns*cellData.rcData.R/Np, 
    final T_ref=cellData.rcData.T_ref, 
    final alpha=cellData.rcData.alpha, 
    each final useHeatPort=true) 
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor[cellData.nRC](each v(
        fixed=true, each start=0), final C=Np*cellData.rcData.C/Ns) 
    annotation (Placement(transformation(extent={{30,30},{50,10}})));
equation
  assert(cellData.R0 > 0, "Ri 必须大于 sum(rcParameters.R)");
  assert(cellData.rcData[1].R > 0, "RC元件参数未定义！");
  //连接RC元件
  connect(resistor[1].p, r0.n) 
    annotation (Line(points={{30,-20},{30,0},{10,0}},color={0,0,255}));
  for k in 1:cellData.nRC loop
    connect(capacitor[k].p, resistor[k].p) 
      annotation (Line(points={{30,20},{30,-20}}, color={0,0,255}));
    connect(capacitor[k].n, resistor[k].n) 
      annotation (Line(points={{50,20},{50,-20}},          color={0,0,255}));
    connect(internalHeatPort, resistor[k].heatPort) 
      annotation (Line(points={{0,-80},{0,-40},{40,-40},{40,-30}}, color={191,0,0}));
    if k < cellData.nRC then
      connect(resistor[k].n, resistor[k + 1].p);
    end if;
  end for;
  connect(resistor[cellData.nRC].n, n) 
    annotation (Line(points={{50,-20},{50,0},{100,0}},color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>
通过一系列RC元件扩展模型<a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks.CellStack\">CellStack</a>，描述电池的瞬态行为。
</p>
<p>
此模型既可用于单个电池 <code>Ns=Np=1</code>，也可用于由相同电池构建的电池组。
</p>
<p>
有关详细信息，请参阅<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">概念</a>和<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">参数化</a>。
</p>
<h4>注意</h4>
<p>
参数记录数组<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a>包含在
参数记录<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData\">cellData</a>中必须指定。
</p>
<p>
总内阻是电阻器<code>r0</code>的阻值和RC元件电阻的总和。
</p>
</html>"));
end CellRCStack;