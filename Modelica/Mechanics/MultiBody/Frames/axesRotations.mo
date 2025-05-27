within Modelica.Mechanics.MultiBody.Frames;
function axesRotations 
  "返回围绕三个轴按顺序固定旋转角度的旋转对象"

  import TM = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  extends Modelica.Icons.Function;
  input Integer sequence[3](
    min={1,1,1}, 
    max={3,3,3}) = {1,2,3} 
    "沿轴序列[i]从坐标系1旋转到坐标系2的旋转顺序";
  input SI.Angle angles[3] 
    "沿'sequence'定义的轴旋转的角度";
  input SI.AngularVelocity der_angles[3] "= der(angles)";
  output Orientation R "将坐标系1旋转到坐标系2的方向对象";
algorithm
  R := Orientation(T=TM.axisRotation(sequence[3], angles[3])*TM.axisRotation(sequence[2], angles[2])*TM.axisRotation(sequence[1], angles[1]), w=Frames.axis(sequence[3])*der_angles[3] + TM.resolve2(TM.axisRotation(sequence[3], angles[3]), Frames.axis(sequence[2])*der_angles[2]) + TM.resolve2(TM.axisRotation(sequence[3], angles[3])*TM.axisRotation(sequence[2], angles[2]), Frames.axis(sequence[1])*der_angles[1]));
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>axesRotations</strong>(sequence, angles, der_angles);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回描述由三个基本旋转元素定义的方向对象R，
给定的<code>sequence</code>中的每个旋转元素由<code>angles</code>旋转。
角速度矢量R.w从角度导数<code>der_angles</code>计算得到。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axesRotations\">TransformationMatrices.axesRotations</a>.
</p>
</html>"));
end axesRotations;