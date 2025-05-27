within Modelica.Mechanics.MultiBody.Frames;
function from_T_inv 
  "从逆变换矩阵 T_inv 返回方向对象 R"
  extends Modelica.Icons.Function;
  input Real T_inv[3, 3] 
    "将矢量从坐标系 2 转换到坐标系 1 的逆变换矩阵 (v1=T_inv*v2)";
  input SI.AngularVelocity w[3] 
    "坐标系 1 相对于坐标系 2 的角速度，以坐标系 1 为基准 (skew(w)=T_inv*der(transpose(T_inv)))";
  output Orientation R "将坐标系 1 旋转到坐标系 2 的方向对象";
algorithm
  R := Orientation(T=transpose(T_inv),w= -w);
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
R = Frames.<strong>from_T_inv</strong>(T_inv, w);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数从逆变换矩阵 T_inv 和对应的角速度矢量 w 中返回一个
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Orientation\">orientation object</a>&nbsp;R。
通常情况下，可以使用来自
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices\">TransformationMatrices</a>
包的函数来获取变换矩阵 T_inv，例如使用 T_inv = <a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.inverseRotation\">inverseRotation</a>(T)。
请注意，速度矢量&nbsp;w 必须相应计算。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.from_T\">from_T</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.from_T_inv\">TransformationMatrices.from_T_inv</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T_inv\">Quaternions.from_T_inv</a>.
</p>
</html>"));
end from_T_inv;