within Modelica.Electrical.Machines;
package SpacePhasors "带有空间矢量模型的库"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
该库包含了利用空间矢量理论的组件、块和函数。
</p>
<p>
空间矢量被定义为长度为2的向量，第一个元素表示空间矢量的实部，第二个元素表示空间矢量的虚部。
</p>
<p>
您可以查看关于空间矢量理论的简要概述：<a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">https://www.haumer.at/refimg/SpacePhasors.pdf</a>
</p>
</html>", 
        revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  echnical Consulting & Electrical Engineering<br>
  D-93049 RegensburgGermany
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.00 2004/09/16 Anton Haumer</li>
  <li> v1.30 2004/11/05 Anton Haumer<br>
       在 SpacePhasors.Blocks 中进行了多项改进</li>
  <li> v1.60 2005/11/03 Anton Haumer<br>
       添加了 Components.Rotator</li>
  <li> v1.6.1 2005/11/10 Anton Haumer<br>
       改进了变换和旋转</li>
  </ul>
</html>"));
end SpacePhasors;