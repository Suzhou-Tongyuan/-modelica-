within Modelica.Magnetic;
package FluxTubes "利用块状磁网络的电磁设备建模库"

  import Modelica.Constants.pi;
  import Modelica.Constants.mu_0;

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
这个库包含了电磁设备与集总磁网络的建模组件。这些模型既适用于设备磁子系统的粗略设计，也适用于与邻近子系统一起在系统级进行有效的动态仿真。目前，提供了<em>平移</em>电磁和电动力执行器的组件和建模实例。如果需要，这些组件可以适应<em>旋转</em>电机的网络建模.
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide\">User's Guide</a> 简要介绍了</strong>磁通管</strong>的基本概念，总结了集总磁网络模型中</strong>磁阻力</strong>的计算，并列出<strong>参考文献</strong>.
</p>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples\">实例</a> 用不同应用领域的简单模型说明磁力网络模型的用法.
</p>

<p>
Copyright &copy; 2005-2020, Modelica Association and contributors
</p>
</html>", revisions="<html>
<p>
见 <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.ReleaseNotes\">版本说明</a>
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
    Polygon(
      origin={-3.75,0.0}, 
      fillColor={160,160,164}, 
      fillPattern=FillPattern.Solid, 
      points={{33.75,50.0},{-46.25,50.0},{-46.25,-50.0},{33.75,-50.0},{33.75,-30.0},{-21.25,-30.0},{-21.25,30.0},{33.75,30.0}}), 
    Ellipse(
      origin={10.4708,41.6771}, 
      extent={{-86.0,-24.0},{-78.0,-16.0}}), 
    Line(
      origin={10.4708,41.6771}, 
      points={{-64.0,-20.0},{-78.0,-20.0}}), 
    Line(
      origin={10.4708,41.6771}, 
      points={{-64.1812,-31.6229},{-32.0,-40.0}}), 
    Line(
      origin={10.4708,41.6771}, 
      points={{-64.0,-20.0},{-32.0,-28.0}}), 
    Ellipse(
      origin={10.4708,41.6771}, 
      extent={{-86.0,-60.0},{-78.0,-52.0}}), 
    Line(
      origin={10.4708,41.6771}, 
      points={{-64.0,-56.0},{-78.0,-56.0}}), 
    Line(
      origin={10.4708,41.6771}, 
      points={{-64.0,-44.0},{-32.0,-52.0}}), 
    Line(
      origin={10.4708,41.6771}, 
      points={{-64.0,-56.0},{-32.0,-64.0}}), 
    Rectangle(
      origin={62.5,0.0}, 
      fillColor={160,160,164}, 
      fillPattern=FillPattern.Solid, 
      extent={{-12.5,-50.0},{12.5,50.0}})}));
end FluxTubes;