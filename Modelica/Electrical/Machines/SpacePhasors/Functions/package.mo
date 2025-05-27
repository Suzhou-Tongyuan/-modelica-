within Modelica.Electrical.Machines.SpacePhasors;
package Functions "用于空间相量转换的函数"
  extends Modelica.Icons.FunctionsPackage;

  annotation (Documentation(info="<html>
该库含有用于计算的空间相量转换函数：
<ul>
<li>ToSpacePhasor：将一组三相值转换为空间相量和零序系统</li>
<li>FromSpacePhasor：将空间相量和零序系统转换为一组三相值</li>
<li>Rotator：旋转空间相量(从一个坐标系到另一个坐标系)</li>
<li>ToPolar：将空间相量从直角坐标转换为极坐标</li>
<li>FromPolar：将空间相量从极坐标转换为直角坐标</li>
</ul>
<p>
空间相量被定义为长度为2的向量，
第一个元素表示空间相量的实部，第二个元素表示空间相量的虚部。
</p>
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

  <dt><strong>版本说明：</strong></dt>
  <dd>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       改进了转换和旋转</li>
  </ul>
  </dd>

</dl>
</html>"));
end Functions;