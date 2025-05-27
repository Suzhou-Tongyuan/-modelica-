within Modelica.Mechanics.MultiBody.Sensors;
model AbsoluteAngles 
  "测量坐标系连接器与全局坐标系之间的绝对角度"
  extends Internal.PartialAbsoluteSensor;

  Modelica.Blocks.Interfaces.RealOutput angles[3](
    each final quantity="Angle", 
    each final unit="rad", 
    each displayUnit="deg") 
    "将全局坐标系旋转到frame_a通过'sequence'的角度" 
    annotation (Placement(transformation(
        origin={110,0}, 
        extent={{-10,-10},{10,10}})));
  parameter MultiBody.Types.RotationSequence sequence(
    min={1,1,1}, 
    max={3,3,3})={1,2,3} 
    "角度返回以使全局坐标系绕轴sequence[1]、sequence[2]和最后sequence[3]旋转到frame_a" 
    annotation (Evaluate=true);
  parameter SI.Angle guessAngle1=0 
    "选择angles[1]，使得abs(angles[1]-guessAngle1)最小";

equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  angles = MultiBody.Frames.axesRotationsAngles(
    frame_a.R, 
    sequence, 
    guessAngle1);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-132,76},{129,124}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{70,0},{100,0}}, 
          color={0,0,127}), 
        Text(
          extent={{-50,-14},{50,-54}}, 
          textColor={64,64,64}, 
          textString="rad")}), 
    Documentation(info="<html>
<p>
这个模型确定了将全局坐标系旋转到frame_a的三个角度，沿着由参数<strong>sequence</strong>定义的轴。
例如，如果sequence={3,1,2}，那么全局坐标系将围绕angles[1]沿z轴旋转，然后围绕angles[2]沿x轴旋转，最后围绕angles[3]沿y轴旋转，然后与frame_a相同。
这三个角度的范围为</p>
<blockquote><pre>
-&pi;&lt;=angles[i]&lt;=&pi;
</pre></blockquote>
<p>
在这个范围内对于\"angles[1]\"有<strong>两个解</strong>。
通过参数<strong>guessAngle1</strong>(默认为0)，选择使得|angles[1]-guessAngle1|最小的解。
关于全局坐标系和frame_a之间的转换矩阵可能在相对于\"sequence\"的奇异配置中，即，存在无限多个角度值导致相同的相对转换矩阵。
在这种情况下，通过设置angles[1]=guessAngle1来选择返回的解。
然后angles[2]和angles[3]可以在上述范围内唯一确定。
</p>
<p>
参数<strong>sequence</strong>有一个限制，只能使用值1、2、3，且sequence[1]&ne;sequence[2]以及sequence[2]&ne;sequence[3]。
通常使用的值有：</p>
<blockquote><pre>
sequence = <strong>{1,2,3}</strong>  // Cardan or Tait-Bryan angle sequence
         = <strong>{3,1,3}</strong>  // Euler angle sequence
         = <strong>{3,2,1}</strong>
</pre></blockquote>

</html>"));
end AbsoluteAngles;