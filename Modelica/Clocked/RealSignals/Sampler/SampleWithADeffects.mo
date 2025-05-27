within Modelica.Clocked.RealSignals.Sampler;
block SampleWithADeffects 
  "模拟数字转换器效应（包括噪音）采样"
  extends Clocked.RealSignals.Interfaces.PartialSISOSampler;

  parameter Boolean noisy = false 
    "= true，如果输出应与噪声叠加" 
    annotation(Evaluate=true,choices(checkBox=true),Dialog(group="采样和噪音"));

  parameter Boolean limited = false "= true，如果限制输出" 
    annotation(Evaluate=true,choices(checkBox=true),Dialog(group="限制和量化"));
  parameter Boolean quantized = false 
    "= true，如果包括输出量化效果" 
    annotation(Evaluate=true,choices(checkBox=true),Dialog(enable=limited,group="限制和量化"));
  parameter Real yMax=1 "输出上限（如果 limited = true）" annotation(Dialog(enable=limited,group="限制和量化"));
  parameter Real yMin=-yMax "输出下限（如果 limited = true）" annotation(Dialog(enable=limited,group="限制和量化"));
  parameter Integer bits(min=1)=8 
    "量化位数（如果量化 = true）" annotation(Dialog(enable=limited and quantized,group="限制和量化"));

  Sample sample1 
    annotation (Placement(transformation(extent={{-84,-6},{-72,6}})));

  replaceable Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoise noise if noisy 
    constrainedby Clocked.RealSignals.Interfaces.PartialNoise "噪声模型" 
    annotation (
    choicesAllMatching=true, 
    Dialog(enable=noisy, group="采样与噪声"), 
    Placement(transformation(extent={{-54,-6},{-42,6}})));
  Clocked.RealSignals.Sampler.Utilities.Internal.Limiter limiter(uMax=yMax, 
      uMin=yMin) if limited 
    annotation (Placement(transformation(extent={{-24,-8},{-8,8}})));
  Clocked.RealSignals.Sampler.Utilities.Internal.Quantization quantization(
    quantized=quantized, 
    yMax=yMax, 
    yMin=yMin, 
    bits=bits) if quantized and limited 
    annotation (Placement(transformation(extent={{14,-8},{30,8}})));
protected
  Modelica.Blocks.Interfaces.RealInput uFeedthrough1 if not noisy 
    annotation (Placement(transformation(extent={{-58,12},{-42,28}})));
  Modelica.Blocks.Interfaces.RealInput uFeedthrough2 if not limited 
    annotation (Placement(transformation(extent={{-26,12},{-10,28}})));
  Modelica.Blocks.Interfaces.RealInput uFeedthrough3 if not quantized or not limited 
    annotation (Placement(transformation(extent={{12,12},{28,28}})));
  Modelica.Blocks.Interfaces.RealOutput y1 
    "带实数输出信号的连接器" 
    annotation (Placement(transformation(extent={{-61,-1},{-59,1}})));
  Modelica.Blocks.Interfaces.RealOutput y2 
    annotation (Placement(transformation(extent={{-35,-1},{-33,1}})));
  Modelica.Blocks.Interfaces.RealOutput y3 
    annotation (Placement(transformation(extent={{3,-1},{5,1}})));
  Modelica.Blocks.Interfaces.RealOutput y4 
    annotation (Placement(transformation(extent={{41,-1},{43,1}})));

equation
  connect(uFeedthrough1, y1) annotation (Line(
      points={{-50,20},{-58,20},{-58,0},{-60,0}}, 
      color={0,0,127}));
  connect(y1, noise.u) annotation (Line(
      points={{-60,0},{-55.2,0}}, 
      color={0,0,127}));
  connect(noise.y, y2) annotation (Line(
      points={{-41.4,0},{-34,0}}, 
      color={0,0,127}));
  connect(y2, limiter.u) annotation (Line(
      points={{-34,0},{-25.6,0}}, 
      color={0,0,127}));
  connect(uFeedthrough1, y2) annotation (Line(
      points={{-50,20},{-38,20},{-38,0},{-34,0}}, 
      color={0,0,127}));
  connect(y2, uFeedthrough2) annotation (Line(
      points={{-34,0},{-30,0},{-30,20},{-18,20}}, 
      color={0,0,127}));
  connect(limiter.y, y3) annotation (Line(
      points={{-7.2,0},{4,0}}, 
      color={0,0,127}));
  connect(y3, quantization.u) annotation (Line(
      points={{4,0},{12.4,0}}, 
      color={0,0,127}));
  connect(y3, uFeedthrough3) annotation (Line(
      points={{4,0},{8,0},{8,20},{20,20}}, 
      color={0,0,127}));
  connect(quantization.y, y4) annotation (Line(
      points={{30.8,0},{42,0}}, 
      color={0,0,127}));
  connect(uFeedthrough3, y4) annotation (Line(
      points={{20,20},{38,20},{38,0},{42,0}}, 
      color={0,0,127}));
  connect(uFeedthrough2, y3) annotation (Line(
      points={{-18,20},{0,20},{0,0},{4,0}}, 
      color={0,0,127}));

  connect(sample1.y, y1) annotation (Line(
      points={{-71.4,0},{-60,0}}, 
      color={0,0,127}));

  connect(u, sample1.u) annotation (Line(
      points={{-120,0},{-85.2,0}}, 
      color={0,0,127}));
  connect(y4, y) annotation (Line(
      points={{42,0},{110,0}}, 
      color={0,0,127}));
  annotation (
   defaultComponentName="sample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Polygon(
          points={{0,-22},{-6,-38},{6,-38},{0,-22}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{0,-100},{0,-38}},color={192,192,192}), 
        Line(points={{-40,-72},{40,-72}}, color={192,192,192}), 
        Polygon(
          points={{0,8},{-6,-8},{6,-8},{0,8}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid, 
          origin={48,-72}, 
          rotation=-90), 
        Line(
          points={{-30,-92},{-10,-92},{-10,-72},{10,-72},{10,-52},{30,-52}}, 
          color={0,0,127}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
该功能块与<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">Sample</a>
模块类似。唯一不同的是，在对输入信号进行采样后，会对采样信号施加模拟真实世界的效果。特别是：
</p>

<ul>
<li> 如果参数 <strong>limited</strong> = true，输出将受到限制。</li>
<li> 如果参数 <strong>limited</strong> = true 和 <strong>quantized</strong> = true，输出将以具有可定义位数的模数转换器形式离散化。
<li> 如果参数 <strong>noisy</strong> = true，则在输出中加入噪声。
      伪随机数发生器用于生成给定频带内均匀分布的随机数。
</li>
</ul>

<h4>Example</h4>

<p>
下面的<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SampleWithADeffects\">example</a>
采样了一个周期为 20 毫秒的正弦信号，并添加了以下效果：
</p>
<ul>
<li> 将输出限制为 +/- 0.8。</li>
<li> 使用 8 位 AD 转换器将输出离散化。</li>
<li> 添加带宽为 +/- 0.2 的大均匀噪声。</li>
</ul>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleWithADeffects_Model.png\" alt=\"SampleWithADeffects_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleWithADeffects_Result.png\" alt=\"SampleWithADeffects_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
<br>输出信号 y 与连续时间输入信号相距甚远，这是由于对采样输入施加的强烈离散化和大量噪音所致。
</p>
</html>"));
end SampleWithADeffects;