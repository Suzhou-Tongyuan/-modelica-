within Modelica.ComplexBlocks.Routing;
model ComplexPassThrough 
  "无需修改即可通过复数信号"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSISO;
equation
  y = u;
  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
    -100}, {100, 100}}), graphics = {Line(points = {{-100, 0}, {100, 0}}, 
    color = {85, 170, 255})}), 
    Documentation(info = "<html>
<p>
将一个复数信号不经修改地传递。使得可以从一个总线读取信号，更改它们的名称并发送回总线。
</p>
</html>"));
end ComplexPassThrough;