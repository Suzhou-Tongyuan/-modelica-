within Modelica.Electrical.QuasiStatic.Machines;
package BasicMachines "基本机械模型"
  extends Modelica.Icons.Package;
  annotation (Icon(graphics={
        Rectangle(
          origin={0,14.817}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-54.179,-59.817},{65.821,60.183}}), 
        Rectangle(
          origin={5.821,15}, 
          fillColor={128,128,128}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{-80,-60},{-60,60}}), 
        Rectangle(
          origin={5.821,15}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.HorizontalCylinder, 
          extent={{60,-10},{80,10}}), 
        Rectangle(
          origin={5.821,15}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          extent={{-60,50},{20,70}}), 
        Polygon(
          origin={5.821,15}, 
          fillPattern=FillPattern.Solid, 
          points={{-70,-90},{-60,-90},{-30,-20},{20,-20},{50,-90},{60,-90},{
              60,-100},{-70,-100},{-70,-90}})}), Documentation(info="<html>
此包含组件用于基于空间矢量理论建模准静态电感机械：
<ul>
<li>package InductionMachines: 三相感应电机的准静态模型</li>
<li>package SynchronousMachines: 三相同步电机的准静态模型</li>
<li>package Transformers: 准静态三相变压器（详细文档见子包）</li>
<li>package Components: 用于准静态建模机械和变压器的组件</li>
</ul>
</html>"));
end BasicMachines;