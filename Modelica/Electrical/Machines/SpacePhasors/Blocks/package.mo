within Modelica.Electrical.Machines.SpacePhasors;
package Blocks "空间矢量转换块"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
该库含有用于控制器的空间矢量转换块：
<ul>
<li>ToSpacePhasor：将一组多相值转换为空间矢量和零序系统</li>
<li>FromSpacePhasor：将空间矢量和零序系统转换为一组多相值</li>
<li>Rotator：旋转空间矢量(从一个坐标系旋转到另一个坐标系)</li>
<li>ToPolar：将空间矢量从直角坐标转换为极坐标</li>
<li>FromPolar：将空间矢量从极坐标转换为直角坐标</li>
</ul>
<p>
空间矢量被定义为长度为2的向量，
第一个元素表示空间矢量的实部，第二个元素表示空间矢量的虚部。
</p>
</html>", 
      revisions="<html>
  <dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.30 2004/11/05 Anton Haumer<br>
       在SpacePhasors.Blocks中进行了多项改进</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       改进了变换和旋转</li>
  </ul>
</html>"));
end Blocks;