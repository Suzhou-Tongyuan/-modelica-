within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function axesRotationsAngles 
  "返回依次绕3个轴旋转以构建给定方向对象的3个角度"

  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
  input Integer sequence[3](
    min={1,1,1}, 
    max={3,3,3}) = {1,2,3} 
    "从坐标系1到坐标系2沿axis sequence[i]的旋转顺序";
  input SI.Angle guessAngle1=0 
    "选择angles[1]，使|angles[1] - guessAngle1|最小";
  output SI.Angle angles[3] 
    "在'sequence'中定义的轴周围的旋转角度，使得T=TransformationMatrices.axesRotation(sequence,angles); -pi < angles[i] <= pi";
protected
  Real e1_1[3](each final unit="1") 
    "第一个旋转轴，在坐标系1中解析";
  Real e2_1a[3](each final unit="1") 
    "第二个旋转轴，在坐标系1a中解析";
  Real e3_1[3](each final unit="1") 
    "第三个旋转轴，在坐标系1中解析";
  Real e3_2[3](each final unit="1") 
    "第三个旋转轴，在坐标系2中解析";
  Real A 
    "方程A*cos(angles[1])+B*sin(angles[1]) = 0中的系数A";
  Real B 
    "方程A*cos(angles[1])+B*sin(angles[1]) = 0中的系数B";
  SI.Angle angle_1a "angles[1]的解1";
  SI.Angle angle_1b "angles[1]的解2";
  TransformationMatrices.Orientation T_1a 
    "将坐标系1旋转到坐标系1a的方向对象";

algorithm
  /* 这个旋转对象 T 是通过以下步骤构建的：
(1)使用 angles[1] 将 坐标系1 沿着轴 e1(等于轴序列[1])进行旋转，得到 坐标系1a。
(2)使用 angles[2] 将 坐标系1a 沿着轴 e2(等于轴序列[2])进行旋转，得到 坐标系1b。
(3)使用 angles[3] 将 坐标系1b 沿着轴 e3(等于轴序列[3])进行旋转，得到 坐标系2。
目标是确定 angles[1:3]。这是通过以下方式完成的：
1. e2 和 e3 是彼此垂直的，即，e2*e3 = 0；
   这两个向量都在 坐标系1 中解析(T_ij 是从 坐标系j 到 坐标系i 的变换矩阵；e1_1*e2_1a = 0，因为向量彼此垂直)：
      e3_1 = T_12*e3_2
           = T[sequence[3],:];
      e2_1 = T_11a*e2_1a
           = ( e1_1*transpose(e1_1) + (identity(3) - e1_1*transpose(e1_1))*cos(angles[1])
               + skew(e1_1)*sin(angles[1]) )*e2_1a
           = e2_1a*cos(angles[1]) + cross(e1_1, e2_1a)*sin(angles[1]);
   由此最终得到 angles[1] 的方程式：
      e2_1*e3_1 = 0
                = (e2_1a*cos(angles[1]) + cross(e1_1, e2_1a)*sin(angles[1]))*e3_1
                = (e2_1a*e3_1)*cos(angles[1]) + cross(e1_1, e2_1a)*e3_1*sin(angles[1])
                = A*cos(angles[1]) + B*sin(angles[1])
                  其中 A = e2_1a*e3_1，B = cross(e1_1, e2_1a)*e3_1
   这个方程式在 -pi < angles[1] <= pi 范围内有两个解：
      sin(angles[1]) =  k*A/sqrt(A*A + B*B)
      cos(angles[1]) = -k*B/sqrt(A*A + B*B)
                   k = +/-1
      tan(angles[1]) = k*A/(-k*B)
   即：
      angles[1] = atan2(k*A, -k*B)
   如果 A 和 B 同时为零，就会出现奇异配置，导致 angles[1] 有无穷多个解(每个值都可能)。
2. 使用函数 TransformationMatrices.planarRotationAngle 确定 angles[2]。该函数需要在 坐标系1a 和 坐标系1b 中提供 e_3：
     e3_1a = TransformationMatrices.resolve2(planarRotation(e1_1,angles[1]), e3_1);
     e3_1b = e3_2
3. 使用函数 TransformationMatrices.planarRotationAngle 确定 angles[3]。该函数需要在 坐标系1b 和 坐标系2 中提供 e_2：
     e2_1b = e2_1a
     e2_2  = TransformationMatrices.resolve2( T, TransformationMatrices.resolve1(planarRotation(e1_1,angles[1]), e2_1a));
  */
  assert(sequence[1] <> sequence[2] and sequence[2] <> sequence[3], 
    "input argument 'sequence[1:3]' is not valid");
  e1_1 := if sequence[1] == 1 then {1,0,0} else if sequence[1] == 2 then {0, 
    1,0} else {0,0,1};
  e2_1a := if sequence[2] == 1 then {1,0,0} else if sequence[2] == 2 then {
    0,1,0} else {0,0,1};
  e3_1 := T[sequence[3], :];
  e3_2 := if sequence[3] == 1 then {1,0,0} else if sequence[3] == 2 then {0, 
    1,0} else {0,0,1};

  A := e2_1a*e3_1;
  B := cross(e1_1, e2_1a)*e3_1;
  if abs(A) <= 1e-12 and abs(B) <= 1e-12 then
    angles[1] := guessAngle1;
  else
    angle_1a := Modelica.Math.atan2(A, -B);
    angle_1b := Modelica.Math.atan2(-A, B);
    angles[1] := if abs(angle_1a - guessAngle1) <= abs(angle_1b - 
      guessAngle1) then angle_1a else angle_1b;
  end if;
  T_1a := planarRotation(e1_1, angles[1]);
  angles[2] := TransformationMatrices.planarRotationAngle(e2_1a, 
    TransformationMatrices.resolve2(T_1a, e3_1), e3_2);
  angles[3] := TransformationMatrices.planarRotationAngle(e3_2, e2_1a, 
    TransformationMatrices.resolve2(T, TransformationMatrices.resolve1(T_1a, 
     e2_1a)));

  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
