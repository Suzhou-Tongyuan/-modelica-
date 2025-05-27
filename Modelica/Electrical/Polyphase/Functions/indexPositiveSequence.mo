within Modelica.Electrical.Polyphase.Functions;
function indexPositiveSequence 
  "确定所有正序的索引"
  extends Modelica.Icons.Function; // 使用函数图标
  input Integer m=3 "相数"; // 输入参数为相数，默认为3
  output Integer ind[numberOfSymmetricBaseSystems(m)] 
    "对称基本系统的数量"; // 输出参数为对称基本系统的数量
protected
  Integer n=numberOfSymmetricBaseSystems(m); // 计算对称基本系统的数量
algorithm
  if n == 1 then
    ind[1] := 1; // 如果基本系统数量为1，则索引为1
  else
    ind := (0:n - 1)*integer(m/n) + ones(n); // 否则按照公式计算索引
  end if;
  annotation (Documentation(info="<html>
<p>
此函数确定具有m相数的对称绕组的正序索引。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">用户指南</a>关于对称分量和方向的指南。
</p>
</html>"));
end indexPositiveSequence;