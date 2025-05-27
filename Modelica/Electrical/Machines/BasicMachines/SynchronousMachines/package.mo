within Modelica.Electrical.Machines.BasicMachines;
package SynchronousMachines "同步电机模型"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(info="<html>
这个库包含了基于空间矢量理论的同步机模型：
<ul>
<li>SM_PermanentMagnet：带有永磁励磁和阻尼笼的同步机</li>
<li>SM_ElectricalExcited：带有电励磁和阻尼笼的同步机</li>
<li>SM_ReluctanceRotor：带有磁阻转子和阻尼笼的感应电机<br>
即，具有不同气隙宽度的松鼠笼转子，其磁极是由于不同气隙宽度而产生的</li>
</ul>
这些模型使用SpacePhasors库。
<br><strong>请记住：</strong><br>
<ul>
<li>我们保持与电机相同的参考系统，即：<br>
    正转子位移角表示作为电动机，<br>
    具有正电功率消耗和正机械功率输出。</li>
<li>ElectricalAngle=p*MechanicalAngle</li>
<li>实轴=d轴<br>
    虚轴=q轴</li>
<li>磁轮感应的电压(d轴)位于q轴。</li>
</ul>
</html>", 
      revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.02  2004/09/19 Anton Haumer</li>
  <li> v1.03  2004/09/24 Anton Haumer<br>
       机器模型中电感和电阻的一致命名</li>
  <li> v1.1   2004/10/01 Anton Haumer<br>
       更改了命名和结构<br>
       发布到Modelica标准库2.1</li>
  <li> v1.2   2004/10/27 Anton Haumer<br>
       修复了一个与支撑(以前称为轴承)相关的错误</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       ReluctanceRotor移动到SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       删除了机械法兰支撑<br>
       以便在将来的版本中实现3D框架时更容易</li>
  <li> v1.52  2005/10/12 Anton Haumer<br>
       添加了SM_ElectricalExcited</li>
  <li> v1.53  2005/10/14 Anton Haumer<br>
       引入了不对称的Synchronous Machines阻尼笼</li>
  <li> v1.6.2 2005/10/23 Anton Haumer<br>
       可选择的Synchronous Machines阻尼笼</li>
  <li> v1.7.1 2006/02/06 Anton Haumer<br>
       更改了一些同步机的命名，不影响现有模型</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       所有机器的条件热端口</li>
  </ul>
</html>"));
end SynchronousMachines;