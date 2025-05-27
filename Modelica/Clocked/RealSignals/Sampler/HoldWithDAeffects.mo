within Modelica.Clocked.RealSignals.Sampler;
block HoldWithDAeffects 
  "保持（模拟）数模转换器效应和计算延迟"
  extends Clocked.RealSignals.Interfaces.PartialSISOHold;

  parameter Boolean computationalDelay = false 
    "=true，如果需要计算延迟" 
    annotation(Evaluate=true, choices(checkBox=true), Dialog(group="计算延迟（秒） = 间隔（） * 移位计数器/分辨率"));
  parameter Integer shiftCounter(min=0,max=resolution) = 0 
    "(最小=0，最大=分辨率)，计算延迟 = 间隔（）*移位计数器/分辨率" 
    annotation(Dialog(enable=computationalDelay, group="计算延迟（秒） = 间隔（） * 移位计数器/分辨率"));
  parameter Integer resolution(min=1) = 1 
    "采样间隔的时间量化分辨率" annotation(Dialog(enable=computationalDelay, group="计算延迟（秒） = 间隔（） * 移位计数器/分辨率"));

  parameter Boolean limited = false "= true，如果限制输出" 
     annotation(Evaluate=true,choices(checkBox=true),Dialog(group="限制和量化"));
  parameter Boolean quantized = false 
    "= true，如果包括输出量化效果" 
    annotation(Evaluate=true,choices(checkBox=true),Dialog(enable=limited,group="限制和量化"));
  parameter Real yMax=1 "输出上限（如果 limited = true）" annotation(Dialog(enable=limited,group="限制和量化"));
  parameter Real yMin=-yMax "输出下限（如果 limited = true）" annotation(Dialog(enable=limited,group="限制和量化"));
  parameter Integer bits(min=1)=8 
    "量化位数（如果量化 = true）" annotation(Dialog(enable=limited and quantized,group="限制和量化"));

  Clocked.RealSignals.Sampler.Utilities.Internal.Limiter limiter(uMax=yMax, 
      uMin=yMin) if limited 
    annotation (Placement(transformation(extent={{-56,-8},{-40,8}})));
  Clocked.RealSignals.Sampler.Utilities.Internal.Quantization quantization(
    quantized=quantized, 
    yMax=yMax, 
    yMin=yMin, 
    bits=bits) if quantized and limited 
    annotation (Placement(transformation(extent={{-18,-8},{-2,8}})));
  Clocked.RealSignals.Sampler.Utilities.Internal.ComputationalDelay compDelay(
      shiftCounter=shiftCounter, resolution=resolution) if 
    computationalDelay 
    annotation (Placement(transformation(extent={{20,-8},{36,8}})));
  Hold hold1(y_start=y_start) 
             annotation (Placement(transformation(extent={{78,-6},{90,6}})));
protected
  Modelica.Blocks.Interfaces.RealInput uFeedthrough2 if not limited 
    annotation (Placement(transformation(extent={{-58,12},{-42,28}})));
  Modelica.Blocks.Interfaces.RealInput uFeedthrough3 if not quantized or not limited 
    annotation (Placement(transformation(extent={{-20,12},{-4,28}})));
  Modelica.Blocks.Interfaces.RealInput uFeedthrough4 if not computationalDelay 
    annotation (Placement(transformation(extent={{18,12},{34,28}})));
  Modelica.Blocks.Interfaces.RealOutput y2 
    annotation (Placement(transformation(extent={{-67,-1},{-65,1}})));
  Modelica.Blocks.Interfaces.RealOutput y3 
    annotation (Placement(transformation(extent={{-29,-1},{-27,1}})));
  Modelica.Blocks.Interfaces.RealOutput y4 
    annotation (Placement(transformation(extent={{9,-1},{11,1}})));
  Modelica.Blocks.Interfaces.RealOutput y5 
    annotation (Placement(transformation(extent={{63,-1},{65,1}})));
