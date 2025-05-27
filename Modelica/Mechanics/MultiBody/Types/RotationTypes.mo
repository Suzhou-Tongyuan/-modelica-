within Modelica.Mechanics.MultiBody.Types;
type RotationTypes = enumeration(
    RotationAxis "围绕固定轴在角度上旋转frame_a", 
    TwoAxesVectors "在frame_a中解析frame_b的两个矢量", 
    PlanarRotationSequence "平面旋转序列") 
  "枚举类型，定义了frame_b相对于frame_a的固定方向的指定方式" 
    annotation (
      Documentation(Evaluate=true, info="<html>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>Types.RotationTypes.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>RotationAxis</td>
<td>通过沿着frame_a中固定轴的角度旋转坐标系来定义frame_b。
</td></tr>

<tr><td>TwoAxesVectors</td>
<td>通过在frame_a中解析frame_b的两个矢量来定义frame_b。
</td></tr>

<tr><td>PlanarRotationSequence</td>
<td>通过沿着3个连续的固定旋转角度的轴矢量旋转坐标系来定义frame_b
(例如，Cardan或Euler角序列旋转)。
</td></tr>
</table>
</html>"));