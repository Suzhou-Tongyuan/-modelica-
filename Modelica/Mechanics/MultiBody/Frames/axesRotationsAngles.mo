within Modelica.Mechanics.MultiBody.Frames;
function axesRotationsAngles 
  "返回绕3个轴依次旋转的3个角度，以构建给定的定向对象"


  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Integer sequence[3](
    min={1,1,1}, 
    max={3,3,3}) = {1,2,3} 
    "沿轴序列[i]从坐标系1旋转到坐标系2的旋转顺序";
  input SI.Angle guessAngle1=0 
    "选择angles[1]，使|angles[1] - guessAngle1|最小";
  output SI.Angle angles[3] 
    "沿'sequence'定义的轴的旋转角度，使R=Frames.axesRotation(sequence,angles); -pi < angles[i] <= pi";
protected
  Real e1_1[3](each final unit="1") 
    "第一旋转轴，以坐标系1为基准";
  Real e2_1a[3](each final unit="1") 
    "第二旋转轴，以坐标系1a为基准";
  Real e3_1[3](each final unit="1") 
    "第三旋转轴，以坐标系1为基准";
  Real e3_2[3](each final unit="1") 
    "第三旋转轴，以坐标系2为基准";
  Real A 
    "方程A*cos(angles[1])+B*sin(angles[1]) = 0中的系数A";
  Real B 
    "方程A*cos(angles[1])+B*sin(angles[1]) = 0中的系数B";
  SI.Angle angle_1a "angles[1]的解1";
  SI.Angle angle_1b "angles[1]的解2";
  TransformationMatrices.Orientation T_1a 
    "将坐标系1旋转到坐标系1a的方向对象";
algorithm
/* 通过以下步骤构造旋转对象R：
(1) 将坐标系1沿轴e1（= 轴序列[1]）旋转angles[1]，
到达坐标系1a。
(2) 将坐标系1a沿轴e2（= 轴序列[2]）旋转angles[2]，
到达坐标系1b。
(3) 将坐标系1b沿轴e3（= 轴序列[3]）旋转angles[3]，
到达坐标系2。
目标是确定angles[1:3]。具体步骤如下：

1.e2 和 e3 是彼此垂直的，即 e2e3 = 0； 
两个矢量在坐标系1中分解（T_ij是从坐标系j到坐标系i的变换矩阵；
e1_1e2_1a = 0，因为矢量彼此垂直）： 
e3_1 = T_12e3_2 = R[sequence[3],:]; 
e2_1 = T_11ae2_1a = ( e1_1transpose(e1_1) + (identity(3) - e1_1transpose(e1_1))cos(angles[1]) + skew(e1_1)sin(angles[1]) )e2_1a = e2_1acos(angles[1]) + cross(e1_1, e2_1a)sin(angles[1]); 
最终得到 angles[1] 的方程式为： e2_1e3_1 = 0 = (e2_1acos(angles[1]) + cross(e1_1, e2_1a)sin(angles[1]))e3_1 = (e2_1ae3_1)cos(angles[1]) + cross(e1_1, e2_1a)e3_1sin(angles[1]) = Acos(angles[1]) + Bsin(angles[1]) 其中 A = e2_1ae3_1，B = cross(e1_1, e2_1a)e3_1 此方程在 -pi < angles[1] <= pi 范围内有两个解： sin(angles[1]) = kA/sqrt(AA + BB) cos(angles[1]) = -kB/sqrt(AA + BB) k = +/-1 tan(angles[1]) = kA/(-kB) 即： angles[1] = atan2(kA, -k*B) 如果 A 和 B 同时为零，则存在奇异配置， 导致 angles[1] 有无限多个解（每个值均可能）。
2.使用函数Frames.planarRotationAngle 确定 angles[2]。 此函数要求在坐标系1a和坐标系1b中提供 e_3： e3_1a = Frames.resolve2(planarRotation(e1_1,angles[1]), e3_1); e3_1b = e3_2
3.使用函数Frames.planarRotationAngle 确定 angles[3]。 此函数要求在坐标系1b和坐标系2中提供 e_2： e2_1b = e2_1a e2_2 = Frames.resolve2( R, Frames.resolve1(planarRotation(e1_1,angles[1]), e2_1a)); */
  assert(sequence[1] <> sequence[2] and sequence[2] <> sequence[3], 
    "input argument 'sequence[1:3]' is not valid");
  e1_1 := if sequence[1] == 1 then {1,0,0} else if sequence[1] == 2 then {0,1, 
    0} else {0,0,1};
  e2_1a := if sequence[2] == 1 then {1,0,0} else if sequence[2] == 2 then {0, 
    1,0} else {0,0,1};
  e3_1 := R.T[sequence[3], :];
  e3_2 := if sequence[3] == 1 then {1,0,0} else if sequence[3] == 2 then {0,1, 
    0} else {0,0,1};

  A := e2_1a*e3_1;
  B := cross(e1_1, e2_1a)*e3_1;
  if abs(A) <= 1e-12 and abs(B) <= 1e-12 then
    angles[1] := guessAngle1;
  else
    angle_1a := Modelica.Math.atan2(A, -B);
    angle_1b := Modelica.Math.atan2(-A, B);
    angles[1] := if abs(angle_1a - guessAngle1) <= abs(angle_1b - guessAngle1) then 
            angle_1a else angle_1b;
  end if;
  T_1a := TransformationMatrices.planarRotation(e1_1, angles[1]);
  angles[2] := planarRotationAngle(e2_1a, TransformationMatrices.resolve2(
    T_1a, e3_1), e3_2);
  angles[3] := planarRotationAngle(e3_2, e2_1a, 
    TransformationMatrices.resolve2(R.T, TransformationMatrices.resolve1(T_1a, 
     e2_1a)));

  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
