within Modelica.ComplexBlocks.Sources;
block ComplexRampPhasor "生成一个幅值呈斜坡变化且角度恒定的相位"
  extends Modelica.ComplexBlocks.Interfaces.ComplexSO;
  import Modelica.Constants.eps;
  parameter Real magnitude1(final min = 0, start = 1) "起始时间的复相位幅度" 
    annotation(Dialog(groupImage = "modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasor.png"));
  parameter Real magnitude2(final min = 0, start = 1) "起始时间+持续时间的复相位幅度";
  parameter Boolean useLogRamp = false "斜坡在对数刻度上呈线性，如果为真";
  parameter Modelica.Units.SI.Angle phi(start = 0) "复相位角";
  parameter Modelica.Units.SI.Time startTime = 0 "频率扫描开始时间";
  parameter Modelica.Units.SI.Time duration(min = 0.0, start = 1) "斜坡持续时间(= 0.0为一个台阶)";
  Real magnitude "复相位的实际幅度";
equation
  assert(not useLogRamp or (magnitude1 > eps and magnitude2 > eps), 
    "ComplexRampPhasor: 当useLogRamp = true时，magnitude1和magnitude2必须大于eps");
  magnitude = if not useLogRamp then 
    magnitude1 + (if time < startTime then 
    0 else 
    if time < (startTime + max(duration, eps)) then 
    (time - startTime) * (magnitude2 - magnitude1) / max(duration, eps) 
    else 
    magnitude2 - magnitude1) 
    else 
    if time < startTime then magnitude1 else 
    if time < (startTime + max(duration, eps)) then 
    10 ^ (log10(magnitude1) + (log10(magnitude2) - log10(magnitude1)) * min(1, (time - startTime) / max(duration, eps))) 
    else 
    magnitude2;

  y = magnitude * Modelica.ComplexMath.exp(Complex(0, phi));

  annotation(defaultComponentName = "complexRamp", 
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
    -100}, {100, 100}}), graphics = {Line(
    points = {{0, -8}, {24, 12}}, 
    color = {85, 170, 255}), 
    Polygon(
    points = {{38, 24}, {17, 15}, {26, 4}, {38, 24}}, 
    lineColor = {85, 170, 255}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid), Line(
    points = {{0, 8}, {60, 58}}, 
    color = {85, 170, 255}), 
    Polygon(
    points = {{76, 72}, {55, 63}, {64, 52}, {76, 72}}, 
    lineColor = {85, 170, 255}, 
    fillColor = {85, 170, 255}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Line(points = {{0, -80}, {0, 68}}, 
    color = {192, 192, 192}), Polygon(
    points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid)}), Documentation(info = "<html>
<p>
输出y是一个复数相位，其角度恒定而幅值是一个斜坡函数。
</p>

<p>
如果 <code>useLogRamp == false</code>，幅值的斜坡是线性的：
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasorLinear.png\"
     alt=\"ComplexRampPhasorLinear.png\">
</div>

<p>
如果 <code>useLogRamp == true</code>，幅值的斜坡在对数尺度上呈现线性变化：
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/ComplexBlocks/Sources/ComplexRampPhasorLog.png\"
     alt=\"ComplexRampPhasorLog.png\">
</div>

</html>"));
end ComplexRampPhasor;