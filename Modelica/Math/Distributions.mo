within Modelica.Math;
package Distributions "分布函数库"
   extends Modelica.Icons.Package;

  package Uniform "均匀分布函数库"
    extends Modelica.Icons.Package;

    function density "均匀分布密度"
      extends Modelica.Math.Distributions.Interfaces.partialDensity;
      input Real u_min=0 "u的下限" annotation (Dialog);
      input Real u_max=1 "u的上限" annotation (Dialog);
    algorithm
      y := if u < u_min or u > u_max then 0.0 else 1/(u_max - u_min);

      annotation (Inline=true,Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Uniform.<strong>density</strong>(u, u_min=0, u_max=1);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据频带内<strong>均匀</strong>分布计算概率密度函数。
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.density.png\">
</blockquote>

<p>
有关详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
density(0.5)    // = 1
density(0,-1,1) // = 0.5
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Uniform.cumulative\">Uniform.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.Uniform.quantile\">Uniform.quantile</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 实现的初始版本
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end density;

    function cumulative 
      "均匀分布的累积分布函数"
      extends Modelica.Math.Distributions.Interfaces.partialCumulative;
      input Real u_min=0 "u的下限" annotation (Dialog);
      input Real u_max=1 "u的上限" annotation (Dialog);
    algorithm
      y := if u < u_min then 0.0 else 
           if u > u_max then 1.0 else (u-u_min)/(u_max-u_min);

      annotation (Inline=true,Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Uniform.<strong>cumulative</strong>(u, u_min=0, u_max=1);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数计算累积分布函数
根据<strong>在一个波段内的均匀</strong>分布。
返回值y的取值范围为:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.cumulative.png\">
</blockquote>

<p>
有关详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
cumulative(0.5)    // = 0.5
cumulative(0,-1,1) // = 0.5
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Uniform.density\">Uniform.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Uniform.quantile\">Uniform.quantile</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 实现的初始版本
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end cumulative;

    function quantile "均匀分布的分位数"
      extends Modelica.Math.Distributions.Interfaces.partialQuantile;
      input Real y_min=0 "y的下限" annotation (Dialog);
      input Real y_max=1 "y的上限" annotation (Dialog);
    algorithm
      y := u*(y_max - y_min) + y_min;
      annotation (Inline=true,Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Uniform.<strong>quantile</strong>(u, y_min=0, y_max=1);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据<strong>均匀</strong>计算逆累积分布函数(=分位数)。
带状分布。输入参数u必须在以下范围内:
</p>

<blockquote>
<p>
0 &le; u &le; 1
</p>
</blockquote>

<p>
返回的数字y在以下范围内:
</p>

<blockquote>
<p>
y_min &le; y &le; y_max
</p>
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.quantile.png\">
</blockquote>

<p>
有关详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
quantile(0.5)      // = 0.5
quantile(0.5,-1,1) // = 0
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Uniform.density\">Uniform.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Uniform.cumulative\">Uniform.cumulative</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 实现的初始版本
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end quantile;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
          -100,-100},{100,100}}), graphics={Line(
        points={{-80,-60},{-40,-60},{-40,60},{40,60},{40,-60},{80,-60}})}), Documentation(info="<html>
<p>
这个包提供
</p>
<ul>
<li> 概率密度函数(=累积分布函数的导数),</li>
<li> 累积分布函数，和</li>
<li> 分位数(=逆累积分布函数).</li>
</ul>
<p>
的<strong>均匀</strong>分布。例子:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.quantile.png\">
</blockquote>

<p>
有关此发行版的更多详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)\">Wikipedia</a>.
</p>
</html>"    ,   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
     <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
     实现的初始版本
     A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
     <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
  end Uniform;

  package Normal "正态分布函数库"
     extends Modelica.Icons.Package;

    function density "正态分布密度"
      extends Modelica.Math.Distributions.Interfaces.partialDensity;
      input Real mu=0 "正态分布的期望值(平均值)" annotation(Dialog);
      input Real sigma=1 "正态分布的标准差" annotation(Dialog);
    algorithm
      y := exp(-(u-mu)^2/(2*sigma^2))/(sigma*sqrt(2*Modelica.Constants.pi));

      annotation (Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Normal.<strong>density</strong>(u, mu=0, sigma=1);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据<strong>正态</strong>分布计算概率密度函数
均值<strong>mu</strong>，标准差<strong>sigma</strong>(方差= sigma<sup>2</sup>)。
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.density.png\">
</blockquote>

<p>
有关详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
density(0.5)     // = 0.3520653267642995
density(3,1,0.5) // = 0.00026766045152977074
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Normal.cumulative\">Normal.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.Normal.quantile\">Normal.quantile</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 实现的初始版本
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end density;

    function cumulative 
      "正态分布的累积分布函数"
      import Modelica.Math.Special;
      extends Modelica.Math.Distributions.Interfaces.partialCumulative;
      input Real mu=0 "正态分布的期望值(平均值)" annotation(Dialog);
      input Real sigma=1 "正态分布的标准差" annotation(Dialog);
    algorithm
      y :=(1 + Special.erf((u - mu)/(sigma*sqrt(2))))/2;

      annotation (Inline=true,Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Normal.<strong>cumulative</strong>(u, mu=0, sigma=1);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据<strong>正态</strong>分布计算累积分布函数
均值<strong>mu</strong>，标准差<strong>sigma</strong>(方差= sigma<sup>2</sup>)。
返回值y的取值范围为:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.cumulative.png\">
</blockquote>

<p>
有关详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
cumulative(0.5)      // = 0.6914624612740131
cumulative(0,1,0.5)  // = 0.15865525393145707
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Normal.density\">Normal.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Normal.quantile\">Normal.quantile</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 实现的初始版本
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end cumulative;

    function quantile "正态分布的分位数"
      import Modelica.Math.Special;
      extends Modelica.Math.Distributions.Interfaces.partialQuantile;
      input Real mu=0 "正态分布的期望值(平均值)" annotation(Dialog);
      input Real sigma=1 "正态分布的标准差" annotation(Dialog);
    algorithm
      y :=mu + sigma*sqrt(2)*Special.erfInv(2*u-1);

      annotation (Inline=true, Documentation(info="<html>

<h4>语法</h4>
<blockquote><pre>
Normal.<strong>quantile</strong>(u, y_min=0, y_max=1);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据<strong>正态</strong>分布计算逆累积分布函数(=分位数)
均值<strong>mu</strong>，标准差<strong>sigma</strong>(方差= sigma<sup>2</sup>)。
输入参数u必须在以下范围内:
</p>

<blockquote>
<p>
0 &lt; u &lt; 1
</p>
</blockquote>

<p>
如果输入参数u是均匀分布的随机数，则
99.7%的返回随机数在:
</p>

<blockquote>
<p>
mu-3*sigma &le; y &le; mu+3*sigma
</p>
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.quantile.png\">
</blockquote>

<p>
有关详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
quantile(0.001)     // = -3.090232306167813;
quantile(0.5,1,0.5) // = 1
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Normal.density\">Normal.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Normal.cumulative\">Normal.cumulative</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 实现的初始版本
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end quantile;
  annotation (Icon(graphics={Line(
            points={{-70,-63.953},{-66.5,-63.8975},{-63,-63.7852},{-59.5, 
            -63.5674},{-56,-63.1631},{-52.5,-62.4442},{-49,-61.2213},{
            -45.5,-59.2318},{-42,-56.1385},{-38.5,-51.5468},{-35,-45.0467}, 
            {-31.5,-36.2849},{-28,-25.0617},{-24.5,-11.4388},{-21,4.16818}, 
            {-17.5,20.9428},{-14,37.695},{-10.5,52.9771},{-7,65.2797},{
            -3.5,73.2739},{0,76.047},{3.5,73.2739},{7,65.2797},{10.5, 
            52.9771},{14,37.695},{17.5,20.9428},{21,4.16818},{24.5, 
            -11.4388},{28,-25.0617},{31.5,-36.2849},{35,-45.0467},{38.5, 
            -51.5468},{42,-56.1385},{45.5,-59.2318},{49,-61.2213},{52.5, 
            -62.4442},{56,-63.1631},{59.5,-63.5674},{63,-63.7852},{66.5, 
            -63.8975},{70,-63.953}}, 
            smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
这个包提供
</p>
<ul>
<li> 概率密度函数(=累积分布函数的导数),</li>
<li> 累积分布函数，和</li>
<li> 分位数(=逆累积分布函数).</li>
</ul>
<p>
<strong>正态</strong>分布。例子:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.quantile.png\">
</blockquote>

<p>
有关此发行版的更多详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>
</html>"    ,   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
     <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
     实现的初始版本
     A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
     <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
  end Normal;

  package TruncatedNormal "截断的正态分布函数库"
    extends Modelica.Icons.Package;

    function density "截断正态分布的密度"
      import Modelica.Math.Distributions.Normal;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedDensity;
      input Real mu= (u_max + u_min)/2 
        "Expectation (mean) value of the normal distribution" annotation(Dialog);
      input Real sigma=(u_max - u_min)/6 
        "Standard deviation of the normal distribution" annotation(Dialog);
    protected
      Real pdf;
      Real cdf_min;
      Real cdf_max;
    algorithm
      if u >= u_min and u <= u_max then
         pdf :=Normal.density(u,mu,sigma);
         cdf_min :=Normal.cumulative(u_min,mu,sigma);
         cdf_max :=Normal.cumulative(u_max,mu,sigma);
         y := pdf / max(cdf_max - cdf_min, 10*Modelica.Constants.eps);
      else
         y := 0;
      end if;
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Normal.<strong>density</strong>(u, u_min=0, u_max=1, mu=0, sigma=1);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据a计算概率密度函数
<strong>截断正态</strong>分布
最小值<strong>u_min</strong>，最大值<strong>u_max</strong>，
原始分布的均值<strong>mu</strong>和
原分布标准差<strong>sigma</strong>(方差= sigma<sup>2</sup>)。
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.density.png\">
</blockquote>

<p>
详细信息<br>
正态分布，见
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>,<br>
截断分布，见
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
density(0.5)                // = 1.041828977196953
density(0.5,-1.5,1.5,1,0.9) // = 0.5365495585520803
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedNormal.cumulative\">TruncatedNormal.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedNormal.quantile\">TruncatedNormal.quantile</a>.
</p>
</html>"                        ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                        ));
    end density;

    function cumulative 
      "截断正态分布的累积分布函数"
      import Modelica.Math.Distributions.Normal;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedCumulative;
      input Real mu= (u_max + u_min)/2 
        "正态分布的期望值(平均值)" annotation(Dialog);
      input Real sigma=(u_max - u_min)/6 
        "正态分布的标准差" annotation(Dialog);
    protected
      Real cdf;
      Real cdf_min;
      Real cdf_max;
    algorithm
      if u <= u_min then
         y := 0;
      elseif u < u_max then
         cdf     :=Normal.cumulative(u, mu, sigma);
         cdf_min :=Normal.cumulative(u_min, mu, sigma);
         cdf_max :=Normal.cumulative(u_max, mu, sigma);
         y := (cdf - cdf_min) / max(cdf_max - cdf_min, 10*Modelica.Constants.eps);
      else
         y := 1;
      end if;

      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Normal.<strong>cumulative</strong>(u, u_min=0, u_max=1, mu=0, sigma=1);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据a计算累积分布函数
<strong>截断正态</strong>分布
最小值<strong>u_min</strong>，最大值<strong>u_max</strong>，
原始分布的均值<strong>mu</strong>和
原分布标准差<strong>sigma</strong>(方差= sigma<sup>2</sup>)。
返回值y的取值范围为:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.cumulative.png\">
</blockquote>

<p>
详细信息<br>
正态分布，见
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>,<br>
截断分布，见
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
cumulative(0.5)                 // = 0.5
cumulative(0.5,-1.5,1.5,1,0.9)  // = 0.4046868865634537
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Normal.density\">TruncatedNormal.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Normal.quantile\">TruncatedNormal.quantile</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 最初版本由
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end cumulative;

    function quantile "截断正态分布的定量"
      import Modelica.Math.Distributions.Normal;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedQuantile;
      input Real mu= (y_max + y_min)/2 
        "正态分布的期望（平均）值" annotation(Dialog);
      input Real sigma=(y_max - y_min)/6 
        "正态分布的标准差" annotation(Dialog);
    protected
      Real cdf_min = Normal.cumulative(y_min, mu, sigma);
      Real cdf_max = Normal.cumulative(y_max, mu, sigma);
    algorithm
      y := Normal.quantile(cdf_min + u*(cdf_max-cdf_min), mu=mu, sigma=sigma);

      /* 在接近 u=0 和 u=1 时，数值计算会出现较大误差。
    会出现较大误差。下面的语句可以保证 y 在 y_min/y_max 范围内
    */
      y := min(y_max,max(y_min,y));

      annotation (smoothOrder = 1,Documentation(info="<html>

<h4>语法</h4>
<blockquote><pre>
Normal.<strong>quantile</strong>(u, y_min=0, y_max=1, mu=0, sigma=1);
</pre></blockquote>

<h4>说明</h4>
<p>
该函数根据a计算逆累积分布函数(=分位数)
<strong>截断正态</strong>分布
最小值<strong>u_min</strong>，最大值<strong>u_max</strong>，
原始分布的均值<strong>mu</strong>和
原分布标准差<strong>sigma</strong>(方差= sigma<sup>2</sup>)。
输入参数u必须在以下范围内:
</p>

<blockquote>
<p>
0 &lt; u &lt; 1
</p>
</blockquote>

<p>
输出参数y在范围内:
</p>

<blockquote>
<p>
y_min &le; y &le; y_max
</p>
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.quantile.png\">
</blockquote>

<p>
更多详情<br>
正态分布，见
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>,<br>
截断分布，见
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
quantile(0.001)           // = 0.001087357613043849;
quantile(0.5,0,1,0.5,0.9) // = 0.5
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedNormal.density\">TruncatedNormal.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedNormal.cumulative\">TruncatedNormal.cumulative</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 最初版本由
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end quantile;
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, 
          extent={{-100,-100},{100,100}}, 
          grid={1,1}), 
                     graphics={
          Line(
            points={{-32,-32},{-32,-80}}), 
                             Line(
            points={{-32,-32},{-28,-21.0617},{-24.5,-7.4388},{-21,8.1682},{
                -17.5,24.9428},{-14,41.695},{-10.5,56.9771},{-7,69.2797},{-3.5, 
                77.2739},{0,80.047},{3.5,77.2739},{7,69.2797},{10.5,56.9771},{
                14,41.695},{17.5,24.9428},{21,8.1682},{24.5,-7.4388},{28, 
                -21.0617},{31.5,-32.2849},{35,-41.0467}}, 
            smooth=Smooth.Bezier), 
          Line(
            points={{34.5,-40.5},{34.5,-78.5}}), 
          Line(
            points={{34.5,-78.5},{70.5,-78.5}}), 
          Line(
            points={{-68,-79},{-32,-79}})}), 
      Documentation(info="<html>
<p>
这个包提供
</p>
<ul>
<li> 概率密度函数(=累积分布函数的导数),</li>
<li> 累积分布函数，和</li>
<li> 分位数(=逆累积分布函数)。</li>
</ul>
<p>
截断的正态</strong>分布。例子:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.quantile.png\">
</blockquote>

<p>
欲知详情<br>
正态分布，见
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>,<br>
截断的分布，参见
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>
</html>"    ,   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
     <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
     实现的初始版本
     A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
     <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
  end TruncatedNormal;

  package Weibull "威布尔分布函数库"
    extends Modelica.Icons.Package;

    function density "威布尔分布的密度"
      extends Modelica.Math.Distributions.Interfaces.partialDensity;
      input Real lambda(min=0) = 1 
        "威布尔分布的标度参数" annotation(Dialog);
      input Real k(min=0) "威布尔分布的形状参数" annotation(Dialog);
    algorithm
      y :=if u >= 0 then (k/lambda)*(u/lambda)^(k - 1)*exp(-(u/lambda)^k) else 0.0;

      annotation (Inline=true, Documentation(info="<html>

<h4>语法</h4>
<blockquote><pre>
Weibull.<strong>density</strong>(u, lambda=1, k=1);
</pre></blockquote>

<h4>说明</h4>
<p>
该函数根据<strong>Weibull</strong>分布计算概率密度函数
尺度参数<strong>lambda</strong>，形状参数<strong>k</strong>。方程:
</p>

<blockquote><pre>
y = if u >= 0 then (k/lambda)*(u/lambda)^(k - 1)*exp(-(u/lambda)^k) else 0.0;
</pre></blockquote>

<p>
绘制函数图：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.density.png\">
</blockquote>

<p>
更多详情，请参阅
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
density(0.5)     // = 0.36787944117144233
density(1,0.5,2) // = 0.14652511110987343
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Weibull.cumulative\">Weibull.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.Weibull.quantile\">Weibull.quantile</a>.
</p>
</html>"            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   最初版本由
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
    end density;

    function cumulative 
      "威布尔分布的累积分布函数"
      import Modelica.Math.Special;
      extends Modelica.Math.Distributions.Interfaces.partialCumulative;
      input Real lambda(min=0) = 1 
        "威布尔分布的标度参数" annotation(Dialog);
      input Real k(min=0) "威布尔分布的形状参数" annotation(Dialog);
    algorithm
      y := if u >= 0 then 1 - exp(-(u/lambda)^k) else 0.0;

      annotation (Inline=true,Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Weibull.<strong>cumulative</strong>(u, lambda=1, k=1);
</pre></blockquote>

<h4>说明</h4>
<p>
这个函数计算累积分布函数
符合<strong>Weibull</strong>分布
尺度参数<strong>lambda</strong>，形状参数<strong>k</strong>。方程:
</p>

<blockquote><pre>
y := if u >= 0 then 1 - exp(-(u/lambda)^k) else 0.0;
</pre></blockquote>

<p>
返回值y的取值范围为:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.cumulative.png\">
</blockquote>

<p>
有关详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>.
</p>

<h4>例子</h4>
<blockquote><pre>
cumulative(0.5)       // = 0.3934693402873666
cumulative(0.5,0.5,1) // = 0.6321205588285577
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Weibull.density\">Weibull.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Weibull.quantile\">Weibull.quantile</a>.
</p>
</html>"        ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   最初版本由
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"        ));
    end cumulative;

    function quantile "威布尔分布的量值"
      extends Modelica.Math.Distributions.Interfaces.partialQuantile;
      input Real lambda(min=0) = 1 
        "威布尔分布的标度参数" annotation(Dialog);
      input Real k(min=0) "威布尔分布的形状参数" annotation(Dialog);
    algorithm
      y := lambda * (-log( 1-u)) ^(1/k);

      annotation (Inline=true, Documentation(info="<html>

<h4>语法</h4>
<blockquote><pre>
Weibull.<strong>quantile</strong>(u, lambda=1, k=1);
</pre></blockquote>

<h4>说明</h4>
<p>
该函数根据<strong>Weibull</strong>分布计算逆累积分布函数(=分位数)
尺度参数<strong>lambda</strong>，形状参数<strong>k</strong>。方程:
</p>

<blockquote><pre>
y := lambda * (-log( 1-u)) ^(1/k);
</pre></blockquote>

<p>
输入参数u必须在以下范围内:
</p>
<blockquote>
<p>
0 &le; u &lt; 1
</p>
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.quantile.png\">
</blockquote>

<p>
有关详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>.
</p>

<h4>例子</h4>
<blockquote><pre>
quantile(0)         // = 0
quantile(0.5,1,0.5) // = 0.41627730557884884
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Weibull.density\">Weibull.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Weibull.cumulative\">Weibull.cumulative</a>.
</p>
</html>"        ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   最初版本由
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"        ));
    end quantile;
    annotation (Icon(graphics={Line(
            points={{-72,-60},{-68.5,-60},{-65,-60},{-61.5,-60},{-58,-60},{-54.5,-60},{-51,-60},{-47.5, 
                -60},{-44,-60},{-40.5,-60},{-37,-60},{-33.5,-60},{-30,-60},{-26.5,-60},{-23,-60},{-19.5, 
                -60},{-16,-60},{-12.5,-60},{-9,-60},{-5.5,-60},{-2,-60},{1.5,43.1424},{5,71.1658},{8.5, 
                80},{12,77.3585},{15.5,67.6645},{19,54.0082},{22.5,38.6157},{26,23.0458},{29.5,8.32389}, 
                {33,-4.9424},{36.5,-16.4596},{40,-26.1579},{43.5,-34.1153},{47,-40.4975},{50.5,-45.5133}, 
                {54,-49.3832},{57.5,-52.3187},{61,-54.5105},{64.5,-56.123},{68,-57.2928}}, 
            smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
这个包提供
</p>
<ul>
<li> 概率密度函数（=累积分布函数的导数）,</li>
<li> 累积分布函数，以及</li>
<li> 量值（=逆累积分布函数）.</li>
</ul>
<p>
的<strong>Weibull</strong>分布。例子
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.quantile.png\">
</blockquote>

<p>
有关该分布的更多详情，请参阅
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>.
</p>
</html>"    ,   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
  <td>

<table border=\"0\">
<tr><td>
       <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
       最初版本由
       A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
       <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
  end Weibull;

  package TruncatedWeibull 
    "截断威布尔分布函数库"
    extends Modelica.Icons.Package;

    function density "截尾威布尔分布的密度"
      import Modelica.Math.Distributions.Weibull;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedDensity;
      input Real lambda(min=0) = 1 
        "威布尔分布的标度参数" annotation(Dialog);
      input Real k(min=0) "威布尔分布的形状参数" annotation(Dialog);
    protected
      Real pdf;
      Real cdf_min;
      Real cdf_max;
    algorithm
      if u >= u_min and u <= u_max then
         pdf :=Weibull.density(u, lambda=lambda, k=k);
         cdf_min :=Weibull.cumulative(u_min, lambda=lambda, k=k);
         cdf_max :=Weibull.cumulative(u_max, lambda=lambda, k=k);
         y := pdf / max(cdf_max - cdf_min, 10*Modelica.Constants.eps);
      else
         y := 0;
      end if;
      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Weibull.<strong>density</strong>(u, u_min=0, u_max=1, lambda=1, k=1);
</pre></blockquote>

<h4>说明</h4>
<p>
该函数根据a计算概率密度函数
<strong>截断Weibull</strong>分布
最小值<strong>u_min</strong>，最大值<strong>u_max</strong>，
原始分布的尺度参数<strong>lambda</strong>和
原始分布的形状参数<strong>k</strong>。
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.density.png\">
</blockquote>

<p>
更多详情<br>
威布尔分布，见
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>,<br>
截断分布，见
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
density(0.5)             // = 0.9595173756674719
density(0.5,0,0.8,0.5,2) // = 1.5948036466479143
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.cumulative\">TruncatedWeibull.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.quantile\">TruncatedWeibull.quantile</a>.
</p>
</html>"              ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 最初版本由
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"              ));
    end density;

    function cumulative 
      "截尾威布尔分布的累积分布函数"
      import Modelica.Math.Distributions.Weibull;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedCumulative;
      input Real lambda(min=0) = 1 
        "威布尔分布的标度参数" annotation(Dialog);
      input Real k(min=0) "威布尔分布的形状参数" annotation(Dialog);
    protected
      Real cdf;
      Real cdf_min;
      Real cdf_max;
    algorithm
      if u <= u_min then
         y := 0;
      elseif u < u_max then
         cdf     :=Weibull.cumulative(u, lambda=lambda, k=k);
         cdf_min :=Weibull.cumulative(u_min, lambda=lambda, k=k);
         cdf_max :=Weibull.cumulative(u_max, lambda=lambda, k=k);
         y := (cdf - cdf_min) / max(cdf_max - cdf_min, 10*Modelica.Constants.eps);
      else
         y := 1;
      end if;

      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
Weibull.<strong>cumulative</strong>(u, u_min=0, u_max=1, lambda=1, k=1);
</pre></blockquote>

<h4>说明</h4>
<p>
该函数根据a计算累积分布函数
<strong>截断Weibull</strong>分布
最小值<strong>u_min</strong>，最大值<strong>u_max</strong>，
原始分布的尺度参数<strong>lambda</strong>和
原始分布的形状参数<strong>k</strong>。
返回值y的取值范围为:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.cumulative.png\">
</blockquote>

<p>
更多详情<br>
的韦布尔分布，见
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>,<br>
的截断分布，见
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
cumulative(0.5)             // = 0.6224593312018546
cumulative(0.5,0,0.8,0.5,2) // = 0.6850805314988328
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.density\">TruncatedWeibull.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.quantile\">TruncatedWeibull.quantile</a>.
</p>
</html>"          ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 最初版本由
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"          ));
    end cumulative;

    function quantile "截断威布尔分布的定量值"
      import Modelica.Math.Distributions.Weibull;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedQuantile;
      input Real lambda(min=0) = 1 
        "威布尔分布的标度参数" annotation(Dialog);
      input Real k(min=0) "威布尔分布的形状参数" annotation(Dialog);
    protected
      Real cdf_min = Weibull.cumulative(y_min, lambda=lambda, k=k) 
        "y_min 时的 cdf 值";
      Real cdf_max = Weibull.cumulative(y_max, lambda=lambda, k=k) 
        "y_max 时的 cdf 值";
    algorithm
      y := Weibull.quantile(cdf_min + u*(cdf_max-cdf_min), lambda=lambda,k=k);

      /* 接近u=1时，数值计算误差较大
    发生。下面的声明是一名警卫仍然保持财产
    y在y_min内。y_max
    */
      y := min(y_max,max(y_min,y));

      annotation (smoothOrder=1,Documentation(info="<html>

<h4>语法</h4>
<blockquote><pre>
Weibull.<strong>quantile</strong>(u, y_min=0, y_max=1, lambda=1, k=1);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数根据a计算逆累积分布函数(=分位数)
<strong>截断Weibull</strong>分布
最小值<strong>u_min</strong>，最大值<strong>u_max</strong>，
原始分布的尺度参数<strong>lambda</strong>和
原始分布的形状参数<strong>k</strong>。
输入参数u必须在以下范围内:
</p>

<blockquote>
<p>
0 &le; u &le; 1
</p>
</blockquote>

<p>
输出参数y在范围内:
</p>

<blockquote>
<p>
y_min &le; y &le; y_max
</p>
</blockquote>

<p>
函数图:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.quantile.png\">
</blockquote>

<p>
更多详情<br>
韦布尔分布，见
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>,<br>
截断分布，见
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>示例</h4>
<blockquote><pre>
quantile(0.001)           // = 0.0006323204312624211;
quantile(0.5,0,1,0.5,0.9) // = 0.256951787882498
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.density\">TruncatedWeibull.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.cumulative\">TruncatedWeibull.cumulative</a>.
</p>
</html>"                  ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
 <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
 最初版本由
 A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
 <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                  ));
    end quantile;
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false, 
          extent={{-100,-100},{100,100}}, 
          grid={1,1}), 
                     graphics={Line(
            points={{-72,-62},{-68.5,-62},{-65,-62},{-61.5,-62},{-58,-62},{
                -54.5,-62},{-51,-62},{-47.5,-62},{-44,-62},{-40.5,-62},{-37,-62}, 
                {-33.5,-62},{-30,-62},{-26.5,-62},{-23,-62},{-19.5,-62},{-16, 
                -62},{-12.5,-62},{-9,-62},{-5.5,-62},{-2,-62},{1.5,41.1424},{5, 
                69.1658},{8.5,78},{12,75.3585},{15.5,65.6645},{19,52.0082},{
                22.5,36.6157},{26,21.0458},{29.5,6.3239},{33,-6.9424},{36.5, 
                -18.4596},{40,-28.1579},{43.5,-36.1153}}, 
            smooth=Smooth.Bezier), 
          Line(
            points={{43.5,-36},{43.5,-63}}), 
          Line(
            points={{43.5,-63},{79.5,-63}})}), 
      Documentation(info="<html>
<p>
该软件包提供
</p>
<ul>
<li> 概率密度函数（=累积分布函数的导数）,</li>
<li> 累积分布函数，以及</li>
<li> 量值（=逆累积分布函数）.</li>
</ul>
<p>
的 <strong> 截断韦布尔</strong>分布。例子
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.quantile.png\">
</blockquote>

<p>
更多详情<br>
的韦布尔分布，见
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>,<br>
的截断分布，见
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>
</html>"      ,   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
     <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
     最初版本由
     A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
     <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"      ));
  end TruncatedWeibull;

  package Interfaces "分配功能接口库"
    extends Modelica.Icons.InterfacesPackage;

    partial function partialDensity 
      "概率密度函数的常见接口"
      extends Modelica.Icons.Function;
      input Real u "实轴上的随机数（-inf < u < inf）";
      output Real y "u 的密度";
      annotation (Documentation(info="<html>
<p>
部分函数，包含概率密度函数的的参数。
</p>
</html>"      ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   最初版本由
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"      ));
    end partialDensity;

    partial function partialCumulative 
      "累积分布函数的共同界面"
      extends Modelica.Icons.Function;
      input Real u "实轴上的数值（-inf < u < inf）";
      output Real y "0 <= y <= 1 范围内的值";
      annotation (Documentation(info="<html>
<p>
部分函数
参数的部分函数。
</p>
</html>"      ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   最初版本由
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"      ));
    end partialCumulative;

    partial function partialQuantile 
      "量子函数（=反向累积分布函数）的常见接口"
      extends Modelica.Icons.Function;
      input Real u(min=0, max=1) "0 <= u <= 1 范围内的随机数";
      output Real y 
        "根据给定分布变换的随机数 u";
      annotation (Documentation(info="<html>
<p>
部分函数，包含量子函数的
参数的部分函数。
</p>
</html>"      ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   最初版本由
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"      ));
    end partialQuantile;

    partial function partialTruncatedDensity 
      "截断概率密度函数的共同界面"
      extends partialDensity;
      input Real u_min=0 "u 的下限" annotation(Dialog);
      input Real u_max=1 "u 的上限" annotation(Dialog);
      annotation (Documentation(info="<html>
<p>
部分函数，包含截断分布的
参数的部分函数。
</p>
</html>"      ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   最初版本由
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"      ));
    end partialTruncatedDensity;

    partial function partialTruncatedCumulative 
      "截断累积分布函数的共同界面"
      extends partialCumulative;
      input Real u_min=0 "u 的下限" annotation(Dialog);
      input Real u_max=1 "u 的上限" annotation(Dialog);
      annotation (Documentation(info="<html>
<p>
部分函数
参数的部分函数。
</p>
</html>"      ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   最初版本由
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"      ));
    end partialTruncatedCumulative;

    partial function partialTruncatedQuantile 
      "截断量子函数（=反向累积分布函数）的常见接口"
      extends partialQuantile;
      input Real y_min=0 "y 的下限" annotation(Dialog);
      input Real y_max=1 "y 的上限" annotation(Dialog);
      annotation (Documentation(info="<html>
<p>
包含公函数的部分函数
截断分布的分位数函数参数。
</p>
</html>"      ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   实现的初始版本
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"      ));
    end partialTruncatedQuantile;
  annotation (Documentation(info="<html>
<p>
的部分函数
分布和的公共接口参数
截断分布函数。
</p>
</html>"  ,   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
  <td>

<table border=\"0\">
<tr><td>
       <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
       实现的初始版本
       A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
       <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"  ));
  end Interfaces;
annotation (Icon(graphics={Line(
          points={{-70,-65.953},{-66.5,-65.8975},{-63,-65.7852},{-59.5, 
          -65.5674},{-56,-65.1631},{-52.5,-64.4442},{-49,-63.2213},{-45.5, 
          -61.2318},{-42,-58.1385},{-38.5,-53.5468},{-35,-47.0467},{-31.5, 
          -38.2849},{-28,-27.0617},{-24.5,-13.4388},{-21,2.1682},{-17.5, 
          18.9428},{-14,35.695},{-10.5,50.9771},{-7,63.2797},{-3.5, 
          71.2739},{0,74.047},{3.5,71.2739},{7,63.2797},{10.5,50.9771},{
          14,35.695},{17.5,18.9428},{21,2.1682},{24.5,-13.4388},{28, 
          -27.0617},{31.5,-38.2849},{35,-47.0467},{38.5,-53.5468},{42, 
          -58.1385},{45.5,-61.2318},{49,-63.2213},{52.5,-64.4442},{56, 
          -65.1631},{59.5,-65.5674},{63,-65.7852},{66.5,-65.8975},{70, 
          -65.953}}, 
          smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
这个包提供
</p>
<ul>
<li> <a href=\"http://en.wikipedia.org/wiki/Probability_density_function\">probability density functions</a>
     (= 累积分布函数的导数)，</li>
<li> <a href=\"http://en.wikipedia.org/wiki/Cumulative_distribution_function\">cumulative distribution functions</a>，
     和</li>
<li> <a href=\"http://en.wikipedia.org/wiki/Quantile_function\">quantiles</a>
     (=逆累积分布函数)。</li>
</ul>
<p>
不同的分布。
</p>

<p>
特别地，还提供了<strong>截断分布</strong>(见下文)。
主要原因介绍截断分布是为了使测量噪声的建模更容易，以便
限制噪声可能发生的频带。例如，如果使用传感器，则
传感器信号的噪声为&plusmn;0.1伏(例如，这可以通过使用参考来确定
值为0 V并检测被测信号)，则传感器信号将经常输入
到模数转换器，这个转换器限制信号，说&plusmn;5伏特。
通常，用户希望对噪声带内的噪声进行建模(例如&plusmn;0.1伏特),
通常使用正态分布。但是正态分布是不受限制的
对于小样本时间和长模拟，可能会有一些样本时间瞬间
其中正常信号的噪声值在&plusmn;0.1伏范围。
对于某些类型的传感器，这是完全不现实的(例如，角度传感器可能
测量&plusmn;0.1 rad，但传感器永远不会增加，比如一圈(6.28 rad)。
然而，纯正态分布的噪声模型可以给出这样的值。
如果建模者想要保证(而不是希望)，建模噪声是
总是在&plusmn;0.1伏，则有两种主要可能性:(a)噪声被计算
结果被限制为&plusmn;0.1伏，或(b)正态分布略有改变，
所以它在&plusmn的范围内;0.1伏特。方法(a)是一种蛮力方法
以未知的方式改变信号的统计特性。方法(b)
是一个“干净”的数学描述。包装中的块
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>
让用户自由选择:要么计算正常(无限)噪声，要么
截断的正态噪声(截断分布)。
</p>

<h4>
截断分布的详细信息
</h4>

<p>
截断分布是这样一种被转换的分布
输入在u_min ..U_max，或者输出在
波段y_min ..y_max。
截断分布是从基数推导出来的
分布(例如，从正态分布)，通过截断其
概率密度函数到所需的波段，并添加一个常数
在这个带上的值，以便对截断的分布积分
仍然是。然后可以确定所有其他属性(例如累积分布函数)
以一种直接的方式，提供底层基本分布的属性
是可用的。
可以找到更多细节，例如，在
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>
(右侧“截断分布”框中的方程
(此包使用了本维基百科文章的链接)。
</p>

<p>
当根据给定的截断分布使用随机数时，
逆累积分布函数(=分位数)的输出受到限制
到定义的频带。
</p>

<p>
截断的分布函数是从底层分布派生出来的
功能如下:
</p>

<blockquote><pre>
// 原始分布
    pdf = Distributions.XXX.density(u,..);
    cdf = Distributions.XXX.cumulative(u,...);
cdf_min = Distributions.XXX.cumulative(u_min,...);
cdf_max = Distributions.XXX.cumulative(u_max,...);

// 截断分布
</pre></blockquote>
<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><th><strong><em>Function</em></strong></th><th><strong><em>Transformation</em></strong></th></tr>
  <tr><td>density(u,u_min,u_max,...)</td>
      <td>= <strong>if</strong> u &ge; u_min <strong>and</strong> u&le;u_max <strong>then</strong> pdf / (cdf_max - cdf_min) <strong>else</strong> 0</td>
  </tr>
  <tr><td>cumulative(u,u_min,u_max,...)</td>
      <td>= <strong>if</strong> u &le; u_min <strong>then</strong> 0
            <strong>else if</strong> u &lt; u_max <strong>then</strong>
              (cdf - cdf_min))/(cdf_max - cdf_min)
            <strong>else</strong> 1</td>
  </tr>
  <tr><td>quantile(u,u_min,u_max,...)</td>
      <td>= Distributions.XXX.quantile( cdf_min + u*(cdf_max - cdf_min), ... )</td>
  </tr>
</table>
</blockquote>
<p>
有关截断分布的示例，请参见以下内容
正态分布的概率密度函数图
与其截尾分布相比:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.density.png\">
</blockquote>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         实现的初始版本
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
end Distributions;