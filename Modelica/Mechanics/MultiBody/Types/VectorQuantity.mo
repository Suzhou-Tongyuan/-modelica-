within Modelica.Mechanics.MultiBody.Types;
type VectorQuantity = enumeration(
    Force "力量量", 
    Torque "扭矩量", 
    Velocity "速度量", 
    Acceleration "加速度量", 
    AngularVelocity "角速度量", 
    AngularAcceleration "角加速度量", 
    RelativePosition "相对位置") 
  "枚举类型，定义了矢量所表示的物理量的类型" 
    annotation (Documentation(info="<html>
<table border=\"1\"cellspacing=\"0\"cellpadding=\"2\">
<tr><th><strong>Types.VectorQuantity.</strong></th><th><strong>含义</strong></th></tr>
<tr><td>Force</td>
<td>矢量表示力量量</td></tr>

<tr><td>Torque</td>
<td>矢量表示扭矩量</td></tr>

<tr><td>Velocity</td>
<td>矢量表示速度量</td></tr>

<tr><td>Acceleration</td>
<td>矢量表示加速度量</td></tr>

<tr><td>AngularVelocity</td>
<td>矢量表示角速度量</td></tr>

<tr><td>AngularAcceleration</td>
<td>矢量表示角加速度量</td></tr>

<tr><td>RelativePosition</td>
<td>矢量表示相对位置</td></tr>
</table>
</html>"));