within Modelica.Electrical.Machines.BasicMachines;
package DCMachines "直流电机模型"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
该库含有以下直流电机模型：
<ul>
<li>DC_PermanentMagnet: 带永磁激励的直流电机</li>
<li>DC_ElectricalExcited: 带电励磁或分开励磁的直流电机</li>
<li>DC_SeriesExcited: 带串联励磁的直流电机</li>
</ul>
</html>", 
      revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
   D-93049 RegensburgGermany<br>
  电子邮件: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.02 2004/09/19 Anton Haumer</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       添加了带串联励磁的直流电机</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       修改了命名和结构<br>
       发布到Modelica标准库 2.1</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       修复了一个与支撑(原名为轴承)相关的错误</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       移除了机械法兰支撑<br>
       以便在将来的版本中更轻松地实现3D框架</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       为所有电机添加了条件热端口</li>
  </ul>
</html>"));
end DCMachines;