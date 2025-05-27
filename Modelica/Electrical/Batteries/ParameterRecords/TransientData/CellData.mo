within Modelica.Electrical.Batteries.ParameterRecords.TransientData;
record CellData "瞬态电池单元的参数"
  extends Modelica.Electrical.Batteries.ParameterRecords.CellData(R0=Ri - sum(rcData.R));
  extends Modelica.Electrical.Batteries.Icons.TransientCellRecord;
  parameter Integer nRC=1 "RC元件的数量" 
    annotation (Dialog(group="RC元件"), Evaluate=true);
  parameter RCData rcData[nRC]= 
    {Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData(R=0, C=0)} "RC元件的参数" 
    annotation (Dialog(group="RC元件"), Placement(transformation(extent={{-10,0},{10,20}})));
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>收集电池单元的参数:</p>
<ul>
<li>名义电荷</li>
<li>OCV与SOC特性</li>
<li>内阻; 可以从OCVmax / 短路电流（在OCVmax处）计算得出</li>
<li>包含RC元件的电池模型的记录数组<code>rcData</code></li>
</ul>
<h4>注意</h4>
<p>
如果<code>useLinearSOCDependency=true</code>，则内部将从<code>OCVmax, OCVmin, SOCmax, SOCmin</code>建立OCV与SOC表。<br>
否则，必须指定OCV与SOC表：第1列=升序的SOC值，第2列=相应于OCVmax的OCV值。
</p>
<p>
数组<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a>的大小必须定义为参数<code>nRC</code>。
电阻之和<code>rcData.R</code>不能超过总内阻<code>Ri</code>。
</p>
</html>"));
end CellData;