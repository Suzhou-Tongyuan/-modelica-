within Modelica;
package Math "数学函数库(例如sin、cos)和向量、矩阵运算函数库"

  extends Modelica.Icons.Package;

  package Vectors "向量运算函数库"
    extends Modelica.Icons.Package;

    function toString "将实型向量转换为字符串表示形式"
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Strings;

      input Real v[:] "实型向量";
      input String name = "" "用于打印的独立变量名";
      input Integer significantDigits = 6 "显示的有效位数";
      output String s = "";
    protected
      String blanks = Strings.repeat(significantDigits);
      String space = Strings.repeat(8);
      Integer r = size(v, 1);

    algorithm
      if r == 0 then
        s := if name == "" then "[]" else name + " = []";
      else
        s := if name == "" then "\n" else "\n" + name + " = \n";
        for i in 1:r loop
          s := s + space;

          if v[i] >= 0 then
            s := s + " ";
          end if;
          s := s + String(v[i], significantDigits = significantDigits) + 
            Strings.repeat(significantDigits + 8 - Strings.length(String(abs(v[i]))));

          s := s + "\n";
        end for;

      end if;

      annotation(Documentation(info = "<html><h4>语法</h4><p>
<br>
</p>
<pre><code >Vectors.toString(v);
Vectors.toString(v,name=\"\",significantDigits=6);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
调用函数\"<code><strong>Vectors.toString(v)</strong></code>\"返回向量<strong>v</strong>的字符串表示形式。
通过可选参数\"name\"和\"significantDigits\"，定义了一个名称和有效位数。 \"name\"和\"significantDigits\"的默认值分别为\" \"和\"6\"。
如果name==\" \"(空字符串)，则前缀\"&lt;name&gt;=\"在输出字符串中被省略.
</p>
<h4>示例</h4><p>
<br>
</p>
<pre><code>v = {2.12, -4.34, -2.56, -1.67};
toString(v);
// = \"
//           2.12
//          -4.34
//          -2.56
//          -1.67\"
toString(v,\"vv\",1);
// = \"vv =
//           2
//          -4
//          -3
//          -2\"
</code></pre><p>
<br>
</p>
<h4>另见</h4><p>
<a href=\"modelica://Modelica.Math.Matrices.toString\" target=\"\">Matrices.toString</a>,
</p>
<p>
<br>
</p>
</html>"        , revisions = "<html>

</html>"        ));
    end toString;

    function isEqual "确定两个实型向量在数值上是否相同"
      extends Modelica.Icons.Function;
      input Real v1[:] "第一个向量";
      input Real v2[:] "第二个向量(长度可能与v1不同)";
      input Real eps(min = 0) = 0 
        "如果abs(e1-e2) <= eps，则两个向量中的两个元素e1和e2相同";
      output Boolean result 
        "= true，如果两个向量具有相同的长度和元素";

    protected
      Integer n = size(v1, 1) "向量v1的维数";
      Integer i = 1;
    algorithm
      result := false;
      if size(v2, 1) == n then
        result := true;
        while i <= n loop
          if abs(v1[i] - v2[i]) > eps then
            result := false;
            i := n;
          end if;
          i := i + 1;
        end while;
      end if;
      annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >Vectors.isEqual(v1, v2);
Vectors.isEqual(v1, v2, eps=0);
</code></pre><p>
<br>
</p>
<h4>说明</h4><p>
调用函数\"<code>Vectors.isEqual(v1, v2)</code>\"如果两个实型向量v1和v2有相同的维数和相同的元素，返回<strong>true</strong> ，否则函数返回<strong>false</strong>。 两个向量的两个元素e1和e2通过检查\"abs(e1-e2) ≤eps\"，其中\"eps\" 可以作为函数的第三个参数提供。默认值为\"eps = 0\"。
</p>
<h4>示例</h4><p>
<br>
</p>
<pre><code >Real v1[3] = {1, 2, 3};
Real v2[4] = {1, 2, 3, 4};
Real v3[3] = {1, 2, 3.0001};
Boolean result;
algorithm
result := Vectors.isEqual(v1,v2);     // = false
result := Vectors.isEqual(v1,v3);     // = false
result := Vectors.isEqual(v1,v1);     // = true
result := Vectors.isEqual(v1,v3,0.1); // = true
</code></pre><p>
<br>
</p>
<h4>另见</h4><p>
<a href=\"modelica://Modelica.Math.Vectors.find\" target=\"\">Vectors.find</a>&nbsp;, <a href=\"modelica://Modelica.Math.Matrices.isEqual\" target=\"\">Matrices.isEqual</a>&nbsp;, <a href=\"modelica://Modelica.Utilities.Strings.isEqual\" target=\"\">Strings.isEqual</a>&nbsp;
</p>
<p>
<br>
</p>
</html>"));
    end isEqual;

    function norm "返回向量的p-范数"
      extends Modelica.Icons.Function;
      input Real v[:] "实型向量";
      input Real p(min = 1) = 2 
        "p-范数类型(常用：1、2或Modelica.Constants.inf)";
      output Real result = 0.0 "向量v的p-范数";
    protected
      Real eps = 10 * Modelica.Constants.eps;
    algorithm
      if size(v, 1) > 0 then
        if p >= 2 - eps and p <= 2 + eps then
          result := sqrt(v * v);
        elseif p >= Modelica.Constants.inf then
          result := max(abs(v));
        elseif p >= 1 - eps and p <= 1 + eps then
          result := sum(abs(v));
        elseif p >= 1 then
          result := (sum(abs(v[i]) ^ p for i in 1:size(v, 1))) ^ (1 / p);
        else
          assert(false, "Optional argument \"p\" (= " + String(p) + ") of function \"norm\" >= 1 required");
        end if;
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
</html>"                    ));
    end norm;

    function length 
      "返回向量的长度(如果执行进一步的符号处理，比使用norm()好)"
      extends Modelica.Icons.Function;
      input Real v[:] "实型向量";
      output Real result "向量v的长度";
    algorithm
      result := sqrt(v * v);
      annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>length</strong>(v);
</pre></blockquote>
<h4>描述</h4>
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
</html>"    ));
    end length;

    function normalize 
      "返回归一化的向量，使得其长度为 1，并且防止零向量出现除零错误"
      extends Modelica.Icons.Function;
      input Real v[:] "实型向量";
      input Real eps(min = 0.0) = 100 * Modelica.Constants.eps 
        "如果|v| < eps则result = v/eps";
      output Real result[size(v, 1)] "输入向量v归一化为length = 1";

    algorithm
      /* 该函数具有内联注释。如果函数是内联的:
      - "smooth(..)"定义了该表达式可以被区分的频率(如果执行了符号处理)。
      */
      result := smooth(0, if length(v) >= eps then v / length(v) else v / eps);
      annotation(Inline = true, Documentation(info = "<html>
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
<h4>另外</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>,
<a href=\"modelica://Modelica.Math.Vectors.normalize\">Vectors.normalizeWithAssert</a>
</p>
</html>"                            ));
    end normalize;

    function normalizeWithAssert 
      "返回归一化的向量，使长度为1(触发零向量断言)"
      import Modelica.Math.Vectors.length;
      extends Modelica.Icons.Function;
      input Real v[:] "实型向量";
      output Real result[size(v, 1)] "输入向量v归一化为length = 1";

    algorithm
      assert(length(v) > 0.0, "向量v = {0,0,0}应归一化(= v/sqrt(v*v))，但这导致会除零错误。\n提供一个非零向量!");
      result := v / length(v);
      annotation(
        Inline = true, 
        Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>normalizeWithAssert</strong>(v);
</pre></blockquote>
<h4>描述</h4>
<p>
调用函数\"<code>Vectors.<strong>normalizeWithAssert</strong>(v)</code>\"返回<strong>单位向量</strong> \"<code>v/sqrt(v*v)</code>\"。
如果向量v是零向量，则触发断言。
</p>
<p>
由于该函数具有\"Inline\"注释，因此它通常是内联的，可以进行符号处理。
</p>
<h4>示例</h4>
<blockquote><pre>
<strong>normalizeWithAssert</strong>({1,2,3});  // = {0.267, 0.534, 0.802}
<strong>normalizeWithAssert</strong>({0,0,0});  // error (an assert is triggered)
</pre></blockquote>
<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>,
<a href=\"modelica://Modelica.Math.Vectors.normalize\">Vectors.normalize</a>
</p>
</html>"                            ));
    end normalizeWithAssert;

    function reverse "反转向量元素(例如，v[1]成为最后一个元素)"
      extends Modelica.Icons.Function;
      input Real v[:] "实型向量";
      output Real result[size(v, 1)] "向量v的元素按相反顺序排列";

    algorithm
      result := {v[end - i + 1] for i in 1:size(v, 1)};
      annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>reverse</strong>(v);
</pre></blockquote>
<h4>说明</h4>
<p>
调用函数\"<code>Vectors.<strong>reverse</strong>(v)</code>\"返回相反顺序的向量元素.
</p>
<h4>示例</h4>
<blockquote><pre>
<strong>reverse</strong>({1,2,3,4});  // = {4,3,2,1}
</pre></blockquote>
</html>"            ));
    end reverse;

    function sort "按升序或降序对向量元素排序"
      extends Modelica.Icons.Function;
      input Real v[:] "要排序的实型向量";
      input Boolean ascending = true 
        "= true，如果升序，否则降序";
      output Real sorted_v[size(v, 1)] = v "排序后的向量";
      output Integer indices[size(v, 1)] = 1:size(v, 1) "sorted_v = v[indices]";

      /* 希尔排序算法；以后应加以改进 */
    protected
      Integer gap;
      Integer i;
      Integer j;
      Real wv;
      Integer wi;
      Integer nv = size(v, 1);
      Boolean swap;
    algorithm
      gap := div(nv, 2);

      while gap > 0 loop
        i := gap;
        while i < nv loop
          j := i - gap;
          if j >= 0 then
            if ascending then
              swap := sorted_v[j + 1] > sorted_v[j + gap + 1];
            else
              swap := sorted_v[j + 1] < sorted_v[j + gap + 1];
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
              if ascending then
                swap := sorted_v[j + 1] > sorted_v[j + gap + 1];
              else
                swap := sorted_v[j + 1] < sorted_v[j + gap + 1];
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
函数<strong>sort</strong>(..)对实型向量v进行升序排序，并将结果返回在sorted_v中。
如果可选参数\"ascending\"为<strong>false</strong>，则向量按降序排序。
在可选的第二个输出参数中，给出排序后的向量相对于原始向量的索引，使得sorted_v = v[indices]。
</p>
<h4>示例</h4>
<blockquote><pre>
(v2, i2) := Vectors.sort({-1, 8, 3, 6, 2});
   -> v2 = {-1, 2, 3, 6, 8}
      i2 = {1, 5, 3, 4, 2}
</pre></blockquote>
</html>"        ));
    end sort;

    function find "查找矢量中的元素"
      extends Modelica.Icons.Function;
      input Real e "搜索 e";
      input Real v[:] "真实矢量";
      input Real eps(min = 0) = 0 
        "如果 abs(e-v[i]) <= eps，元素 e 等于向量 v 的元素 v[i]";
      output Integer result 
        "v[result] = e（e 的首次出现）；如果未找到，则 result=0";
    protected
      Integer i;
    algorithm
      result := 0;
      i := 1;
      while i <= size(v, 1) loop
        if abs(v[i] - e) <= eps then
          result := i;
          i := size(v, 1) + 1;
        else
          i := i + 1;
        end if;
      end while;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>find</strong>(e, v);
Vectors.<strong>find</strong>(e, v, eps=0);
</pre></blockquote>
<h4>描述</h4>
<p>
调用函数\"<code>Vectors.find(e, v)</code>\"返回输入e在向量<strong>v</strong>中第一次出现的索引。
等式检验由\"abs(e - v[i]) &le;eps\"，其中\"eps\"可以作为函数的第三个参数提供。默认值为 \"eps = 0\"。
</p>
<h4>示例</h4>
<blockquote><pre>
Real v[3] = {1, 2, 3};
Real e1 = 2;
Real e2 = 3.01;
Boolean result;
<strong>algorithm</strong>
result := Vectors.find(e1,v);          // = <strong>2</strong>
result := Vectors.find(e2,v);          // = <strong>0</strong>
result := Vectors.find(e2,v,eps=0.1);  // = <strong>3</strong>
</pre></blockquote>
<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>
</p>
</html>"            ));
    end find;

    function interpolate "对向量进行线性插值"
      extends Modelica.Icons.Function;
      input Real x[:] 
        "横坐标表向量(要求严格单调递增的值)";
      input Real y[size(x, 1)] "纵坐标表向量";
      input Real xi "期望的横坐标值";
      input Integer iLast = 1 "上次搜索时使用的索引";
      output Real yi "与xi对应的纵坐标值";
      output Integer iNew = 1 "xi位于区间x[iNew] <= xi < x[iNew+1]中";
    protected
      Integer i;
      Integer nx = size(x, 1);
      Real x1;
      Real x2;
      Real y1;
      Real y2;
    algorithm
      assert(nx > 0, "表格向量必须至少有一个元素。");
      if nx == 1 then
        yi := y[1];
      else
        // 搜索间隔
        i := min(max(iLast, 1), nx - 1);
        if xi >= x[i] then
          // 向前搜索
          while i < nx and xi >= x[i] loop
            i := i + 1;
          end while;
          i := i - 1;
        else
          // 向后搜索
          while i > 1 and xi < x[i] loop
            i := i - 1;
          end while;
        end if;

        // 获取插值数据
        x1 := x[i];
        x2 := x[i + 1];
        y1 := y[i];
        y2 := y[i + 1];

        assert(x2 > x1, "横坐标表向量的值必须是递增的");
        // 内插法
        yi := y1 + (y2 - y1) * (xi - x1) / (x2 - x1);
        iNew := i;
      end if;

      annotation(smoothOrder(normallyConstant = x, normallyConstant = y) = 100, 
        Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
// Real    x[:], y[:], xi, yi;
// Integer iLast, iNew;
    yi = Vectors.<strong>interpolate</strong>(x,y,xi);
(yi, iNew) = Vectors.<strong>interpolate</strong>(x,y,xi,iLast=1);
</pre></blockquote>
<h4>描述</h4>
<p>
调用函数\"<code>Vectors.interpolate(x,y,xi)</code>\"在向量(, y)中进行线性插值，并返回与xi对应的值yi。
向量x[:]必须由单调递增的值构成。如果xi < x[1]或xi > x[end]，则分别通过x[:]中的第一个或最后两个值进行外推。
如果x和y向量的长度为1，则始终返回y[1]。搜索区间x[iNew] ≤ xi < x[iNew+1]从可选输入参数 \"iLast\"开始。
索引\"iNew\"将作为输出参数返回。如果进行多次插值，使用\"iLast\"和\"iNew\"可以提高调用效率。
如果x中有两个或更多相同的值，则插值使用具有最大索引的x值。
</p>

<h4>示例</h4>

<blockquote><pre>
Real x1[:] = { 0,  2,  4,  6,  8, 10};
Real x2[:] = { 1,  2,  3,  3,  4,  5};
Real y[:]  = {10, 20, 30, 40, 50, 60};
<strong>algorithm</strong>
(yi, iNew) := Vectors.interpolate(x1,y,5);  // yi = 35, iNew=3
(yi, iNew) := Vectors.interpolate(x2,y,4);  // yi = 50, iNew=5
(yi, iNew) := Vectors.interpolate(x2,y,3);  // yi = 40, iNew=4
</pre></blockquote>
</html>"            ));
    end interpolate;

    function relNodePositions "返回节点相对位置向量(0...1)"
      extends Modelica.Icons.Function;
      input Integer nNodes 
        "节点数(包括位于左和右位置的节点)";
      output Real xsi[nNodes] "节点的相对位置";
    protected
      Real delta;
    algorithm
      if nNodes >= 1 then
        xsi[1] := 0;
      end if;

      if nNodes >= 2 then
        xsi[nNodes] := 1;
      end if;

      if nNodes == 3 then
        xsi[2] := 0.5;
      elseif nNodes > 3 then
        delta := 1 / (nNodes - 2);
        for i in 2:nNodes - 1 loop
          xsi[i] := (i - 1.5) * delta;
        end for;
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.<strong>relNodePositions</strong>(nNodes);
</pre></blockquote>
<h4>描述</h4>
<p>
调用函数\"<code>relNodePositions(nNodes)</code>\"返回一个向量，
包含具有nNodes个节点(包括管道左侧和右侧节点)的离散化管道节点的相对位置，参见下图：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/Vectors/relNodePositions.png\">
</div>

<h4>示例</h4>

<blockquote><pre>
Real xsi[7];
<strong>algorithm</strong>
xsi = relNodePositions(7);  // xsi = {0, 0.1, 0.3, 0.5, 0.7, 0.9, 1}
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">MultiBody.Visualizers.PipeWithScalarField</a>
</p>
</html>"            ));
    end relNodePositions;
    annotation(preferredView = "info", Documentation(info = "<html>
<h4>库目录</h4>
<p>
该库提供了对向量进行操作的函数：
</p>

<ul>
<li> <a href=\"modelica://Modelica.Math.Vectors.toString\">toString</a>(v)
     - 返回向量v的字符串表示。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.isEqual\">isEqual</a>(v1, v2)
     - 如果向量v1和v2具有相同的大小和相同的元素，则返回true。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.norm\">norm</a>(v,p)
     - 返回向量v的p-范数。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.length\">length</a>(v)
     - 返回向量v的长度(即norm(v, 2)，但已内联，因此可用于符号操作)。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.normalize\">normalize</a>(v)
     - 返回与v方向相同、长度为1的向量，并防止零向量出现除零错误。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.reverse\">reverse</a>(v)
     - 反转向量v的元素顺序。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.sort\">sort</a>(v)
     - 将向量v的元素按升序或降序排序。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.find\">find</a>(e, v)
     - 返回标量e在向量v中首次出现的索引。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.interpolate\">interpolate</a>(x, y, xi)
     - 返回在(x, y)中与xi对应插值的值。</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.relNodePositions\">relNodePositions</a>(nNodes)
     - 返回相对节点位置的向量(0..1)。</li>
</ul>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices\">Matrices</a>
</html>"    ), 
      Icon(graphics = {Rectangle(
      extent = {{-16, 66}, {14, 18}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {175, 175, 175}, 
      fillPattern = FillPattern.Solid), Rectangle(
      extent = {{-16, -14}, {14, -62}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {175, 175, 175}, 
      fillPattern = FillPattern.Solid)}));
    package Utilities 
      "不应直接由用户使用的工具函数"
      extends Modelica.Icons.UtilitiesPackage;
      function householderVector 
        "计算归一化的householder向量，将向量a反射到向量b上"
        extends Modelica.Icons.Function;
        import Modelica.Math.Vectors.norm;

        input Real a[:] "要反射的实型向量";
        input Real b[size(a, 1)] "实向量b，向量a反射到它上";
        output Real u[size(a, 1)] "a反射到b上的householder向量";
      protected
        Real norm_a = norm(a, 2);
        Real norm_b = norm(b, 2);
        Real alpha;

      algorithm
        assert(norm_b > 0, 
          "Vector b in function householderVector is zero vector, but at least one element should be different from zero");
        assert(norm_a > 0, 
          "Vector a in function householderVector is zero vector, but at least one element should be different from zero");
        alpha := if norm(a + norm_a / norm_b * b, 2) > norm(a - norm_a / norm_b * b, 2) 
          then norm_a / norm_b else -norm_a / norm_b;
        u := (a + alpha * b) / length(a + alpha * b);

        annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >Vectors.Utilities.householderVector(a,b);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
函数调用\"<code> housedervector (a, b)</code>\"返回归一化的Householder向量 对于输入向量<strong>a</strong>在向量<strong>b</strong>上的Householder反射<strong>u</strong>，即Householder向量<strong>u</strong>为法线反射平面的矢量。在代数上，通过变换矩阵<strong>Q</strong>来实现反射。
</p>
<p>
<br>
</p>
<p>
 <strong>Q</strong> = <strong>I</strong> - 2*<strong>u</strong>*<strong>u</strong>\\',
</p>
<p>
<br>即，将vector <strong>a</strong>映射到<br>
</p>
<p>
<br>
</p>
<p>
 <strong>a</strong> -&gt; <strong>Q</strong>*<strong>a</strong>=c*<strong>b</strong>
</p>
<p>
<br>与标量c, |c| = ||<strong>a</strong>|| / ||<strong>b</strong>||. <strong>Q</strong>*<strong>a</strong>是<strong>a</strong>关于与<strong>u</strong>正交的超平面的反射.<br><strong>Q</strong> 是一个正交矩阵。<br>
</p>
<p>
<br>
</p>
<p>
 <strong>Q</strong> = inv(<strong>Q</strong>) = <strong>Q</strong>\\'
</p>
<p>
<br>
</p>
<h4>示例</h4><p>
<br>
</p>
<pre><code >a = {2, -4, -2, -1};
b = {1, 0, 0, 0};

u = householderVector(a,b);    // {0.837, -0.478, -0.239, -0.119}
                         // Computation (identity(4) - 2*matrix(u)*transpose(matrix(u)))*a results in
                         // {-5, 0, 0, 0} = -5*b
</code></pre><p>
<br>
</p>
<h4>另见<a href=\"modelica://Modelica.Math.Vectors.Utilities.householderReflection\" target=\"\">Vectors.Utilities.householderReflection</a><br><a href=\"modelica://Modelica.Math.Matrices.Utilities.householderReflection\" target=\"\">Matrices.Utilities.householderReflection</a><br><a href=\"modelica://Modelica.Math.Matrices.Utilities.householderSimilarityTransformation\" target=\"\">Matrices.Utilities.householderSimilarityTransformation</a></h4><p>
<br>
</p>
</html>",revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
 by Marcus Baur, DLR-RM</li>
</ul>

</html>"));
      end householderVector;

      function householderReflection 
        "用正交向量 u 在平面上反射一个向量 a"
        extends Modelica.Icons.Function;
        import Modelica.Math.Vectors;

        input Real a[:] "要反射的实向量 a";
        input Real u[size(a, 1)] "住户向量";
        output Real ra[size(u, 1)] "反映一个a";

      protected
        Real norm_a = Vectors.length(a);
        Real h = 2 * u * a;

      algorithm
        ra := a - h * u;

        // 接近零的值设置为零.
        for i in 1:size(ra, 1) loop
          ra[i] := if abs(ra[i]) >= norm_a * 1e-12 then ra[i] else 0;
        end for;

        annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Vectors.Utilities.<strong>householderReflection</strong>(a,u);
</pre></blockquote>
<h4>描述</h4>
<p>
函数\"<code> housederreflection (a, u)</code>\"执行向量的反射
关于向量<strong>u</strong> (Householder向量)正交的平面的<strong>a</strong>。
在代数上，运算定义为
</p>
<blockquote>
<p>
<strong>b</strong>=<strong>Q</strong>*<strong>a</strong>
</p>
</blockquote>
和
<blockquote>
<p>
<strong>Q</strong> = <strong>I</strong> - 2*<strong>u</strong>*<strong>u</strong>',
</p>
</blockquote>
其中<strong>Q</strong>是一个正交矩阵
<blockquote>
<p>
<strong>Q</strong> = inv(<strong>Q</strong>) = <strong>Q</strong>'
</p>
</blockquote>
<h4>示例</h4>
<blockquote><pre>
a = {2, -4, -2, -1};
u = {0.837, -0.478, -0.239, -0.119};

<strong>householderReflection</strong>(a,u);    //  = {-5.0, -0.001, -0.0005, -0.0044}
</pre></blockquote>
<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Vectors.Utilities.householderVector\">Utilities.householderVector</a><br>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderReflection\">Matrices.Utilities.householderReflection</a><br>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderSimilarityTransformation\">Matrices.Utilities.householderSimilarityTransformation</a>

</html>"                  , revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
 by Marcus Baur, DLR-RM</li>
</ul>
</html>"                  ));
      end householderReflection;

      encapsulated function roots 
        "计算假定最高系数不为零的多项式的零点"
        import Modelica.Math.Matrices;
        import Modelica;
        extends Modelica.Icons.Function;
        input Real p[:] 
          "具有多项式系数的向量p[1]*x^n +p[2]*x^(n-1) +p[n]*x +p[n-1]";
        output Real roots[max(0, size(p, 1) - 1),2] = fill(
          0, 
          max(0, size(p, 1) - 1), 
          2) 
          "根[:，1]和根[:，2]是多项式p根的实部和虚部";
      protected
        Integer np = size(p, 1);
        Integer n = size(p, 1) - 1;
        Real A[max(size(p, 1) - 1, 0),max(size(p, 1) - 1, 0)] "伴生矩阵";
        Real ev[max(size(p, 1) - 1, 0),2] "特征值";
      algorithm
        if n > 0 then
          assert(abs(p[1]) > 0, 
            "Computing the roots of a polynomial with function \"Modelica.Math.Vectors.Utilities.roots\"\n" 
            + 
            "failed because the first element of the coefficient vector is zero, but should not be.");

          // 伴生矩阵
          A[1,:] := -p[2:np] / p[1];
          A[2:n,:] := [identity(n - 1), zeros(n - 1)];

          // 根是伴随矩阵的特征值
          roots := Matrices.Utilities.eigenvaluesHessenberg(A);
        end if;
        annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
r = Vectors.Utilities.<strong>roots</strong>(p);
</pre></blockquote>
<h4>描述</h4>
<p>
该函数计算 x 的多项式 P 的根数
</p>
<blockquote><pre>
P = p[1]*x^n + p[2]*x^(n-1) + ... + p[n-1]*x + p[n+1];
</pre></blockquote>
<p>
与系数向量<strong>p</strong>。假设<strong>p</strong>的第一个元素不为零，即多项式的阶大小为(p,1)-1.
</p>
<p>
为了计算根，对应的伴矩阵<strong>C</strong>的特征值
</p>
<blockquote><pre>
   |-p[2]/p[1]  -p[3]/p[1]  ...  -p[n-2]/p[1]  -p[n-1]/p[1]  -p[n]/p[1] |
   |    1            0                0               0           0     |
   |    0            1      ...       0               0           0     |
<strong>C</strong> =    |    .            .      ...       .               .           .     |
   |    .            .      ...       .               .           .     |
   |    0            0      ...       0               1           0     |
</pre></blockquote>
<p>
计算。这些是多项式的根。<br>
由于伴生矩阵已经是海森伯格形式，所以不需要进行向海森伯格形式的变换。
Function <a href=\"modelica://Modelica.Math.Matrices.Utilities.eigenvaluesHessenberg\">eigenvaluesHessenberg</a><br>
为这些矩阵提供了有效的特征值计算.
</p>
<h4>示例</h4>
<blockquote><pre>
r = <strong>roots</strong>({1,2,3});
// r = [-1.0,  1.41421356237309;
//      -1.0, -1.41421356237309]
// which corresponds to the roots: -1.0 +/- j*1.41421356237309
</pre></blockquote>
</html>"                  ));
      end roots;
      annotation(Documentation(info = "<html>
<p>
本包包含由更高层次的向量和矩阵函数使用的工具函数。这些函数通常对最终用户没有太大用处。
</p>

</html>"            ));
    end Utilities;
  end Vectors;

  package Matrices "矩阵运算函数库"
    package Examples 
      "演示Math.Matrices函数用法的示例"
      extends Modelica.Icons.ExamplesPackage;
      function solveLinearEquations 
        "演示线性方程组的解法"
        extends Modelica.Icons.Function;
        import Modelica.Utilities.Streams.print;
        // solve and solve2
      protected
        Real A0[0,0];
        Real A1[2,2] = [1, 2; 3, 4];
        Real x1_ref[2] = {-2, 3};
        Real b1[2] = A1 * x1_ref;
        Real x1[2];
        Real B2[2,3] = [b1, 2 * b1, -3 * b1];
        Real X2[2,3];

        // 最小二乘法和最小二乘法2
        Integer rank;
        Real a[3] = {2, 3, -1};
        Real A3[3,3] = transpose([{2, 3, -4}, a, 3 * a]);
        Real x3_ref[3] = {-2, 3, 5};
        Real b3[3] = A3 * x3_ref;
        Real x3[3];
        Real B3[3,2] = [b3, -3 * b3];
        Real X3[3,2];

      algorithm
        print("\n演示如何解线性方程组:\n");

        // 解带右侧向量的正则线性方程
        x1 := Math.Matrices.solve(A1, b1);
        print("diff1 = " + String(Vectors.norm(x1 - x1_ref)));

        // 用右侧矩阵求解正则线性方程
        X2 := Math.Matrices.solve2(A1, B2);
        print("diff2 = " + String(Matrices.norm(X2 - [x1_ref, 2 * x1_ref, -3 * x1_ref])));

        // 求解带有右侧向量的奇异线性方程
        (x3,rank) := Math.Matrices.leastSquares(A3, b3);
        print("diff3 = " + String(Vectors.norm(A3 * x3 - b3)) + ", n = " + String(
          size(A3, 1)) + ", rank = " + String(rank));

        // 用右侧矩阵求解奇异线性方程
        (X3,rank) := Math.Matrices.leastSquares2(A3, B3);
        print("diff4 = " + String(Matrices.norm(A3 * X3 - B3)) + ", n = " + String(
          size(A3, 1)) + ", rank = " + String(rank));

        annotation(Documentation(info = "<html>
<p>
通过这个简单的示例，这个函数演示了如何使用Matrices.solve和Matrices.solve2求解常规线性方程组，
以及如何使用Matrices.leastSquares和Matrices.leastSquares2求解奇异线性方程组。
</p>
</html>"      ));
      end solveLinearEquations;
      annotation();
    end Examples;

    function toString "将矩阵转换为其字符串表示形式"
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Strings;

      input Real M[:,:] "实数矩阵";
      input String name = "" "用于打印的独立变量名";
      input Integer significantDigits = 6 
        "显示的有效位数";
      output String s = "" "矩阵M的字符串表达式";
    protected
      String blanks = Strings.repeat(significantDigits);
      String space = Strings.repeat(8);
      String space2 = Strings.repeat(3);
      Integer r = size(M, 1);
      Integer c = size(M, 2);

    algorithm
      if r == 0 or c == 0 then
        s := name + " = []";
      else
        s := if name == "" then "\n" else "\n" + name + " = \n";
        for i in 1:r loop
          s := s + space;
          for j in 1:c loop
            if M[i,j] >= 0 then
              s := s + " ";
            end if;
            s := s + String(M[i,j], significantDigits = significantDigits) + 
              Strings.repeat(significantDigits + 8 - Strings.length(String(abs(M[
              i,j]))));
          end for;
          s := s + "\n";
        end for;

      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Matrices.<strong>toString</strong>(A);
Matrices.<strong>toString</strong>(A, name=\"\", significantDigits=6);
</pre></blockquote>
<h4>描述</h4>
<p>
函数调用\"<code>Matrices.<strong>toString</strong>(A)</code>\"返回矩阵A</strong>的字符串表示形式。
通过可选参数\"name\"和\"significantDigits\"，定义了名称和有效位数。
name和significantDigits的默认值分别为\" \"和6。如果name==\" \"则前缀\"&lt;name&gt; =\"被省略。
</p>
<h4>示例</h4>
<blockquote><pre>
A = [2.12, -4.34; -2.56, -1.67];

toString(A);
// = \"
//      2.12   -4.34
//     -2.56   -1.67\";

toString(A,\"A\",1);
// = \"A =
//         2     -4
//        -3     -2\"
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.toString\">Vectors.toString</a>
</p>

</html>"            , revisions = "<html>
</html>"            ));
    end toString;

    extends Modelica.Icons.Package;

    function isEqual "比较两个实型矩阵是否相同"
      extends Modelica.Icons.Function;
      input Real M1[:,:] "第一矩阵";
      input Real M2[:,:] "第二矩阵（大小可能与M1不同）";
      input Real eps(min = 0) = 0 
        "如果abs(e1-e2) <= eps，则两个矩阵的两个元素e1和e2相同";
      output Boolean result 
        "= true，如果矩阵具有相同大小和相同元素";

    protected
      Integer nrow = size(M1, 1) "矩阵M1的行数";
      Integer ncol = size(M1, 2) "矩阵M1的列数";
      Integer i = 1;
      Integer j;
    algorithm
      result := false;
      if size(M2, 1) == nrow and size(M2, 2) == ncol then
        result := true;
        while i <= nrow loop
          j := 1;
          while j <= ncol loop
            if abs(M1[i,j] - M2[i,j]) > eps then
              result := false;
              i := nrow;
              j := ncol;
            end if;
            j := j + 1;
          end while;
          i := i + 1;
        end while;
      end if;

      annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >Matrices.isEqual(M1, M2);
Matrices.isEqual(M1, M2, eps=0);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
函数调用\"<code>Matrices。isEqual(M1, M2)</code>\"如果两个实数矩阵M1和M2具有相同的维数和同样的元素，返回<strong>true</strong> 。否则函数返回 <strong>false</strong>。两个矩阵的两个元素e1和e2 通过检查是否\"abs(e1-e2) ≤Eps \"，其中\"eps\" 可以作为函数的第三个参数提供。默认值为\"eps = 0\"。
</p>
<h4>示例</h4><p>
<br>
</p>
<pre><code >Real A1[2,2] = [1,2; 3,4];
Real A2[3,2] = [1,2; 3,4; 5,6];
Real A3[2,2] = [1,2, 3,4.0001];
Boolean result;
algorithm
result := Matrices.isEqual(M1,M2);     // = false
result := Matrices.isEqual(M1,M3);     // = false
result := Matrices.isEqual(M1,M1);     // = true
result := Matrices.isEqual(M1,M3,0.1); // = true
</code></pre><p>
<br>
</p>
<h4>另外<a href=\"modelica://Modelica.Math.Vectors.isEqual\" target=\"\">Vectors.isEqual</a>,<br><a href=\"modelica://Modelica.Utilities.Strings.isEqual\" target=\"\">Strings.isEqual</a></h4><p>
<br>
</p>
</html>"));
    end isEqual;

    function solve 
      "解实数线性方程组A*x=b，其中b是一个向量(使用带部分主元选择的高斯消元法)"

      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)] "A*x = b中的矩阵A";
      input Real b[size(A, 1)] "A*x = b中的向量b";
      output Real x[size(b, 1)] "向量x使得A*x = b";

    protected
      Integer info;
    algorithm
      (x,info) := LAPACK.dgesv_vec(A, b);
      assert(info == 0, "使用函数\"Matrices.solve\"求解线性方程组是不可行的，
  因为该系统要么没有解，要么有无穷多解(A是奇异矩阵)。"        );
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Matrices.<strong>solve</strong>(A,b);
</pre></blockquote>
<h4>描述</h4>
<p>
函数调用返回线性方程组的解<strong>x</strong>
</p>
<blockquote>
<p>
<strong>A</strong>*<strong>x</strong> = <strong>b</strong>
</p>
</blockquote>
<p>
如果唯一解<strong>x</strong>不存在(因为<strong>A</strong>是奇异的)，
触发一个断言。如果不需要，请使用
<a href = \"modelica://Modelica.Math.Matrices.leastSquares\"> Matrices.leastSquares</a>
返回参数rank来查询解的奇异性(如果rank = size(a,1)，则计算唯一解)。
</p>

<p>
注意，解是用LAPACK函数\"dgesv\"计算的，即通过带部分选主元的高斯消元法。
</p>
<h4>示例</h4>
<blockquote><pre>
Real A[3,3] = [1,2,3;
               3,4,5;
               2,1,4];
Real b[3] = {10,22,12};
Real x[3];
<strong>algorithm</strong>
x := Matrices.solve(A,b);  // x = {3,2,1}
</pre></blockquote>
<h4>另外</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
<a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>.
</html>"        ));
    end solve;

    function solve2 
      "解实系数线性方程组A*X = B，使用B矩阵(带部分选主元的高斯消元法)"

      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)] "矩阵A (A*X) = B";
      input Real B[size(A, 1),:] "矩阵B (A*X) = B";
      output Real X[size(B, 1),size(B, 2)] "矩阵X使得A*X = B";

    protected
      Integer info;
    algorithm
      (X,info) := LAPACK.dgesv(A, B);
      assert(info == 0, "求解一个带函数的线性方程组
\"Matrices. solve2\"是不可能的，因为系统都有
无解或无穷多解(A为奇异)."                );
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Matrices.<strong>solve2</strong>(A,b);
</pre></blockquote>
<h4>描述</h4>
<p>
此函数调用返回线性方程组A*X = B的解<strong>X</strong>
</p>
<blockquote>
<p>
<strong>A</strong>*<strong>X</strong> = <strong>B</strong>
</p>
</blockquote>
<p>
如果唯一解<strong>X</strong>不存在(因为<strong>A</strong>是奇异的)，
则会触发断言。如果不希望触发断言，可以改用
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>，
并通过返回参数rank查询解的奇异性(当rank = size(A,1)时，计算得到唯一解)。
</p>
<p>
注意，解是用LAPACK函数\"dgesv\"计算的，即通过带部分选主元的高斯消元法。
</p>
<h4>示例</h4>
<blockquote><pre>
Real A[3,3] = [1,2,3;
             3,4,5;
             2,1,4];
Real B[3,2] = [10, 20;
             22, 44;
             12, 24];
Real X[3,2];
<strong>algorithm</strong>
X := Matrices.solve2(A, B);  /* X = [3, 6;
                                   2, 4;
                                   1, 2] */
</pre></blockquote>

<h4>另外</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.LU_solve2\">Matrices.LU_solve2</a>,
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>.
</p>
</html>"                ));
    end solve2;

    function leastSquares 
      "解线性方程A * x = b(如果可能则精确求解，否则采用最小二乘法求解；A可能是非方阵且可能是秩亏的)"
      extends Modelica.Icons.Function;
      input Real A[:,:] "Matrix A";
      input Real b[size(A, 1)] "Vector b";
      input Real rcond = 100 * Modelica.Constants.eps 
        "估计A的秩的倒数条件数";
      output Real x[size(A, 2)] 
        "向量x使得min|A*x-b|^2如果size(A,1) >= size(A,2)或min|x|^2 and A*x=b，如果size(A,1) < size(A,2)";
      output Integer rank "A的秩";
    protected
      Integer info;
      Real xx[max(size(A, 1), size(A, 2))];
    algorithm
      if min(size(A)) > 0 then
        (xx,info,rank) := LAPACK.dgelsy_vec(
          A, 
          b, 
          rcond);
        x := xx[1:size(A, 2)];
        assert(info == 0, 
          "Solving an overdetermined or underdetermined linear system\n" + 
          "of equations with function \"Matrices.leastSquares\" failed.");
      else
        x := fill(0.0, size(A, 2));
      end if;
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
x = Matrices.<strong>leastSquares</strong>(A,b);
</pre></blockquote>
<h4>描述</h4>
<p>
返回方程A * x = b的最小二乘解(A可能是秩亏的)：
</p>
<blockquote><pre>
minimize | A*x - b |
</pre></blockquote>

<p>
可以区分几种不同的情况(请注意，<strong>rank</strong>是该函数的输出参数)：
</p>

<p>
<strong>size(A,1) = size(A,2)</strong>
</p>

<p>对于常规矩阵和奇异矩阵A都返回解：
</p>

<ul>
<li> <strong>rank</strong> = size(A,1):<br>
 A是<strong>常规矩阵</strong>，返回的解x唯一地满足方程A*x = b。</li>

<li> <strong>rank</strong> &lt; size(A,1):<br>
 A是<strong>奇异矩阵</strong>，方程A*x = b不存在唯一解。
 <ul>
 <li>  如果有无穷多个解，则选择满足方程的解，并且这个解在所有满足方程的解中具有最小的范数|x|。</li>
 <li>  如果没有解，选择使|A * x - b|尽可能小的x(但A * x - b不为零)。</li>
 </ul></li>
</ul>

<p>
<strong>size(A,1) &gt; size(A,2):</strong>
</p>

<p>
方程A * x = b没有唯一解。选择使|A * x - b|尽可能小的解x。如果rank = size(A,2)，则这个最小范数解是唯一的。
如果rank < size(A,2)，则存在无穷多个解，它们导致相同的|A * x - b| 的最小值。在这些无穷多个解中，选择具有最小范数|x|的解。
这会得到一个唯一解，同时最小化|A * x - b|和|x|。
</p>

<p>
<strong>size(A,1) &lt; size(A,2):</strong>
</p>

<ul>
<li> <strong>rank</strong> = size(A,1):<br>
存在无穷多个解可以满足方程A * x = b。从这些解中，选择唯一的解，该解最小化|x|。
 </li>

<li> <strong>rank</strong> &lt; size(A,1):<br>
方程A * x = b要么没有解，要么存在无穷多个解。返回唯一的解x，该解最小化|A * x - b|和|x|。</li>
</ul>

<p>
注意，该解是通过LAPACK函数\"dgelsy\"计算的，即通过对A进行列主元的QR或LQ分解。
</p>

<h4>算法细节</h4>

<p>
函数首先计算带列主元的QR分解：
</p>

<blockquote><pre>
A * P = Q * [ R11 R12 ]
        [  0  R22 ]
</pre></blockquote>

<p>
其中，R11定义为最大的领先子矩阵，其估计条件数小于1/rcond。R11的阶数，<strong>rank</strong>，就是A的有效秩。
</p>

<p>
然后，认为R22可忽略不计，通过右侧的正交变换将R12消除，得到完整的正交分解：
</p>

<blockquote><pre>
A * P = Q * [ T11 0 ] * Z
        [  0  0 ]
</pre></blockquote>

<p>
然后，最小范数解为：
</p>

<blockquote><pre>
x = P * Z' [ inv(T11)*Q1'*b ]
       [        0       ]
</pre></blockquote>

<p>
其中，Q1是Q的前\"rank\"列。
</p>

<h4>另见</h4>

<p>
<a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">Matrices.leastSquares2</a>
(same as leastSquares, but with a right hand side matrix),<br>
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
(for square, regular matrices A)
</p>

</html>"        ));
    end leastSquares;

    function leastSquares2 
      "解线性方程A * X = B(如果可能则精确解，否则以最小二乘法解；A可能是非方阵并且可能是秩亏的)"
      extends Modelica.Icons.Function;
      input Real A[:,:] "矩阵A";
      input Real B[size(A, 1),:] "矩阵B";
      input Real rcond = 100 * Modelica.Constants.eps 
        "估计A秩的倒数条件数";
      output Real X[size(A, 2),size(B, 2)] 
        "矩阵X使得min|A*X-B|^2如果size(A,1) >= size(A,2)，或min|X|^2和A*X=B，如果size(A,1) < size(A,2)";
      output Integer rank "A的秩";
    protected
      Integer info;
      Real XX[max(size(A, 1), size(A, 2)),size(B, 2)];
    algorithm
      (XX,info,rank) := LAPACK.dgelsy(
        A, 
        B, 
        rcond);
      X := XX[1:size(A, 2),:];
      assert(info == 0, "超定或欠定线性方程组的求解
具有函数矩阵的方程\"Matrices. leastSquares2\"失败."                        );
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
X = Matrices.<strong>leastSquares2</strong>(A,B);
</pre></blockquote>
<h4>描述</h4>
<p>
返回方程A * X = B的最小二乘解(A可能是秩亏的)：
</p>
<blockquote><pre>
minimize | A*X - B |
</pre></blockquote>

<p>
可以区分几种不同的情况(请注意，<strong>rank</strong>是该函数的输出参数)：
</p>

<p>
<strong>size(A,1) = size(A,2)</strong>
</p>

<p> 对于常规矩阵和奇异矩阵A都返回解：
</p>

<ul>
<li> <strong>rank</strong> = size(A,1):<br>
A是<strong>常规矩阵</strong>，返回的解X唯一地满足方程A * X = B。
</li>

<li> <strong>rank</strong> &lt; size(A,1):<br>
A是<strong>奇异矩阵</strong>，方程A * X = B没有唯一解。
 <ul>
 <li>如果有无穷多个解，则选择满足方程的解，并且这个解在所有满足方程的解中具有最小的范数|X|。</li>
 <li>如果没有解，选择使|A * X - B|尽可能小的X(但A * X - B不为零)。</li>
 </ul></li>
</ul>

<p>
<strong>size(A,1) &gt; size(A,2):</strong>
</p>

<p>
方程A * X = B没有唯一解。选择使|A * X - B|尽可能小的解X。
如果rank = size(A,2)，则这个最小范数解是唯一的。
如果rank < size(A,2)，则存在无穷多个解，它们导致相同的|A * X - B|的最小值。
在这些无穷多个解中，选择具有最小范数|X|的解。这会得到一个唯一解，同时最小化|A * X - B|和|X|。
</p>

<p>
<strong>size(A,1) &lt; size(A,2):</strong>
</p>

<ul>
<li> <strong>rank</strong> = size(A,1):<br>
存在无穷多个解可以满足方程A * X = B。从这些解中，选择唯一的解，该解最小化|X|。
 </li>

<li> <strong>rank</strong> &lt; size(A,1):<br>
方程A * X = B要么没有解，要么存在无穷多个解。返回唯一的解X，该解最小化|A * X - B|和|X|。</li>
</ul>

<p>
注意，解是通过LAPACK函数\"dgelsy\"计算的，即通过对A进行列主元的QR或LQ分解。
</p>

<h4>算法细节</h4>

<p>
该函数首先计算带列主元的QR分解：
</p>

<blockquote><pre>
A * P = Q * [ R11 R12 ]
        [  0  R22 ]
</pre></blockquote>

<p>
其中，R11被定义为最大的领先子矩阵，其估计条件数小于1/rcond。R11的阶数，<strong>rank</strong>，就是A的有效秩。
</p>

<p>
然后，认为R22可忽略不计，通过右侧的正交变换将R12消除，得到完整的正交分解：
</p>

<blockquote><pre>
A * P = Q * [ T11 0 ] * Z
        [  0  0 ]
</pre></blockquote>

<p>
然后，最小范数解为：
</p>

<blockquote><pre>
X = P * Z' [ inv(T11)*Q1'*B ]
       [        0       ]
</pre></blockquote>

<p>
其中，Q1是Q的前rank列。
</p>

<h4>另外</h4>

<p>
<a href=\"modelica://Modelica.Math.Matrices.leastSquares\">Matrices.leastSquares</a>
(same as leastSquares2, but with a right hand side vector),<br>
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>
(for square, regular matrices A)
</p>

</html>"                        ));
    end leastSquares2;

    function equalityLeastSquares 
      "解线性等式约束最小二乘问题"
      extends Modelica.Icons.Function;
      input Real A[:,:] "最小化|A*x - A |^2";
      input Real a[size(A, 1)];
      input Real B[:,size(A, 2)] "受制于B*x= B";
      input Real b[size(B, 1)];
      output Real x[size(A, 2)] "解向量";

    protected
      Integer info;
    algorithm
      assert(size(A, 2) >= size(B, 1) and size(A, 2) <= size(A, 1) + size(B, 1), 
        "It is required that size(B,1) <= size(A,2) <= size(A,1) + size(B,1)\n" 
        + 
        "This relationship is not fulfilled, since the matrices are declared as:\n" 
        + "  A[" + String(size(A, 1)) + "," + String(size(A, 2)) + "], B[" + 
        String(size(B, 1)) + "," + String(size(B, 2)) + "]\n");

      (x,info) := LAPACK.dgglse_vec(
        A, 
        a, 
        B, 
        b);

      assert(info == 0, "求解线性等式约束下的最小二乘问题
与函数\"Matrices. equalityLeastSquares\"失败."        );
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
x = Matrices.<strong>equalityLeastSquares</strong>(A,a,B,b);
</pre></blockquote>
<h4>描述</h4>
<p>
该函数返回线性等式约束最小二乘问题的解<strong>x</strong>：
</p>
<blockquote>
<p>
min|<strong>A</strong>*<strong>x</strong> - <strong>A</strong> |^2 作用在<strong>x</strong>，使得<strong>B</strong>*<strong>x</strong> = <strong>B</strong>
</p>
</blockquote>

<p>
要求矩阵A和B的维度满足以下关系：
</p>

<blockquote>
size(B,1) &le; size(A,2) &le; size(A,1) + size(B,1)
</blockquote>

<p>
请注意，解是通过LAPACK函数\"dgglse\"计算的，该函数使用广义RQ分解，并假设B是满行秩(= size(B,1))，
且矩阵 [A;B]是满列秩(= size(A,2))。在这种情况下，问题具有唯一解。
</p>
</html>"        ));
    end equalityLeastSquares;

    pure function LU "方形或矩形矩阵的LU分解"
      extends Modelica.Icons.Function;
      input Real A[:,:] "方形或矩形矩阵";
      output Real LU[size(A, 1),size(A, 2)] = A 
        "L,U因子(与LU_solve(..)一起使用)";
      output Integer pivots[min(size(A, 1), size(A, 2))] 
        "枢轴索引(与LU_solve(..)一起使用)";
      output Integer info "信息";
    protected
      Integer m = size(A, 1);
      Integer n = size(A, 2);
      Integer lda = max(1, size(A, 1));
    external "FORTRAN 77" dgetrf(
      m, 
      n, 
      LU, 
      lda, 
      pivots, 
      info) annotation(Library = "lapack");

    annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
(LU, pivots)       = Matrices.<strong>LU</strong>(A);
(LU, pivots, info) = Matrices.<strong>LU</strong>(A);
</pre></blockquote>
<h4>描述</h4>
<p>
此函数调用返回一个\"Real[m,n]\"矩阵A的LU分解，即：
</p>
<blockquote>
<p>
<strong>P</strong>*<strong>L</strong>*<strong>U</strong> = <strong>A</strong>
</p>
</blockquote>
<p>
其中，<strong>P</strong>是一个置换矩阵(由向量pivots隐式定义)，<strong>L</strong>是一个下三角矩阵，具有单位对角元素(当m > n时为下梯形矩阵)，
<strong>U</strong>是一个上三角矩阵(当m < n时为上梯形矩阵)。
矩阵<strong>L</strong>和<strong>U</strong>存储在返回的矩阵<code>LU</code>中(<strong>L</strong>的对角线元素不存储)。
结合函数<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>，
此分解可以用来求解线性系统(<strong>P</strong>*<strong>L</strong>*<strong>U</strong>)*<strong>x</strong> = <strong>b</strong>，其中右侧向量<strong>b</strong>可以不同。
如果只是求解一个右侧向量<strong>b</strong>的线性方程组，更方便的做法是直接使用<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>函数。
</p>
<p>
可选的第三个(整数)输出参数含义如下：</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td>info = 0:</td>
  <td>成功退出</td></tr>
<tr><td>info &gt; 0:</td>
  <td>如果info = i, 则U[i,i]恰好为零。分解已完成，
但因子U恰好是奇异的，若用于求解方程组，将发生除以零的情况。</td></tr>
</table>
<p>
LU分解是通过LAPACK函数\"dgetrf\"计算的，即通过高斯消元法使用部分主元法进行行交换。
向量\"pivots\"是主元索引，即对于1≤i≤min(m,n)，矩阵A的第i行与第pivots[i]行进行了交换。
</p>
<h4>示例</h4>
<blockquote><pre>
Real A[3,3] = [1,2,3;
             3,4,5;
             2,1,4];
Real b1[3] = {10,22,12};
Real b2[3] = { 7,13,10};
Real    LU[3,3];
Integer pivots[3];
Real    x1[3];
Real    x2[3];
<strong>algorithm</strong>
(LU, pivots) := Matrices.LU(A);
x1 := Matrices.LU_solve(LU, pivots, b1);  // x1 = {3,2,1}
x2 := Matrices.LU_solve(LU, pivots, b2);  // x2 = {1,0,2}
</pre></blockquote>
<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>,
</p>
</html>"    ));
    end LU;

    function LU_solve 
      "解带有右侧向量b和LU分解(使用LU(..))的实系数线性方程组P*L*U*x=b"

      extends Modelica.Icons.Function;
      input Real LU[:,size(LU, 1)] 
        "L,U矩阵的因子。lu(…)对于一个方阵";
      input Integer pivots[size(LU, 1)] "矩阵的轴心指数。lu (..)";
      input Real b[size(LU, 1)] "右边向量P*L*U*x=b";
      output Real x[size(b, 1)] "解向量使得P*L*U*x = b";

    algorithm
      for i in 1:size(LU, 1) loop
        assert(LU[i,i] <> 0, "求解一个带函数的线性方程组
矩阵\"Matrices.LU_solve\"是不可能的，因为LU分解
是否奇异，即不存在唯一解."        );
      end for;
      x := LAPACK.dgetrs_vec(
        LU, 
        pivots, 
        b);
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Matrices.<strong>LU_solve</strong>(LU, pivots, b);
</pre></blockquote>
<h4>描述</h4>
<p>
函数调用返回线性方程组的解<strong>x</strong>
</p>
<blockquote>
<p>
<strong>P</strong>*<strong>L</strong>*<strong>U</strong>*<strong>x</strong> = <strong>b</strong>;
</p>
</blockquote>
<p>
其中，<strong>P</strong>是一个置换矩阵(由向量<code>pivots</code>隐式定义)，<strong>L</strong>是一个下三角矩阵，具有单位对角元素(当m > n时为下梯形矩阵)，
<strong>U</strong>是一个上三角矩阵(当m < n时为上梯形矩阵)。
这个分解的矩阵是通过函数<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>计算的，该函数返回<code>LU</code>和<code>pivots</code>作为<code>Matrices.LU_solve</code>的输入参数。
通过<code>Matrices.LU</code>和<code>Matrices.LU_solve</code>，可以高效地求解具有不同右侧向量的线性方程组。
如果只需求解一个带有单一右侧向量的线性方程组，更方便的做法是直接使用<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>函数。
</p>
<p>
如果唯一解<strong>x</strong>不存在(因为LU分解是奇异的)，则会引发异常。
</p>
<p>
LU分解是通过LAPACK函数\"dgetrf\"计算的，即通过高斯消元法使用部分主元法进行行交换。
向量\"pivots\"是主元索引，即对于1≤i≤min(m,n)，矩阵A的第i行与第pivots[i]行进行了交换。
</p>

<h4>示例</h4>
<blockquote><pre>
Real A[3,3] = [1,2,3;
             3,4,5;
             2,1,4];
Real b1[3] = {10,22,12};
Real b2[3] = { 7,13,10};
Real    LU[3,3];
Integer pivots[3];
Real    x1[3];
Real    x2[3];
<strong>algorithm</strong>
(LU, pivots) := Matrices.LU(A);
x1 := Matrices.LU_solve(LU, pivots, b1);  // x1 = {3,2,1}
x2 := Matrices.LU_solve(LU, pivots, b2);  // x2 = {1,0,2}
</pre></blockquote>
<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>,
</html>"        ));
    end LU_solve;

    function LU_solve2 
      "解带有右侧矩阵B和LU分解(使用LU(..))的实系数线性方程组P*L*U*X=B"

      extends Modelica.Icons.Function;
      input Real LU[:,size(LU, 1)] 
        "L,U矩阵的因子。lu(…)对于一个方阵";
      input Integer pivots[size(LU, 1)] "矩阵的轴心指数。lu (..)";
      input Real B[size(LU, 1),:] "右边的矩阵P*L*U*X=B";
      output Real X[size(B, 1),size(B, 2)] 
        "解矩阵使P*L*U*X = B";

    algorithm
      for i in 1:size(LU, 1) loop
        assert(LU[i,i] <> 0, "求解一个带函数的线性方程组
矩阵\"LU_solve2\"是不可能的，因为LU分解
是否奇异，即不存在唯一解."    );
      end for;
      X := Modelica.Math.Matrices.LAPACK.dgetrs(
        LU, 
        pivots, 
        B);
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Matrices.<strong>LU_solve2</strong>(LU, pivots, B);
</pre></blockquote>
<h4>描述</h4>
<p>
此函数调用返回线性方程组的解<strong>X</strong>
</p>
<blockquote>
<p>
<strong>P</strong>*<strong>L</strong>*<strong>U</strong>*<strong>X</strong> = <strong>B</strong>;
</p>
</blockquote>
<p>
其中，<strong>P</strong>是一个置换矩阵(由向量<code>pivots</code>隐式定义)，<strong>L</strong>是一个下三角矩阵，
具有单位对角元素(当m > n时为下梯形矩阵)，<strong>U</strong>是一个上三角矩阵(当m < n时为上梯形矩阵)。
这个分解的矩阵是通过函数<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>计算的，
该函数返回<code>LU</code>和<code>pivots</code>作为<code>Matrices.LU_solve2</code>的输入参数。
通过<code>Matrices.LU</code>和<code>Matrices.LU_solve2</code>，可以高效地求解带有不同右侧矩阵的线性方程组。
如果只需求解一个带有单一右侧矩阵的线性方程组，更方便的做法是直接使用<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>函数。
</p>
<p>
如果不存在唯一解<strong>X</strong>(因为LU分解是奇异的)，则会引发异常。
</p>
<p>
LU分解是通过LAPACK函数\"dgetrf\"计算的，即通过高斯消元法使用部分主元法进行行交换。
向量\"pivots\"是主元索引，即对于1 ≤ i ≤ min(m,n)，矩阵A的第i行与第pivots[i]行进行了交换。
</p>
<h4>示例</h4>
<blockquote><pre>
Real A[3,3] = [1,2,3;
             3,4,5;
             2,1,4];
Real B1[3] = [10, 20;
            22, 44;
            12, 24];
Real B2[3] = [ 7, 14;
            13, 26;
            10, 20];
Real    LU[3,3];
Integer pivots[3];
Real    X1[3,2];
Real    X2[3,2];
<strong>algorithm</strong>
(LU, pivots) := Matrices.LU(A);
X1 := Matrices.LU_solve2(LU, pivots, B1);  /* X1 = [3, 6;
                                                  2, 4;
                                                  1, 2] */
X2 := Matrices.LU_solve2(LU, pivots, B2);  /* X2 = [1, 2;
                                                  0, 0;
                                                  2, 4] */
</pre></blockquote>
<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>,
</html>"    ));
    end LU_solve2;

    function eigenValues 
      "返回实数表示的实数非对称矩阵的特征值和特征向量"

      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)] "矩阵";
      output Real eigenvalues[size(A, 1),2] 
        "矩阵A的特征值(Re:第一列，Im:第二列)";
      output Real eigenvectors[size(A, 1),size(A, 2)] 
        "实值特征向量矩阵";

    protected
      Integer info;
      Boolean onlyEigenvalues = false;
    algorithm
      if size(A, 1) > 0 then
        if onlyEigenvalues then
          (eigenvalues[:,1],eigenvalues[:,2],info) := LAPACK.dgeev_eigenValues(A);
          eigenvectors := zeros(size(A, 1), size(A, 1));
        else
          (eigenvalues[:,1],eigenvalues[:,2],eigenvectors,info) := LAPACK.dgeev(A);
        end if;
        assert(info == 0, "用函数计算特征值
矩阵\"Matrices. eigenvalues\"。特征值是不可能的，因为
数值算法不收敛."    );
      end if;
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
            eigenvalues = Matrices.<strong>eigenValues</strong>(A);
(eigenvalues, eigenvectors) = Matrices.<strong>eigenValues</strong>(A);
</pre></blockquote>
<h4>描述</h4>
<p>
此函数调用返回方阵<strong>A</strong>的特征值，并可选地返回其(右)特征向量。
返回的\"eigenvalues\"矩阵的第一列包含特征值的实部，第二列包含特征值的虚部。
如果第i个特征值没有虚部，则eigenvectors[:,i]是对应的实特征向量。
如果第i个特征值有虚部，则eigenvalues[i+1,:]是共轭复特征值，
eigenvectors[:,i]是实特征向量，eigenvectors[:,i+1]是该特征值对应的特征向量的虚部。
通过函数<a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>，
可以根据特征值构造一个实数块对角矩阵，使得：
</p>
<blockquote><pre>
A = eigenvectors * eigenValueMatrix(eigenvalues) * inv(eigenvectors)
</pre></blockquote>
<p>
前提是特征向量矩阵\"eigenvectors\"可以求逆(当所有特征值不同时，逆矩阵总是存在；
在某些情况下，当部分特征值相同时，也可以求逆)。
</p>
<h4>示例</h4>
<blockquote><pre>
Real A[3,3] = [1,2,3;
             3,4,5;
             2,1,4];
Real eval[3,2];
<strong>algorithm</strong>
eval := Matrices.eigenValues(A);  // eval = [-0.618, 0;
                                //          8.0  , 0;
                                //          1.618, 0];
</pre></blockquote>
<p>
即，矩阵A有3个实特征值-0.618、8、1.618。
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">Matrices.eigenValueMatrix</a>,
<a href=\"modelica://Modelica.Math.Matrices.singularValues\">Matrices.singularValues</a>
</p></html>"    ));
    end eigenValues;

    function eigenValueMatrix 
      "返回矩阵A的特征值的实值块对角矩阵J(A=V*J*Vinv)"

      extends Modelica.Icons.Function;
      input Real eigenValues[:,2] 
        "特征值从函数特征值(..)(Re:第一列，Im:第二列)";
      output Real J[size(eigenValues, 1),size(eigenValues, 1)] 
        "具有特征值的实值块对角矩阵(Re: 1x1块，Im: 2x2块)";

    protected
      Integer n = size(eigenValues, 1);
      Integer i;
    algorithm
      J := zeros(n, n);
      i := 1;
      while i <= n loop
        if eigenValues[i,2] == 0 then
          J[i,i] := eigenValues[i,1];
          i := i + 1;
        else
          J[i,i] := eigenValues[i,1];
          J[i,i + 1] := eigenValues[i,2];
          J[i + 1,i] := eigenValues[i + 1,2];
          J[i + 1,i + 1] := eigenValues[i + 1,1];
          i := i + 2;
        end if;
      end while;
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Matrices.<strong>eigenValueMatrix</strong>(eigenvalues);
</pre></blockquote>
<h4>描述</h4>
<p>
此函数调用返回一个块对角矩阵<strong>J</strong>，该矩阵由两列矩阵<code>eigenvalues</code>构造
(该矩阵由函数<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>)计算得到)。
矩阵<code>eigenvalues</code>必须将特征值的实部放在第一列，将虚部放在第二列。如果特征值i的虚部为零，
则<strong>J</strong>[i,i] = eigenvalues[i,1]，即<strong>J</strong>的对角元素是实特征值。
如果特征值i具有虚部，则特征值i和共轭复特征值i+1会一起用于构造<strong>J</strong>的一个2×2对角块：
</p>
<blockquote><pre>
J[i  , i]   := eigenvalues[i,1];
J[i  , i+1] := eigenvalues[i,2];
J[i+1, i]   := eigenvalues[i+1,2];
J[i+1, i+1] := eigenvalues[i+1,1];
</pre></blockquote>
<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>
</html>"        ));
    end eigenValueMatrix;

    function singularValues 
      "返回奇异值和左、右奇异向量"
      extends Modelica.Icons.Function;
      input Real A[:,:] "矩阵";
      output Real sigma[min(size(A, 1), size(A, 2))] "奇异值";
      output Real U[size(A, 1),size(A, 1)] = identity(size(A, 1)) 
        "左正交矩阵";
      output Real VT[size(A, 2),size(A, 2)] = identity(size(A, 2)) 
        "转置的右正交矩阵";

    protected
      Integer info;
      Integer n = min(size(A, 1), size(A, 2)) "奇异值数";
    algorithm
      if n > 0 then
        (sigma,U,VT,info) := Modelica.Math.Matrices.LAPACK.dgesvd(A);
        assert(info == 0, "用数值算法来计算
奇异值分解不收敛"            );
      end if;
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
     sigma = Matrices.<strong>singularValues</strong>(A);
(sigma, U, VT) = Matrices.<strong>singularValues</strong>(A);
</pre></blockquote>
<h4>描述</h4>
<p>
此函数计算矩阵A的奇异值，并可选地计算其奇异向量。基本上，函数计算的是矩阵A的奇异值分解(SVD)，即：
</p>
<blockquote><pre>
<strong>A</strong> = <strong>U</strong> <strong>&Sigma;</strong> <strong>V</strong><sup>T</sup>
= U*Sigma*VT
</pre></blockquote>
<p>
其中<strong>U</strong>和<strong>V</strong>是正交矩阵(<strong>UU</strong><sup>T</sup>=<strong>I，
</strong><strong>VV</strong><sup>T</sup>=<strong>I</strong>)。
矩阵 为一个对角矩阵，形式为：
如果n = size(A,1) ≤ m = size(A,2)，则<strong>Σ</strong> = [diagonal(σ<sub>i</sub>), zeros(n,m-n)]；
如果n > m =   size(A,2)，则[diagonal(σ<sub>i</sub>);  zeros(n-m,m)]。
矩阵<strong>&Sigma;</strong>与矩阵A具有相同的大小，且其对角元素为非负的奇异值，
按降序排列，其他元素为零(其中&sigma;<sub>1</sub>是最大的奇异值)。
该函数返回奇异值&sigma;<sub>i</sub>的向量<code>sigma</code>，
并返回正交矩阵<code>U</code>和<code>VT</code>。
</p>
<h4>示例</h4>
<blockquote><pre>
A = [1, 2,  3,  4;
 3, 4,  5, -2;
-1, 2, -3,  5];
(sigma, U, VT) = singularValues(A);
results in:
sigma = {8.33, 6.94, 2.31};
i.e.
Sigma = [8.33,    0,    0, 0;
           0, 6.94,    0, 0;
           0,    0, 2.31, 0]
</pre></blockquote>
<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\">Matrices.eigenValues</a>
</html>"            ));
    end singularValues;

    function QR 
      "返回带有可选列主元素的方阵的QR分解(A(:,p) = Q*R)"

      extends Modelica.Icons.Function;
      input Real A[:,:] "大小为(A,1) >=大小为(A,2)的矩形矩阵";
      input Boolean pivoting = true 
        "= true，如果执行列透视。True为默认值";
      output Real Q[size(A, 1),size(A, 2)] 
        "具有使Q*R=A的正交列的矩形矩阵[:，p]";
      output Real R[size(A, 2),size(A, 2)] "平方上三角矩阵";
      output Integer p[size(A, 2)] "列排列向量";

    protected
      Integer nrow = size(A, 1);
      Integer ncol = size(A, 2);
      Real tau[size(A, 2)];
    algorithm
      assert(nrow >= ncol, "\nInput matrix A[" + String(nrow) + "," + String(ncol) 
        + "] has more columns than rows.
This is not allowed when calling Modelica.Math.Matrices.QR(A)."            );
      if pivoting then
        (Q,tau,p) := LAPACK.dgeqp3(A);
      else
        (Q,tau) := LAPACK.dgeqrf(A);
        p := 1:ncol;
      end if;

      // 确定R
      R := zeros(ncol, ncol);
      for i in 1:ncol loop
        for j in i:ncol loop
          R[i,j] := Q[i,j];
        end for;
      end for;

      Q := LAPACK.dorgqr(Q, tau);
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
(Q,R,p) = Matrices.<strong>QR</strong>(A);
</pre></blockquote>
<h4>描述</h4>
<p>
此函数返回矩阵A的QR分解(矩阵A的列数必须小于或等于行数)：
</p>
<blockquote>
<p>
<strong>Q</strong>*<strong>R</strong> = <strong>A</strong>[:,<strong>p</strong>]
</p>
</blockquote>
<p>
其中，<strong>Q</strong>是一个矩形矩阵，具有正交归一化的列，
并且与矩阵A具有相同的大小(<strong>Q</strong><sup>T</sup><strong>Q</strong>=<strong>I</strong>)；
<strong>R</strong>是一个方阵，且为上三角矩阵；<strong>p</strong>是一个置换向量。矩阵<strong>R</strong>具有以下重要特性：
</p>
<ul>
<li> <strong>R</strong>的对角线元素的绝对值是该行中的最大值，即：
abs(R[i,i]) &ge; abs(R[i,j]).</li>
<li> <strong>R</strong>的对角线元素按大小排序，其中最大绝对值是abs(R[1,1])，
并且abs(R[i,i]) &ge; abs(R[j,j])，其中i &lt; j。</li>
</ul>
<p>
这意味着如果abs(R[i,i]) &le; &epsilon;，则对于j &ge; i，有abs(R[j,k]) &le; &epsilon;，
即矩阵<strong>R</strong>的第i行到最后一行的元素非常小，可以视为零。
这样可以估计<strong>R</strong>的行秩(它与<strong>A</strong>的行秩相同)。
此外，矩阵<strong>R</strong>可以被分成两部分：
</p>
<blockquote><pre>
<strong>A</strong>[:,<strong>p</strong>] = <strong>Q</strong> * [<strong>R</strong><sub>1</sub>, <strong>R</strong><sub>2</sub>;
          <strong>0</strong>,  <strong>0</strong>]
</pre></blockquote>
<p>
其中<strong>R</strong><sub>1</sub>是一个常规的上三角矩阵。
</p>
<p>
注意，解是通过使用LAPACK函数\"dgeqp3\"和\"dorgqr\"计算的，即通过带列主元素的Householder变换。
如果不需要<strong>Q</strong>，则可以仅调用：<code>(,R,p) = QR(A)</code>。
</p>
<h4>示例</h4>
<blockquote><pre>
Real A[3,3] = [1,2,3;
             3,4,5;
             2,1,4];
Real R[3,3];
<strong>algorithm</strong>
(,R) := Matrices.QR(A);  // R = [-7.07.., -4.24.., -3.67..;
                                0     , -1.73.., -0.23..;
                                0     ,  0     ,  0.65..];
</pre></blockquote>
</html>"            ));
    end QR;

    function hessenberg "返回矩阵的上Hessenberg形式"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices;

      input Real A[:,size(A, 1)] "方阵A";

      output Real H[size(A, 1),size(A, 2)] "A的海森伯格形式";
      output Real U[size(A, 1),size(A, 2)] "变换矩阵";

    protected
      Real V[size(A, 1),size(A, 2)] 
        "V = [v1、v2 . .vn-1,0]和vi是定义初等反射镜的向量";
      Real tau[max(0, size(A, 1) - 1)] 
        "初等反射器的标量因子";

    algorithm
      (H,V,tau) := Matrices.Utilities.toUpperHessenberg(
        A, 
        1, 
        size(A, 1));
      U := Matrices.LAPACK.dorghr(
        V, 
        1, 
        size(A, 1), 
        tau);
      annotation(Documentation(info = "<html>

<h4>语法</h4>
<blockquote><pre>
 H = Matrices.<strong>hessenberg</strong>(A);
(H, U) = Matrices.<strong>hessenberg</strong>(A);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>hessenberg</strong>计算矩阵<strong>A</strong>的Hessenberg矩阵<strong>H</strong>，
以及满足<strong>H</strong> = <strong>U</strong> A</strong>*<strong>U</strong>的正交变换矩阵<strong>U</strong>。
矩阵的Hessenberg形式是通过反复应用Householder相似变换来计算的。
基本反射器和相应的标量因子由函数\"Utilities.toUpperHessenberg()\"提供。
然后，通过<a href=\"modelica://Modelica.Math.Matrices.LAPACK.dorghr\">LAPACK.dorghr</a>函数计算变换矩阵<strong>U</strong>。
</p>

<h4>示例</h4>
<blockquote><pre>
A  = [1, 2,  3;
  6, 5,  4;
  1, 0,  0];

(H, U) = hessenberg(A);

results in:

H = [1.0,  -2.466,  2.630;
-6.083, 5.514, -3.081;
 0.0,   0.919, -0.514]

U = [1.0,    0.0,      0.0;
 0.0,   -0.9864,  -0.1644;
 0.0,   -0.1644,   0.9864]

and therefore,

U*H*transpose(U) = [1.0, 2.0, 3.0;
                6.0, 5.0, 4.0;
                1.0, 0.0, 0.0]

</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.toUpperHessenberg\">Matrices.Utilities.toUpperHessenberg</a>
</p>

</html>"    , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
   by Marcus Baur, DLR-RM</li>
</ul>
</html>"    ));
    end hessenberg;

    function realSchur 
      "返回方阵A的实Schur形式(rsf)S，其中A =QZ*S*QZ'"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices;

      input Real A[:,size(A, 1)] "方阵";

    public
      output Real S[size(A, 1),size(A, 2)] "A的实舒尔形式";
      output Real QZ[size(A, 1),size(A, 2)] "舒尔向量矩阵";
      output Real alphaReal[size(A, 1)] 
        "eigenvalue=alphaReal+i*alphaImag的实部";
      output Real alphaImag[size(A, 1)] 
        "eigenvalue=alphaReal+i*alphaImag的虚部";

    protected
      Integer info;

    algorithm
      if size(A, 1) > 1 then
        (S,QZ,alphaReal,alphaImag,info) := Matrices.LAPACK.dgees(A);
        assert(info == 0, "The output info of LAPACK.dgees should be zero, else if\n
 info < 0:  if info = -i, the i-th argument of dgees had an illegal value\n
 info > 0:  if INFO = i, and i is
           <= N: the QR algorithm failed to compute all the
                 eigenvalues; elements 1:ILO-1 and i+1:N of WR and WI
                 contain those eigenvalues which have converged; if
                 JOBVS = 'V', VS contains the matrix which reduces A
                 to its partially converged Schur form.\n"                );
      else
        S := A;
        QZ := fill(1, size(A, 1), size(A, 2));
        alphaReal := fill(1, size(A, 1));
        alphaImag := fill(0, size(A, 1));
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>

<blockquote><pre>
                        S = Matrices.<strong>realSchur</strong>(A);
(S, QZ, alphaReal, alphaImag) = Matrices.<strong>realSchur</strong>(A);
</pre></blockquote>

<h4>描述</h4>

<p>
函数<strong>realSchur</strong>计算实方阵<strong>A</strong>的实Schur形式，即
</p>

<blockquote><pre>
<strong>A</strong> = <strong>QZ</strong>*<strong>S</strong>*transpose(<strong>QZ</strong>)
</pre></blockquote>

<p>
其中，<strong>S</strong>和<strong>QZ</strong>是实n × n矩阵。
<strong>S</strong>是一个块上三角矩阵，主对角线上包含1 × 1和2 × 2的块。
<strong>QZ</strong>是一个正交矩阵。
1 × 1块包含A的实特征值。
2 × 2块形式为[s11,s12;s21,s11]，表示特征值的共轭复数对，其中特征值的实部是对角线元素s11，
而虚部则是s12和s21两个元素的乘积的正负平方根(imag = +-sqrt(s12*s21))。
</p>

<p>
lapack.dgees计算是逐步执行的，即使用dgees的内部平衡和缩放方法。
</p>

<h4>示例</h4>
<blockquote><pre>
Real A[3,3] = [1, 2, 3; 4, 5, 6; 7, 8, 9];
Real T[3,3];
Real Z[3,3];
Real alphaReal[3];
Real alphaImag[3];

<strong>algorithm</strong>
(T, Z, alphaReal, alphaImag):=Modelica.Math.Matrices.realSchur(A);
//   T = [16.12, 4.9,   1.59E-015;
//        0,    -1.12, -1.12E-015;
//        0,     0,    -1.30E-015]
//   Z = [-0.23,  -0.88,   0.41;
//        -0.52,  -0.24,  -0.82;
//        -0.82,   0.4,    0.41]
//alphaReal = {16.12, -1.12, -1.32E-015}
//alphaImag = {0, 0, 0}
</pre></blockquote>

<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.reorderRSF\">Math.Matrices.Utilities.reorderRSF</a>

</html>"                , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
   by Marcus Baur, DLR-RM</li>
</ul>
</html>"                ));
    end realSchur;

    function cholesky 
      "返回对称正定矩阵的Cholesky分解"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices.LAPACK;
      input Real A[:,size(A, 1)] "对称正定矩阵";
      input Boolean upper = true 
        "= true，如果应该返回右Cholesky因子(上三角形)";

      output Real H[size(A, 1),size(A, 2)] 
        "当A = U'*U或A = L*L'时，choolesky因子U (upper=true)或L (upper=false)";

    protected
      Integer n = size(A, 1);
      Integer info;

    algorithm
      if size(A, 1) > 0 then
        (H,info) := LAPACK.dpotrf(A, upper);
      else
        H := fill(
          0, 
          0, 
          0);
        info := 0;
      end if;
      if info < 0 then
        assert(info == 0, 
          "Cholesky factorization failed in function \"Matrices.cholesky\" due to illegal value of input " 
          + String(info) + " for LAPACK routine DPOTRF");
      else
        assert(info == 0, 
          "Cholesky factorization failed in function \"Matrices.cholesky\" since matrix A is not positive definite");
      end if;

      if upper then
        for i in 2:n loop
          for j in 1:i - 1 loop
            H[i,j] := 0.0;
          end for;
        end for;
      else
        for i in 1:n - 1 loop
          for j in i + 1:n loop
            H[i,j] := 0.0;
          end for;
        end for;
      end if;
      annotation(Documentation(info = "<html>
<h4>语法</h4>

<blockquote><pre>
H = Matrices.<strong>cholesky</strong>(A);
H = Matrices.<strong>cholesky</strong>(A, upper=true);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>cholesky</strong>计算实对称正定矩阵a的cholesky分解。
可选的布尔输入\"upper\"指定是返回上三角矩阵还是下三角矩阵。
</p>

<blockquote><pre>
A = H'*H   if upper is true (H is upper triangular)
A = H*H'   if upper is false (H is lower triangular)
</pre></blockquote>

<p>
计算是通过<a href=\"modelica://Modelica.Math.Matrices.LAPACK.dpotrf\">LAPACK.dpotrf</a>函数执行的。
</p>

<h4>示例</h4>

<blockquote><pre>
A  = [1, 0,  0;
    6, 5,  0;
    1, -2,  2];
S = A*transpose(A);

H = Matrices.cholesky(S);

results in:

H = [1.0,  6.0,  1.0;
   0.0,  5.0, -2.0;
   0.0,  0.0,  2.0]

with

transpose(H)*H = [1.0,  6.0,   1;
                6.0, 61.0,  -4.0;
                1.0, -4.0,   9.0] //=S

</pre></blockquote>

</html>"            , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>

</html>"            ));
    end cholesky;

    function balance 
      "返回矩阵A的平衡形式以改善A的状态"
      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)];
      output Real D[size(A, 1)] "对角线(D)=T是变换矩阵，使得
B = inv(T)*A*T的条件小于A"                ;
      output Real B[size(A, 1),size(A, 1)] 
        "Balanced matrix (= inv(diagonal(D))*A*diagonal(D) )";
    protected
      Integer na = size(A, 1);
      Integer radix = 2 "指数表示法的基数必须是'基数'
或者是radix的倍数"                ;
      Integer radix2 = radix * radix;
      Boolean noconv = true;
      Integer i = 1;
      Integer j = 1;
      Real CO;
      Real RO;
      Real G;
      Real F;
      Real S;
    /*辅助变量*/

    algorithm
      // B = inv(D)*A*D，使得cond(B)<=cond(A)
      D := ones(na);
      B := A;
      while noconv loop
        noconv := false;
        for i in 1:na loop
          CO := sum(abs(B[:,i])) - abs(B[i,i]);
          RO := sum(abs(B[i,:])) - abs(B[i,i]);
          G := RO / radix;
          F := 1;
          S := CO + RO;
          while not (CO >= G or CO == 0) loop
            F := F * radix;
            CO := CO * radix2;
          end while;
          G := RO * radix;
          while not (CO < G or RO == 0) loop
            F := F / radix;
            CO := CO / radix2;
          end while;
          if not ((CO + RO) / F >= 0.95 * S) then
            G := 1 / F;
            D[i] := D[i] * F;
            B[i,:] := B[i,:] * G;
            B[:,i] := B[:,i] * F;
            noconv := true;
          end if;
        end for;
      end while;
      annotation(Documentation(info = "<html>

<h4>语法</h4>
<blockquote><pre>
(D,B) = Matrices.<strong>balance</strong>(A);
</pre></blockquote>

<h4>描述</h4>

<p>
此函数返回一个向量D，使得矩阵B = inv(diagonal(D))×A×diagonal(D)的条件数优于矩阵A，即 
conditionNumber(B) ≤ conditionNumber(A)。
向量D的元素是2的倍数，这意味着该函数不会引入舍入误差。
平衡化的目的是使得矩阵B的每一行的范数等于相应列的范数。
</p>

<p>
平衡化用于最小化通过大规模矩阵计算(如泰勒级数近似或特征值计算)引起的舍入误差。
</p>

<h4>示例</h4>

<blockquote><pre>
- A = [1, 10,  1000; 0.01,  0,  10; 0.005,  0.01,  10]
- Matrices.norm(A, 1);
= 1020.0
- (T,B)=Matrices.balance(A)
- T
= {256, 16, 0.5}
- B
=  [1,     0.625,   1.953125;
    0.16,  0,       0.3125;
    2.56,  0.32,   10.0]
- Matrices.norm(B, 1);
= 12.265625
</pre></blockquote>

<p>
算法取自
</p>
<dl>
<dt>H. D. Joos, G. Gr&uuml;bel:</dt>
<dd><strong>RASP'91 Regulator Analysis and Synthesis Programs</strong><br>
  DLR - Control Systems Group 1991</dd>
</dl>
<p>
which based on the <code>balance</code> function from EISPACK.
</p>

</html>"                , revisions = "<html>
<h4>Release Notes</h4>
<ul>
<li><em>July 5, 2002</em>
     by H. D. Joos and Nico Walther<br>
     Implemented.
</li>
</ul>
</html>"                ));
    end balance;

    function balanceABC 
      "返回系统[A,B;C,0]的平衡形式，通过状态变换改善其条件数"
      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)] "系统矩阵A";
      input Real B[size(A, 1),:] = fill(0.0, size(A, 1), 0) 
        "系统矩阵B(不需要存在)";
      input Real C[:,size(A, 1)] = fill(0.0, 0, size(A, 1)) 
        "系统矩阵C(不需要存在)";
      output Real scale[size(A, 1)] 
        "对角线(尺度)=T使得[inv(T)*A*T, inv(T)*B;C*T, 0]的条件小于[A,B;C,0]";
      output Real As[size(A, 1),size(A, 1)] "平衡矩阵 A (= inv(T)*A*T )";
      output Real Bs[size(A, 1),size(B, 2)] "平衡矩阵 B (= inv(T)*B )";
      output Real Cs[size(C, 1),size(A, 1)] "平衡矩阵 C (= C*T )";

    protected
      Integer na = size(A, 1);
      Integer radix = 2 "指数表示法的基数必须是'基数'
或者是radix的倍数"            ;
      Integer radix2 = radix * radix;
      Boolean noconv = true;
      Integer i = 1;
      Integer j = 1;
      Real CO;
      Real RO;
      Real G;
      Real F;
      Real S;
    algorithm
      scale := ones(na);
      As := A;
      Bs := B;
      Cs := C;
      while noconv loop
        noconv := false;
        for i in 1:na loop
          CO := sum(abs(As[:,i])) - abs(As[i,i]) + sum(abs(Cs[:,i]));
          RO := sum(abs(As[i,:])) - abs(As[i,i]) + sum(abs(Bs[i,:]));
          G := RO / radix;
          F := 1;
          S := CO + RO;
          while not (CO >= G or CO == 0) loop
            F := F * radix;
            CO := CO * radix2;
          end while;
          G := RO * radix;
          while not (CO < G or RO == 0) loop
            F := F / radix;
            CO := CO / radix2;
          end while;
          if not ((CO + RO) / F >= 0.95 * S) then
            G := 1 / F;
            scale[i] := scale[i] * F;
            As[i,:] := As[i,:] * G;
            As[:,i] := As[:,i] * F;
            Bs[i,:] := Bs[i,:] * G;
            Cs[:,i] := Cs[:,i] * F;
            noconv := true;
          end if;
        end for;
      end while;
      annotation(Documentation(info = "<html>

<h4>语法</h4>
<blockquote><pre>
(scale,As,Bs,Cs) = Matrices.<strong>balanceABC</strong>(A,B,C);
(scale,As,Bs)    = Matrices.<strong>balanceABC</strong>(A,B);
(scale,As,,Cs)   = Matrices.<strong>balanceABC</strong>(A,C=C);
</pre></blockquote>

<h4>描述</h4>

<p>
此函数返回一个向量scale，使得通过状态变换T=diagonal(scale)，系统矩阵S_scale
</p>

<blockquote><pre>
      |inv(T)*A*T, inv(T)*B|
S_scale = |                    |
      |       C*T,     0   |
</pre></blockquote>

<p>
有更好的条件作为系统矩阵S
</p>

<blockquote><pre>
|A, B|
S = |    |
|C, 0|
</pre></blockquote>
<p>
即，conditionNumber(S_scale) &le;conditionNumber(S)。
向量scale的元素是2的倍数，这意味着该函数不会引入舍入误差。
</p>

<p>
在状态空间形式下平衡线性动态系统
</p>

<blockquote><pre>
der(x) = A*x + B*u
y  = C*x + D*u
</pre></blockquote>

<p>
意味着找到一个状态变换x_new = T*x = diagonal(scale)*x，使得变换后的系统更适合数值算法。
</p>

<h4>示例</h4>

<blockquote><pre>
import Modelica.Math.Matrices;

A = [1, -10,  1000; 0.01,  0,  10; 0.005,  -0.01,  10];
B = [100, 10; 1,0; -0.003, 1];
C = [-0.5, 1, 100];

(scale, As, Bs, Cs) := Matrices.balanceABC(A,B,C);
T    = diagonal(scale);
Diff = [Matrices.inv(T)*A*T, Matrices.inv(T)*B;
    C*T, zeros(1,2)] - [As, Bs; Cs, zeros(1,2)];
err  = Matrices.norm(Diff);

-> Results in:
scale = {16, 1, 0.0625}
norm(A)  = 1000.15, norm(B)  = 100.504, norm(C)  = 100.006
norm(As) = 10.8738, norm(Bs) = 16.0136, norm(Cs) = 10.2011
err = 0
</pre></blockquote>

<p>
算法取自
</p>
<dl>
<dt>H. D. Joos, G. Gr&uuml;bel:</dt>
<dd><strong>RASP'91 Regulator Analysis and Synthesis Programs</strong><br>
DLR - Control Systems Group 1991</dd>
</dl>
<p>
which is based on the <code>balance</code> function from EISPACK.
</p>
</html>"            , revisions = "<html>
<ul>
<li><em>Sept. 14, 2014</em>
   by Martin Otter: Implemented.
</li>
</ul>
</html>"            ));
    end balanceABC;

    function trace 
      "返回矩阵A的迹，即对角线元素的和"
      extends Modelica.Icons.Function;

      input Real A[:,size(A, 1)] "方阵A";
      output Real result "A 的轨迹";
    algorithm
      result := sum(A[i,i] for i in 1:size(A, 1));
      annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
r = Matrices.<strong>trace</strong>(A);
</pre></blockquote>

<h4>描述</h4>
<p>
此函数计算迹，即矩阵<strong>A</strong>对角线上元素的总和。
</p>

<h4>示例</h4>
<blockquote><pre>
A = [1, 3;
   2, 1];
r = trace(A);

results in:

r = 2.0
</pre></blockquote>

</html>"                , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"                ));
    end trace;

    function det 
      "返回矩阵的行列式(通过LU分解计算；尽量避免使用det(..))"

      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)];
      output Real result "矩阵A的行列式";
    protected
      Real LU[size(A, 1),size(A, 1)];
      Integer pivots[size(A, 1)];

    algorithm
      (LU,pivots) := Matrices.LU(A);
      result := product(LU[i,i] for i in 1:size(A, 1)) * product(if pivots[i] == i 
        then 1 else -1 for i in 1:size(pivots, 1));
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
result = Matrices.<strong>det</strong>(A);
</pre></blockquote>

<h4>说明</h4>
<p>
此函数返回通过带行主元素交换的LU分解计算得到的矩阵 A 的行列式\"结果\"。
有关行列式的详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Determinant\">http://en.wikipedia.org/wiki/Determinant</a>.。
通常，应该避免使用此函数，因为通常有更好的数值算法来代替直接计算行列式。例如：
</p>

<ul>
<li> 使用<a href=\"modelica://Modelica.Math.Matrices.rank\">Matrices.rank</a>
来判断det(A) = 0(即：Matrices.rank(A) <  size(A,1))。</li>

<li> 使用<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
来解线性方程A*x = b，而不是用行列式来求解。</li>
</ul>

<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Matrices.rank\">Matrices.rank</a>,
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
</html>"            ));
    end det;

    function inv "返回矩阵的逆(尽量避免使用inv(..))"
      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)];
      output Real invA[size(A, 1),size(A, 2)] "矩阵A的逆";
    protected
      Integer info;
      Integer pivots[size(A, 1)] "主向量";
      Real LU[size(A, 1),size(A, 2)] "A的LU因子";
    algorithm
      (LU,pivots,info) := LAPACK.dgetrf(A);

      assert(info == 0, "用函数计算逆矩阵
\"Matrices.inv\"。是不可能的，因为矩阵A是奇异的."            );

      invA := LAPACK.dgetri(LU, pivots);

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
invA = Matrices.<strong>inv</strong>(A);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数返回矩阵A的逆，即A*inv(A) = identity(size(A,1))
由具有行旋转的LU分解计算。
通常，不应该使用这个函数，因为
几乎总是有更好的数值算法
就像直接计算逆函数一样。例子:
</p>

<blockquote>
使用x = <a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>(a,b)
来解线性方程A*x = b，而不是用
x = inv(A)*b，因为这样更有效更可靠。
</blockquote>

<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Matrices.solve\">Matrices.solve</a>
<a href=\"modelica://Modelica.Math.Matrices.solve2\">Matrices.solve2</a>
</html>"            ));
    end inv;

    function rank 
      "返回矩形矩阵的秩(用奇异值计算)"
      extends Modelica.Icons.Function;
      input Real A[:,:] "矩阵";
      input Real eps = 0 
        "如果eps > 0，则根据eps检查奇异值;否则eps=max(size(A))*norm(A)*Modelica.Constants. eps";
      output Integer result "矩阵A的秩";

    protected
      Integer n = min(size(A, 1), size(A, 2));
      Integer i = n;
      Real sigma[min(size(A, 1), size(A, 2))];
      Real eps2;
    algorithm
      result := 0;
      if n > 0 then
        sigma := Modelica.Math.Matrices.singularValues(A);
        eps2 := if eps > 0 then eps else max(size(A)) * sigma[1] * Modelica.Constants.eps;
        while i > 0 loop
          if sigma[i] > eps2 then
            result := i;
            i := 0;
          end if;
          i := i - 1;
        end while;
      end if;
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
result = Matrices.<strong>rank</strong>(A);
result = Matrices.<strong>rank</strong>(A,eps=0);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数返回由奇异值分解计算的正方形或矩形矩阵a的秩。
有关矩阵秩的详细信息，请参见
<a href=\"http://en.wikipedia.org/wiki/Matrix_rank\">http://en.wikipedia.org/wiki/Matrix_rank</a>。
更准确地说：
</p>

<ul>
<li> rank(A) 返回大于的A的奇异值的个数
   max(size(A))*norm(A)*Modelica.Constants.eps.</li>
<li> rank(A, eps) 返回大于的A的奇异值的个数 \"eps\"。</li>
</ul>

<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Matrices.rcond\">Matrices.rcond</a>.
</html>"            ));
    end rank;

    function conditionNumber 
      "返回矩阵A的条件数norm(A)*norm(inv(A))"
      extends Modelica.Icons.Function;

      input Real A[:,:] "输入矩阵";
      input Real p(min = 1) = 2 
        "p-范数类型(只允许: 1, 2 or Modelica.Constants.inf)";
      output Real result = 0.0 "矩阵A的条件数";

    protected
      Real eps = 1e-25;
      Real eps2 = 10 * Modelica.Constants.eps;
      Real s[size(A, 1)] "奇异值";

    algorithm
      if min(size(A)) > 0 then
        if p >= 2 - eps2 and p <= 2 + eps2 then
          s := Modelica.Math.Matrices.singularValues(A);
          if min(s) < eps then
            result := Modelica.Constants.inf;
          else
            result := max(s) / min(s);
          end if;
        else
          result := Modelica.Math.Matrices.norm(A, p) * Modelica.Math.Matrices.norm(
            Modelica.Math.Matrices.inv(A), p);
        end if;
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
r = Matrices.<strong>conditionNumber</strong>(A);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数计算一般实矩阵<strong>A</strong>的条件数(norm(A) * norm(inv(A)))，在1-范数，2-范数或无穷范数中。
在2范数的情况下，结果是<strong>A</strong>的最大奇异值与最小奇异值之比。
有关详细信息，请参见 <a href=\"http://en.wikipedia.org/wiki/Condition_number\">http://en.wikipedia.org/wiki/Condition_number</a>。
</p>

<h4>示例</h4>
<blockquote><pre>
A = [1, 2;
   2, 1];
r = conditionNumber(A);

results in:

r = 3.0
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.rcond\">Matrices.rcond</a>
</p>

</html>"            , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"            ));
    end conditionNumber;
    function nullSpace "返回矩阵的标准正交零空间"
      extends Modelica.Icons.Function;

      input Real A[:,:] "输入矩阵";
      output Real Z[size(A, 2),size(A, 2)] "矩阵A的标准正交零空间";
      output Integer nullity "零，即零空间的维数";

    protected
      Real V[size(A, 2),size(A, 2)] "右正交矩阵";
      Real sigma[min(size(A, 1), size(A, 2))] "奇异值";
      Integer rank "矩阵A的秩";
      Real eps "等级决定容忍度";
      constant Integer n = min(size(A, 1), size(A, 2));
      Integer i = n;

    algorithm
      (sigma,,V) := Modelica.Math.Matrices.singularValues(A);
      V := transpose(V);
      // 秩计算
      eps := max(size(A, 1), size(A, 2)) * max(sigma) * Modelica.Constants.eps;
      rank := 0;
      if n > 0 then
        while i > 0 loop
          if sigma[i] > eps then
            rank := i;
            i := 0;
          end if;
          i := i - 1;
        end while;
      end if;
      Z := fill(0.0, size(A, 2), size(A, 2));
      if n > 0 then
        for j in 1:(size(A, 2) - rank) loop
          Z[:,j] := V[:,j + rank];
        end for;
      end if;
      //Z := V[:, rank + 1:size(A, 2)];
      // 零空间计算
      nullity := size(A, 2) - rank;
      // 零度

      annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >         Z = Matrices.nullspace(A);
(Z, nullity) = Matrices.nullspace(A);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
这个函数计算一个标准正交基<strong>Z</strong>=[<strong> Z</strong> _1， <strong>Z</strong> _2，…]]矩阵<strong> a </strong>的零空间，即<strong> a </strong>*<strong>z</strong>_i=<strong>0</strong>.
</p>
<p>
用奇异值分解法得到零空间。即矩阵<strong>A</strong>分解为矩阵<strong>S</strong>、<strong>U</strong>、<strong>V</strong>:
</p>
<p>
<br>
</p>
<pre><code >A = U*S*transpose(V)
</code></pre><p>
<br>
</p>
<p>
与标准正交矩阵<strong>U</strong>和<strong>V</strong>和矩阵<strong>S</strong>
</p>
<p>
<br>
</p>
<pre><code >S = [S1, 0]
S1 = [diag(s); 0]
</code></pre><p>
<br>
</p>
<p>
奇异值<strong>s</strong>={s1, s2，…， sr}的<strong>A</strong>和r=rank(<strong>A</strong>)。注意，<strong>S</strong>与<strong>A</strong>具有相同的大小。由于<strong>U</strong>和<strong>V</strong>是正交的，我们可以写
</p>
<p>
<br>
</p>
<pre><code >transpose(U)*A*V = [S1, 0].
</code></pre><p>
<br>
</p>
<p>
矩阵<strong>S</strong>1显然具有满列秩，因此，矩阵<strong>V</strong>的左n-r行(n为<strong>A</strong>或<strong>S</strong>的列数)张成<strong>A</strong>的零空间。
</p>
<p>
矩阵<strong>A</strong>的零度是矩阵<strong>A</strong>的零空间的维数。综上所述，零度得以保持。
</p>
<p>
<br>
</p>
<pre><code >nullity = n - r
</code></pre><p>
<br>
</p>
<p>
和
</p>
<p>
<br>
</p>
<pre><code >n = number of columns of matrix A
r = rank(A)
</code></pre><p>
<br>
</p>
<h4>示例</h4><p>
<br>
</p>
<pre><code >A = [1, 2,  3, 1;
   3, 4,  5, 2;
  -1, 2, -3, 3];
(Z, nullity) = nullspace(A);

results in:

Z=[0.1715;
-0.686;
 0.1715;
 0.686]

nullity = 1
</code></pre><p>
<br>
</p>
<h4>另见</h4><p>
<a href=\"modelica://Modelica.Math.Matrices.singularValues\" target=\"\">Matrices.singularValues</a>
</p>
<p>
<br>
</p>
</html>",revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
    end nullSpace;

    function rcond "返回矩阵的倒数条件数"
      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)] "平方实矩阵";
      input Boolean inf = false 
        "如果使用无穷范数为真，如果使用1范数为假";
      output Real rcond "A的倒数条件数";
      output Integer info "信息";
    protected
      Real LU[size(A, 1),size(A, 1)] 
        "矩阵A的LU分解，由gettrf返回";
      Real anorm "矩阵A范数";
      String normspec = if inf then "I" else "1" "指定norm 1或inf";

    algorithm
      if min(size(A)) > 0 then
        (LU,,info) := Modelica.Math.Matrices.LAPACK.dgetrf(A);
        anorm := Modelica.Math.Matrices.LAPACK.dlange(A, normspec);
        (rcond,info) := Modelica.Math.Matrices.LAPACK.dgecon(
          LU, 
          inf, 
          anorm);
      else
        rcond := Modelica.Constants.inf;
        info := 0;
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
r = Matrices.<strong>rcond</strong>(A);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数估计一般实矩阵<strong>A</strong>的条件数(norm(A) * norm(inv(A)))的倒数，在1-范数或
无限模，使用LAPACK函数<a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgecon\">DGECON</a>。
若rcond(A)接近1.0，则<strong>A</strong>是条件良好的;若rcond(A)接近零，则<strong>A</strong>是条件不良的.
</p>

<h4>示例</h4>
<blockquote><pre>
A = [1, 2;
   2, 1];
r = rcond(A);

results in:

r = 0.3333
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.conditionNumber\">Matrices.conditionNumber</a>
</p>

</html>"        , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"        ));
    end rcond;

    function norm "返回矩阵的p-范数"
      extends Modelica.Icons.Function;
      input Real A[:,:] "输入矩阵";
      input Real p(min = 1) = 2 
        "p-范数类型(只允许: 1, 2 or Modelica.Constants.inf)";
      output Real result = 0.0 "矩阵A的p-norm";
    protected
      Real eps = 10 * Modelica.Constants.eps;
    algorithm
      if min(size(A)) > 0 then
        if p >= 1 - eps and p <= 1 + eps then
          // 列和范数
          for i in 1:size(A, 2) loop
            result := max(result, sum(abs(A[:,i])));
          end for;
        elseif p >= 2 - eps and p <= 2 + eps then
          // 最大奇异值
          result := max(singularValues(A));
        elseif p >= Modelica.Constants.inf then
          // 行和范数
          for i in 1:size(A, 1) loop
            result := max(result, sum(abs(A[i,:])));
          end for;
        else
          assert(false, "Optional argument \"p\" (= " + String(p) + ") of function \"norm\" must be
1, 2 or Modelica.Constants.inf"        );
        end if;
      end if;
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Matrices.<strong>norm</strong>(A);
Matrices.<strong>norm</strong>(A, p=2);
</pre></blockquote>

<h4>描述</h4>
<p>
函数调用\"<code>Matrices.norm(A)</code>\"返回
矩阵A的2范数，即A的最大奇异值<br>
函数调用\"<code>Matrices。norm(A, p)</code>\"返回
矩阵a的p范数，p唯一允许的值是
</p>

<ul>
<li> \"p=1\": A的最大列和</li>
<li> \"p=2\": A的最大奇异值</li>
<li> \"p=Modelica.Constants.inf\": A的最大行和</li>
</ul>

<p>
注意，对于任何矩阵A1, A2，下面的不等式成立:
</p>

<blockquote><pre>
Matrices.<strong>norm</strong>(A1+A2,p) &le; Matrices.<strong>norm</strong>(A1,p) + Matrices.<strong>norm</strong>(A2,p)
</pre></blockquote>

<p>
注意，对于任何矩阵A和向量v，下面的不等式成立:
</p>

<blockquote><pre>
Vectors.<strong>norm</strong>(A*v,p) &le; Matrices.<strong>norm</strong>(A,p)*Vectors.<strong>norm</strong>(A,p)
</pre></blockquote>

<h4>另外</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.frobeniusNorm\">Matrices.frobeniusNorm</a>
</p>

</html>"        ));
    end norm;

    function frobeniusNorm "返回矩阵的Frobenius范数"
      extends Modelica.Icons.Function;
      input Real A[:,:] "输入矩阵";
      output Real result "矩阵A的Frobenius范数";

    algorithm
      result := if min(size(A)) > 0 then sqrt(sum(A .* A)) else 0.0;

      annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
r = Matrices.<strong>frobeniusNorm</strong>(A);
</pre></blockquote>

<h4>描述</h4>

<p>
这个函数计算一般实矩阵<strong> a </strong>的Frobenius范数，即所有元素的平方和的平方根。
</p>

<h4>示例</h4>
<blockquote><pre>
A = [1, 2;
 2, 1];
r = frobeniusNorm(A);

results in:

r = 3.162;
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.norm\">Matrices.norm</a>
</p>

</html>"            , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
   by Marcus Baur, DLR-RM</li>
</ul>
</html>"            ));
    end frobeniusNorm;

    function exp 
      "通过带缩放和平衡的自适应泰勒级数展开，返回矩阵的指数"

      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)];
      input Real T = 1;
      output Real phi[size(A, 1),size(A, 1)] "= exp(A*T)";

    protected
      parameter Integer nmax = 21 "最大迭代次数";
      /*最大迭代次数*/
      parameter Integer na = size(A, 1) "A方阵行数";
      Integer j = 1;
      Integer k = 0;
      Boolean done = false;
      Real Anorm;
      Real Tscaled = 1;
      Real Atransf[na,na];
      Real D[na,na];
      /*D: psi的虚拟变量*/
      Real M[na,na];
      /*M: 虚拟矩阵*/
      Real Diag[na];
      /*对角变换矩阵用于平衡*/

      encapsulated function columnNorm "返回矩阵的列范数"
        import Modelica;
        extends Modelica.Icons.Function;
        input Real A[:,:] "输入矩阵";
        output Real result = 0.0 "矩阵A的1范数";
        annotation();
      algorithm
        for i in 1:size(A, 2) loop
          result := max(result, sum(abs(A[:,i])));
        end for;
      end columnNorm;

    algorithm
      // A的平衡
      (Diag,Atransf) := balance(A);

      // T的缩放 norm(A)*/(2^k) < 1
      Tscaled := T;
      /*Anorm: 矩阵A的列范数*/
      Anorm := columnNorm(Atransf);
      Anorm := Anorm * T;
      while Anorm >= 0.5 loop
        Anorm := Anorm / 2;
        Tscaled := Tscaled / 2;
        k := k + 1;
      end while;

      // 用泰勒级数近似计算
      M := identity(na);
      D := M;
      while j < nmax and not done loop
        M := Atransf * M * Tscaled / j;
        //如果级数的新元素很小，则停止
        if columnNorm((D + M) - D) == 0 then
          done := true;
        else
          D := M + D;
          j := j + 1;
        end if;
      end while;

      // re-scaling
      for i in 1:k loop
        D := D * D;
      end for;

      // re-balancing: psi := diagonal(Diag)*D*inv(diagonal(Diag));
      for j in 1:na loop
        for k in 1:na loop
          phi[j,k] := D[j,k] * Diag[j] / Diag[k];
        end for;
      end for;
      annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >phi = Matrices.exp(A);
phi = Matrices.exp(A,T=1);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
该函数计算矩阵<strong>A</strong>的指数e<sup><strong>AT</strong></sup>。
</p>
<p>
<br>
</p>
<pre><code >                   (AT)^2   (AT)^3
 Φ = e^(AT) = I + AT + ------ + ------ + ....
                     2!       3!
</code></pre><p>
<br>
</p>
<p>
在e = 2.71828……， <strong>A</strong>是一个n × n的实数矩阵，T是实数， 例如，采样时间。 <strong>A</strong>可以是单数。对于矩阵的指数，它是，例如，可能的 计算一个线性微分方程组的解
</p>
<p>
<br>
</p>
<pre><code >der(x) = A*x   -&gt;   x(t0 + T) = e^(AT)*x(t0)
</code></pre><p>
<br>
</p>
<h4>算法细节</h4><p>
算法取自
</p>
<p>
H. D. Joos, G. Grübel:
</p>
<p>
<strong>RASP\\'91 Regulator Analysis and Synthesis Programs<br></strong><br>DLR - Control Systems Group 1991
</p>
<p>
执行以下步骤来计算A的指数:
</p>
<ol><li>
矩阵<strong>A</strong>是平衡的<br> (=用对角矩阵<strong>D</strong>变换，使得inv(<strong>D</strong>)*<strong> a </strong>*<strong>D</strong> 条件<strong> a </strong>).</li>
<li>
标量T除以2的倍数，使得norm( inv(<strong>D</strong>)*<strong>A</strong>*<strong>D</strong>*T/2^k ) &lt; 0.5. 注意，(1)和(2)的实现使得没有舍入错误 介绍了.</li>
<li>
由式(2)得到的矩阵通过显式地执行泰勒近似 项数可变的级数展开。 如果新项不再对<strong>Φ</strong>的值有贡献，则发生截断。 从之前的迭代中.</li>
<li>
通过还原(2)的步骤，将得到的矩阵变换回来。 (1).</li>
</ol><p>
在一些资料中，不建议使用泰勒级数展开计算矩阵的指数，如C.B. Moler和C.F. Van Loan: 19种计算矩阵指数的可疑方法。SIAM评论20， 第801- 836,1979 \\'或在m-文件expm2在MATLAB版本6的文档 (<a href=\"http://www.mathworks.com\" target=\"\">http://www.mathworks.com</a> 他说:“作为一种实用的数值方法，这种方法通常是缓慢和不准确的。” 这些表述对于泰勒级数的直接实现是有效的扩展，但不是用于此函数中使用的实现变体。
</p>
<p>
<br>
</p>
</html>"    ,revisions = "<html>
<p><strong>发布说明:</strong></p>
<ul>
<li><em>July 5, 2002</em>
   by H. D. Joos and Nico Walther<br>
   Implemented.
</li>
</ul>
</html>"    ));
    end exp;

    function integralExp 
      "返回一个矩阵的指数和指数积分"

      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)];
      input Real B[size(A, 1),:];
      input Real T = 1;
      output Real phi[size(A, 1),size(A, 1)] "= exp(A*T)";
      output Real gamma[size(A, 1),size(B, 2)] "= integral(phi)*B";
    protected
      parameter Integer nmax = 21"最大迭代次数";
      /*最大迭代次数*/
      parameter Integer na = size(A, 1)"A方阵行数";
      Integer j = 2;
      Integer k = 0;
      Boolean done = false;
      Real Anorm;
      Real Tscaled = 1;
      Real Atransf[na,na];
      Real Psi[na,na];
      /*Psi: psi的虚拟变量*/
      Real M[na,na];
      /*M: 虚拟矩阵*/
      Real Diag[na];
      /*对角变换矩阵用于平衡*/

      encapsulated function columnNorm "返回矩阵的列范数"
        import Modelica;
        extends Modelica.Icons.Function;
        input Real A[:,:] "输入矩阵";
        output Real result = 0.0 "矩阵A的1范数";
        annotation();
      algorithm
        for i in 1:size(A, 2) loop
          result := max(result, sum(abs(A[:,i])));
        end for;
      end columnNorm;
    algorithm
      // A的平衡
      (Diag,Atransf) := balance(A);

      // T的缩放 norm(A)*/(2^k) < 0.5
      Tscaled := T;
      /*Anorm: 矩阵的列模 A*/
      // Anorm := norm(Atransf, 1);
      Anorm := columnNorm(Atransf);
      Anorm := Anorm * T;
      while Anorm >= 0.5 loop
        Anorm := Anorm / 2;
        Tscaled := Tscaled / 2;
        k := k + 1;
      end while;

      // 用泰勒级数近似计算
      M := identity(na) * Tscaled;
      Psi := M;
      while j < nmax and not done loop
        M := Atransf * M * Tscaled / j;
        //如果级数的新元素很小，则停止
        // if norm((Psi + M) - Psi, 1) == 0 then
        if columnNorm((Psi + M) - Psi) == 0 then
          done := true;
        else
          Psi := M + Psi;
          j := j + 1;
        end if;
      end while;

      // re-scaling
      for j in 1:k loop
        Psi := Atransf * Psi * Psi + 2 * Psi;
      end for;

      // re-balancing: psi := diagonal(Diag)*D*inv(diagonal(Diag));
      for j in 1:na loop
        for k in 1:na loop
          Psi[j,k] := Psi[j,k] * Diag[j] / Diag[k];
        end for;
      end for;
      gamma := Psi * B;
      phi := A * Psi + identity(na);

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
(phi,gamma) = Matrices.<strong>integralExp</strong>(A,B);
(phi,gamma) = Matrices.<strong>integralExp</strong>(A,B,T=1);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数计算矩阵<strong>A</strong>的指数phi = e^(<strong>A</strong>T)和积分gamma = integral(phi*dt)*B.
</p>

<p>
该函数使用泰勒级数展开结合平衡和缩放/平方方法来近似矩阵指数<strong>&Phi;</strong>=e^(AT)的积分<strong>&Psi;</strong>：
</p>
<blockquote><pre>
                       AT^2   A^2 * T^3          A^k * T^(k+1)
<strong>&Psi;</strong> = int(e^(As))ds = IT + ---- + --------- + ... + --------------
                        2!        3!                (k+1)!
</pre></blockquote>
<p>
<strong>&Phi;</strong>是通过<strong>&Phi;</strong> = I + A*<strong>&Psi;</strong>计算, 所以A可能是是奇异的。
<strong>&Gamma;</strong> 简化为<strong>&Psi;</strong>*B。
</p>
<p>算法按以下步骤执行：</p>
<ol>
<li>平衡</li>
<li>扩展</li>
<li>泰勒级数展开</li>
<li>重新扩展</li>
<li>重新平衡</li>
</ol>
<p>
平衡步骤将方阵A的不良条件转化为对角变换矩阵D。这减少了后续计算的工作量。
之后，结果需要通过变换D*A<small> transfer </small>*inv(D)重新平衡。
<br>
缩放步骤将T缩小k次，直到A*T的范数小于0.5。这保证了在后续级数展开中的最小舍入误差。重新缩放基于方程exp(A*2T) = exp(AT)^2。
因此，psi的重新缩放公式变为：
</p>
<blockquote><pre>
    <strong>&Phi;</strong> = <strong>&Phi;</strong>'*<strong>&Phi;</strong>'
I + A*<strong>&Psi;</strong> = I + 2A*<strong>&Psi;</strong>' + A^2*<strong>&Psi;</strong>'^2
    <strong>&Psi;</strong> = A*<strong>&Psi;</strong>'^2 + 2*<strong>&Psi;</strong>'
</pre></blockquote>
<p>
其中，psi′是从级数展开得到的缩放结果，而psi是重新缩放后的矩阵。
</p>
<p>
该函数通常用于将状态空间系统离散化为零阶保持(ZOH)等效形式。
</p>
<blockquote><pre>
x(k+1) = <strong>&Phi;</strong>*x(k) + <strong>&Gamma;</strong>*u(k)
y(k) = C*x(k) + D*u(k)
</pre></blockquote>
<p>
零阶保持采样，也称为阶跃不变法(step-invariant method)，在假设控制信号u在采样时刻之间保持不变的情况下，给出了状态变量的精确值。零阶保持采样在以下文献中有描述：
在
</p>
<dl>
<dt>K. J. &Aring;str&ouml;m, B. Wittenmark:</dt>
<dd><strong>Computer Controlled Systems - Theory and Design</strong><br>
    Third Edition, p. 32</dd>
</dl>
<blockquote><pre><strong>Syntax:</strong>
    (phi,gamma) = Matrices.expIntegral(A,B,T)
                     A,phi: [n,n] square matrices
                   B,gamma: [n,m] input matrix
                         T: scalar, e.g., sampling time
</pre></blockquote>
<p>
计算psi的算法取自
</p>
<dl>
<dt>H. D. Joos, G. Gr&uuml;bel:</dt>
<dd><strong>RASP'91 Regulator Analysis and Synthesis Programs</strong><br>
    DLR - Control Systems Group 1991</dd>
</dl>
</html>"            , revisions = "<html>
<p><strong>发布说明:</strong></p>
<ul>
<li><em>July 5, 2002</em>
     by H. D. Joos and Nico Walther<br>
     已实现。
</li>
</ul>
</html>"            ));
    end integralExp;

    function integralExpT 
      "返回一个矩阵的指数、指数积分、以及指数的时间加权积分"

      extends Modelica.Icons.Function;
      input Real A[:,size(A, 1)];
      input Real B[size(A, 1),:];
      input Real T = 1;
      output Real phi[size(A, 1),size(A, 1)] "= exp(A*T)";
      output Real gamma[size(A, 1),size(B, 2)] "= integral(phi)*B";
      output Real gamma1[size(A, 1),size(B, 2)] "= integral((T-t)*exp(A*t))*B";
    protected
      Integer nmax = 200;
      /*最大迭代次数*/
      parameter Integer na = size(A, 1)"A方阵行数";
      parameter Integer nb = size(B, 2)"B矩阵列数";
      Integer j = 1;
      Boolean done = false;
      Real F[na + 2 * nb,na + 2 * nb];

    algorithm
      F := [A, B, zeros(na, nb); zeros(2 * nb, na), zeros(2 * nb, nb), [identity(nb);
        zeros(nb, nb)]];
      F := exp(F, T);
      phi := F[1:na,1:na];
      gamma := F[1:na,na + 1:na + nb];
      gamma1 := F[1:na,na + nb + 1:na + 2 * nb];

      annotation(Documentation(info = "<html>
<blockquote><pre>
(phi,gamma,gamma1) = Matrices.<strong>integralExpT</strong>(A,B);
(phi,gamma,gamma1) = Matrices.<strong>integralExpT</strong>(A,B,T=1);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数计算矩阵<strong>A</strong>的指数phi = e^(<strong>A</strong>T)、积分gamma = integral(phi*dt)*B和
积分gamma1 = integral((T-t)*exp(A*t)*dt)*B，其中A是一个(n,n)的方阵，B、gamma和gamma1是(n,m)矩阵。
</p>

<p>
这个函数通过这个方程计算矩阵phi、gamma、gamma1：
</p>
<blockquote><pre>
                               [ A B 0 ]
[phi gamma gamma1] = [I 0 0]*exp([ 0 0 I ]*T)
                               [ 0 0 0 ]
</pre></blockquote>

<p>
这些矩阵定义了状态空间系统的离散化一阶保持(first-order-hold)等效形式：
</p>
<blockquote><pre>
x(k+1) = phi*x(k) + gamma*u(k) + gamma1/T*(u(k+1) - u(k))
</pre></blockquote>
<p>
一阶保持采样，也称为斜坡不变法(ramp-invariant method)，与零阶保持(ZOH)等效方法相比，提供了更加平滑的控制信号。
一阶保持采样，例如，在以下文献中有描述：
</p>

<dl>
<dt>K. J. &Aring;str&ouml;m, B. Wittenmark:</dt>
<dd><strong>Computer Controlled Systems - Theory and Design</strong><br>
    Third Edition, p. 256</dd>
</dl>

</html>"                , revisions = "<html>
<p><strong>发布说明:</strong></p>
<ul>
<li><em>July 31, 2002</em>
     by Nico Walther<br>
     实现。
</li>
</ul>
</html>"                ));
    end integralExpT;

    //
    // protected

    function continuousLyapunov 
      "返回连续时间Lyapunov方程X*A + A'*X = C的解X"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices;

      input Real A[:,size(A, 1)] "方阵A在 X*A + A'*X = C";
      input Real C[size(A, 1),size(A, 2)] "方阵C在X*A + A'*X = C";
      input Boolean ATisSchur = false 
        "= true，如果转置(A)已经是实舒尔形式";
      input Real eps = Modelica.Math.Matrices.norm(A, 1) * 10 * 1e-15 "宽容每股收益";

    protected
      constant Integer n = size(A, 1);
      Real R[size(A, 1),size(A, 2)] "rsf of A', i.e., R=U'A'U";
      Real U[size(A, 1),size(A, 2)] "变换矩阵U对于R=U'A'U";
      Real D[size(A, 1),size(A, 2)] "矩阵 D=U'*C*U";
      Real R11[size(A, 1),size(A, 2)];
      Real R22[size(A, 1),size(A, 2)];
      Real R12[size(A, 1),size(A, 2)];
      Real R21[size(A, 1),size(A, 2)];
      Real R2[2 * size(A, 1),2 * size(A, 2)];
      Real I[size(A, 1),size(A, 1)] = identity(size(A, 1));
      Real y[2 * size(A, 1)];
      Real c[2 * size(A, 1)];
      Real CC[size(A, 1),2];
      Integer k;

    public
      output Real X[size(A, 1),size(A, 2)] 
        "李雅普诺夫方程X*A + A'*X = C的解X";
    protected
      Real tempX[size(A, 1)];
      Real tempX2[size(A, 1),2];

    algorithm
      if n > 1 then
        if ATisSchur then
          R := transpose(A);
          U := identity(n);
          D := C;
        else
          (R,U) := Modelica.Math.Matrices.realSchur(transpose(A));
          D := transpose(U) * C * U;
        end if;

        X := zeros(n, n);

        // 计算X的最后1或2列
        R22 := R;
        for i1 in 1:n loop
          R22[i1,i1] := R[i1,i1] + R[n,n];
        end for;
        if abs(R[n,n - 1]) < eps then
          X[:,n] := Matrices.solve(R22, D[:,n]);
          k := n - 1;
        else
          R11 := R;
          R12 := zeros(n, n);
          R21 := zeros(n, n);
          for i1 in 1:n loop
            R11[i1,i1] := R[i1,i1] + R[n - 1,n - 1];
            R12[i1,i1] := R[n - 1,n];
            R21[i1,i1] := R[n,n - 1];
          end for;

          // 利用Kronecker积和vec算子方法求解2x2 Schur凹凸的2nx2n方程
          R2 := [R11, R12; R21, R22];
          c := cat(
            1, 
            D[:,n - 1], 
            D[:,n]);
          y := Matrices.solve(R2, c);
          X[:,n - 1] := y[1:n];
          X[:,n] := y[n + 1:2 * n];
          k := n - 2;
        end if;

        // 计算X的剩余部分
        while k > 1 loop
          R22 := R;
          for i1 in 1:n loop
            R22[i1,i1] := R[i1,i1] + R[k,k];
          end for;
          if abs(R[k,k - 1]) < eps then
            //真正的特征值
            for i in 1:n loop
              tempX[i] := 0;
              for j in k + 1:n loop
                tempX[i] := tempX[i] + X[i,j] * R[k,j];
              end for;
            end for;
            X[:,k] := Matrices.solve(R22, D[:,k] - tempX);
            //X[:, k] := Matrices.solve(R22, D[:, k] - vector(X[:, k + 1:n]*matrix(
            //R[k, k + 1:n])));
            k := k - 1;
          else
            // 共轭复特征值
            R11 := R;
            R12 := zeros(n, n);
            R21 := zeros(n, n);
            for i1 in 1:n loop
              R11[i1,i1] := R[i1,i1] + R[k - 1,k - 1];
              R12[i1,i1] := R[k - 1,k];
              R21[i1,i1] := R[k,k - 1];
            end for;
            R2 := [R11, R12; R21, R22];
            for i in 1:n loop
              for j in 1:2 loop
                tempX2[i,j] := 0;
                for kn in k + 1:n loop
                  tempX2[i,j] := tempX2[i,j] + X[i,kn] * R[j,kn];
                end for;
                CC[i,j] := D[i,j] - tempX2[i,j];
              end for;
            end for;
            //CC := D[:, k - 1:k] - X[:, k + 1:n]*transpose(R[k - 1:k, k + 1:n]);
            c := cat(
              1, 
              CC[:,1], 
              CC[:,2]);
            y := Matrices.solve(R2, c);
            X[:,k - 1] := y[1:n];
            X[:,k] := y[n + 1:2 * n];

            k := k - 2;
          end if;
        end while;
        // k=1 or k=0

        // 如果k=1，第一列(如果存在实特征值)必须单独计算
        if k == 1 then
          R22 := R;
          for i1 in 1:n loop
            R22[i1,i1] := R[i1,i1] + R[1,1];
          end for;
          X[:,1] := Matrices.solve(R22, D[:,1] - vector(X[:,2:n] * matrix(R[1,2
            :n])));
        end if;

        // 变换X对应于原始形式
        if not ATisSchur then
          X := U * X * transpose(U);
        end if;

      elseif n == 1 then
        //简单标量方程
        X[1,1] := C[1,1] / (2 * A[1,1]);
      else
        X := fill(
          0, 
          0, 
          0);
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
X = Matrices.<strong>continuousLyapunov</strong>(A, C);
X = Matrices.<strong>continuousLyapunov</strong>(A, C, ATisSchur, eps);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数计算连续时间Lyapunov方程的解<strong>X</strong>
</p>

<blockquote><pre>
<strong>X</strong>*<strong>A</strong> + <strong>A</strong>'*<strong>X</strong> = <strong>C</strong>
</pre></blockquote>

<p>
利用Bartels和Stewart提出的Lyapunov方程的Schur方法[1].
</p>

<p>
简而言之，问题被简化为相应的问题
</p>

<blockquote><pre>
<strong>Y</strong>*<strong>R</strong>' + <strong>R</strong>*<strong>Y</strong> = <strong>D</strong>
</pre></blockquote>

<p>
其中<strong>R</strong>=<strong>U</strong>'*<strong>A'</strong>*<strong>U</strong>是<strong>A</strong>'的实Schur形式，
<strong>D</strong>=<strong>U</strong>'*<strong>C</strong>*<strong>U</strong>和<strong>Y</strong>=<strong>U</strong>'*<strong>X</strong>*<strong>U</strong>是<strong>C</strong>和<strong>X</strong>的对应变换。
利用<strong>R</strong>的块三角形式，逐步求解1x1或2x2的Schur块。
最后恢复原问题的解为<strong>X</strong>=<strong>U</strong>*<strong>Y</strong>*<strong>U</strong>'。
布尔输入\"ATisSchur\"表示在<strong>A</strong>'已经具有Schur形式的情况下，则省略对A′的Schur变换。
</p>

<h4>参考文献</h4>
<blockquote><pre>
[1] Bartels, R.H. and Stewart G.W.
  Algorithm 432: Solution of the matrix equation AX + XB = C.
  Comm. ACM., Vol. 15, pp. 820-826, 1972.
</pre></blockquote>

<h4>示例</h4>
<blockquote><pre>
A = [1, 2,  3,  4;
   3, 4,  5, -2;
  -1, 2, -3, -5;
   0, 2,  0,  6];

C =  [-2, 3, 1, 0;
    -6, 8, 0, 1;
     2, 3, 4, 5;
    0, -2, 0, 0];

X = continuousLyapunov(A, C);

results in:

X = [1.633, -0.761,  0.575, -0.656;
  -1.158,  1.216,  0.047,  0.343;
  -1.066, -0.052, -0.916,  1.61;
  -2.473,  0.717, -0.986,  1.48]
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">Matrices.continuousSylvester</a>,
<a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">Matrices.discreteLyapunov</a>
</p>

</html>"                , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"                ));
    end continuousLyapunov;

    function continuousSylvester 
      "返回连续时间Sylvester方程A*X + X*B = C的解X"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices;

      input Real A[:,:] "方阵A";
      input Real B[:,:] "方阵B";
      input Real C[size(A, 1),size(B, 2)] "矩阵C";
      input Boolean AisSchur = false "= true，如果A已经有实舒尔形式";
      input Boolean BisSchur = false "= true，如果B已经有实舒尔形式";
      output Real X[size(A, 1),size(B, 2)] 
        "连续Sylvester方程的解";

    protected
      Integer n = size(A, 1);
      Integer m = size(B, 1);
      Real S[size(A, 1),size(A, 2)];
      Real T[size(B, 1),size(B, 2)];
      Real U[size(A, 1),size(A, 1)];
      Real V[size(B, 1),size(B, 1)];
      Real Chat[size(C, 1),size(C, 2)];
      Real scale;
      Integer info;

    algorithm
      if n > 1 and m > 1 then
        if AisSchur then
          S := A;
          U := identity(n);
        else
          (S,U) := Modelica.Math.Matrices.realSchur(A);
        end if;
        if BisSchur then
          T := B;
          V := identity(m);
        else
          (T,V) := Modelica.Math.Matrices.realSchur(B);
        end if;

        Chat := if AisSchur and BisSchur then C else if AisSchur then C * V else 
          if BisSchur then transpose(U) * C else transpose(U) * C * V;
        (X,scale,info) := Matrices.LAPACK.dtrsyl(
          S, 
          T, 
          Chat);
        assert(info == 0, "用矩阵求解Sylvester方程。西尔维斯特没有成功.\n
                  The value of info is "             + String(info) + ", but should be zero. A value unequal to zero means:\n
          < 0: if INFO = -i, the i-th argument had an illegal value\n
          = 1: A and B have common or very close eigenvalues; perturbed
               values were used to solve the equation (but the matrices
               A and B are unchanged)."            );
        X := if AisSchur and BisSchur then scale * X else if AisSchur then scale * X * 
          transpose(V) else if BisSchur then scale * U * X else scale * U * X * transpose(V);
      else
        X := fill(
          0, 
          n, 
          m);
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
X = Matrices.<strong>continuousSylvester</strong>(A, B, C);
X = Matrices.<strong>continuousSylvester</strong>(A, B, C, AisSchur, BisSchur);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>continuousSylvester</strong>计算连续时间Sylvester方程的解<strong>X</strong>
</p>

<blockquote><pre>
<strong>A</strong>*<strong>X</strong> + <strong>X</strong>*<strong>B</strong> = <strong>C</strong>.
</pre></blockquote>

<p>
使用Bartels和Stewart[1]提出的Sylvester方程的Schur方法。
</p>

<p>
简而言之，问题被简化为相应的问题
</p>
<blockquote><pre>
<strong>S</strong>*<strong>Y</strong> + <strong>Y</strong>*<strong>T</strong> = <strong>D</strong>.
</pre></blockquote>
<p>
其中<strong>S</strong>=<strong>U</strong>'*<strong>A</strong>*<strong>U</strong>是<strong>A</strong>的实Schur形式，
<strong>T</strong>=<strong>V</strong>'*<strong>T</strong>*<strong>V</strong>是<strong>B</strong>的实Schur形式，
<strong>D</strong>=<strong>U</strong>'*<strong>C</strong>*<strong>V</strong>和<strong>Y</strong>=<strong>U</strong>*<strong>X</strong>*<strong>V</strong>”为<strong>C</strong>和<strong>X</strong>的对应变换。
该问题通过利用<strong>S</strong>和<strong>T</strong>的块三角形形式依次解决。
最后恢复原问题的解为<strong>X</strong>=<strong>U</strong>'*<strong>Y</strong>*<strong>V</strong>。
布尔输入\"AisSchur\"和\"BisSchur\"表示在<strong>A</strong>和/或<strong>B</strong>已经具有Schur形式的情况下，省略到Schur的一个或两个转换。
</p>

<p>
该函数应用LAPACK-routine DTRSYL。参见<a href=\"modelica:// modelica . math . matrices .LAPACK.dtrsyl\">LAPACK.dtrsyl</a>
了解更多信息。
</p>

<h4>参考文献</h4>
<blockquote><pre>
[1] Bartels, R.H. and Stewart G.W.
  Algorithm 432: Solution of the matrix equation AX + XB = C.
  Comm. ACM., Vol. 15, pp. 820-826, 1972.
</pre></blockquote>

<h4>示例</h4>
<blockquote><pre>
A = [17.0,   24.0,   1.0,   8.0,   15.0 ;
   23.0,    5.0,   7.0,  14.0,   16.0 ;
    0.0,    6.0,  13.0,  20.0,   22.0;
    0.0,    0.0,  19.0,  21.0,    3.0 ;
    0.0,    0.0,   0.0,   2.0,    9.0];

B =  [8.0, 1.0, 6.0;
    0.0, 5.0, 7.0;
    0.0, 9.0, 2.0];

C = [62.0,  -12.0, 26.0;
   59.0,  -10.0, 31.0;
   70.0,  -6.0,   9.0;
   35.0,  31.0,  -7.0;
   36.0, -15.0,   7.0];

X = continuousSylvester(A, B, C);

results in:

X = [0.0,  0.0,  1.0;
   1.0,  0.0,  0.0;
   0.0,  1.0,  0.0;
   1.0,  1.0, -1.0;
   2.0, -2.0,  1.0];
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">Matrices.discreteSylvester</a>,
<a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">Matrices.continuousLyapunov</a>
</p>

</html>"            , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"            ));
    end continuousSylvester;
    function continuousRiccati 
      "返回连续时间代数Riccati方程A'*X + X*A - X*B*inv(R)*B'*X + Q = 0的解X"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices;

      input Real A[:,size(A, 1)] "CARE中的方阵A";
      input Real B[size(A, 1),:] "CARE中的矩阵B";
      input Real R[size(B, 2),size(B, 2)] = identity(size(B, 2)) 
        "CARE中的矩阵R";
      input Real Q[size(A, 1),size(A, 1)] = identity(size(A, 1)) 
        "CARE中的矩阵Q";
      input Boolean refine = false "为后续细化";

    protected
      constant Integer n = size(A, 1);
      Real G[size(A, 1),size(A, 1)] = B * Modelica.Math.Matrices.solve2(R, transpose(
        B));
      Real H[2 * size(A, 1),2 * size(A, 1)] = [A, -G; -Q, -transpose(A)];
      Real H_RSF[2 * size(A, 1),2 * size(A, 1)] = H;
      Real Z[size(H, 1),size(H, 2)];
      Real Z11[size(A, 1),size(A, 2)];
      Real Z21[size(A, 1),size(A, 2)];

      Integer info;

    public
      output Real X[size(A, 1),size(A, 2)] "CARE的稳定解";
      output Real alphaReal[2 * size(A, 1)] 
        "eigenvalue=alphaReal+i*alphaImag的实部";
      output Real alphaImag[2 * size(A, 1)] 
        "eigenvalue=alphaReal+i*alphaImag的虚部";
    algorithm
      if n > 1 then
        (H_RSF,Z,alphaReal,alphaImag) := Modelica.Math.Matrices.realSchur(H);
        (H_RSF,Z,alphaReal,alphaImag) := Matrices.Utilities.reorderRSF(
          H_RSF, 
          Z, 
          alphaReal, 
          alphaImag, 
          true);

        Z11 := Z[1:n,1:n];
        Z21 := Z[n + 1:2 * n,1:n];
        if size(Z11, 1) > 0 then

          (X,info) := Matrices.LAPACK.dgesvx(Z11, transpose(Z21));
          //该函数不需要像 solve2 在使用 //  X := transpose(Matrices.solve2(transpose(Z11), transpose(Z21)));
          assert(info == 0, 
            "Solving a linear system of equations with function \"Matrices.LAPACK.dgesvx\" is not possible, because the system has either no or infinitely many solutions (input A is singular).");
          X := transpose(X);

          if refine then
            X := Modelica.Math.Matrices.Utilities.continuousRiccatiIterative(
              A, 
              B, 
              R, 
              Q, 
              X);
          end if;
        else
          X := fill(
            0, 
            size(Z21, 1), 
            size(Z11, 1));
        end if;

      elseif n == 1 then
        X := matrix((A[1,1] - sqrt(A[1,1] * A[1,1] + G[1,1] * Q[1,1])) / G[1,1]);
        if X[1,1] * G[1,1] < A[1,1] then
          X := matrix((A[1,1] + sqrt(A[1,1] * A[1,1] + G[1,1] * Q[1,1])) / G[1,1]);
        end if;
      else
        X := fill(
          0, 
          0, 
          0);
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
                    X = Matrices.<strong>continuousRiccati</strong>(A, B, R, Q);
(X, alphaReal, alphaImag) = Matrices.<strong>continuousRiccati</strong>(A, B, R, Q, true);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>continuousRiccati</strong>计算连续时间代数Riccati方程的解<strong>X</strong>
</p>

<blockquote><pre>
<strong>A</strong>'*<strong>X</strong> + <strong>X</strong>*<strong>A</strong> - <strong>X</strong>*<strong>G</strong>*<strong>X</strong> + <strong>Q</strong> = <strong>0</strong>
</pre></blockquote>

<p>
<code><strong>G</strong> = <strong>B</strong>*inv(<strong>R</strong>)*<strong>B</strong>'</code>使用Laub提出的Schur向量方法[1]。
</p>

<p>
假设<strong>Q</strong>是对称的正半定的，<strong>R</strong>是对称的非奇异的正定的，
(<strong>A</strong>，<strong>B</strong>)是稳定的，(<strong>A</strong>，<strong>Q</strong>)是可检测的。
</p>

<p><strong>
在这个函数中没有检查这些假设!!
</strong><br>
</p>

<p>
这个假设保证了Hamiltonian矩阵
</p>

<blockquote><pre>
<strong>H</strong> = [<strong>A</strong>, -<strong>G</strong>; -<strong>Q</strong>, -<strong>A</strong>']
</pre></blockquote>

<p>
没有纯虚特征值，并且可以转换为有序的实Schur形式
</p>

<blockquote><pre>
<strong>U</strong>'*<strong>H</strong>*<strong>U</strong> = <strong>S</strong> = [<strong>S</strong>11, <strong>S</strong>12; <strong>0</strong>, <strong>S</strong>22]
</pre></blockquote>

<p>
正交相似变换<strong>U</strong>.<strong>S</strong>排序如下:
<strong>S</strong>11包含有闭环系统矩阵的系统矩阵
<strong>A</strong> - <strong>B</strong>*inv(<strong>R</strong>)*<strong>B</strong>'*<strong>X</strong>的n个稳定特征值。
如果<strong>U</strong>被分区为
</p>

<blockquote><pre>
<strong>U</strong> = [<strong>U</strong>11, <strong>U</strong>12; <strong>U</strong>21, <strong>U</strong>22]
</pre></blockquote>

<p>
根据<strong>S</strong>的维度，解<strong>X</strong>被计算为
</p>

<blockquote><pre>
<strong>X</strong>*<strong>U</strong>11 = <strong>U</strong>21.
</pre></blockquote>

<p>
对于可选输入<code>refinement=true</code>，应用基于牛顿方法的精确行搜索的后续迭代细化。
参见<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">continuousRiccatiIterative</a>
了解更多信息。
</p>

<h4>参考文献</h4>
<blockquote><pre>
[1] Laub, A.J.
A Schur Method for Solving Algebraic Riccati equations.
IEEE Trans. Auto. Contr., AC-24, pp. 913-921, 1979.
</pre></blockquote>

<h4>示例</h4>
<blockquote><pre>
A = [0.0, 1.0;
 0.0, 0.0];

B = [0.0;
 1.0];

R = [1];

Q = [1.0, 0.0;
 0.0, 2.0];

X = continuousRiccati(A, B, R, Q);

results in:

X = [2.0, 1.0;
 1.0, 2.0];
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\">Matrices.Utilities.continuousRiccatiIterative</a>,
<a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">Matrices.discreteRiccati</a>
</p>

</html>"                        , revisions = "<html><ul>
<li><em>2010/05/31 </em>
   by Marcus Baur, DLR-RM</li>
</ul>
</html>"                        ));
    end continuousRiccati;

    function discreteLyapunov 
      "返回离散时间Lyapunov方程A'*X*A + sgn*X = C的解X"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices;

      input Real A[:,size(A, 1)] "方阵A (A'*X) *A + sgn*X = C";
      input Real C[size(A, 1),size(A, 2)] 
        "方阵C (A'*X) *A + sgn*X = C";
      input Boolean ATisSchur = false 
        "= true，如果转置(A)已经是实舒尔形式";
      input Integer sgn = 1 "指定A'*X*A + sgn*X = C中的符号";
      input Real eps = Matrices.norm(A, 1) * 10 * Modelica.Constants.eps 
        "容忍度 eps";

    protected
      constant Integer n = size(A, 1);
      Real R[size(A, 1),size(A, 2)] "RSF of A', i.e., R=U'A'U";
      Real U[size(A, 1),size(A, 2)] "变换矩阵 U 用于 R=U'A'U";
      Real D[size(A, 1),size(A, 2)] "矩阵 D=U'*C*U";
      Real R22[size(A, 1),size(A, 2)];
      Real R11[size(A, 1),size(A, 2)];
      Integer k;

      Real g[size(A, 1)];
      Real w[size(A, 1)];
      Real y[2 * size(A, 1)];
      Boolean crit;

    public
      output Real X[size(A, 1),size(A, 2)] 
        "李雅普诺夫方程 A'*X*A + sgn*X = C 的解 X";
    protected
      Real tempX[size(A, 1)];
      Real temp;

    algorithm
      assert(sgn == 1 or sgn == -1, 
        "Input sgn in function Math.Matrices.discreteLyapunov() must be 1 or -1, however it is " 
        + String(sgn));
      X := zeros(n, n);
      k := n;
      if n > 1 then
        if ATisSchur then
          R := transpose(A);
          U := identity(n);
          D := C;
        else
          (R,U) := Modelica.Math.Matrices.realSchur(transpose(A));
          D := transpose(U) * C * U;
        end if;

        while k > 0 loop
          for i in 1:n loop
            tempX[i] := 0;
            for j in k + 1:n loop
              temp := 0;
              for t in 1:n loop
                temp := temp + R[i,t] * X[t,j];
              end for;
              tempX[i] := tempX[i] + temp * R[k,j];
            end for;
          end for;
          w := D[:,k] - tempX;
          //w := D[:, k] - R*X[:, k + 1:n]*R[k, k + 1:n];
          crit := if k > 1 then abs(R[k,k - 1]) < eps else false;
          if (k == 1 or crit) then
            R22 := R[k,k] * R;
            for i in 1:n loop
              R22[i,i] := R22[i,i] + sgn;
            end for;
            X[:,k] := Matrices.solve(R22, w);
            k := k - 1;
          else
            for i in 1:n loop
              tempX[i] := 0;
              for j in k + 1:n loop
                temp := 0;
                for t in 1:n loop
                  temp := temp + R[i,t] * X[t,j];
                end for;
                tempX[i] := tempX[i] + temp * R[k - 1,j];
              end for;
            end for;
            g := D[:,k - 1] - tempX;
            //g := D[:, k - 1] - R*X[:, k + 1:n]*R[k - 1, k + 1:n];
            R11 := R[k - 1,k - 1] * R;
            R22 := R[k,k] * R;
            for i in 1:n loop
              R11[i,i] := R11[i,i] + sgn;
              R22[i,i] := R22[i,i] + sgn;
            end for;
            y := Matrices.solve([R11, R[k - 1,k] * R; R[k,k - 1] * R, R22], cat(
              1, 
              g, 
              w));
            X[:,k - 1] := y[1:n];
            X[:,k] := y[n + 1:2 * n];
            k := k - 2;
          end if;
        end while;

        // 与原形式相对应的 X 变换
        if not ATisSchur then
          X := U * X * transpose(U);
        end if;

      elseif n == 1 then
        X[1,1] := C[1,1] / (A[1,1] * A[1,1] + sgn);
      else
        X := fill(
          0, 
          0, 
          0);
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
X = Matrices.<strong>discreteLyapunov</strong>(A, C);
X = Matrices.<strong>discreteLyapunov</strong>(A, C, ATisSchur, sgn, eps);
</pre></blockquote>

<h4>描述</h4>
<p>
该函数计算离散时间Lyapunov方程的解<strong>X</strong>
</p>

<blockquote><pre>
<strong>A</strong>'*<strong>X</strong>*<strong>A</strong> + sgn*<strong>X</strong> = <strong>C</strong>
</pre></blockquote>

<p>
其中sgn=1或sgn =-1。当sgn = -1时，离散Lyapunov方程是Stein方程的特例：
</p>

<blockquote><pre>
<strong>A</strong>*<strong>X</strong>*<strong>B</strong> - <strong>X</strong> + <strong>Q</strong> = <strong>0</strong>.
</pre></blockquote>

<p>
该算法采用Bartels和Stewart提出的Lyapunov方程的Schur法[1]。
</p>

<p>
简而言之，这个问题可以简化为相应的问题
</p>

<blockquote><pre>
<strong>R</strong>*<strong>Y</strong>*<strong>R</strong>' + sgn*<strong>Y</strong> = <strong>D</strong>.
</pre></blockquote>

<p>
其中<strong>R</strong>=<strong>U</strong>'*<strong>A'</strong>*<strong>U</strong>是<strong>A</strong>'的实Schur形式，
<strong>D</strong>=<strong>U</strong>'*<strong>C</strong>*<strong>U</strong>和<strong>Y</strong>=<strong>U</strong>'*<strong>X</strong>*<strong>U</strong>
为<strong>C</strong>和<strong>X</strong>的相应变换。这个问题通过利用<strong>R</strong>的块三角形形式逐步解决。
最后原问题的解通过<strong>X</strong>=<strong>U</strong>*<strong>Y</strong>*<strong>U</strong>'恢复。
布尔输入\"ATisSchur\"表示在<strong>A</strong>'已经是Schur形式的情况下，跳过转换为Schur形式的步骤。
</p>

<h4>参考文献</h4>
<blockquote><pre>
[1] Bartels, R.H. and Stewart G.W.
  Algorithm 432: Solution of the matrix equation AX + XB = C.
  Comm. ACM., Vol. 15, pp. 820-826, 1972.
</pre></blockquote>

<h4>示例</h4>
<blockquote><pre>
A = [1, 2,  3,  4;
   3, 4,  5, -2;
  -1, 2, -3, -5;
   0, 2,  0,  6];

C =  [-2,  3, 1, 0;
    -6,  8, 0, 1;
     2,  3, 4, 5;
     0, -2, 0, 0];

X = discreteLyapunov(A, C, sgn=-1);

results in:

X  = [7.5735,   -3.1426,  2.7205, -2.5958;
   -2.6105,    1.2384, -0.9232,  0.9632;
    6.6090,   -2.6775,  2.6415, -2.6928;
   -0.3572,    0.2298,  0.0533, -0.27410];

</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">Matrices.discreteSylvester</a>,
<a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">Matrices.continuousLyapunov</a>
</p>

</html>"                    , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"                    ));
    end discreteLyapunov;

    function discreteSylvester 
      "返回离散时间Sylvester方程A*X*B + sgn*X = C的解"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices;

      input Real A[:,size(A, 1)] "方阵A中的A*X*B + sgn*X = C";
      input Real B[:,size(B, 1)] "方阵B在A*X*B + sgn*X = C";
      input Real C[size(A, 2),size(B, 1)] 
        "矩形矩阵C在A*X*B + sgn*X = C";
      input Boolean AisHess = false "= true，如果A已经是海森伯格形式";
      input Boolean BTisSchur = false "= true，如果B'已经是实舒尔形式";
      input Integer sgn = 1 "指定A*X*B + sgn*X = C中的符号";
      input Real eps = Matrices.norm(A, 1) * 10 * Modelica.Constants.eps "容忍度";

    protected
      constant Integer n = size(A, 1);
      constant Integer m = size(B, 1);
      Real H[size(A, 1),size(A, 1)] "A 的海森伯形式, i.e., H=U'AU";
      Real U[size(A, 1),size(A, 1)] "变换矩阵 U 为 H=U'AU";
      Real S[size(B, 1),size(B, 1)] "RSF 形式的 B, i.e., S=Z'BZ";
      Real Z[size(B, 1),size(B, 1)] "变换矩阵 Z 用于 S=Z'BZ";
      Real F[size(A, 1),size(B, 1)] 
        "右边 C 的适当变换，F=U'*C*Z";

      Real R22[size(A, 1),size(A, 1)];
      Real R11[size(A, 1),size(A, 1)];
      Integer k;

      Real w[size(A, 1)];
      Real g[size(A, 1)];
      Real y[2 * size(A, 1)];
      Boolean crit;

    public
      output Real X[size(A, 2),size(B, 1)] 
        "离散西尔维斯特方程 A*X*B + sgn*X = C 的解";
    protected
      Real tempX[size(A, 1)];
      Real temp;

    algorithm
      assert(sgn == 1 or sgn == -1, 
        "Input sgn in function Math.Matrices.discreteLyapunov() must be 1 or -1, however it is " 
        + String(sgn));
      X := zeros(n, m);
      k := m;

      if n > 1 and m > 1 then
        if AisHess then
          H := A;
          U := identity(n);
          if BTisSchur then
            S := B;
            Z := identity(m);
            F := C;
          else
            (S,Z) := Matrices.realSchur(transpose(B));
            S := transpose(S);
            F := C * Z;
          end if;
        else
          (H,U) := Matrices.hessenberg(A);
          if BTisSchur then
            S := B;
            Z := identity(m);
            F := transpose(U) * C;
          else
            (S,Z) := Matrices.realSchur(transpose(B));
            S := transpose(S);
            F := transpose(U) * C * Z;
          end if;
        end if;

        while k > 0 loop
          for i in 1:n loop
            tempX[i] := 0;
            for j in k + 1:m loop
              temp := 0;
              for t in 1:n loop
                temp := temp + H[i,t] * X[t,j];
              end for;
              tempX[i] := tempX[i] + temp * S[j,k];
            end for;
          end for;
          w := F[:,k] - tempX;
          //w := F[:, k] - H*X[:, k + 1:m]*S[k + 1:m, k];
          crit := if k > 1 then abs(S[k - 1,k]) < eps else false;

          if (k == 1 or crit) then
            //舒尔形式的实特征值
            R22 := S[k,k] * H;
            for i in 1:n loop
              R22[i,i] := R22[i,i] + sgn;
            end for;
            X[:,k] := Matrices.solve(R22, w);
            // 求解 X 中一列的一个实特征值
            k := k - 1;
          else
            // 一对复特征值，即 2x2 舒尔凸
            for i in 1:n loop
              tempX[i] := 0;
              for j in k + 1:m loop
                temp := 0;
                for t in 1:n loop
                  temp := temp + H[i,t] * X[t,j];
                end for;
                tempX[i] := tempX[i] + temp * S[j,k - 1];
              end for;
            end for;
            g := F[:,k - 1] - tempX;
            //g := F[:, k - 1] - H*X[:, k + 1:m]*S[k + 1:m, k - 1];
            R22 := S[k,k] * H;
            R11 := S[k - 1,k - 1] * H;
            for i in 1:n loop
              R11[i,i] := R11[i,i] + sgn;
              R22[i,i] := R22[i,i] + sgn;
            end for;
            y := Matrices.solve([R11, S[k,k - 1] * H; S[k - 1,k] * H, R22], cat(
              1, 
              g, 
              w));
            // 求解 X 中两列的一个共轭复极对
            X[:,k - 1] := y[1:n];
            X[:,k] := y[n + 1:2 * n];
            k := k - 2;
          end if;
        end while;

        // 与原形式相对应的 X 变换
        if not (AisHess and BTisSchur) then
          X := if AisHess then X * transpose(Z) else if BTisSchur then U * X else U * X 
            * transpose(Z);
        end if;

      elseif n == 1 and m == 1 then
        // 简单标量方程
        X[1,1] := C[1,1] / (A[1,1] * B[1,1] + sgn);
      else
        X := fill(
          0, 
          0, 
          0);
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
X = Matrices.<strong>discreteSylvester</strong>(A, B, C);
X = Matrices.<strong>discreteSylvester</strong>(A, B, C, AisHess, BTisSchur, sgn, eps);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>discreteSylvester</strong>计算离散时间Sylvester方程的解<strong>X</strong>
</p>

<blockquote><pre>
<strong>A</strong>*<strong>X</strong>*<strong>B</strong> + sgn*<strong>X</strong> = <strong>C</strong>.
</pre></blockquote>

<p>
其中sgn = 1或sgn = -1。该算法采用Golub等人[1]提出的Hessenberg-Schur方法。
当sgn = -1时，离散Sylvester方程又称Stein方程:
</p>

<blockquote><pre>
<strong>A</strong>*<strong>X</strong>*<strong>B</strong> - <strong>X</strong> + <strong>Q</strong> = <strong>0</strong>.
</pre></blockquote>

<p>
简而言之，问题被简化为相应的问题
</p>
<blockquote><pre>
<strong>H</strong>*<strong>Y</strong>*<strong>S</strong>' + sgn*<strong>Y</strong> = <strong>F</strong>.
</pre></blockquote>

<p>
其中<strong>H</strong>=<strong>U</strong>'*<strong>A</strong>*<strong>U</strong>是<strong>A</strong>的Hessenberg形式，而<strong>S</strong>=<strong>V</strong>'*<strong>B</strong>'*<strong>V</strong>是<strong>B</strong>'的实Schur形式，
<strong>F</strong>=<strong>U</strong>'*<strong>C</strong>*<strong>V</strong>和<strong>Y</strong>=<strong>U</strong>*<strong>X</strong>*<strong>V</strong>”是<strong>C</strong>和<strong>X</strong>的适当变换。
这个问题通过利用<strong>S</strong>和<strong>H</strong>的特定形式依次解决。
最后恢复原问题的解为<strong>X</strong>=<strong>U</strong>'*<strong>Y</strong>*<strong>V</strong>。
布尔输入\"AisHess\"和\"BTisSchur\"表示在<strong>A</strong>和/或<strong>B</strong>分别具有Hessenberg形式或Schur形式的情况下，分别省略到Hessenberg形式或Schur形式的一个或两个变换。
</p>

<h4>参考文献</h4>
<blockquote><pre>
[1] Golub, G.H., Nash, S. and Van Loan, C.F.
  A Hessenberg-Schur method for the problem AX + XB = C.
  IEEE Transaction on Automatic Control, AC-24, no. 6, pp. 909-913, 1979.
</pre></blockquote>

<h4>示例</h4>
<blockquote><pre>
A = [1.0,   2.0,   3.0;
   6.0,   7.0,   8.0;
   9.0,   2.0,   3.0];

B = [7.0,   2.0,   3.0;
   2.0,   1.0,   2.0;
   3.0,   4.0,   1.0];

C = [271.0,   135.0,   147.0;
   923.0,   494.0,   482.0;
   578.0,   383.0,   287.0];

X = discreteSylvester(A, B, C);

results in:
X = [2.0,   3.0,   6.0;
   4.0,   7.0,   1.0;
   5.0,   3.0,   2.0];

</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">Matrices.continuousSylvester</a>,
<a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">Matrices.discreteLyapunov</a>
</p>

</html>"                    , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"                    ));
    end discreteSylvester;

    function discreteRiccati 
      "返回离散时间代数Riccati方程A'*X*A - X - A'*X*B*inv(R + B'*X*B)*B'*X*A + Q = 0的解"
      extends Modelica.Icons.Function;
      import Modelica.Math.Matrices;
      input Real A[:,size(A, 1)] "DARE中的方阵A";
      input Real B[size(A, 1),:] "DARE中的矩阵B";
      input Real R[size(B, 2),size(B, 2)] = identity(size(B, 2)) 
        "DARE中的矩阵R";
      input Real Q[size(A, 1),size(A, 1)] = identity(size(A, 1)) 
        "DARE中的矩阵Q";
      input Boolean refine = false "为后续细化";

    protected
      constant Integer n = size(A, 1);
      Real G[size(A, 1),size(A, 1)] = B * Matrices.solve2(R, transpose(B));
      Real AT[size(A, 1),size(A, 1)] = transpose(A);
      Real LU[size(A, 1),size(A, 1)];
      Integer p[size(A, 1)];
      Real H[2 * size(A, 1),2 * size(A, 1)];
      Real H11[size(A, 1),size(A, 1)];
      Real H12[size(A, 1),size(A, 1)];
      Real H21[size(A, 1),size(A, 1)];
      Real H22[size(A, 1),size(A, 1)];
      Real H_RSF[2 * size(A, 1),2 * size(A, 1)];
      Real Z[size(H, 1),size(H, 2)];
      Real Z11[size(A, 1),size(A, 2)];
      Real Z21[size(A, 1),size(A, 2)];

      Integer info;

    public
      output Real X[size(A, 1),size(A, 2)] 
        "与有序rsf相关的舒尔向量的正交矩阵";
      output Real alphaReal[2 * size(A, 1)] 
        "eigenvalue=alphaReal+i*alphaImag的实部";
      output Real alphaImag[2 * size(A, 1)] 
        "eigenvalue=alphaReal+i*alphaImag的虚部";
    algorithm
      (LU,p) := Modelica.Math.Matrices.LU(AT);
      H21 := Modelica.Math.Matrices.LU_solve2(
        LU, 
        p, 
        -Q);
      H22 := Modelica.Math.Matrices.LU_solve2(
        LU, 
        p, 
        identity(n));
      (LU,p) := Modelica.Math.Matrices.LU(A);
      H12 := Modelica.Math.Matrices.LU_solve2(
        LU, 
        p, 
        -G);
      H12 := transpose(H12);
      H11 := A - H12 * Q;
      H := [H11, H12; H21, H22];
      (H_RSF,Z,alphaReal,alphaImag) := Modelica.Math.Matrices.realSchur(H);
      // 把H化成舒尔式
      (H_RSF,Z,alphaReal,alphaImag) := Matrices.Utilities.reorderRSF(
        H_RSF, 
        Z, 
        alphaReal, 
        alphaImag, 
        false);
      // 有序舒尔形式
      Z11 := Z[1:n,1:n];
      Z21 := Z[n + 1:2 * n,1:n];
      if size(Z11, 1) > 0 then
        //  X := transpose(Matrices.solve2(transpose(Z11), transpose(Z21)));
        (X,info) := Matrices.LAPACK.dgesvx(Z11, transpose(Z21));
        //函数不需要像solve2那样对Z11进行转置
        X := transpose(X);
        assert(info == 0, "求解一个带函数的线性方程组
\"Matrices.LAPACK.dgesvx\"是不可能的，因为系统有
无解或无穷多解(输入A为奇异)."            );

        if refine then
          X := Modelica.Math.Matrices.Utilities.discreteRiccatiIterative(
            A, 
            B, 
            R, 
            Q, 
            X);
        end if;
      else
        X := fill(
          0, 
          size(Z21, 1), 
          size(Z11, 1));
      end if;

      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
                      X = Matrices.<strong>discreteRiccati</strong>(A, B, R, Q);
(X, alphaReal, alphaImag) = Matrices.<strong>discreteRiccati</strong>(A, B, R, Q, true);
</pre></blockquote>

<h4>描述</h4>

<p>
函数<strong>discreteRiccati</strong>计算离散时间代数Riccati方程的解<strong>X</strong>
</p>

<blockquote><pre>
<strong>A</strong>'*<strong>X</strong>*<strong>A</strong> - <strong>X</strong> - <strong>A</strong>'*<strong>X</strong>*<strong>B</strong>*inv(<strong>R</strong> + <strong>B</strong>'*<strong>X</strong>*<strong>B</strong>)*<strong>B</strong>'*<strong>X</strong>*<strong>A</strong> + <strong>Q</strong> = <strong>0</strong>
</pre></blockquote>

<p>
使用Laub提出的Schur向量方法[1]。
</p>

<p>
假设<strong>Q</strong>是对称的正半定的，<strong>R</strong>是对称的非奇异的正定的，
(<strong>A</strong>，<strong>B</strong>)是稳定的，(<strong>A</strong>，<strong>Q</strong>)是可检测的。使用这种方法，<strong>A</strong>也必须是可逆的.
</p>

<p>
<strong>在这个函数中没有检查这些假设!!!</strong>
</p>

<p>
这个假设保证了哈密顿矩阵。
</p>
<blockquote><pre>
<strong>H</strong> = [<strong>A</strong> + <strong>G</strong>*<strong>T</strong>*<strong>Q</strong>, -<strong>G</strong>*<strong>T</strong>; -<strong>T</strong>*<strong>Q</strong>, <strong>T</strong>]
</pre></blockquote>
<p>
和
</p>
<blockquote><pre>
   -T
<strong>T</strong> = <strong>A</strong>
</pre></blockquote>

<p>
和
</p>

<blockquote><pre>
     -1
<strong>G</strong> = <strong>B</strong>*<strong>R</strong> *<strong>B</strong>'
</pre></blockquote>

<p>
没有特征值位于单位圆上，并且可以转换为有序的实Schur形式
</p>

<blockquote><pre>
<strong>U</strong>'*<strong>H</strong>*<strong>U</strong> = <strong>S</strong> = [<strong>S11</strong>, <strong>S12</strong>; <strong>0</strong>, <strong>S22</strong>]
</pre></blockquote>

<p>
正交相似变换<strong>U</strong>.<strong>S</strong>排序如下:
<strong>S11</strong>包含有系统矩阵的闭环系统的n个稳定特征值
</p>

<blockquote><pre>
                -1
<strong>A</strong> - <strong>B</strong>*(<strong>R</strong> + <strong>B</strong>'*<strong>X</strong>*<strong>B</strong>)  *<strong>B</strong>'*<strong>X</strong>*<strong>A</strong>
</pre></blockquote>

<p>
如果<strong>U</strong>被分区为
</p>

<blockquote><pre>
<strong>U</strong> = [<strong>U11</strong>, <strong>U12</strong>; <strong>U21</strong>, <strong>U22</strong>]
</pre></blockquote>

<p>
根据<strong>S</strong>，解<strong>X</strong>可计算为
</p>

<blockquote><pre>
<strong>X</strong>*<strong>U11</strong> = <strong>U21</strong>.
</pre></blockquote>

<h4>参考文献</h4>
<blockquote><pre>
[1] Laub, A.J.
  A Schur Method for Solving Algebraic Riccati equations.
  IEEE Trans. Auto. Contr., AC-24, pp. 913-921, 1979.
</pre></blockquote>

<h4>示例</h4>
<blockquote><pre>
A  = [4.0    3.0]
   -4.5,  -3.5];

B  = [ 1.0;
    -1.0];

R = [1.0];

Q = [9.0, 6.0;
   6.0, 4.0]

X = discreteRiccati(A, B, R, Q);

results in:

X = [14.5623, 9.7082;
    9.7082, 6.4721];
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">Matrices.continuousRiccati</a>
</p>
</html>"            , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"            ));
    end discreteRiccati;

    function sort 
      "按升序或降序对矩阵的行或列进行排序"
      extends Modelica.Icons.Function;
      input Real M[:,:] "待排序矩阵";
      input Boolean sortRows = true "= true，如果行被排序，否则为列";
      input Boolean ascending = true 
        "= true，如果是升序，否则是降序";
      output Real sorted_M[size(M, 1),size(M, 2)] = M "排序矩阵";
      output Integer indices[if sortRows then size(M, 1) else size(M, 2)] 
        "sorted_M = if sortRows then M[indices,:] else M[:,indices]";

      /* shellsort算法;应该在以后改进 */
    protected
      Integer gap;
      Integer i;
      Integer j;
      Real wM2[size(M, 2)];
      Integer wi;
      Integer nM1 = size(M, 1);
      Boolean swap;
      Real sorted_MT[size(M, 2),size(M, 1)];

    public
      encapsulated function greater "比较向量v1是否大于v2"
        import Modelica;
        extends Modelica.Icons.Function;
        import Modelica.Utilities.Types.Compare;
        input Real v1[:];
        input Real v2[size(v1, 1)];
        output Boolean result;
      protected
        Integer n = size(v1, 1);
        Integer i = 1;
        annotation();
      algorithm
        result := false;
        while i <= n loop
          if v1[i] > v2[i] then
            result := true;
            i := n;
          elseif v1[i] < v2[i] then
            i := n;
          end if;
          i := i + 1;
        end while;
      end greater;

    encapsulated function less "比较向量v1是否小于v2"
        import Modelica;
        extends Modelica.Icons.Function;
        import Modelica.Utilities.Types.Compare;
        input Real v1[:];
        input Real v2[size(v1, 1)];
        output Boolean result;
      protected
        Integer n = size(v1, 1);
        Integer i = 1;
      annotation();
      algorithm
        result := false;
        while i <= n loop
          if v1[i] < v2[i] then
            result := true;
            i := n;
          elseif v1[i] > v2[i] then
            i := n;
          end if;
          i := i + 1;
        end while;
      end less;
    algorithm
      if not sortRows then
        (sorted_MT,indices) := sort(transpose(M), ascending = ascending);
        sorted_M := transpose(sorted_MT);
      else
        indices := 1:size(M, 1);
        gap := div(nM1, 2);
        while gap > 0 loop
          i := gap;
          while i < nM1 loop
            j := i - gap;
            if j >= 0 then
              if ascending then
                swap := greater(sorted_M[j + 1,:], sorted_M[j + gap + 1,:]);
              else
                swap := less(sorted_M[j + 1,:], sorted_M[j + gap + 1,:]);
              end if;
            else
              swap := false;
            end if;

            while swap loop
              wM2 := sorted_M[j + 1,:];
              wi := indices[j + 1];
              sorted_M[j + 1,:] := sorted_M[j + gap + 1,:];
              sorted_M[j + gap + 1,:] := wM2;
              indices[j + 1] := indices[j + gap + 1];
              indices[j + gap + 1] := wi;
              j := j - gap;
              if j >= 0 then
                if ascending then
                  swap := greater(sorted_M[j + 1,:], sorted_M[j + gap + 1,:]);
                else
                  swap := less(sorted_M[j + 1,:], sorted_M[j + gap + 1,:]);
                end if;
              else
                swap := false;
              end if;
            end while;
            i := i + 1;
          end while;
          gap := div(gap, 2);
        end while;
      end if;
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
         sorted_M = Matrices.<strong>sort</strong>(M);
(sorted_M, indices) = Matrices.<strong>sort</strong>(M, sortRows=true, ascending=true);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>sort</strong>(…)对实矩阵M的行进行升序排序，并将结果返回为sorted_M。
如果可选参数\"sortRows\"为<strong>false</strong>，则矩阵的列会被排序。
如果可选参数\"ascending\"为<strong>false</strong>，则行或列将按降序排序。
在可选的第二个输出参数中，给出与原始矩阵对应的排序行或列的索引，使得
</p>

<blockquote><pre>
sorted_M = <strong>if</strong> sortedRow <strong>then</strong> M[indices,:] <strong>else</strong> M[:,indices];
</pre></blockquote>

<h4>示例</h4>
<blockquote><pre>
(M2, i2) := Matrices.sort([2, 1,  0;
                         2, 0, -1]);
   -> M2 = [2, 0, -1;
            2, 1, 0 ];
      i2 = {2,1};
</pre></blockquote>
</html>"            ));
    end sort;

    function flipLeftRight "在左/右方向翻转矩阵的列"
      extends Modelica.Icons.Function;
      input Real A[:,:] "要翻转的矩阵";
      output Real Aflip[size(A, 1),size(A, 2)] "翻转矩阵";
    algorithm
      Aflip := A[:,{i for i in size(A, 2):-1:1}];

      annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
A_flr = Matrices.<strong>flipLeftRight</strong>(A);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>flipLeftRight</strong>从矩阵<strong>A</strong>计算出一个翻转列的矩阵<strong>A_flr</strong>，即<strong>A_flr</strong>[:，i]=<strong>A</strong>[:，n-i+1], i=1，…n。
</p>

<h4>示例</h4>
<blockquote><pre>
A = [1, 2,  3;
   3, 4,  5;
  -1, 2, -3];

A_flr = flipLeftRight(A);

results in:

A_flr = [3, 2,  1;
       5, 4,  3;
      -3, 2, -1]
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.flipUpDown\">Matrices.flipUpDown</a>
</p>

</html>"                , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"                ));
    end flipLeftRight;

    function flipUpDown "在上/下方向翻转矩阵的行"
      extends Modelica.Icons.Function;
      input Real A[:,:] "要翻转的矩阵";
      output Real Aflip[size(A, 1),size(A, 2)] "翻转矩阵";
    algorithm
      Aflip := A[{i for i in size(A, 1):-1:1},:];

      annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
A_fud = Matrices.<strong>flipUpDown</strong>(A);
</pre></blockquote>

<h4>描述</h4>
<p>
函数<strong>flipUpDown</strong>从矩阵<strong>A</strong>计算出具有翻转行的矩阵<strong>A_fud</strong>，即<strong>A_fud</strong>[i,:]=<strong>A</strong>[n-i+1,:], i=1,..., n。
</p>

<h4>示例</h4>
<blockquote><pre>
A = [1, 2,  3;
   3, 4,  5;
  -1, 2, -3];

A_fud = flipUpDown(A);

results in:

A_fud  = [-1, 2, -3;
         3, 4,  5;
         1, 2,  3]
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.flipLeftRight\">Matrices.flipLeftRight</a>
</p>

</html>"                , revisions = "<html>
<ul>
<li><em>2010/05/31 </em>
     by Marcus Baur, DLR-RM</li>
</ul>
</html>"                ));
    end flipUpDown;

    package LAPACK 
      "LAPACK库的接口(通常不应该直接使用，而只能通过Modelica.Math.Matrices间接使用)"
      extends Modelica.Icons.FunctionsPackage;

      pure function dgeev 
        "计算实非对称矩阵A的特征值和(右)特征向量"

        extends Modelica.Icons.Function;
        input Real A[:,size(A, 1)];
        output Real eigenReal[size(A, 1)] "特征值的实部";
        output Real eigenImag[size(A, 1)] "特征值的虚部";
        output Real eigenVectors[size(A, 1),size(A, 1)] "右特征向量";
        output Integer info;
      protected
        Real dummy[1,1];
        Integer n = size(A, 1);
        Integer lwork = 12 * n;
        Integer ldvl = 1;
        Real Awork[size(A, 1),size(A, 1)] = A;
        Real work[12 * size(A, 1)];

      external "FORTRAN 77" dgeev(
        "N", 
        "V", 
        n, 
        Awork, 
        n, 
        eigenReal, 
        eigenImag, 
        dummy, 
        ldvl, 
        eigenVectors, 
        n, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "这个函数不是LAPACK函数gegev的完整接口,
但是这样称呼它只有特征值和正确的特征向量
计算.

Lapack文档
目的
=======

geev计算一个n × n实非对称矩阵A
特征值和(可选的)左和/或右特征向量.

A的右特征向量v(j)满足
               A * v(j) = lambda(j) * v(j)
其中(j)是它的特征值。
A的左特征向量u(j)满足
            u(j)**H * A = lambda(j) * u(j)**H
其中u(j)**H表示u(j)的共轭转置.

将计算得到的特征向量归一化，使其具有欧氏范数
等于1，最大分量是实数.

参数
=========

JOBVL   (input) CHARACTER*1
      = 'N': A的左特征向量不计算;
      = 'V': 计算A的左特征向量.

JOBVR   (input) CHARACTER*1
      = 'N': A的右特征向量不计算;
      = 'V': 计算A的右特征向量.

N       (input) INTEGER
      矩阵a的阶数N >= 0.

A       (输入/输出)双精度数组，尺寸(LDA,N)
在入口，n × n矩阵A。
在退出时，A已被覆盖.

LDA     (输入)的整数
数组a的首维数LDA >= max(1,N).

WR      (输出)双精度数组，尺寸(N)
WI      (输出)双精度数组，尺寸(N)
      WR和WI包含实部和虚部，
分别为计算出的特征值。复杂的
特征值共轭对连续出现
特征值有正虚部
第一个.

VL      (输出)DOUBLE PRECISION数组，维度(LDVL,N)
如果JOBVL = 'V'，则左特征向量u(j)存储为1
在VL的列中一个接一个，以相同的顺序
作为它们的特征值。
如果JOBVL = 'N'，则不引用VL。
如果第j个特征值是实数，则u(j) = VL(:，j)，
VL的第j列。
如果第j个和(j+1)-st个特征值形成一个复形
则u(j) = VL(:，j) + i*VL(:，j+1
u(j+1) = VL(:，j) - i*VL(:，j+1).

LDVL    (输入)的整数
数组VL的前导维数。LDVL >= 1;如果
Jobvl = ' v '， LDVL >= n.

VR      (输出)双精度数组，尺寸(LDVR,N)
如果JOBVR = 'V'，则正确的特征向量V (j)存储为1
在VR的列中，以相同的顺序，一个接一个
作为它们的特征值。
如果JOBVR = 'N'，则不引用VR。
若第j个特征值为实数，则v(j) = VR(:，j);
VR的第j列。
如果第j个和(j+1)-st个特征值形成一个复形
则v(j) = VR(:，j) + i*VR(:，j+1
v(j+1) = VR(:，j) - i*VR(:，j+1).

LDVR    (输入)的整数
阵列VR的首维。LDVR >= 1;如果
Jobvr = ' v '， LDVR >= n.

WORK    (工作空间/输出)双精度数组，尺寸(MAX(1,LWORK))
在退出时，如果INFO = 0, WORK(1)返回最优LWORK.

LWORK   (输入)的整数
数组的尺寸为WORK。LWORK >= max(1,3*N)
如果JOBVL = 'V'或JOBVR = 'V'，则LWORK >= 4*N。为好
性能，LWORK一般必须更大.

      如果LWORK = -1，则假定存在一个工作空间查询;例程
只计算WORK数组的最佳大小，返回
这个值作为WORK数组的第一个条目，没有错误
与LWORK相关的消息由XERBLA发出.

INFO    (输出)的整数
      = 0:  成功的退出
      < 0:  如果INFO = -i，则第i个参数具有非法值.
      > 0:  如果INFO = i, QR算法计算所有的失败
特征值，没有计算特征向量;
元素i+1: WR和WI的N包含特征值有聚合.
"    ));
      end dgeev;

      pure function dgeev_eigenValues 
        "计算实非对称矩阵A的特征值"

        extends Modelica.Icons.Function;
        input Real A[:,size(A, 1)];
        output Real EigenReal[size(A, 1)];
        output Real EigenImag[size(A, 1)];

        /*
        输出实特征向量[size(A, 1)， size(A, 1)]= 0 (size(A, 1)， size(
        , 1)); */
        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer lwork = 8 * n;
        Real Awork[size(A, 1),size(A, 1)] = A;
        Real work[8 * size(A, 1)];
        Real EigenvectorsL[size(A, 1),size(A, 1)] = zeros(size(A, 1), size(A, 1));

      /*
      外部“FORTRAN 77”geev(“N”，“V”，N, Awork, N，
      EigenReal, eigenimage, EigenvectorsL, n，
      特征向量，n, work, lwork, info)
      */
      external "FORTRAN 77" dgeev(
        "N", 
        "N", 
        n, 
        Awork, 
        n, 
        EigenReal, 
        EigenImag, 
        EigenvectorsL, 
        n, 
        EigenvectorsL, 
        n, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");

      annotation(Documentation(info = "Lapack文档
目的
=======

geev计算一个n × n实非对称矩阵A
特征值和(可选的)左和/或右特征向量.

A的右特征向量v(j)满足
               A * v(j) = lambda(j) * v(j)
(j)是它的特征值.
A的左特征向量u(j)满足
            u(j)**H * A = lambda(j) * u(j)**H
其中u(j)**H表示u(j)的共轭转置.

将计算得到的特征向量归一化，使其具有欧氏范数
等于1，最大分量是实数.

参数
=========

JOBVL   (输入) CHARACTER*1
      = 'N': A的左特征向量不计算;
      = 'V': 计算A的左特征向量.

JOBVR   (输入) CHARACTER*1
      = 'N': A的右特征向量不计算;
      = 'V': 计算A的右特征向量.

N       (输入) INTEGER
      矩阵a的阶数N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      在入口，n × n矩阵A.
      在退出时，A已被覆盖.

LDA     (输入) INTEGER
      数组a的首维数LDA >= max(1,N).

WR      (输出) DOUBLE PRECISION array, dimension (N)
WI      (输出) DOUBLE PRECISION array, dimension (N)
      WR和WI包含实部和虚部，
分别为计算出的特征值。复杂的
特征值共轭对连续出现
特征值有正虚部
第一个.

VL      (输出) DOUBLE PRECISION array, dimension (LDVL,N)
      如果JOBVL = 'V'，则左特征向量u(j)存储为1
在VL的列中一个接一个，以相同的顺序
作为它们的特征值。
如果JOBVL = 'N'，则不引用VL。
如果第j个特征值是实数，则u(j) = VL(:，j)，
VL的第j列。
如果第j个和(j+1)-st个特征值形成一个复形
则u(j) = VL(:，j) + i*VL(:，j+1
u(j+1) = VL(:，j) - i*VL(:，j+1).

LDVL    (输入) INTEGER
      数组VL的前导维数。LDVL >= 1;如果
Jobvl = ' v '， LDVL >= n.

VR      (输出) DOUBLE PRECISION array, dimension (LDVR,N)
      如果JOBVR = 'V'，则正确的特征向量V (j)存储为1
在VR的列中，以相同的顺序，一个接一个
作为它们的特征值。
如果JOBVR = 'N'，则不引用VR。
若第j个特征值为实数，则v(j) = VR(:，j);
VR的第j列。
如果第j个和(j+1)-st个特征值形成一个复形
则v(j) = VR(:，j) + i*VR(:，j+1
v(j+1) = VR(:，j) - i*VR(:，j+1).

LDVR    (输入) INTEGER
      阵列VR的首维。LDVR >= 1;如果
Jobvr = ' v '， LDVR >= n.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      在退出时，如果INFO = 0, WORK(1)返回最优LWORK.

LWORK   (输入) INTEGER
      数组的尺寸为WORK。LWORK >= max(1,3*N)
如果JOBVL = 'V'或JOBVR = 'V'，则LWORK >= 4*N。为好
性能，LWORK一般必须更大.

      如果LWORK = -1，则假定存在一个工作空间查询;例程
只计算WORK数组的最佳大小，返回
这个值作为WORK数组的第一个条目，没有错误
与LWORK相关的消息由XERBLA发出.

INFO    (输出) INTEGER
      = 0:  成功的退出
      < 0:  如果INFO = -i，则第i个参数具有非法值.
      > 0:  如果INFO = i, QR算法计算所有的失败
特征值，没有计算特征向量;
元素i+1: WR和WI的N包含特征值
有聚合.
"    ));
      end dgeev_eigenValues;

      pure function dgelsy 
        "计算一个缺秩a的实线性最小二乘问题的最小范数解"

        extends Modelica.Icons.Function;
        input Real A[:,:];
        input Real B[size(A, 1),:];
        input Real rcond = 0.0 "估计秩的倒数条件数";
        output Real X[max(size(A, 1), size(A, 2)),size(B, 2)] = cat(
          1, 
          B, 
          zeros(max(nrow, ncol) - nrow, nrhs)) 
          "解决方案是第一个大小(A,2)行的";
        output Integer info;
        output Integer rank "A的有效等级";
      protected
        Integer nrow = size(A, 1);
        Integer ncol = size(A, 2);
        Integer nx = max(nrow, ncol);
        Integer nrhs = size(B, 2);
        Integer lwork = max(min(nrow, ncol) + 3 * ncol + 1, 2 * min(nrow, ncol) + nrhs);
        Real work[max(min(size(A, 1), size(A, 2)) + 3 * size(A, 2) + 1, 2 * min(size(A, 1), size(A, 2)) + size(B, 2))];
        Real Awork[size(A, 1),size(A, 2)] = A;
        Integer jpvt[size(A, 2)] = zeros(ncol);

      external "FORTRAN 77" dgelsy(
        nrow, 
        ncol, 
        nrhs, 
        Awork, 
        nrow, 
        X, 
        nx, 
        jpvt, 
        rcond, 
        rank, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack文档
目的
=======

DGELSY计算实线性最小值的最小范数解
广场的问题:
  minimize || A * X - B ||
利用a的完全正交分解。a是一个m × n矩阵
矩阵可能是秩不足的.

右边的几个向量b和解向量x可以是
在一次呼叫中处理的;的列存储
右边的m × nrhs矩阵B和n × nrhs解
矩阵X.

该例程首先计算具有列枢轴的QR分解:
  A * P = Q * [ R11 R12 ]
              [  0  R22 ]
其中R11定义为最大的前导子矩阵，其估计
条件数小于1/RCOND。R11的顺序，RANK，
A的有效秩是多少.

那么R22可以忽略不计，R12被湮灭
通过从右边开始的正交变换，得到
完全正交分解:
 A * P = Q * [ T11 0 ] * Z
             [  0  0 ]
最小范数解是
 X = P * Z' [ inv(T11)*Q1'*B ]
            [        0       ]
其中Q1由Q的第一个RANK列组成.

这个例程与最初的xGELSX基本相同，只是
三个不同点:
o 对子例程xGEQPF的调用已被
对子程序xGEQP3的调用。这个子程序是Blas-3
带有列枢轴的QR分解的版本.
o 矩阵B(右手边)更新为Blas-3.
o 矩阵B(右边)的排列更快，而且更简单.

参数
=========

M       (输入) INTEGER
      矩阵a的行数M >= 0.

N       (输入) INTEGER
      矩阵a的列数N >= 0.

NRHS    (输入) INTEGER
      右手边的个数，也就是NRHS >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      在入口，m × n矩阵A。退出时，A已被其完全正交分解.

LDA     (输入) INTEGER
      数组a的首维数LDA >= max(1,M).

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
      在进入时，m × nrhs右边的矩阵B。在出口，n乘nrhs解矩阵X.

LDB     (输入) INTEGER
      数组b的前导维数LDB >= max(1,M,N).

JPVT    (输入/输出) INTEGER array, dimension (N)
      在入职时，如果JPVT(i) .ne。0, A的第i列被排列
到AP的前面，否则第i列是自由列。
在退出时，如果JPVT(i) = k，则AP的第i列
A的第k列是什么.

RCOND   (输入) DOUBLE PRECISION
      RCOND用于确定A的有效秩，其中
定义为最大导三角形的阶数
以A为枢轴的QR分解中的子矩阵R11，
其估计状态数< 1/RCOND.

RANK    (输出) INTEGER
      A的有效秩，即子矩阵的阶
R11来。这和子矩阵T11的阶是一样的
A的完全正交分解.

WORK    (工作空间/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      在退出时，如果INFO = 0, WORK(1)返回最优LWORK.

LWORK   (输入) INTEGER
      数组的尺寸为WORK。
畅通战略要求这样做:
         LWORK >= MAX( MN+3*N+1, 2*MN+NRHS ),
      其中 MN = min( M, N ).
      块算法要求这样:
         LWORK >= MAX( MN+2*N+NB*(N+1), 2*MN+NB*NRHS ),
      其中NB是返回块大小的上界
例程DGEQP3, DTZRZF, STZRQF, DORMQR，
和DORMRZ.

      如果LWORK = -1，则假定存在一个工作空间查询;例程
只计算WORK数组的最佳大小，返回
这个值作为WORK数组的第一个条目，没有错误
与LWORK相关的消息由XERBLA发出.

INFO    (输出) INTEGER
      = 0: 成功的退出
      < 0: If INFO = -i, 第i个参数的值是非法的.
"    ));
      end dgelsy;

      pure function dgelsy_vec 
        "计算一个缺秩a的实线性最小二乘问题的最小范数解"

        extends Modelica.Icons.Function;
        input Real A[:,:];
        input Real b[size(A, 1)];
        input Real rcond = 0.0 "估计秩的倒数条件数";
        output Real x[max(size(A, 1), size(A, 2))] = cat(
          1, 
          b, 
          zeros(max(nrow, ncol) - nrow)) 
          "解决方案是在第一个大小(A,2)行";
        output Integer info;
        output Integer rank "A的有效等级";
      protected
        Integer nrow = size(A, 1);
        Integer ncol = size(A, 2);
        Integer nrhs = 1;
        Integer nx = max(nrow, ncol);
        Integer lwork = max(min(nrow, ncol) + 3 * ncol + 1, 2 * min(nrow, ncol) + 1);
        Real work[max(min(size(A, 1), size(A, 2)) + 3 * size(A, 2) + 1, 2 * min(size(A, 1), size(A, 2)) + 1)];
        Real Awork[size(A, 1),size(A, 2)] = A;
        Integer jpvt[size(A, 2)] = zeros(ncol);

      external "FORTRAN 77" dgelsy(
        nrow, 
        ncol, 
        nrhs, 
        Awork, 
        nrow, 
        x, 
        nx, 
        jpvt, 
        rcond, 
        rank, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack文档
目的
=======

DGELSY计算实线性最小值的最小范数解
广场的问题:
  minimize || A * X - B ||
利用a的完全正交分解。a是一个m × n矩阵
矩阵可能是秩不足的.

右边的几个向量b和解向量x可以是
在一次呼叫中处理的;的列存储
右边的m × nrhs矩阵B和n × nrhs解
矩阵X.

该例程首先计算具有列枢轴的QR分解:
  A * P = Q * [ R11 R12 ]
              [  0  R22 ]
其中R11定义为最大的前导子矩阵，其估计
条件数小于1/RCOND。R11的顺序，RANK，
A的有效秩是多少.

那么R22可以忽略不计，R12被湮灭
通过从右边开始的正交变换，得到
完全正交分解:
 A * P = Q * [ T11 0 ] * Z
             [  0  0 ]
minimum-norm解决方案
 X = P * Z' [ inv(T11)*Q1'*B ]
            [        0       ]
其中Q1由Q的第一个RANK列组成.

这个例程与最初的xGELSX基本相同，只是
三个不同点:
o 对子例程xGEQPF的调用已被
对子程序xGEQP3的调用。这个子程序是Blas-3
带有列枢轴的QR分解的版本.
o 矩阵B(右手边)更新为Blas-3.
o 矩阵B(右边)的排列更快，而且
更简单.

参数
=========

M       (输入) INTEGER
      矩阵a的行数M >= 0.

N       (输入) INTEGER
      矩阵a的列数N >= 0.

NRHS    (输入) INTEGER
      右手边的个数，也就是NRHS >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      在入口，m × n矩阵A。
退出时，A已被其
完全正交分解.

LDA     (输入) INTEGER
      数组a的首维数LDA >= max(1,M).

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
      在进入时，m × nrhs右边的矩阵B。
在出口，n乘nrhs解矩阵X.

LDB     (输入) INTEGER
      数组b的前导维数LDB >= max(1,M,N).

JPVT    (输入/输出) INTEGER array, dimension (N)
      在入职时，如果JPVT(i) .ne。0, A的第i列被排列
到AP的前面，否则第i列是自由列。
在退出时，如果JPVT(i) = k，则AP的第i列
A的第k列是什么.

RCOND   (输入) DOUBLE PRECISION
      RCOND用于确定A的有效秩，其中
定义为最大导三角形的阶数
以A为枢轴的QR分解中的子矩阵R11，
其估计状态数< 1/RCOND.

RANK    (输出) INTEGER
      A的有效秩，即子矩阵的阶
R11来。这和子矩阵T11的阶是一样的
A的完全正交分解.

WORK    (工作空间/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      在退出时，如果INFO = 0, WORK(1)返回最优LWORK.

LWORK   (输入) INTEGER
      数组的尺寸为WORK。
畅通战略要求这样做:
         LWORK >= MAX( MN+3*N+1, 2*MN+NRHS ),
      其中 MN = min( M, N ).
      块算法要求这样:
         LWORK >= MAX( MN+2*N+NB*(N+1), 2*MN+NB*NRHS ),
      其中NB是返回块大小的上界
例程DGEQP3, DTZRZF, STZRQF, DORMQR，
和DORMRZ.

      如果LWORK = -1，则假定存在一个工作空间查询;例程
只计算WORK数组的最佳大小，返回
这个值作为WORK数组的第一个条目，没有错误
与LWORK相关的消息由XERBLA发出.

INFO    (输出) INTEGER
      = 0: 成功的退出
      < 0: 如果INFO = -i，则第i个参数具有非法值.
"    ));
      end dgelsy_vec;

      pure function dgels_vec 
        "用b向量求解过定或欠定实线性方程A*x=b"

        extends Modelica.Icons.Function;
        input Real A[:,:];
        input Real b[size(A, 1)];
        output Real x[max(size(A, 1), size(A, 2))] = cat(
          1, 
          b, 
          zeros(nx - nrow)) "Solution is in first size(A,2) rows";
        output Integer info;
      protected
        Integer nrow = size(A, 1);
        Integer ncol = size(A, 2);
        Integer nrhs = 1;
        Integer nx = max(nrow, ncol);
        Integer lwork = min(nrow, ncol) + nx;
        Real work[size(A, 1) + size(A, 2)];
        Real Awork[size(A, 1),size(A, 2)] = A;

      external "FORTRAN 77" dgels(
        "N", 
        nrow, 
        ncol, 
        nrhs, 
        Awork, 
        nrow, 
        x, 
        nx, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack文档
目的
=======

DGELS解决了过定或欠定的真实线性系统
涉及到一个m × n矩阵A，或它的转置，用QR或LQ
假设A是满秩的.

提供了以下选项:

1. If TRANS = 'N'且m >= N:求最小二乘解
一个超定系统，即求解最小二乘问题
              minimize || B - A*X ||.

2. 如果TRANS = 'N'且m < N:求的最小范数解
待定系统A * X = B.

3. 如果TRANS = 'T'且m >= n:求的最小范数解
待定系统A**T * X = B.

4. 如果TRANS = 'T'且m < n:求最小二乘解
一个超定系统，即求解最小二乘问题
              minimize || B - A**T * X ||.

右边的几个向量b和解向量x可以是
在一次呼叫中处理的;的列存储
右边的m × nrhs矩阵B和n × nrhs解
矩阵X.

参数
=========

TRANS   (输入) CHARACTER*1
      = 'N': 线性系统包含A;
      = 'T': 线性系统涉及A**T.

M       (输入) INTEGER
      矩阵a的行数M >= 0.

N       (输入) INTEGER
      矩阵a的列数N >= 0.

NRHS    (输入) INTEGER
      右手边的个数，也就是NRHS >=0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      在入口，m × n矩阵A。
在退出时,
        if M >= N, A被其QR的细节所覆盖
由DGEQRF返回的因子分解;
        if M <  N, A被其LQ的详细信息覆盖
由DGELQF返回的因子分解.

LDA     (输入) INTEGER
      数组a的首维数LDA >= max(1,M).

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
      在入口，矩阵B的右边向量，存储
columnwise;如果TRANS = 'N'，则B是M-by-NRHS，或N-by- nrhs
      if TRANS = 'T'.
      退出时，如果INFO = 0, B将被解覆盖
向量，按列存储:
      if TRANS = 'N' and m >= n, B的第1到第n行包含最小值
平方解向量;的残差平方和
每一列的解由的平方和给出
这列中N+1到M的元素;
      if TRANS = 'N' and m < n, B的第1 ~ N行包含
最小范数解向量;
      if TRANS = 'T' and m >= n, B的第1到M行包含
最小范数解向量;
      if TRANS = 'T' and m < n, B的第1到M行包含
最小二乘解向量;残差平方和
因为每一列的解由的和给出
列中元素M+1到N的平方.

LDB     (输入) INTEGER
      数组b的前导维数LDB >= MAX(1,M,N).

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      在退出时，如果INFO = 0, WORK(1)返回最优LWORK.

LWORK   (输入) INTEGER
      数组的尺寸为WORK.
      LWORK >= max( 1, MN + max( MN, NRHS ) ).
      为了获得最佳性能,
      LWORK >= max( 1, MN + max( MN, NRHS )*NB ).
      其中MN = min(M,N)， NB为最优块大小.

      如果LWORK = -1，则假定存在一个工作空间查询;例程
只计算WORK数组的最佳大小，返回
这个值作为WORK数组的第一个条目，没有错误
与LWORK相关的消息由XERBLA发出.

INFO    (输出) INTEGER
      = 0:  成功的退出
      < 0:  如果INFO = -i，则第i个参数具有非法值
      > 0:  的第i个对角线元素三角形因子A等于零，所以A没有满秩;最小二乘解不可能是计算.
"    ));
      end dgels_vec;

      pure function dgesv 
        "用B矩阵求解线性方程组A*X=B"
        extends Modelica.Icons.Function;
        input Real A[:,size(A, 1)];
        input Real B[size(A, 1),:];
        output Real X[size(A, 1),size(B, 2)] = B;
        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer nrhs = size(B, 2);
        Real Awork[size(A, 1),size(A, 1)] = A;
        Integer lda = max(1, size(A, 1));
        Integer ldb = max(1, size(B, 1));
        Integer ipiv[size(A, 1)];

      external "FORTRAN 77" dgesv(
        n, 
        nrhs, 
        Awork, 
        lda, 
        ipiv, 
        X, 
        ldb, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack文档
目的
=======

DGESV计算一个实线性方程组的解
 A * X = B,
其中A是n乘n矩阵X和B是n乘nrhs矩阵.

具有部分枢轴和行交换的LU分解为用来分解A
 A = P * L * U,
其中P是一个排列矩阵，L是单位下三角形，U是上三角。然后用A的因式来解方程组 A * X = B.

参数
=========

N       (输入) INTEGER
      线性方程的个数，即阶数矩阵.  N >= 0.

NRHS    (输入) INTEGER
      右手边的个数，即列的个数矩阵B的.  NRHS >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      在入口，n乘n系数矩阵A。
在出口，因子L和U从分解
A = p * l * u;L的单位对角线元素不被存储.

LDA     (输入) INTEGER
      数组A的前导维数.  LDA >= max(1,N).

IPIV    (输出) INTEGER array, dimension (N)
      定义置换矩阵P的主指标;矩阵的第i行与第IPIV(i)行交换.

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
      在入口，右边矩阵B的n乘nrhs矩阵。退出时，如果INFO = 0，则N-by-NRHS解矩阵X.

LDB     (输入) INTEGER
      数组B的前导维数.  LDB >= max(1,N).

INFO    (输出) INTEGER
      = 0:  成功的退出
      < 0:  如果INFO = -i，则第i个参数具有非法值
      > 0:  如果INFO = i, U(i,i)恰好为零。的分解已经完成了，但是因子U到底是奇异，所以解不能计算.
"    ));
      end dgesv;

      pure function dgesv_vec 
        "用b向量求解线性方程组A*x=b"
        extends Modelica.Icons.Function;
        input Real A[:,size(A, 1)];
        input Real b[size(A, 1)];
        output Real x[size(A, 1)] = b;
        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer nrhs = 1;
        Real Awork[size(A, 1),size(A, 1)] = A;
        Integer lda = max(1, size(A, 1));
        Integer ldb = max(1, size(b, 1));
        Integer ipiv[size(A, 1)];

      external "FORTRAN 77" dgesv(
        n, 
        nrhs, 
        Awork, 
        lda, 
        ipiv, 
        x, 
        ldb, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "
功能与LAPACK相同。Dgesv，但是右边是一个向量而不是矩阵。
有关参数的详细信息，请参阅dgesv的文档.
"    ));
      end dgesv_vec;

      pure function dgglse_vec 
        "求解一个线性等式约束的最小二乘问题"
        extends Modelica.Icons.Function;
        input Real A[:,:] "最小化 |A*x - c|^2";
        input Real c[size(A, 1)];
        input Real B[:,size(A, 2)] "受 B*x=d";
        input Real d[size(B, 1)];
        output Real x[size(A, 2)] "解向量";
        output Integer info;
      protected
        Integer nrow_A = size(A, 1);
        Integer nrow_B = size(B, 1);
        Integer ncol_A = size(A, 2) "(min=nrow_B,max=nrow_A+nrow_B) 要求";
        Real Awork[size(A, 1),size(A, 2)] = A;
        Real Bwork[size(B, 1),size(A, 2)] = B;
        Real cwork[size(A, 1)] = c;
        Real dwork[size(B, 1)] = d;
        Integer lwork = ncol_A + nrow_B + max(nrow_A, max(ncol_A, nrow_B)) * 5;
        Real work[size(A, 2) + size(B, 1) + max(size(A, 1), max(size(A, 2), size(B, 1))) * 5];

      external "FORTRAN 77" dgglse(
        nrow_A, 
        ncol_A, 
        nrow_B, 
        Awork, 
        nrow_A, 
        Bwork, 
        nrow_B, 
        cwork, 
        dwork, 
        x, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");

      annotation(Documentation(info = "Lapack文档
目的
=======

DGGLSE求解线性等约束最小二乘(LSE)
问题:

      minimize || c - A*x ||_2   subject to   B*x = d

其中A是一个m × n矩阵，B是一个p × n矩阵，c是给定的
m向量，d是给定的p向量。假设
P <= N <= M+P，且

       rank(B) = P and  rank( (A) ) = N.
                            ( (B) )

这些条件确保了伦敦经济学院的问题有一个独特的解决方案，
的广义RQ分解得到
矩阵(B, A)由

 B = (0 R)*Q,   A = Z*T*Q.

参数
=========

M       (输入) INTEGER
      矩阵A的行数.  M >= 0.

N       (输入) INTEGER
      矩阵A和B的列数. N >= 0.

P       (输入) INTEGER
      矩阵B的行数. 0 <= P <= N <= M+P.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      在入口，m × n矩阵A。
退出时，在数组对角线上和上面的元素
包含最小(M,N) × N的上梯形矩阵T.

LDA     (输入) INTEGER
      数组A的前导维数. LDA >= max(1,M).

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,N)
      在进入时，p乘n矩阵B。
在退出时，子数组B的上三角形(1:P,N-P+1:N)
包含p × p上三角矩阵R.

LDB     (输入) INTEGER
      数组B的前导维数. LDB >= max(1,P).

C       (输入/输出) DOUBLE PRECISION array, dimension (M)
      在入口，C包含右边的向量
LSE问题的最小二乘部分。
在出口，解的残差平方和
是由元素N-P+1到M的平方和给出的
矢量C.

D       (输入/输出) DOUBLE PRECISION array, dimension (P)
      在入口，D包含右边的向量
约束方程。
在出口，D被销毁.

X       (输出) DOUBLE PRECISION array, dimension (N)
      在退出时，X是LSE问题的解.

WORK    (工作空间/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      在退出时，如果INFO = 0, WORK(1)返回最优LWORK.

LWORK   (输入) INTEGER
      数组的尺寸为WORK。LWORK >= max(1,M+N+P)。
对于最优性能LWORK >= P+min(M,N)+max(M,N)*NB
其中NB是最优块大小的上界
DGEQRF, SGERQF, DORMQR和SORMRQ.

      如果LWORK = -1，则假定存在一个工作空间查询;例程
只计算WORK数组的最佳大小，返回
这个值作为WORK数组的第一个条目，没有错误
与LWORK相关的消息由XERBLA发出.

INFO    (输出) INTEGER
      = 0:  成功的退出.
      < 0:  如果INFO = -i，则第i个参数具有非法值.
      = 1:  上三角形因子R与B有关
对(B, A)的广义RQ分解为
奇异，使得rank(B) < P;最小二乘
解无法计算.
      = 2:  上梯形因子的(N-P) × (N-P)部分
广义RQ分解中T与A的关联
对(B, A)中的一个是单数，因此
rank((A)) < N;最小二乘解不能
(b))
计算.
"    ));
      end dgglse_vec;

      pure function dgtsv 
        "用B矩阵和三对角线A求解线性方程组A*X=B"

        extends Modelica.Icons.Function;
        input Real superdiag[:];
        input Real diag[size(superdiag, 1) + 1];
        input Real subdiag[size(superdiag, 1)];
        input Real B[size(diag, 1),:];
        output Real X[size(B, 1),size(B, 2)] = B;
        output Integer info;
      protected
        Integer n = size(diag, 1);
        Integer nrhs = size(B, 2);
        Integer ldb = size(B, 1);
        Real superdiagwork[size(superdiag, 1)] = superdiag;
        Real diagwork[size(diag, 1)] = diag;
        Real subdiagwork[size(subdiag, 1)] = subdiag;

      external "FORTRAN 77" dgtsv(
        n, 
        nrhs, 
        subdiagwork, 
        diagwork, 
        superdiagwork, 
        X, 
        ldb, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack文档
目的
=======

DGTSV解这个方程

 A*X = B,

其中A是一个n × n的三对角矩阵，用高斯消去法
部分旋转.

注意，方程A'*X = B可以通过交换
参数DU和DL的顺序.

参数
=========

N       (输入) INTEGER
      矩阵A的阶.  N >= 0.

NRHS    (输入) INTEGER
      右手边的个数，即列的个数矩阵B的.  NRHS >= 0.

DL      (输入/输出) DOUBLE PRECISION array, dimension (N-1)
      在条目中，DL必须包含(n-1)个子对角线元素一个.

      的(n-2)个元素覆盖DL上三角矩阵U的第二个超对角线A的LU分解，在DL(1)中，…, DL (n - 2).

D       (输入/输出) DOUBLE PRECISION array, dimension (N)
      在入口，D必须包含A的对角元素.

      在退出时，D被U的n个对角线元素覆盖.

DU      (输入/输出) DOUBLE PRECISION array, dimension (N-1)
      在条目中，DU必须包含(n-1)个超对角线元素的.

      在退出时，DU被第一个元素的(n-1)个元素覆盖U超对角线.

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
      在入口，右边矩阵B的N × NRHS矩阵.
      退出时，若INFO = 0，则N by NRHS解矩阵X.

LDB     (输入) INTEGER
      数组B的前导维数.  LDB >= max(1,N).

INFO    (输出) INTEGER
      = 0: 成功的退出
      < 0: 如果INFO = -i，则第i个参数具有非法值
      > 0: 如果INFO = i, U(i,i)正好为零，且解还没有计算过。因子分解还没有完成，除非i = N.
"    ));
      end dgtsv;

      pure function dgtsv_vec 
        "求解具有向量b和三对角线A的线性方程组A*x=b"

        extends Modelica.Icons.Function;
        input Real superdiag[:];
        input Real diag[size(superdiag, 1) + 1];
        input Real subdiag[size(superdiag, 1)];
        input Real b[size(diag, 1)];
        output Real x[size(b, 1)] = b;
        output Integer info;
      protected
        Integer n = size(diag, 1);
        Integer nrhs = 1;
        Integer ldb = size(b, 1);
        Real superdiagwork[size(superdiag, 1)] = superdiag;
        Real diagwork[size(diag, 1)] = diag;
        Real subdiagwork[size(subdiag, 1)] = subdiag;

      external "FORTRAN 77" dgtsv(
        n, 
        nrhs, 
        subdiagwork, 
        diagwork, 
        superdiagwork, 
        x, 
        ldb, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "
功能与LAPACK相同。Dgtsv，但是右边是一个向量而不是矩阵。
有关参数的详细信息，请参阅dgtsv的文档.
"    ));
      end dgtsv_vec;

      pure function dgbsv 
        "用B矩阵求解线性方程组A*X=B"
        extends Modelica.Icons.Function;
        input Integer n "方程数";
        input Integer kLower "低频带数";
        input Integer kUpper "上带数";
        input Real A[2 * kLower + kUpper + 1,n];
        input Real B[n,:];
        output Real X[n,size(B, 2)] = B;
        output Integer info;
      protected
        Integer nrhs = size(B, 2);
        Integer ldab = size(Awork, 1);
        Real Awork[size(A, 1),size(A, 2)] = A;
        Integer ipiv[n];

      external "FORTRAN 77" dgbsv(
        n, 
        kLower, 
        kUpper, 
        nrhs, 
        Awork, 
        ldab, 
        ipiv, 
        X, 
        n, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack文档
目的
=======

DGBSV计算一个实线性方程组的解
A * X = B，其中A是一个N阶带矩阵，有KL个次对角线
和KU超对角线，X和B为N-by-NRHS矩阵.

具有部分枢轴和行交换的LU分解为
用来将A分解为A = L * U，其中L是排列的乘积
和具有KL次对角线的单位下三角矩阵，U为
具有KL+KU超对角线的上三角形。A的因式形式
是用来解方程组 A * X = B.

参数
=========

N       (输入) INTEGER
      线性方程的个数，即阶数矩阵A.  N >= 0.

KL      (输入) INTEGER
      A 带内的子对角线数.  KL >= 0.

KU      (输入) INTEGER
      A 带内的超对角线数.  KU >= 0.

NRHS    (输入) INTEGER
      右边的数量，即矩阵 B 的列数的列数.  NRHS >= 0.

AB      (输入/输出) DOUBLE PRECISION array, dimension (LDAB,N)
      输入时，带状存储中的矩阵 A，行数为 KL+1 至
      2*KL+KU+1 行；数组的第 1 至 KL 行无需设置。
      A 的第 j 列存储在数组 AB 的第 j 列中。
      如下所示:
      AB(KL+KU+1+i-j,j) = A(i,j) for max(1,j-KU)<=i<=min(N,j+KL)
      退出时，将显示因式分解的详细信息： U 被存储为一个
      上三角带状矩阵，KL+KU 的对角线位于
      第 1 行至 KL+KU+1 行，因式分解过程中使用的乘法器存储在第
      因式分解过程中使用的乘数存储在 KL+KU+2 至 2*KL+KU+1 行。
      详见下文.

LDAB    (输入) INTEGER
      数组 AB 的前向维数.  LDAB >= 2*KL+KU+1.

IPIV    (输出) INTEGER array, dimension (N)
      定义置换矩阵 P 的枢轴指数；
      矩阵的第 i 行与第 IPIV(i)行互换.

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
      输入时，是 N-by-NRHS 右边矩阵 B。
      退出时，如果 INFO = 0，则 N-by-NRHS 解矩阵 X.

LDB     (输入) INTEGER
      数组 B 的前向维度.  LDB >= max(1,N).

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
      > 0:  如果 INFO = i，则 U(i,i) 恰好为零。 因式分解
            因式分解已经完成，但因式 U 恰好是
            奇异，且解未计算出来.

更多详情
===============

下面举例说明波段存储方案，当
M = N = 6, KL = 2, KU = 1:

进入:                       出口处:

  *    *    *    +    +    +       *    *    *   u14  u25  u36
  *    *    +    +    +    +       *    *   u13  u24  u35  u46
  *   a12  a23  a34  a45  a56      *   u12  u23  u34  u45  u56
 a11  a22  a33  a44  a55  a66     u11  u22  u33  u44  u55  u66
 a21  a32  a43  a54  a65   *      m21  m32  m43  m54  m65   *
 a31  a42  a53  a64   *    *      m31  m42  m53  m64   *    *

标记为 * 的数组元素不被例程使用；标记为
+ 的元素不需要在输入时设置，但例程需要这些元素来存储
的元素，因为行交换会产生填充.
"    ));
      end dgbsv;

      pure function dgbsv_vec 
        "用 a b 向量求解实数线性方程组 A*x=b"
        extends Modelica.Icons.Function;
        input Integer n "方程式数量";
        input Integer kLower "低频段数量";
        input Integer kUpper "上带数量";
        input Real A[2 * kLower + kUpper + 1,n];
        input Real b[n];
        output Real x[n] = b;
        output Integer info;
      protected
        Integer nrhs = 1;
        Integer ldab = size(Awork, 1);
        Real Awork[size(A, 1),size(A, 2)] = A;
        Integer ipiv[n];

      external "FORTRAN 77" dgbsv(
        n, 
        kLower, 
        kUpper, 
        nrhs, 
        Awork, 
        ldab, 
        ipiv, 
        x, 
        n, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "
与函数 LAPACK.dgbsv 相同，但右侧是向量而不是矩阵。
有关参数的详细信息，请参阅 dgbsv 文档。.
"    ));
      end dgbsv_vec;

      pure function dgesvd "确定奇异值分解"
        extends Modelica.Icons.Function;
        input Real A[:,:];
        output Real sigma[min(size(A, 1), size(A, 2))];
        output Real U[size(A, 1),size(A, 1)] = zeros(size(A, 1), size(A, 1));
        output Real VT[size(A, 2),size(A, 2)] = zeros(size(A, 2), size(A, 2));
        output Integer info;
      protected
        Integer m = size(A, 1);
        Integer n = size(A, 2);
        Real Awork[size(A, 1),size(A, 2)] = A;
        Integer lwork = 5 * size(A, 1) + 5 * size(A, 2);
        Real work[5 * size(A, 1) + 5 * size(A, 2)];

      external "FORTRAN 77" dgesvd(
        "A", 
        "A", 
        m, 
        n, 
        Awork, 
        m, 
        sigma, 
        U, 
        m, 
        VT, 
        n, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGESVD 可计算一个 M 乘 N 实矩阵 A 的奇异值分解（SVD）。
可选择计算左奇异向量和/或右奇异向量。
向量。SVD 的写法是

   A = U * SIGMA * transpose(V)

其中，SIGMA 是一个 M 乘 N 矩阵，除了它的min(m,n)对角线元素外为零；U 是 M 乘 M 的正交矩阵；V 是 N 乘 N 的正交矩阵。
V 是一个 N 乘 N 的正交矩阵.  SIGMA的对角元素是 A 的奇异值；它们都是实数且非负，并且以降序返回。 U 和 V 的前 min(m,n) 列是 A 的左奇异向量和右奇异向量。U 和 V 的第一列是 A 的左奇异向量和右奇异向量.

请注意，例程返回的是 V**T，而不是 V.

论据
=========

JOBU    (输入) CHARACTER*1
      指定计算矩阵 U 全部或部分的选项:
      = 'A':  U 的所有 M 列返回数组 U:
      = 'S':  U 的前最小（m,n）列（左奇异
              向量）会在数组 U;
      = 'O':  U 的前最小（m,n）列（左奇异
              向量）被覆盖到数组 A;
      = 'N':  不计算 U 的列（不计算左奇异矢量
              计算.

JOBVT   (输入) CHARACTER*1
      指定计算全部或部分矩阵的选项
      V**T:
      = 'A':  在数组 VT 中返回 V**T 的所有 N 行;
      = 'S':  V**T 的前最小（m,n）行（右奇异
              向量）会在数组 VT;
      = 'O':  V**T 的前最小（m,n）行（右奇异
              向量）被覆盖到数组 A;
      = 'N':  不计算 V**T 的行（不计算右奇异向量）。
              计算.

      JOBVT 和 JOBU 不能都是 'O'.

M       (输入) INTEGER
      输入矩阵 A 的行数.  M >= 0.

N       (输入) INTEGER
      输入矩阵 A 的列数.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      入口为 M 乘 N 矩阵 A.
      出口处,
      如果 JOBU = 'O'，则用 U 的前 min(m,n) 列（左奇异矢量）覆盖 A。
                      列（左奇异向量、
                      按列存储）;
      如果 JOBVT = 'O'，则用 V**T 的前 min(m,n)
                      行（右奇异向量、
                      按行存储）;
      如果 JOBU .ne. 'O'和 JOBVT .ne. 'O'，则 A
                      的内容将被销毁.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,M).

S       (输出) DOUBLE PRECISION array, dimension (min(M,N))
      A 的奇异值，排序为 S(i) >= S(i+1).

U       (输出) DOUBLE PRECISION array, dimension (LDU,UCOL)
      如果 JOBU ='A'，则为 (LDU,M)；如果 JOBU ='S'，则为 (LDU,min(M,N))。
      如果 JOBU = 'A'，U 包含 M 乘 M 的正交矩阵 U；
      如果 JOBU = 'S'，U 包含 U 的第一列 min(m,n)
      (左奇异向量，按列存储）；
      如果 JOBU = 'N' 或 'O'，则不引用 U.

LDU     (输入) INTEGER
      LDU >= 1; 如果
      JOBU = 'S' 或 'A'，LDU >= M.

VT      (输出) DOUBLE PRECISION array, dimension (LDVT,N)
      如果 JOBVT = 'A'，则 VT 包含 N 乘 N 的正交矩阵
      V**T；
      如果 JOBVT = 'S'，VT 包含 V**T 的前 min(m,n) 行（右奇异矢量，按顺序存储
      右奇异矢量，按行存储）；
      如果 JOBVT = 'N' 或 'O'，则不引用 VT.

LDVT    (输入) INTEGER
      数组 VT 的前向维数。 LDVT >= 1; if
      JOBVT = 'A'，LDVT >= N；如果 JOBVT = 'S'，LDVT >= min(M,N).

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 返回最优 LWORK；
      如果 INFO > 0，WORK(2:MIN(M,N)) 将包含未反演的
      上对角矩阵 B 的未对角元素。
      的对角线在 S 中（不一定排序）。B
      满足 A = U * B * VT，因此它具有与 A 相同的奇异值和奇异向量。
      的奇异值，以及与 U 和 VT 相关的奇异向量.

LWORK   (输入) INTEGER
      数组 WORK 的维数。
      LWORK >= max(1,3*min(m,n)+max(m,n),5*min(m,n)).
      为了获得良好的性能，LWORK 通常应大于.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0:  成功退出.
      < 0:  如果 INFO = -i，则第 i 个参数为非法值.
      > 0:  如果 DBDSQR 没有收敛，INFO 会指定有多少个
            中间对角线形式 B
            没有收敛为零的超对角线个数。详见上文关于 WORK
            的详细说明.
"    ));
      end dgesvd;

      pure function dgesvd_sigma "确定奇异值"
        extends Modelica.Icons.Function;
        input Real A[:,:];
        output Real sigma[min(size(A, 1), size(A, 2))];
        output Integer info;
      protected
        Integer m = size(A, 1);
        Integer n = size(A, 2);
        Real Awork[size(A, 1),size(A, 2)] = A;
        Real U[size(A, 1),size(A, 1)];
        Real VT[size(A, 2),size(A, 2)];
        Integer lwork = 5 * size(A, 1) + 5 * size(A, 2);
        Real work[5 * size(A, 1) + 5 * size(A, 2)];

      external "FORTRAN 77" dgesvd(
        "N", 
        "N", 
        m, 
        n, 
        Awork, 
        m, 
        sigma, 
        U, 
        m, 
        VT, 
        n, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack文档
目的
=======

DGESVD 可计算一个 M 乘 N 实矩阵 A 的奇异值分解（SVD）。
可选择计算左奇异向量和/或右奇异向量。
向量。SVD 的写法是

   A = U * SIGMA * transpose(V)

其中，SIGMA 是一个 M 乘 N 矩阵，除了它的
min(m,n)对角元素外为零；U 是一个 M 乘 M 的正交矩阵；V 是一个 N 乘 N 的正交矩阵。
V 是一个 N 乘 N 的正交矩阵。 SIGMA
的对角元素是 A 的奇异值；它们是实数且非负，并按
按降序返回。 U 和 V 的前 min(m,n) 列为左和右奇异值。
U 和 V 的第一列是 A 的左奇异向量和右奇异向量。

请注意，例程返回的是 V**T，而不是 V.

论据
=========

JOBU    (输入) CHARACTER*1
      指定计算矩阵 U 全部或部分的选项:
      = 'A':  U 的所有 M 列返回数组 U:
      = 'S':  U 的前最小（m,n）列（左奇异
              向量）会在数组 U;
      = 'O':  U 的前最小（m,n）列（左奇异
              向量）被覆盖到数组 A;
      = 'N':  不计算 U 的列（不计算左奇异矢量
              计算.

JOBVT   (输入) CHARACTER*1
      指定计算全部或部分矩阵的选项
      V**T:
      = 'A':  在数组 VT 中返回 V**T 的所有 N 行;
      = 'S':  V**T 的前最小（m,n）行（右奇异
              向量）会在数组 VT;
      = 'O':  V**T 的前最小（m,n）行（右奇异
              向量）被覆盖到数组 A;
      = 'N':  不计算 V**T 的行（不计算右奇异向量）。
              计算.

      JOBVT 和 JOBU 不能都是 'O'.

M       (输入) INTEGER
      输入矩阵 A 的行数.  M >= 0.

N       (输入) INTEGER
      输入矩阵 A 的列数.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      输入时，是 M 乘 N 矩阵 A。
      退出时,
      if JOBU = 'O',  A 将被 U 的前 min(m,n)
                      列（左奇异向量、
                      按列存储）;
      if JOBVT = 'O', 用 V**T 的前 min(m,n)
                      行（右奇异向量、
                      按行存储）;
      if JOBU .ne. 'O' and JOBVT .ne. 'O', 的内容
                      的内容被销毁.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,M).

S       (输出) DOUBLE PRECISION array, dimension (min(M,N))
      A 的奇异值，排序为 S(i) >= S(i+1).

U       (输出) DOUBLE PRECISION array, dimension (LDU,UCOL)
      如果 JOBU ='A'，则为 (LDU,M)；如果 JOBU ='S'，则为 (LDU,min(M,N))。
      如果 JOBU = 'A'，U 包含 M 乘 M 的正交矩阵 U；
      如果 JOBU = 'S'，U 包含 U 的第一列 min(m,n)
      (左奇异向量，按列存储）；
      如果 JOBU = 'N' 或 'O'，则不引用 U.

LDU     (输入) INTEGER
      LDU >= 1; 如果
      JOBU = 'S' 或 'A'，LDU >= M.

VT      (输出) DOUBLE PRECISION array, dimension (LDVT,N)
      如果 JOBVT = 'A'，则 VT 包含 N 乘 N 的正交矩阵
      V**T；
      如果 JOBVT = 'S'，VT 包含 V**T 的前 min(m,n) 行（右奇异矢量，按顺序存储
      右奇异矢量，按行存储）；
      如果 JOBVT = 'N' 或 'O'，则不引用 VT.

LDVT    (输入) INTEGER
      数组 VT 的前导维数.  LDVT >= 1; if
      JOBVT = 'A', LDVT >= N; if JOBVT = 'S', LDVT >= min(M,N).

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 返回最优 LWORK；
      如果 INFO > 0，WORK(2:MIN(M,N)) 将包含未反演的
      上对角矩阵 B 的未对角元素。
      的对角线在 S 中（不一定排序）。B
      满足 A = U * B * VT，因此它具有与 A 相同的奇异值和奇异向量。
      的奇异值，以及与 U 和 VT 相关的奇异向量.

LWORK   (输入) INTEGER
      数组 WORK 的维数。
      LWORK >= max(1,3*min(m,n)+max(m,n),5*min(m,n)).
      为了获得良好的性能，LWORK 通常应大于.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0:  成功退出.
      < 0:  如果 INFO = -i，则第 i 个参数为非法值.
      > 0:  如果 DBDSQR 没有收敛，INFO 会指定有多少个
            中间对角线形式 B
            没有收敛为零的超对角线个数。详见上文关于 WORK
            的详细说明.
"    ));
      end dgesvd_sigma;

      pure function dgetrf 
        "计算正方形或矩形矩阵 A 的 LU 因式分解（A = P*L*U）"

        extends Modelica.Icons.Function;
        input Real A[:,:] "正方形或矩形矩阵";
        output Real LU[size(A, 1),size(A, 2)] = A;
        output Integer pivots[min(size(A, 1), size(A, 2))] "枢轴向量";
        output Integer info "信息";
      protected
        Integer m = size(A, 1);
        Integer n = size(A, 2);
        Integer lda = max(1, size(A, 1));

      external "FORTRAN 77" dgetrf(
        m, 
        n, 
        LU, 
        lda, 
        pivots, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGETRF 利用部分透视和行间交换计算 M 乘 N 矩阵 A 的 LU 因式分解
的 LU 因式分解。.

因式分解的形式是
 A = P * L * U
其中，P 是置换矩阵，L 是下三角矩阵，对角线元素为单位（如果 m > n，则为下梯形），U 是上三角矩阵。
对角元素的下三角（如果 m > n，则为下梯形），U 为上三角（如果 m < n，则为上梯形）。
如果 m < n，则为上梯形）。.

这是算法的第 3 级 BLAS 正确版本.

论据
=========

M       (输入) INTEGER
      矩阵 A 的行数.  M >= 0.

N       (输入) INTEGER
      矩阵 A 的列数.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      输入时，是要因式分解的 M 乘 N 矩阵。
      退出时，因式分解中的因数 L 和 U
      A = P*L*U；不存储 L 的单位对角元素.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,M).

IPIV    (输出) INTEGER array, dimension (min(M,N))
      枢轴指数；对于 1 <= i <= min(M,N)，矩阵的第 i 行与第 IPIV(i) 行交换。
      与 IPIV(i) 行交换.

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
      > 0:  如果 INFO = i，则 U(i,i) 恰好为零。因式分解
            因式分解已经完成，但因式 U 恰好是
            奇异，如果用它来解方程组，就会出现除以零的情况。
            求解方程组.
"    ));
      end dgetrf;

      pure function dgetrs 
        "用 dgetrf 的 LU 分解求解线性方程组"

        extends Modelica.Icons.Function;
        input Real LU[:,size(LU, 1)] 
          "正方形矩阵 dgetrf 的 LU 因式分解";
        input Integer pivots[size(LU, 1)] "dgetrf 的枢轴向量";
        input Real B[size(LU, 1),:] "右边矩阵 B";
        output Real X[size(B, 1),size(B, 2)] = B "解矩阵 X";
        output Integer info;
      protected
        Integer n = size(LU, 1);
        Integer nrhs = size(B, 2);
        Real work[size(LU, 1),size(LU, 1)] = LU;
        Integer lda = max(1, size(LU, 1));
        Integer ldb = max(1, size(B, 1));

      external "FORTRAN 77" dgetrs(
        "N", 
        n, 
        nrhs, 
        work, 
        lda, 
        pivots, 
        X, 
        ldb, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGETRS 可求解线性方程组
 A * X = B  or  A' * X = B
使用 DGETRF 计算出的 LU 因式分解对一般 N 乘 N 矩阵 A
用 DGETRF.

论据
=========

TRANS   (输入) CHARACTER*1
      指定方程组的形式:
      = 'N':  A * X = B  (无转置)
      = 'T':  A'* X = B  (转置)
      = 'C':  A'* X = B  (共轭转置 = 转置)

N       (输入) INTEGER
      矩阵 A 的阶数.  N >= 0.

NRHS    (输入) INTEGER
      右边的数量，即矩阵 B 的列数
      的列数.  NRHS >= 0.

A       (输入) DOUBLE PRECISION array, dimension (LDA,N)
      因子 A = P*L*U 中的因子 L 和 U
      计算得出的.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,N).

IPIV    (输入) INTEGER array, dimension (N)
      来自 DGETRF 的枢轴索引；对于 1<=i<=N，矩阵的第 i 行与 IPIV(i) 行交换。
      与 IPIV(i) 行交换.

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
      输入时，右侧矩阵 B。
      出站时，解矩阵 X。

LDB     (输入) INTEGER
      数组 B 的前向维度.  LDB >= max(1,N).

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dgetrs;

      pure function dgetrs_vec 
        "用 dgetrf 的 LU 分解求解线性方程组"

        extends Modelica.Icons.Function;
        input Real LU[:,size(LU, 1)] 
          "正方形矩阵 dgetrf 的 LU 因式分解";
        input Integer pivots[size(LU, 1)] "dgetrf 的枢轴向量";
        input Real b[size(LU, 1)] "右侧矢量 b";
        output Real x[size(b, 1)] = b;
        output Integer info;

      protected
        Integer n = size(LU, 1);
        Integer nrhs = 1;
        Real work[size(LU, 1),size(LU, 1)] = LU;
        Integer lda = max(1, size(LU, 1));
        Integer ldb = max(1, size(b, 1));

      external "FORTRAN 77" dgetrs(
        "N", 
        n, 
        nrhs, 
        work, 
        lda, 
        pivots, 
        x, 
        ldb, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGETRS 可求解线性方程组
 A * X = B  or  A' * X = B
使用 DGETRF 计算出的 LU 因式分解对一般 N 乘 N 矩阵 A
用 DGETRF.

论据=========

TRANS   (输入) CHARACTER*1
      指定方程组的形式:
      = 'N':  A * X = B  (无转置)
      = 'T':  A'* X = B  (转置)
      = 'C':  A'* X = B  (共轭转置 = 转置)

N       (输入) INTEGER
      矩阵 A 的阶数.  N >= 0.

NRHS    (输入) INTEGER
      右边的数量，即矩阵 B 的列数
      的列数.  NRHS >= 0.

A       (输入) DOUBLE PRECISION array, dimension (LDA,N)
      因子 A = P*L*U 中的因子 L 和 U
      计算得出的.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,N).

IPIV    (输入) INTEGER array, dimension (N)
      来自 DGETRF 的枢轴索引；对于 1<=i<=N，矩阵的第 i 行与 IPIV(i) 行交换。
      与 IPIV(i) 行交换.

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
      输入时，右侧矩阵 B。
      退出时，解矩阵 X.

LDB     (输入) INTEGER
      数组 B 的前向维度.  LDB >= max(1,N).

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dgetrs_vec;

      pure function dgetri 
        "使用 dgetrf 中的 LU 因式分解计算矩阵的逆值"

        extends Modelica.Icons.Function;
        input Real LU[:,size(LU, 1)] 
          "正方形矩阵 dgetrf 的 LU 因式分解";
        input Integer pivots[size(LU, 1)] "dgetrf 的枢轴向量";
        output Real inv[size(LU, 1),size(LU, 2)] = LU "矩阵 P*L*U 的逆";
        output Integer info;

      protected
        Integer n = size(LU, 1);
        Integer lda = max(1, size(LU, 1));
        Integer lwork = max(1, min(10, size(LU, 1)) * size(LU, 1)) 
          "工作阵列长度";
        Real work[max(1, min(10, size(LU, 1)) * size(LU, 1))];

      external "FORTRAN 77" dgetri(
        n, 
        inv, 
        lda, 
        pivots, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGETRI 使用 DGETRF 计算出的 LU 因子分解计算矩阵的逆
计算矩阵的逆.

该方法反演 U，然后通过求解系统计算 inv(A)
inv(A)*L = inv(U) for inv(A).

Arguments
=========

N       (输入) INTEGER
      矩阵 A 的阶数.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      输入因子 L 和 U。
      A = P*L*U 由 DGETRF 计算得出。
      退出时，如果 INFO = 0，则是原始矩阵 A 的逆值.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,N).

IPIV    (输入) INTEGER array, dimension (N)
      来自 DGETRF 的枢轴索引；对于 1<=i<=N，矩阵的第 i 行与 IPIV(i) 行交换。
      与 IPIV(i) 行交换.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO=0，则 WORK(1) 返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。 LWORK >= max(1,N)。
      为获得最佳性能，LWORK >= N*NB，其中 NB 是
      是 ILAENV 返回的最佳块大小。.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
      > 0:  如果 INFO = i，U(i,i) 恰好为零；矩阵为奇异矩阵，无法计算其逆值。
            奇异，无法计算其逆.
"    ));
      end dgetri;

      pure function dgeqp3 "计算正方形或矩形矩阵 A 的 QR 因式分解，并进行列支点处理"

        extends Modelica.Icons.Function;
        input Real A[:,:] "正方形或矩形矩阵";
        input Integer lwork = max(1, 3 * size(A, 2) + 1) "工作阵列长度";
        output Real QR[size(A, 1),size(A, 2)] = A 
          "QR 因式分解打包格式";
        output Real tau[min(size(A, 1), size(A, 2))] 
          "Q 基本反射体的标量因子";
        output Integer p[size(A, 2)] = zeros(size(A, 2)) "枢轴向量";
        output Integer info;
      protected
        Integer m = size(A, 1);
        Integer lda = max(1, size(A, 1));
        Integer ncol = size(A, 2) "A 的柱尺寸";
        Real work[lwork] "工作阵列";

      external "FORTRAN 77" dgeqp3(
        m, 
        ncol, 
        QR, 
        lda, 
        p, 
        tau, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGEQP3 使用 3 级 BLAS 计算矩阵 A 的 QR 因式分解和列支点化：A*P = Q*R
矩阵 A 的 QR 因式分解：A*P = Q*R。.

论据
=========

M       (输入) INTEGER
      矩阵 A 的行数. M >= 0.

N       (输入) INTEGER
      矩阵 A 的列数.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      输入时，是 M 乘 N 矩阵 A。
      退出时，数组的上三角包含
      最小（M,N）乘 N 的上梯形矩阵 R。
      对角线以下的元素与数组 TAU 一起，代表正交矩阵 Q。
      正交矩阵 Q 是最小（M,N）个基本
      反射器.

LDA     (输入) INTEGER
      数组 A 的前向维度. LDA >= max(1,M).

JPVT    (输入/输出) INTEGER array, dimension (N)
      输入时，如果 JPVT(J).ne.0，则 A 的第 J 列被置换到 A*P 的前面（前导列）。
      到 A*P 的前面（前导列）；如果 JPVT(J)=0、
      则 A 的第 J 列为自由列。
      退出时，如果 JPVT(J)=K ，那么 A*P 的第 J 列就是 A*P 的第 K 列。
      的第 K 列.

TAU     (输出) DOUBLE PRECISION array, dimension (min(M,N))
      基本反射器的标量因子.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO=0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。LWORK>=3*N+1。
      为获得最佳性能，LWORK >= 2*N+( N+1 )*NB, 其中 NB
      是最佳块大小.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0: 成功退出.
      < 0: 如果 INFO = -i，则第 i 个参数为非法值.

更多详情
===============

矩阵 Q 表示为基本反射器的乘积

 Q = H(1) H(2) . . . H(k), where k = min(m,n).

每个 H(i) 的形式为

 H(i) = I - tau * v * v'

其中 tau 为实数/复数标量，v 为实数/复数向量
v(1:i-1) = 0，v(i) = 1；v(i+1:m) 在退出时存储在
A(i+1:m,i)，tau 保存在 TAU(i).

根据以下方面提供的资料
G. Quintana-Orti, Depto. de Informatica, Universidad Jaime I, Spain
X. Sun, Computer Science Dept., Duke University, USA
"    ));
      end dgeqp3;

      pure function dorgqr 
        "生成一个实正交矩阵 Q，其定义为 dgeqrf 返回的基本反射器的乘积"

        extends Modelica.Icons.Function;
        input Real QR[:,:] "来自 dgeqrf 的 QR";
        input Real tau[min(size(QR, 1), size(QR, 2))] 
          "Q 基本反射体的标量因子";
        output Real Q[size(QR, 1),size(QR, 2)] = QR "正交矩阵 Q";
        output Integer info;

      protected
        Integer m = size(QR, 1);
        Integer n = size(QR, 2);
        Integer k = size(tau, 1);
        Integer lda = max(1, size(Q, 1));
        Integer lwork = max(1, min(10, size(QR, 2)) * size(QR, 2)) 
          "工作阵列长度";
        Real work[max(1, min(10, size(QR, 2)) * size(QR, 2))];

      external "FORTRAN 77" dorgqr(
        m, 
        n, 
        k, 
        Q, 
        lda, 
        tau, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DORGQR 生成一个具有正交列的 M 乘 N 实矩阵 Q、
的前 N 列。
的前 N 列的乘积。

    Q  =  H(1) H(2) . . . H(k)

由 DGEQRF 返回.

论据
=========

M       (输入) INTEGER
      矩阵 Q 的行数. M >= 0.

N       (输入) INTEGER
      矩阵 Q 的列数. M >= N >= 0.

K       (输入) INTEGER
      基本反射器的数量，其乘积定义了
      矩阵 Q. N >= K >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      输入时，第 i 列必须包含定义基本反射器 H(i) 的矢量。
      定义基本反射器 H(i) 的向量，对于 i = 1,2,...,k，如
      由 DGEQRF 在其数组参数 A 的前 k 列返回。
      参数 A 的前 k 列。
      退出时，M 乘 N 矩阵 Q.

LDA     (输入) INTEGER
      数组 A 的第一个维度. LDA >= max(1,M).

TAU     (输入) DOUBLE PRECISION array, dimension (K)
      TAU(i) 必须包含由 DGEQRF 返回的基本反射器 H(i) 的标量因子。
      的标量因子。.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。LWORK >= max(1,N)。
      为获得最佳性能，LWORK >= N*NB，其中 NB 是
      最佳块大小.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dorgqr;

      pure function dgees 
        "计算实非对称矩阵 A 的实舒尔体 T，以及舒尔向量矩阵 Z 和特征值"
        extends Modelica.Icons.Function;

        input Real A[:,size(A, 1)] "正方形矩阵";
        output Real T[size(A, 1),size(A, 2)] = A "A = Z*T*Z' 的实数舒尔形式";
        output Real Z[size(A, 1),size(A, 1)] 
          "舒尔向量正交矩阵 Z";
        output Real eval_real[size(A, 1)] "A 的特征向量实部";
        output Real eval_imag[size(A, 1)] 
          "A 的特征向量的虚部";
        output Integer info;

      protected
        constant Integer dummyFunctionPointerNotUsed[1] = {0};
        Integer n = size(A, 1) "A 的行维度";
        Integer lda = max(1, n);
        Integer sdim = 0;
        Integer lwork = max(1, 10 * size(A, 1));
        Real work[lwork];
        Boolean bwork[size(A, 1)];

      external "FORTRAN 77" dgees(
        "V", 
        "N", 
        dummyFunctionPointerNotUsed, 
        n, 
        T, 
        lda, 
        sdim, 
        eval_real, 
        eval_imag, 
        Z, 
        lda, 
        work, 
        lwork, 
        bwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGEES 可以计算 N 乘 N 的实非对称矩阵 A 的
的特征值、实数舒尔形式 T，以及可选的舒尔向量矩阵 Z。
这样就得到了舒尔因式分解 A = Z*T*(Z**T).

此外，它还可以对实舒尔表对角线上的特征值进行排序。
实数舒尔形式对角线上的特征值排序，使选定的特征值位于左上方。
然后，Z 的前导列就构成了与所选特征值对应的不变子空间的正交基
与所选特征值相对应的不变子空间的正交基.

如果矩阵是上准三角形，且具有
1-by-1 和 2-by-2 块。2×2 块将以
形式
      [  a  b  ]
      [  c  a  ]

这样一个区块的特征值为 a +- sqrt(bc).

论据
=========

JOBVS   (输入) CHARACTER*1
      = 'N': 不计算舒尔向量;
      = 'V': 计算舒尔向量.

SORT    (输入) CHARACTER*1
      指定是否对舒尔表对角线上的特征值进行排序。
      对角线上的特征值.
      = 'N': 特征值无序;
      = 'S': 特征值是有序的（见 SELECT）.

SELECT  (外部程序) LOGICAL FUNCTION of two DOUBLE PRECISION arguments
      SELECT 必须在调用子程序中声明为 EXTERNAL。
      如果 SORT = 'S'，SELECT 将用于选择特征值，并排序到舒尔表格的左上角。
      到舒尔表格的左上角。
      如果 SORT = 'N'，则不引用 SELECT。
      如果出现以下情况，特征值 WR(j)+sqrt(-1)*WI(j) 将被选中
      SELECT(WR(j),WI(j))为真；也就是说，如果复共轭对特征值中的任一个
      共轭对特征值中的任何一个被选中，那么两个复特征值都会被选中。
      则两个复特征值都被选中。
      请注意，被选中的复特征值可能不再满足
      满足 SELECT(WR(j),WI(j)) = .TRUE.
      排序可能会改变复特征值的值
      (特别是在特征值条件不佳的情况下）；在这种情况下
      在这种情况下，INFO 设置为 N+2（见下文 INFO）.

N       (输入) INTEGER
      矩阵 A 的阶数. N >= 0.

A       (输入/output) DOUBLE PRECISION array, dimension (LDA,N)
      输入时，是 N 乘 N 矩阵 A。
      退出时，A 已被其实数舒尔形式 T 覆盖.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,N).

SDIM    (输出) INTEGER
      If SORT = 'N', SDIM = 0.
      If SORT = 'S', SDIM = SELECT 为真的特征值数（排序后）
                     SELECT为真的复共轭对）。
                     复共轭对，其中任一特征值的 SELECT 为真，则算作 2）。
                     特征值均为真的复共轭对算为 2）。

WR      (输出) DOUBLE PRECISION array, dimension (N)
WI      (输出) DOUBLE PRECISION array, dimension (N)
      WR 和 WI 包含实部和虚部、
      的实部和虚部。
      的对角线上出现的顺序。
      特征值的复共轭对将连续出现
      连续出现，具有正虚部的特征值先出现
      虚部在前.

VS      (输出) DOUBLE PRECISION array, dimension (LDVS,N)
      If JOBVS = 'V', VS 包含舒尔矢量的正交矩阵 Z
      向量的正交矩阵.
      If JOBVS = 'N', VS 未被引用.

LDVS    (输入) INTEGER
      数组 VS 的前导维数.  LDVS >= 1; if
      JOBVS = 'V', LDVS >= N.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将包含最佳 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。 LWORK >= max(1,3*N)。
      为了获得良好的性能，LWORK 通常必须大于.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

BWORK   (工作区) LOGICAL array, dimension (N)
      如果 SORT = 'N'，则不引用.

INFO    (输出) INTEGER
      = 0: 成功退出
      < 0: 如果 INFO = -i，则第 i 个参数为非法值.
      > 0: 如果 INFO = i，并且 i 是
         <= N: QR 算法无法计算所有特征值；WR 和 WI 的元素 1:ILO-1 和 i+1:N
               特征值；WR 和 WI 中的元素 1:ILO-1 和 i+1:N
               包含收敛的特征值；如果
               如果 JOBVS = 'V'，则 VS 包含将 A
               部分收敛的舒尔形式的矩阵.
         = N+1: 特征值无法重新排序，因为有些
               特征值太接近，无法分开（问题
               条件很差）;
         = N+2: 重新排序后，四舍五入改变了一些复特征值的值
               复特征值，因此舒尔形式中的前导特征值不再满足 SELECT=.
               不再满足 SELECT=.TRUE 条件。 这
               也可能是由于缩放造成的下溢.
"    ));
      end dgees;

      pure function dtrsen "重排实数矩阵的实数舒尔因式分解"
        extends Modelica.Icons.Function;

        input String job = "N" "指定条件编号的用途";
        input String compq = "V" "Is \"V\" 如果要更新舒尔向量矩阵";
        input Boolean select[:] "指定要重新排序的特征值";
        input Real T[:,:] "重新排序的真实舒尔形式";
        input Real Q[:,size(T, 2)] "舒尔向量矩阵";

      protected
        Integer n = size(T, 2);
        Integer ldt = max(1, n);
        Integer ldq = if compq == "V" then max(n, 1) else 1;
        Integer lwork = if job == "N" then max(1, n) else if job == "E" then n * n 
          else 2 * n * n;
        Real work[if job == "N" then max(1, size(T, 2)) else if job == "E" then size(T, 2) * size(T, 2) else 2 * size(T, 2) * size(T, 2)];
        Integer liwork = if job == "N" or job == "E" then 1 else n * n;
        Integer iwork[if job == "N" or job == "E" then 1 else size(T, 2) * size(T, 2)];

      public
        output Real To[:,:] = T "重新排序的舒尔形式";
        output Real Qo[:,:] = Q "重新排序的舒尔向量";
        output Real wr[size(T, 2)] "重排特征值，实部";
        output Real wi[size(T, 2)] "重排特征值，虚部";
        output Integer m 
          "所选特征值所跨不变子空间的维数";
        output Real s 
          "倒数条件数的下限。工作===V 不引用";
        output Real sep 
          "指定不变子空间的估计倒数条件数";
        output Integer info;

      external "FORTRAN 77" dtrsen(
        job, 
        compq, 
        select, 
        n, 
        To, 
        ldt, 
        Qo, 
        ldq, 
        wr, 
        wi, 
        m, 
        s, 
        sep, 
        work, 
        lwork, 
        iwork, 
        liwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DTRSEN 对实数矩阵的实数舒尔因式分解进行重新排序
A = Q*T*Q**T，使选定的特征值群出现在上准三边矩阵 T 的前导对角线块中。
上准三角形矩阵 T 的前导对角块中、
的前导列构成相应右不变子空间的正交基。
相应的右不变子空间的正交基.

作为选项，例程会计算特征值群和/或不变子空间的倒数条件数。
或不变子空间的倒数条件数.

T 必须是舒尔规范形式（由 DHSEQR 返回），即
具有 1-by-1 和 2-by-2 对角块的上三角块；每个
对角线块的对角线元素相等，对角线外元素符号相反。
对角元素符号相反.

论据
=========

JOB     (输入) CHARACTER*1
      指定是否需要为
      特征值簇 (S) 或不变子空间 (SEP) 的条件数:
      = 'N': 无;
      = 'E': 仅适用于特征值（S）;
      = 'V': 仅适用于不变子空间（SEP）;
      = 'B': 特征值和不变子空间（S 和
             SEP).

COMPQ   (输入) CHARACTER*1
      = 'V': 更新舒尔向量矩阵 Q;
      = 'N': 不更新 Q.

SELECT  (输入) LOGICAL array, dimension (N)
      SELECT 指定所选群组中的特征值。要
      要选择实特征值 w(j)，SELECT(j) 必须设置为
      .TRUE. 要选择一对复共轭特征值
      w(j)和 w(j+1)，对应一个 2×2 的对角线块、
      必须将 SELECT(j) 或 SELECT(j+1) 设置为.TRUE.
      .TRUE.；一对复共轭特征值必须
      或都被排除在外.

N       (输入) INTEGER
      矩阵 T 的阶数. N >= 0.

T       (输入/输出) DOUBLE PRECISION array, dimension (LDT,N)
      入口为上准三角形矩阵 T，采用舒尔
      正则表达式。
      退出时，T 会被重新排序的矩阵 T 覆盖，同样以
      舒尔规范形式，所选特征值位于
      前对角线块中的选定特征值.

LDT     (输入) INTEGER
      数组 T 的前向维度. LDT >= max(1,N).

Q       (输入/输出) DOUBLE PRECISION array, dimension (LDQ,N)
      输入时，如果 COMPQ = 'V'，则为舒尔向量矩阵 Q。
      退出时，如果 COMPQ = 'V'，Q 已被正交变换矩阵后乘，从而重新排列了 T。
      正交变换矩阵对 T 进行重新排序；Q 的前 M 列构成一个正交变换矩阵。
      Q 的前 M 列构成指定不变子空间的正交基。
      前 M 列构成指定不变子空间的正交基。
      如果 COMPQ = 'N'，则不引用 Q.

LDQ     (输入) INTEGER
      数组 Q 的前向维数。
      LDQ >= 1；如果 COMPQ = 'V'，则 LDQ >= N.

WR      (输出) DOUBLE PRECISION array, dimension (N)
WI      (输出) DOUBLE PRECISION array, dimension (N)
      的实部和虚部。
      的实部和虚部。
      T(i:i+1,i:i+1) 是一个 2 乘 2 的对角线。
      T(i:i+1,i:i+1)是一个 2 乘 2 的对角线块，则 WI(i) > 0 和
      WI(i+1) = -WI(i)。请注意，如果复特征值是
      则其值可能与重新排序前的值相差很大。
      与重新排序前的值相差很大.

M       (输出) INTEGER
      指定不变子空间的维度.
      0 < = M <= N.

S       (输出) DOUBLE PRECISION
      如果 JOB ='E'或 'B'，则 S 是所选特征值组的倒数条件数下限。
      条件数的下限。
      S 不能低估真实的倒易条件数
      不能低估超过 sqrt(N) 倍。如果 M = 0 或 N，S = 1。
      如果 JOB = 'N' 或 'V'，则不引用 S.

SEP     (输出) DOUBLE PRECISION
      如果 JOB ='N'或 'B'，则 SEP 是指定不变子空间的估计倒数条件数。
      条件数。如果
      M = 0 或 N，SEP = norm(T)。
      如果 JOB = 'N' 或 'E'，则不引用 SEP.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。
      如果 JOB = 'N'，LWORK >= max(1,N)；
      如果 JOB = 'E'，LWORK >= max(1,M*(N-M))；
      如果 JOB = 'V' 或 'B'，LWORK >= max(1,2*M*(N-M)).

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

IWORK   (工作区) INTEGER array, dimension (MAX(1,LIWORK))
      退出时，如果 INFO = 0，IWORK(1) 将返回最优 LIWORK.

LIWORK  (输入) INTEGER
      数组 IWORK 的维数。
      如果 JOB = 'N' 或 'E'，LIWORK >= 1；
      如果 JOB = 'V' 或 'B'，LIWORK >= max(1,M*(N-M)).

      如果 LIWORK =-1，则假定进行了工作区查询；例程仅计算 IWORK 数组的最佳大小。
      例程只计算 IWORK 数组的最佳大小、
      返回该值作为 IWORK 数组的第一个条目，并且
      XERBLA 不会发出与 LIWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0: 成功退出
      < 0: 如果 INFO = -i，则第 i 个参数为非法值
      = 1: T 的重新排序失败了，因为某些特征值太接近了（问题的条件很差）。
           太接近（问题的条件很差）；
           T 可能已部分重新排序，而 WR 和 WI
           包含的特征值顺序与 T 中的相同；S 和
           SEP（如有要求）设为零.

更多详情
===============

DTRSEN 首先通过计算正交变换 Z 来收集选定的特征值。
将它们移动到 T 的左上角。
换句话说，选定的特征值是 T11
的特征值。:

            Z'*T*Z = ( T11 T12 ) n1
                     (  0  T22 ) n2
                        n1  n2

其中，N = n1+n2 和 Z' 表示 Z 的转置。
跨越 T 的指定不变子空间.

如果 T 是由矩阵的实薛尔因式分解得到的
A = Q*T*Q'，则 A 的重排序实数舒尔因式分解为
A = (Q*Z)*(Z'*T*Z)*(Q*Z)'，Q*Z 的前 n1 列横跨 A 的相应不变子空间。
的相应不变子空间.

T11 特征值平均值的倒数条件数可以用 S 表示。
S 介于 0（条件非常差）和 1（条件非常好）之间。
和 1（条件非常好）之间。其计算方法如下。首先我们
计算 R

                     P = ( I  R ) n1
                         ( 0  0 ) n2
                           n1 n2

是与 T11 相关的不变子空间上的投影。
R 是西尔维斯特方程的解:

                    T11*R - R*T22 = T12.

让 F-norm(M) 表示 M 的弗罗贝尼斯正则，2-norm(M) 表示
则 S 的计算方法为下界

                  (1 + F-norm(R)**2)**(-1/2)

的倒数，即真正的倒数条件数。
S 不能低估 1 / 2-norm(P)，低估系数不能超过
sqrt(N).

计算出的 T11 平均值的近似误差范围为
的平均值的近似误差范围为

                     EPS * norm(T) / S

其中 EPS 为机器精度.

右不变子空间的倒数条件数
在 SEP 中返回 Z（或 Q*Z）前 n1 列所跨的右不变量子空间的倒数条件数。
SEP 的定义是 T11 和 T22 的分离值:

                 sep( T11, T22 ) = sigma-min( C )

其中，sigma-min(C) 是 n1*n2-by-n1*n2 矩阵的最小奇异值。
n1*n2-by-n1*n2 矩阵的最小奇异值

 C  = kprod( I(n2), T11 ) - kprod( transpose(T22), I(n1) )

I(m) 是 m 乘 m 的同位矩阵，kprod 表示 Kronecker
积。我们通过对 inverse(C) 1-norm 的估计倒数来估计 sigma-min(C)。
的倒数来估计 sigma-min(C)。逆（C）的真实倒数 1-norm
不能与 sigma-min(C)相差超过 sqrt(n1*n2) 的系数.

当 SEP 较小时，T 的微小变化会导致不变子空间的巨大变化。
不变子空间的巨大变化。计算出的右不变子空间的最大角度误差的近似
最大角度误差的近似值为

                  EPS * norm(T) / SEP
"    ));
      end dtrsen;

      pure function dgesvx 
        "求解实数线性方程组 op(A)*X=B，其中 op(A) 根据布尔输入 transposed 的值确定为矩阵 A 或其转置 A'。"
        extends Modelica.Icons.Function;
        input Real A[:,size(A, 1)] "实正方形矩阵 A";
        input Real B[size(A, 1),:] "实数矩阵 B";
        input Boolean transposed = true 
          "= true，如果要解的方程是 A'*X=B";
        output Real X[size(A, 1),size(B, 2)] "解决方案矩阵";
        output Integer info;
        output Real rcond "矩阵 A 的倒数条件数";

      protected
        Integer n = size(A, 1);
        Integer nrhs = size(B, 2);
        String transA = if transposed then "T" else "N";
        Real Awork[size(A, 1),size(A, 2)] = A;
        Real Bwork[size(B, 1),size(B, 2)] = B;
        Real AF[size(A, 1),size(A, 2)];
        Real R[size(A, 1)];
        Real C[size(A, 1)];
        Real ferr[size(B, 2)];
        Real berr[size(B, 2)];
        Integer lda = max(1, size(A, 1));
        Real work[4 * size(A, 1)];
        Integer ipiv[size(A, 1)];
        Integer iwork[size(A, 1)];
        String equed = " ";

      external "FORTRAN 77" dgesvx(
        "N", 
        transA, 
        n, 
        nrhs, 
        Awork, 
        lda, 
        AF, 
        lda, 
        ipiv, 
        equed, 
        R, 
        C, 
        Bwork, 
        lda, 
        X, 
        lda, 
        rcond, 
        ferr, 
        berr, 
        work, 
        iwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info="<html><p>
Lapack 文档<br>用途<br>=======<br><br>DGESVX 使用 LU 因式分解来计算实数线性方程组的解。<br>线性方程组的解<br> A * X = B,<br>其中 A 是 N 乘 N 矩阵，X 和 B 是 N 乘 NRHS 矩阵.<br><br>还提供了解的误差范围和条件估计值<br>提供.<br><br>说明<br>===========<br><br>执行以下步骤:<br><br>1. 如果 FACT = \\'E\\'，则计算实际缩放因子，以平衡系统。<br> 系统:<br> &nbsp; &nbsp;TRANS = \\'N\\': &nbsp;diag(R)*A*diag(C) &nbsp; &nbsp; *inv(diag(C))*X = diag(R)*B<br> &nbsp; &nbsp;TRANS = \\'T\\': (diag(R)*A*diag(C))**T *inv(diag(R))*X = diag(C)*B<br> &nbsp; &nbsp;TRANS = \\'C\\': (diag(R)*A*diag(C))**H *inv(diag(R))*X = diag(C)*B<br> 系统是否平衡取决于矩阵 A 的缩放比例。<br> 矩阵 A 的缩放比例，但如果使用平衡，A 将被 diag(R)*A*diag(C)<br> 被 diag(R)*A*diag(C)覆盖，B 被 diag(R)*B（如果 TRANS=\\'N\\'）<br> 或 diag(C)*B（如果 TRANS=\\'T\\'或\\'C\\'）。.<br><br>2. 如果 FACT = \\'N\\' 或 \\'E\\'，则使用 LU 分解将矩阵 A 分解为<br> 矩阵 A 的因式分解（如果 FACT = \\'E\\'，则在平衡后）为<br> &nbsp; &nbsp;A = P * L * U,<br> 其中，P 是置换矩阵，L 是单位下三角矩阵，U 是上三角矩阵。<br> 矩阵，U 是上三角.<br><br>3. 如果某个 U(i,i)=0 使得 U 恰好是奇异值，那么例程会以 INFO = i 返回。<br> 则例程以 INFO = i 返回。<br> 来估计矩阵 A 的条件数。 如果<br> 条件数的倒数小于机器精度、<br> 则返回 INFO = N+1 作为警告，但例程仍会继续求解 X 并计算误差。<br> 求解 X 并计算误差边界，如下所述.<br><br>4. 利用分解形式求解方程组 X 的.<br><br>5. 应用迭代精化来改进计算出的解<br> 矩阵，并为其计算误差边界和后向误差估计值<br> 的.<br><br>6. 如果使用了平衡，矩阵 X 将被预乘以<br> diag(C)（如果 TRANS=\\'N\\'）或 diag(R)（如果 TRANS=\\'T\\'或 \\'C\\'）进行预乘，以便在平衡之前求解原始系统。<br> 使其在均衡之前求解原始系统.<br><br>论据<br>=========<br><br>FACT &nbsp; &nbsp;(输入) CHARACTER*1<br> &nbsp; &nbsp; &nbsp;指定是否在输入时提供矩阵 A 的分解形式。<br> &nbsp; &nbsp; &nbsp;如果不提供，则在对矩阵 A 进行因子化之前是否应<br> &nbsp; &nbsp; &nbsp;平衡后再进行因子化.<br> &nbsp; &nbsp; &nbsp;= \\'F\\': &nbsp;输入时，AF 和 IPIV 包含 A 的分解形式。<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;如果 EQUED 不为 \\'N\\'，则矩阵 A 已用 R 和 C 给出的缩放因子均衡化。<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;用 R 和 C 给出的缩放因子进行平衡。<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;不修改 A、AF 和 IPIV.<br> &nbsp; &nbsp; &nbsp;= \\'N\\': &nbsp;矩阵 A 将被复制到 AF 并进行分解.<br> &nbsp; &nbsp; &nbsp;= \\'E\\': &nbsp;必要时将对矩阵 A 进行平衡，然后<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;复制到 AF 并进行因式分解.<br><br>TRANS &nbsp; (输入) CHARACTER*1<br> &nbsp; &nbsp; &nbsp;指定方程组的形式:<br> &nbsp; &nbsp; &nbsp;= \\'N\\': &nbsp;A * X = B &nbsp; &nbsp; (无转置)<br> &nbsp; &nbsp; &nbsp;= \\'T\\': &nbsp;A**T * X = B &nbsp;(转置)<br> &nbsp; &nbsp; &nbsp;= \\'C\\': &nbsp;A**H * X = B &nbsp;(转置)<br><br>N &nbsp; &nbsp; &nbsp; (输入) INTEGER<br> &nbsp; &nbsp; &nbsp;线性方程的个数，即矩阵 A 的阶数<br> &nbsp; &nbsp; &nbsp;矩阵 A. &nbsp;N &gt;= 0.<br><br>NRHS &nbsp; &nbsp;(输入) INTEGER<br> &nbsp; &nbsp; &nbsp;右边的数量，即矩阵 B 和 X 的列数<br> &nbsp; &nbsp; &nbsp;矩阵 B 和 X. &nbsp;NRHS &gt;= 0.<br><br>A &nbsp; &nbsp; &nbsp; (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)<br> &nbsp; &nbsp; &nbsp;输入 N 乘 N 矩阵 A。 如果 FACT = \\'F\\'，而 EQUED<br> &nbsp; &nbsp; &nbsp;不是 \\'N\\'，则 A 必须已被 R 和/或 C 中的比例因子平衡。<br> &nbsp; &nbsp; &nbsp;如果 FACT = \\'F\\' 或 \\'N\\'，或者 EQUED = \\'N\\'，则 A 不会被修改。<br> &nbsp; &nbsp; &nbsp;或 FACT = \\'E\\'且 EQUED = \\'N\\'，则 A 不会被修改。.<br><br> &nbsp; &nbsp; &nbsp;退出时，如果 EQUED .ne. \\'N\\'，A 的缩放比例如下:<br> &nbsp; &nbsp; &nbsp;EQUED = \\'R\\': &nbsp;A := diag(R) * A<br> &nbsp; &nbsp; &nbsp;EQUED = \\'C\\': &nbsp;A := A * diag(C)<br> &nbsp; &nbsp; &nbsp;EQUED = \\'B\\': &nbsp;A := diag(R) * A * diag(C).<br><br>LDA &nbsp; &nbsp; (输入) INTEGER<br> &nbsp; &nbsp; &nbsp;数组 A 的前向维度. &nbsp;LDA &gt;= max(1,N).<br><br>AF &nbsp; &nbsp; &nbsp;(输入或输出) DOUBLE PRECISION array, dimension (LDAF,N)<br> &nbsp; &nbsp; &nbsp;如果 FACT = \\'F\\'，则 AF 是一个输入参数，输入时<br> &nbsp; &nbsp; &nbsp;包含由 DGETRF 计算出的因式分解中的因数 L 和 U<br> &nbsp; &nbsp; &nbsp;A = P*L*U 由 DGETRF 计算得出。 如果 EQUED .ne. \\'N\\'，则<br> &nbsp; &nbsp; &nbsp;AF 是平衡矩阵 A 的因式分解形式.<br><br> &nbsp; &nbsp; &nbsp;如果 FACT = \\'N\\'，则 AF 是输出参数，退出时<br> &nbsp; &nbsp; &nbsp;返回原矩阵 A 的因数分解 A = P*L*U 中的因数 L 和 U<br> &nbsp; &nbsp; &nbsp;的因子 L 和 U.<br><br> &nbsp; &nbsp; &nbsp;如果 FACT = \\'E\\'，则 AF 是输出参数，退出时<br> &nbsp; &nbsp; &nbsp;返回均衡矩阵 A 的因数分解 A = P*L*U 中的因数 L 和 U（有关 A 的说明，请参见 A 的说明）。<br> &nbsp; &nbsp; &nbsp;的因数分解 A = P*L*U 中的因数 L 和 U（关于平衡矩阵 A 的形式，请参阅<br> &nbsp; &nbsp; &nbsp;平衡矩阵的形式）。.<br><br>LDAF &nbsp; &nbsp;(输入) INTEGER<br> &nbsp; &nbsp; &nbsp;数组 AF 的前导维数. &nbsp;LDAF &gt;= max(1,N).<br><br>IPIV &nbsp; &nbsp;(输入或输出) INTEGER array, dimension (N)<br> &nbsp; &nbsp; &nbsp;如果 FACT = \\'F\\'，则 IPIV 是一个输入参数，在输入时<br> &nbsp; &nbsp; &nbsp;包含 DGETRF 计算出的因式分解 A = P*L*U 的枢轴索引；矩阵的第 i 行被交换。<br> &nbsp; &nbsp; &nbsp;中的枢轴索引；矩阵的第 i 行与 IPIV(i) 行交换。<br> &nbsp; &nbsp; &nbsp;行 IPIV(i).<br><br> &nbsp; &nbsp; &nbsp;如果 FACT = \\'N\\'，则 IPIV 是一个输出参数，在退出时<br> &nbsp; &nbsp; &nbsp;包含原矩阵 A 的因式分解 A = P*L*U 中的枢轴索引<br> &nbsp; &nbsp; &nbsp;的因式分解中的枢轴索引。.<br><br> &nbsp; &nbsp; &nbsp;如果 FACT = \\'E\\'，则 IPIV 是输出参数，在退出时<br> &nbsp; &nbsp; &nbsp;包含均衡矩阵 A = P*L*U 的因式分解中的枢轴索引<br> &nbsp; &nbsp; &nbsp;的均衡矩阵 A.<br><br>EQUED &nbsp; (输入或输出) CHARACTER*1<br> &nbsp; &nbsp; &nbsp;指定平衡的形式.<br> &nbsp; &nbsp; &nbsp;= \\'N\\': &nbsp;无平衡（如果 FACT = \\'N\\'，则始终为真）.<br> &nbsp; &nbsp; &nbsp;= \\'R\\': &nbsp;行平衡，即 A 已被预乘以<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;diag(R).<br> &nbsp; &nbsp; &nbsp;= \\'C\\': &nbsp;列平衡，即 A 已被 diag(C)<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;乘以 diag(C).<br> &nbsp; &nbsp; &nbsp;= \\'B\\': &nbsp;行平衡和列平衡，即 A 被 diag(R) * A * diag(C)<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;替换为 diag(R) * A * diag(C).<br> &nbsp; &nbsp; &nbsp;如果 FACT = \\'F\\'，EQUED 是输入参数；否则，它是输出参数。<br> &nbsp; &nbsp; &nbsp;输出参数.<br><br>R &nbsp; &nbsp; &nbsp; (输入或输出) DOUBLE PRECISION array, dimension (N)<br> &nbsp; &nbsp; &nbsp;如果 EQUED = \\'R\\' 或 \\'B\\'，A 的左边乘以 diag(R)。<br> &nbsp; &nbsp; &nbsp;在左边乘以 diag(R)；如果 EQUED = \\'N\\' 或 \\'C\\'，则 R<br> &nbsp; &nbsp; &nbsp;则不会被访问。 如果 FACT = \\'F\\'，R 是输入参数；<br> &nbsp; &nbsp; &nbsp;否则，R 是输出参数。 如果 FACT = \\'F\\'，且<br> &nbsp; &nbsp; &nbsp;EQUED = \\'R\\' 或 \\'B\\'，则 R 的每个元素必须是正数.<br><br>C &nbsp; &nbsp; &nbsp; (输入或输出) DOUBLE PRECISION array, dimension (N)<br> &nbsp; &nbsp; &nbsp;如果 EQUED = \\'C\\' 或 \\'B\\'，则 A 右乘以 diag(C)；如果 EQUED = \\'N\\' 或 \\'R\\'，则 C<br> &nbsp; &nbsp; &nbsp;右乘以 diag(C)；如果 EQUED = \\'N\\' 或 \\'R\\'，则不访问 C<br> &nbsp; &nbsp; &nbsp;不会被访问。 如果 FACT = \\'F\\'，C 是输入参数；<br> &nbsp; &nbsp; &nbsp;否则，C 是输出参数。 如果 FACT = \\'F\\'，且<br> &nbsp; &nbsp; &nbsp;EQUED = \\'C\\' 或 \\'B\\'，则 C 的每个元素必须是正数.<br><br>B &nbsp; &nbsp; &nbsp; (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)<br> &nbsp; &nbsp; &nbsp;输入时，是 N-by-NRHS 右边矩阵 B。<br> &nbsp; &nbsp; &nbsp;退出时<br> &nbsp; &nbsp; &nbsp;如果 EQUED = \\'N\\'，则不修改 B；<br> &nbsp; &nbsp; &nbsp;如果 TRANS = \\'N\\'，且 EQUED = \\'R\\' 或 \\'B\\'，则 B 被覆盖为<br> &nbsp; &nbsp; &nbsp;diag(R)*B 覆盖 B；<br> &nbsp; &nbsp; &nbsp;如果 TRANS = \\'T\\' 或 \\'C\\'，且 EQUED = \\'C\\' 或 \\'B\\'，则 B 将被 diag(C)*B 改写<br> &nbsp; &nbsp; &nbsp;被 diag(C)*B 覆盖.<br><br>LDB &nbsp; &nbsp; (输入) INTEGER<br> &nbsp; &nbsp; &nbsp;数组 B 的前向维度. &nbsp;LDB &gt;= max(1,N).<br><br>X &nbsp; &nbsp; &nbsp; (输出) DOUBLE PRECISION array, dimension (LDX,NRHS)<br> &nbsp; &nbsp; &nbsp;如果 INFO = 0 或 INFO = N+1，原方程组的 N-by-NRHS 解矩阵 X<br> &nbsp; &nbsp; &nbsp;是原方程组的 N-by-NRHS 解矩阵 X。 请注意，如果 EQUED .ne<br> &nbsp; &nbsp; &nbsp;如果 EQUED .ne. \\'N\\'，则退出时 A 和 B 会被修改，而<br> &nbsp; &nbsp; &nbsp;如果 TRANS = \\'N\\'，且<br> &nbsp; &nbsp; &nbsp;EQUED=\\'C\\'或\\'B\\'，或 inv(diag(R))*X（如果 TRANS=\\'T\\'或\\'C<br> &nbsp; &nbsp; &nbsp;且 EQUED = \\'R\\' 或 \\'B\\' 时，则 inv(diag(R) *X.<br><br>LDX &nbsp; &nbsp; (输入) INTEGER<br> &nbsp; &nbsp; &nbsp;数组 X 的前向维度. &nbsp;LDX &gt;= max(1,N).<br><br>RCOND &nbsp; (输出) DOUBLE PRECISION<br> &nbsp; &nbsp; &nbsp;矩阵 A 的倒数条件数的估计值<br> &nbsp; &nbsp; &nbsp;A 的倒数条件数的估计值。 如果 RCOND 小于<br> &nbsp; &nbsp; &nbsp;如果 RCOND 小于机器精度（尤其是 RCOND = 0 时），矩阵<br> &nbsp; &nbsp; &nbsp;是工作精度的奇异值。 这种情况<br> &nbsp; &nbsp; &nbsp;返回代码为 INFO &gt; 0.<br><br>FERR &nbsp; &nbsp;(输出) DOUBLE PRECISION array, dimension (NRHS)<br> &nbsp; &nbsp; &nbsp;每个解法向量的估计前向误差边界<br> &nbsp; &nbsp; &nbsp;X(j)（解矩阵 X 的第 j 列）。<br> &nbsp; &nbsp; &nbsp;如果 XTRUE 是与 X(j) 相对应的真实解，那么 FERR(j)<br> &nbsp; &nbsp; &nbsp;是对 (X(j) - X(j) - X(j) 中最大元素大小的估计上限。<br> &nbsp; &nbsp; &nbsp;(X(j) - XTRUE) 中最大元素的大小除以<br> &nbsp; &nbsp; &nbsp;的估计上限。 该估计值与<br> &nbsp; &nbsp; &nbsp;的估计值一样可靠，而且几乎总是略微高估真实误差。<br> &nbsp; &nbsp; &nbsp;高估真实误差.<br><br>BERR &nbsp; &nbsp;(输出) DOUBLE PRECISION array, dimension (NRHS)<br> &nbsp; &nbsp; &nbsp;每个解的分量相对后向误差<br> &nbsp; &nbsp; &nbsp;向量 X(j)的分量相对后向误差（即<br> &nbsp; &nbsp; &nbsp;的最小相对变化）。.<br><br>WORK &nbsp; &nbsp;(工作区/输出) DOUBLE PRECISION array, dimension (4*N)<br> &nbsp; &nbsp; &nbsp;退出时，WORK(1) 包含倒数枢轴增长<br> &nbsp; &nbsp; &nbsp;因子 norm(A)/norm(U)。使用 最大绝对元素规范。<br> &nbsp; &nbsp; &nbsp;使用。如果 WORK(1) 远远小于 1，那么<br> &nbsp; &nbsp; &nbsp;平衡）矩阵 A 的 LU 因式分解的稳定性就会很差。<br> &nbsp; &nbsp; &nbsp;的稳定性就会很差。这也意味着解 X、条件<br> &nbsp; &nbsp; &nbsp;估算器 RCOND 和前向误差约束 FERR 可能不可靠。<br> &nbsp; &nbsp; &nbsp;不可靠。如果因式分解在 0 0: &nbsp;如果 INFO = i，并且 i 是<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&lt;= N: &nbsp;U(i,i) 恰好为零。 因式分解已经完成<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 已经完成，但因子 U 恰好是<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 奇异，因此无法计算解和误差边界。<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 无法计算。返回 RCOND = 0。<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= N+1：U 是非奇异值，但 RCOND 小于机器值<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 精度，即矩阵的奇异<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 到工作精度。 然而<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 解和误差边界的计算，因为<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 在很多情况下<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 计算出的解可能比<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RCOND 的值更精确.<br>
</p>
</html>"      ));
      end dgesvx;

      pure function dtrsyl 
        "求解实希尔维斯特矩阵方程 op(A)*X + X*op(B) = scale*C 或 op(A)*X - X*op(B) = scale*C"
        extends Modelica.Icons.Function;

        input Real A[:,:] "上准三角矩阵";
        input Real B[:,:] "上准三角矩阵";
        input Real C[if tranA then size(A, 1) else size(A, 2),if tranB then size(B, 1) else size(B, 2)] "Right side of the Sylvester equation";

        input Boolean tranA = false "= true，如果 op(A)=A'";
        input Boolean tranB = false "= true，如果 op(B)=B'";
        input Integer isgn = 1 "指定方程中的符号，+1 或 -1";
        output Real X[size(C, 1),size(C, 2)] = C 
          "西尔维斯特方程的解法";
        output Real scale "比例系数";
        output Integer info;
      protected
        Integer m = if tranA then size(A, 1) else size(A, 2);
        Integer n = if tranB then size(B, 1) else size(B, 2);
        String trana = if tranA then "T" else "N";
        String tranb = if tranB then "T" else "N";
        Integer lda = max(1, m);
        Integer ldb = max(1, n);

      external "FORTRAN 77" dtrsyl(
        trana, 
        tranb, 
        isgn, 
        m, 
        n, 
        A, 
        lda, 
        B, 
        ldb, 
        X, 
        lda, 
        scale, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DTRSYL 可求解实西尔维斯特矩阵方程:

 op(A)*X + X*op(B) = scale*C or
 op(A)*X - X*op(B) = scale*C,

其中，op(A) = A 或 A**T，A 和 B 都是上准三角形。
三角形。A 是 M 乘 M，B 是 N 乘 N；右边 C 和
是输出比例因子，设置为
<= 1 以避免 X.

A 和 B 必须是舒尔规范形式（由 DHSEQR 返回），即
即具有 1 乘 1 和 2 乘 2 对角方块的上三角方块；
每个 2×2 对角线块的对角线元素相等，其对角线外元素符号相反
对角元素符号相反.

论据
=========

TRANA   (输入) CHARACTER*1
      指定选项 op(A):
      = 'N': op(A) = A    (无转置)
      = 'T': op(A) = A**T (转置)
      = 'C': op(A) = A**H (共轭转置 = 转置)

TRANB   (输入) CHARACTER*1
      指定操作（B）选项:
      = 'N': op(B) = B    (无转置)
      = 'T': op(B) = B**T (转置)
      = 'C': op(B) = B**H (共轭转置 = 转置)

ISGN    (输入) INTEGER
      指定方程中的符号:
      = +1: 求解运算符（A）*X + X* 运算符（B） = 比例*C
      = -1: 求解运算符（A）*X - X* 运算符（B） = 比例*C

M       (输入) INTEGER
      矩阵 A 的顺序以及矩阵 X 和 C 的行数
      矩阵 X 和 C 的行数. M >= 0.

N       (输入) INTEGER
      矩阵 B 的顺序以及矩阵 X 和 C 的列数
      矩阵 X 和 C 的列数. N >= 0.

A       (输入) DOUBLE PRECISION array, dimension (LDA,M)
      舒尔规范形式的上准三边矩阵 A.

LDA     (输入) INTEGER
      数组 A 的前向维度. LDA >= max(1,M).

B       (输入) DOUBLE PRECISION array, dimension (LDB,N)
      舒尔规范形式的上准三边矩阵 B.

LDB     (输入) INTEGER
      数组 B 的前向维度. LDB >= max(1,N).

C       (输入/输出) DOUBLE PRECISION array, dimension (LDC,N)
      输入时，是 M 乘 N 的右边矩阵 C。
      退出时，C 会被解矩阵 X.

LDC     (输入) INTEGER
      数组 C 的前向维度. LDC >= max(1,M)

SCALE   (输出) DOUBLE PRECISION
      缩放因子，scale，设置 <= 1 以避免在 X 中溢出.

INFO    (输出) INTEGER
      = 0: 成功退出
      < 0: 如果 INFO = -i，则第 i 个参数为非法值
      = 1: A 和 B 有共同或非常接近的特征值；扰动的
           值用于解方程（但矩阵
           A 和 B 保持不变）.
"    ));
      end dtrsyl;

      pure function dhseqr 
        "使用针对海森伯形式矩阵的 lapack 例程 DHSEQR 计算矩阵 H 的特征值"
        extends Modelica.Icons.Function;

        input Real H[:,size(H, 1)] "具有海森伯形式的矩阵 H";
        input Boolean eigenValuesOnly = true 
          "= true，如果只计算特征值，否则也计算舒尔形式";
        input String compz = "N" "指定舒尔向量的计算方法";
        input Real Z[:,:] = H "矩阵 Z";
        output Real alphaReal[size(H, 1)] 
          "alpha 的实部（特征值=（alphaReal+i*alphaImag）";
        output Real alphaImag[size(H, 1)] 
          "alpha 的虚部（特征值=（alphaReal+i*alphaImag）";
        output Integer info;
        output Real Ho[:,:] = H 
          "舒尔分解（若仅特征值===false，否则未指定）";
        output Real Zo[:,:] = Z;
        output Real work[3 * max(1, size(H, 1))];

      protected
        Integer n = size(H, 1);
        String job = if eigenValuesOnly then "E" else "S";
        Integer ilo = 1;
        Integer ihi = n;
        Integer ldh = max(n, 1);
        Integer lwork = 3 * max(1, size(H, 1)) 
          "dhseqr 中使用的 dwork 数组的尺寸";

      external "FORTRAN 77" dhseqr(
        job, 
        compz, 
        n, 
        ilo, 
        ihi, 
        Ho, 
        ldh, 
        alphaReal, 
        alphaImag, 
        Zo, 
        ldh, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info="<html><p>
Lapack 文档<br>用途<br>=======<br><br>DHSEQR 可以计算海森伯矩阵 H 的特征值，以及舒尔分解矩阵 T 和 Z 的特征值。<br>的特征值，以及可选的舒尔分解矩阵 T 和 Z 的特征值<br>H = Z T Z**T，其中 T 是上准三角形矩阵（舒尔形式），Z 是舒尔向量的正交矩阵.<br><br>可选择将 Z 后乘以输入的正交矩阵 Q，这样该例程就能给出舒尔因式分解。<br>矩阵 Q，这样该例程就能给出矩阵 A 的舒尔因式分解。<br>矩阵 A 的舒尔因式分解。<br>的矩阵 A 进行舒尔因式分解：A = Q*H*Q**T = (QZ)*T*(QZ)**T.<br><br>论据<br>=========<br><br>JOB &nbsp; (输入) CHARACTER*1<br> &nbsp; &nbsp;= \\\\'E\\\\': &nbsp;只计算特征值;<br> &nbsp; &nbsp;= \\\\'S\\\\': &nbsp;计算特征值和舒尔形式 T.<br><br>COMPZ (输入) CHARACTER*1<br> &nbsp; &nbsp;= \\\\'N\\\\': &nbsp;不计算舒尔向量;<br> &nbsp; &nbsp;= \\\\'I\\\\': &nbsp;Z 被初始化为单位矩阵，H 的舒尔向量矩阵 Z<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;返回 H 的舒尔向量矩阵 Z;<br> &nbsp; &nbsp;= \\\\'V\\\\': &nbsp;Z 的入口必须包含一个正交矩阵 Q，并且<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;返回乘积 Q*Z.<br><br>N &nbsp; &nbsp; (输入) INTEGER<br> &nbsp; &nbsp;矩阵 H 的阶数. &nbsp;N &gt;= 0.<br><br>ILO &nbsp; (输入) INTEGER<br>IHI &nbsp; (输入) INTEGER<br> &nbsp; &nbsp;假设 H 的行列 1:ILO-1 和列 IHI+1:N 已经是上三角形。<br> &nbsp; &nbsp;和列 1:ILO-1 和 IHI+1:N 已是上三角形。ILO 和 IHI 通常<br> &nbsp; &nbsp;通常由之前调用 DGEBAL 时设置，然后在 DGEBAL 输出的矩阵还原为荷叶边矩阵时传递给 DGEHRD。<br> &nbsp; &nbsp;当 DGEBAL 输出的矩阵还原为海森伯形式时，再将其传递给 DGEHRD<br> &nbsp; &nbsp;形式。否则 ILO 和 IHI 应分别设置为 1 和 N。<br> &nbsp; &nbsp;分别设置为 1 和 N。 如果 N&gt;0，则 1&lt;=ILO&lt;=IHI&lt;=N。<br> &nbsp; &nbsp;如果 N = 0，则 ILO = 1，IHI = 0.<br><br>H &nbsp; &nbsp; (输入/输出) DOUBLE PRECISION array, dimension (LDH,N)<br> &nbsp; &nbsp;输入时，是上海森堡矩阵 H。<br> &nbsp; &nbsp;退出时，如果 INFO = 0 且 JOB = \\\\'S\\\\'，则 H 包含舒尔分解的上准三角形矩阵 T。<br> &nbsp; &nbsp;上准三角形矩阵 T 的舒尔分解（舒尔形式<br> &nbsp; &nbsp;(舒尔形式）；2 乘 2 的对角线块（对应于<br> &nbsp; &nbsp;对角块（对应于特征值的复共轭对）以标准形式返回。<br> &nbsp; &nbsp;标准形式返回，H(i,i) = H(i+1,i+1) 和<br> &nbsp; &nbsp;H(i+1,i)*H(i,i+1)&lt;0.<br> &nbsp; &nbsp;则在退出时不指定 H 的内容。 (当 INFO&gt;0 时<br> &nbsp; &nbsp;的输出值）。<br> &nbsp; &nbsp;的描述中给出）。<br><br> &nbsp; &nbsp;与早期版本的 DHSEQR 不同，该子程序可以<br> &nbsp; &nbsp;在 i&gt;j 和 j = 1、2、...时，显式 H(i,j) = 0 ILO-1<br> &nbsp; &nbsp;或 j = IHI+1, IHI+2, ... N.<br>LDH &nbsp; (输入) INTEGER<br> &nbsp; &nbsp;数组 H 的前向维度. LDH &gt;= max(1,N).<br><br>WR &nbsp; &nbsp;(输出) DOUBLE PRECISION array, dimension (N)<br>WI &nbsp; &nbsp;(输出) DOUBLE PRECISION array, dimension (N)<br> &nbsp; &nbsp;分别是计算出的特征值的实部和虚部。<br> &nbsp; &nbsp;的实部和虚部。如果计算出的两个特征值是一对复<br> &nbsp; &nbsp;如果两个特征值被计算为一对复共轭，它们将被存储在<br> &nbsp; &nbsp;WR 和 WI 中的连续元素，例如第 i 个和第 (i+1)th 个元素，WI(i) &gt; 0，WI(i+1) &lt; 0。<br> &nbsp; &nbsp;如果 JOB = \\\\'S\\\\'，特征值的存储顺序与对角线上的顺序相同。<br> &nbsp; &nbsp;与 H 中返回的舒尔表格对角线上的特征值顺序相同。<br> &nbsp; &nbsp;中的对角线顺序存储，WR(i) = H(i,i)，如果 H(i:i+1,i:i+1) 是一个 2-by-2<br> &nbsp; &nbsp;对角块，则 WI(i) = sqrt(-H(i+1,i)*H(i,i+1)) 和<br> &nbsp; &nbsp;WI(i+1) = -WI(i).<br><br>Z &nbsp; &nbsp; (输入/输出) DOUBLE PRECISION array, dimension (LDZ,N)<br> &nbsp; &nbsp;如果 COMPZ = \\\\'N\\\\'，则不引用 Z。<br> &nbsp; &nbsp;如果 COMPZ = \\\\'I\\\\'，则在进入和退出时无需设置 Z、<br> &nbsp; &nbsp;如果 INFO = 0，则 Z 包含 H 的舒尔向量的正交矩阵 Z。<br> &nbsp; &nbsp;如果 COMPZ = \\\\'V\\\\'，入口 Z 必须包含一个 N-by-N 矩阵 Q。<br> &nbsp; &nbsp;如果 COMPZ = \\\\'V\\\\'，Z 的入口必须包含一个 N 乘 N 的矩阵 Q，假定它等于单位矩阵。<br> &nbsp; &nbsp;子矩阵 Z（ILO:IHI,ILO:IHI）除外。退出时<br> &nbsp; &nbsp;如果 INFO = 0，则 Z 包含 Q*Z。<br> &nbsp; &nbsp;通常 Q 是 DORGHR<br> &nbsp; &nbsp;生成的正交矩阵。<br> &nbsp; &nbsp;当 INFO&gt;0 时 Z 的输出值在下面的 INFO 说明中给出）。<br> &nbsp; &nbsp;的说明中给出）。<br><br>LDZ &nbsp; (输入) INTEGER<br> &nbsp; &nbsp;如果 COMPZ = \\\\'I\\\\' 或<br> &nbsp; &nbsp;则 LDZ&gt;=MAX(1,N) 。 否则，LDZ&gt;=1.<br><br>WORK &nbsp;(工作区/输出) DOUBLE PRECISION array, dimension (LWORK)<br> &nbsp; &nbsp;退出时，如果 INFO = 0，WORK(1) 将返回 LWORK 的最优值估计值。<br> &nbsp; &nbsp;的最优值.<br><br>LWORK (输入) INTEGER<br> &nbsp; &nbsp;数组 WORK 的维数。 LWORK &gt;= max(1,N)<br> &nbsp; &nbsp;就足够了，它能提供非常好的<br> &nbsp; &nbsp;最佳性能。 不过，要达到最佳性能，LWORK 可能需要大到 11*N<br> &nbsp; &nbsp;才能达到最佳性能。 工作区<br> &nbsp; &nbsp;查询来确定最佳工作区<br> &nbsp; &nbsp;大小.<br><br> &nbsp; &nbsp;如果 LWORK =-1，则 DHSEQR 会进行工作区查询。<br> &nbsp; &nbsp;在这种情况下，DHSEQR 会检查输入参数并<br> &nbsp; &nbsp;估算给定值 N、ILO 和 IHI 的最佳工作区大小。<br> &nbsp; &nbsp;值的最佳工作区大小。 估算结果将在<br> &nbsp; &nbsp;在 WORK(1) 中返回。 XERBLA 不会发出与 LWORK 有关的错误信息。<br> &nbsp; &nbsp;XERBLA 不会发出与 LWORK 有关的错误信息。 H 和 Z 均未被访问.<br><br>INFO &nbsp;(输出) INTEGER<br> &nbsp; &nbsp;= 0: 成功退出<br> &nbsp; &nbsp;&lt; 0: 如果 INFO = -i，说明第 i 个参数的值不合法。<br> &nbsp; &nbsp; &nbsp; &nbsp; 值<br> &nbsp; &nbsp;&gt; 0: 如果 INFO = i，则 DHSEQR 计算所有特征值失败。<br> &nbsp; &nbsp; &nbsp; &nbsp; 特征值。 WR 和 WI 的元素 1:ilo-1 和 i+1:n<br> &nbsp; &nbsp; &nbsp; &nbsp; 和 WI 中的元素 1:ilo-1 和 i+1:n 包含已成功计算的特征值。<br> &nbsp; &nbsp; &nbsp; &nbsp; 成功计算的特征值。 (计算失败的情况很少见）。<br><br> &nbsp; &nbsp; &nbsp; &nbsp; 如果 INFO &gt; 0 且 JOB = \\\\'E\\\\'，那么退出时<br> &nbsp; &nbsp; &nbsp; &nbsp; 则在退出时，剩余的未求和特征值为上海森伯矩阵行的特征值和<br> &nbsp; &nbsp; &nbsp; &nbsp; 值。<br> &nbsp; &nbsp; &nbsp; &nbsp; 列的特征值。<br> &nbsp; &nbsp; &nbsp; &nbsp; 的特征值.<br><br> &nbsp; &nbsp; &nbsp; &nbsp; 如果 INFO &gt; 0 且 JOB = \\\\'S\\\\'，则在退出时<br><br> &nbsp; &nbsp;(*) &nbsp;(initial value of H)*U &nbsp;= U*(final value of H)<br><br> &nbsp; &nbsp; &nbsp; &nbsp; 其中 U 是一个正交矩阵。 最终<br> &nbsp; &nbsp; &nbsp; &nbsp; H 的最终值是上黑森伯格和准三角形的<br> &nbsp; &nbsp; &nbsp; &nbsp; 行和列 INFO+1 至 IHI.<br><br> &nbsp; &nbsp; &nbsp; &nbsp; 如果 INFO &gt; 0 且 COMPZ = \\\\'V\\\\'，则在退出时<br><br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (final value of Z) &nbsp;= &nbsp;(initial value of Z)*U<br><br> &nbsp; &nbsp; &nbsp; &nbsp; 其中 U 是 (*) 中的正交矩阵（与 JOB 值无关）。<br> &nbsp; &nbsp; &nbsp; &nbsp; 的数值）。<br><br> &nbsp; &nbsp; &nbsp; &nbsp; 如果 INFO &gt; 0 且 COMPZ = \\\\'I\\\\'，则退出时<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (Z 的最终值）= U<br> &nbsp; &nbsp; &nbsp; &nbsp; 其中 U 是 (*) 中的正交矩阵（无论<br> &nbsp; &nbsp; &nbsp; &nbsp; 的正交矩阵）。<br><br> &nbsp; &nbsp; &nbsp; &nbsp; 如果 INFO &gt; 0 且 COMPZ = \\\\'N\\\\'，则不会访问 Z<br> &nbsp; &nbsp; &nbsp; &nbsp; 访问.<br>
</p>
</html>"));
      end dhseqr;

      pure function dlange "矩阵的范数"
        extends Modelica.Icons.Function;

        input Real A[:,:] "实矩阵 A";
        input String norm = "1" "指定标准, i.e., 1, I, F, M";
        output Real anorm "A 的常模";
      protected
        Integer m = size(A, 1);
        Integer n = size(A, 2);
        Integer lda = max(1, size(A, 1));
        Real work[lda];

      external "FORTRAN 77" anorm = dlange(
        norm, 
        m, 
        n, 
        A, 
        lda, 
        work) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DLANGE 返回一规范值、弗罗贝尼斯规范值、无穷大规范值或
无穷规范，或实数矩阵 A 的最大绝对值元素。
实矩阵 A.

说明
===========

DLANGE returns the value

 DLANGE = ( max(abs(A(i,j))), NORM = 'M' or 'm'
          (
          ( norm1(A),         NORM = '1', 'O' or 'o'
          (
          ( normI(A),         NORM = 'I' or 'i'
          (
          ( normF(A),         NORM = 'F', 'f', 'E' or 'e'

其中，norm1 表示矩阵的一规范（最大列和）、
normI 表示矩阵的无穷大规范（最大行和），以及
normF 表示矩阵的弗罗贝尼斯法（平方和的平方根）。
平方根）。 请注意，max(abs(A(i,j))) 并不是一致的矩阵规范。

论据
=========

NORM    (输入) CHARACTER*1
      在 DLANGE 中指定要返回的值，如上文所述
      中返回的值。.

M       (输入) INTEGER
      矩阵 A 的行数。 当 M = 0 时，M >= 0、
      DLANGE 设置为零.

N       (输入) INTEGER
      矩阵 A 的列数。 当 N = 0 时，DLANGE 设置为零、
      DLANGE 设置为零.

A       (输入) DOUBLE PRECISION array, dimension (LDA,N)
      m 乘 n 矩阵 A.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(M,1).

WORK    (工作区) DOUBLE PRECISION array, dimension (MAX(1,LWORK)),
      当 NORM = 'I' 时，LWORK >= M；否则，WORK 不被引用。
      引用.
"          ));

      end dlange;

      pure function dgecon 
        "估计一般实矩阵 A 的条件数倒数"
        extends Modelica.Icons.Function;

        input Real LU_of_A[:,:] "实矩阵 A 的 LU 因式分解";
        input Boolean inf = false 
          "使用无穷规范时为 true，使用 1 规范时为 false";
        input Real anorm "A 的常模";
        output Real rcond "A 的互易条件数";
        output Integer info;
      protected
        Integer n = size(LU_of_A, 2);
        Integer lda = max(1, size(LU_of_A, 1));
        Real work[4 * size(LU_of_A, 2)];
        Integer iwork[size(LU_of_A, 2)];
        String norm = if inf then "I" else "1";

      external "FORTRAN 77" dgecon(
        norm, 
        n, 
        LU_of_A, 
        lda, 
        anorm, 
        rcond, 
        work, 
        iwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGECON 可以估算一般实矩阵 A 的条件数倒数。
用 DGETRF 计算出的 LU 因式分解来估算一般实矩阵 A 的条件数倒数。
DGETRF 计算出的 LU 因式分解.

可以得到 norm(inv(A)) 的估计值，并计算出条件数的倒数。
条件数的倒数计算公式为
 RCOND = 1 / ( norm(A) * norm(inv(A)) ).

论据
=========

NORM    (输入) CHARACTER*1
      指定需要使用 1 正态条件编号还是无穷正态条件编号。
      无穷正态条件号:
      = '1' or 'O':  1-norm;
      = 'I':         Infinity-norm.

N       (输入) INTEGER
      矩阵 A 的阶数.  N >= 0.

A       (输入) DOUBLE PRECISION array, dimension (LDA,N)
      因子 A = P*L*U 中的因子 L 和 U
      计算得出的.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,N).

ANORM   (输入) DOUBLE PRECISION
      如果 NORM = '1' 或 'O'，则为原始矩阵 A 的 1 正。
      如果 NORM = 'I'，则为原始矩阵 A 的无穷正.

RCOND   (输出) DOUBLE PRECISION
      矩阵 A 的条件数倒数、
      计算公式为 RCOND = 1/(norm(A) * norm(inv(A))).

WORK    (工作区) DOUBLE PRECISION array, dimension (4*N)

IWORK   (工作区) INTEGER array, dimension (N)

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dgecon;

      pure function dgehrd 
        "通过正交相似变换，将实数普通矩阵 A 还原为上海森堡形式 H：  Q' * A * Q = H"
        extends Modelica.Icons.Function;

        input Real A[:,size(A, 1)];
        input Integer ilo = 1 
          "原矩阵不是上三角形式的最低指数";
        input Integer ihi = size(A, 1) 
          "原矩阵不是上三角形式的最高指数";
        output Real Aout[size(A, 1),size(A, 2)] = A 
          "在上三角和第一对角线中包含海森伯形式，在第一对角线下方包含基本反射器，它表示（与阵列 tau）正交矩阵 Q 的乘积";
        output Real tau[max(size(A, 1), 1) - 1] 
          "基本反射器的标量系数";
        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer lda = max(1, n);
        Integer lwork = max(1, 3 * n);
        Real work[max(1, 3 * size(A, 1))];

      external "FORTRAN 77" dgehrd(
        n, 
        ilo, 
        ihi, 
        Aout, 
        lda, 
        tau, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info="<html><p>
<strong>Lapack 文档<br>用途<br>=======<br><br>DGEHRD 通过正交相似变换将实数一般矩阵 A 还原为上海森堡形式 H。<br>正交相似变换： &nbsp;Q\\\\\\' * A * Q = H .<br><br>论据<br>=========<br><br>N &nbsp; &nbsp; &nbsp; (输入) INTEGER<br> &nbsp; &nbsp; &nbsp;矩阵 A 的阶数. &nbsp;N &gt;= 0.<br><br>ILO &nbsp; &nbsp; (输入) INTEGER<br>IHI &nbsp; &nbsp; (输入) INTEGER<br> &nbsp; &nbsp; &nbsp;假设 A 的行列 1:ILO-1 和列 IHI+1:N 已经是上三角形。<br> &nbsp; &nbsp; &nbsp;和列 1:ILO-1 和 IHI+1:N 已是上三角形。ILO 和 IHI<br> &nbsp; &nbsp; &nbsp;通常由之前调用 DGEBAL 设置，否则应分别设置为 1 和 N。<br> &nbsp; &nbsp; &nbsp;分别设置为 1 和 N。参见更多详情。<br> &nbsp; &nbsp; &nbsp;1 &lt;= ILO &lt;= IHI &lt;= N，如果 N &gt; 0；ILO=1 和 IHI=0，如果 N=0.<br><br>A &nbsp; &nbsp; &nbsp; (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)<br> &nbsp; &nbsp; &nbsp;输入时，是要缩小的 N 乘 N 的普通矩阵。<br> &nbsp; &nbsp; &nbsp;退出时，A 的上三角和第一对角线将被上海森伯矩阵 H 所覆盖。<br> &nbsp; &nbsp; &nbsp;的上三角和第一个对角线用上层海森堡矩阵 H 覆盖，而<br> &nbsp; &nbsp; &nbsp;第一个子对角线以下的元素用数组 TAU 覆盖、<br> &nbsp; &nbsp; &nbsp;表示正交矩阵 Q，是基本<br> &nbsp; &nbsp; &nbsp;反射器的乘积。更多详情.<br><br>LDA &nbsp; &nbsp; (输入) INTEGER<br> &nbsp; &nbsp; &nbsp;数组 A 的前向维度. &nbsp;LDA &gt;= max(1,N).<br><br>TAU &nbsp; &nbsp; (输出) DOUBLE PRECISION array, dimension (N-1)<br> &nbsp; &nbsp; &nbsp;基本反射器的标量因数（见更多<br> &nbsp; &nbsp; &nbsp;详细信息）。TAU 的元素 1:ILO-1 和 IHI:N-1 设置为<br> &nbsp; &nbsp; &nbsp;为零.<br><br>WORK &nbsp; &nbsp;(工作区/输出) DOUBLE PRECISION array, dimension (LWORK)<br> &nbsp; &nbsp; &nbsp;退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK.<br><br>LWORK &nbsp; (输入) INTEGER<br> &nbsp; &nbsp; &nbsp;数组 WORK 的长度。 LWORK &gt;= max(1,N)。<br> &nbsp; &nbsp; &nbsp;为获得最佳性能，LWORK &gt;= N*NB，其中 NB 是<br> &nbsp; &nbsp; &nbsp;最佳块大小.<br><br> &nbsp; &nbsp; &nbsp;如果 LWORK =-1，则假定是工作区查询；例程<br> &nbsp; &nbsp; &nbsp;例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。<br> &nbsp; &nbsp; &nbsp;作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。<br> &nbsp; &nbsp; &nbsp;XERBLA 不会发出与 LWORK 有关的错误信息.<br><br>INFO &nbsp; &nbsp;(输出) INTEGER<br> &nbsp; &nbsp; &nbsp;= 0: &nbsp;成功退出<br> &nbsp; &nbsp; &nbsp;&lt; 0: &nbsp;如果 INFO = -i，则第 i 个参数为非法值.<br><br>更多详情<br>===============<br><br>矩阵 Q 表示为（ihi-ilo）基本<br>反射器<br><br> Q = H(ilo) H(ilo+1) . . . H(ihi-1).<br><br>每个 H(i) 的形式为<br><br> H(i) = I - tau * v * v\\\\\\'<br><br>其中，tau 是实数标量，v 是实数矢量，其中<br>v(1:i)=0，v(i+1)=1，v(ihi+1:n)=0；v(i+2:ihi)在退出时存储在 A(i+2:ihi,i) 中。<br>退出时，v(i+2:ihi,i) 保存在 A(i+2:ihi,i)，tau 保存在 TAU(i).<br><br>下面的例子说明了 A 的内容，其中<br>n = 7、ilo = 2 和 ihi = 6:<br><br>on entry, &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;on exit,<br><br>( a &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a ) &nbsp; &nbsp;( &nbsp;a &nbsp; a &nbsp; h &nbsp; h &nbsp; h &nbsp; h &nbsp; a )<br>( &nbsp; &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a ) &nbsp; &nbsp;( &nbsp; &nbsp; &nbsp;a &nbsp; h &nbsp; h &nbsp; h &nbsp; h &nbsp; a )<br>( &nbsp; &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a ) &nbsp; &nbsp;( &nbsp; &nbsp; &nbsp;h &nbsp; h &nbsp; h &nbsp; h &nbsp; h &nbsp; h )<br>( &nbsp; &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a ) &nbsp; &nbsp;( &nbsp; &nbsp; &nbsp;v2 &nbsp;h &nbsp; h &nbsp; h &nbsp; h &nbsp; h )<br>( &nbsp; &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a ) &nbsp; &nbsp;( &nbsp; &nbsp; &nbsp;v2 &nbsp;v3 &nbsp;h &nbsp; h &nbsp; h &nbsp; h )<br>( &nbsp; &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a &nbsp; a ) &nbsp; &nbsp;( &nbsp; &nbsp; &nbsp;v2 &nbsp;v3 &nbsp;v4 &nbsp;h &nbsp; h &nbsp; h )<br>( &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; a ) &nbsp; &nbsp;( &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;a )<br><br>其中，a 表示原始矩阵 A 的元素，h 表示上海森伯矩阵 H 的修正元素，vi 表示原始矩阵 A 的元素。<br>表示上海森堡矩阵 H 的修正元素，vi 表示定义 H(i) 的向量的元素。<br>定义 H(i) 的向量的元素.<br></strong>
</p>
</html>"));
      end dgehrd;

      pure function dgeqrf "计算 QR 因式分解，无需旋转"
        extends Modelica.Icons.Function;

        input Real A[:,:] "正方形或矩形矩阵";
        output Real Aout[size(A, 1),size(A, 2)] = A 
          "阵列的上三角包含上梯形矩阵 R；对角线以下的元素与阵列 TAU 一起，表示正交矩阵 Q，是基本反射器的乘积";
        output Real tau[min(size(A, 1), size(A, 2))] 
          "基本反射器的标量系数";
        output Integer info;
        output Real work[3 * max(1, size(A, 2))];
      protected
        Integer m = size(A, 1);
        Integer n = size(A, 2);
        Integer lda = max(1, m);
        Integer lwork = 3 * max(1, n);

      external "FORTRAN 77" dgeqrf(
        m, 
        n, 
        Aout, 
        lda, 
        tau, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGEQRF 计算 M 乘 N 实矩阵 A 的 QR 因式分解:
A = Q * R.

论据
=========

M       (输入) INTEGER
      矩阵 A 的行数.  M >= 0.

N       (输入) INTEGER
      矩阵 A 的列数.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      入口为 M 乘 N 矩阵 A。
      退出时，数组对角线上和对角线以上的元素
      包含最小（M,N）乘 N 的上梯形矩阵 R（如果 m >= n，则 R
      如果 m >= n，则 R 为上三角）；对角线以下的元素与数组 TAU 一起，代表矩阵 A、
      用数组 TAU 表示正交矩阵 Q，作为
      的乘积（见更多
      详情）.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,M).

TAU     (输出) DOUBLE PRECISION array, dimension (min(M,N))
      基本反射器的标量因数（见更多
      详情）.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。 LWORK >= max(1,N)。
      为获得最佳性能，LWORK >= N*NB，其中 NB 为
      最佳块大小.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值

更多详情
===============

矩阵 Q 表示为基本反射器的乘积

 Q = H(1) H(2) . . . H(k), 其中 k = min(m,n).

每个 H(i) 的形式为

 H(i) = I - tau * v * v'

其中 tau 是实数标量，v 是实数矢量，其中
v(1:i-1)=0，v(i)=1；v(i+1:m) 在退出时存储在 A(i+1:m,i) 中、
和 tau 保存在 TAU(i).
"    ));
      end dgeqrf;

      pure function dgeevx 
        "使用 lapack 例程 dgeevx 计算矩阵 A 的特征值和（实）左右特征向量"
        extends Modelica.Icons.Function;

        input Real A[:,size(A, 1)];
        output Real alphaReal[size(A, 1)] 
          "alpha 的实部（特征值=（alphaReal+i*alphaImag）";
        output Real alphaImag[size(A, 1)] 
          "alpha 的虚部（特征值=（alphaReal+i*alphaImag）";
        output Real lEigenVectors[size(A, 1),size(A, 1)] 
          "矩阵 A 的左特征向量";
        output Real rEigenVectors[size(A, 1),size(A, 1)] 
          "矩阵 A 的右特征向量";
        output Real AS[size(A, 1),size(A, 2)] = A 
          "AS 是输入矩阵 A 的平衡版本的实数舒尔形式";
        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer ilo;
        Integer ihi;
        Real scale[size(A, 1)];
        Real abnrm;
        Real rconde[size(A, 1)];
        Real rcondv[size(A, 1)];
        Integer lwork = n * (n + 6);
        Real work[size(A, 1) * (size(A, 1) + 6)];
        Integer iwork[1];

      external "FORTRAN 77" dgeevx(
        "B", 
        "V", 
        "V", 
        "E", 
        n, 
        AS, 
        n, 
        alphaReal, 
        alphaImag, 
        lEigenVectors, 
        n, 
        rEigenVectors, 
        n, 
        ilo, 
        ihi, 
        scale, 
        abnrm, 
        rconde, 
        rcondv, 
        work, 
        lwork, 
        iwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGEEVX 可计算 N 乘 N 的实非对称矩阵 A 的
的特征值，以及可选的左特征向量和/或右特征向量.

它还可以选择计算平衡变换，以改善
特征值和特征向量（ILO、IHI、
SCALE、ABNRM）、特征值的倒数条件数（RCONDE
(RCONDE) 和右特征向量的倒易条件数 (RCONDV)
右特征向量的倒易条件数 (RCONDV).

A 的右特征向量 v(j) 满足以下条件
               A * v(j) = lambda(j) * v(j)
其中 lambda(j) 是其特征值。
A 的左特征向量 u(j) 满足以下条件
            u(j)**H * A = lambda(j) * u(j)**H
其中，u(j)**H 表示 u(j) 的共轭转置.

计算出的特征向量进行归一化处理，使其欧氏常态
等于 1，最大分量为实数.

平衡矩阵是指对矩阵的行列进行排列，使其更接近上三角，并应用对角线相似性。
使其更接近上三角，并应用对角线相似性变换
变换 D * A * D**(-1)，其中 D 是对角矩阵，使其行和列的法线与条件数更接近。
使其行和列的规范更接近，并使其特征值和特征值的条件数
使其特征值和特征向量的条件数更小。 计算出的
倒数条件数对应于平衡矩阵。
行列对换不会改变条件数
(精确算术），但对角线缩放会。 关于平衡的进一步
平衡的进一步解释，请参见《LAPACK 用户指南》第 4.10.2 节。
用户指南》第 4.10.2 节.

论据
=========

BALANC  (输入) CHARACTER*1
      表示输入矩阵应如何进行对角缩放
      和/或进行排列，以改善其
      特征值.
      = 'N': 请勿按对角线方向缩放或排列;
      = 'P': 进行排列，使矩阵更接近
             上三角。不要按对角线方向缩放;
      = 'S': 将矩阵对角线缩放，即用以下公式替换 A
             D*A*D**(-1)，其中 D 是一个对角矩阵。
             使 A 的行和列在规范上更相等。
             规范。不要进行置换;
      = 'B': 都对 A 进行对角缩放和排列.

      计算出的倒数条件数将是矩阵
      的倒数条件数。置换不会改变
      条件数（精确算术），但平衡会.

JOBVL   (输入) CHARACTER*1
      = 'N': 不计算 A 的左特征向量;
      = 'V': 计算 A 的左特征向量。
      如果 SENSE ='E'或 'B'，则 JOBVL 必须 ='V'。.

JOBVR   (输入) CHARACTER*1
      = 'N': 不计算 A 的右特征向量;
      = 'V': 计算出 A 的右特征向量.
      如果 SENSE = 'E' 或 'B'，JOBVR 必须 = 'V'.

SENSE   (输入) CHARACTER*1
      决定计算哪些倒数条件数.
      = 'N': 没有计算;
      = 'E': 仅计算特征值;
      = 'V': 只计算右特征向量;
      = 'B': 计算特征值和右特征向量.

      如果 SENSE = 'E' 或 'B'，则还必须计算左右两个特征向量（JOBVL = 'V' 和 JOBVR = 'V'）。
      还必须计算（JOBVL = 'V' 和 JOBVR = 'V').

N       (输入) INTEGER
      矩阵 A 的阶数. N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      输入时，是 N 乘 N 矩阵 A。
      退出时，A 已被覆盖。 如果 JOBVL = 'V' 或
      JOBVR = 'V'，则 A 包含输入矩阵 A 的平衡版本的实数舒尔形式。
      输入矩阵 A.

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,N).

WR      (输出) DOUBLE PRECISION array, dimension (N)
WI      (输出) DOUBLE PRECISION array, dimension (N)
      WR 和 WI 包含实部和虚部、
      分别包含计算出的特征值的实部和虚部。复
      特征值的复共轭对将连续出现
      具有正虚部的特征值
      第一个.

VL      (输出) DOUBLE PRECISION array, dimension (LDVL,N)
      如果 JOBVL ='V'，则左特征向量 u(j) 将一个接一个地存储在 VL 列中。
      与特征值的顺序相同。
      与其特征值的顺序相同。
      如果 JOBVL = 'N'，则不引用 VL。
      如果第 j 个特征值为实数，则 u(j) = VL(:,j)、
      即 VL 的第 j 列。
      如果第 j 和 (j+1)-st 个特征值构成一对复
      共轭对，则 u(j) = VL(:,j) + i*VL(:,j+1) and
      u(j+1) = VL(:,j) - i*VL(:,j+1).

LDVL    (输入) INTEGER
      数组 VL 的前向维数。 LDVL >= 1; if
      jobvl = 'v', ldvl >= n.

VR      (输出) DOUBLE PRECISION array, dimension (LDVR,N)
      如果 JOBVR = 'V'，则右特征向量 v(j) 将按相同顺序逐个存储在 VR 列中。
      与特征值的顺序相同。
      与其特征值的顺序相同。
      如果 JOBVR = 'N'，则不引用 VR。
      如果第 j 个特征值为实数，则 v(j) = VR(:,j)、
      即 VR 的第 j 列。
      如果第 j 和 (j+1)-st 个特征值构成一对复
      共轭对，则 v(j) = VR(:,j) + i*VR(:,j+1) and
      v(j+1) = VR(:,j) - i*VR(:,j+1).

LDVR    (输入) INTEGER
      数组 VR 的前向维数。 LDVR >= 1，且如果
      jobvr = 'v'，ldvr >= n.

ILO     (输出) INTEGER
IHI     (输出) INTEGER
      ILO 和 IHI 是 A 平衡时确定的整数值。
      平衡时确定的整数值。 平衡后的 A(i,j) = 0 if I > J and
      J = 1,...,ILO-1 or I = IHI+1,...,N.

SCALE   (输出) DOUBLE PRECISION array, dimension (N)
      在平衡 A 时应用的排列和缩放因子的详情
      如果 P(j) 是与第 j 行和第 j 列交换的行和列的索引，D(j) 是缩放因子，则
      的索引，D(j) 是应用于第 j 行和第 j 列的缩放因子。
      则
      SCALE(J) = P(J),    for J = 1,...,ILO-1
               = D(J),    for J = ILO,...,IHI
               = P(J)     for J = IHI+1,...,N.
      交换的顺序是 N 至 IHI+1、
      然后 1 到 ILO-1.

ABNRM   (输出) DOUBLE PRECISION
      平衡矩阵的单正态（任意列元素绝对值之和的最大值
      的最大值）.

RCONDE  (输出) DOUBLE PRECISION array, dimension (N)
      RCONDE(j) 是第 j 个特征值的倒数条件数。
      特征值的倒数条件数.

RCONDV  (输出) DOUBLE PRECISION array, dimension (N)
      RCONDV(j) 是第 j 个右特征向量的倒数条件数。
      右特征向量的倒数条件数.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      WORK 数组的维数。  如果 SENSE = 'N' 或 'E'、
      LWORK >= max(1,2*N)，如果 JOBVL = 'V' 或 JOBVR = 'V'、
      LWORK >= 3*N。 如果 SENSE = 'V' 或 'B'，则 LWORK >= N*（N+6）。
      为获得良好性能，LWORK 通常必须大于.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

IWORK   (工作区) INTEGER array, dimension (2*N-2)
      如果 SENSE = 'N' 或 'E'，则未引用.

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值.
      > 0:  如果 INFO = i，则 QR 算法未能计算所有特征值，也没有特征向量或条件数。
            没有计算出特征向量或条件数。
            和 WI 的元素 1:ILO-1 和 i+1:N 包含已收敛的特征值。
            和 WI 的元素包含已收敛的特征值.
"    ));
      end dgeevx;

      pure function dgesdd "确定奇异值分解"
        extends Modelica.Icons.Function;
        input Real A[:,:];
        output Real sigma[min(size(A, 1), size(A, 2))];
        output Real U[size(A, 1),size(A, 1)] = zeros(size(A, 1), size(A, 1));
        output Real VT[size(A, 2),size(A, 2)] = zeros(size(A, 2), size(A, 2));
        output Integer info;
      protected
        Integer m = size(A, 1);
        Integer n = size(A, 2);
        Real Awork[size(A, 1),size(A, 2)] = A;
        Integer lda = max(1, size(A, 1));
        Integer ldu = max(1, size(A, 1));
        Integer ldvt = max(1, size(A, 2));
        Integer lwork = max(1, 3 * (3 * min(size(A, 1), size(A, 2)) * min(size(A, 1), 
          size(A, 2)) + max(max(size(A, 1), size(A, 2)), 4 * min(size(A, 1), size(
          A, 2)) * min(size(A, 1), size(A, 2)) + 4 * min(size(A, 1), size(A, 2)))));
        Integer iwork = max(1, 8 * min(size(A, 1), size(A, 2)));
        Real work[max(1, 3 * (3 * min(size(A, 1), size(A, 2)) * min(size(A, 1), size(A, 2)) + max(max(size(A, 1), size(A, 2)), 4 * min(size(A, 1), size(A, 2)) * min(size(A, 1), size(A, 2)) + 4 * min(size(A, 1), size(A, 2)))))];

      external "FORTRAN 77" dgesdd(
        "A", 
        m, 
        n, 
        Awork, 
        lda, 
        sigma, 
        U, 
        ldu, 
        VT, 
        ldvt, 
        work, 
        lwork, 
        iwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGESDD 可计算一个 M 乘 N 实矩阵 A 的奇异值分解（SVD）。
可选择计算左奇异向量和右奇异向量。
向量。 如果需要奇异向量，它会使用
分而治之算法.

SVD 的写法是

   A = U * SIGMA * transpose(V)

其中，SIGMA 是一个 M 乘 N 矩阵，除了它的
min(m,n)对角元素外为零；U 是一个 M 乘 M 的正交矩阵；V 是一个 N 乘 N 的正交矩阵。
V 是一个 N 乘 N 的正交矩阵。 SIGMA
的对角元素是 A 的奇异值；它们是实数且非负，并按
按降序返回。 U 和 V 的前 min(m,n) 列为左和右奇异值。
U 和 V 的第一列是 A 的左奇异向量和右奇异向量。.

请注意，例程返回的是 VT = V**T，而不是 V**T。.

分而治之算法对浮点运算的假设非常温和。
浮点运算。它适用于在加减运算中带有
的二进制机器上工作，如 Cray X-MP、Cray Y-MP、Cray Cray
减法的二进制机器，如 Cray X-MP、Cray Y-MP、Cray C-90 或
Cray-2。可以想象，在十六进制或十进制机器上，它也可能失效
但据我们所知，还没有.

论据
=========

JOBZ    (输入) CHARACTER*1
      指定计算矩阵 U 全部或部分的选项:
      = 'A':  U 的所有 M 列和 V**T 的所有 N 行都会在数组 U 和 VT 中返回
              在 U 和 VT 阵列中返回;
      = 'S':  U 的前几列最小值（M,N）和 V**T 的前几行最小值（M,N
              的前几列和 V**T 的前几行分别在数组 U
              和 VT;
      = 'O':  如果 M >= N，则 U 的前 N 列被覆盖在数组 A 上，V**T 的所有行被返回到数组 A 中。
              在数组 A 上，V**T 的所有行将返回数组 VT 中。
              数组 VT;
              否则，U 的所有列都将返回数组 U，而 V**T 的前 M 行将被覆盖。
              数组 U 中的所有列返回，V**T 的前 M 行在数组 A 中被覆盖。
              在数组 A;
      = 'N':  不计算 U 的列或 V**T 的行.

M       (输入) INTEGER
      输入矩阵 A 的行数.  M >= 0.

N       (输入) INTEGER
      输入矩阵 A 的列数.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      输入时，是 M 乘 N 矩阵 A。
      退出时,
      如果 JOBZ = 'O'，则 A 将被前 N 列 U（左奇异矢量，已存储）覆盖。
                      的前 N 列（左奇异矢量，按列存储
                      列），如果 M >= N；
                      则用 V**T 的前 M 行覆盖 A
                      的前 M 行（右奇异矢量，按行存储）覆盖 A。
                      行）覆盖 A。
      如果 JOBZ .ne. O'，A 的内容将被销毁。

LDA     (输入) INTEGER
      数组 A 的前向维度.  LDA >= max(1,M).

S       (输出) DOUBLE PRECISION array, dimension (min(M,N))
      对 A 的奇异值进行排序，以便 S(i) >= S(i+1).

U       (输出) DOUBLE PRECISION array, dimension (LDU,UCOL)
      如果 JOBZ = 'A' 或 JOBZ = 'O'，且 M < N，则 UCOL = M；
      如果 JOBZ = 'S'，则 UCOL = min(M,N)。
      如果 JOBZ = 'A' 或 JOBZ = 'O'，且 M < N，则 U 包含 M-by-M
      正交矩阵 U；
      如果 JOBZ = 'S'，则 U 包含 U 的第一列 min(M,N)
      (左奇异矢量，按列存储）；
      如果 JOBZ = 'O'，且 M >= N，或 JOBZ = 'N'，则不引用 U.

LDU     (输入) INTEGER
      LDU >= 1; 如果
      JOBZ = 'S' 或 'A' 或 JOBZ = 'O' 且 M < N，则 LDU >= M.

VT      (输出) DOUBLE PRECISION array, dimension (LDVT,N)
      如果 JOBZ = 'A' 或 JOBZ = 'O'，且 M >= N，则 VT 包含
      N 乘 N 的正交矩阵 V**T；
      如果 JOBZ = 'S'，VT 包含 V**T 的前 min(M,N) 行（右奇异矢量）。
      右奇异矢量，按行存储）；
      如果 JOBZ = 'O'，且 M < N，或者 JOBZ = 'N'，则不引用 VT.

LDVT    (输入) INTEGER
      数组 VT 的前向维数。 LDVT >= 1; if
      JOBZ = 'A' 或 JOBZ = 'O' 且 M >= N，则 LDVT >= N；
      如果 JOBZ = 'S'，LDVT >= min(M,N).

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK;

LWORK   (输入) INTEGER
      数组 WORK 的维数。LWORK >= 1.
      如果 JOBZ = 'N'、
        LWORK >= 3*min(M,N) + max(max(M,N),7*min(M,N))。
      如果 JOBZ = 'O'，则
        LWORK >= 3*min(M,N) +
                 max(max(M,N),5*min(M,N)*min(M,N)+4*min(M,N))。
      如果 JOBZ = 'S' 或 'A'
        LWORK >= 3*min(M,N) +
                 max(max(M,N),4*min(M,N)*min(M,N)+4*min(M,N))。
      为了获得良好的性能，LWORK 通常应该更大。
      如果 LWORK = -1 但其他输入参数合法，WORK(1)
      将返回最佳 LWORK.

IWORK   (工作区) INTEGER array, dimension (8*min(M,N))

INFO    (输出) INTEGER
      = 0:  成功退出.
      < 0:  如果 INFO = -i，则第 i 个参数为非法值.
      > 0:  DBDSDC 未收敛，更新过程失败.

更多详情
===============

根据以下方面提供的资料
 Ming Gu and Huan Ren, Computer Science Division, University of
 California at Berkeley, USA
"    ));
      end dgesdd;

      pure function dggev 
        "计算 (A,B) 系统的广义特征值以及左右特征向量"
        extends Modelica.Icons.Function;

        input Real A[:,size(A, 1)];
        input Real B[size(A, 1),size(A, 1)];
        input Integer nA = size(A, 1) 
          "矩阵 A 和 B 的实际尺寸（计算 A[1:nA,1:nA]，B[1:nA,1:nA]）。";
        output Real alphaReal[size(A, 1)] 
          "alpha 的实部（特征值=（alphaReal+i*alphaImag）/beta）";
        output Real alphaImag[size(A, 1)] "阿尔法的虚部";
        output Real beta[size(A, 1)] "特征值的分母";
        output Real lEigenVectors[size(A, 1),size(A, 1)] 
          "矩阵 A 的左特征向量";
        output Real rEigenVectors[size(A, 1),size(A, 1)] 
          "矩阵 A 的右特征向量";

        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer lwork = max(1, 8 * n);
        Real Awork[size(A, 1),size(A, 1)] = A;
        Real Bwork[size(A, 1),size(A, 1)] = B;
        Real work[max(1, 8 * size(A, 1))];
        Integer lda = max(1, n);

      external "FORTRAN 77" dggev(
        "V", 
        "V", 
        nA, 
        Awork, 
        lda, 
        Bwork, 
        lda, 
        alphaReal, 
        alphaImag, 
        beta, 
        lEigenVectors, 
        lda, 
        rEigenVectors, 
        lda, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGGEV 可以计算一对 N 乘 N 的实非对称矩阵 (A,B)
的广义特征值，以及可选的左侧和/或右侧
广义特征向量.

一对矩阵 (A,B) 的广义特征值是一个标量
或比率 alpha/beta = lambda，使得 A - lambda*B 为奇异值。
奇异。它通常表示为一对（alpha,beta），因为
β=0，甚至两者都为零，都有合理的解释。
为零.

对应于特征值 lambda(j) 的右特征向量 v(j)
的右特征向量 v(j) 满足

               A * v(j) = lambda(j) * B * v(j).

与特征值 lambda(j) 相对应的左特征向量 u(j)
的左特征向量 u(j) 满足

               u(j)**H * A  = lambda(j) * u(j)**H * B .

其中，u(j)**H 是 u(j) 的共轭变换.

论据
=========

JOBVL   (输入) CHARACTER*1
      = 'N':  不计算左侧广义特征向量;
      = 'V':  计算左侧广义特征向量.

JOBVR   (输入) CHARACTER*1
      = 'N':  不计算正确的广义特征向量;
      = 'V':  不计算正确的广义特征向量.

N       (输入) INTEGER
      矩阵 A、B、VL 和 VR 的顺序.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA, N)
      输入时，矩阵 A 在 (A,B) 对中。
      退出时，A 已被覆盖.

LDA     (输入) INTEGER
      A 的前向维度.  LDA >= max(1,N).

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB, N)
      输入时，矩阵 B 在 (A,B) 对中。
      退出时，B 已被覆盖.

LDB     (输入) INTEGER
      B 的前向维度.  LDB >= max(1,N).

ALPHAR  (输出) DOUBLE PRECISION array, dimension (N)
ALPHAI  (输出) DOUBLE PRECISION array, dimension (N)
BETA    (输出) DOUBLE PRECISION array, dimension (N)
      退出时，(ALPHAR(j) + ALPHAI(j)*i)/BETA(j), j=1,...,N, 将是广义特征值。
      为广义特征值。 如果 ALPHAI(j) 为零，则
      则第 j 个特征值为实数；如果为正数，则第 j 和 (j+1)-st 个特征值为实数。
      (j+1)-st 个特征值是一对复共轭，其中
      ALPHAI(j+1) 为负值.

      注意：ALPHAR(j)/BETA(j) 和 ALPHAI(j)/BETA(j) 的商很容易溢出或不足，BETA(j) 甚至可能为零。
      很容易出现溢出或溢出不足的情况，BETA(j) 甚至可能为零。
      因此，用户应避免天真地计算比率
      阿尔法/贝塔。 不过，ALPHAR 和 ALPHAI 总是小于 norm(j)
      然而，ALPHAR 和 ALPHAI 的大小总是小于 norm(A)，通常与 norm(A) 相当，而 BETA
      BETA 总是小于且通常与常模（B）相当.

VL      (输出) DOUBLE PRECISION array, dimension (LDVL,N)
      如果 JOBVL ='V'，左特征向量 u(j) 将按照与 JOBVL 相同的顺序一个接一个地存储在 VL 列中。
      以与其特征值相同的顺序一个接一个地存储在 VL 的列中。
      其特征值的顺序。如果第 j 个特征值为实数，则
      u(j) = VL(:,j), 即 VL 的第 j 列。如果第 j 和
      (j+1)-th 特征值构成一对复共轭，则
      u(j) = VL(:,j)+i*VL(:,j+1) 和 u(j+1) = VL(:,j)-i*VL(:,j+1) 。
      对每个特征向量进行缩放，使最大分量具有
      abs（实部）+abs（虚部）=1。
      如果 JOBVL = 'N' 则不引用.

LDVL    (输入) INTEGER
      矩阵 VL 的前维。LDVL >= 1，且
      如果 JOBVL = 'V'，则 LDVL >= N.

VR      (输出) DOUBLE PRECISION array, dimension (LDVR,N)
      如果 JOBVR = 'V'，则右特征向量 v(j) 将按照与 JOBVR 相同的顺序逐个存储在 VR 列中。
      将按照与特征值相同的顺序一个接一个地存储在 VR 的列中。
      其特征值的顺序。如果第 j 个特征值为实数，则
      v(j) = VR(:,j), 即 VR 的第 j 列。如果第 j 和
      (j+1)-th 特征值构成一对复共轭，则
      v(j) = VR(:,j)+i*VR(:,j+1) 和 v(j+1) = VR(:,j)-i*VR(:,j+1) 。
      对每个特征向量进行缩放，使最大分量具有
      abs（实部）+abs（虚部）=1。
      如果 JOBVR = 'N' 则不引用.

LDVR    (输入) INTEGER
      矩阵 VR 的前维。LDVR >= 1，且
      如果 JOBVR = 'V'，则 LDVR >= N.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。 LWORK >= max(1,8*N)。
      为了获得良好的性能，LWORK 通常必须大于.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值.
      = 1,...,N:
            QZ 迭代失败。 没有计算出特征向量
            但在 j=INFO+1,...,N 时，ALPHAR(j)、ALPHAI(j) 和 BETA(j)
            应该是正确的.
      > N:  =N+1：DHGEQZ 中 QZ 以外的迭代失败。
            =N+2：DTGEVC 错误返回.
"    ));
      end dggev;

      pure function dggevx 
        "使用 lapack 例程 dggevx 计算 (A,B) 系统的广义特征值"
        extends Modelica.Icons.Function;

        input Real A[:,size(A, 1)];
        input Real B[size(A, 1),size(A, 1)];
        output Real alphaReal[size(A, 1)] 
          "alpha 的实部（特征值=（alphaReal+i*alphaImag）/beta）";
        output Real alphaImag[size(A, 1)] "阿尔法的虚部";
        output Real beta[size(A, 1)] "特征值的分母";
        output Real lEigenVectors[size(A, 1),size(A, 1)] 
          "矩阵 A 的左特征向量";
        output Real rEigenVectors[size(A, 1),size(A, 1)] 
          "矩阵 A 的右特征向量";

        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer lda = max(1, size(A, 1));
        Integer ilo;
        Integer ihi;
        Real lscale[size(A, 1)];
        Real rscale[size(A, 1)];
        Real abnrm;
        Real bbnrm;
        Real rconde[size(A, 1)];
        Real rcondv[size(A, 1)];
        Integer lwork = 2 * n * n + 12 * n + 16;
        Real work[2 * size(A, 1) * size(A, 1) + 12 * size(A, 1) + 16];
        Integer iwork[size(A, 1) + 6];
        Integer bwork[size(A, 1)];

      external "FORTRAN 77" dggevx(
        "B", 
        "V", 
        "V", 
        "B", 
        n, 
        A, 
        lda, 
        B, 
        lda, 
        alphaReal, 
        alphaImag, 
        beta, 
        lEigenVectors, 
        lda, 
        rEigenVectors, 
        lda, 
        ilo, 
        ihi, 
        lscale, 
        rscale, 
        abnrm, 
        bbnrm, 
        rconde, 
        rcondv, 
        work, 
        lwork, 
        iwork, 
        bwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DGGEVX 可计算一对 N 乘 N 的实非对称矩阵 (A,B)
的广义特征值，以及可选的左侧和/或右侧
广义特征向量.

它还可以选择计算平衡变换，以改善
特征值和特征向量的条件（ILO、IHI、
LSCALE、RSCALE、ABNRM 和 BBNRM）、特征值的倒数条件数（RCONDE
特征值的倒数条件数 (RCONDE)，以及右特征向量的倒数条件数 (RCONDE)
右特征向量的倒易条件数 (RCONDV).

一对矩阵 (A,B) 的广义特征值是一个标量
或比率 alpha/beta = lambda，使得 A - lambda*B 为奇异值。
奇异。它通常表示为一对（alpha,beta），因为
β=0，甚至两者都为零，都有合理的解释。
为零.

对应于特征值 lambda(j) 的右特征向量 v(j)
的右特征向量 v(j) 满足

               A * v(j) = lambda(j) * B * v(j) .

与特征值 lambda(j) 相对应的左特征向量 u(j)
的左特征向量 u(j) 满足

               u(j)**H * A  = lambda(j) * u(j)**H * B.

其中，u(j)**H 是 u(j) 的共轭变换.

论据
=========

BALANC  (输入) CHARACTER*1
      指定要执行的平衡选项.
      = 'N':  不要斜向缩放或排列;
      = 'P':  仅允许;
      = 'S':  仅刻度;
      = 'B':  兼具可扩展性和可伸缩性.
      计算出的倒数条件数将用于
      矩阵的倒数条件数。置换不会
      不会改变条件数（精确算术），但
      平衡.

JOBVL   (输入) CHARACTER*1
      = 'N':  不计算左侧广义特征向量;
      = 'V':  计算左侧广义特征向量.

JOBVR   (输入) CHARACTER*1
      = 'N':  不计算正确的广义特征向量;
      = 'V':  计算右侧广义特征向量.

SENSE   (输入) CHARACTER*1
      决定计算哪些倒数条件数.
      = 'N': 没有计算;
      = 'E': 只计算特征值;
      = 'V': 只计算特征向量;
      = 'B': 计算出的特征值和特征向量.

N       (输入) INTEGER
      矩阵 A、B、VL 和 VR 的顺序.  N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA, N)
      输入时，矩阵 A 在 (A,B) 对中。
      退出时，A 已被覆盖。如果 JOBVL='V' 或 JOBVR='V'
      或两者都为'V'，则 A 包含实数 Schur
      形式的第一部分.

LDA     (输入) INTEGER
      A 的前向维度.  LDA >= max(1,N).

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB, N)
      输入时，矩阵 B 在 (A,B) 对中。
      退出时，B 已被覆盖。如果 JOBVL='V' 或 JOBVR='V'
      或两者都是，则 B 包含实数舒尔
      形式的第二部分。.

LDB     (输入) INTEGER
      B 的前向维度.  LDB >= max(1,N).

ALPHAR  (输出) DOUBLE PRECISION array, dimension (N)
ALPHAI  (输出) DOUBLE PRECISION array, dimension (N)
BETA    (输出) DOUBLE PRECISION array, dimension (N)
      退出时，(ALPHAR(j) + ALPHAI(j)*i)/BETA(j), j=1,...,N, 将是广义特征值。
      为广义特征值。 如果 ALPHAI(j) 为零，则
      则第 j 个特征值为实数；如果为正数，则第 j 和 (j+1)-st 个特征值为实数。
      (j+1)-st 个特征值是一对复共轭，其中
      ALPHAI(j+1) 为负值.

      注意：ALPHAR(j)/BETA(j) 和 ALPHAI(j)/BETA(j) 的商很容易溢出或不足，BETA(j) 甚至可能为零。
      很容易出现溢出或溢出不足的情况，BETA(j) 甚至可能为零。
      因此，用户应避免天真地计算比率
      ALPHA/BETA。不过，ALPHAR 和 ALPHAI 总是小于 norm(j)
      通常与 norm(A) 的大小相当，而
      BETA 总是小于 norm(B)，通常与 norm(B) 相当。.

VL      (输出) DOUBLE PRECISION array, dimension (LDVL,N)
      如果 JOBVL ='V'，左特征向量 u(j) 将按照与 JOBVL 相同的顺序一个接一个地存储在 VL 列中。
      以与其特征值相同的顺序一个接一个地存储在 VL 的列中。
      其特征值的顺序。如果第 j 个特征值为实数，则
      u(j) = VL(:,j), 即 VL 的第 j 列。如果第 j 和
      (j+1)-th 特征值构成一对复共轭，则
      u(j) = VL(:,j)+i*VL(:,j+1) 和 u(j+1) = VL(:,j)-i*VL(:,j+1) 。
      每个特征向量都将被缩放，因此最大分量有
      abs（实部）+ abs（虚部）= 1。
      如果 JOBVL = 'N' 则不引用.

LDVL    (输入) INTEGER
      矩阵 VL 的前维。LDVL >= 1，且
      如果 JOBVL = 'V'，则 LDVL >= N.

VR      (输出) DOUBLE PRECISION array, dimension (LDVR,N)
      如果 JOBVR = 'V'，则右特征向量 v(j) 将按照与 JOBVR 相同的顺序逐个存储在 VR 列中。
      将按照与特征值相同的顺序一个接一个地存储在 VR 的列中。
      其特征值的顺序。如果第 j 个特征值为实数，则
      v(j) = VR(:,j), 即 VR 的第 j 列。如果第 j 和
      (j+1)-th 特征值构成一对复共轭，则
      v(j) = VR(:,j)+i*VR(:,j+1) 和 v(j+1) = VR(:,j)-i*VR(:,j+1) 。
      每个特征向量将按比例缩放，因此最大分量有
      abs（实部）+ abs（虚部）= 1。
      如果 JOBVR = 'N' 则不引用.

LDVR    (输入) INTEGER
      矩阵 VR 的前维。LDVR >= 1，且
      如果 JOBVR = 'V'，则 LDVR >= N.

ILO     (输出) INTEGER
IHI     (输出) INTEGER
      ILO 和 IHI 都是整数值，这样在退出时
      A(i,j) = 0，B(i,j) = 0，如果 i > j 且
      j = 1,..., ILO-1 或 i = IHI+1,..., N。
      如果 BALANC = 'N' 或 'S'，则 ILO = 1，IHI = N.

LSCALE  (输出) DOUBLE PRECISION array, dimension (N)
      应用于 A 和 B 左侧的排列和缩放因子的详情
      如果 PL(j) 是与第 j 行交换的行的索引，DL(j) 是缩放因子，则
      行的索引，DL(j) 是应用于第 j 行的缩放因子。
      则
        LSCALE(j) = PL(j)  for j = 1,...,ILO-1
                  = DL(j)  for j = ILO,...,IHI
                  = PL(j)  for j = IHI+1,...,N.
      交换的顺序是 N 至 IHI+1、
      然后 1 到 ILO-1.

RSCALE  (输出) DOUBLE PRECISION array, dimension (N)
      应用于 A 和 B 右边的排列和缩放因子的细节
      如果 PR(j) 是与第 j 列交换的列的索引，DR(j)
      的索引，DR(j) 是应用于第 j 列的缩放因子。
      则
        RSCALE(j) = PR(j)  for j = 1,...,ILO-1
                  = DR(j)  for j = ILO,...,IHI
                  = PR(j)  for j = IHI+1,...,N
      交换的顺序是 N 至 IHI+1、
      然后 1 到 ILO-1.

ABNRM   (输出) DOUBLE PRECISION
      平衡矩阵 A 的单正值.

BBNRM   (输出) DOUBLE PRECISION
      平衡矩阵 B 的单正值.

RCONDE  (输出) DOUBLE PRECISION array, dimension (N)
      如果 SENSE ='E'或 'B'，则特征值的倒数条件数将存储在数组的连续元素中。
      存储在数组的连续元素中。
      对于一对复共轭特征值，两个连续的
      的元素设置为相同值。因此 RCONDE(j)、
      RCONDV(j)以及 VL 和 VR 的第 j 列均对应于第 j 个特征对。
      第 j 个特征对。
      如果 SENSE = 'N' 或 'V'，则不引用 RCONDE.

RCONDV  (输出) DOUBLE PRECISION array, dimension (N)
      如果 SENSE ='V'或 'B'，则估计的倒数条件数
      特征向量的估计倒数条件数，存储在数组的连续元素中。
      存储在数组的连续元素中。对于复特征向量，RCONDV 的两个连续
      RCONDV 的两个连续元素设置为相同值。如果
      特征值无法重新排序以计算 RCONDV(j)、
      RCONDV(j)就会被设为 0；只有在真值非常小的情况下才会出现这种情况。
      值非常小的情况下才会发生。
      如果 SENSE = 'N' 或 'E'，则不引用 RCONDV.

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。LWORK >= max(1,2*N)。
      如果 BALANC = 'S' 或 'B'，或 JOBVL = 'V'，或 JOBVR = 'V'、
      LWORK >= max(1,6*N)。
      如果 SENSE = 'E' 或 'B'，LWORK >= max(1,10*N)。
      如果 SENSE = 'V' 或 'B'，LWORK >= 2*N*N+8*N+16.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

IWORK   (工作区) INTEGER array, dimension (N+6)
      如果 SENSE = 'E'，则不引用 IWORK.

BWORK   (工作区) LOGICAL array, dimension (N)
      如果 SENSE = 'N'，则不引用 BWORK.

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值.
      = 1,...,N:
            QZ 迭代失败。 没有计算出特征向量
            但 ALPHAR(j)、ALPHAI(j) 和 BETA(j)
            应该是正确的 j=INFO+1,...,N.
      > N:  =N+1：DHGEQZ 中 QZ 以外的迭代失败。
            =N+2：DTGEVC 错误返回.

更多详情
===============

平衡矩阵对 (A,B) 包括：首先，对行和列进行排列，以分离出特征值；其次，应用对角线相似性来平衡矩阵对 (A,B) 。
行和列进行对角相似性变换，使行和列的特征值相等。
对行和列进行对角相似性变换，使行和列的规范尽可能接近。
尽可能接近。计算出的倒数条件
数对应于平衡矩阵。行列对调
不会改变条件数（精确算术），但对角线缩放会改变条件数。
对角线缩放会改变。 关于平衡的进一步解释，请参见
第 4.11.1.2 节.

第 i 个计算出的广义特征值 w 与相应的精确特征值之间的弦距的近似误差约束
计算出的广义特征值 w 与相应的精确特征值
特征值 lambda 的近似误差约束为

   chord(w, lambda) <= EPS * norm(ABNRM, BBNRM) / RCONDE(I)

第 i 个计算特征向量 VL(i) 或 VR(i) 之间角度的近似误差约束为
特征向量 VL(i) 或 VR(i) 之间角度的近似误差约束为

   EPS * norm(ABNRM, BBNRM) / DIF(i).

关于倒易条件数 RCONDE
和 RCONDV 的进一步解释，请参见《LAPACK 用户指南》第 4.11 节。.
"    ));
      end dggevx;

      pure function dhgeqz "计算 (A,B) 系统的广义特征值"
        extends Modelica.Icons.Function;

        input Real A[:,size(A, 1)];
        input Real B[size(A, 1),size(A, 1)];
        output Real alphaReal[size(A, 1)] 
          "alpha 的实部（特征值=（alphaReal+i*alphaImag）/beta）";
        output Real alphaImag[size(A, 1)] "阿尔法的虚部";
        output Real beta[size(A, 1)] "特征值的分母";

        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer ilo = 1;
        Integer ihi = n;
        Integer lwork = max(1, 3 * n);
        Real work[max(1, 3 * size(A, 1))];
        Real Awork[size(A, 1),size(A, 1)] = A;
        Real Bwork[size(A, 1),size(A, 1)] = B;
        Integer lda = max(1, n);
        Real Q[1,n] = fill(
          0, 
          1, 
          n);

      external "FORTRAN 77" dhgeqz(
        "E", 
        "N", 
        "N", 
        n, 
        ilo, 
        ihi, 
        Awork, 
        lda, 
        Bwork, 
        lda, 
        alphaReal, 
        alphaImag, 
        beta, 
        Q, 
        1, 
        Q, 
        1, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DHGEQZ 计算实矩阵对 (H,T) 的特征值、
其中 H 是上海森堡矩阵，T 是上三角矩阵、
使用双移位 QZ 方法。
这种类型的矩阵对是通过还原为
实矩阵对 (A,B) 的广义上海森堡形式:

 A = Q1*H*Z1**T,  B = Q1*T*Z1**T,

由 DGGHRD 计算得出.

如果 JOB='S'，那么海森伯三角对 (H,T)
也简化为广义舒尔形式,

 H = Q*S*Z**T,  T = Q*P*Z**T,

其中，Q 和 Z 为正交矩阵，P 为上三角矩阵，S 为准三角矩阵，其中 1-by-1 和 2-by-2 为正交矩阵。
矩阵，而 S 是一个准三角形矩阵，其对角块分别为 1×1 和 2×2
对角线块.

1-by-1 块对应矩阵对 (H,T) 的实特征值，2-by-2 块对应矩阵对 (H,T) 的复共轭对。
(H,T)的实特征值，2-by-2 块对应复共轭对的
特征值.

此外，P 的 2×2 上三角对角块与 S 的 2×2 块相对应，被还原为正对角。
与 S 的 2-by-2 对角块对应的 P 的 2-by-2 上三角对角块被简化为正对角线形式。
形式，即如果 S(j+1,j) 非零，则 P(j+1,j) = P(j,j+1) = 0、
P(j,j) > 0，且 P(j+1,j+1) > 0.

可以选择将广义舒尔因式分解得到的正交矩阵 Q
因式分解的正交矩阵 Q 可以后乘输入矩阵 Q1，正交矩阵 Z 可以后乘输入矩阵 Z1。
正交矩阵 Z 可以后乘输入矩阵 Z1。
如果 Q1 和 Z1 是来自 DGGHRD 的正交矩阵，将矩阵对 (A,B)
将矩阵对 (A,B) 简化为广义上黑森伯格形式，则
输出矩阵 Q1*Q 和 Z1*Z 是将矩阵对 (A,B) 简化为广义上海森堡形式的
(A,B) 的广义舒尔因式分解的正交因式:

 A = (Q1*Q)*S*(Z1*Z)**T,  B = (Q1*Q)*P*(Z1*Z)**T.

为避免溢出，矩阵对 (H,T) 的特征值（等同于、
(A,B)）的特征值计算为一对值 (alpha,beta)，其中 alpha 为复数，beta 为实数。
为复数，β 为实数。
如果 beta 不为零，则 lambda = alpha / beta 是
广义非对称特征值问题（GNEP）
 A*x = lambda*B*x
如果 alpha 不为零，则 mu = beta / alpha 是 GNEP 交替形式的特征值。
的特征值
 mu*A*y = B*y.
实特征值可以直接从广义舒尔形式中读取。
形式直接读取：
alpha = S(i,i), beta = P(i,i).

Ref: C.B. Moler & G.W. Stewart, \"An Algorithm for Generalized Matrix
   Eigenvalue Problems\", SIAM J. Numer. Anal., 10(1973),
   pp. 241--256.

论据
=========

JOB     (输入) CHARACTER*1
      = 'E': 只计算特征值;
      = 'S': 计算特征值和舒尔形式.

COMPQ   (输入) CHARACTER*1
      = 'N': 不计算左舒尔向量 (Q);
      = 'I': 初始化为单位矩阵，并返回 (H,T) 的左舒尔向量矩阵 Q
             的左舒尔向量矩阵返回;
      = 'V': Q 的入口必须包含一个正交矩阵 Q1，并且
             将返回 Q1*Q 的乘积.

COMPZ   (输入) CHARACTER*1
      = 'N': 不计算右舒尔向量 (Z);
      = 'I': Z 初始化为单位矩阵，并返回 (H,T) 的右舒尔向量矩阵 Z
             返回 (H,T) 的右舒尔向量矩阵 Z;
      = 'V': Z 的入口必须包含一个正交矩阵 Z1，并且
             将返回乘积 Z1*Z.

N       (输入) INTEGER
      矩阵 H、T、Q 和 Z 的顺序.  N >= 0.

ILO     (输入) INTEGER
IHI     (输入) INTEGER
      ILO 和 IHI 标示出 H 的行和列，这些行和列呈
      海森堡形式的行和列。 假定 A 的行列 1:ILO-1 和 IHI+1:N
      1:ILO-1 和 IHI+1:N 的行和列。
      如果 N > 0，则 1 <= ILO <= IHI <= N；如果 N = 0，则 ILO=1 和 IHI=0.

H       (输入/输出) DOUBLE PRECISION array, dimension (LDH, N)
      输入时，是 N 乘 N 的上黑森伯格矩阵 H。
      退出时，如果 JOB = 'S'，则 H 包含广义舒尔因式分解中的上准三角形
      矩阵 S；
      2乘2的对角线块（对应于复数共轭特征值对
      对角块（对应于特征值的复共轭对）以标准形式返回，其中
      H(i,i) = H(i+1,i+1) 和 H(i+1,i)*H(i,i+1) < 0。
      如果 JOB = 'E'，则 H 的对角线块与 S 的对角线块一致，但 H 的其余部分未指定。
      H 的其余部分未指定.

LDH     (输入) INTEGER
      数组 H 的前向维度.  LDH >= max( 1, N ).

T       (输入/输出) DOUBLE PRECISION array, dimension (LDT, N)
      输入时，是 N 乘 N 的上三角矩阵 T。
      退出时，如果 JOB = 'S'，则 T 包含广义舒尔因式分解的上三角矩阵 P
      矩阵 P；
      与 S 的 2-by-2 对角块相对应的 P 的 2-by-2 对角块
      被简化为正对角线形式，也就是说，如果 H(j+1,j)
      非零，则 T(j+1,j) = T(j,j+1) = 0，T(j,j) > 0，且
      T(j+1,j+1) > 0。
      如果 JOB = 'E'，则 T 的对角线区块与 P 的对角线区块一致，但 T 的其余部分未指定。
      T 的其余部分未指定.

LDT     (输入) INTEGER
      数组 T 的前向维度.  LDT >= max( 1, N ).

ALPHAR  (输出) DOUBLE PRECISION array, dimension (N)
      定义 GNEP 特征值的每个标量 alpha 的实部
      的实部.

ALPHAI  (输出) DOUBLE PRECISION array, dimension (N)
      每个标量 alpha 的虚部定义了一个
      的虚部。
      如果 ALPHAI(j) 为零，则第 j 个特征值为实数；如果为正数，则第 j 和 (j+1)-st 个特征值为虚数。
      为正，则第 j 和 (j+1)-st 个特征值是一对复共轭对，ALPHAI(j)为正。
      复共轭对，ALPHAI(j+1) = -ALPHAI(j).

BETA    (输出) DOUBLE PRECISION array, dimension (N)
      定义 GNEP 特征值的标量贝塔。
      Alpha = (ALPHAR(j),ALPHAI(j))和
      beta = BETA(j) 代表矩阵对 (A,B) 的第 j 个特征值。
      (A,B) 的第 j 个特征值，其形式为 lambda = alpha/beta 或
      mu = β/α。 由于 lambda 或 mu 都可能溢出、
      一般不应计算它们.

Q       (输入/输出) DOUBLE PRECISION array, dimension (LDQ, N)
      输入时，如果 COMPZ = 'V'，正交矩阵 Q1 用于还原 (A,B)
      将 (A,B) 简化为广义海森堡形式时使用的正交矩阵 Q1。
      退出时，如果 COMPZ = 'I'，则是 (H,T) 的左舒尔向量的正交矩阵。
      向量的正交矩阵。
      则为 (A,B) 的左舒尔向量正交矩阵。
      如果 COMPZ = 'N'，则不引用.

LDQ     (输入) INTEGER
      数组 Q 的前向维数，LDQ >= 1。
      如果 COMPQ='V' 或 'I'，则 LDQ >= N.

Z       (输入/输出) DOUBLE PRECISION array, dimension (LDZ, N)
      如果 COMPZ = 'V'，则输入正交矩阵 Z1。
      将 (A,B) 简化为广义海森伯形式时使用的正交矩阵 Z1。
      退出时，如果 COMPZ = 'I'，则是 (H,T) 的右舒尔向量的正交矩阵。
      如果 COMPZ = 'V'，则为 (H,T) 的右舒尔向量正交矩阵。
      则为 (A,B) 的右舒尔向量正交矩阵。
      如果 COMPZ = 'N'，则不引用。

LDZ     (输入) INTEGER
      LDZ >= 1。
      如果 COMPZ='V' 或 'I'，则 LDZ >= N.

WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO >= 0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。 LWORK >= max(1,N).

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0: 成功退出
      < 0: 如果 INFO = -i，则第 i 个参数为非法值
      = 1,...,N: QZ 迭代没有收敛。 (H,T) 不是
                 但 ALPHAR(i)、ALPHAI(i) 和
                 BETA(i)，i=INFO+1,...,N 应该是正确的.
      = N+1,...,2*N: 移位计算失败。 (H,T) 不是
                 但 ALPHAR(i)、ALPHAI(i) 和
                 BETA(i)，i=INFO-N+1,...,N 应该是正确的.

更多详情
===============

迭代计数器:

JITER  -- 计数迭代.
IITER  -- 计数自上次更改 ILAST 后运行的迭代次数。
        的迭代次数。 因此，只有当 1-by-1 或
        块从底部瘪下去时才会重置。
"    ));
      end dhgeqz;

      pure function dormhr 
        "用 Q * C 或 C * Q 或 Q' * C 或 C * Q' 覆盖一般实数 M-N 矩阵 C，其中 Q 是 dgehrd 返回的正交矩阵"
        extends Modelica.Icons.Function;

        input Real C[:,:];
        input Real A[:,:];
        input Real tau[if side == "L" then size(C, 2) - 1 else size(C, 1) - 1];
        input String side = "L";
        input String trans = "N";
        input Integer ilo = 1 
          "原矩阵不是上三角形式的最低指数";
        input Integer ihi = if side == "L" then size(C, 1) else size(C, 2) 
          "原矩阵不是上三角形式的最高指数";
        output Real Cout[size(C, 1),size(C, 2)] = C 
          "在上三角和第一对角线中包含海森伯形式，在第一对角线下方包含基本反射器，它表示（与阵列 tau）正交矩阵 Q 的乘积";

        output Integer info;
      protected
        Integer m = size(C, 1);
        Integer n = size(C, 2);
        Integer lda = max(1, size(A, 2));
        Integer ldc = max(1, m);
        Integer lwork = max(1, 2 * size(A, 2));
        Real work[max(1, 2 * size(A, 2))];

      external "FORTRAN 77" dormhr(
        side, 
        trans, 
        m, 
        n, 
        ilo, 
        ihi, 
        A, 
        lda, 
        tau, 
        Cout, 
        ldc, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DORMHR 将一般实数 M 乘 N 矩阵 C 改写为

              SIDE = 'L'     SIDE = 'R'
TRANS = 'N':      Q * C          C * Q
TRANS = 'T':      Q**T * C       C * Q**T

其中 Q 是 nq 阶的实正交矩阵，如果 SIDE = 'L'，则 nq = m；如果 SIDE = 'R'，则 nq = n。
如果 SIDE = 'L'，则 nq = m；如果 SIDE = 'R'，则 nq = n。Q 被定义为
由 DGEHRD 返回的 IHI-ILO 基本反射器的乘积:

Q = H(ilo) H(ilo+1) . . . H(ihi-1).

Arguments
=========

SIDE    (输入) CHARACTER*1
      = 'L': 从左侧应用 Q 或 Q**T;
      = 'R': 从右侧申请 Q 或 Q**T.

TRANS   (输入) CHARACTER*1
      = 'N':  不转置，应用 Q;
      = 'T':  转置，应用 Q**T.

M       (输入) INTEGER
      矩阵 C 的行数。M >= 0.

N       (输入) INTEGER
      矩阵 C 的列数。N >= 0.

ILO     (输入) INTEGER
IHI     (输入) INTEGER
      国际劳工组织和国际基础结构、水利和环境工程学院的价值观必须与 DGEHRD 上次呼吁的价值观相同。
      的值相同。Q 等于单位矩阵，但在子矩阵 Q(ilo+1:ihi,ilo+1:ihi) 中除外。
      子矩阵 Q（ILO+1:IHI,ILO+1:IHI）外，Q 等于单位矩阵。
      如果 SIDE = 'L'，则 1 <= ILO <= IHI <= M，如果 M > 0，且
      如果 M = 0，则 ILO = 1，IHI = 0；
      如果 SIDE = 'R'，则 1 <= ILO <= IHI <= N，如果 N > 0，并且
      如果 N = 0，则 ILO = 1，IHI = 0.

A       (输入) 二进制数组，维数
                           (LDA,M) if SIDE = 'L'
                           (LDA,N) if SIDE = 'R'
      定义基本反射器的矢量，如
      返回的.

LDA     (输入) INTEGER
      数组 A 的前导维数。
      如果 SIDE = 'L'，则 LDA >= max(1,M); 如果 SIDE = 'R'，则 LDA >= max(1,N).

TAU     (输入) 二进制数组，维数
                           (M-1) if SIDE = 'L'
                           (N-1) if SIDE = 'R'
      TAU(i) 必须包含由 DGEHRD 返回的基本反射器 H(i) 的标量因子。
      的标量因子.

C       (输入/输出) DOUBLE PRECISION array, dimension (LDC,N)
      输入时，是 M 乘 N 矩阵 C。
      退出时，C 被 Q*C 或 Q**T*C 或 C*Q**T 或 C*Q 覆盖。.

LDC     (输入) INTEGER
      数组 C 的前向维度。 LDC >= max(1,M).

WORK    (工作区/输出) 二进制数组，维数（MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。
      如果 SIDE = 'L'，则 LWORK >= max(1,N)；
      如果 SIDE = 'R'，则 LWORK >= max(1,M)。
      为获得最佳性能，如果 SIDE = 'L'，LWORK >= N*NB；如果 SIDE = 'R'，LWORK >= M*NB。
      如果 SIDE = 'R'，则 LWORK >= M*NB，其中 NB 是最佳的
      块大小.

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息.

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dormhr;

      pure function dormqr 
        "用 Q * C 或 C * Q 或 Q' * C 或 C * Q' 覆盖一般实数 M-N 矩阵 C，其中 Q 是 QR 因式分解的正交矩阵，由 dgeqrf 返回"
        extends Modelica.Icons.Function;

        input Real C[:,:];
        input Real A[:,:];
        input Real tau[:];
        input String side = "L";
        input String trans = "N";

        output Real Cout[size(C, 1),size(C, 2)] = C 
          "包含 Q*C 或 Q**T*C 或 C*Q**T 或 C*Q";

        output Integer info;
      protected
        Integer m = size(C, 1);
        Integer n = size(C, 2);
        Integer k = if side == "L" then m else n;
        Integer lda = if side == "L" then max(1, m) else max(1, n);
        Integer ldc = max(1, m);
        Integer lwork = if side == "L" then max(1, n) else max(1, m);
        Real work[if side == "L" then max(1, size(C, 2)) else max(1, size(C, 1))];

      external "FORTRAN 77" dormqr(
        side, 
        trans, 
        m, 
        n, 
        k, 
        A, 
        lda, 
        tau, 
        Cout, 
        ldc, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DORMQR 会用以下矩阵覆盖 M 乘 N 的一般实矩阵 C

              SIDE = 'L'     SIDE = 'R'
TRANS = 'N':      Q * C          C * Q
TRANS = 'T':      Q**T * C       C * Q**T

其中，Q 是一个实正交矩阵，定义为 k 个
个基本反射体的乘积

    Q = H(1) H(2) . . . H(k)

由 DGEQRF 返回。如果 SIDE = 'L'，Q 为 M 阶；如果 SIDE = 'R'，Q 为 N 阶。
如果 SIDE = 'R' 则为 N.

论据
=========

SIDE    (输入) CHARACTER*1
      = 'L': 从左侧应用 Q 或 Q**T;
      = 'R': 从右侧申请 Q 或 Q**T.

TRANS   (输入) CHARACTER*1
      = 'N':  不转置，应用 Q;
      = 'T':  转置，应用 Q**T.

M       (输入) INTEGER
      矩阵 C 的行数。M >= 0.

N       (输入) INTEGER
      矩阵 C 的列数。N >= 0.

K       (输入) INTEGER
      基本反射器的数量，其乘积定义了
      矩阵 Q。
      如果 SIDE = 'L'，则 M >= K >= 0；
      如果 SIDE = 'R'，N >= K >= 0.

A       (输入) 二进制数组，维数 (LDA,K)
      第 i 列必须包含定义了
      i = 1,2,...,k，由 DGEQRF 在其数组参数 A 的前 k 列中返回。
      DGEQRF 返回的数组参数 A 的前 k 列。
      例程会修改 A，但退出时会还原 A.

LDA     (输入) INTEGER
      数组 A 的前向维数。
      如果 SIDE = 'L'，LDA >= max(1,M)；
      如果 SIDE = 'R'，LDA >= max(1,N).

TAU     (输入) 二进制数组，维数 (K)
      TAU(i) 必须包含由 DGEQRF 返回的基本
      的标量因子.

C       (输入/输出) 二进制数组，维数 (LDC,N)
      输入 M 乘 N 矩阵 C。
      退出时，C 会被 Q*C 或 Q**T*C 或 C*Q**T 或 C*Q 覆盖.

LDC     (输入) INTEGER
      LDC >= max(1,M)。

WORK    (工作区/输出) 二进制数组，维数（MAX(1,LWORK)）。
      退出时，如果 INFO = 0，WORK(1) 返回最优 LWORK.

LWORK   (输入) INTEGER
      数组 WORK 的维数。
      如果 SIDE = 'L'，则 LWORK >= max(1,N)；
      如果 SIDE = 'R'，则 LWORK >= max(1,M)。
      为获得最佳性能，如果 SIDE = 'L'，LWORK >= N*NB；如果 SIDE = 'R'，LWORK >= M*NB。
      如果 SIDE = 'R'，则 LWORK >= M*NB，其中 NB 是最优块大小。
      块大小。

      如果 LWORK =-1，则假定是工作区查询；例程
      例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
      作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息。

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dormqr;

      pure function dtrevc 
        "计算实上准三角形矩阵 T 的右和/或左特征向量"
        extends Modelica.Icons.Function;

        input Real T[:,size(T, 1)] "上准三角矩阵";
        input String side = "R" "指定哪些特征向量";
        input String howmny = "B" "指定多少个特征向量";
        input Real Q[size(T, 1),size(T, 1)] 
          "DHSEQR 返回的舒尔向量正交矩阵 Q";

        output Real lEigenVectors[size(T, 1),size(T, 1)] = Q 
          "矩阵 T 的左特征向量";
        output Real rEigenVectors[size(T, 1),size(T, 1)] = Q 
          "矩阵 T 的右特征向量";
        output Integer info;

      protected
        Integer n = size(T, 1);
        Boolean select[size(T, 1)];
        Integer ldt = max(1, n);
        Integer ldvl = max(1, n);
        Integer ldvr = max(1, n);
        Real work[3 * size(T, 1)];

      external "FORTRAN 77" dtrevc(
        side, 
        howmny, 
        select, 
        n, 
        T, 
        ldt, 
        lEigenVectors, 
        ldvl, 
        rEigenVectors, 
        ldvr, 
        n, 
        n, 
        work, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DTREVC 计算实上准三边矩阵 T 的部分或全部右特征向量和/或左特征向量。
计算实上准三边矩阵 T 的部分和/或全部右特征向量。
这种类型的矩阵是由实数普通矩阵的舒尔因式分解产生的。
的舒尔因式分解：  A = Q*T*Q**T，由 DHSEQR 计算得出.

与特征值 w 相对应的 T 的右特征向量 x 和左特征向量 y 定义如下
的右特征向量 x 和左特征向量 y 定义如下:

 T*x = w*x,     (y**H)*T = w*(y**H)

其中 y**H 表示 y 的共轭转置。
本例程不输入特征值，而是直接从 T 的对角线块中读取。
直接从 T 的对角线块中读取。

此例程返回 T 的左右特征向量矩阵 X 和/或 Y
或 Q*X 和/或 Q*Y 的乘积，其中 Q 是输入矩阵。
输入矩阵。 如果 Q 是正交因子，能将矩阵
则 Q*X 和 Q*Y 是 A 的左右特征向量矩阵。
则 Q*X 和 Q*Y 分别是 A 的右特征向量矩阵和左特征向量矩阵。

论据
=========

SIDE    (输入) CHARACTER*1
      = 'R':  只计算右特征向量;
      = 'L':  只计算左特征向量;
      = 'B':  计算左右特征向量.

HOWMNY  (输入) CHARACTER*1
      = 'A':  计算所有右特征向量和/或左特征向量;
      = 'B':  计算所有右特征向量和/或左特征向量、
              通过 VR 和/或 VL 中的矩阵进行反变换;
      = 'S':  计算选定的右特征向量和/或左特征向量、
              逻辑数组 SELECT.

SELECT  (输入/输出) 逻辑数组，维数（N）
      如果 HOWMNY = 'S'，SELECT 将指定要计算的特征向量。
      计算的特征向量。
      如果 w(j) 是实特征值，则相应的实特征向量
      如果 SELECT(j) 为 .TRUE，则计算相应的实特征向量。
      如果 w(j) 和 w(j+1) 是复特征值的实部和虚部，则会计算相应的复特征向量。
      则计算相应的复特征向量。
      如果 SELECT(j) 或 SELECT(j+1) 为 .TRUE.
      退出时，SELECT(j) 设置为 .TRUE.，SELECT(j+1) 设置为
      .FALSE.
      如果 HOWMNY = 'A' 或 'B'，则不引用。

N       (输入) INTEGER
      矩阵 T 的阶数。

T       (输入) 双精度数组，维数 (LDT,N)
      舒尔规范形式的上准三边矩阵 T。

LDT     (输入) INTEGER
      数组 T 的前向维度。LDT >= max(1,N)。

VL      (输入/输出) 二进制数组，维数 (LDVL,MM)
      输入时，如果 SIDE = 'L' 或 'B'，且 HOWMNY = 'B'，则 VL 必须包含一个 N 乘 N 矩阵 Q（通常为正交矩阵 Q）。
      必须包含一个 N 乘 N 矩阵 Q（通常是由 Schur 向量返回的正交矩阵 Q
      的正交矩阵）。
      退出时，如果 SIDE = 'L' 或 'B'，VL 包含：
      如果 HOWMNY = 'A'，T 的左特征向量矩阵 Y；
      如果 HOWMNY = 'B'，矩阵 Q*Y；
      如果 HOWMNY = 'S'，T 的左特征向量由
                       SELECT）指定的 T 的左特征向量，以相同的顺序连续存储在
                       与特征值的顺序相同。
                       特征值的顺序。
      与复特征值相对应的复特征向量
      存储在连续的两列中，第一列存储实部，第二列存储虚部。
      实部，第二列为虚部。
      如果 SIDE = 'R'，则不引用。

LDVL    (输入) INTEGER
      数组 VL 的前向维数。 LDVL >= 1，如果
      SIDE = 'L' 或 'B'，则 LDVL >= N。

VR      (输入/输出) 二进制数组，维数 (LDVR,MM)
      输入时，如果 SIDE = 'R' 或 'B'，且 HOWMNY = 'B'，则 VR 必须包含一个 N 乘 N 矩阵 Q（通常为正交矩阵 Q）。
      必须包含一个 N 乘 N 矩阵 Q（通常是由 Schur 向量返回的正交矩阵 Q
      的正交矩阵）。
      退出时，如果 SIDE = 'R' 或 'B'，则 VR 包含：
      如果 HOWMNY = 'A'，T 的右特征向量矩阵 X；
      如果 HOWMNY = 'B'，矩阵 Q*X；
      如果 HOWMNY = 'S'，T 的右特征向量由
                       SELECT）指定的 T 的右特征向量，以相同的顺序连续存储在
                       的列中，顺序与特征值相同。
                       特征值的顺序。
      与复特征值对应的复特征向量
      存储在连续的两列中，第一列存储实部，第二列存储虚部。
      实部，第二列为虚部。
      如果 SIDE = 'L'，则不引用。

LDVR    (输入) INTEGER
      数组 VR 的前向维数。 LDVR >= 1，如果
      SIDE = 'R' 或 'B'，则 LDVR >= N。

MM      (输入) INTEGER
      VL 和/或 VR 阵列的列数。MM >= M。

M       (输出) INTEGER
      数组 VL 和/或 VR 中实际用于存储特征向量的列数。
      实际用于存储特征向量的数组 VL 和/或 VR 的列数。
      如果 HOWMNY ='A'或 'B'，则 M 设为 N。
      每个选定的实特征向量占一列，每个选定的复特征向量占两列。
      每个选定的复特征向量占用两列。

WORK    (工作区) 二进制数组，维数 (3*N)

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值

更多详情
===============

该程序使用的算法基本上是后向（前向）替换
替换，并进行了缩放，使代码更稳健，以防
可能的溢出。

每个特征向量都进行了归一化处理，使幅度最大的元素的幅度为 1。
幅值为 1；这里复数 (x,y) 的幅值被认为是
(x,y) 取为 |x| + |y|。
"    ));
      end dtrevc;

      pure function dpotrf 
        "计算实对称正定矩阵 A 的 Cholesky 因式分解"
        extends Modelica.Icons.Function;

        input Real A[:,size(A, 1)] "实对称正定矩阵 A";
        input Boolean upper = true "= true，如果提供了 A 的上三角形";

        output Real Acholesky[size(A, 1),size(A, 1)] = A "Cholesky 因子";
        output Integer info;
      protected
        String uplo = if upper then "U" else "L";
        Integer n = size(A, 1);
        Integer lda = max(1, n);
      external "FORTRAN 77" dpotrf(
        uplo, 
        n, 
        Acholesky, 
        lda, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

DPOTRF 计算实对称正定矩阵 A 的 Cholesky 因式分解。
正定矩阵 A。

因式分解的形式是
 如果 UPLO = 'U'，则 A = U**T * U，或
 A = L * L**T （如果 UPLO = 'L'）、
其中 U 是上三角矩阵，L 是下三角矩阵。

T这是调用第 3 级 BLAS 的算法块版本。

论据
=========

UPLO    (输入) CHARACTER*1
      = 'U':  存储 A 的上三角;
      = 'L':  存储 A 的下三角.

N       (输入) INTEGER
      矩阵 A 的阶数。 N >= 0.

A       (输入/输出) 二进制数组，维数 (LDA,N)
      输入值为对称矩阵 A。 如果 UPLO = 'U'，则 A 的前导
      的上三角部分。
      矩阵 A 的上三角部分，严格意义上的下三角部分不被引用。
      的严格下三角部分不被引用。 如果 UPLO = 'L'，则
      则 A 的前导 N-by-N 下三角部分包含矩阵 A 的下三角部分，而矩阵 A 的严格下三角部分不被引用。
      矩阵 A 的下三角部分，A 的严格上三角部分不被引用。
      则不引用 A 的严格上三角部分。

      退出时，如果 INFO = 0，Cholesky 因式分解中的因子 U 或 L
      因数 A = U**T*U 或 A = L*L**T.

LDA     (输入) INTEGER
      数组 A 的前向维数。LDA >= max(1,N)。

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
      > 0:  如果 INFO = i，阶 i 的前导小数就不是正定的，因式分解就无法进行。
            为正定，则无法完成因式分解。
            完成。
"    ));
      end dpotrf;

      pure function dtrsm 
        "求解其中一个矩阵方程 op( A )*X = alpha*B 或 X*op( A ) = alpha*B，其中 A 为三角矩阵。BLAS 例程"
        extends Modelica.Icons.Function;

        input Real A[:,:] "输入矩阵 A";
        input Real B[:,:] "输入矩阵 B";
        input Real alpha = 1 "因子 alpha";
        input Boolean right = true "= true，如果 A 是右乘法";
        input Boolean upper = true "= true，如果 A 是上三角";
        input Boolean trans = false "= true，如果 op(A) 表示 transposed(A)";
        input Boolean unitTriangular = false 
          "= true，如果 A 是单位三角形，即 A 的所有对角元素都等于 1";

        output Real X[size(B, 1),size(B, 2)] = B 
          "矩阵 Bout=alpha*op( A )*B, 或 B := alpha*B*op( A )";
      protected
        String side = if right then "R" else "L";
        String uplo = if upper then "U" else "L";
        String transA = if trans then "T" else "N";
        String diag = if unitTriangular then "U" else "N";
        Integer m = size(B, 1) "B 的行数";
        Integer n = size(B, 2) "B 的列数";
        Integer lda = if right then max(1, n) else max(1, m) "A 的第一个维度";
        Integer ldb = max(1, m) "B 的第一个维度";

      external "FORTRAN 77" dtrsm(
        side, 
        uplo, 
        transA, 
        diag, 
        m, 
        n, 
        alpha, 
        A, 
        lda, 
        X, 
        ldb) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

DTRSM 可求解其中一个矩阵方程

 op( A )*X = alpha*B,   or   X*op( A ) = alpha*B,

其中，alpha 是标量，X 和 B 是 m 乘 n 矩阵，A 是单位或非单位的上三角或下三角矩阵，op( A ) 是一个矩阵。
是单位矩阵或非单位矩阵、上三角矩阵或下三角矩阵，op( A )是以下两个矩阵之一

 op( A ) = A   or   op( A ) = A'.

矩阵 X 在 B 上被覆盖。

论据
==========

SIDE   - CHARACTER*1.
       输入时，SIDE 指定 op( A ) 是出现在 X 的左边还是右边。
       还是 X 的右边，如下所示：

          SIDE = 'L' or 'l'   op( A )*X = alpha*B.

          SIDE = 'R' or 'r'   X*op( A ) = alpha*B.

       退出时不变。

UPLO   - CHARACTER*1.
       输入时，UPLO 指定矩阵 A 是上三角矩阵还是下三角矩阵。
       下三角矩阵：

          UPLO = 'U' or 'u'   A 是一个上三角矩阵。

          UPLO = 'L' or 'l'   A 是下三角矩阵。

       Unchanged on exit.

TRANSA - CHARACTER*1.
       输入时，TRANSA 将指定 op( A ) 在矩阵乘法中使用的形式，如下所示
       矩阵乘法的形式如下

          TRANSA = 'N' or 'n'   op( A ) = A.

          TRANSA = 'T' or 't'   op( A ) = A'.

          TRANSA = 'C' or 'c'   op( A ) = A'.

       退出时不变。

DIAG   - CHARACTER*1.
       输入时，DIAG 指定 A 是否为单位三角形，如下所示
       如下所示：

          DIAG = 'U' or 'u'   假定 A 为单位三角形。

          DIAG = 'N' or 'n'   不假定 A 是单位
                              三角形。

       退出时不变。

M      - INTEGER.
       输入时，M 指定 B 的行数。
       至少为零。
       退出时不变。

N      - INTEGER.
       输入时，N 指定 B 的列数。
       至少为零。
       退出时不变。
       
ALPHA  - DOUBLE PRECISION.
       输入时，ALPHA 指定标量 alpha。当 alpha
       为零时，则不引用 A，也无需在输入前设置 B。
       输入。
       退出时不变。

A      - DOUBLE PRECISION 数组，其中当 SIDE = 'L' 或 'l' 时，k 为 m；当 SIDE = 'R' 或 'r' 时，k 为 n。
       当 SIDE = 'L' 或 'l' 时为 m，当 SIDE = 'R' 或 'r' 时为 n。
       在输入 UPLO = 'U' 或 'u' 时，前导 k 乘 k
       上三角部分必须包含上三角矩阵和严格的下三角矩阵。
       矩阵，A 的严格下三角部分不被引用。
       不被引用。
       在输入 UPLO = 'L' 或 'l' 时，数组 A 的前导 k 乘 k
       的下三角部分必须包含下三角矩阵，而严格意义上的上三角部分则不被引用。
       矩阵，A 的严格上三角部分不被引用。
       不引用。
       请注意，当 DIAG = 'U' 或 'u' 时，数组 A 的对角线元素也不会被引用，但会被引用。
       A 的对角元素也不会被引用，而是假定为合一。
       退出时不变。

LDA    - INTEGER.
       输入时，LDA 指定 A 的第一个维度，如调用（子程序）中声明的那样。
       的第一个维度。 当 SIDE = 'L' 或 'l' 时，则
       LDA 必须至少为 max( 1, m )；当 SIDE = 'R' 或 'r' 时，LDA 必须至少为 max( 1, n )。
       则 LDA 必须至少为 max( 1, n )。
       退出时不变。

B      - DOUBLE PRECISION 数组的 DIMENSION( LDB, n )。
       在输入之前，数组 B 的前导 m 乘 n 部分必须包含右侧矩阵 B。
       必须包含右侧矩阵 B，并在退出时被解矩阵 X
       被解法矩阵 X 覆盖。
       
LDB    - INTEGER.
       输入时，LDB 指定调用（子程序）中声明的 B 的第一个维度。
       的第一个维度。  LDB 必须至少为
       max( 1, m )。
       退出时不变。

3 级布拉斯程序。
"    ));
      end dtrsm;

      pure function dorghr 
        "生成一个实正交矩阵 Q，它被定义为 N 阶 IHI-ILO 基本反射器的乘积，如 DGEHRD 所返回的那样"
        extends Modelica.Icons.Function;

        input Real A[:,size(A, 1)] 
          "带基本反射器的正方形矩阵";
        input Integer ilo = 1 
          "原始矩阵不是上三角形式的最低索引 - ilo 必须与前一次调用 DGEHRD 时的值相同";
        input Integer ihi = size(A, 1) 
          "原始矩阵不是上三角形式的最高指数 - ihi 必须与 DGEHRD 上一次调用的值相同";
        input Real tau[max(0, size(A, 1) - 1)] 
          "基本反射器的标量系数";
        output Real Aout[size(A, 1),size(A, 2)] = A 
          "正交矩阵是基本反射器的结果";
        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer lda = max(1, n);
        Integer lwork = max(1, 3 * n);
        Real work[max(1, 3 * size(A, 1))];

      external "FORTRAN 77" dorghr(
        n, 
        ilo, 
        ihi, 
        Aout, 
        lda, 
        tau, 
        work, 
        lwork, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

多尔戈尔生成的实正交矩阵 Q 定义为
定义为 N 阶 IHI-ILO 基本反射体的乘积。
DGEHRD 生成的实正交矩阵 Q：

Q = H(ilo) H(ilo+1) . . . H(ihi-1).

论据
=========

N       (输入) INTEGER
      矩阵 Q 的阶数。

ILO     (输入) INTEGER
IHI     (输入) INTEGER
      国际劳工组织和国际基础结构、水利和环境工程学院的价值观必须与 DGEHRD 上次呼吁的价值观相同。
      的值相同。Q 等于单位矩阵，但在子矩阵 Q(ilo+1:ihi,ilo+1:ihi) 中除外。
      子矩阵 Q（ILO+1:IHI,ILO+1:IHI）外，Q 等于单位矩阵。
      1 <= ILO <= IHI <= N，如果 N > 0；ILO=1，IHI=0，如果 N=0。

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
      输入端，定义基本反射器的向量、
      由 DGEHRD 返回。
      退出时，是 N 乘 N 的正交矩阵 Q。

LDA     (输入) INTEGER
      数组 A 的前向维数。LDA >= max(1,N)。

TAU     (输入) DOUBLE PRECISION array, dimension (N-1)
      TAU(i) 必须包含由 DGEHRD 返回的基本反射器 H(i) 的标量因子。
      的标量因子。

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
      退出时，如果 INFO = 0，WORK(1) 将返回最优的 LWORK。

LWORK   (输入) INTEGER
      数组 WORK 的维数。LWORK >= IHI-ILO。
      为获得最佳性能，LWORK >= (IHI-ILO)*NB，其中 NB 为最佳块大小。
      最佳块大小。

      如果 LWORK =-1，则假定有工作区查询；例程仅计算工作区的最优大小。
      例程只计算 WORK 数组的最佳大小，并将此值作为工作区数据表的第一个条目返回。
      例程仅计算 WORK 数组的最优大小，并将此值作为 WORK 数组的第一个条目返回，且例程不会出现与 LWORK 相关的错误信息。
      XERBLA 不会发出与 LWORK 有关的错误信息。

INFO    (输出) INTEGER
      = 0:  成功退出
      < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dorghr;
      annotation(Documentation(info = "<html>
<p>
This package contains external Modelica functions as interface to the
LAPACK library
(<a href=\"http://www.netlib.org/lapack\">http://www.netlib.org/lapack</a>)
that provides FORTRAN subroutines to solve linear algebra
tasks. Usually, these functions are not directly called, but only via
the much more convenient interface of
<a href=\"modelica://Modelica.Math.Matrices\">Modelica.Math.Matrices</a>.
The documentation of the LAPACK functions is a copy of the original
FORTRAN code. The details of LAPACK are described in:
</p>

<dl>
<dt>Anderson E., Bai Z., Bischof C., Blackford S., Demmel J., Dongarra J.,
  Du Croz J., Greenbaum A., Hammarling S., McKenney A., and Sorensen D.:</dt>
<dd> <a href=\"http://www.netlib.org/lapack/lug/lapack_lug.html\">Lapack Users' Guide</a>.
   Third Edition, SIAM, 1999.</dd>
</dl>

<p>
See also <a href=\"http://en.wikipedia.org/wiki/Lapack\">http://en.wikipedia.org/wiki/Lapack</a>.
</p>

<p>
This package contains a direct interface to the LAPACK subroutines
</p>

</html>"    ));
      function dgegv "计算 (A,B) 系统的广义特征值"
        extends Modelica.Icons.Function;
        input Real A[:,size(A, 1)];
        input Real B[size(A, 1),size(A, 1)];
        output Real alphaReal[size(A, 1)] 
          "alpha 的实部（特征值=（alphaReal+i*alphaImag）/beta）";
        output Real alphaImag[size(A, 1)] "阿尔法的虚部";
        output Real beta[size(A, 1)] "特征值的分母";
        output Integer info;
      protected
        Integer n = size(A, 1);
        Integer lwork = 12 * n;
        Integer ldvl = 1;
        Integer ldvr = 1;
        Real Awork[size(A, 1),size(A, 1)] = A;
        Real Bwork[size(A, 1),size(A, 1)] = B;
        Real work[12 * size(A, 1)];
        Real dummy1[1,1];
        Real dummy2[1,1];

      external "FORTRAN 77" dgegv(
        "N", 
        "N", 
        n, 
        Awork, 
        n, 
        Bwork, 
        n, 
        alphaReal, 
        alphaImag, 
        beta, 
        dummy1, 
        ldvl, 
        dummy2, 
        ldvr, 
        work, 
        lwork, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

此例程已废弃，由例程 DGGEV 代替。

DGEGV 可计算特征值，也可选择计算左特征向量和/或右特征向量。
右特征向量。
给定两个正方形矩阵 A 和 B、
广义非对称特征值问题 (GNEP) 是要找出
特征值 lambda 和相应的（非零）特征向量 x，使得
使

A*x = lambda*B*x.

另一种形式是找出特征值 mu 和相应的
特征向量 y，使得

mu*A*y = B*y.

如果 lambda 和 mu 都不为零，这两种形式等价于 mu = 1/lambda 和 x = y。
和 x = y。 为了处理
为处理 lambda 或 mu 为零或很小的情况，每个特征值都会返回两个值 alpha 和 beta。
为每个特征值返回两个值 alpha 和 beta，即 lambda = alpha/beta 和
mu = beta/alpha。

上述方程中的向量 x 和 y 是矩阵对 (A,B) 的右特征向量。
矩阵对 (A,B)。 向量 u 和 v 满足
u**H*A = lambda*u**H*B  or  mu*v**H*A = v**H*B

是 (A,B) 的左特征向量。

注意：这个例程在 A 和 B 上执行 \"完全平衡（full balancing）\"--见
下面的 \"更多细节\"

论据
=========

JOBVL   (输入) CHARACTER*1
  = 'N':  不计算左侧广义特征向量;
  = 'V':  计算左侧广义特征向量（在 VL 中返回
          在 VL 中返回）.

JOBVR   (输入) CHARACTER*1
  = 'N':  不计算正确的广义特征向量;
  = 'V':  计算右侧广义特征向量（在 VR 中返回
          在 VR 中）.

N       (输入) INTEGER
  矩阵 A、B、VL 和 VR 的顺序。 N >= 0.

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA, N)
  输入时为矩阵 A。
  如果 JOBVL = 'V' 或 JOBVR = 'V'，则退出时 A
  包含 A 的实数舒尔形式。
  因式分解的 A 的实舒尔形。
  如果没有计算特征向量，那么只有对角线上的
  块才是正确的。 详见 DGGHRD 和
  DHGEQZ 了解详情。

LDA     (输入) INTEGER
  A 的前向维度。LDA >= max(1,N)。

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB, N)
  输入时，矩阵 B。
  如果 JOBVL = 'V' 或 JOBVR = 'V'，则在退出时，B 包含在广义矩阵 B 中得到的上三角矩阵。
  上三角矩阵。
  对 (A,B) 的广义舒尔因式分解中得到的上三角矩阵。
  如果没有计算特征向量，那么只有与
  B 的对角线块对应的元素才是正确的。
  将是正确的。 详见 DGGHRD 和 DHGEQZ。

LDB     (输入) INTEGER
  B 的前向维度。LDB >= max(1,N)。

ALPHAR  (输出) DOUBLE PRECISION array, dimension (N)
  每个标量 alpha 的实部定义了的实部。

ALPHAI  (输出) DOUBLE PRECISION array, dimension (N)
  每个标量 alpha 的虚部定义了一个
  的虚部。 如果 ALPHAI(j) 为零，则第 j 个特征值为实数；如果为正数，则第 j 个和第 j 个特征值均为实数。
  特征值为实数；如果为正数，则第 j 和 (j+1)-st 个特征值是一对复数。
  (j+1)-st 个特征值是一对复共轭，其中
  ALPHAI(j+1) = -ALPHAI(j)。

BETA    (输出) DOUBLE PRECISION array, dimension (N)
  定义 GNEP 特征值的标量贝塔。

  Alpha = (ALPHAR(j),ALPHAI(j))和
  贝塔 = BETA(j) 表示矩阵对（A,B）的第 j 个特征值。
  (A,B) 的第 j 个特征值，其形式为 lambda = alpha/beta 或
  mu = β/α。 由于 lambda 或 mu 都可能溢出、
  一般情况下不应计算它们。
  
VL      (输出) DOUBLE PRECISION array, dimension (LDVL,N)
  如果 JOBVL ='V'，则左特征向量 u(j) 将按照与特征值相同的顺序存储在 VL 列中。
  与特征值的顺序相同。
  如果第 j 个特征值为实数，则 u(j) = VL(:,j)。
  如果第 j 个特征值和第 (j+1)- 个特征值构成一对复共轭，则 u(j) = VL(:,j)
  对，则
     u(j) = VL(:,j) + i*VL(:,j+1)
  和
    u(j+1) = VL(:,j) - i*VL(:,j+1).

  对每个特征向量进行缩放，使其最大分量具有
  abs（实部）+ abs（虚部）= 1，除非特征向量
  对应于 alpha = beta = 0 的特征值的特征向量除外。
  设为零。
  如果 JOBVL = 'N'，则不引用。

LDVL    (输入) INTEGER
  矩阵 VL 的前维。LDVL >= 1，且
  如果 JOBVL = 'V'，则 LDVL >= N。

VR      (输出) DOUBLE PRECISION array, dimension (LDVR,N)
  如果 JOBVR = 'V'，则右特征向量 x(j) 将按照其特征值的顺序存储在 VR 列中。
  与特征值的顺序相同。
  如果第 j 个特征值为实数，则 x(j) = VR(:,j)。
  如果第 j 个和第 (j+1)- 个特征值构成一对复共轭，则 x(j) = VR(:,j)
  对，则
    x(j) = VR(:,j) + i*VR(:,j+1)
  and
    x(j+1) = VR(:,j) - i*VR(:,j+1).

  对每个特征向量进行缩放，使其最大分量具有
  abs（实部）+ abs（虚部）= 1，但特征值
  对应于 alpha = beta = 0 的特征值，这些特征值被设置为零。
  设为零。
  如果 JOBVR = 'N'，则不引用。

LDVR    (输入) INTEGER
  矩阵 VR 的前维。LDVR >= 1，且
  如果 JOBVR = 'V'，则 LDVR >= N。

WORK    (工作区/输出) DOUBLE PRECISION array, dimension (MAX(1,LWORK))
  退出时，如果 INFO = 0，WORK(1) 将返回最优的 LWORK。

LWORK   (输入) INTEGER
  数组 WORK 的维数。 LWORK >= max(1,8*N)。
  为了获得良好的性能，LWORK 通常必须更大。
  要计算 LWORK 的最佳值，可调用 ILAENV 获取
  块大小（适用于 DGEQRF、DORMQR 和 DORGQR）：
  NB -- DGEQRF、DORMQR 和 DORGQR 的区块大小的 MAX；
  最优 LWORK 为
      2*N + MAX( 6*N, N*(NB+1) ).

  如果 LWORK =-1，则假定是工作区查询；例程
  例程只计算工作数组的最佳大小，并将该值作为工作数组的第一个条目返回。
  作为 WORK 数组的第一个条目返回，XERBLA 不会发出与 LWORK 有关的错误信息。
  XERBLA 不会发出与 LWORK 有关的错误信息。

INFO    (输出) INTEGER
  = 0:  成功退出
  < 0:  如果 INFO = -i，则第 i 个参数为非法值。
  = 1,...,N:
        QZ 迭代失败。 没有计算出特征向量
        没有计算出特征向量，但在 j=INFO+1 时，ALPHAR(j)、ALPHAI(j) 和 BETA(j)
        对于 j=INFO+1,...N 应该是正确的。
  > N:  通常表示 LAPACK 问题的错误：
        =N+1：从 DGGBAL 返回错误信息
        =N+2：从 DGEQRF 错误返回
        =N+3: 从 DORMQR 错误返回
        =N+4: 从 DORGQR 错误返回
        =N+5: 从 DGGHRD 错误返回
        =N+6：从 DHGEQZ 错误返回（迭代失败除外
                                        迭代失败除外）
        =N+7：从 DTGEVC 错误返回
        =N+8：从 DGGBAK 错误返回（计算 VL）
        =N+9：从 DGGBAK 错误返回（计算 VR）
        =N+10：从 DLASCL（各种调用）返回的错误信息

更多详情
===============

平衡
---------

该驱动程序调用 DGGBAL 对 A 和 B 的行和列进行排列和缩放。
选择排列 PL 和 PR 的目的是使 PL*A*PR 和 PL*B*R 除对角线块外都是上三角形。
和 PL*B*R 将是上三角形，对角线块除外
A(i:j,i:j)和 B(i:j,i:j)，i 和 j 尽可能靠近。
尽可能靠近。 对角缩放矩阵 DL 和 DR 的选择是为了
DL*PL*A*PR*DR、DL*PL*B*PR*DR 这对对角矩阵的元素接近于 1（开始元素除外）。
1（开始为零的元素除外）。

计算平衡矩阵的特征值和特征向量后
在计算出平衡矩阵的特征值和特征向量后，DGGBAK 会将特征向量转换回它们本来的状态（在完全弧形的情况下）。
如果没有平衡矩阵，它们的特征向量（在完美算术中）会是什么样子。
平衡。

退出时 A 和 B 的内容
-------- -- - --- - -- ----

如果计算了任何特征向量（JOBVL='V'或 JOBVR='V'，或两者皆有
那么在退出时，数组 A 和 B 将包含 A 和 B 的实数舒尔
形式[*] 的 A 和 B 的 \"平衡 \"版本。
则只有对角线块是正确的。
[*] 参见 DHGEQZ、DGEGS，或阅读由约翰-霍普金斯大学出版社出版的 Golub & van Loan 著的《矩阵计算》一书、
Golub & van Loan 著，约翰霍普金斯大学出版社出版。
"    ));
      end dgegv;
      function dgelsx 
        "计算实数线性最小二乘问题的最小规范解，其 A"

        extends Modelica.Icons.Function;
        input Real A[:,:];
        input Real B[size(A, 1),:];
        input Real rcond = 0.0 "估计等级的互易条件数";
        output Real X[max(size(A, 1), size(A, 2)),size(B, 2)] = cat(
          1, 
          B, 
          zeros(max(nrow, ncol) - nrow, nrhs)) 
          "解决方案在第一个 size(A,2) 行中";
        output Integer info;
        output Integer rank "A 级有效等级";
      protected
        Integer nrow = size(A, 1);
        Integer ncol = size(A, 2);
        Integer nx = max(nrow, ncol);
        Integer nrhs = size(B, 2);
        Real work[max(min(size(A, 1), size(A, 2)) + 3 * size(A, 2), 2 * min(size(A, 1), size(A, 2)) + size(B, 2))];
        Real Awork[size(A, 1),size(A, 2)] = A;
        Integer jpvt[size(A, 2)] = zeros(ncol);

      external "FORTRAN 77" dgelsx(
        nrow, 
        ncol, 
        nrhs, 
        Awork, 
        nrow, 
        X, 
        nx, 
        jpvt, 
        rcond, 
        rank, 
        work, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

此例程已废弃，由例程 DGELSY 代替。

DGELSX 计算实数线性最小二乘问题的最小规范解
最小正值解：
最小化 A * X - B |||
A 是一个 M 乘 N 的矩阵，可能存在秩缺陷。
矩阵，可能存在秩缺陷。

多个右侧向量 b 和解向量 x 可以
的列存储。
存储为 M-by-NRHS 右边矩阵 B 和 N-by-NRHS 解矩阵 X 的列。
矩阵 X。

例程首先计算 QR 因式分解，并进行列支点处理:
A * P = Q * [ R11 R12 ]
          [  0  R22 ]
R11 定义为估计条件数小于 1/RCOND 的最大前导子矩阵。
条件数小于 1/RCOND 的最大前导子矩阵。 R11 的秩 RANK、
是 A 的有效秩。

然后，R22 被视为可忽略不计，R12 通过从右侧开始的正交变换被湮没。
通过从右边开始的正交变换，得到
完整的正交因式分解:
A * P = Q * [ T11 0 ] * Z
         [  0  0 ]
那么最小规范解就是
X = P * Z' [ inv(T11)*Q1'*B ]
        [        0       ]
其中 Q1 由 Q 的前 RANK 列组成.

论据
=========

M       (输入) INTEGER
  矩阵 A 的行数。 M >= 0.

N       (输入) INTEGER
  矩阵 A 的列数。 N >= 0.

NRHS    (输入) INTEGER
  右边的数量，即矩阵 B 和 X 的列数。
  NRHS >= 0。

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
  输入时，是 M 乘 N 矩阵 A。
  退出时，A 已被其
  完全正交因式分解。

LDA     (输入) INTEGER
  数组 A 的前导维数。 LDA >= max(1,M).

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
  输入时，是 M-by-NRHS 右边矩阵 B。
  退出时，是 N-by-NRHS 解矩阵 X。
  如果 m >= n 且 RANK = n，则第 i 列解法的残差平方和为
  第 i 列的解的残差平方和由
  该列元素 N+1:M 的平方之和。

LDB     (输入) INTEGER
  数组 B 的前向维数。LDB >= max(1,M,N)。

JPVT    (输入/输出) INTEGER array, dimension (N)
  输入时，如果 JPVT(i) .ne. 0，则 A 的第 i 列为初始列，否则为空闲列。
  为初始列，否则为空闲列。 在
  在对 A 进行 QR 因式分解之前，所有初始列都被
  在对 A 进行 QR 因式分解之前，所有初始列都被置换到前导位置；只有剩余的
  只有剩余的空闲列会在因式分解过程中由于列旋转而移动。
  移动。
  退出时，如果 JPVT(i) = k，则 A*P 的第 i 列是 A 的第 k 列。
  就是 A 的第 k 列。

RCOND   (输入) DOUBLE PRECISION
  RCOND 用于确定 A 的有效秩，即
  的有效秩。
  子矩阵 R11 的秩、
  其估计条件数 < 1/RCOND。

RANK    (输出) INTEGER
  A 的有效秩，即子矩阵的秩
  R11.  这与子矩阵 T11
  的秩相同。

WORK    (工作区) DOUBLE PRECISION array, dimension
              (max( min(M,N)+3*N, 2*min(M,N)+NRHS )),

INFO    (输出) INTEGER
  = 0:  成功退出
  < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dgelsx;
      function dgelsx_vec 
        "计算实数线性最小二乘问题的最小规范解，其 A"

        extends Modelica.Icons.Function;
        input Real A[:,:];
        input Real b[size(A, 1)];
        input Real rcond = 0.0 "估计等级的互易条件数";
        output Real x[max(size(A, 1), size(A, 2))] = cat(
          1, 
          b, 
          zeros(max(nrow, ncol) - nrow)) 
          "解在第一个 size(A,2) 行中";
        output Integer info;
        output Integer rank "A 级有效等级";
      protected
        Integer nrow = size(A, 1);
        Integer ncol = size(A, 2);
        Integer nrhs = 1;
        Integer nx = max(nrow, ncol);
        Real work[max(min(size(A, 1), size(A, 2)) + 3 * size(A, 2), 2 * min(size(A, 1), size(A, 2)) + 1)];
        Real Awork[size(A, 1),size(A, 2)] = A;
        Integer jpvt[size(A, 2)] = zeros(ncol);

      external "FORTRAN 77" dgelsx(
        nrow, 
        ncol, 
        nrhs, 
        Awork, 
        nrow, 
        x, 
        nx, 
        jpvt, 
        rcond, 
        rank, 
        work, 
        info) annotation(Library = "lapack");
      annotation(Documentation(info = "Lapack 文档
用途
=======

此例程已废弃，由例程 DGELSY 代替。

DGELSX 计算实数线性最小二乘问题的最小规范解。
问题的最小正解法:
minimize || A * X - B ||
A 是一个 M 乘 N 的矩阵，可能存在秩缺陷。
矩阵，可能存在秩缺陷。

一次调用可以处理多个右侧向量 b 和解向量 x。
的列存储。
存储为 M-by-NRHS 右边矩阵 B 和 N-by-NRHS 解矩阵 X 的列。
矩阵 X。

例程首先计算 QR 因式分解，并进行列支点处理:
A * P = Q * [ R11 R12 ]
          [  0  R22 ]
R11 定义为估计条件数小于 1/RCOND 的最大前导子矩阵。
条件数小于 1/RCOND 的最大前导子矩阵。 R11 的秩 RANK、
是 A 的有效秩。

然后，R22 被视为可忽略不计，R12 通过从右侧开始的正交变换被湮没。
通过从右边开始的正交变换，得到
完整的正交因式分解:
A * P = Q * [ T11 0 ] * Z
         [  0  0 ]
那么最小规范解就是
X = P * Z' [ inv(T11)*Q1'*B ]
        [        0       ]
其中 Q1 由 Q 的前 RANK 列组成。

论据
=========

M       (输入) INTEGER
  矩阵 A 的行数。 M >= 0.

N       (输入) INTEGER
  矩阵 A 的列数。 N >= 0.

NRHS    (输入) INTEGER
  右边的数量，即矩阵 B 和 X 的列数。
  NRHS >= 0。

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
  输入时，是 M 乘 N 矩阵 A。
  退出时，A 已被其
  完全正交因式分解。

LDA     (输入) INTEGER
  数组 A 的前向维数。LDA >= max(1,M)。

B       (输入/输出) DOUBLE PRECISION array, dimension (LDB,NRHS)
  输入时，是 M-by-NRHS 右边矩阵 B。
  退出时，是 N-by-NRHS 解矩阵 X。
  如果 m >= n 且 RANK = n，则第 i 列解法的残差平方和为
  第 i 列的解的残差平方和由
  该列元素 N+1:M 的平方之和。

LDB     (输入) INTEGER
  数组 B 的前向维数。LDB >= max(1,M,N)。

JPVT    (输入/输出) INTEGER array, dimension (N)
  输入时，如果 JPVT(i) .ne. 0，则 A 的第 i 列为初始列，否则为空闲列。
  为初始列，否则为空闲列。 在
  在对 A 进行 QR 因式分解之前，所有初始列都被
  在对 A 进行 QR 因式分解之前，所有初始列都被置换到前导位置；只有剩余的
  只有剩余的空闲列会在因式分解过程中由于列旋转而移动。
  移动。
  退出时，如果 JPVT(i) = k，则 A*P 的第 i 列是 A 的第 k 列。
  就是 A 的第 k 列。

RCOND   (输入) DOUBLE PRECISION
  RCOND 用于确定 A 的有效秩，即
  的有效秩。
  子矩阵 R11 的秩、
  其估计条件数 < 1/RCOND。

RANK    (输出) INTEGER
  A 的有效秩，即子矩阵的秩
  R11.  这与子矩阵 T11
  的秩相同。
WORK    (工作区) DOUBLE PRECISION array, dimension
              (max( min(M,N)+3*N, 2*min(M,N)+NRHS )),

INFO    (输出) INTEGER
  = 0:  成功退出
  < 0:  如果 INFO = -i，则第 i 个参数为非法值
"    ));
      end dgelsx_vec;
      function dgeqpf 
        "计算带列支点的正方形或矩形矩阵 A 的 QR 因式分解 (A(:,p) = Q*R)"

        extends Modelica.Icons.Function;
        input Real A[:,:] "正方形或矩形矩阵";
        output Real QR[size(A, 1),size(A, 2)] = A 
          "打包格式的 QR 因式分解";
        output Real tau[min(size(A, 1), size(A, 2))] 
          "Q 基本反射体的标量因子";
        output Integer p[size(A, 2)] = zeros(size(A, 2)) "枢轴向量";
        output Integer info;
      protected
        Integer m = size(A, 1);
        Integer lda = max(1, size(A, 1));
        Integer ncol = size(A, 2) "A 的柱尺寸";
        Real work[3 * size(A, 2)] "工作阵列";

      external "FORTRAN 77" dgeqpf(
        m, 
        ncol, 
        QR, 
        lda, 
        p, 
        tau, 
        work, 
        info) annotation(Library = {"lapack"});
      annotation(Documentation(info = "Lapack 文档
用途
=======

此例程已废弃，由例程 DGEQP3 代替。

DGEQPF 计算一个 M×N 实矩阵 A 带列支点的 QR 因式分解：A*P = Q*R
实 M 乘 N 矩阵 A：A*P = Q*R。

论据
=========

M       (输入) INTEGER
  矩阵 A 的行数。M >= 0.

N       (输入) INTEGER
  矩阵 A 的列数。N >= 0

A       (输入/输出) DOUBLE PRECISION array, dimension (LDA,N)
  输入时，是 M 乘 N 矩阵 A。
  退出时，数组的上三角包含
  最小（M,N）乘 N 的上三角矩阵 R；对角线以下的元素与数组 TAU
  以及数组 TAU、
  表示正交矩阵 Q，它是
  min(m,n)个基本反射器的乘积。

LDA     (输入) INTEGER
  数组 A 的前向维数。LDA >= max(1,M)。

JPVT    (输入/输出) INTEGER array, dimension (N)
  输入时，如果 JPVT(i) .ne. 0，则 A 的第 i 列被置换到 A*P 的前面（前导列）；如果 JPVT(i)=0
  到 A*P 的前面（前导列）；如果 JPVT(i) = 0、
  则 A 的第 i 列为自由列。
  退出时，如果 JPVT(i) = k，则 A*P 的第 i 列是 A 的第 k 列。
  是 A 的第 k 列。
  
TAU     (输出) DOUBLE PRECISION array, dimension (min(M,N))
  基本反射器的标量因子。

WORK    (工作区) DOUBLE PRECISION array, dimension (3*N)

INFO    (输出) INTEGER
  = 0:  成功退出
  < 0:  如果 INFO = -i，则第 i 个参数为非法值

更多详情
===============

矩阵 Q 表示为基本反射器的乘积

Q = H(1) H(2) . . . H(n)

每个 H(i) 的形式为

H = I - tau * v * v'

其中 tau 是实数标量，v 是实数向量，其中
v(1:i-1)=0，v(i)=1；v(i+1:m) 在退出时存储在 A(i+1:m,i) 中。

矩阵 P 在 jpvt 中的表示如下： 如果
jpvt(j) = i
则 P 的第 j 列为第 i 个规范单位向量。
"    ));
      end dgeqpf;
    end LAPACK;

    package Utilities 
      "用户不应直接使用的实用函数"
      extends Modelica.Icons.UtilitiesPackage;

      function continuousRiccatiIterative 
        "用牛顿法精确寻线迭代求解连续代数黎卡提方程"
        extends Modelica.Icons.Function;

        import Modelica.Math.Matrices;

        input Real A[:,size(A, 1)] 
          "里卡提方程矩阵 A X*A + A'*X -X*G*X +Q = 0";
        input Real B[size(A, 1),:] "G 中的矩阵 B = B*inv(R)*B'";
        input Real R[size(B, 2),size(B, 2)] = identity(size(B, 2)) 
          "矩阵 R 在 G = B*inv(R)*B'";
        input Real Q[size(A, 1),size(A, 2)] = identity(size(A, 1)) 
          "里卡提方程矩阵 Q X*A + A'*X -X*G*X +Q = 0";
        input Real X0[size(A, 1),size(A, 2)] = identity(size(A, 1)) 
          "X*A + A'*X -X*G*X +Q = 0 的初始近似解";
        input Integer maxSteps = 10 "最大迭代步数";
        input Real eps = Matrices.frobeniusNorm(A) * 1e-9 
          "停止标准的容差";

        output Real X[size(X0, 1),size(X0, 2)] 
          "里卡提方程 X*A + A'*X -X*G*X +Q = 0 的解 X";
        output Real r "X*A + A'*X - X*G*X + Q 的常模，精确解为零";

      protected
        constant Integer n = size(A, 1);
        Real G[size(A, 1),size(A, 2)] = B * Matrices.solve2(R, transpose(B));
        Real Xk[size(A, 1),size(A, 2)];
        Real Ak[size(A, 1),size(A, 2)];
        Real Rk[size(A, 1),size(A, 2)];
        Real Nk[size(A, 1),size(A, 2)];
        Real Vk[size(A, 1),size(A, 2)];
        Real tk;
        Integer k;
        Boolean stop;

      algorithm
        if n > 1 then
          k := 0;
          stop := false;
          Xk := X0;
          while (not stop) loop
            k := k + 1;
            Ak := A - G * Xk;
            Rk := transpose(A) * Xk + Xk * A + Q - Xk * G * Xk;
            Nk := Matrices.continuousLyapunov(Ak, -Rk);
            Vk := Nk * G * Nk;
            tk := Matrices.Utilities.findLocal_tk(Rk, Vk);
            stop := eps > Matrices.frobeniusNorm(tk * Nk) / Matrices.frobeniusNorm(Xk) 
              or k >= maxSteps;
            Xk := Xk + tk * Nk;
          end while;
          X := Xk;
          r := Matrices.frobeniusNorm(X * A + transpose(A) * X - X * G * X + Q);

        elseif n == 1 then
          // 精确计算
          X := matrix((A[1,1] - sqrt(A[1,1] * A[1,1] + G[1,1] * Q[1,1])) / G[1,1]);
          if X[1,1] * G[1,1] < A[1,1] then
            X := matrix((A[1,1] + sqrt(A[1,1] * A[1,1] + G[1,1] * Q[1,1])) / G[1,
              1]);
          end if;
          r := 0;
        else
          X := fill(
            0, 
            0, 
            0);
          r := 0;
        end if;

        annotation(Documentation(info="<html><h4>Syntax</h4><p>
<br>
</p>
<pre><code >X = Matrices.Utilities.continuousRiccatiIterative(A, B, R, Q, X0);
(X, r) = Matrices.Utilities.continuousRiccatiIterative(A, B, R, Q, X0, maxSteps, eps);
</code></pre><p>
<br>
</p>
<h4>说明</h4><p>
这个函数提供了一种类似牛顿的方法来求解连续代数黎卡提方程(注意)。它利用精确线搜索来改善有时不稳定的牛顿法的收敛性。在这种情况下，精确行搜索意味着，在每次迭代<code>i</code>时，牛顿步 <code><strong>delta_i</strong></code>
</p>
<p>
<br>
</p>
<pre><code >X_i+1 = X_i + delta_i
</code></pre><p>
<br>
</p>
<p>
取最小残差的Frobenius范数的方向
</p>
<p>
<br>
</p>
<pre><code >r = || X_i+1*A +A\\\\\\'*X_i+1 - X_i+1*G*X_i+1 + Q ||.
</code></pre><p>
<br>
</p>
<p>
和
</p>
<p>
<br>
</p>
<pre><code >-1
G = B*R *B\\\\\\'
</code></pre><p>
<br>
</p>
<p>
输入\"maxSteps\" 和 \"eps\"指定迭代的终止。如果是其中之一，迭代将终止 已执行maxSteps迭代步骤或相对变化<strong>delta</strong>_i/<strong>X</strong>_i小于eps.
</p>
<p>
使用适当的初始值<strong>X</strong>0，可以在几个迭代步骤内获得足够精确的解决方案。虽然是李雅普诺夫方程 阶<code>n</code> (n为Riccati方程的阶数)，则算法可能会更快 而不是直接使用<a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\" target=\"\">Matrices. continuousRiccati</a>，因为直接方法必须解2*n阶哈密顿 系统方程.<br> 算法取自[1]和[2].
</p>
<h4>参考文献</h4><p>
<br>
</p>
<pre><code >[1] Benner, P., Byers, R.
An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
[2] Datta, B.N.
Numerical Methods for Linear Control Systems
Elsevier Academic Press, 2004.
</code></pre><p>
<br>
</p>
<h4>例子</h4><p>
<br>
</p>
<pre><code >A=[0.0,         1.0,         0.0,         0.0;
0.0,        -1.890,       3.900e-01,  -5.530;
0.0,        -3.400e-02,  -2.980,       2.430;
3.400e-02,  -1.100e-03,  -9.900e-01,  -2.100e-01];

B=[ 0.0,         0.0;
3.600e-01,  -1.60;
-9.500e-01,  -3.200e-02;
3.000e-02,   0.0];

R=[1, 0; 0, 1];

Q=[2.313,       2.727,       6.880e-01,   2.300e-02;
2.727,       4.271,       1.148,       3.230e-01;
6.880e-01,   1.148,       3.130e-01,   1.020e-01;
2.300e-02,   3.230e-01,   1.020e-01,   8.300e-02];

X0=identity(4);

(X,r) = Matrices.Utilities.continuousRiccatiIterative(A, B, R, Q, X0);

// X = [1.3239,  0.9015,  0.5466, -1.7672;
  0.9015,  0.9607,  0.4334, -1.1989;
  0.5466,  0.4334,  0.4605, -1.3633;
 -1.7672, -1.1989, -1.3633,  4.4612]
// r =  2.48809423389491E-015

(,r) = Matrices.Utilities.continuousRiccatiIterative(A, B, R, Q, X0,4);

// r =  0.0004;
</code></pre><p>
<br>
</p>
<h4>另请参阅<a href=\"modelica://Modelica.Math.Matrices.Utilities.discreteRiccatiIterative\" target=\"\">Matrices.Utilities.discreteRiccatiIterative</a><br><a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\" target=\"\">Matrices.continuousRiccati</a></h4><p>
<br>
</p>
<h4></h4><p>
<br>
</p>
<h4></h4><p>
<br>
</p>
</html>",revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
 by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
      end continuousRiccatiIterative;

      function discreteRiccatiIterative 
        "采用精确线性搜索求解离散代数Riccati方程的牛顿法"
        extends Modelica.Icons.Function;

        import Modelica.Math.Matrices;

        input Real A[:,size(A, 1)] "离散Riccati方程的矩阵A";
        input Real B[size(A, 1),:] "离散Riccati方程的矩阵B";
        input Real R[size(B, 2),size(B, 2)] = identity(size(B, 2)) 
          "离散Riccati方程的矩阵R";
        input Real Q[size(A, 1),size(A, 2)] = identity(size(A, 1)) 
          "离散Riccati方程的矩阵Q";
        input Real X0[size(A, 1),size(A, 2)] = identity(size(A, 1)) 
          "离散Riccati方程初始近似解";
        input Integer maxSteps = 10 "最大迭代步骤数";
        input Real eps = Matrices.frobeniusNorm(A) * 1e-9 
          "停止准则公差";

        output Real X[size(X0, 1),size(X0, 2)];
        output Real r;

      protected
        constant Integer n = size(A, 1);
        Real Xk[size(A, 1),size(A, 2)];
        Real Ak[size(A, 1),size(A, 2)];
        Real Rk[size(A, 1),size(A, 2)];
        Real Nk[size(A, 1),size(A, 2)];
        Real Hk[size(B, 2),size(B, 1)];
        Real Vk[size(A, 1),size(A, 2)];
        Real AT[size(A, 2),size(A, 2)] = transpose(A);
        Real BT[size(B, 2),size(B, 1)] = transpose(B);
        Real tk;
        Integer k;

        Boolean stop;

      algorithm
        if n > 0 then
          k := 0;
          stop := false;
          Xk := X0;
          while (not stop) loop
            k := k + 1;
            Hk := Matrices.solve2(R + BT * Xk * B, BT);
            Ak := A - B * Hk * Xk * A;
            Rk := AT * Xk * A - Xk + Q - AT * Xk * B * Hk * Xk * A;
            Nk := Modelica.Math.Matrices.discreteLyapunov(
              A = Ak, 
              C = -Rk, 
              sgn = -1);
            Vk := transpose(Ak) * Nk * B * Hk * Nk * Ak;
            tk := Modelica.Math.Matrices.Utilities.findLocal_tk(Rk, Vk);
            stop := eps > Matrices.frobeniusNorm(tk * Nk) / Matrices.frobeniusNorm(Xk) 
              or k >= maxSteps;
            Xk := Xk + tk * Nk;
          end while;
          X := Xk;
          r := Matrices.frobeniusNorm(AT * X * A - X + Q - AT * X * B * Matrices.solve2(R 
            + BT * X * B, BT) * X * A);
        else
          X := fill(
            0, 
            0, 
            0);
          r := 0;
        end if;

        annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >X = Matrices.Utilities.discreteRiccatiIterative(A, B, R, Q, X0);
(X, r) = Matrices.Utilities.discreteRiccatiIterative(A, B, R, Q, X0, maxSteps, eps);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
这个函数提供了一种类似牛顿的方法来求解离散时间代数黎卡提方程。它使用精确线搜索来改善有时不稳定的 牛顿法的收敛性。在这种情况下，精确行搜索意味着，在每次迭代<code>i</code>时，牛顿步 <code><strong>delta_i</strong></code>。
</p>
<p>
<br>
</p>
<pre><code >X_i+1 = X_i + delta_i
</code></pre><p>
<br>
</p>
<p>
取最小残差的Frobenius范数的方向
</p>
<p>
<br>
</p>
<pre><code >r = || A\\'X_i+1*A - X_i+1 - A\\'X_i+1*G_i*X_i+1*A + Q ||
</code></pre><p>
<br>
</p>
<p>
和
</p>
<p>
<br>
</p>
<pre><code >           -1
G_i = B*(R + B\\'*X_i*B) *B\\'
</code></pre><p>
<br>
</p>
<p>
输出<code>r</code>是上次迭代的残差的范数.<br>
</p>
<p>
输入\"maxSteps\" 和 \"eps\" 指定迭代的终止。如果是其中之一，迭代将终止 已执行maxSteps迭代步骤或相对变化<strong>delta</strong>_i/<strong>X</strong>_i小于eps.
</p>
<p>
使用适当的初始值<strong>X</strong>0，可以通过几个迭代步骤获得足够精确的解。虽然李雅普诺夫方程 order <code>n</code> (n为Riccati方程的阶数)在每个迭代步骤中都要求解，算法可能会更快 而不是像<a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\" target=\"\">Matrices. discreteRiccati</a>，因为直接方法必须求解2*n阶哈密顿 系统方程。 算法取自[1]和[2].
</p>
<h4>参考文献</h4><p>
<br>
</p>
<pre><code >[1] Benner, P., Byers, R.
An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
[2] Datta, B.N.
Numerical Methods for Linear Control Systems
Elsevier Academic Press, 2004.
</code></pre><p>
<br>
</p>
<h4>例子</h4><p>
<br>
</p>
<pre><code >A  = [0.9970,    0.0000,    0.0000,    0.0000;
1.0000,    0.0000,    0.0000,    0.0000;
0.0000,    1.0000,    0.0000,    0.0000;
0.0000,    0.0000,    1.0000,    0.0000];

B  = [0.0150;
0.0000;
0.0000;
0.0000];

R = [0.2500];

Q = [0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 0;
0, 0, 0, 1];

X0=identity(4);

(X,r) = Matrices.Utilities.discreteRiccatiIterative(A, B, R, Q, X0);

//  X = [30.625, 0.0, 0.0, 0.0;
0.0,   1.0, 0.0, 0.0;
0.0,   0.0, 1.0, 0.0;
0.0,   0.0, 0.0, 1.0];

// r =   3.10862446895044E-015
</code></pre><p>
<br>
</p>
<h4>另请参阅<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\" target=\"\">Matrices.Utilities.continuousRiccatiIterative</a><br><a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\" target=\"\">Matrices.discreteRiccati</a></h4><p>
<br>
</p>
</html>",revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
      end discreteRiccatiIterative;

      function toUpperHessenberg 
        "通过正交相似变换将实方阵A转换为上Hessenberg矩阵H：Q' * A * Q = H"
        extends Modelica.Icons.Function;

        import Modelica.Math.Matrices;
        import Modelica.Math.Matrices.LAPACK;

        input Real A[:,size(A, 1)] "方阵A";
        input Integer ilo = 1 
          "原始矩阵不是上三角形式的最低指标";
        input Integer ihi = size(A, 1) 
          "原始矩阵不是上三角形式的最高指标";
        output Real H[size(A, 1),size(A, 2)] "上海森伯格形式";
        output Real V[size(A, 1),size(A, 2)] 
          "V=[v1,v2,..vn-1,0] vi是定义初等反射器的向量";

        output Real tau[max(0, size(A, 1) - 1)] 
          "初等反射器的标量因子";
        output Integer info "函数调用成功的信息";

      protected
        constant Integer n = size(A, 1);
        Real Aout[size(A, 1),size(A, 2)];
        Integer i;

      algorithm
        if n > 0 then
          if n == 1 then
            H := A;
            V := {{0.0}};
            tau := zeros(0);
            info := 0;
          else
            (Aout,tau,info) := LAPACK.dgehrd(A, ilo, ihi);
            H := zeros(size(H, 1), size(H, 2));
            H[1:2,1:n] := Aout[1:2,1:n];
            for i in 3:n loop
              for j in (i - 1):n loop
                H[i,j] := Aout[i,j];
              end for;
            //H[i, (i - 1):n] := Aout[i, (i - 1):n];
            end for;
            V := zeros(size(V, 1), size(V, 2));
            for i in ilo:min(n - 2, ihi) loop
              V[i + 1,i] := 1.0;
              for j in (i + 2):n loop
                V[j,i] := Aout[j,i];
              end for;
            //V[(i + 2):n, i] := Aout[(i + 2):n, i];
            end for;
            V[n,n - 1] := 1;
          end if;
        end if;
        annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
      H = Matrices.Utilities.<strong>toUpperHessenberg</strong>(A);
(H, V, tau, info) = Matrices.Utilities.<strong>toUpperHessenberg</strong>(A,ilo, ihi);
</pre></blockquote>
<h4>描述</h4>
<p>
函数<strong>toUpperHessenberg</strong>通过正交相似变换计算矩阵<strong> a </strong>的上Hessenberg形式<strong>H</strong>: <strong>Q</strong>' * <strong> a </strong> * <strong>Q</strong> = <strong>H</strong>。
可选输入<strong>ilo</strong>和<strong>ihi</strong>如果矩阵已经部分转换为海森伯格形式，则可以提高效率;假设
矩阵<strong>A</strong>对于行和列<strong>1:(ihi -1)</strong>和<strong>(ihi+1):size(A, 1)</strong>已经是上Hessenberg。
该函数调用<a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgehrd\">LAPACK.dgehrd</a>。
参见<a href=\"modelica://Modelica.Math.Matrices.LAPACK.dgehrd\">Matrices.LAPACK. dgehrd</a>。有关附加输出V, tau, info和输入ilo, ihi的更多信息.
</p>

<h4>例子</h4>
<blockquote><pre>
A  = [1, 2, 3;
6, 5, 4;
1, 0, 0];

H = toUpperHessenberg(A);

结果:

H = [1.0,  -2.466,  2.630;
-6.083, 5.514, -3.081;
0.0,   0.919, -0.514]
</pre></blockquote>

<h4>另请参阅</h4>
<a href=\"modelica://Modelica.Math.Matrices.hessenberg\">Matrices.hessenberg</a>
</html>"                        , revisions = "<html><ul>
<li><em>2010/04/30 </em>
by Marcus Baur, DLR-RM</li>
</ul>
</html>"                        ));
      end toUpperHessenberg;

      function eigenvaluesHessenberg 
        "计算上海森堡阵的特征值"
        extends Modelica.Icons.Function;

        import Modelica.Math.Matrices.LAPACK;
        input Real H[:,size(H, 1)] "海森伯格矩阵H";

        output Real ev[size(H, 1),2] "特征值";
        output Integer info = 0;
      protected
        Real alphaReal[size(H, 1)] 
          "alpha的实部(eigenvalue=(alphaReal+i*alphaImag))";
        Real alphaImag[size(H, 1)] 
          "alpha的虚部(eigenvalue=(alphaReal+i*alphaImag))";
      algorithm
        if size(H, 1) > 0 then
          (alphaReal,alphaImag,info) := LAPACK.dhseqr(H);
        else
          alphaReal := fill(0, size(H, 1));
          alphaImag := fill(0, size(H, 1));
        end if;
        ev := [alphaReal, alphaImag];

        annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >  ev = Matrices.Utilities.eigenvaluesHessenberg(H);
(ev, info) = Matrices.Utilities.eigenvaluesHessenberg(H);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
这个函数计算一个海森堡阵的特征值。变换成海森堡阵形式是任意矩阵的QR分解特征值计算的第一步。 如果矩阵已经具有海森堡阵形式，则可以跳过这一步。
</p>
<p>
该函数使用lapack例程dhseqr。如果调用成功，输出<code>info</code>为0 函数。<br> 见 <a href=\"modelica://Modelica.Math.Matrices.LAPACK.dhseqr\" target=\"\">Matrices.LAPACK.dhseqr</a> for details
</p>
<h4>例子</h4><p>
<br>
</p>
<pre><code >Real A[3,3] = [1,2,3;
         9,8,7;
         0,1,0];

Real ev[3,2];

ev := Matrices.Utilities.eigenvaluesHessenberg(A);

// ev  = [10.7538,    0.0;
    -0.8769,    1.0444;
    -0.8769,   -1.0444]
// = {10.7538,  -0.8769 +- i*1.0444}
</code></pre><p>
<br>
</p>
<h4>另见</h4><p>
<a href=\"modelica://Modelica.Math.Matrices.eigenValues\" target=\"\">Matrices.eigenValues</a>, <a href=\"modelica://Modelica.Math.Matrices.hessenberg\" target=\"\">Matrices.hessenberg</a>
</p>
<p>
<br>
</p>
</html>"      ,revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
 by Marcus Baur, DLR-RM</li>
</ul>
</html>"      ));
      end eigenvaluesHessenberg;

      function reorderRSF 
        "将实Schur形式重新排序为稳定和不稳定特征值的簇"
        extends Modelica.Icons.Function;

        import Modelica.Math.Matrices.LAPACK;

        input Real T[:,:] "实舒尔形式";
        input Real Q[:,size(T, 2)] "舒尔向量矩阵";
        input Real alphaReal[size(T, 1)] 
          "特征值的实部=alphaReal+i*alphaImag";
        input Real alphaImag[size(T, 1)] 
          "特征值的虚部=alphaReal+i*alphaImag";
        input Boolean iscontinuous = true 
          "= true，如果对应系统是连续的。离散系统为False";

        output Real To[size(T, 1),size(T, 2)] "重新排序舒尔形式";
        output Real Qo[size(T, 1),size(T, 2)] "重排序舒尔向量矩阵";
        output Real wr[size(T, 2)] "重新排序的特征值，实部";
        output Real wi[size(T, 2)] "重排序的特征值，虚部";

      protected
        constant Integer n = size(T, 2);
        Boolean select[size(T, 2)] = fill(false, size(T, 2));
        Integer i;
      algorithm
        if iscontinuous then
          for i in 1:n loop
            if alphaReal[i] < 0 then
              select[i] := true;
            end if;
          end for;
        else
          for i in 1:n loop
            if alphaReal[i] ^ 2 + alphaImag[i] ^ 2 < 1 then
              select[i] := true;
            end if;
          end for;
        end if;

        (To,Qo,wr,wi) := LAPACK.dtrsen(
          "E", 
          "V", 
          select, 
          T, 
          Q);

        annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >        To = Matrices.Utilities.reorderRSF(T, Q, alphaReal, alphaImag);
(To, Qo, wr, wi) = Matrices.Utilities.reorderRSF(T, Q, alphaReal, alphaImag, iscontinuous);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
函数<strong>reorderRSF</strong>()重新排序一个实Schur形式，使得 系统均在1 × 1和2 × 2对角线块的块<strong>上</strong>三角矩阵中。 如果将舒尔形式引用到一个连续系统，则其特征值在左复半平面上。 离散系统的稳定特征值在复单位圆内。<br> 这个函数用于求解代数黎卡提方程 (<a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\" target=\"\">continuousRiccati</a>, <a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\" target=\"\">discreteRiccati</a>)。在这种情况下，舒尔形式 以及对应的特征值和变换矩阵<strong>Q</strong>是已知的，为什么特征值和变换矩阵是<strong>reorderRSF()</strong>的输入.<br> 舒尔向量矩阵<strong>Qo</strong>也按照<strong> to </strong>重新排序。向量<strong>wr</strong>和<strong>wi</strong>包含向量的实部和虚部 分别重新排序特征值.
</p>
<h4>例子</h4><p>
<br>
</p>
<pre><code >T := [-1,2, 3,4;
 0,2, 6,5;
 0,0,-3,5;
 0,0, 0,6];
To := Matrices.Utilities.reorderRSF(T,identity(4),{-1, 2, -3, 6},{0, 0, 0, 0}, true);

// To = [-1.0, -0.384, 3.585, 4.0;
//        0.0, -3.0,   6.0,   0.64;
//        0.0,  0.0,   2.0,   7.04;
//        0.0,  0.0,   0.0,   6.0]
</code></pre><p>
<br>
</p>
<p>
另请参阅 <a href=\"modelica://Modelica.Math.Matrices.realSchur\" target=\"\">Matrices.realSchur</a>
</p>
<p>
<br>
</p>
</html>",revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
 by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
      end reorderRSF;

      function findLocal_tk 
        "找到一个局部极小器tk来定义连续迭代和离散迭代中步骤tk*Nk的长度"
        extends Modelica.Icons.Function;

        import Modelica.Math.Matrices;
        import Modelica.Math.Polynomials;

        input Real Rk[:,size(Rk, 1)];
        input Real Vk[size(Rk, 1),size(Rk, 2)];

        output Real tk;

      protected
        Real alpha_k;
        Real beta_k;
        Real gamma_k;
        Real p[3,2];
        Boolean h;

      algorithm
        alpha_k := Matrices.trace(Rk * Rk);
        beta_k := Matrices.trace(Rk * Vk);
        gamma_k := Matrices.trace(Vk * Vk);

        if gamma_k > Modelica.Constants.eps then
          p := Polynomials.roots({4 * gamma_k, 6 * beta_k, 2 * (alpha_k - 2 * beta_k), 
            -2 * alpha_k});
          h := false;
          for i1 in 1:3 loop
            if abs(p[i1,2]) < Modelica.Constants.eps then
              if abs(p[i1,1] - 1) <= 1 then
                tk := p[i1,1];
                h := true;
              end if;
            end if;
          end for;
          if not h then
            tk := 1;
          end if;

        else
          tk := 1;
        end if;

        annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >tk = Matrices.Utilities.findLocal_tk(Rk, Vk);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
函数<code>findLocal_tk()</code>是基于牛顿法的代数Riccati方程迭代求解器中调用的辅助函数精确行搜索，如<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\" target=\"\">continuousRiccatiIterative</a><br> 和 <a href=\"modelica://Modelica.Math.Matrices.Utilities.discreteRiccatiIterative\" target=\"\">discreteRiccatiIterative</a>.<br> 函数计算函数f_k(t_k)的局部最小值
</p>
<p>
<br>
</p>
<pre><code >f_k(t_k) = alpha_k*(1-t_k)^2 + 2*beta_k*(1-t)*t^2 + gamma_k*t^4
</code></pre><p>
<br>
</p>
<p>
通过计算导数d f_k/d t_k的零点。已知函数f_k(t_k)在[0,2]中的某个值t_k_min处有一个局部最小值。<br> 使用t_k_min，算法的下一个残差的范数将被最小化。<br>参见[1]了解更多信息
</p>
<h4>参考文献</h4><p>
<br>
</p>
<pre><code >[1] Benner, P., Byers, R.
An Exact Line Search Method for Solving Generalized Continuous-Time Algebraic Riccati Equations
IEEE Transactions On Automatic Control, Vol. 43, No. 1, pp. 101-107, 1998.
</code></pre><p>
<br>
</p>
<h4>另请参阅<a href=\"modelica://Modelica.Math.Matrices.Utilities.continuousRiccatiIterative\" target=\"\">Matrices.Utilities.continuousRiccatiIterative</a><br><a href=\"modelica://Modelica.Math.Matrices.Utilities.discreteRiccatiIterative\" target=\"\">Matrices.Utilities.discreteRiccatiIterative</a><br></h4><p>
<br>
</p>
</html>",revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
      end findLocal_tk;
      annotation(Documentation(info = "<html>
<p>
这个包包含了被更高级矩阵函数使用的工具函数。
这些函数通常对最终用户没有什么用处。
</p>
</html>"            ));
      function householderReflection 
        "反映矩阵A的每个向量A=[a_1, a_2, ..., a_n]在正交向量u的平面上"
        extends Modelica.Icons.Function;
        import Modelica.Math.Vectors;

        input Real A[:,:] "长方形矩阵";
        input Real u[size(A, 1)] "户主矢量";

        output Real RA[size(A, 1),size(A, 2)] "A 的反射";

      protected
        constant Integer n = size(A, 2);
        Real h;
        Real lu = (Vectors.length(u)) ^ 2;

      algorithm
        if n > 0 then
          for i in 1:n loop
            h := scalar(2 * transpose(matrix(u)) * A[:,i] / lu);
            RA[:,i] := A[:,i] - h * u;
          end for;
        end if;

        annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >Matrices.householderReflection(A,u);
</code></pre><p>
<br>
</p>
<h4>说明</h4><p>
该函数计算豪斯霍尔德变换
</p>
<p>
<strong>Ar</strong> = <strong>Q</strong>*<strong>A</strong><br>和<br>
</p>
<p>
<strong>Q</strong> = <strong>I</strong> -2*<strong>u</strong>*<strong>u</strong>\\'/(<strong>u</strong>\\'*<strong>u</strong>)
</p>
<p>
其中，<strong>u</strong> 是豪斯托向量，即反射面的法向量。
</p>
<p>
豪斯霍尔德变换被广泛应用于数值线性代数中，如进行 QR 分解。
</p>
<h4>示例</h4><p>
<br>
</p>
<pre><code >// QR 分解的第一步
import   Modelica.Math.Vectors.Utilities;

Real A[3,3] = [1,2,3;
   3,4,5;
   2,1,4];
Real Ar[3,3];
Real u[:];

u=Utilities.householderVector(A[:,1],{1,0,0});
// u= {0.763, 0.646, 0}

Ar=householderReflection(A,u);
// Ar = [-6.0828,   -5.2608,   -4.4388;
//        0.0,      -1.1508,   -2.3016;
//        0.0,       2.0,       0.0]

</code></pre><p>
<br>
</p>
<h4>另见</h4><p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderSimilarityTransformation\" target=\"\">Matrices.Utilities.housholderSimilarityTransformation</a>,<br> <a href=\"modelica://Modelica.Math.Vectors.Utilities.householderReflection\" target=\"\">Vectors.Utilities.householderReflection</a>,<br> <a href=\"modelica://Modelica.Math.Vectors.Utilities.householderVector\" target=\"\">Vectors.Utilities.householderVector</a>
</p>
<p>
<br>
</p>
</html>",revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
      end householderReflection;
      function householderSimilarityTransformation 
        "用对称户矩阵S = I - 2u*u'对矩阵A进行相似性变换S*A*S"
        extends Modelica.Icons.Function;

        import Modelica.Math.Vectors;

        input Real A[:,size(A, 1)] "正方形矩阵 A";
        input Real u[size(A, 1)] "户主矢量";
        output Real SAS[size(A, 1),size(A, 1)] "矩阵 A 的变换";

      protected
        constant Integer na = size(A, 1);
        Real S[size(A, 1),size(A, 1)] "对称矩阵";
        Integer i;
      algorithm
        if na > 0 then
          S := -2 * matrix(u) * transpose(matrix(u)) / (Vectors.length(u) * 
            Vectors.length(u));
          for i in 1:na loop
            S[i,i] := 1.0 + S[i,i];
          end for;
          SAS := S * A * S;
        else
          SAS := fill(
            0.0, 
            0, 
            0);
        end if;

        annotation(Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >As = Matrices.householderSimilarityTransformation(A,u);
</code></pre><p>
<br>
</p>
<h4>说明</h4><p>
该函数计算 Householder 相似性变换
</p>
<p>
<strong>As</strong> = <strong>S</strong>*<strong>A</strong>*<strong>S</strong><br>和<br>
</p>
<p>
<strong>S</strong> = <strong>I</strong> -2*<strong>u</strong>*<strong>u</strong>\\'/(<strong>u</strong>\\'*<strong>u</strong>).
</p>
<p>
这种变换被广泛用于将非对称矩阵转换为海森堡形式。
</p>
<h4>示例</h4><p>
<br>
</p>
<pre><code >// 海森伯分解的第一步
import   Modelica.Math.Vectors.Utilities;

Real A[4,4] = [1,2,3,4;
       3,4,5,6;
       9,8,7,6;
       1,2,0,0];
Real Ar[4,4];
Real u[4]={0,0,0,0};

u[2:4]=Utilities.householderVector(A[2:4,1],{1,0,0});
// u= = {0, 0.8107, 0.5819, 0.0647}

Ar=householderSimilarityTransformation(A,u);
//  Ar = [1.0,     -3.8787,    -1.2193,    3.531;
-9.5394, 11.3407,      6.4336,   -5.9243;
 0.0,     3.1307,      0.7525,   -3.3670;
 0.0,     0.8021,     -1.1656,   -1.0932]
</code></pre><p>
<br>
</p>
<h4>另见</h4><p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.householderReflection\" target=\"\">Matrices.Utilities.householderReflection</a>,<br> <a href=\"modelica://Modelica.Math.Vectors.Utilities.householderReflection\" target=\"\">Vectors.Utilities.householderReflection</a>,<br> <a href=\"modelica://Modelica.Math.Vectors.Utilities.householderVector\" target=\"\">Vectors.Utilities.householderVector</a>
</p>
<p>
<br>
</p>
</html>",revisions = "<html>
<ul>
<li><em>2010/04/30 </em>
by Marcus Baur, DLR-RM</li>
</ul>
</html>"));
      end householderSimilarityTransformation;
    end Utilities;
    annotation(Documentation(info = "<html>
<h4>库的内容</h4>
<p>
这个库提供了对矩阵进行运算的函数。
下面，函数按类别排序，并展示了各自的典型调用。
大多数函数仅仅是外部<a href=\"modelica://Modelica.Math.Matrices.LAPACK\">LAPACK</a>库的接口。
</p>
<p>
注意：A'是矩阵A的转置(transpose(A))的简写表示。
</p>

<p><strong>基本信息</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.toString\">toString</a>(A)
     - 返回矩阵A的字符串表示形式。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.isEqual\">isEqual</a>(M1, M2)
     - 如果矩阵M1和M2具有相同大小和相同元素，则返回true。</li>
</ul>

<p><strong>线性方程</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.solve\">solve</a>(A,b)
     - 返回线性方程A*x=b的解x(其中b是一个向量，A是一个方阵且必须是正则的)。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.solve2\">solve2</a>(A,B)
     - 返回线性方程A*X=B的解X(其中B是一个矩阵，A是一个方阵且必须是正则的)。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.leastSquares\">leastSquares</a>(A,b)
     - 返回线性方程A*x=b在最小二乘意义上的解x(其中b是一个向量，A可以是非平方的，也可以是秩不足的)。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.leastSquares2\">leastSquares2</a>(A,B)
     - 返回线性方程A*X=B在最小二乘意义上的解X(其中B是一个矩阵，A可以是非平方的，也可以是秩不足的)。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.equalityLeastSquares\">equalityLeastSquares</a>(A,a,B,b)
     - 返回线性等式约束最小二乘问题的解x：最小化|Ax - a|^2，同时满足Bx = b。</li>

<li> (LU,p,info) = <a href=\"modelica://Modelica.Math.Matrices.LU\">LU</a>(A)
     - 返回矩阵A的带行主元的LU分解。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve\">LU_solve</a>(LU,p,b)
     - 返回线性方程L*U*x[p]=b的解x，b为向量，LU分解来自\"LU(..)\"。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.LU_solve2\">LU_solve2</a>(LU,p,B)
     - 返回线性方程L*U*X[p,:]=B的解X，B为矩阵，LU分解来自\"LU(..)\"。</li>
</ul>

<p><strong>矩阵分解</strong></p>
<ul>
<li> (eval,evec) = <a href=\"modelica://Modelica.Math.Matrices.eigenValues\">eigenValues</a>(A)
     - 返回实数非对称矩阵A的特征值\"eval\"和特征向量\"evec\"，以实数表示。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.eigenValueMatrix\">eigenValueMatrix</a>(eval)
     - 返回矩阵A的特征值\"eval\"的实值块对角矩阵。</li>

<li> (sigma,U,VT) = <a href=\"modelica://Modelica.Math.Matrices.singularValues\">singularValues</a>(A)
     - 返回矩阵A的奇异值\"sigma\"以及左奇异向量U和右奇异向量VT。</li>

<li> (Q,R,p) = <a href=\"modelica://Modelica.Math.Matrices.QR\">QR</a>(A)
     - 返回矩阵A的带列选主元素的QR分解，使得Q*R = A[:,p]。</li>

<li> (H,U) = <a href=\"modelica://Modelica.Math.Matrices.hessenberg\">hessenberg</a>(A)
     - 返回矩阵A的上Hessenberg形式H和正交变换矩阵U，使得H = U'AU。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.realSchur\">realSchur</a>(A)
     - 返回矩阵A的实Schur形式。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.cholesky\">cholesky</a>(A)
     - 返回实对称正定矩阵A的Cholesky因子H，使得A = H'*H。</li>

<li> (D,Aimproved) = <a href=\"modelica://Modelica.Math.Matrices.balance\">balance</a>(A)
     - 返回矩阵A的改进形式Aimproved，使得其条件数比A小，且Aimproved = inv(diagonal(D))*A*diagonal(D)。</li>
</ul>

<p><strong>矩阵属性</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.trace\">trace</a>(A)
     - 返回方阵A的迹，即对角元素的和。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.det\">det</a>(A)
     - 返回方阵A的行列式(使用LU分解；尽量避免使用det(..))。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.inv\">inv</a>(A)
     - 返回方阵A的逆矩阵(尽量避免使用，建议使用\"solve2(..)\"并设B=identity(..))。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.rank\">rank</a>(A)
     - 返回方阵A的秩(用奇异值分解计算)。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.conditionNumber\">conditionNumber</a>(A)
     - 返回范围为1..&infin;的方阵A的条件数norm(A)*norm(inv(A))。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.rcond\">rcond</a>(A)
     - 返回方阵A在0..1范围内的倒数条件数1/conditionNumber(A)。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.norm\">norm</a>(A)
     - 返回矩阵A的1-范数、2-范数或无穷范数。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.frobeniusNorm\">frobeniusNorm</a>(A)
     - 返回矩阵A的Frobenius范数。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.nullSpace\">nullSpace</a>(A)
     - 返回矩阵A的零空间。</li>
</ul>

<p><strong>矩阵指数</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.exp\">exp</a>(A)
     - 返回矩阵A的指数e^A，使用自适应泰勒级数展开，带有缩放和平衡处理。</li>

<li> (phi, gamma) = <a href=\"modelica://Modelica.Math.Matrices.integralExp\">integralExp</a>(A,B)
     - 返回矩阵指数phi = e^A和积分gamma=integral(exp(A*t)*dt)*B，适用于带零阶保持的离散化系统。</li>

<li> (phi, gamma, gamma1) = <a href=\"modelica://Modelica.Math.Matrices.integralExpT\">integralExpT</a>(A,B)
     - 返回矩阵指数phi = e^A，积分gamma=integral(exp(A*t)*dt)*B，
     以及时间加权积分gamma1 = integral((T-t)*exp(A*t)*dt)*B，适用于带一阶保持的离散化系统。</li>
</ul>

<p><strong>矩阵方程</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.continuousLyapunov\">continuousLyapunov</a>(A,C)
     - 返回连续时间Lyapunov方程X*A + A'*X = C的解X。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.continuousSylvester\">continuousSylvester</a>(A,B,C)
     - 返回连续时间Sylvester方程A*X + X*B = C的解X。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.continuousRiccati\">continuousRiccati</a>(A,B,R,Q)
     - 返回连续时间代数Riccati方程A'*X + X*A - X*B*inv(R)*B'*X + Q = 0的解X。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteLyapunov\">discreteLyapunov</a>(A,C)
     - 返回离散时间Lyapunov方程A'*X*A + sgn*X = C的解X。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteSylvester\">discreteSylvester</a>(A,B,C)
     - 返回离散时间Sylvester方程A*X*B + sgn*X = C的解X。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.discreteRiccati\">discreteRiccati</a>(A,B,R,Q)
     - 返回离散时间代数Riccati方程A'*X*A - X - A'*X*B*inv(R + B'*X*B)*B'*X*A + Q = 0的解X。</li>
</ul>

<p><strong>矩阵操作</strong></p>
<ul>
<li> <a href=\"modelica://Modelica.Math.Matrices.sort\">sort</a>(M)
     - 返回矩阵M中按升序或降序排序的行或列。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.flipLeftRight\">flipLeftRight</a>(M)
     - 返回矩阵M，使M的列在左/右方向翻转。</li>

<li> <a href=\"modelica://Modelica.Math.Matrices.flipUpDown\">flipUpDown</a>(M)
     - 返回矩阵M，使M的行在上/下方向翻转。</li>
</ul>

<h4>另见</h4>
<a href=\"modelica://Modelica.Math.Vectors\">Vectors</a>

</html>"    ), Icon(graphics = {
      Rectangle(
      extent = {{-60, 66}, {-30, 18}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {175, 175, 175}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{28, 66}, {58, 18}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {175, 175, 175}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{-60, -18}, {-30, -66}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {175, 175, 175}, 
      fillPattern = FillPattern.Solid), 
      Rectangle(
      extent = {{28, -18}, {58, -66}}, 
      lineColor = {95, 95, 95}, 
      fillColor = {175, 175, 175}, 
      fillPattern = FillPattern.Solid)}));
  end Matrices;

  package Icons "数学库图标"
    extends Modelica.Icons.IconsPackage;

    partial function AxisLeft 
      "数学函数的基本图标，y轴在左侧"

      annotation(
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
        100}}), graphics = {
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(points = {{-80, -80}, {-80, 68}}, color = {192, 192, 192}), 
        Polygon(
        points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
        lineColor = {192, 192, 192}, 
        fillColor = {192, 192, 192}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-150, 150}, {150, 110}}, 
        textString = "%name", 
        textColor = {0, 0, 255})}), 
        Documentation(info = "<html>
<p>
数学函数图标，由左侧的y轴组成。预计会添加x轴和函数绘图。
</p>
</html>"    ));
    end AxisLeft;

    partial function AxisCenter 
      "数学函数的基本图标，y轴在中心"

      annotation(
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
        100}}), graphics = {
        Rectangle(
        extent = {{-100, 100}, {100, -100}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(points = {{0, -80}, {0, 68}}, color = {192, 192, 192}), 
        Polygon(
        points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
        lineColor = {192, 192, 192}, 
        fillColor = {192, 192, 192}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-150, 150}, {150, 110}}, 
        textString = "%name", 
        textColor = {0, 0, 255})}), 
        Documentation(info = "<html>
<p>
数学函数图标，中间有一个y轴。预计会添加一个x轴并绘制函数图。
</p>
</html>"  ));
    end AxisCenter;
    annotation();

  end Icons;

  function isEqual "确定两个实型标量在数值上是否相等"
    extends Modelica.Icons.Function;
    input Real s1 "第一个标量";
    input Real s2 "第二个标量";
    input Real eps(min = 0) = 0 
      "如果abs(s1-s2) <= eps，则两个标量相等";
    output Boolean result "= true，如果标量相等";
  algorithm
    result := abs(s1 - s2) <= eps;
    annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
Math.<strong>isEqual</strong>(s1, s2);
Math.<strong>isEqual</strong>(s1, s2, eps=0);
</pre></blockquote>
<h4>说明</h4>
<p>
如果两个实型标量s1和s2是相等的，调用函数\"<code>Math.isEqual(s1, s2)</code>\"则返回<strong>true</strong>。
否则函数返回<strong>false</strong>。相等性检查由
\"abs(s1-s2) ≤ eps\"实现，其中\"eps\"
可以作为函数的第三个参数提供。默认值为\"eps = 0\"。
</p>
<h4>示例</h4>
<blockquote><pre>
  Real s1 = 2.0;
  Real s2 = 2.0;
  Real s3 = 2.000001;
  Boolean result;
<strong>algorithm</strong>
  result := Math.isEqual(s1,s2);     // = <strong>true</strong>
  result := Math.isEqual(s1,s3);     // = <strong>false</strong>
  result := Math.isEqual(s1,s3,0.1); // = <strong>true</strong>
</pre></blockquote>
<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>,
<a href=\"modelica://Modelica.Math.Matrices.isEqual\">Matrices.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</p>
</html>"));
  end isEqual;

  function sin "正弦"
    extends Modelica.Math.Icons.AxisLeft;
    input Modelica.Units.SI.Angle u "自变量";
    output Real y "因变量y = sin(u)";

  external "builtin" y = sin(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, 0}, {-68.7, 34.2}, {-61.5, 53.1}, {-55.1, 66.4}, {-49.4, 74.6}, 
    {-43.8, 79.1}, {-38.2, 79.8}, {-32.6, 76.6}, {-26.9, 69.7}, {-21.3, 59.4}, 
    {-14.9, 44.1}, {-6.83, 21.2}, {10.1, -30.8}, {17.3, -50.2}, {23.7, -64.2}, 
    {29.3, -73.1}, {35, -78.4}, {40.6, -80}, {46.2, -77.6}, {51.9, -71.5}, {
    57.5, -61.9}, {63.9, -47.2}, {72, -24.8}, {80, 0}}), 
    Text(
    extent = {{12, 84}, {84, 36}}, 
    textColor = {192, 192, 192}, 
    textString = "sin")}), 
    Documentation(info = "<html>
<p>
该函数返回y = sin(u)，其中-&infin; &lt; u &lt; &infin;：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/sin.png\">
</div>
</html>"      ));
  end sin;

  function cos "余弦"
    extends Modelica.Math.Icons.AxisLeft;
    input Modelica.Units.SI.Angle u "自变量";
    output Real y "因变量y = cos(u)";

  external "builtin" y = cos(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, 80}, {-74.4, 78.1}, {-68.7, 72.3}, {-63.1, 63}, {-56.7, 48.7}, 
    {-48.6, 26.6}, {-29.3, -32.5}, {-22.1, -51.7}, {-15.7, -65.3}, {-10.1, -73.8}, 
    {-4.42, -78.8}, {1.21, -79.9}, {6.83, -77.1}, {12.5, -70.6}, {18.1, -60.6}, 
    {24.5, -45.7}, {32.6, -23}, {50.3, 31.3}, {57.5, 50.7}, {63.9, 64.6}, {69.5, 
    73.4}, {75.2, 78.6}, {80, 80}}), 
    Text(
    extent = {{-36, 82}, {36, 34}}, 
    textColor = {192, 192, 192}, 
    textString = "cos")}), 
    Documentation(info = "<html>
<p>
此函数返回y = cos(u)，其中-&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\">
</div>
</html>"      ));
  end cos;

  function tan "正切(u不得为-pi/2、pi/2、3*pi/2、...)"
    extends Modelica.Math.Icons.AxisCenter;
    input Modelica.Units.SI.Angle u "自变量";
    output Real y "因变量y = tan(u)";

  external "builtin" y = tan(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, -80}, {-78.4, -68.4}, {-76.8, -59.7}, {-74.4, -50}, {-71.2, -40.9}, 
    {-67.1, -33}, {-60.7, -24.8}, {-51.1, -17.2}, {-35.8, -9.98}, {-4.42, -1.07}, 
    {33.4, 9.12}, {49.4, 16.2}, {59.1, 23.2}, {65.5, 30.6}, {70.4, 39.1}, {73.6, 
    47.4}, {76, 56.1}, {77.6, 63.8}, {80, 80}}), 
    Text(
    extent = {{-90, 72}, {-18, 24}}, 
    textColor = {192, 192, 192}, 
    textString = "tan")}), 
    Documentation(info = "<html>
<p>
此函数返回y = tan(u)，其中 -&infin; &lt; u &lt; &infin;
(如果u是(2n-1)*pi/2的倍数，则y = tan(u)为 +/- 无穷大)。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\">
</div>
</html>"      ));
  end tan;

  function asin "反正弦(-1 <= u <= 1)"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u "自变量";
    output Modelica.Units.SI.Angle y "因变量y = asin(u)";

  external "builtin" y = asin(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, -80}, {-79.2, -72.8}, {-77.6, -67.5}, {-73.6, -59.4}, {-66.3, 
    -49.8}, {-53.5, -37.3}, {-30.2, -19.7}, {37.4, 24.8}, {57.5, 40.8}, {68.7, 
    52.7}, {75.2, 62.2}, {77.6, 67.5}, {80, 80}}), 
    Text(
    extent = {{-88, 78}, {-16, 30}}, 
    textColor = {192, 192, 192}, 
    textString = "asin")}), 
    Documentation(info = "<html>
<p>
该函数返回y = asin(u)，其中-1 &le; u &le; +1:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\">
</div>
</html>"    ));
  end asin;

  function acos "反余弦(-1 <= u <= 1)"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u "自变量";
    output Modelica.Units.SI.Angle y "因变量y = acos(u)";

  external "builtin" y = acos(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, -80}, {68, -80}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, 80}, {-79.2, 72.8}, {-77.6, 67.5}, {-73.6, 59.4}, {-66.3, 
    49.8}, {-53.5, 37.3}, {-30.2, 19.7}, {37.4, -24.8}, {57.5, -40.8}, {68.7, -52.7}, 
    {75.2, -62.2}, {77.6, -67.5}, {80, -80}}), 
    Text(
    extent = {{-86, -14}, {-14, -62}}, 
    textColor = {192, 192, 192}, 
    textString = "acos")}), 
    Documentation(info = "<html>
<p>
该函数返回y = acos(u)，其中-1 &le; u &le; +1:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\">
</div>
</html>"      ));
  end acos;

  function atan "反正切"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u "自变量";
    output Modelica.Units.SI.Angle y "因变量y = atan(u)";

  external "builtin" y = atan(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, -80}, {-52.7, -75.2}, {-37.4, -69.7}, {-26.9, -63}, {-19.7, -55.2}, 
    {-14.1, -45.8}, {-10.1, -36.4}, {-6.03, -23.9}, {-1.21, -5.06}, {5.23, 21}, 
    {9.25, 34.1}, {13.3, 44.2}, {18.1, 52.9}, {24.5, 60.8}, {33.4, 67.6}, {47, 
    73.6}, {69.5, 78.6}, {80, 80}}), 
    Text(
    extent = {{-86, 68}, {-14, 20}}, 
    textColor = {192, 192, 192}, 
    textString = "atan")}), 
    Documentation(info = "<html>
<p>
此函数返回y = atan(u)，其中-&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/atan.png\">
</div>
</html>"      ));
  end atan;

  function atan2 "四象限反正切"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u1 "第一个自变量";
    input Real u2 "第二个自变量";
    output Modelica.Units.SI.Angle y "因变量y = atan2(u1, u2) = atan(u1/u2)";

  external "builtin" y = atan2(u1, u2);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{0, -80}, {8.93, -67.2}, {17.1, -59.3}, {27.3, -53.6}, {42.1, -49.4}, 
    {69.9, -45.8}, {80, -45.1}}), 
    Line(points = {{-80, -34.9}, {-46.1, -31.4}, {-29.4, -27.1}, {-18.3, -21.5}, {-10.3, 
    -14.5}, {-2.03, -3.17}, {7.97, 11.6}, {15.5, 19.4}, {24.3, 25}, {39, 30}, {
    62.1, 33.5}, {80, 34.9}}), 
    Line(points = {{-80, 45.1}, {-45.9, 48.7}, {-29.1, 52.9}, {-18.1, 58.6}, {-10.2, 
    65.8}, {-1.82, 77.2}, {0, 80}}), 
    Text(
    extent = {{-90, -46}, {-18, -94}}, 
    textColor = {192, 192, 192}, 
    textString = "atan2")}), 
    Documentation(info = "<html>
<p>
这个函数返回y = atan2(u1, u2)，其中tan(y) = u1/u2，且y在-pi &lt; y &le; pi范围内。
u2可以为零，前提是u1不为零。通常，u1、u2的形式为u1 = sin(y)和u2 = cos(y)：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/atan2.png\">
</div>

</html>"            ));
  end atan2;

  function atan3 
    "四象限反正切(选择最接近给定角度y0的解)"
    import Modelica.Constants.pi;
    extends Modelica.Math.Icons.AxisCenter;
    input Real u1 "第一个自变量";
    input Real u2 "第二个自变量";
    input Modelica.Units.SI.Angle y0 = 0 "y应在范围内: -pi < y - y0 <= pi";
    output Modelica.Units.SI.Angle y "因变量y = atan3(u1, u2, y0) = atan(u1/u2)";

  protected
    constant Real pi2 = 2 * pi;
    Real w;
  algorithm
    w := Math.atan2(u1, u2);
    if y0 == 0 then
      // 对于默认值（y0 = 0），返回的结果与 atan2(...) 完全相同
      y := w;
    else
      /* -pi < y - y0 <= pi
      -pi < w + 2*pi*N - y0 <= pi
      (-pi+y0-w)/(2*pi) < N <= (pi+y0-w)/(2*pi)
      -> N := integer( (pi+y0-w)/(2*pi) )
      */
      y := w + pi2 * integer((pi + y0 - w) / pi2);
    end if;
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{0, -80}, {8.93, -67.2}, {17.1, -59.3}, {27.3, -53.6}, {42.1, -49.4}, 
      {69.9, -45.8}, {80, -45.1}}), 
      Line(points = {{-80, -34.9}, {-46.1, -31.4}, {-29.4, -27.1}, {-18.3, -21.5}, {-10.3, 
      -14.5}, {-2.03, -3.17}, {7.97, 11.6}, {15.5, 19.4}, {24.3, 25}, {39, 30}, {
      62.1, 33.5}, {80, 34.9}}), 
      Line(points = {{-80, 45.1}, {-45.9, 48.7}, {-29.1, 52.9}, {-18.1, 58.6}, {-10.2, 
      65.8}, {-1.82, 77.2}, {0, 80}}), 
      Text(
      extent = {{-90, -46}, {-18, -94}}, 
      textColor = {192, 192, 192}, 
      textString = "atan3")}), 
      Documentation(info = "<html>
<p>
这个函数返回y = <strong>atan3</strong>(u1, u2, y0)，使得<strong>tan</strong>(y) = u1/u2并且y的取值范围是：-pi &lt; y - y0 &le; pi。<br>
u2可能是零，前提是u1不为零。与Modelica.Math.atan2(..)的区别是可选的第三个参数y0，允许指定返回无限多解中的特定解：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/atan3.png\">
</div>

<p>
注意，对于默认情况(y0 = 0)，返回结果与atan2(..)完全相同。
</p>
</html>"          ));
  end atan3;

  function sinh "双曲正弦"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u "自变量";
    output Real y "因变量y = sinh(u)";

  external "builtin" y = sinh(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, -80}, {-76, -65.4}, {-71.2, -51.4}, {-65.5, -38.8}, {-59.1, -28.1}, 
    {-51.1, -18.7}, {-41.4, -11.4}, {-27.7, -5.5}, {-4.42, -0.653}, {24.5, 
    4.57}, {39, 10.1}, {49.4, 17.2}, {57.5, 25.9}, {63.9, 35.8}, {69.5, 47.4}, {
    74.4, 60.4}, {78.4, 73.8}, {80, 80}}), 
    Text(
    extent = {{-88, 80}, {-16, 32}}, 
    textColor = {192, 192, 192}, 
    textString = "sinh")}), 
    Documentation(info = "<html>
<p>
此函数返回y = sinh(u)，其中-&infin; &lt; u &lt; &infin;：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/sinh.png\">
</div>
</html>"    ));
  end sinh;

  function cosh "双曲余弦"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u "自变量";
    output Real y "因变量y = cosh(u)";

  external "builtin" y = cosh(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, -86.083}, {68, -86.083}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, -86.083}, {68, -78.083}, {68, -94.083}, {90, -86.083}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, 80}, {-77.6, 61.1}, {-74.4, 39.3}, {-71.2, 20.7}, {-67.1, 
    1.29}, {-63.1, -14.6}, {-58.3, -29.8}, {-52.7, -43.5}, {-46.2, -55.1}, {-39, 
    -64.3}, {-30.2, -71.7}, {-18.9, -77.1}, {-4.42, -79.9}, {10.9, -79.1}, {
    23.7, -75.2}, {34.2, -68.7}, {42.2, -60.6}, {48.6, -51.2}, {54.3, -40}, {
    59.1, -27.5}, {63.1, -14.6}, {67.1, 1.29}, {71.2, 20.7}, {74.4, 39.3}, {
    77.6, 61.1}, {80, 80}}), 
    Text(
    extent = {{4, 66}, {66, 20}}, 
    textColor = {192, 192, 192}, 
    textString = "cosh")}), 
    Documentation(info = "<html>
<p>
此函数返回y = cosh(u)，其中-&infin; &lt; u &lt; &infin;：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/cosh.png\">
</div>
</html>"      ));
  end cosh;

  function tanh "双曲正切"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u "自变量";
    output Real y "因变量y = tanh(u)";

  external "builtin" y = tanh(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, -80}, {-47.8, -78.7}, {-35.8, -75.7}, {-27.7, -70.6}, {-22.1, 
    -64.2}, {-17.3, -55.9}, {-12.5, -44.3}, {-7.64, -29.2}, {-1.21, -4.82}, {
    6.83, 26.3}, {11.7, 42}, {16.5, 54.2}, {21.3, 63.1}, {26.9, 69.9}, {34.2, 75}, 
    {45.4, 78.4}, {72, 79.9}, {80, 80}}), 
    Text(
    extent = {{-88, 72}, {-16, 24}}, 
    textColor = {192, 192, 192}, 
    textString = "tanh")}), 
    Documentation(info = "<html>
<p>
此函数返回y = tanh(u)，其中-&infin; &lt; u &lt; &infin;：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\">
</div>
</html>"      ));
  end tanh;

  function asinh "sinh的反函数(面积双曲正弦)"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u "自变量";
    output Real y "因变量y = asinh(u)";

  algorithm
    y := Modelica.Math.log(u + sqrt(u * u + 1));
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -80}, {-56.7, -68.4}, {-39.8, -56.8}, {-26.9, -44.7}, {-17.3, 
      -32.4}, {-9.25, -19}, {9.25, 19}, {17.3, 32.4}, {26.9, 44.7}, {39.8, 56.8}, 
      {56.7, 68.4}, {80, 80}}), 
      Text(
      extent = {{-90, 80}, {-6, 26}}, 
      textColor = {192, 192, 192}, 
      textString = "asinh")}), 
      Documentation(info = "<html>
<p>
此函数返回输入参数u的面积双曲正弦(area hyperbolic sine)值。作为sinh(..)的反函数，asinh(u)是唯一的，并且对输入参数u没有任何限制
(-&infin; &lt; u &lt; &infin;)：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/asinh.png\">
</div>
</html>"          ));
  end asinh;

  function acosh "cosh的反函数(面积双曲余弦)"
    extends Modelica.Math.Icons.AxisLeft;
    input Real u "自变量";
    output Real y "因变量y = acosh(u)";

  algorithm
    assert(u >= 1.0, "输入参数 u (= " + String(u) + 
      ") of acosh(u) must be >= 1.0");
    y := Modelica.Math.log(u + sqrt(u * u - 1));
    annotation(
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-90, -80}, {68, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-66, -80}, {-65.2, -66}, {-64.4, -60.3}, {-62.8, -52.2}, {-60.4, -43.4}, 
      {-56.4, -32.4}, {-49.9, -19.3}, {-41.1, -5.65}, {-29, 8.8}, {-12.9, 23.8}, 
      {7.97, 39.2}, {35.3, 55}, {69.9, 70.8}, {94, 80}}), 
      Text(
      extent = {{-14, 2}, {76, -54}}, 
      textColor = {192, 192, 192}, 
      textString = "arcosh")}), 
      Documentation(info = "<html>
<p>
此函数返回输入参数u的面积双曲余弦(area hyperbolic cosine)值。
u的有效范围是
</p>
<blockquote><pre>
+1 &le; u &lt; +&infin;
</pre></blockquote>
<p>
如果在调用函数时使得u &lt; 1，则会出现错误。
函数cosh(u)有两个反函数(曲线看起来类似于sqrt(..)函数)。acosh(..)返回值为正的反函数。
当u = 1时，导数dy/du是无穷的。因此，如果 u 可能接近 1，则不应在模型中使用此函数：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/acosh.png\">
</div>
</html>"              ));
  end acosh;

  function exp "以e为底的指数"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u "自变量";
    output Real y "因变量y = exp(u)";

  external "builtin" y = exp(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, -80.3976}, {68, -80.3976}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, -80.3976}, {68, -72.3976}, {68, -88.3976}, {90, -80.3976}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, -80}, {-31, -77.9}, {-6.03, -74}, {10.9, -68.4}, {23.7, -61}, 
    {34.2, -51.6}, {43, -40.3}, {50.3, -27.8}, {56.7, -13.5}, {62.3, 2.23}, {
    67.1, 18.6}, {72, 38.2}, {76, 57.6}, {80, 80}}), 
    Text(
    extent = {{-86, 50}, {-14, 2}}, 
    textColor = {192, 192, 192}, 
    textString = "exp")}), 
    Documentation(info = "<html>
<p>
该函数返回y = exp(u)，其中-&infin; &lt; u &lt; &infin;:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
</div>
</html>"    ));
  end exp;

  function log "自然对数(以e为底)(u应大于0)"
    extends Modelica.Math.Icons.AxisLeft;
    input Real u "自变量";
    output Real y "因变量y = ln(u)";

  external "builtin" y = log(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-80, -80}, {-79.2, -50.6}, {-78.4, -37}, {-77.6, -28}, {-76.8, -21.3}, 
    {-75.2, -11.4}, {-72.8, -1.31}, {-69.5, 8.08}, {-64.7, 17.9}, {-57.5, 28}, 
    {-47, 38.1}, {-31.8, 48.1}, {-10.1, 58}, {22.1, 68}, {68.7, 78.1}, {80, 80}}), 
    Text(
    extent = {{-6, -24}, {66, -72}}, 
    textColor = {192, 192, 192}, 
    textString = "log")}), 
    Documentation(info = "<html>
<p>
此函数返回y = log(10)(u的自然对数)、其中u &gt; 0：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/log.png\">
</div>
</html>"      ));
  end log;

  function log10 "以10为底的对数(u应大于0)"
    extends Modelica.Math.Icons.AxisLeft;
    input Real u "自变量";
    output Real y "因变量y = lg(u)";

  external "builtin" y = log10(u);
  annotation(
    Icon(coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
    Polygon(
    points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}, 
    lineColor = {192, 192, 192}, 
    fillColor = {192, 192, 192}, 
    fillPattern = FillPattern.Solid), 
    Line(points = {{-79.8, -80}, {-79.2, -50.6}, {-78.4, -37}, {-77.6, -28}, {-76.8, -21.3}, 
    {-75.2, -11.4}, {-72.8, -1.31}, {-69.5, 8.08}, {-64.7, 17.9}, {-57.5, 28}, 
    {-47, 38.1}, {-31.8, 48.1}, {-10.1, 58}, {22.1, 68}, {68.7, 78.1}, {80, 80}}), 
    Text(
    extent = {{-30, -22}, {60, -70}}, 
    textColor = {192, 192, 192}, 
    textString = "log10")}), 
    Documentation(info = "<html>
<p>
此函数返回y = log10(u)、其中u &gt; 0：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/log10.png\">
</div>
</html>"  ));
  end log10;

  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
    {100, 100}}), graphics = {Line(points = {{-80, 0}, {-68.7, 34.2}, {-61.5, 53.1}, 
    {-55.1, 66.4}, {-49.4, 74.6}, {-43.8, 79.1}, {-38.2, 79.8}, {-32.6, 76.6}, {
    -26.9, 69.7}, {-21.3, 59.4}, {-14.9, 44.1}, {-6.83, 21.2}, {10.1, -30.8}, {17.3, 
    -50.2}, {23.7, -64.2}, {29.3, -73.1}, {35, -78.4}, {40.6, -80}, {46.2, -77.6}, 
    {51.9, -71.5}, {57.5, -61.9}, {63.9, -47.2}, {72, -24.8}, {80, 0}}, color = {
    0, 0, 0}, smooth = Smooth.Bezier)}), Documentation(info = "<html>
<p>
该包包含<strong>基本数学函数</strong>(如sin(..))，
以及
<a href=\"modelica://Modelica.Math.Vectors\">vectors</a>、
<a href=\"modelica://Modelica.Math.Matrices\">matrices</a>、
<a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>和
<a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>运算的函数。
</p>

<h4>主要作者</h4>
<p><a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a>
和 <strong>Marcus Baur</strong><br>
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e.V. (DLR)<br>
Institut f&uuml;r Systemdynamik und Regelungstechnik (DLR-SR)<br>
Forschungszentrum Oberpfaffenhofen<br>
D-82234 Wessling<br>
Germany<br>
email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a>
</p>

<p>
版权所有&copy; 1998-2020，Modelica协会及其贡献者
</p>
</html>", revisions = "<html>
<ul>
<li><em>June 22, 2019</em>
       by Thomas Beutlich: 移动函数tempInterpol1/tempInterpol2到ObsoleteModelica4</li>
<li><em>August 24, 2016</em>
       by Christian Kral: 添加wrapAngle</li>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       添加函数tempInterpol2。</li>
<li><em>Oct. 24, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       引入了图标和图形级别的图标。</li>
<li><em>June 30, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       实现。</li>
</ul>
</html>"));
end Math;