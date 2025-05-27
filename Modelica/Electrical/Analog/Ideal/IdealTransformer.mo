within Modelica.Electrical.Analog.Ideal;
model IdealTransformer "理想变压器的铁心(考虑变压器铁心是否磁化)"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  parameter Real n(start = 1) "一次侧与二次侧的电压之比";
  parameter Boolean considerMagnetization = false 
    "考虑磁化的选择";
  parameter SI.Inductance Lm1(start = 1) 
    "主迁回感应电抗(主磁涡流阻抗)" 
    annotation(Dialog(enable = considerMagnetization));
protected
  SI.Current im1 "Magnetization current w.r.t. primary side";
  SI.MagneticFlux psim1 "Magnetic flux w.r.t. primary side";
equation
  im1 = i1 + i2 / n;
  if considerMagnetization then
    psim1 = Lm1 * im1;
    v1 = der(psim1);
  else
    psim1 = 0;
    im1 = 0;
  end if;
  v1 = n * v2;
  annotation(defaultComponentName = "transformer", 
    Documentation(info = "<html>
<p>
理想变压器是一个双端口电路元件；在考虑布尔参数的情况下，如果<code>considerMagnetization=false</code>，则其特征由以下方程式描述：
</p>

<blockquote><pre>
i2 = -i1*n;
v2 =  v1/n;
</pre></blockquote>

<p>
其中<code>n</code>其中n是一个被称为匝数比的实数。由于这些方程，直流电压和电流也会被转换(但是这在技术变压器中并非如此)。
</p>

<p>
在布尔参数的情况下，如果<code>considerMagnetization=true</code>，那么存在以下方程：
</p>

<blockquote><pre>
im1  = i1 + i2/n \"相对于一次侧的磁化电流\";
psim1= Lm1*im1   \"相对于一次侧的磁感应\";
v1 = der(psim1)  \"一次侧电压\";
v2 = v1/n        \"二次侧电压\";
</pre></blockquote>
<p>
其中<code>Lm</code>表示磁化电感。根据这些方程，二次侧的电压和电流的直流偏置会随着时间的变化而减小。
</p>
<p>
对于一次侧<code>L1sigma</code>和二次侧<code>L2ssigma</code>，与基本变压器<a href=\"modelica://Modelica.Electrical.Analog.Basic.Transformer\">basic transformer</a>相比，可以应用以下参数转换(这将导致相同的结果)：
</p>

<blockquote><pre>
L1 = L1sigma + M*n \"次级空载时的主绕组电感\";
L2 = L2sigma + M/n \"初级空载时的次级绕组电感\";
M  = Lm1/n         \"互感\";
</pre></blockquote>
<p>
在能量转换过程中，需要决定漏磁如何在设备的输入和输出部分之间分配。

</html>", 
    revisions = "<html>
<ul>
<li><em>2009年3月11日</em>
       作者：Christoph Clauss<br>添加了条件热口<br>
       </li>
<li><em>1998年</em>
       作者：Christoph Clauss<br>最初实现<br>
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Text(extent = {{-150, -110}, {150, -150}}, textString = "n=%n"), 
    Text(
    extent = {{-100, 20}, {-60, -20}}, 
    textColor = {0, 0, 255}, 
    textString = "1"), 
    Text(
    extent = {{60, 20}, {100, -20}}, 
    textColor = {0, 0, 255}, 
    textString = "2"), 
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(points = {{-40, 60}, {-40, 100}, {-90, 100}}, color = {0, 0, 255}), 
    Line(points = {{40, 60}, {40, 100}, {90, 100}}, color = {0, 0, 255}), 
    Line(points = {{-40, -60}, {-40, -100}, {-90, -100}}, color = {0, 0, 255}), 
    Line(points = {{40, -60}, {40, -100}, {90, -100}}, color = {0, 0, 255}), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {-33, 45}, 
    rotation = 270), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {-33, 15}, 
    rotation = 270), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {-33, -15}, 
    rotation = 270), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {-33, -45}, 
    rotation = 270), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {33, 45}, 
    rotation = 90), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {33, 15}, 
    rotation = 90), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {33, -15}, 
    rotation = 90), 
    Line(
    points = {{-15, -7}, {-14, -1}, {-7, 7}, {7, 7}, {14, -1}, {15, -7}}, 
    color = {0, 0, 255}, 
    smooth = Smooth.Bezier, 
    origin = {33, -45}, 
    rotation = 90)}));
end IdealTransformer;