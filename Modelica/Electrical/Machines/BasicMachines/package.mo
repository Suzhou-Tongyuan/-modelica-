within Modelica.Electrical.Machines;
package BasicMachines "基本机械模型"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>该库含有用于建模电机的组件，特别是基于空间矢量理论的三相感应电机：
<ul>
<li>package InductionMachines: 三相感应电机的模型</li>
<li>package SynchronousMachines: 三相同步电机的模型</li>
<li>package DCMachines: 不同励磁方式的直流电机模型</li>
<li>package Transformers: 三相变压器(详细文档请参见子包)</li>
<li>package Components: 用于建模机械和变压器的组件</li>
</ul>
</p>
<p>感应电机模型使用SpacePhasors库。</p>
</html>", 
        revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering D-93049 <br>
  RegensburgGermany<br>
  电子邮件： <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</dl>
  <ul>
  <li> v1.00  2004/09/16 Anton Haumer</li>
  <li> v1.01  2004/09/18 Anton Haumer<br>
       将机械模型的公共方程从机械模型中移到PartialMachine中</li>
  <li> v1.02  2004/09/19 Anton Haumer<br>
       为机械类型添加了新的库结构<br>
       添加了直流电机模型</li>
  <li> v1.03  2004/09/24 Anton Haumer<br>
       添加了串联励磁的直流电机</li>
  <li> v1.1   2004/10/01 Anton Haumer<br>
       修改了命名和结构<br>
       发布到Modelica标准库 2.1</li>
  <li> v1.2   2004/10/27 Anton Haumer<br>
       修复了支撑(以前是轴承)的一个错误</li>
  <li> v1.3.2 2004/11/10 Anton Haumer<br>
       将ReluctanceRotor移动到SynchronousMachines</li>
  <li> v1.4   2004/11/11 Anton Haumer<br>
       移除了机械法兰支撑<br>
       以方便在将来的版本中实现三维框架</li>
  <li> v1.53  2005/10/14 Anton Haumer<br>
       引入了用于同步电机的非对称阻尼笼</li>
  <li> v1.6.2 2005/10/23 Anton Haumer<br>
       为同步电机引入了可选的阻尼笼</li>
  <li> v1.6.3 2005/11/25 Anton Haumer<br>
       更容易参数化 InductionMachines.IM_SlipRing 模型</li>
  <li> v1.7.1 2006/02/06 Anton Haumer<br>
       更改了同步电机的一些命名，不影响现有模型</li>
  <li> v2.1.3 2010/02/10 Anton Haumer<br>
       为 SquirrelCage 和 DamperCage 准备了条件热端口</li>
  <li> v2.2.0 2011/02/10 Anton Haumer<br>
       为所有机器准备了条件热端口</li>
  </ul>
</html>"), 
         Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          origin={2.835,10}, 
          fillColor={0,128,255}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-60,-60},{60,60}}), 
        Rectangle(
          origin={2.835,10}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-80,-60},{-60,60}}), 
        Rectangle(
          origin={2.835,10}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{60,-10},{80,10}}), 
        Rectangle(
          origin={2.835,10}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          extent={{-60,50},{20,70}}), 
        Polygon(
          origin={2.835,10}, 
          fillPattern=FillPattern.Solid, 
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{
              60,-100},{-70,-100},{-70,-90}})}));
end BasicMachines;