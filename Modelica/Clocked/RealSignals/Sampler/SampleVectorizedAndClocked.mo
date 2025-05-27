within Modelica.Clocked.RealSignals.Sampler;
block SampleVectorizedAndClocked 
  "对连续实时输入信号矢量进行采样，并将其作为时钟输出信号矢量，时钟作为输入信号"
  extends Clocked.RealSignals.Interfaces.SamplerIcon;
  parameter Integer n(min=1)=1 
    "输入信号向量 u 的大小（= 输出信号向量 y 的大小）";
  Modelica.Blocks.Interfaces.RealInput u[n] 
    "连续时间、实数输入信号矢量连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[n] 
    "时钟实数输出信号矢量连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
   Clocked.ClockSignals.Interfaces.ClockInput clock 
    "输出信号向量 y 与该时钟输入相关联" 
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
equation
  y = sample(u,clock);

  annotation (
   defaultComponentName="sample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Line(
          points={{0,-100},{0,18}}, 
          color={175,175,175}, 
          pattern=LinePattern.Dot, 
          thickness=0.5), 
        Text(
          extent={{-150,-40},{20,-90}}, 
          textColor={0,0,0}, 
          textString="n=%n"), 
    Text(
        extent={{-150,90},{150,50}}, 
        textString="%name", 
        textColor={0,0,255})}), 
    Documentation(info="<html>
<p>
这个模块类似于
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\">SampleClocked</a>模块。
唯一的区别在于连续时间输入信号是一个向量：
所有输入信号都被采样，
并且与通过第二个输入提供的标量时钟信号相关联。
</p>

<h4>例如</h4>

<p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SampleVectorizedAndClocked\">example</a>
具有一个向量作为输入，包含两个不同的正弦信号。这些信号将使用周期为20毫秒的周期时钟进行采样：
<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleVectorizedAndClocked_Model.png\" alt=\"SampleVectorizedAndClocked_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleVectorizedAndClocked_Result.png\" alt=\"SampleVectorizedAndClocked_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result<br></td>
   </tr>
</table>
</html>"));
end SampleVectorizedAndClocked;