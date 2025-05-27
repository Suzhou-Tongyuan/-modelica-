within Modelica.Mechanics.MultiBody.Examples;
package Elementary "演示多体库的各种特点的基本示例"
  extends Modelica.Icons.ExamplesPackage;
  annotation (Documentation(info="<html>
<p>
这个包中包含基本的示例模型来演示多体库的用法
</p>
<h4>目录</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>模型</em></strong></th><th><strong><em>描述</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum\">DoublePendulum</a><br>
          <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulumInitTip\">DoublePendulumInitTip</a></td>
      <td> 具有两个旋转关节和两个构件的简单双摆模型。在DoublePendulumInitTip中，摆动件尖端的位置是给定的
           而不是按照常规对摆动件的角度进行初始化<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulumSmall.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.ForceAndTorque\">ForceAndTorque</a></td>
      <td> 对于Forces.ForceAndTorque模块的使用演示。<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ForceAndTorque_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.FreeBody\">FreeBody</a></td>
      <td> 在双弹簧连接下的自由构件。<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/FreeBody_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.InitSpringConstant\">InitSpringConstant</a></td>
      <td> 给定弹簧常数，使系统在给定位置下处于稳定状态。
      <br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/InitSpringConstant_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.LineForceWithTwoMasses\">LineForceWithTwoMasses</a></td>
      <td> 演示了使用Joints.Assemblies.JointUPS 和Forces.LineForceWithTwoMasses模块来分析双质量块的线性力
           <br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/LineForceWithTwoMasses_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum\">Pendulum</a></td>
      <td> 具有一个转动关节和一个构件的简单单摆模型。<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Pendulum_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PendulumWithSpringDamper\">PendulumWithSpringDamper</a></td>
      <td> 简单弹簧-阻尼-质量系统<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PendulumWithSpringDamper_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravity\">PointGravity</a></td>
      <td> 在点重力场中的两个物体<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravity_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravityWithPointMasses\">PointGravityWithPointMass</a></td>
      <td> 在点重力场中的两个质量点(忽略了物体的旋转)<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravityWithPointMasses_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.PointGravityWithPointMasses2\">PointGravityWithPointMasses2</a></td>
      <td> 在点重力场中刚性连接的点质量<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PointGravityWithPointMasses2_small.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheel\">RollingWheel</a></td>
      <td> 带有初始速度的单个轮在地面上滚动<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/RollingWheel.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheelSetDriving\">RollingWheelSetDriving</a></td>
      <td> 由扭矩驱动的滚动轮组<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/RollingWheelSetDriving.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.RollingWheelSetPulling\">RollingWheelSetPulling</a></td>
      <td> 被力拉动的滚轮组<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/RollingWheelSetPulling.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringDamperSystem\">SpringDamperSyste</a></td>
      <td> 带有平移副并连接在自由体上的弹簧/阻尼系统
           <br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringDamperSystem_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringMassSystem\">SpringMassSystem</a></td>
      <td> 通过平移副和弹簧连接到全局坐标系的质量块<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringMassSystem_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.SpringWithMass\">SpringWithMass</a></td>
      <td> 悬挂在弹簧上的质点<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringWithMass_small.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.ThreeSprings\">ThreeSprings</a></td>
      <td> 串联和并联连接的三维弹簧<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ThreeSprings_small.png\">
      </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.HeatLosses\">HeatLosses</a></td>
      <td> 演示建立热量损失的模型 </td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.UserDefinedGravityField\">UserDefindGravaityField</a></td>
      <td> 演示建立用户自定义重力场的模型</td>
  </tr>

  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Surfaces\">Surface</a></td>
      <td> 展示正弦曲面的可视化，以及由曲面构成的圆环面和轮子<br>
      <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Surfaces_small.png\">
      </td>
  </tr>

</table>
</html>"));
end Elementary;