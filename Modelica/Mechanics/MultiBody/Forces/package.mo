within Modelica.Mechanics.MultiBody;
package Forces "在坐标系之间施加力和/或力矩的组件"
  extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html>
<p>
此包包含在两个坐标系连接器(例如两个部件)之间施加力和力矩的组件。
</p>
<h4>目录</h4>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>模型</em></strong></th><th><strong><em>描述</em></strong></th></tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.WorldForce\">WorldForce</a></td>
      <td> 作用于与该组件相连的坐标系上的外部力，由3个输入信号定义，这些信号被解析为在world坐标系、frame_b或frame_resolve中的一个矢量。<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ArrowForce.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.WorldTorque\">WorldTorque</a></td>
      <td> 作用于与该组件相连的坐标系上的外部力矩，由3个输入信号定义，这些信号被解析为在world坐标系、frame_b或frame_resolve中的一个矢量。<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ArrowTorque.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.WorldForceAndTorque\">WorldForceAndTorque</a></td>
      <td> 作用于与该组件相连的坐标系上的外部力和外部力矩，由3+3个输入信号定义，这些信号被解析为在world坐标系、frame_b或frame_resolve中的一个力矢量和一个力矩矢量。<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ArrowForce.png\"><br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ArrowTorque.png\">
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Force\">Force</a></td>
      <td> 在两个坐标系之间作用的力，由在world坐标系、frame_a、frame_b或frame_resolve中解析的3个输入信号定义。<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ArrowForce2.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Torque\">Torque</a></td>
      <td> 在两个坐标系之间作用的力矩，由在world坐标系、frame_a、frame_b或frame_resolve中解析的3个输入信号定义。<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ArrowTorque2.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.ForceAndTorque\">ForceAndTorque</a></td>
      <td> 在两个坐标系之间作用的力和力矩，由在world坐标系、frame_a、frame_b或frame_resolve中解析的3+3个输入信号定义。<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ArrowForce2.png\"><br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/ArrowTorque2.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithMass\">LineForceWithMass</a></td>
      <td>  连接线上具有1个可选点质量的通用线性力组件。力定律可以由Modelica.Mechanics.Translational中的一个组件定义。<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/LineForceWithMass.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses\">LineForceWithTwoMasses</a></td>
      <td>  连接线上具有2个可选点质量的通用线性力组件。力定律可以由Modelica.Mechanics.Translational中的一个组件定义。<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/LineForceWithTwoMasses.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Spring\">Spring</a></td>
      <td> 具有可选质量的线性平动弹簧<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Spring2.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Damper\">Damper</a></td>
      <td> 线性(速度相关)阻尼器<br>
           <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Forces/Damper2.png\"></td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.SpringDamperParallel\">SpringDamperParallel</a></td>
      <td> 并联连接的线性弹簧和阻尼器 </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.SpringDamperSeries\">SpringDamperSeries</a></td>
      <td> 串联连接的线性弹簧和阻尼器 </td>
  </tr>
</table>
</html>"));
end Forces;