within Modelica.Mechanics.MultiBody.Interfaces;
partial function partialGravityAcceleration 
  "用于World对象中重力函数的接口"
  extends Modelica.Icons.Function;
  input SI.Position r[3] 
    "从全局坐标系到实际点的位置矢量，在全局坐标系中解析";
  output SI.Acceleration gravity[3] 
    "在位置r处的重力加速度，在全局坐标系中解析";
  annotation (Documentation(info="<html>
<p>
此部分函数定义了用于World对象中重力函数的接口。
所有重力场函数都必须继承自此函数。
函数的输入是重力场中某一点的绝对位置矢量，而输出是该点处的重力加速度，在全局坐标系中解析。
</p>
</html>"));
end partialGravityAcceleration;