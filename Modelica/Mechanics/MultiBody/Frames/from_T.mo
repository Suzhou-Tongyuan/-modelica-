within Modelica.Mechanics.MultiBody.Frames;
function from_T 
  "返回从变换矩阵 T 和角速度 w 确定的方向对象"
  extends Modelica.Icons.Function;
  input Real T[3, 3] 
    "将矢量从坐标系 1 转换到坐标系 2 的变换矩阵 (v2=T*v1)";
  input SI.AngularVelocity w[3] 
    "在坐标系 2 中解析的相对于坐标系 1 的角速度，解析在坐标系 2 中 (skew(w)=T*der(transpose(T)))";
  output Orientation R "将坐标系 1 旋转到坐标系 2 的方向对象";
algorithm
  R := Orientation(T=T,w= w);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>from_T</strong>(T, w);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数返回由变换矩阵&nbsp;T 和角速度矢量&nbsp;w 组装而成的
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R。
通常情况下，变换矩阵&nbsp;T 可以通过使用
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a>
包中的函数获得。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.to_T\">to_T</a>、
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T_inv\">from_T_inv</a>、
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T\">TransformationMatrices.from_T</a>、
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T\">Quaternions.from_T</a>。
</p>
</html>"));
end from_T;