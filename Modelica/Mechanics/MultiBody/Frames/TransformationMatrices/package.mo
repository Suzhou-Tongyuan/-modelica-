within Modelica.Mechanics.MultiBody.Frames;
package TransformationMatrices "变换矩阵的函数"
  extends Modelica.Icons.FunctionsPackage;

  annotation (Documentation(info="<html>
<p>
<strong>Frames.TransformationMatrices</strong>中包含类型定义和
使用变换矩阵来转换旋转坐标系量的函数。
</p>
<h4>目录</h4>
<p>在下表中给出了每个函数定义的示例。
使用的变量具有以下声明：
</p>
<blockquote><pre>
Orientation T, T1, T2, T_rel, T_inv;
Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, e, e_x, res_ori, phi;
Real[6]     res_equal;
Real        L, angle;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>函数/类型</em></strong></th><th><strong><em>描述</em></strong></th></tr>
  <tr><td><strong>Orientation T;</strong></td>
      <td>定义了一个新类型，用于描述坐标系1到坐标系2的旋转。
      </td>
  </tr>
  <tr><td><strong>der_Orientation</strong> der_T;</td>
      <td>定义了一个新类型，Frames.Orientation对时间的一阶导数。
      </td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(T);</td>
      <td>返回一个方向对象中变量之间的约束(应等于零)。
      </td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(T, der_T);</td>
      <td>从方向对象T和其导数der_T中返回在坐标系1中解析的角速度。
     </td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(T, der_T);</td>
      <td>从方向对象T和其导数der_T中返回在坐标系2中解析的角速度。
     </td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(T,v2);</td>
      <td>将矢量v2从坐标系2转换到坐标系1。
      </td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(T,v1);</td>
      <td>将矢量v1从坐标系1转换到坐标系2。
     </td>
  </tr>
  <tr><td>[v1,w1] = <strong>multipleResolve1</strong>(T, [v2,w2]);</td>
      <td>将多个矢量从坐标系2转换到坐标系1。
      </td>
  </tr>
  <tr><td>[v2,w2] = <strong>multipleResolve2</strong>(T, [v1,w1]);</td>
      <td>将多个矢量从坐标系1转换到坐标系2。
      </td>
  </tr>
  <tr><td>D1 = <strong>resolveDyade1</strong>(T,D2);</td>
      <td>将二阶张量D2从坐标系2转换到坐标系1。
      </td>
  </tr>
  <tr><td>D2 = <strong>resolveDyade2</strong>(T,D1);</td>
      <td>将二阶张量D1从坐标系1转换到坐标系2。
     </td>
  </tr>
  <tr><td>T = <strong>nullRotation</strong>()</td>
      <td>返回一个没有旋转坐标系的方向对象T。
     </td>
  </tr>
  <tr><td>T_inv = <strong>inverseRotation</strong>(T);</td>
      <td>返回逆方向对象。
      </td>
  </tr>
  <tr><td>T_rel = <strong>relativeRotation</strong>(T1,T2);</td>
      <td>从两个绝对方向对象返回相对方向对象。
      </td>
  </tr>
  <tr><td>T2 = <strong>absoluteRotation</strong>(T1,T_rel);</td>
      <td>从另一个绝对方向对象和一个相对方向对象返回绝对方向对象。
      </td>
  </tr>
  <tr><td>T = <strong>planarRotation</strong>(e, angle);</td>
      <td>返回平面旋转的方向对象。
      </td>
  </tr>
  <tr><td>angle = <strong>planarRotationAngle</strong>(e, v1, v2);</td>
      <td>给定旋转轴和一个矢量在坐标系1和坐标系2中的表示，返回平面旋转的角度。
      </td>
  </tr>
  <tr><td>T = <strong>axisRotation</strong>(i, angle);</td>
      <td>返回绕坐标系1中的轴i旋转的方向对象T。
      </td>
  </tr>
  <tr><td>T = <strong>axesRotations</strong>(sequence, angles);</td>
      <td>返回绕三个轴按顺序旋转的旋转对象。示例：<br>
          T = axesRotations({1,2,3},{90,45,-90});
      </td>
  </tr>
  <tr><td>angles = <strong>axesRotationsAngles</strong>(T, sequence);</td>
      <td>返回绕三个轴按顺序旋转以构造给定方向对象的3个角度。
      </td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(T);</td>
      <td>返回用于小旋转的有效旋转角度phi。
      </td>
  </tr>
  <tr><td>T = <strong>from_nxy</strong>(n_x, n_y);</td>
      <td>从n_x和n_y矢量返回方向对象T。
      </td>
  </tr>
  <tr><td>T = <strong>from_nxz</strong>(n_x, n_z);</td>
      <td>从n_x和n_z矢量返回方向对象T。
      </td>
  </tr>
  <tr><td>R = <strong>from_T</strong>(T);</td>
      <td>从变换矩阵T返回方向对象R。
      </td>
  </tr>
  <tr><td>R = <strong>from_T_inv</strong>(T_inv);</td>
      <td>从逆变换矩阵T_inv返回方向对象R。
      </td>
  </tr>
  <tr><td>T = <strong>from_Q</strong>(Q);</td>
      <td>从四元数方向对象Q返回方向对象T。
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
  <tr><td>Q = <strong>to_Q</strong>(T);</td>
      <td>从方向对象T返回四元数方向对象Q。
      </td>
  </tr>
  <tr><td>exy = <strong>to_exy</strong>(T);</td>
      <td>返回方向对象T的[e_x, e_y]矩阵，其中坐标系2的e_x和e_y矢量在坐标系1下解析。
      </td>
  </tr>

</table>
</html>"));
end TransformationMatrices;