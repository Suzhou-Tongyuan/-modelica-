within Modelica.Electrical.Machines;
package Examples "测试示例"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
这个库包含了电机的测试示例。
</html>", 
        revisions="<html>
<dl>
  <dt><strong>主要作者:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering D-93049<br>
  RegensburgGermany<br>
  电子邮件:<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.01 2004/09/18 Anton Haumer<br>
       适应改进的MoveToRotational</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       添加了直流电机的示例</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       使用Sensors.CurrentRMSSensor<br>
       添加了串激励直流电机的示例</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       改变了命名和结构<br>
       发布到Modelica标准库2.1</li>
  <li> v1.3.1 2004/11/06 Anton Haumer<br>
       在Utilities.VfController中做了一些小改动</li>
  <li> v1.52 2005/10/12 Anton Haumer<br>
       新增了电气激励同步电机的示例</li>
  <li> v1.6.1 2004/11/22 Anton Haumer<br>
       引入了Utilities.TerminalBox</li>
  <li> v2.1.2 2010/02/09 Anton Haumer<br>
       包括了新的示例(IMC_Transformer, DC_Comparison)</li>
  </ul>
</html>"));
end Examples;