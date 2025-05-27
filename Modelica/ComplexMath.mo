within Modelica;
package ComplexMath 
  "复数函数库(例如sin、cos)和复数向量、矩阵运算函数库"
  extends Modelica.Icons.Package;
  final constant Complex j = Complex(0, 1) "虚数单位";

  package Vectors "复数向量运算的函数库"
    extends Modelica.Icons.FunctionsPackage;

    function norm "返回复数向量的p-范数"
      extends Modelica.Icons.Function;
      input Complex v[:] "向量";
      input Real p(min = 1) = 2 
        "p-范数类型(常用：1、2或Modelica.Constants.inf)";
      output Real result "向量v的p-范数";

    algorithm
      if p == 2 then
        result := .sqrt(.sum(v[i].re ^ 2 + v[i].im ^ 2 for i in 1:size(v, 1)));
      elseif p == Modelica.Constants.inf then
        result := ComplexMath.abs(ComplexMath.max(v));
      elseif p == 1 then
        result := .sum(ComplexMath.abs(v[i]) for i in 1:size(v, 1));
      else
        result := (.sum(ComplexMath.abs(v[i]) ^ p for i in 1:size(v, 1))) ^ (1 / p);
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>norm</strong>(v);
Vectors.<strong>norm</strong>(v,p=2);   // 1 &le; p &le; &#8734;
</pre></blockquote>

<h4>描述</h4>
<p>
调用函数\"<code>Vectors.<strong>norm</strong>(v)</code>\"返回向量v的<strong>欧几里得范数</strong>\"sqrt(v*v)\"。
第二个参数p作为可选参数，任何其他p-范数都可以计算:
</p>
<center>
<img src=\"modelica://Modelica/Resources/Images/Math/Vectors/vectorNorm.png\" alt=\"function Vectors.norm\">
</center>
<p>
除了欧几里得范数(p=2)，有时还会使用1-范数和无穷范数：
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>1-norm</strong></td>
      <td>= sum(abs(v))</td>
      <td><strong>norm</strong>(v,1)</td>
  </tr>
  <tr><td><strong>2-norm</strong></td>
      <td>= sqrt(v*v)</td>
      <td><strong>norm</strong>(v) or <strong>norm</strong>(v,2)</td>
  </tr>
  <tr><td><strong>infinity-norm</strong></td>
      <td>= max(abs(v))</td>
      <td><strong>norm</strong>(v,Modelica.Constants.<strong>inf</strong>)</td>
  </tr>
</table>
<p>
注意，对于任何向量范数，以下不等式成立：
</p>
<blockquote><pre>
<strong>norm</strong>(v1+v2,p) &le; <strong>norm</strong>(v1,p) + <strong>norm</strong>(v2,p)
</pre></blockquote>

<h4>示例</h4>
<blockquote><pre>
v = {2, -4, -2, -1};
<strong>norm</strong>(v,1);    // = 9
<strong>norm</strong>(v,2);    // = 5
<strong>norm</strong>(v);      // = 5
<strong>norm</strong>(v,10.5); // = 4.00052597412635
<strong>norm</strong>(v,Modelica.Constants.inf);  // = 4
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.norm\">Matrices.norm</a>
</p>
</html>"      ));
    end norm;

    function length "返回复数向量的长度"
      extends Modelica.Icons.Function;
      input Complex v[:] "向量";
      output Real result "向量v的长度";

    algorithm
      result := .sqrt(.sum({v[i].re ^ 2 + v[i].im ^ 2 for i in 1:size(v, 1)}));
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>length</strong>(v);
</pre></blockquote>

<h4>说明</h4>

<p>
调用函数\"<code>Vectors.<strong>length</strong>(v)</code>\"返回向量v的<strong>欧几里得长度</strong> \"<code>sqrt(v*v)</code>\"。
该函数调用等价于Vectors.norm(v)。
与norm(v)相比，length(v)的优势在于函数length(..)是通过一个语句实现的，因此该函数通常会被自动内联。
进一步的符号处理是可能的，而在函数norm(..)中则不行。
</p>

