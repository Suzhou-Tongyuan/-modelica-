within Modelica.Electrical.Polyphase.Functions;
function symmetricTransformationMatrix 
  "用于对称分量的变换矩阵"
  extends Modelica.Icons.Function; // 使用函数图标
  import Modelica.ComplexMath.fromPolar; // 导入复数工具箱
  input Integer m "相数"; // 输入参数为相数
  output Complex tM[m, m] 
    "m相对称分量的变换矩阵"; // 输出参数为m相对称分量的变换矩阵
protected
  Integer nBase=numberOfSymmetricBaseSystems(m); // 基本对称系统数量
  Integer mBase=integer(m/nBase); // 每个基本对称系统的相数
  Real factor=nBase/m; // 因子
  SI.Angle oM[m,m]=symmetricOrientationMatrix(m); // 对称方向矩阵
algorithm
  // 仅填充基本系统内的元素
  for i in 1:nBase loop
    for j in 1:nBase loop
      for ii in (i - 1)*mBase + 1:i*mBase loop
        for jj in (j - 1)*mBase + 1:j*mBase loop
          tM[ii,jj] :=fromPolar(if i==j then factor else 0, oM[ii,jj]); // 使用极坐标填充变换矩阵
        end for;
      end for;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
该函数确定具有m相的对称绕组的变换矩阵。
</p>
<p>
该变换矩阵可用于从时间相量确定对称分量。
</p>
<h4>参见</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">用户指南</a>关于对称分量和方向的内容。
</p>
</html>"));
end symmetricTransformationMatrix;