equation
  connect(y2, limiter.u) annotation (Line(
      points={{-66,0},{-57.6,0}}, 
      color={0,0,127}));
  connect(y2, uFeedthrough2) annotation (Line(
      points={{-66,0},{-62,0},{-62,20},{-50,20}}, 
      color={0,0,127}));
  connect(limiter.y, y3) annotation (Line(
      points={{-39.2,0},{-28,0}}, 
      color={0,0,127}));
  connect(y3, quantization.u) annotation (Line(
      points={{-28,0},{-19.6,0}}, 
      color={0,0,127}));
  connect(y3, uFeedthrough3) annotation (Line(
      points={{-28,0},{-24,0},{-24,20},{-12,20}}, 
      color={0,0,127}));
  connect(quantization.y, y4) annotation (Line(
      points={{-1.2,0},{10,0}}, 
      color={0,0,127}));
  connect(y4, compDelay.u) annotation (Line(
      points={{10,0},{18.4,0}}, 
      color={0,0,127}));
  connect(uFeedthrough3, y4) annotation (Line(
      points={{-12,20},{6,20},{6,0},{10,0}}, 
      color={0,0,127}));
  connect(y4, uFeedthrough4) annotation (Line(
      points={{10,0},{14,0},{14,20},{26,20}}, 
      color={0,0,127}));
  connect(uFeedthrough2, y3) annotation (Line(
      points={{-50,20},{-32,20},{-32,0},{-28,0}}, 
      color={0,0,127}));

  connect(y5, compDelay.y) annotation (Line(
      points={{64,0},{36.8,0}}, 
      color={0,0,127}));
  connect(y5, uFeedthrough4) annotation (Line(
      points={{64,0},{46,0},{46,20},{26,20}}, 
      color={0,0,127}));

  connect(y5, hold1.u) annotation (Line(
      points={{64,0},{76.8,0}}, 
      color={0,0,127}));
  connect(u, y2) annotation (Line(
      points={{-120,0},{-66,0}}, 
      color={0,0,127}));
  connect(hold1.y, y) annotation (Line(
      points={{90.6,0},{110,0}}, 
      color={0,0,127}));
  annotation (
    defaultComponentName="hold1", 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Ellipse(
          extent={{-88,-30},{-68,-50}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-48,30},{-28,10}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-8,70},{12,50}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{32,10},{52,-10}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Text(visible=computationalDelay, 
          extent={{-150,-150},{150,-190}}, 
          textString="%shiftCounter/%resolution")}), 
    Documentation(info="<html><p>
这个模块类似于保持<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Hold\" target=\"\">Hold</a>&nbsp; 模块。 唯一的区别在于，在将信号转换为零阶保持的连续时间信号之前，对时钟输入信号 u <span style=\"color: rgb(51, 51, 51);\">应用模拟的现实世界效应</span>。 具体来说：
</p>
<li>
如果参数 <strong>computationalDelay</strong> = true， 则输出会延迟一个时钟周期的一部分。 延迟由 shiftCounter/resolution*interval() 定义， 其中 <strong>shiftCounter</strong> 和 <strong>resolution</strong> 是整数参数， interval() 是从前一个时钟脉冲到当前时钟脉冲的时间间隔。 最大可能的计算延迟为一个时钟周期， 因此有一个限制条件 shiftCounter ≤ resolution。</li>
<li>
如果参数 <strong>limited</strong> = true，则输出会受到限制。</li>
<li>
如果参数 <strong>limited</strong> = true 和 <strong>quantized</strong> = true， 则输出会以数字模拟转换器的形式进行值离散化，位数可定义。</li>
<h4>Example</h4><p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.HoldWithDAeffects1\" target=\"\">example</a>&nbsp; &nbsp;对幅度为2.0的正弦信号进行采样， 采样周期为20毫秒，并将其延迟2个采样周期。 结果信号经过“HoldWithDAeffects”模块保持。 因此，hold.u 的时钟开始于40毫秒。 模块的输出 hold.y 是一个连续时间信号， 在仿真开始时就已经存在。 在 hold.u 的时钟第一次触发之前， 它被设置为0.5（即参数 hold.y_start 的值）。 此外，对 hold 模块添加了以下效果：
</p>
<li>
输出限制为 +/- 1.9。</li>
<li>
计算延迟为采样周期的一半（=1/2*20 毫秒=10 毫秒）。<br></li>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/HoldWithDAeffects1_Model.png\" alt=\"HoldWithDAeffects1_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/HoldWithDAeffects1_Result.png\" alt=\"HoldWithDAeffects1_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<br>由于输出信号的限制，hold.u ≥ 1.9 的值仅限于 1.9。
</p>
<p>
如果保持输出被延迟了一个采样周期， 那么输出的是输入的 <strong>previous</strong>(…) 一个值， 第一个触发信号也会延迟一个采样周期， 如上面<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.HoldWithDAeffects2\" target=\"\">modified example</a>&nbsp; &nbsp;所示：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/HoldWithDAeffects2_Model.png\" alt=\"HoldWithDAeffects2_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/HoldWithDAeffects2_Result.png\" alt=\"HoldWithDAeffects2_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<br>注意，如 hold 模块图标所示，一个采样周期的计算延迟由 shiftCounter=1 和 resolution=1 定义。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end HoldWithDAeffects;