<h4>示例</h4>
<blockquote><pre>
v = {2, -4, -2, -1};
<strong>length</strong>(v);  // = 5
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.norm\">Vectors.norm</a>
</p>
</html>"      ));
    end length;

    function normalize 
      "返回归一化的复数向量，使得其长度为 1，并且防止零向量出现除零错误"
      extends Modelica.Icons.Function;
      input Complex v[:] "向量";
      input Real eps = 100 * Modelica.Constants.eps "如果|v| < eps，则result = v";
      output Complex result[size(v, 1)] "将输入向量v标准化为length = 1";

    protected
      Real length_v = length(v);
    algorithm
      if length_v >= eps then
        for i in 1:size(v, 1) loop
          result[i] := v[i].re / length_v + (v[i].im / length_v) * j;
        end for;
      else
        result := v;
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>normalize</strong>(v);
Vectors.<strong>normalize</strong>(v,eps=100*Modelica.Constants.eps);
</pre></blockquote>

<h4>描述</h4>
<p>
调用函数\"<code>Vectors.<strong>normalize</strong>(v)</code>\"返回向量v的<strong>单位向量</strong> \"<code>v/length(v)</code>\"。
如果length(v)接近于零(更准确地说，如果length(v) < eps),返回v是为了避免出现除零错误。
对于许多应用来说，这是很有用的，因为通常使用单位向量<strong>e</strong> = <strong>v</strong>/length(<strong>v</strong>)来计算一个向量x * <strong>e</strong>，其中标量 x 的大小与 length(v) 的数量级相当，
也就是说，当length(<strong>v</strong>)较小时，x * <strong>e</strong>很小，此时可以用<strong>v</strong>替代<strong>e</strong>来避免除零错误。
</p>
<p>
由于该函数是通过一个语句实现的，因此通常会被内联处理，因此可以进行符号处理。
</p>

<h4>示例</h4>
<blockquote><pre>
<strong>normalize</strong>({1,2,3});  // = {0.267, 0.534, 0.802}
<strong>normalize</strong>({0,0,0});  // = {0,0,0}
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>
</p>
</html>"              ));
    end normalize;

    function reverse "反转向量元素(例如，v[1]变为最后一个元素)"
      extends Modelica.Icons.Function;

      input Complex v[:] "向量";
      output Complex result[size(v, 1)] "向量v的元素按相反顺序排列";

    algorithm
      result := {v[end - i + 1] for i in 1:size(v, 1)};
      annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>reverse</strong>(v);
</pre></blockquote>
<h4>描述</h4>
<p>
调用函数\"<code>Vectors.<strong>reverse</strong>(v)</code>\"返回复数向量元素的逆序。
</p>

