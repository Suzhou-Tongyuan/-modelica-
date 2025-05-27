within Modelica.Mechanics.MultiBody.Frames;
function smallRotation 
  "返回对小幅旋转有效的旋转角度，并可选择返回应为零的残差"

  extends Modelica.Icons.Function;
  input Orientation R "将坐标系1旋转到坐标系2的方向对象";
  input Boolean withResidues=false 
    "= false/true，如果返回 'angles'/'angles and residues' 中的角度/角度和残留项";
  output SI.Angle phi[if withResidues then 6 else 3] 
    "坐标系1绕x轴、y轴和z轴的旋转角度，将坐标系1旋转到坐标系2的小角度旋转 + 可选的三个应该为零的残留项";
algorithm
  /* 平面旋转：
       Trel = outerProduct(e,e) + (identity(3) - outerProduct(e,e))*cos(angle) - skew(e)*sin(angle)
            = identity(3) - skew(e)*angle, 对于小角度
            = identity(3) - skew(e*angle)
               定义 phi = e*angle，那么
       Trel = [1,      phi3,   -phi2;
               -phi3,     1,    phi1;
                phi2, -phi1,       1 ];
  */
  if withResidues then
    phi := {R.T[2, 3],-R.T[1, 3],R.T[1, 2],R.T[1, 1] - 1,R.T[2, 2] - 1,R.T[1, 1]*R.T[2, 2] - R.T[2, 1]*R.T[1, 2] - 1};
  else
    phi := {R.T[2, 3],-R.T[1, 3],R.T[1, 2]};
  end if;
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
phi = Frames.<strong>smallRotation</strong>(R, withResidues);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数返回一个小角度旋转的有效旋转角度，顺序为 x-y-z(即 {1,2,3})。
如果 <code>withResidues=true</code>，则还可以返回残留项。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.smallRotation\">TransformationMatrices.smallRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.smallRotation\">Quaternions.smallRotation</a>.
</p>
</html>"));
end smallRotation;