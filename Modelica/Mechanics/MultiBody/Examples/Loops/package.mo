within Modelica.Mechanics.MultiBody.Examples;
package Loops "运动学环路的示例"
  extends Modelica.Icons.ExamplesPackage;
  annotation (Documentation(info="<html><p>
这个包包含不同的示例，用于展示如何对具有运动环的机械系统进行建模。
</p>
<h4>目录</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>模型</em></strong></th><th><strong><em>描述</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1a\">Engine1a</a><br>
             <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b\">Engine1b</a><br>
             <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b_analytic\">Engine1b_analytic</a></td>
      <td> 单缸发动机模型(Engine1a: 简单模型，无燃烧; Engine1b: 带燃烧模型;
      Engine1b_analytic: 与Engine1b相同但带解析循环处理)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\">EngineV6</a><br>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6_analytic\">EngineV6_analytic</a></td>
      <td> 6个缸，6个平面循环和1个自由度的V6发动机。
      第二版带有运动学循环的解析处理和CAD数据动画。<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6_small.png\">
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6_CAD_smaller.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar1\">Fourbar1</a></td>
      <td> 一个具有四个杆的运动学闭环(仅具有旋转副；5个非线性方程)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar1_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar2\">Fourbar2</a></td>
      <td> 一个具有四个杆的运动学闭环(具有球副；1个非线性方程)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar2_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar_analytic\">Fourbar_analytic</a></td>
      <td> 一个具有四个杆的运动学闭环(使用JointSSP连接件；非线性代数环的解析解)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Fourbar_analytic_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.PlanarFourbar\">PlanarFourbar</a></td>
      <td> 平面四杆机构，带有一个运动学闭环(使用RevolutePlanarLoopConstraint连接件)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/PlanarFourbar_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.PlanarLoops_analytic\">PlanarLoops_analytic</a></td>
      <td> 具有三个平面运动学闭环和一个自由度的机构，使用解析循环处理(使用JointRRR运动副)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/PlanarLoops_small.png\">
      </td>
  </tr>
</table>
</html>"));
end Loops;