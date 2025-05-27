within Modelica.Electrical.QuasiStatic.Polyphase.Functions;
function activePower 
  "计算复数输入电压和电流的有功功率"
  extends Modelica.Icons.Function;
  input SI.ComplexVoltage v[:] 
    "准静态电压相量";
  input SI.ComplexCurrent i[size(v, 1)] 
    "准静态电流相量";
  output SI.Power p "有功功率";
algorithm
  p := sum(Modelica.ComplexMath.real({v[k]*Modelica.ComplexMath.conj(i[k]) 
    for k in 1:size(v, 1)}));
  annotation (Inline=true, Documentation(info="<html>
<p>
从多相电压和电流计算瞬时功率。
在准静态运行中，瞬时功率等于有功功率；
</p>
</html>"));
end activePower;