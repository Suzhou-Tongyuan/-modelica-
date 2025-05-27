within Modelica.Mechanics.MultiBody;
package Frames "用于转换旋转坐标系量的函数"

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
包<strong>Frames</strong>中包含了类的定义以及用于转换旋转坐标系中量的函数。
基本思想是，通过提供必要的<strong>Orientation</strong>类以及操作该类实例的<strong>functions</strong>，
在这个包中隐藏实际的<strong>orientation</strong>的定义。
</p>
<h4>目录</h4>
<p>在下表中，给出了每个函数定义的示例。其中所使用的变量具有以下声明：
</p>
<blockquote><pre>
Frames.Orientation R, R1, R2, R_rel, R_inv;
Real[3,3]   T, T_inv;
Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, e, e_x, res_ori, phi;
Real[6]     res_equal;
Real        L, angle;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>函数/类</em></strong></th><th><strong><em>描述</em></strong></th></tr>
  <tr><td><strong>Orientation R;</strong></td>
      <td>定义了一个新类型，用于描述坐标系1到坐标系2的旋转。</td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(R);</td>
      <td>返回方向对象的变量之间的约束(应等于零)。</td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(R);</td>
      <td>从方向对象R解析出的在坐标系1中的角速度。</td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(R);</td>
      <td>从方向对象R解析出的在坐标系2中的角速度。</td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(R,v2);</td>
      <td>将矢量v2从坐标系2转换到坐标系1。</td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(R,v1);</td>
      <td>将矢量v1从坐标系1转换到坐标系2。</td>
  </tr>
  <tr><td>v2 = <strong>resolveRelative</strong>(v1,R1,R2);</td>
      <td>使用坐标系1的绝对方向对象R1和坐标系2的绝对方向对象R2，将矢量v1从坐标系1下表示转换到坐标系2下表示。</td>
  </tr>
   <tr><td>D1 = <strong>resolveDyade1</strong>(R,D2);</td>
      <td>将二阶张量D2从坐标系2转换到坐标系1。</td>
  </tr>
  <tr><td>D2 = <strong>resolveDyade2</strong>(R,D1);</td>
      <td>将二阶张量D1从坐标系1转换到坐标系2。</td>
  </tr>
  <tr><td>R = <strong>nullRotation</strong>()</td>
      <td>返回坐标系没有旋转的方向对象R。</td>
  </tr>
  <tr><td>R_inv = <strong>inverseRotation</strong>(R);</td>
      <td>返回方向对象的逆对象。</td>
  </tr>
  <tr><td>R_rel = <strong>relativeRotation</strong>(R1,R2);</td>
      <td>从两个绝对方向对象返回相对方向对象。</td>
  </tr>
  <tr><td>R2 = <strong>absoluteRotation</strong>(R1,R_rel);</td>
      <td>从另一个绝对方向对象和一个相对方向对象返回绝对方向对象。</td>
  </tr>
  <tr><td>R = <strong>planarRotation</strong>(e, angle, der_angle);</td>
      <td>返回平面旋转的方向对象。</td>
  </tr>
  <tr><td>angle = <strong>planarRotationAngle</strong>(e, v1, v2);</td>
      <td>返回平面旋转的角度，给定旋转轴和在坐标系1和坐标系2下表示的矢量。</td>
  </tr>
  <tr><td>R = <strong>axisRotation</strong>(axis, angle, der_angle);</td>
      <td>返回绕坐标系1中的给定轴旋转给定角度的方向对象R。</td>
  </tr>

  <tr><td>R = <strong>axesRotations</strong>(sequence, angles, der_angles);</td>
      <td>返回一个旋转对象，用于按给定顺序绕三个轴旋转。例如：<br>
          R = axesRotations({1,2,3},{pi/2,pi/4,-pi}, zeros(3));
      </td>
  </tr>
  <tr><td>angles = <strong>axesRotationsAngles</strong>(R, sequence);</td>
      <td>返回绕三个轴按顺序旋转以构造给定方向对象所需的三个角度。
      </td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(R);</td>
      <td>返回适用于小幅旋转R的旋转角度phi。
      </td>
  </tr>
  <tr><td>R = <strong>from_nxy</strong>(n_x, n_y);</td>
      <td>从n_x和n_y矢量返回方向对象。
      </td>
  </tr>
  <tr><td>R = <strong>from_nxz</strong>(n_x, n_z);</td>
      <td>从n_x和n_z矢量返回方向对象。
      </td>
  </tr>
  <tr><td>R = <strong>from_T</strong>(T,w);</td>
      <td>从变换矩阵T及其角速度w返回方向对象R。
      </td>
  </tr>
   <tr><td>R = <strong>from_T2</strong>(T,der(T));</td>
      <td>从变换矩阵T及其导数der(T)返回方向对象R。
      </td>
  </tr>
  <tr><td>R = <strong>from_T_inv</strong>(T_inv,w);</td>
      <td>从逆变换矩阵T_inv及其角速度w返回方向对象R。
      </td>
  </tr>
  <tr><td>R = <strong>from_Q</strong>(Q,w);</td>
      <td>从四元数方向对象Q及其角速度w返回方向对象R。
      </td>
  </tr>
  <tr><td>T = <strong>to_T</strong>(R);</td>
      <td>从方向对象R返回变换矩阵T。
      </td>
  </tr>
  <tr><td>T_inv = <strong>to_T_inv</strong>(R);</td>
      <td>从方向对象R返回逆变换矩阵T_inv。
      </td>
  </tr>
  <tr><td>Q = <strong>to_Q</strong>(R);</td>
      <td>从方向对象R返回四元数方向对象Q。
      </td>
  </tr>
  <tr><td>exy = <strong>to_exy</strong>(R);</td>
      <td>从方向对象R返回[e_x, e_y]矩阵，其中坐标系2的轴e_x和e_y在坐标系1下表示的矢量。
      </td>
  </tr>
  <tr><td>L = <strong>length</strong>(n_x);</td>
      <td>返回矢量n_x的长度L。
      </td>
  </tr>
  <tr><td>e_x = <strong>normalize</strong>(n_x);</td>
      <td>返回矢量n_x的单位矢量e_x，使得e_x的长度为一。
      </td>
  </tr>
  <tr><td>e = <strong>axis</strong>(i);</td>
      <td>返回沿着轴i方向的单位矢量e。
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions\">Quaternions</a></td>
      <td>基于四元数(也称为欧拉参数)的旋转坐标系量的转换函数包。
      </td>
  </tr>
  <tr><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a></td>
      <td>基于变换矩阵的旋转坐标系量的转换函数包。
      </td>
  </tr>
</table>
</html>"), Icon(graphics={
        Line(points={{-2,-18},{80,-60}}, color={95,95,95}), 
        Line(points={{-2,-18},{-2,80}}, color={95,95,95}), 
        Line(points={{-78,-56},{-2,-18}}, color={95,95,95})}));
end Frames;