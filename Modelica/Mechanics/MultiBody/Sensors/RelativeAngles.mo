within Modelica.Mechanics.MultiBody.Sensors;
model RelativeAngles "测量两个坐标系连接器之间的相对角度"
  extends Internal.PartialRelativeSensor 
    annotation(IconMap(primitivesVisible=false));
  extends Modelica.Icons.RoundSensor;

  Modelica.Blocks.Interfaces.RealOutput angles[3](
    each final quantity="Angle", 
    each final unit="rad", 
    each displayUnit="deg") 
    "将frame_a旋转到frame_b的角度通过'sequence'进行" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  parameter MultiBody.Types.RotationSequence sequence(
    min={1,1,1}, 
    max={3,3,3})={1,2,3} 
    "返回将frame_a绕轴sequence[1]、sequence[2]和最终sequence[3]旋转到frame_b的角度" 
    annotation (Evaluate=true);
  parameter SI.Angle guessAngle1=0 
    "选择angles[1]使得abs(angles[1]-guessAngle1)最小";
  Modelica.Mechanics.MultiBody.Frames.Orientation R_rel 
    "从frame_a到frame_b的相对方向对象";


equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);
  R_rel = Modelica.Mechanics.MultiBody.Frames.relativeRotation(frame_a.R, frame_b.R);
  angles = MultiBody.Frames.axesRotationsAngles(
    R_rel, 
    sequence, 
    guessAngle1);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), 
      graphics={
        Line(
          points={{0,-70},{0,-100}}, 
          color={0,0,127}), 
        Line(
          points={{-70,0},{-96,0},{-96,0}}), 
        Line(
          points={{96,0},{70,0},{70,0}}), 
        Text(
          extent={{-132,90},{129,138}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="rad"), 
        Text(
          extent={{-108,43},{-72,18}}, 
          textColor={128,128,128}, 
          textString="a"), 
        Text(
          extent={{72,43},{108,18}}, 
          textColor={128,128,128}, 
          textString="b")}), 
    Documentation(info="<html>
<p>
这个模型确定了将frame_a旋转到frame_b的3个角度，沿着参数<strong>sequence</strong>定义的轴。
例如，如果sequence={3,1,2}，那么frame_a将沿着z轴绕angles[1]旋转，然后沿着x轴绕angles[2]旋转，最后沿着y轴绕angles[3]旋转，此时frame_a与frame_b相同。
这3个角度返回的范围为</p>
<blockquote><pre>
-&pi;&lt;=angles[i]&lt;=&pi;
</pre></blockquote>
<p>
在这个范围内，“angles[1]”有<strong>两个解</strong>。
通过参数<strong>guessAngle1</strong>(默认值为0)选择返回的解，使得|angles[1]-guessAngle1|最小。
相对于\"sequence\"，frame_a和frame_b之间的相对变换矩阵可能处于奇异配置，即存在无限多个角度值导致相同的相对变换矩阵。
在这种情况下，通过设置angles[1]=guessAngle1来选择返回的解。
然后angles[2]和angles[3]可以在上述范围内唯一确定。
</p>
<p>
参数<strong>sequence</strong>的限制是只能使用值1,2,3，并且sequence[1]&ne;sequence[2]以及sequence[2]&ne;sequence[3]。
常用的值有：</p>
<blockquote><pre>
sequence=<strong>{1,2,3}</strong>//Cardan或Tait-Bryan角序列
=<strong>{3,1,3}</strong>//欧拉角序列
=<strong>{3,2,1}</strong>
</pre></blockquote>

</html>"));
end RelativeAngles;