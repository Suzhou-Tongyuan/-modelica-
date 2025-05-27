within Modelica.Electrical.Machines.BasicMachines;
package Transformers "用于技术三相变压器的库"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
该包含有模型技术三相变压器的组件：
<ul>
<li>Transformer：选择连接/矢量组的变压器模型</li>
<li>Yy：一次侧为Y接法/二次侧为y接法的变压器</li>
<li>Yd：一次侧为Y接法/二次侧为d接法的变压器</li>
<li>Yz：一次侧为Y接法/二次侧为zig-zag接法的变压器</li>
<li>Dy：一次侧为D接法/二次侧为y接法的变压器</li>
<li>Dd：一次侧为D接法/二次侧为d接法的变压器</li>
<li>Dz：一次侧为D接法/二次侧为zig-zag接法的变压器</li>
</ul>
<p>
变压器由理想变压器建模，加上一次侧和二次侧绕组电阻和漏电感。<br>
所有变压器都继承自基本模型<em>PartialTransformer</em>，添加了一次侧和二次侧的连接。<br>
<strong>VectorGroup</strong>定义了一次侧和二次侧电压之间的相位差，用数字相位差/30度表示(即，时钟上的小时数)。
因此，每个变压器由两个字符和两位数组成，例如，Yd11...一次侧连接为Y(星型)，二次侧连接为d(三角形)，矢量组为11(相位差330度)<br>
用户可以使用“超级模型”<em>Transformer</em>选择一次侧和二次侧的连接以及矢量组。<br>
它计算绕组比、一次侧和二次侧绕组电阻和漏电感，并将它们均匀分布到一次侧和二次侧绕组中，从以下参数计算：
</p>
<ul>
<li>额定频率</li>
<li>一次电压(RMS线对线)</li>
<li>二次电压(RMS线对线)</li>
<li>额定视在功率</li>
<li>阻抗电压降</li>
<li>短路铜损耗</li>
</ul>
<strong>阻抗电压降</strong>表示(绝对值的)额定负载(电流)的电压降，以及我们必须施加到一次绕组上的电压，以在短路的二次绕组中达到额定电流。
<p>
<strong>请注意</strong>对整个电路的一次侧和二次侧进行适当接地。<br>
一次侧和二次侧的星点作为连接器可用，如果连接不是三角形(D或d)。<br>
<strong>在某些情况下(如Yy或Yz)，即使源和/或负载的星点接地，也可能需要接地变压器的一个星点；
您可以使用合理高的接地电阻。</strong>
</p>
<p><strong>限制和假设：</strong>
<li>相数限制为三，因此定义为常量m=3</li>
<li>三相或磁环的对称性</li>
<li>忽略饱和，即，电感是恒定的</li>
<li>忽略磁化电流</li>
<li>忽略磁化损耗</li>
<li>忽略附加(漏)损耗</li>
</p>
<p><strong>进一步发展：</strong>
<li>建模磁化电流，包括饱和</li>
<li>绕组电阻的温度依赖性</li>
</p>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  D-93049 RegensburgGermany<br>
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
</html>", 
      revisions="<html>
  <li> v1.0.0 2006/11/19 Anton Haumer<br>
       第一个稳定版本发布</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       为所有机器添加了条件ThermalPort</li>
</html>"), 
       Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          origin={10,10}, 
          fillColor={135,135,135}, 
          fillPattern=FillPattern.VerticalCylinder, 
          points={{-80,50},{-60,30},{-60,-50},{-80,-70},{-80,50}}), 
        Polygon(
          origin={10,10}, 
          fillColor={135,135,135}, 
          fillPattern=FillPattern.VerticalCylinder, 
          points={{60,50},{40,30},{40,-50},{60,-70},{60,50}}), 
        Polygon(
          origin={10,10}, 
          fillColor={135,135,135}, 
          fillPattern=FillPattern.VerticalCylinder, 
          points={{-10,40},{-20,30},{-20,-50},{-10,-60},{0,-50},{0,30},{-10, 
              40}}), 
        Polygon(
          origin={10,10}, 
          fillColor={135,135,135}, 
          fillPattern=FillPattern.VerticalCylinder, 
          points={{-80,50},{60,50},{40,30},{0,30},{-10,40},{-20,30},{-60,30}, 
              {-80,50}}), 
        Polygon(
          origin={10,10}, 
          fillColor={135,135,135}, 
          fillPattern=FillPattern.VerticalCylinder, 
          points={{-80,-70},{60,-70},{40,-50},{0,-50},{-10,-60},{-20,-50},{
              -60,-50},{-80,-70}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={128,0,255}, 
          fillColor={128,0,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-88,-46},{-52,26}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={0,128,255}, 
          fillColor={0,128,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-94,-38},{-46,18}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={128,0,255}, 
          fillColor={128,0,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-28,-46},{8,26}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={0,128,255}, 
          fillColor={0,128,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-34,-38},{14,18}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={128,0,255}, 
          fillColor={128,0,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{32,-46},{68,26}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={0,128,255}, 
          fillColor={0,128,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{26,-38},{74,18}})}));
end Transformers;