<h4>示例</h4>
<blockquote><pre>
<strong>reverse</strong>({1,2,3,4});  // = {4,3,2,1}
</pre></blockquote>
</html>"                  ));
    end reverse;

    function sort "对复数向量的元素进行排序"
      extends Modelica.Icons.Function;
      input Complex v[:] "待排序向量";
      input Boolean ascending = true 
        "如果等于true则按升序排列，否则按降序排列";
      input Boolean sortFrequency = true 
        "= true，则先对虚值排序，再对实值排序；= false，则对绝对值排序";
      output Complex sorted_v[size(v, 1)] = v "排序后的向量";
      output Integer indices[size(v, 1)] = 1:size(v, 1) "sorted_v = v[indices]";

      /* 希尔排序算法；以后应加以改进 */
    protected
      Integer gap;
      Integer i;
      Integer j;
      Complex wv;
      Integer wi;
      Integer nv = size(v, 1);
      Boolean swap;
      Integer k1;
      Integer k2;
    algorithm
      gap := div(nv, 2);

      while gap > 0 loop
        i := gap;
        while i < nv loop
          j := i - gap;
          if j >= 0 then
            k1 := j + 1;
            k2 := j + gap + 1;
            if sortFrequency then
              if ascending then
                swap := .abs(sorted_v[k1].im) > .abs(sorted_v[k2].im) or 
                  .abs(sorted_v[k1].im) == .abs(sorted_v[k2].im) and 
                  (sorted_v[k1].re > sorted_v[k2].re or 
                  sorted_v[k1].re == sorted_v[k2].re and sorted_v[k1].im < sorted_v[k2].im);
              else
                swap := .abs(sorted_v[k1].im) < .abs(sorted_v[k2].im) or 
                  .abs(sorted_v[k1].im) == .abs(sorted_v[k2].im) and 
                  (sorted_v[k1].re < sorted_v[k2].re or 
                  sorted_v[k1].re == sorted_v[k2].re and sorted_v[k1].im < sorted_v[k2].im);
              end if;
            else
              if ascending then
                swap := ComplexMath.abs(sorted_v[k1]) > ComplexMath.abs(sorted_v[k2]);
              else
                swap := ComplexMath.abs(sorted_v[k1]) < ComplexMath.abs(sorted_v[k2]);
              end if;
            end if;
          else
            swap := false;
          end if;

          while swap loop
            wv := sorted_v[j + 1];
            wi := indices[j + 1];
            sorted_v[j + 1] := sorted_v[j + gap + 1];
            sorted_v[j + gap + 1] := wv;
            indices[j + 1] := indices[j + gap + 1];
            indices[j + gap + 1] := wi;
            j := j - gap;
            if j >= 0 then
              k1 := j + 1;
              k2 := j + gap + 1;
              if sortFrequency then
                if ascending then
                  swap := .abs(sorted_v[k1].im) > .abs(sorted_v[k2].im) or 
                    .abs(sorted_v[k1].im) == .abs(sorted_v[k2].im) and 
                    (sorted_v[k1].re > sorted_v[k2].re or 
                    sorted_v[k1].re == sorted_v[k2].re and sorted_v[k1].im < sorted_v[k2].im);
                else
                  swap := .abs(sorted_v[k1].im) < .abs(sorted_v[k2].im) or 
                    .abs(sorted_v[k1].im) == .abs(sorted_v[k2].im) and 
                    (sorted_v[k1].re < sorted_v[k2].re or 
                    sorted_v[k1].re == sorted_v[k2].re and sorted_v[k1].im < sorted_v[k2].im);
                end if;
              else
                if ascending then
                  swap := ComplexMath.abs(sorted_v[k1]) > ComplexMath.abs(sorted_v[k2]);
                else
                  swap := ComplexMath.abs(sorted_v[k1]) < ComplexMath.abs(sorted_v[k2]);
                end if;
              end if;
            else
              swap := false;
            end if;
          end while;
          i := i + 1;
        end while;
        gap := div(gap, 2);
      end while;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
           sorted_v = Vectors.<strong>sort</strong>(v);
(sorted_v, indices) = Vectors.<strong>sort</strong>(v, ascending=true);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>sort</strong>(..)对复数向量v进行升序排序，并将结果返回在sorted_v中。
如果可选参数\"ascending\"为<strong>false</strong>，则向量按降序排序。
在可选的第二个输出参数中，给出排序后的向量相对于原始向量的索引，使得sorted_v = v[indices]。
</p>

<h4>示例</h4>
<blockquote><pre>
(v2, i2) := Vectors.sort({-1, 8, 3, 6, 2});
    -> v2 = {-1, 2, 3, 6, 8}
       i2 = {1, 5, 3, 4, 2}
</pre></blockquote>

