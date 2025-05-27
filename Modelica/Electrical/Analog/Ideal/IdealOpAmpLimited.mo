within Modelica.Electrical.Analog.Ideal;
model IdealOpAmpLimited "带限制的理想运算放大器"
  Interfaces.PositivePin in_p "输入端口的正极引脚" annotation(
    Placement(transformation(extent = {{-110, -70}, {-90, -50}}), iconTransformation(extent = {{-110, -70}, {-90, -50}})));
  Interfaces.NegativePin in_n "输入端口的负极引脚" annotation(
    Placement(transformation(extent = {{-110, 50}, {-90, 70}}), iconTransformation(extent = {{-110, 50}, {-90, 70}})));
  Interfaces.PositivePin out "输出引脚" annotation(Placement(
    transformation(extent = {{90, -10}, {110, 10}})));
  Interfaces.PositivePin VMax "输出电压(正)限制" 
    annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}}), iconTransformation(extent = {{-10, 90}, {10, 110}})));
  Interfaces.NegativePin VMin "输出电压(负)限制" 
    annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}}), iconTransformation(extent = {{-10, -110}, {10, -90}})));
  SI.Voltage vin "Input voltage";
protected
  Real s(start = 0, final unit = "1") "辅助变量";
  constant SI.Voltage unitVoltage = 1 annotation(HideResult = true);

equation
  in_p.i = 0;
  in_n.i = 0;
  VMax.i = 0;
  VMin.i = 0;
  vin = in_p.v - in_n.v;
  in_p.v - in_n.v = unitVoltage * smooth(0, (if s < -1 then s + 1 else if s > 1 
    then s - 1 else 0));
  out.v = smooth(0, if s < -1 then VMin.v else if s > 1 then VMax.v else (
    VMax.v - VMin.v) * s / 2 + (VMax.v + VMin.v) / 2);
  annotation(defaultComponentName = "opAmp", 
    Documentation(info = "<html>
<p>
在理想运算放大器(OpAmp)中，如果存在限制，但其输出电压在限制范围内(即VMin和VMax之间)，那么它的行为将类似于没有限制的理想运算放大器。在这种情况下，输入电压vin=in_p.v-in_n.v为零。如果输入电压vin小于0，则输出电压out.v=VMin。如果输入电压vin大于0，则输出电压out.v=VMax。
</p>

</html>", 
    revisions = "<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Line(points = {{60, 0}, {90, 0}}, color = {0, 0, 255}), 
    Polygon(
    points = {{70, 0}, {-70, 80}, {-70, -80}, {70, 0}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 255}), 
    Line(points = {{-100, 60}, {-70, 60}}, color = {0, 0, 255}), 
    Line(points = {{-100, -60}, {-70, -60}}, color = {0, 0, 255}), 
    Line(points = {{-60, 50}, {-40, 50}}, color = {0, 0, 255}), 
    Line(points = {{-50, -40}, {-50, -60}}, color = {0, 0, 255}), 
    Line(points = {{-60, -50}, {-40, -50}}, color = {0, 0, 255}), 
    Line(points = {{70, 0}, {100, 0}}, color = {0, 0, 255}), 
    Line(points = {{-45, -10}, {-10, -10}, {-10, 10}, {20, 10}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(points = {{0, 40}, {0, 100}}, color = {0, 0, 255}), 
    Line(points = {{0, -100}, {0, -40}}, color = {0, 0, 255})}));
end IdealOpAmpLimited;