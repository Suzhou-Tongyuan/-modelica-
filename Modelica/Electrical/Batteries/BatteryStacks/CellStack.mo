within Modelica.Electrical.Batteries.BatteryStacks;
model CellStack 
  "电池，其开路电压取决于电荷状态、自放电和内阻"
  extends Modelica.Electrical.Batteries.BaseClasses.BaseCellStack(r0(final R=Ns*cellData.Ri/Np), 
    redeclare Modelica.Electrical.Batteries.ParameterRecords.CellData cellData);
equation
  connect(r0.n, n) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>
该电池模型的开路电压(OCV)取决于电荷状态(SOC)、自放电和内阻，这是在部分<a href=\"modelica://Modelica.Electrical.Batteries.BaseClasses.BaseCellStack\">BaseCellStack</a> 中实现的。
</p>
<p>
此模型既可用于单个电池<code>Ns=Np=1</code>，也可用于由相同电池构建的电池组。
</p>
<p>
有关详细信息，请参阅<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Concept\">概念</a>和<a href=\"modelica://Modelica.Electrical.Batteries.UsersGuide.Parameterization\">参数化</a>。
</p>
<h4>注意</h4>
<p>
在参数记录<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a>中包含的参数记录数组<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a>被忽略。
</p>
</html>"));
end CellStack;