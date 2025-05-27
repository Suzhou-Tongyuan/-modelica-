within Modelica.Electrical.Machines.BasicMachines;
package Components "机器组件，如气隙"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>该库含有用于建模电气机器的组件，特别是基于空间矢量理论的三相感应电机。
这些模型使用了SpacePhasors库。</p>
</html>", 
      revisions="<html>
<dl>
  <dt><strong>主要作者:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  D-93049 RegensburgGermany<br>
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.02 2004/09/19 Anton Haumer<br>
       添加了AirGapDC模型</li>
  <li> v1.2  2004/10/27 Anton Haumer<br>
       修复了支撑(以前是轴承)的错误</li>
  <li> v1.52 2005/10/12 Anton Haumer<br>
       添加了电激励</li>
  <li> v1.53 Beta 2005/10/14 Anton Haumer<br>
       引入了不对称的同步机阻尼笼</li>
  <li> v2.1.3 2010/02/10 Anton Haumer<br>
       准备好了SquirrelCage和DamperCage的ConditionalHeatPort</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       所有机器的条件热端口</li>
  </ul>
</html>"));
end Components;