angles = TransformationMatrices.<strong>axesRotationsAngles</strong>(T, sequence, guessAngle1);
</pre></blockquote>

<h4>描述</h4>
<p>
调用这个函数的形式如下：
</p>
<blockquote><pre>
  TransformationMatrices.Orientation T;
  <strong>parameter</strong> Integer sequence[3] = {1,2,3};
  SI.Angle angles[3];
<strong>equation</strong>
  angle = <strong>axesRotationAngles</strong>(T, sequence);
</pre></blockquote>
<p>
计算旋转角度 \"<strong>angles</strong>[1:3]\" 将坐标系 1 沿轴 <strong>sequence</strong>[1:3] 旋转到坐标系 2 中，给定从坐标系 1 到坐标系 2 的<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation\"> transformation matrix</a>&nbsp;T。
因此，该函数的结果满足以下方程式：
</p>
<blockquote><pre>
T = <strong>axesRotation</strong>(sequence, angles)
</pre></blockquote>
<p>
旋转角度返回在范围内：
</p>
<blockquote><pre>
-&pi; &lt;= angles[i] &lt;= &pi;
</pre></blockquote>
<p>
在这个范围内对于 \"angles[1]\" 有<strong>两个解</strong>。
通过第三个参数 <strong>guessAngle1</strong>(默认 = 0)，选择返回的解使得 |angles[1] - guessAngle1| 最小。
方向对象 T 可能处于奇异配置，即存在无限多个角度值导致相同的 T。
通过设置 angles[1] = guessAngle1 来选择返回的解。
然后可以在上述范围内唯一确定 angles[2] 和 angles[3]。
</p>
<p>
注意，输入参数 <strong>sequence</strong> 有限制，只能使用值 1、2、3，并且 sequence[1] ≠ sequence[2] 和 sequence[2] ≠ sequence[3]。常用的值包括：
</p>
<blockquote><pre>
sequence = <strong>{1,2,3}</strong>  // Cardan angle sequence
         = <strong>{3,1,3}</strong>  // Euler angle sequence
         = <strong>{3,2,1}</strong>  // Tait-Bryan angle sequence
</pre></blockquote>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.axesRotationsAngles\">Frames.axesRotationsAngles</a>。
</p>

</html>"));
end axesRotationsAngles;