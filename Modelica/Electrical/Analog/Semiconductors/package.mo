within Modelica.Electrical.Analog;
package Semiconductors "半导体器件，如二极管、MOS和双极晶体管"
  extends Modelica.Icons.Package;
  import Modelica.Constants.k "Boltzmann's constant, [J/K]";
  import Modelica.Constants.q "Electron charge, [As]";

  function pow "一个辅助函数，它可以为symbolic计算引擎提供更轻松转换的x^y幂运算"

    extends Modelica.Icons.Function;
    input Real x;
    input Real y;
    output Real z;
    annotation();
  algorithm
    z := x ^ y;
  end pow;

  function powlin "幂函数(1-x)^(-y)在x>0的情况下的线性延拓(假设y为常数)"

    extends Modelica.Icons.Function;
    input Real x;
    input Real y;
    output Real z;
    annotation();
  algorithm
    z := if x > 0 then 1 + y * x else pow(1 - x, -y);
  end powlin;

  function exlin "指数函数在x>Maxexp的情况下进行线性延拓"
    extends Modelica.Icons.Function;
    input Real x;
    input Real Maxexp;
    output Real z;
    annotation();
  algorithm
    z := if x > Maxexp then exp(Maxexp) * (1 + x - Maxexp) else exp(x);
  end exlin;

  function exlin2 "指数函数在大于Maxexp小于MinExp的情况下进行线性延拓"
    extends Modelica.Icons.Function;
    input Real x;
    input Real Minexp;
    input Real Maxexp;
    output Real z;
    annotation();
  algorithm
    z := if x < Minexp then exp(Minexp) * (1 + x - Minexp) else exlin(x, Maxexp);
  end exlin2;

  annotation(
    Documentation(info = "<html>
<p>这个库包含以下半导体器件：</p>
<ul>
<li>二极管</li>
<li>MOS管</li>
<li>双极型晶体管</li>
<li>晶闸管</li>
<li>三极管</li>
</ul>
<p>大多数半导体器件都包含一个条件热端口，该热端口默认情况下是不活跃的。如果激活了该热端口，损耗功率将被计算并用于热网络。半导体器件的加热变体提供了使用热端口温度进行电气计算的功能。这意味着为了实现真正的热电相互作用，必须使用加热器件模型。
</p>

</html>", 
    revisions = "<html>
<dl>
<dt>
<strong>主要作者：</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
</dl>
</html>"), Icon(graphics = {
    Line(points = {{-20, 0}, {-90, 0}}), 
    Line(points = {{-20, 60}, {-20, -60}}), 
    Line(points = {{20, 68}, {-20, 28}}), 
    Line(points = {{80, 68}, {20, 68}}), 
    Line(points = {{-20, -30}, {20, -70}}), 
    Line(points = {{20, -70}, {80, -70}})}));
end Semiconductors;