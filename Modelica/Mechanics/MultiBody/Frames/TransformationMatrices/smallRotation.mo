within Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
function smallRotation 
  "返回对小幅旋转有效的旋转角度，并可选择返回应为零的残差"
  extends Modelica.Icons.Function;
  input TransformationMatrices.Orientation T 
    "将坐标系1旋转到坐标系2的方向对象";
  input Boolean withResidues=false 
    "= false/true，如果在phi中返回'angles'/'angles and residues'";
  output SI.Angle phi[if withResidues then 6 else 3] 
    "坐标系1绕x轴、y轴和z轴的旋转角度，以将坐标系1旋转到坐标系2的小旋转 + 可选的3个应为零的残差";
algorithm
  /* 平面旋转:
       Trel = outerProduct(e,e) + (identity(3) - outerProduct(e,e))*cos(angle) - skew(e)*sin(angle)
            = identity(3) - skew(e)*angle, 对于小角度
            = identity(3) - skew(e*angle)
               定义 phi = e*angle, 则
       Trel = [1,      phi3,   -phi2;
               -phi3,     1,    phi1;
                phi2, -phi1,       1 ];
  */
  phi := if withResidues then {T[2, 3],-T[1, 3],T[1, 2],T[1, 1] - 1,T[2, 2] 
     - 1,T[1, 1]*T[2, 2] - T[2, 1]*T[1, 2] - 1} else {T[2, 3],-T[1, 3],T[1,
     2]};
  annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
phi = TransformationMatrices.<strong>smallRotation</strong>(T, withResidues);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数返回x-y-z顺序的小旋转的旋转角度(即{1,2,3})。
如果<code>withResidues=true</code>，还可以返回残差。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.smallRotation\">Frames.smallRotation</a>,
<a href=\"modelica://Modelica.Mechanics.MultiBody.Frames.Quaternions.smallRotation\">Quaternions.smallRotation</a>.
</p>
</html>"));
end smallRotation;