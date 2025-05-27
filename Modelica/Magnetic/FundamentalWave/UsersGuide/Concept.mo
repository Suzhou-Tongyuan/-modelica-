within Modelica.Magnetic.FundamentalWave.UsersGuide;
class Concept "基本波概念"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>

<h4>基本波概念概述</h4>

<p>
电机气隙中的确切磁场通常是通过电磁有限元分析确定的。磁场的波形，例如磁位差<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m_phi.png\">，由空间基波(相对于等效的两极机)和不同阶次的附加谐波组成。然而，基波在电机的气隙中占主导地位.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> 四极感应电机的磁场线</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Concept/aimc_fem.png\">
    </td>
  </tr>
</table>

<p>
在基本波理论中，只假定磁量的纯正弦分布。因此，假定不考虑所有其他谐波效应.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2:</strong> 四极电机的磁电位差，其中<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/varphi.png\">为空间域相对于一极对的角度</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Concept/four_pole_V_m.png\">
    </td>
  </tr>
</table>

<p>
磁场量的波形，例如磁位差<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m_phi.png\">，可以用复相量表示，例如<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\">:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m_real_complex.png\">
</p>

<p>值得注意的是，该库中使用的磁势总是</strong>指的是等效的两极电机.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3:</strong> Spatial distribution of the magnetic potential difference (red shade = positive sine wave, blue shade = negative sine wave) including complex phasor representing this spatial distribution</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Concept/electrical_reference_V_m.png\">
    </td>
  </tr>
</table>

<p>
该库的势量和流量是在基本的<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">magnetic port</a>。由于磁势和磁通呈正弦分布，所以可以采用这种复相量表示。这样，FundamentalWave库可以被看作是<a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a>库.
</p>

<p>
在具有<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/p.png\">极对的电机中，绕组的特定排列会产生正弦波优势磁势波。该波的空间周期由一个极对决定
[<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Mueller70</a>,
 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Spaeth73</a>].
</p>

<p>
基于FundamentalWave库的电机模型的主要组件是<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components. SymmetricPolyphaseWinding\">polyphase</a> 和 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components. SinglePhaseWinding\">single-phase windings</a>， <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components. RotorSaliencyAirGap\">air gap</a> 以及<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components. SymmetricPolyphaseWinding\">symmetric</a> 和 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components. SaliencyCageWinding\">salient cage</a>型号。
本库中提供的电机模型基于定子的对称绕组和鼠笼式转子的等效两相或三相绕组。滑环感应电机的定子和转子的相数可能不同。
</p>

<h4>Assumptions</h4>

<p>
FundamentalWave库的机器模型目前基于以下假设
</p>

<ul>
<li>定子相数大于或等于三相
    [<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Eckhardt82</a>]
    </li>
<li>假定相绕组是对称的；可以考虑对这一方法进行扩展</li>
<li>只考虑基波效应</li>
<li>磁势差指的是等效的两极机器</li>
<li>对电压和电流的波形没有限制</li>
<li>所有的电阻和电感都被建模为常量;饱和效应，交叉耦合效应
(<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Li07</a>]，电阻的温度依赖性和深棒效应可以在该库的扩展中考虑</li>
<li>目前尚未考虑磁滞损耗 [<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Haumer09</a>]</li>
<li>电机模型的损耗为
    <ul>
    <li>欧姆热损失,</li>
    <li>定子铁芯中的涡流损耗,</li>
    <li>杂散负载损耗,</li>
    <li>摩擦损失.</li>
    </ul>
</li>
</ul>

<h4>备注</h4>

<p>
术语<strong>基波</strong>是指电磁量的空间波。该库对任何电压、电流等时域信号的波形没有限制。.
</p>
</html>"));
end Concept;