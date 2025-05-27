within Modelica.Electrical.Polyphase.UsersGuide;
class PhaseOrientation "相位定向"
  extends Modelica.Icons.Information;
  annotation (preferredView="info", 
    DocumentationClass=true, 
    Documentation(info="<html>
<p>
<strong>在多相系统中，相位电压和电流的角位移以及机器绕组的空间位移必须遵循相同的规则，即它们基于相同的<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">定向函数</a>。</strong>
</p>
<h4>对称三相系统</h4>
<p>
对称的三相系统由三个角位移为2&pi;/3的正弦波组成。
</p>
<h4>对称多相系统</h4>
<p>
在对称多相系统中，必须区分奇数和偶数相位数。
</p>
<h5>奇数相数</h5>
<p>
对于具有m相的对称多相系统，正弦波的位移为2&pi;/m。
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>图 1: </strong>对称(a)三相和(b)五相电流系统</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/phase35.png\"
           alt=\"phase35.png\">
    </td>
  </tr>
</table>
<h5>偶数相数</h5>
<p>
对于偶数相数的情况，对齐的方向不添加任何信息。相反，m相被分成两个或更多不同的组(基本系统)。
</p>
<p>
相数m可以递归地除以2，直到结果是奇数或2为止。此除法的结果称为m<sub>Base</sub>，基本系统的相数。
基本系统的数量n<sub>Base</sub> 由除法的次数定义，即m=n<sub>Base</sub>*m<sub>Base</sub>。
</p>
<p>
对于具有m<sub>Base</sub>相的基本系统，属于该基本系统的正弦波的位移为2&pi;/m<sub>Base</sub>。
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>图2:</strong>对称(a)六相和(b)十相电流系统</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/phase610.png\"
           alt=\"phase610.png\">
    </td>
  </tr>
</table>
<p>
基本系统的位移定义为&pi;/n<sub>Base</sub>。
</p>
<h4>注意</h4>
<p>
在数组或矩阵中，基本系统是一个接着一个存储的。
</p>
<h4>对称分量</h4>
<p>
对于时间相量的每个基本系统，可以根据Charles L. Fortescue的思想计算对称分量。
</p>
<p>
第一个对称分量是具有正序的直流分量。<br>
在m<sub>Base</sub>=2的情况下，第二个分量是具有负序的逆向分量。<br>
在m<sub>Base</sub>&gt;2的情况下，分量[2..m<sub>Base</sub>-1]是具有非正序的分量，<br>
而最后一个分量 [m<sub>Base</sub>] 是零序分量。
</p>
<p>
这组对称分量对每个n<sub>Base</sub>基本系统都重复一次。
</p>
<h4>多边形连接</h4>
<p>
对于多相系统，m相的星形连接是明确的，即插头的每个引脚都连接到星点引脚，
而对于多边形连接，存在(m<sub>Base</sub>-1)/2种选择(参见图3)。
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>图 3: </strong>不同系统的线到中性电压和线到线电压</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Polyphase/Polygon2phase.png\" alt=\"Polygon2phase.png\">
    </td>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Polyphase/Polygon4phase.png\" alt=\"Polygon4phase.png\">
    </td>
  </tr>
  <tr>
    <td>
      2相系统
    </td>
    <td>
      2=2x2相系统
    </td>
  </tr>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Polyphase/Polygon3phase.png\" alt=\"Polygon3phase.png\">
    </td>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Polyphase/Polygon6phase.png\" alt=\"Polygon6phase.png\">
    </td>
  </tr>
  <tr>
    <td>
      3相系统
    </td>
    <td>
      6=2x3相系统
    </td>
  </tr>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Polyphase/Polygon5phase.png\" alt=\"Polygon5phase.png\">
    </td>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Polyphase/Polygon7phase.png\" alt=\"Polygon7phase.png\">
    </td>
  </tr>
  <tr>
    <td>
      5相系统：2种替代多边形连接
    </td>
    <td>
      7相系统：3种替代多边形连接
    </td>
  </tr>
</table>
<p>
因此，使用<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiDelta\">MultiDelta</a>组件时，
必须通过参数kPolygon指定替代方案。
</p>
<h4>另请参阅</h4>
<p>
关于多相绕组的<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">用户指南</a>。
</p>
</html>"));
end PhaseOrientation;