angles = Frames.<strong>axesRotationsAngles</strong>(R, sequence, guessAngle1);
</pre></blockquote>

<h4>描述</h4>
<p>
调用这个函数的形式如下：
</p>
<blockquote><pre>
  Frames.Orientation R;
  <strong>parameter</strong> Integer sequence[3] = {1,2,3};
  SI.Angle angles[3];
<strong>equation</strong>
  angle = <strong>axesRotationAngles</strong>(R, sequence);
</pre></blockquote>
<p>
计算旋转角度 \"<strong>angles</strong>[1:3]\"，将坐标系1沿着轴 <strong>sequence</strong>[1:3]旋转到坐标系 2 的姿态，给定从坐标系1到坐标系2的方向对象 <strong>R</strong>。
因此，这个函数的结果满足以下方程：
</p>
<blockquote><pre>
R = <strong>axesRotation</strong>(sequence, angles)
</pre></blockquote>
<p>
旋转角度的范围为
</p>
<blockquote><pre>
-&pi; &lt;= angles[i] &lt;= &pi;
</pre></blockquote>
<p>
在这个范围内有<strong>两个解</strong>对于 \"angles[1]\"。
通过第三个参数 <strong>guessAngle1</strong> （默认值为 0），选择返回的解，使得 |angles[1] - guessAngle1| 最小。方向对象 R 可能处于奇异配置，即有无穷多个导致相同 R 的角度值。通过设置 angles[1] = guessAngle1 来选择返回的解。然后 angles[2] 和 angles[3] 可以在上述范围内唯一确定。
</p>
<p>
请注意，输入参数 <strong>sequence</strong> 有一个限制，只能使用值 1、2、3，并且 sequence[1] ≠ sequence[2] 以及 sequence[2] ≠ sequence[3]。通常使用的值包括：
</p>
<blockquote><pre>
sequence = <strong>{1,2,3}</strong>  // Cardan angle sequence
         = <strong>{3,1,3}</strong>  // Euler angle sequence
         = <strong>{3,2,1}</strong>  // Tait-Bryan angle sequence
</pre></blockquote>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axesRotationsAngles\">TransformationMatrices.axesRotationsAngles</a>.
</p>
</html>"));

end axesRotationsAngles;