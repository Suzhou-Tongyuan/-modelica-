within Modelica;
package Constants 
  "数学常数和自然常数库(例如pi、eps、R、sigma)"

  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import Modelica.Units.NonSI;

  // 数学常数
  final constant Real e = Modelica.Math.exp(1.0);
  final constant Real pi = 2 * Modelica.Math.asin(1.0);  // 3.14159265358979;
  final constant Real D2R = pi / 180 "角度到弧度";
  final constant Real R2D = 180 / pi "弧度到角度";
  final constant Real gamma = 0.57721566490153286061 
    "参见 http://en.wikipedia.org/wiki/Euler_constant";

  // 机器相关常数
  final constant Real eps = ModelicaServices.Machine.eps 
    "1.0 + eps = 1.0的最大数字";
  final constant Real small = ModelicaServices.Machine.small 
    "可在机器上表示small和-small的最小数";
  final constant Real inf = ModelicaServices.Machine.inf 
    "可在机器上表示inf和-inf的最大实数";
  final constant Integer Integer_inf = ModelicaServices.Machine.Integer_inf 
    "可在机器上表示Integer_inf和-Integer_inf的最大整数";

  // 自然常数
  // (名称、数值、说明都来自https://www.bipm.org/en/CGPM/db/26/1/，自2019年5月20日起生效)
  // c、q、h、k、N_A的值是精确的，是国际单位制基础的一部分。
  // 请注意，由于e已被采用，基本电荷使用通用的替代名称q。
  // F、R、sigma、T_zero、ε_0的值也是精确的。
  // mu_0的值现在可以表示为2*alpha*h/(q^2*c)，
  // 其中alpha是实验精细结构常数，
  // 该值来自 https://physics.nist.gov/cuu/pdf/wall_2018.pdf
  final constant SI.Velocity c = 299792458 "真空中的光速";
  final constant SI.Acceleration g_n = 9.80665 
    "地球上的标准重力加速度";
  final constant Real G(final unit = "m3/(kg.s2)") = 6.67430e-11 
    "牛顿万有引力常数";
  final constant SI.ElectricCharge q = 1.602176634e-19 "元电荷";
  final constant SI.FaradayConstant F = q * N_A 
    "法拉第常数，C/mol";
  final constant Real h(final unit = "J.s") = 6.62607015e-34 
    "普朗克常数";
  final constant Real k(final unit = "J/K") = 1.380649e-23 
    "玻尔兹曼常数";
  final constant Real R(final unit = "J/(mol.K)") = k * N_A 
    "摩尔气体常数";
  final constant Real sigma(final unit = "W/(m2.K4)") = 2 * pi ^ 5 * k ^ 4 / (15 * h ^ 3 * c ^ 2) 
    "斯蒂芬-玻尔兹曼常数";
  final constant Real N_A(final unit = "1/mol") = 6.02214076e23 
    "阿伏加德罗常数";
  final constant Real mu_0(final unit = "N/A2") = 4 * pi * 1.00000000055e-7 "磁常数";
  final constant Real epsilon_0(final unit = "F/m") = 1 / (mu_0 * c * c) 
    "电常数";
  final constant NonSI.Temperature_degC T_zero = -273.15 
    "绝对零度温度";
  annotation(
    Documentation(info = "<html>
<p>
这个包提供常用的数学常数、机器相关常数和自然常数。自然常数(名称、值、描述)来自以下来源(基于第二个来源)：
</p>
<dl>
<dt>Michael Stock, Richard Davis, Estefan&iacute;a de Mirand&eacute;s 和 Martin J T Milton:</dt>
<dd><strong>The revision of the SI-the result of three decades of progress in metrology</strong>，《Metrologia》，第56卷，第2期。
<a href= \"https://iopscience.iop.org/article/10.1088/1681-7575/ab0013/pdf\">https://iopscience.iop.org/article/10.1088/1681-7575/ab0013/pdf</a>，2019年。
</dd>
</dl>
<dl>
<dt>D B Newell, F Cabiati, J Fischer, K Fujii, S G Karshenboim, H S Margolis , E de Mirand&eacute;s, P J Mohr, F Nez, K Pachucki, T J Quinn, B N Taylor, M Wang, B M Wood 和 Z Zhang:</dt>
<dd><strong>The CODATA 2017 values of h, e, k, and NA for the revision of the SI</strong>，《Metrologia》，第55卷，第1期。
<a href= \"https://iopscience.iop.org/article/10.1088/1681-7575/aa950a/pdf\">https://iopscience.iop.org/article/10.1088/1681-7575/aa950a/pdf</a>，2017年。
</dd>
</dl>
<p>BIPM是国际计量局(发布SI标准)。</p>
<p>CODATA是科学技术数据委员会。</p>

<dl>
<dt><strong>主要作者：</strong></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    德国航空航天中心(DLR)<br>
    奥伯帕芬霍芬<br>
    邮政信箱1116<br>
    D-82230 We&szlig;ling<br>
    邮箱：<a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>

<p>
版权所有&copy; 1998-2020，Modelica协会及其贡献者
</p>
</html>", revisions = "<html>
<ul>
<li><em>2019年12月4日</em>
       由Thomas Beutlich更新：<br>
       根据2018年CODATA值更新了常数G。</li>
<li><em>2019年3月25日</em>
       由Hans Olsson更新：<br>
       根据2017年CODATA值和新SI标准更新了常数。</li>
<li><em>2015年11月4日</em>
       由Thomas Beutlich更新：<br>
       根据2014年CODATA值更新了常数。</li>
<li><em>2004年11月8日</em>
       由Christian Schweiger更新：<br>
       根据2002年CODATA值更新了常数。</li>
<li><em>1999年12月9日</em>
       由<a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>更新：<br>
       根据1998年CODATA值更新了常数，使用了此来源中的名称、值和描述文本，并包括了磁常数和电常数。</li>
<li><em>1999年9月18日</em>
       由<a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>更新：<br>
       引入了常数eps，inf，small。</li>
<li><em>1997年11月15日</em>
       由<a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>实现。</li>
</ul>
</html>"), 
    Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {
    Polygon(
    origin = {-9.2597, 25.6673}, 
    fillColor = {102, 102, 102}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{48.017, 11.336}, {48.017, 11.336}, {10.766, 11.336}, {-25.684, 10.95}, {-34.944, -15.111}, {-34.944, -15.111}, {-32.298, -15.244}, {-32.298, -15.244}, {-22.112, 0.168}, {11.292, 0.234}, {48.267, -0.097}, {48.267, -0.097}}, 
    smooth = Smooth.Bezier), 
    Polygon(
    origin = {-19.9923, -8.3993}, 
    fillColor = {102, 102, 102}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{3.239, 37.343}, {3.305, 37.343}, {-0.399, 2.683}, {-16.936, -20.071}, {-7.808, -28.604}, {6.811, -22.519}, {9.986, 37.145}, {9.986, 37.145}}, 
    smooth = Smooth.Bezier), 
    Polygon(
    origin = {23.753, -11.5422}, 
    fillColor = {102, 102, 102}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{-10.873, 41.478}, {-10.873, 41.478}, {-14.048, -4.162}, {-9.352, -24.8}, {7.912, -24.469}, {16.247, 0.27}, {16.247, 0.27}, {13.336, 0.071}, {13.336, 0.071}, {7.515, -9.983}, {-3.134, -7.271}, {-2.671, 41.214}, {-2.671, 41.214}}, 
    smooth = Smooth.Bezier)}));
end Constants;