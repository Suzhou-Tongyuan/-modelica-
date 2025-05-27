within Modelica.Mechanics.MultiBody.Forces.Internal;
function standardGravityAcceleration 
  "标准重力场(无/平行/点场)"
  extends Modelica.Icons.Function;
  extends Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration;
  import Modelica.Mechanics.MultiBody.Types.GravityTypes;
  input GravityTypes gravityType "重力场类型" annotation(Dialog);
  input SI.Acceleration g[3] 
    "如果 gravityType 等于 UniformGravity，则常重力加速度在全局坐标系中分解。" 
    annotation(Dialog);
  input Real mu(unit="m3/s2") 
    "如果 gravityType 等于 PointGravity，则为点重力场的场常数" annotation(Dialog);
algorithm
gravity := if gravityType == GravityTypes.UniformGravity then g else 
           if gravityType == GravityTypes.PointGravity then 
              -(mu/(r*r))*(r/Modelica.Math.Vectors.length(r)) else zeros(3);
  annotation(Inline=true, Documentation(info="<html>
<p>
这个函数定义了World对象的标准重力场。
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong><em>重力类型</em></strong></td>
    <td><strong><em>重力 [m/s2]</em></strong></td>
    <td><strong><em>描述</em></strong></td></tr>
<tr><td>Types.GravityType.NoGravity</td>
    <td>= {0,0,0}</td>
    <td> 无重力</td></tr>

<tr><td>Types.GravityType.UniformGravity</td>
    <td>= g</td>
    <td> 恒定平行重力场</td></tr>

<tr><td>Types.GravityType.PointGravity</td>
    <td>= -(mu/(r*r))*r/|r|</td>
    <td> 具有球形质量的点重力场</td></tr>
</table>

</html>"));
end standardGravityAcceleration;