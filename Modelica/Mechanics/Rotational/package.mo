within Modelica.Mechanics;
package Rotational "用于建立一维转动机械系统模型的库"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html><p>
<strong>Rotational</strong>库是一个<strong>免费</strong>的Modelica包，这个包中提供了一维旋转机械组件。
可以使用户以便捷的方式建立具有摩擦损失的传动系统。下图展示了一个典型的简单示例：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/driveExample.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
如要了解这个库需重点阅读以下部分：
</p>
<ul><li>
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide\" target=\"\">Rotational.UsersGuide</a>：就Rotational库中最重要的方面进行了讨论</li>
<li>
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples\" target=\"\">Rotational.Examples</a>：就Rotational库的案例进行演示</li>
</ul><p>
在Modelica标准库的3.0版本中，库的基本设计发生了变化：在3.0版本之前，支撑连接器可以连接也可以不连接。在3.0版本中，支撑连接器被重命名为\"<strong>support</strong>\"并且
通过参数\"useSupport\"启用此连接器。如果启用了支撑连接器，则必须连接它；如果未启用，则可不用连接它。
</p>
<p>
在Modelica标准库的3.2版本中，Rotational库的所有<strong>损耗(dissipative)</strong>组件都添加了一个可选的<strong>heatPort</strong>连接器，用于以热的形式传输损耗的能量。
此连接器通过参数\"useHeatPort\"启用。如果启用了heatPort连接器，则必须连接它；如果未启用，则不能连接它。无论heatPort是否启用，损耗功率都可从新变量\"<strong>lossPower</strong>\"中获得(如果热从heatPort流出，则为正)。例如，请参阅<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.HeatLosses\" target=\"\">Examples.HeatLosses</a>。
</p>
<p>
版权所有©1998-2020，Modelica协会及其贡献者
</p>
</html>",revisions=""), Icon(
    coordinateSystem(preserveAspectRatio=true, 
      extent={{-100.0,-100.0},{100.0,100.0}}), 
      graphics={
    Line(origin={-2.0,46.0}, 
      points={{-83.0,-66.0},{-63.0,-66.0}}), 
    Line(origin={29.0,48.0}, 
      points={{36.0,-68.0},{56.0,-68.0}}), 
    Line(origin={-2.0,49.0}, 
      points={{-83.0,-29.0},{-63.0,-29.0}}), 
    Line(origin={29.0,52.0}, 
      points={{36.0,-32.0},{56.0,-32.0}}), 
    Line(origin={-2.0,49.0}, 
      points={{-73.0,-9.0},{-73.0,-29.0}}), 
    Line(origin={29.0,52.0}, 
      points={{46.0,-12.0},{46.0,-32.0}}), 
    Line(origin={-0.0,-47.5}, 
      points={{-75.0,27.5},{-75.0,-27.5},{75.0,-27.5},{75.0,27.5}}), 
    Rectangle(origin={13.5135,76.9841}, 
      lineColor={64,64,64}, 
      fillColor={255,255,255}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-63.5135,-126.9841},{36.4865,-26.9841}}, 
      radius=10.0), 
    Rectangle(origin={13.5135,76.9841}, 
      lineColor={64,64,64}, 
      extent={{-63.5135,-126.9841},{36.4865,-26.9841}}, 
      radius=10.0), 
    Rectangle(origin={-3.0,73.0769}, 
      lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{-87.0,-83.0769},{-47.0,-63.0769}}), 
    Rectangle(origin={22.3077,70.0}, 
      lineColor={64,64,64}, 
      fillColor={192,192,192}, 
      fillPattern=FillPattern.HorizontalCylinder, 
      extent={{27.6923,-80.0},{67.6923,-60.0}})}));
end Rotational;