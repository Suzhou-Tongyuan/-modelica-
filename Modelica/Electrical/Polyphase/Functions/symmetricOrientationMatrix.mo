within Modelica.Electrical.Polyphase.Functions;
function symmetricOrientationMatrix 
  "用于创建对称变换矩阵的矩阵对称方向角"
  extends Modelica.Icons.Function;  // 使用函数图标
  import Modelica.Constants.pi;  // 导入π常数
  input Integer m "相数";  // 输入参数为相数
  output SI.Angle oM[m,m] 
    "对称变换矩阵的角度";  // 输出参数为对称变换矩阵的角度
protected
  Integer nBase = numberOfSymmetricBaseSystems(m);  // 基本对称系统数量
  Integer mBase = integer(m / nBase);  // 每个基本对称系统的相数
  SI.Angle o[m] = symmetricOrientation(m);  // 所有相位的对称方向角
  SI.Angle oBase[numberOfSymmetricBaseSystems(m)] = o[1:mBase:m];  // 基本对称系统的方向角
algorithm
  // 使用零初始化变换矩阵
  oM := zeros(m, m);
  // mBase 可能为 2
  if mBase == 2 then
    oM[1:mBase,1:mBase] := {o[1:mBase], -o[1:mBase]};  // 填充对称变换矩阵
  else  // 或者为奇数
    for j in 1:mBase loop
      oM[j,1:mBase] := j * o[1:mBase];  // 填充对称变换矩阵
    end for;
  end if;
  // 沿对角线移动基本方向矩阵 nBase 次
  for i in 2:nBase loop
    for k in 1:mBase loop
      //oM[(i - 1)*mBase + k, (i - 1)*mBase + 1:i*mBase] := oM[k, 1:mBase] + fill(oBase[i], mBase);
      for j in 1:mBase loop
        oM[(i - 1) * mBase + k,(i - 1) * mBase + j] := oM[k,j] + oBase[i];  // 填充对称变换矩阵
      end for;
    end for;
  end for;
  annotation(Documentation(info = "<html>
<p>
该函数确定具有m相的对称绕组的方向矩阵。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">用户指南</a>关于对称分量和方向的内容。
</p>
</html>"));
end symmetricOrientationMatrix;