within Modelica.Electrical.QuasiStatic.Machines.BasicMachines;
package Transformers "技术三相变压器库"
  extends Modelica.Icons.Package;
  annotation (Documentation(info="<html>
此包含组件用于建模技术三相变压器：
<ul>
<li>Transformer: 变压器模型，用于选择连接方式 / 矢量组</li>
<li>Yy: 主接线 Y / 次接线 y 的变压器</li>
<li>Yd: 主接线 Y / 次接线 d 的变压器</li>
<li>Yz: 主接线 Y / 次接线锯齿形的变压器</li>
<li>Dy: 主接线 D / 次接线 y 的变压器</li>
<li>Dd: 主接线 D / 次接线 d 的变压器</li>
<li>Dz: 主接线 D / 次接线锯齿形的变压器</li>
</ul>
<p>
变压器通过理想变压器进行建模，添加了主次绕组电阻和漏感。
所有变压器都是从基本模型 <em>PartialTransformer</em> 继承，并添加了主次连接。
<strong>VectorGroup</strong> 定义了主次电压之间的相位差，由相位差除以 30 度表示
（即，时钟面上的小时数）。因此，每个变压器由两个字符和两位数标识，
例如，Yd11 ... 主接线 Y（星型），次接线 d（三角形），矢量组 11（相位差 330 度）<br>
通过“超级模型” <em>Transformer</em>，用户可以选择主次连接以及矢量组。
它计算绕组比例以及主次绕组电阻和漏感，将它们等量地分配到主次绕组，从以下参数开始：
</p>
<ul>
<li>名义频率</li>
<li>主电压（有效线间）</li>
<li>次电压（有效线间）</li>
<li>名义视在功率</li>
<li>阻抗电压降</li>
<li>短路铜损耗</li>
</ul>
<strong>阻抗电压降</strong> 表示（绝对值的）额定负载（电流）时的电压降以及
我们必须施加到主绕组上的电压，以达到短路次绕组中的额定电流。
<p>
<strong>请注意</strong> 正确接地整个电路的主次部分。<br>
如果连接不是三角形（D 或 d），主次星点可用作连接器。<br>
<strong>在某些情况下（例如 Yy 或 Yz），即使源和/或负载的星点已接地，
也可能需要接地变压器的一个星点；您可以使用合理高的接地电阻。</strong>
</p>
<strong>限制和假设：</strong><br>
<ul>
<li>相数限制为 3，因此定义为常数 m=3</li>
<li>三相或磁环的对称性</li>
<li>忽略饱和，即，电感是常数</li>
<li>忽略磁化电流</li>
<li>忽略磁化损耗</li>
<li>忽略额外的（漏）损耗</li>
</ul>
<strong>进一步发展：</strong>
<ul>
<li>建模磁化电流，包括饱和</li>
<li>绕组电阻的温度依赖性</li>
</ul>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  技术咨询与电气工程<br>
  德国，雷根斯堡，93049<br>
  电子邮件： <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
</html>", 
      revisions="<html>
  <ul>
  <li> v1.0.0 2006/11/19 Anton Haumer<br>
       第一个稳定版本发布</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       为所有机器添加条件 ThermalPort</li>
  </ul>
</html>"), 
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
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
          lineColor={213,170,255}, 
          fillColor={213,170,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-88,-46},{-52,26}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={170,213,255}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-94,-38},{-46,18}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={213,170,255}, 
          fillColor={213,170,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-28,-46},{8,26}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={170,213,255}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{-34,-38},{14,18}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={213,170,255}, 
          fillColor={213,170,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{32,-46},{68,26}}), 
        Rectangle(
          origin={10,10}, 
          lineColor={170,213,255}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          extent={{26,-38},{74,18}})}));
end Transformers;