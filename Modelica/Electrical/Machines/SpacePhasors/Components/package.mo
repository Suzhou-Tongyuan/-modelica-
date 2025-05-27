within Modelica.Electrical.Machines.SpacePhasors;
package Components "基本空间矢量模型"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
该库含有基本的空间矢量模型。<br>
电压空间矢量的实部和虚部分别为空间矢量连接器的电位 v_[2]；(隐含接地)<br>
电流空间矢量的实部和虚部分别为空间矢量连接器的电流 i_[2]；
必要时需要使用接地以使电流能够回流。
</html>", 
      revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  D-93049 RegensburgGermany
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.60 2005/11/03 Anton Haumer<br>
       添加了 Rotator</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       改进了变换和旋转</li>
  </ul>
</html>"));
end Components;