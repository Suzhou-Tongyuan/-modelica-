within Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis;
class Preisach "Preisach滞后模型"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Preisach滞后模型</h4>

<p>
本节给出了Preisach迟滞模型的一个非常简短的概述，在<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Pr35, Ma03, Zi12]</a>。经典的Preisach磁滞模型将铁磁磁芯材料的磁通密度B(t)描述为磁场强度H(t)的过程及其历史的函数。该模型假定有无限组初等滞后算子&gamma;&alpha;&beta;。这种具有上下开关限的算子的输出& γ;& α;& β;H(t)的简单矩形图和β;如图1所示.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Characteristics of an elementary hysteresis operator.</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/preisach_elementaryOperator.png\">
    </td>
  </tr>
</table>

<p>
由于&alpha;&ge;&beta;和β;张成一个直角三角形区域，通常称为Preisach平面(见图2a)。对于这个平面上的每一个单点(& α;，& β;)，只有一个初等迟滞算子被定义为恰好具有& α;和β</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2:</strong> Preisach Plane (a) and exemplary plot of the Preisach distribution function P(&alpha;,&beta;) (b)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/preisach_PlaneAndDist.png\">
    </td>
  </tr>
</table>

<p>
此外，普雷萨赫分布函数 P（&alpha;,&beta;）是在普雷萨赫平面上定义的，它赋予每个算子一个单独的权重（见图 2b）。普雷萨赫平面可分为两个区域。在 S+ 区域，所有算子都处于 &quot;+1&quot;状态；在 S- 区域，所有算子都处于 &quot;-1&quot;状态。分隔 S+ 和 S- 区域的线 L(t) 随着磁场强度 H(t) 的变化而变化，并包含其历史信息。电流磁通密度的计算公式如下:
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/Eqn_PreisachBt.png\">
    </td>
  </tr>
</table>

<h4>滞后形状和双积分的计算</h4>

<p>
由上式可知，根据Preisach迟滞模型，要计算B(t)，每个时间步长都要计算P(&alpha;，&beta;)的二重积分。通常，Preisach分布函数不能解析可积两次。每个时间步长的数值二重积分计算量非常大。因此，Everett函数的分析描述<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[YUY89]</a> 用于定义迟滞形状.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/Eqn_EverettFcn.png\">
    </td>
  </tr>
</table>

<p>
Everett函数返回区域R的所有基本磁滞算符从“-1”状态切换到“+1”状态时的磁化变化(见图3)。整个区域S+现在可以分解成几个类似于r的更小的三角形区域，这样磁化B(t)就可以有效地计算，而不需要对Preisach分布函数进行数值积分.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3:</strong> Preisach plane and region R over which P(&alpha;,&beta;) is integrated to obtain E(H1,H2)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Preisach/EverettRegion.png\">
    </td>
  </tr>
</table>

<p>
根据 <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[YUY89]</a>使用的Everett函数解析形式由8个参数参数化。
确定了几个参数集来拟合测量或公布的不同材料的静态滞后行为。
这些预定义的参数集存储在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\"><code>FluxTubes.Material. HysteresisEverettParameter</code></a> 库
并且可以与<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystPreisachEverett\"><code>GenericHystPreisachEverett</code></a>通量管元素。
此外，还有<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystTellinenEverett\"><code>GenericHystTellinenEverett</code></a>元素可以使用这个库.
</p>

</html>"));
end Preisach;