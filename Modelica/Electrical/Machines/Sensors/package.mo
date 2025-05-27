within Modelica.Electrical.Machines;
package Sensors "机器建模传感器"
  extends Modelica.Icons.SensorsPackage;

  annotation (Documentation(info="<html>
此包含传感器在模拟机器时非常有用。
</html>", 
        revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  D-93049 RegensburgGermany<br>
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.03 2004/09/24 Anton Haumer</li>
  <li> v1.1  2004/10/01 Anton Haumer<br>
       更改了RotorDisplacementAngle</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       删除了机械法兰支撑，也删除了传感器RotorDisplacementAngle中的机械支撑<br>
       以方便在将来的发布中实现3D框架</li>
  </ul>
</html>"));
end Sensors;