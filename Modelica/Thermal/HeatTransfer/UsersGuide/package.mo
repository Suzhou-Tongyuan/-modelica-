within Modelica.Thermal.HeatTransfer;
package UsersGuide "用户指南"
  extends Modelica.Icons.Information;

  annotation (
    preferredView="info", 
    DocumentationClass=true, 
    Documentation(info="<html><p>
该库包含用于建模基于集总元件的<strong>一维热传递</strong>的组件。这尤其允许对元件中的传热进行建模，<span style=\"color: rgb(64, 64, 64);\">前提是集总元件的参数</span>（如元件的热容）可以通过测量确定 (<span style=\"color: rgb(64, 64, 64);\">由于元件中使用的几何结构复杂且材料多样，通常无法通过一些基本的解析公式计算集总元件的参数</span>）.
</p>
<p>
如何使用这个库的示例模型在子库<strong>Examples</strong>中给出。<br> <span style=\"color: rgb(64, 64, 64);\">对于一个简单的初始示例，请参见</span><strong>Examples.TwoMasses</strong>。<span style=\"color: rgb(64, 64, 64);\">其中两个具有不同初始温度的物体相互接触，经过一段时间后达到相同的温度。</span><br> <strong>Examples.ControlledTemperature</strong><span style=\"color: rgb(64, 64, 64);\">展示了如何通过开关电阻将温度控制在期望的范围内</span>。<br> <strong>Examples.Motor</strong><span style=\"color: rgb(64, 64, 64);\">提供了一个更贴近实际的示例，其中对电动机的发热进行了建模。以下是该示例的截图：</span>
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Thermal/HeatTransfer/driveWithHeatTransfer.png\" alt=\"driveWithHeatTransfer\" data-href=\"\" style=\"\"/>
</p>
<p>
<span style=\"color: rgb(64, 64, 64);\">组件左右两侧的</span><span style=\"color: rgb(64, 64, 64);\"><strong>实心红色方块</strong></span><span style=\"color: rgb(64, 64, 64);\">和</span><span style=\"color: rgb(64, 64, 64);\"><strong>空心红色方块</strong></span><span style=\"color: rgb(64, 64, 64);\">代表</span><span style=\"color: rgb(64, 64, 64);\"><strong>热端口</strong></span><span style=\"color: rgb(64, 64, 64);\">（即 </span><span style=\"color: rgb(64, 64, 64);\"><strong>HeatPort</strong></span><span style=\"color: rgb(64, 64, 64);\"> 连接器）</span>。在这些方块之间画一条线意味着它们是热连接的。 <strong>HeatPort</strong>连接器的变量包括接口的温度<strong>T</strong> 以及流入组件的热流率<strong>Q_flow</strong>(<span style=\"color: rgb(64, 64, 64);\">如果 </span><span style=\"color: rgb(64, 64, 64);\"><strong>Q_flow</strong></span><span style=\"color: rgb(64, 64, 64);\"> 为正，表示热量流入组件；如果为负，则表示热量流出组件)</span>:
</p>
<p>
<br>
</p>
<pre><code >Modelica.Units.SI.Temperature  T  \"Absolute temperature at port in Kelvin\";
Modelica.Units.SI.HeatFlowRate Q_flow  \"Flow rate at the port in Watt\";
</code></pre><p>
<br>
</p>
<p>
<span style=\"color: rgb(64, 64, 64);\">需要注意的是，此库中的所有温度（包括初始条件）均以开尔文（Kelvin）为单位。为了方便使用，在子库</span><span style=\"color: rgb(64, 64, 64);\"><strong> HeatTransfer.Celsius、HeatTransfer.Fahrenheit 和 HeatTransfer.Rankine </strong></span><span style=\"color: rgb(64, 64, 64);\">中提供了相应的组件，使得源和传感器的信息可以分别以摄氏度（°C）、华氏度（°F）或兰氏度（°R）显示。此外，在 </span><span style=\"color: rgb(64, 64, 64);\"><strong>Modelica.Units.Conversions </strong></span><span style=\"color: rgb(64, 64, 64);\">库中还提供了开尔文与摄氏度、华氏度、兰氏度之间的单位转换函数。这些函数可以按以下方式使用：</span>
</p>
<p>
<br>
</p>
<pre><code >import Modelica.Units.SI;
import Modelica.Units.Conversions.from_degC;
...
parameter SI.Temperature T = from_degC(25);  // convert 25 degree Celsius to Kelvin
</code></pre><p>
<br>
</p>
<p>
还有其他一些组件，如 AxialConduction（在轴向方向上离散化的偏微分方程），这些组件已暂时从该库中移除。原因是这些组件引用了材料属性，如热导率，而目前 Modelica 设计组正在讨论一种通用方案来描述材料属性。
</p>
<p>
有关该库设计的技术细节，请参阅 [<a href=\"modelica://Modelica.Thermal.HeatTransfer.UsersGuide.References\" target=\"\">Tiller2001</a>&nbsp;]。
</p>
</html>"));
end UsersGuide;