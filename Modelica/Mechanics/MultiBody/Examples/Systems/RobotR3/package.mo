within Modelica.Mechanics.MultiBody.Examples.Systems;
package RobotR3 "一个基于Manutec r3机器人的机器人系统模型演示库"
  extends Modelica.Icons.ExamplesPackage;

  annotation (
    Documentation(info="<html>
<p>
这个包包含Manutec公司r3机器人的模型。这些模型用于展示如何先通过单独测试组件模型，再将它们组合在一起来构建复杂的机器人模型。
此外，它还展示了如何使用CAD数据进行动画制作。
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Systems/RobotR3/robot_kr15.png\"
alt=\"model Examples.Systems.RobotR3\">

<p>
以下是可用的模型：
</p>
<blockquote><pre>
<strong>OneAxis</strong>   Test one axis (controller, motor, gearbox).
<strong>FullRobot</strong> Test complete robot model.
</pre></blockquote>
<p>
r3机器人已不再生产。实际上，Manutec公司也已经不存在了。
这款机器人的参数是通过在DLR实验室的测量确定的。测量过程在以下文献中进行了描述：
</p>
<blockquote><pre>
Tuerk S. (1990): Zur Modellierung der Dynamik von Robotern mit
    rotatorischen Gelenken. Fortschrittberichte VDI, Reihe 8, Nr. 211,
    VDI-Verlag 1990.
</pre></blockquote>
<p>
该机器人模型的详细描述可见于
</p>
<blockquote><pre>
Otter M. (1995): Objektorientierte Modellierung mechatronischer
    Systeme am Beispiel geregelter Roboter. Dissertation,
    Fortschrittberichte VDI, Reihe 20, Nr. 147, VDI-Verlag 1995.
    This report can be downloaded as compressed postscript file
    from: <a href=\"http://www.robotic.dlr.de/Martin.Otter\">http://www.robotic.dlr.de/Martin.Otter</a>.
</pre></blockquote>
<p>
路径规划主要使用Modelica.Mechanics.Rotational.KinematicPTP模块以简单的方式进行。
用户通过定义每个轴的起始角度和结束角度来定义路径。在规划路径时，所有轴在给定最大关节速度和最大关节加速度的条件下，以尽可能快的速度移动。
Manutec公司的实际r3机器人采用了不同的路径规划策略。
现如今，机器人公司的路径规划算法涉及的内容要复杂得多。
</p>
<p>
为了获得更好的动画效果，我们使用了KUKA机器人的CAD数据，因为原始r3机器人的CAD数据不可用。
KUKA的CAD数据来源于<a href=\"http://www.kuka-robotics.com/\">KUKA</a>的公开数据。
由于相应KUKA机器人的尺寸与r3机器人相似但不完全相同，我们对r3机器人的数据(如臂长)进行了修改，以使其与CAD数据相匹配。
</p>
<p>
在这个模型中，每个轴都使用了一个简化的P-PI级联控制器。参数是通过手动调整的。原始的r3控制器更为复杂。使用简化控制器的原因是为了提供简化的模型示例。
</p>
</html>"));

end RobotR3;