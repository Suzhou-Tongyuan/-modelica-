within Modelica.Mechanics.MultiBody.UsersGuide;
class Contact "联系"
  extends Modelica.Icons.Contact;

  annotation (Documentation(info="<html>
<h4>模型库负责人</h4>

<p>
<strong>Jakub Tobolar</strong> 和 <a href=\"http://www.robotic.dlr.de/Martin.Otter/\" target=\"\"><strong>Martin Otter</strong></a><br>
德国宇航中心(DLR)<br>
系统动力学与控制技术研究所(DLR-SR) <br>
奥伯普法芬霍芬研究中心<br>
D-82234 Wessling<br>
德国
</p>

<h4><strong>致谢</strong></h4>
<ul><li>
处理一类过度定义的、一致的微分代数方程组(即方程数量多于未知数)的核心思想，即通过符号转换算法，
是与之前在瑞典隆德的达索系统AB公司的Hilding Elmqvist和Sven Erik Mattsson共同开发的。
多体库在很大程度上依赖于这一特性，这是一个真正\"面向对象\"的多体系统库的前提条件，
使得其中的组件可以以任何有意义的方式连接在一起。
</li>
<li>
六缸V6发动机的Examples.Loops.EngineV6演示案例，其中有6个平面回路和1个自由度，
来自Hilding Elmqvist和Sven Erik Mattsson。</li>
<li>
Modelica.Mechanics.MultiBody.Forces.LineForceWithMass基于瑞典斯德哥尔摩皇家理工学院
Johan Andreasson的Modelica VehicleDynamics库中的模型\"RelativeDistance\"。</li>
<li>
一维组件(Parts.Rotor1D、Parts.BevelGear1D、Mounting1D)和Joints.GearConstraints来自Christian Schweiger。</li>
<li>
该库的设计基于欧盟RealSim项目(多物理系统设计的实时模拟)的工作，
该项目得到欧洲委员会在信息社会技术(IST)计划下的合同编号为IST 1999-11979的资助。</li>
</ul></html>"));
end Contact;