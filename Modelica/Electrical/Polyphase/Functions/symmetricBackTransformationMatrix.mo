within Modelica.Electrical.Polyphase.Functions;
function symmetricBackTransformationMatrix 
  "用于对称分量的逆变换矩阵"
  extends Modelica.Icons.Function; // 使用函数图标
  import Modelica.ComplexMath.fromPolar; // 导入复数工具箱
  input Integer m "相数"; // 输入参数为相数
  output Complex bTM[m, m] 
    "m相对称分量的逆变换矩阵"; // 输出参数为m相对称分量的逆变换矩阵
protected
  Integer nBase=numberOfSymmetricBaseSystems(m); // 基本对称系统数量
  Integer mBase=integer(m/nBase); // 每个基本对称系统的相数
  Real factor=1; // 因子为1
  SI.Angle oM[m,m]=symmetricOrientationMatrix(m); // 对称方向矩阵
algorithm
  // 逆变换（在基本系统内）：共轭和转置
  for i in 1:nBase loop
    for j in 1:nBase loop
      for ii in (i - 1)*mBase + 1:i*mBase loop
        for jj in (j - 1)*mBase + 1:j*mBase loop
          bTM[ii,jj] :=fromPolar(if i==j then factor else 0, -oM[jj,ii]); // 使用极坐标填充逆变换矩阵
        end for;
      end for;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
该函数确定具有m相的对称绕组的逆变换矩阵。
</p>
<p>
逆变换矩阵可用于从对称分量确定时间相量。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">用户指南</a>关于对称分量和方向的内容。
</p>
</html>"));
end symmetricBackTransformationMatrix;