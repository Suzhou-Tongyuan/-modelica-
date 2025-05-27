within Modelica.Electrical.Machines.BasicMachines;
package InductionMachines "感应电机模型"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
该库含有基于空间矢量理论的感应电机模型：
<ul>
<li>IM_SquirrelCage: 带松鼠笼的感应电机</li>
<li>IM_SlipRing: 带绕线转子的感应电机</li>
</ul>
这些模型使用SpacePhasors库。
</html>", 
      revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Consulting & Electrical Engineering D-93049<br>
  RegensburgGermany<br>
  电子邮件： <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.02 2004/09/19 Anton Haumer</li>
  <li> v1.03 2004/09/24 Anton Haumer<br>
       在机械模型中保持感应电机的电感和电阻的一致命名</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       修改了命名和结构<br>
       发布到Modelica标准库 2.1</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       修复了支撑(以前是轴承)的一个错误</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       将ReluctanceRotor移动到 SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       移除了机械法兰支撑<br>
       以方便在将来的版本中实现三维框架</li>
  <li> v1.6.3 2005/11/25 Anton Haumer<br>
       更容易参数化SlipRing模型</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       为所有机器准备了条件热端口</li>
  </ul>
</html>"));
end InductionMachines;