within Modelica.Mechanics.MultiBody.Types;
type GravityTypes = enumeration(
    NoGravity "无重力场", 
    UniformGravity "均匀重力场", 
    PointGravity "点重力场") 
  "枚举类型，定义了重力场的类型" 
    annotation (Documentation(info="<html>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>Types.GravityTypes.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>NoGravity</td>
<td>无重力场</td></tr>

<tr><td>Un如果ormGravity</td>
<td>重力场由恒定重力加速度的矢量描述</td></tr>

<tr><td>PointGravity</td>
<td>中心重力场。
重力加速度矢量指向场中心，重力与1/r^2成比例，
其中r是到场中心的距离。
</td></tr>
</table>
</html>"));