within Modelica.Magnetic.QuasiStatic.FundamentalWave.UsersGuide;
class Concept "基本波概念"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h5>参考帧</h5>

<p>准静态磁口包含复磁通(流量变量)、复磁位差(位差变量)和参考角。不同复相量相对于不同参考之间的关系将用复磁通量来解释。同样的变换关系也适用于复磁位差。然而，所讨论的关系对于处理气隙模型中的连接器，将方程转换为转子固定参考系等都是重要的.</p>

<p>
让我们假设气隙模型包含与机器的不同侧面相关的定子和转子磁端口。这两个端口之间的角度关系是
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_relationship.png\"/>,
</div>

<p>其中
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_s.png\"/>
连接器是定子端口的参考角度吗,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_r.png\"/>
是接头参考角度的转子端口，和
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_mechanical.png\"/>
法兰和支座的机械角度分别是差值吗,
乘以极对的个数,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/p.png\"/>.
定子和转子参考角与电机的电频率直接相关
定子的电路,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/f_s.png\"/>,
和转子,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/f_r.png\"/>,
分别，通过:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/gamma_f.png\"/>
</div>

<p>
这是准静态电畴和准静态磁畴之间电磁耦合的严格结果.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> 准静态基波库的参考系</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/ReferenceFrames.png\"/>
    </td>
  </tr>
</table>

<p>
定子磁口和转子磁口的复磁通相等,
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi(ref)=Phi,re+jPhi,im.png\"/>,
</div>

<p>
但根据上述关系，参考相位角是不同的。定子和转子参考角是指准静态磁性连接器。(定子)端口相对于<strong>定子固定</strong>参考系的复磁通量由式计算</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_s_ref.png\"/>.
</div>

<p>
然后计算(转子)磁口相对于<strong>转子固定</strong>参照系的复磁通量</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_r_ref.png\"/>.
</div>

<p>
定子和转子的两个固定复磁通是由</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FundamentalWave/Phi_r_s.png\"/>.
</div>

</html>"));
end Concept;