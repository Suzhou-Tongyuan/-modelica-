within Modelica.Electrical.Polyphase.Functions;
function activePower "计算电压和电流输入的有功功率"
  extends Modelica.Icons.Function; // 使用函数图标
  input SI.Voltage v[:] "相电压"; // 输入参数为电压数组
  input SI.Current i[size(v, 1)] "相电流"; // 输入参数为电流数组
  output SI.Power p "有功功率"; // 输出参数为功率
algorithm
  p := sum(v .* i); // 计算有功功率
  annotation (Inline=true, Documentation(info="<html>
<p>
从多相电压和电流计算瞬时功率。
在准静态运行中，瞬时功率等于有功功率；
</p>
</html>"));
end activePower;