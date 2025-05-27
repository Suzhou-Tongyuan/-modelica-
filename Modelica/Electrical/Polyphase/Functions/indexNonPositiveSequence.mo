within Modelica.Electrical.Polyphase.Functions;
function indexNonPositiveSequence 
  "确定所有非正序的索引"
  extends Modelica.Icons.Function; // 使用函数图标
  input Integer m=3 "相数"; // 输入参数为相数，默认为3
  output Integer ind[numberOfSymmetricBaseSystems(m)*(integer(m/numberOfSymmetricBaseSystems(m)) - 1)] 
    "非正序的索引"; // 输出参数为非正序的索引
protected
  constant Integer nBase=numberOfSymmetricBaseSystems(m) "基本系统数量"; // 常量定义基本系统的数量
  constant Integer mBase=integer(m/nBase) "基本系统的相数"; // 常量定义基本系统的相数
algorithm
  if mBase == 1 then
    ind := fill(0, 0); // 如果基本系统相数为1，则索引为空
  elseif mBase == 2 then
    for k in 1:nBase loop
      ind[k] := 2 + 2*(k - 1); // 如果基本系统相数为2，则按规则计算索引
    end for;
  else
    for k in 1:nBase loop
      for i in 1:(mBase-1) loop
        ind[(mBase - 1) * (k - 1) + i] := i + 1 + mBase * (k - 1); // 否则按照公式计算索引
      end for;
    end for;
  end if;
  annotation (Documentation(info="<html>
<p>
此函数确定具有m相数的对称绕组的非正序索引。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">用户指南</a>关于对称分量和方向的指南。
</p>
</html>"));
end indexNonPositiveSequence;