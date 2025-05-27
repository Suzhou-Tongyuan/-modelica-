within Modelica.Electrical.Polyphase.Functions;
function numberOfSymmetricBaseSystems 
  "确定m相对称系统的对称基本系统数量"
  extends Modelica.Icons.Function; // 使用函数图标
  input Integer m=3 "相数"; // 输入参数为相数，默认为3
  output Integer n "对称基本系统数量"; // 输出参数为对称基本系统数量
algorithm
  // 初始化基本系统数量
  n := 1;
  if mod(m, 2) == 0 then
    // 偶数相数
    if m == 2 then
      // 两相机器的特殊情况
      n := 1;
    else
      n := n*2*numberOfSymmetricBaseSystems(integer(m/2)); // 乘以2倍的下一个基本系统数量
    end if;
  else
    // 奇数相数
    n := 1;
  end if;
  annotation (Documentation(info="<html>
<p>
该函数确定具有m相的对称绕组的基本系统数量。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">用户指南</a>关于对称分量和方向的内容。
</p>
</html>"));
end numberOfSymmetricBaseSystems;