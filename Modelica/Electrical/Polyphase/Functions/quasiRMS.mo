within Modelica.Electrical.Polyphase.Functions;
function quasiRMS "计算输入的连续准有效值"
  extends Modelica.Icons.Function; // 使用函数图标
  input Real x[:]; // 输入参数为实数数组
  output Real y; // 输出参数为实数
algorithm
  y := sqrt(sum(x .^ 2/size(x, 1))); // 计算准有效值
  annotation (Inline=true, Documentation(info="<html>
<p>
此函数确定多相系统的连续准<a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a>值，表示等效的RMS向量或矢量。如果输入波形偏离正弦曲线，则传感器的输出将不会完全是平均RMS值。
</p>
<blockquote><pre>
y=sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end quasiRMS;