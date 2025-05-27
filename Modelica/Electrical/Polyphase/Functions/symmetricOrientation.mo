within Modelica.Electrical.Polyphase.Functions;
function symmetricOrientation 
  "结果基波场相量的方向"
  extends Modelica.Icons.Function; // 使用函数图标
  input Integer m "相数"; // 输入参数为相数
  output SI.Angle orientation[m] 
    "结果基波场相量的方向"; // 输出参数为方向
  import Modelica.Constants.pi; // 导入π常数
algorithm
  if mod(m, 2) == 0 then // 如果相数为偶数
    // Even number of phases
    if m == 2 then // 如果相数为2
      // Special case two phase machine
      orientation[1] := 0; // 第一个相位的方向为0
      orientation[2] := +pi/2; // 第二个相位的方向为π/2
    else // 如果相数不为2
      orientation[1:integer(m/2)] := symmetricOrientation(integer(m/2)); // 前一半相位的方向
      orientation[integer(m/2) + 1:m] := symmetricOrientation(integer(m/2)) 
         - fill(pi/m, integer(m/2)); // 后一半相位的方向
    end if;
  else // 如果相数为奇数
    // Odd number of phases
    orientation := {(k - 1)*2*pi/m for k in 1:m}; // 计算方向
  end if;
  annotation (Documentation(info="<html>
<p>
该函数确定具有m相的对称绕组的方向角度。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">用户指南</a>关于对称分量和方向的内容。
</p>
</html>"));
end symmetricOrientation;