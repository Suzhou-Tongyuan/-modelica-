within Modelica.Electrical.Machines;
package Interfaces "空间矢量连接器和电机基类"
  extends Modelica.Icons.InterfacesPackage;

  annotation (Documentation(info="<html>
此包包含空间相量连接器和用于机器模型的部分模型。
</html>", 
        revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  技术咨询与电气工程<br>
  D-93049 雷根斯堡 <br>德国<br>
  电子邮箱： <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.01 2004/09/18 Anton Haumer<br>
       将公共方程从机器模型移至PartialMachine</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       添加了PartialDCMachine</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       修复了支持（原支撑）的bug</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       移除了机械接口支撑<br>
       以简化未来版本中3D坐标系的实现</li>
  <li> v1.51 Beta 2005/02/01 Anton Haumer<br>
       将参数polePairs更改为Integer</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       为所有机器添加了条件热端口</li>
  </ul>
</html>"));
end Interfaces;