within Modelica.Mechanics.MultiBody.Frames.Quaternions;
function from_T 
  "从变换矩阵 T 返回四元数方向对象 Q"

  extends Modelica.Icons.Function;
  input Real T[3, 3] 
    "将矢量从坐标系 1 转换到坐标系 2 的变换矩阵(v2=T*v1)";
  input Quaternions.Orientation Q_guess=nullRotation() 
    "Q 的猜测值(有 2 个解；选择接近 Q_guess 的一个解)";
  output Quaternions.Orientation Q 
    "将坐标系 1 旋转到坐标系 2 的四元数方向对象(Q 和 -Q 具有相同的变换矩阵)";
protected
  Real paux;
  Real paux4;
  Real c1;
  Real c2;
  Real c3;
  Real c4;
  constant Real p4limit=0.1;
  constant Real c4limit=4*p4limit*p4limit;
algorithm
  /*
   注意，对于四元数，Q 和 -Q 具有相同的变换矩阵。
   从变换矩阵 T 计算四元数：
   保证 c1>=0，c2>=0，c3>=0，c4>=0，且它们不会同时为零
   (例如，如果其中 3 个为零，第 4 个变量为 1)。
   由于 sqrt(..) 必须对这些变量之一执行，
   因此应该应用于远离零的变量。
   这保证 sqrt(..) 从未接近零，因此 sqrt(..) 的导数永远不会无穷大。
   对于四元数存在歧义，因为 Q 和 -Q
   导致相同的变换矩阵。 歧义
   在此通过选择接近输入参数 Q_guess 的 Q 来解决。
*/
  c1 := 1 + T[1, 1] - T[2, 2] - T[3, 3];
  c2 := 1 + T[2, 2] - T[1, 1] - T[3, 3];
  c3 := 1 + T[3, 3] - T[1, 1] - T[2, 2];
  c4 := 1 + T[1, 1] + T[2, 2] + T[3, 3];

  if c4 > c4limit or (c4 > c1 and c4 > c2 and c4 > c3) then
    paux := sqrt(c4)/2;
    paux4 := 4*paux;
    Q := {(T[2, 3] - T[3, 2])/paux4,(T[3, 1] - T[1, 3])/paux4,(T[1, 2] - T[
      2, 1])/paux4,paux};

  elseif c1 > c2 and c1 > c3 and c1 > c4 then
    paux := sqrt(c1)/2;
    paux4 := 4*paux;
    Q := {paux,(T[1, 2] + T[2, 1])/paux4,(T[1, 3] + T[3, 1])/paux4,(T[2, 3] 
       - T[3, 2])/paux4};

  elseif c2 > c1 and c2 > c3 and c2 > c4 then
    paux := sqrt(c2)/2;
    paux4 := 4*paux;
    Q := {(T[1, 2] + T[2, 1])/paux4,paux,(T[2, 3] + T[3, 2])/paux4,(T[3, 1] 
       - T[1, 3])/paux4};

  else
    paux := sqrt(c3)/2;
    paux4 := 4*paux;
    Q := {(T[1, 3] + T[3, 1])/paux4,(T[2, 3] + T[3, 2])/paux4,paux,(T[1, 2] 
       - T[2, 1])/paux4};
  end if;

  if Q*Q_guess < 0 then
    Q := -Q;
  end if;
  annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Q = Quaternions.<strong>from_T</strong>(T, Q_guess);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从变换矩阵&nbsp;T 计算得到一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.Orientation\">quaternions orientation</a>&nbsp;Q。
取决于初始猜测 Q_guess。
通常，变换矩阵&nbsp;T 可以通过
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a>
包中的函数获得。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.to_T\">to_T</a>、
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T_inv\">from_T_inv</a>、
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">Frames.from_T</a>、
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">TransformationMatrices.from_T</a>。
</p>
</html>"));
end from_T;