</html>"    ));
    end sort;

    annotation(Documentation(info = "<html>
<p>
这个库提供了用于复数向量运算的函数。
</p>
</html>"  ));
  end Vectors;

  function sin "复数的正弦"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "sin(c1)";
  algorithm
    c2 := (exp(Complex(-c1.im, +c1.re)) - exp(Complex(+c1.im, -c1.re))) / Complex(0, 2);
    annotation(Inline = true, Documentation(info = "<html>
<p>该函数返回输入复数的复数正弦值.</p>
</html>"  ));
  end sin;

  function cos "复数的余弦"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= cos(c1)";
  algorithm
    c2 := (exp(Complex(-c1.im, +c1.re)) + exp(Complex(+c1.im, -c1.re))) / 2;
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的复数余弦值.</p>
</html>"  ));
  end cos;

  function tan "复数的正切"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= tan(c1)";
  algorithm
    c2 := sin(c1) / cos(c1);
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的复数正切值.</p>
</html>"  ));
  end tan;

  function asin "复数的反正弦"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "arc_sin(c1)";
  algorithm
    c2 := -j * log(j * c1 + sqrt(1 - c1 * c1));
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的反正弦值。</p>
</html>"  ));
  end asin;

  function acos "复数的反余弦"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= arc_cos(c1)";
  algorithm
    c2 := -j * log(c1 + j * sqrt(1 - c1 * c1));
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的反余弦值。</p>
</html>"  ));
  end acos;

  function atan "复数的反正切"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= arc_tan(c1)";
  algorithm
    c2 := 0.5 * j * log((j + c1) / (j - c1));
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的反正切值。</p>
</html>"  ));
  end atan;

  function sinh "复数的双曲正弦"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "sinh(c1)";
  algorithm
    c2 := Complex(Math.sinh(c1.re) * Math.cos(c1.im), Math.cosh(c1.re) * Math.sin(c1.im));
    annotation(Inline = true, Documentation(info = "<html>
<p>该函数返回输入复数的复双曲正弦值。</p>
</html>"  ));
  end sinh;

  function cosh "复数的双曲余弦"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= cosh(c1)";
  algorithm
    c2 := Complex(Math.cosh(c1.re) * Math.cos(c1.im), Math.sinh(c1.re) * Math.sin(c1.im));
    annotation(Inline = true, Documentation(info = "<html>
<p>该函数返回输入复数的复双曲余弦值。</p>
</html>"  ));
  end cosh;

  function tanh "复数的双曲正切"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= tanh(c1)";
  algorithm
    c2 := sinh(c1) / cosh(c1);
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的复双曲正切值。</p>
</html>"  ));
  end tanh;

  function asinh "复数的反双曲正弦"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "ar_sinh(c1)";
  algorithm
    c2 := log(c1 + sqrt(c1 * c1 + 1));
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的反双曲正弦值。</p>
</html>"    ));
  end asinh;

  function acosh "复数的反双曲余弦"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= ar_cosh(c1)";
  algorithm
    c2 := log(c1 + (c1 + 1) * sqrt((c1 - 1) / (c1 + 1)));
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的反双曲余弦值。</p>
</html>"  ));
  end acosh;

  function atanh "复数的反双曲正切"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= ar_tanh(c1)";
  algorithm
    c2 := 0.5 * log((1 + c1) / (1 - c1));
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的反双曲正切值。</p>
</html>"    ));
  end atanh;

  function exp "复数的指数"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= exp(c1)";
  algorithm
    c2 := Complex(Math.exp(c1.re) * Math.cos(c1.im), Math.exp(c1.re) * Math.sin(c1.im));
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的自然指数值。</p>
</html>"  ));
  end exp;

  function log "复数的对数"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= log(c1)";
  algorithm
    c2 := Complex(Modelica.Math.log(abs(c1)), arg(c1));
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的自然对数值。</p>
</html>"    ));
  end log;

  function abs "复数的绝对值"
    extends Modelica.Icons.Function;
    input Complex c "复数";
    output Real result "= abs(c)";
  algorithm
    result := (c.re ^ 2 + c.im ^ 2) ^ 0.5;  //从sqrt修改
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的实数绝对值，即它的长度值。</p>
</html>"  ));
  end abs;

  function arg "复数的相位角"
    extends Modelica.Icons.Function;
    input Complex c "复数";
    input Modelica.Units.SI.Angle phi0 = 0 
      "相位角phi的取值范围: -pi < phi-phi0 < pi";
    output Modelica.Units.SI.Angle phi "复数c的相位角";
  algorithm
    phi := Modelica.Math.atan3(
      c.im, 
      c.re, 
      phi0);
    annotation(Inline = true, Documentation(info = "<html>
<p>该函数返回输入复数的实数参数，即其角度。</p>
</html>"  ));
  end arg;

  function conj "复数的共轭"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= c1.re - j*c1.im";
  algorithm
    c2 := Complex(c1.re, -c1.im);
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的共轭值。</p>
</html>"  ));
  end conj;

  function real "复数的实部"
    extends Modelica.Icons.Function;
    input Complex c "复数";
    output Real r "= c.re";
  algorithm
    r := c.re;
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的实部。</p>
</html>"  ));
  end real;

  function imag "复数的虚部"
    extends Modelica.Icons.Function;
    input Complex c "复数";
    output Real r "= c.im";
  algorithm
    r := c.im;
    annotation(Inline = true, Documentation(info = "<html>
<p>此函数返回输入复数的虚部。</p>
</html>"  ));
  end imag;

  function fromPolar "极坐标形式得到复数"
    extends Modelica.Icons.Function;
    input Real len "复数的绝对值";
    input Modelica.Units.SI.Angle phi "复数的相位角";
    output Complex c "= len*cos(phi) + j*len*sin(phi)";
  algorithm
    c := Complex(len * Modelica.Math.cos(phi), len * Modelica.Math.sin(phi));
    annotation(Inline = true, Documentation(info = "<html>
<p>这个函数从它的长度(绝对值)和角度(参数)构造一个复数。</p>
</html>"  ));
  end fromPolar;

  function sqrt "复数的平方根"
    extends Modelica.Icons.Function;
    input Complex c1 "复数";
    output Complex c2 "= sqrt(c1)";
  algorithm
    c2 := Complex(.sqrt(abs(c1)) * Math.cos(arg(c1) / 2), .sqrt(abs(c1)) * Math.sin(arg(c1) / 2));
    annotation(Inline = true, Documentation(info = "<html>
<p>这个函数返回输入复数的复平方根(主平方根)。</p>
</html>"  ));
  end sqrt;

  function max "返回复数向量的最大元素"
    extends Modelica.Icons.Function;
    input Complex v[:] "向量";
    output Complex result "v中绝对值最大的元素";
    output Integer index "v[index]的绝对值最大";
  protected
    Real absv_i;
    Real absres;
  algorithm
    if size(v, 1) > 0 then
      absres := abs(v[1]);
      index := 1;
      for i in 2:size(v, 1) loop
        absv_i := abs(v[i]);
        if absv_i > absres then
          absres := absv_i;
          index := i;
        end if;
      end for;
      result := v[index];
    else
      result := Complex(0);
      index := 0;
    end if;
    annotation(Documentation(info = "<html>
<p>这个函数返回输入复数向量中绝对值最大的元素。</p>
</html>"        ));
  end max;

  function min "返回复数向量的最小元素"
    extends Modelica.Icons.Function;
    input Complex v[:] "向量";
    output Complex result "v中绝对值最小的元素";
    output Integer index "v[index]的绝对值最小";
  protected
    Real absv_i;
    Real absres;
  algorithm
    if size(v, 1) > 0 then
      absres := abs(v[1]);
      index := 1;
      for i in 2:size(v, 1) loop
        absv_i := abs(v[i]);
        if absv_i < absres then
          absres := absv_i;
          index := i;
        end if;
      end for;
      result := v[index];
    else
      result := Complex(0);
      index := 0;
    end if;
    annotation(Documentation(info = "<html>
<p>这个函数返回输入复数向量中绝对值最小的元素。</p>
</html>"          ));
  end min;

  function sum "返回复数向量的和"
    extends Modelica.Icons.Function;
    input Complex v[:] "向量";
    output Complex result "复数向量元素的和";
  algorithm
    result := Complex(.sum(v[:].re), .sum(v[:].im));
    annotation(Inline = true, Documentation(info = "<html>
<p>这个函数返回复数输入向量的复数和。</p>
</html>"  ));
  end sum;

  function product "返回复向量的乘积"
    extends Modelica.Icons.Function;
    input Complex v[:] "向量";
    output Complex result "复数向量元素的积";
  algorithm
    result := Complex(1);
    for i in 1:size(v, 1) loop
      result := result * v[i];
    end for;
    annotation(Documentation(info = "<html>
<p>这个函数返回输入复数向量的复数乘积。</p>
</html>"  ));
  end product;

  annotation(Documentation(info = "<html>
<p>
这个包包含了用于处理复数的<strong>基本数学函数</strong>(例如sin(..))，以及用于处理复数向量的函数。
</p>

</html>"), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
    preserveAspectRatio = false), graphics = {
    Line(points = {{32, -86}, {32, 88}}, color = {175, 175, 175}), 
    Line(points = {{-84, 2}, {88, 2}}, color = {175, 175, 175}), 
    Line(
    points = {{-50, 75}, {-5, 30}}), 
    Line(
    points = {{-50, 30}, {-5, 75}}), 
    Line(
    points = {{-50, -30}, {-5, -75}}), 
    Line(
    points = {{-50, -75}, {-5, -30}})}));

end ComplexMath;