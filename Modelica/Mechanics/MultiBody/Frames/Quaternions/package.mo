within Modelica.Mechanics.MultiBody.Frames;
package Quaternions "基于四元数(也称为欧拉参数)转换旋转坐标系量的函数"
  extends Modelica.Icons.FunctionsPackage;

  annotation (Documentation(info="<html>
<p>
<strong>Quaternions</strong>包中含有类型定义和函数，用于使用四元数转换旋转坐标系量。
此包中的函数目前仅在当需要将四元数用作构件状态的一部分时在MultiBody.Parts.Body 组件中使用。
一些函数也在用于新的 Modelica 包，用于 B-Spline 插值，能够插值由位置矢量和方向对象组成的路径。
</p>
<h4>内容</h4>
<p>下表给出了每个函数定义的示例。使用的变量具有以下声明：
</p>

<blockquote><pre>
Quaternions.Orientation Q, Q1, Q2, Q_rel, Q_inv;
Real[3,3]   T, T_inv;
Real[3]     v1, v2, w1, w2, n_x, n_y, n_z, res_ori, phi;
Real[6]     res_equal;
Real        L, angle;
</pre></blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>函数/类型</em></strong></th><th><strong><em>描述</em></strong></th></tr>
  <tr><td><strong>Orientation Q;</strong></td>
      <td>定义一个新类型，描述了将坐标系1旋转到坐标系2的四元数对象。
      </td>
  </tr>
  <tr><td><strong>der_Orientation</strong> der_Q;</td>
      <td>定义了Frames.Quaternions.Orientation的一阶时间导数。
      </td>
  </tr>
  <tr><td>res_ori = <strong>orientationConstraint</strong>(Q);</td>
      <td>返回四元数对象的变量之间的约束(应为零)。
      </td>
  </tr>
  <tr><td>w1 = <strong>angularVelocity1</strong>(Q, der_Q);</td>
      <td>从四元数对象Q及其导数der_Q解析出在坐标系1中的角速度。
     </td>
  </tr>
  <tr><td>w2 = <strong>angularVelocity2</strong>(Q, der_Q);</td>
      <td>从四元数对象Q及其导数der_Q解析出在坐标系2中的角速度。
     </td>
  </tr>
  <tr><td>v1 = <strong>resolve1</strong>(Q,v2);</td>
      <td>将矢量v2从坐标系2变换到坐标系1。
      </td>
  </tr>
  <tr><td>v2 = <strong>resolve2</strong>(Q,v1);</td>
      <td>将矢量v1从坐标系1变换到坐标系2。
     </td>
  </tr>
  <tr><td>[v1,w1] = <strong>multipleResolve1</strong>(Q, [v2,w2]);</td>
      <td>将多个矢量从坐标系2变换到坐标系1。
      </td>
  </tr>
  <tr><td>[v2,w2] = <strong>multipleResolve2</strong>(Q, [v1,w1]);</td>
      <td>将多个矢量从坐标系1变换到坐标系2。
      </td>
  </tr>

  <tr><td>Q = <strong>nullRotation</strong>();</td>
      <td>返回不旋转坐标系的四元数对象 R。</td>
  </tr>
  <tr><td>Q_inv = <strong>inverseRotation</strong>(Q);</td>
      <td>返回逆四元数对象。</td>
  </tr>
  <tr><td>Q_rel = <strong>relativeRotation</strong>(Q1,Q2);</td>
      <td>从两个绝对四元数对象返回相对四元数对象。</td>
  </tr>
  <tr><td>Q2 = <strong>absoluteRotation</strong>(Q1,Q_rel);</td>
      <td>从另一个绝对四元数对象和一个相对四元数对象返回绝对四元数对象。</td>
  </tr>
  <tr><td>Q = <strong>planarRotation</strong>(e, angle);</td>
      <td>返回平面旋转的四元数对象。</td>
  </tr>
  <tr><td>phi = <strong>smallRotation</strong>(Q);</td>
      <td>返回小旋转有效的旋转角度 phi。</td>
  </tr>
  <tr><td>Q = <strong>from_T</strong>(T);</td>
      <td>从变换矩阵 T 返回四元数对象 Q。</td>
  </tr>
  <tr><td>Q = <strong>from_T_inv</strong>(T_inv);</td>
      <td>从逆变换矩阵 T_inv 返回四元数对象 Q。</td>
  </tr>
  <tr><td>T = <strong>to_T</strong>(Q);</td>
      <td>从四元数对象 Q 返回变换矩阵 T。</td>
  </tr>
  <tr><td>T_inv = <strong>to_T_inv</strong>(Q);</td>
      <td>从四元数对象 Q 返回逆变换矩阵 T_inv。</td>
  </tr>

</table>
</html>"));
end Quaternions;