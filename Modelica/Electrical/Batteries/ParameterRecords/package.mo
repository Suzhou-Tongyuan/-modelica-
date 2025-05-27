within Modelica.Electrical.Batteries;
package ParameterRecords "电池参数记录"
  extends Modelica.Icons.RecordsPackage;

  annotation (Documentation(info="<html>
<p>
电池参数记录
</p>
<h4>注意</h4>
<p>
用户可以通过创建单独的参数记录，从基本记录<code>CellData</code>扩展，轻松地构建不同类型的电池集合。
在每个单独的参数记录中不要忘记添加<code>annotation(defaultComponentPrefixes=\"parameter\");</code>。
</p>
</html>"));
end ParameterRecords;