within Modelica.Blocks;
package Nonlinear 
  "不连续或不可微分代数控制模块库"
  import Modelica.Blocks.Interfaces;
  extends Modelica.Icons.Package;

  block Limiter "限制信号范围"
    parameter Real uMax(start = 1) "输入信号的上限";
    parameter Real uMin = -uMax "输入信号的下限";
    parameter Boolean strict = false "=true，如果使用noEvent(...)进行严格限制" 
      annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级"));
    parameter Types.LimiterHomotopy homotopyType = Modelica.Blocks.Types.LimiterHomotopy.Linear "基于同构初始化的简化模型" 
      annotation(Evaluate = true, Dialog(group = "初始化"));
    extends Interfaces.SISO;
  protected
    Real simplifiedExpr "基于同伦初始化的简化表达式";

  equation
    assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) + 
      ") < uMin (=" + String(uMin) + ")");
    simplifiedExpr = (if homotopyType == Types.LimiterHomotopy.Linear then u 
      else if homotopyType == Types.LimiterHomotopy.UpperLimit then uMax 
      else if homotopyType == Types.LimiterHomotopy.LowerLimit then uMin 
      else 0);
    if strict then
      if homotopyType == Types.LimiterHomotopy.NoHomotopy then
        y = smooth(0, noEvent(if u > uMax then uMax else if u < uMin then uMin else u));
      else
        y = homotopy(actual = smooth(0, noEvent(if u > uMax then uMax else if u < uMin then uMin else u)), 
          simplified = simplifiedExpr);
      end if;
    else
      if homotopyType == Types.LimiterHomotopy.NoHomotopy then
        y = smooth(0, if u > uMax then uMax else if u < uMin then uMin else u);
      else
        y = homotopy(actual = smooth(0, if u > uMax then uMax else if u < uMin then uMin else u), 
          simplified = simplifiedExpr);
      end if;
    end if;
    annotation(
      Documentation(info="<html><p>
只要输入信号在指定的上限和下限范围内，Limiter 模块就会将其输入信号作为输出信号。 否则，相应的限值将作为输出信号传递。
</p>
<p>
在高级选项卡中的参数 <code>homotopyType</code> 指定了如果使用基于同伦的初始化，则简化行为：
</p>
<li>
<code>NoHomotopy</code>: 使用带限制的实际表达式</li>
<li>
<code>Linear</code>: 假设线性行为 y = u &nbsp;(默认选项)</li>
<li>
<code>UpperLimit</code>: 假设输出卡在上限 u = uMax</li>
<li>
<code>LowerLimit</code>: 假设输出卡在下限 u = uMin</li>
<p>
如果事先知道输入信号将位于哪个区域， 那么这个选项可以从初始化问题中去除一个强非线性因素，从而起到很大作用。
</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{0, -90}, {0, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, -8}, {68, 8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -70}, {-50, -70}, {50, 70}, {80, 70}}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "uMax=%uMax"), 
      Line(
      visible = strict, 
      points = {{50, 70}, {80, 70}}, 
      color = {255, 0, 0}), 
      Line(
      visible = strict, 
      points = {{-80, -70}, {-50, -70}}, 
      color = {255, 0, 0})}));
  end Limiter;

  block VariableLimiter "用可变限值限制信号范围"
    extends Interfaces.SISO;
    parameter Boolean strict = false "=true，如果使用noEvent(...)进行严格限制" 
      annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级"));
    parameter Types.VariableLimiterHomotopy homotopyType = Modelica.Blocks.Types.VariableLimiterHomotopy.Linear "基于同伦的初始化简化模型" 
      annotation(Evaluate = true, Dialog(group = "初始化"));
    parameter Real ySimplified = 0 "简化模型中的固定输出值" 
      annotation(Dialog(tab = "高级", enable = homotopyType == Modelica.Blocks.Types.VariableLimiterHomotopy.Fixed));
    Interfaces.RealInput limit1 
      "作为最大输入信号的实数输入信号接口u" 
      annotation(Placement(transformation(extent = {{-140, 60}, {-100, 100}})));
    Interfaces.RealInput limit2 
      "作为最小输入信号的实数输入信号连口u" 
      annotation(Placement(transformation(extent = {{-140, -100}, {-100, -60}})));
  protected
    Real simplifiedExpr "基于同伦初始化的简化表达式";
  equation
    assert(limit1 >= limit2, "Input signals are not consistent: limit1 < limit2");
    simplifiedExpr = (if homotopyType == Types.VariableLimiterHomotopy.Linear then u 
      else if homotopyType == Types.VariableLimiterHomotopy.Fixed then ySimplified 
      else 0);
    if strict then
      if homotopyType == Types.VariableLimiterHomotopy.NoHomotopy then
        y = smooth(0, noEvent(if u > limit1 then limit1 else if u < limit2 then limit2 else u));
      else
        y = homotopy(actual = smooth(0, noEvent(if u > limit1 then limit1 else if u < limit2 then limit2 else u)), 
          simplified = simplifiedExpr);
      end if;
    else
      if homotopyType == Types.VariableLimiterHomotopy.NoHomotopy then
        y = smooth(0, if u > limit1 then limit1 else if u < limit2 then limit2 else u);
      else
        y = homotopy(actual = smooth(0, if u > limit1 then limit1 else if u < limit2 then limit2 else u), 
          simplified = simplifiedExpr);
      end if;
    end if;

    annotation(
      Documentation(info="<html><p>
只要输入信号在两个附加输入 limit1 和 limit2 指定的上限和下限范围内， 限幅块就会将其输入信号作为输出信号。 否则，相应的限值将作为输出信号传递。
</p>
<p>
在高级选项卡中的参数 <code>homotopyType</code> 指定了如果使用基于同伦的初始化，则简化行为：
</p>
<li>
<code>NoHomotopy</code>: 使用带限制的实际表达式</li>
<li>
<code>Linear</code>: 假设线性行为 (默认选项)</li>
<li>
<code>Fixed</code>:假设输出固定在值<code>ySimplified</code></li>
<p>
如果事先知道输入信号将位于哪个区域， 那么这个选项可以从初始化问题中去除一个强非线性因素， 从而起到很大作用。
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 
      100}}), graphics = {
      Line(points = {{0, -90}, {0, 68}}, color = {192, 192, 192}), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, -8}, {68, 8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -70}, {-50, -70}, {50, 70}, {80, 70}}), 
      Line(points = {{-100, 80}, {66, 80}, {66, 70}}, color = {0, 0, 127}), 
      Line(points = {{-100, -80}, {-64, -80}, {-64, -70}}, color = {0, 0, 127}), 
      Polygon(points = {{-64, -70}, {-66, -74}, {-62, -74}, {-64, -70}}, lineColor = {
      0, 0, 127}), 
      Polygon(points = {{66, 70}, {64, 74}, {68, 74}, {66, 70}}, lineColor = {0, 0, 127}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      visible = strict, 
      points = {{50, 70}, {80, 70}}, 
      color = {255, 0, 0}), 
      Line(
      visible = strict, 
      points = {{-80, -70}, {-50, -70}}, 
      color = {255, 0, 0})}));
  end VariableLimiter;

  block SlewRateLimiter "限制信号的斜率"
    extends Modelica.Blocks.Interfaces.SISO;
    import Modelica.Constants.small;
    parameter Real Rising(min = small) = 1 
      "最大上升斜率[+small..+inf)[1/s]";
    parameter Real Falling(max = -small) = -Rising 
      "最大下降斜率(-inf..-small][1/s]";
    parameter SI.Time Td(min = small) = 0.001 
      "导数时间常数";
    parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.SteadyState 
      "初始化类型(SteadyState表示y=u）" 
      annotation(Evaluate = true, Dialog(group = "初始化"));
    parameter Real y_start = 0 "输出的初始值或猜测值(=state)" 
      annotation(Dialog(group = "Initialization"));
    parameter Boolean strict = false "=true，如果使用noEvent(...)进行严格限制" 
      annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级"));
  protected
    Real val = (u - y) / Td;
  initial equation
    if initType == Modelica.Blocks.Types.Init.SteadyState then
      y = u;
    elseif initType == Modelica.Blocks.Types.Init.InitialState 
      or initType == Modelica.Blocks.Types.Init.InitialOutput then
      y = y_start;
    end if;
  equation
    if strict then
      der(y) = smooth(1, (if noEvent(val < Falling) then Falling else if noEvent(val > Rising) then Rising else val));
    else
      der(y) = if val < Falling then Falling else if val > Rising then Rising else val;
    end if;
    annotation(Icon(graphics = {
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Line(points = {{0, -90}, {0, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Polygon(
      points = {{90, 0}, {68, -8}, {68, 8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = {{-50, -70}, {50, 70}}), 
      Line(
      visible = strict, 
      points = {{50, 70}, {-50, -70}}, 
      color = {255, 0, 0})}), 
      Documentation(info = "<html>
<p>
<code>SlewRateLimiter</code> 模块将其输入信号的斜率限制在<code>[Falling, Rising]</code>范围内。
</p>
<p>
为了确保对任意输入进行微分，并产生微分输出，
输入要通过导数时间常数<code>Td</code> 进行数值微分。
时间常数<code>Td</code>越小，表示导数越接近理想导数。
</p>
<p><em>注：用户必须根据输入信号的性质选择导数时间常数。</em></p>
</html>"  , 
      revisions = "<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<th>Revision</th>
<th>Date</th>
<th>Author</th>
<th>Comment</th>
</tr>
<tr>
<td>4954</td>
<td>2012-03-02</td>
<td>A. Haumer &amp; D. Winkler</td>
<td><p>Initial version based on discussion in ticket <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/529\">#529</a></p></td>
</tr>
</table>
</html>"  ));
  end SlewRateLimiter;

  block DeadZone "提供零输出区域"
    parameter Real uMax(start = 1) "死区的上限";
    parameter Real uMin = -uMax "死区的下限";
    extends Interfaces.SISO;

  equation
    assert(uMax >= uMin, "DeadZone: Limits must be consistent. However, uMax (=" + String(uMax) + 
      ") < uMin (=" + String(uMin) + ")");

    y = homotopy(actual = smooth(0, if u > uMax then u - uMax else if u < uMin then u - uMin else 0), simplified = u);

    annotation(
      Documentation(info="<html><p>
DeadZone 模块定义一个输出为零的区域。
</p>
<p>
如果输入在 uMin ...uMax，输出为零。在此区域之外，输出是输入的线性函数，斜率为 1。
</p>
</html>"    ), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{0, -90}, {0, 68}}, color = {192, 192, 192}), 
      Polygon(
      points = {{0, 90}, {-8, 68}, {8, 68}, {0, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, 0}, {68, -8}, {68, 8}, {90, 0}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -60}, {-20, 0}, {20, 0}, {80, 60}}), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textColor = {160, 160, 164}, 
      textString = "uMax=%uMax")}));
  end DeadZone;

  block FixedDelay "具有固定 DelayTime 的延迟模块"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Time delayTime(start = 1) 
      "输出相对于输入信号的延迟时间";

  equation
    y = delay(u, delayTime);
    annotation(
      Documentation(info="<html><p>
输入信号延迟给定的时间时刻，或者更准确地说：
</p>
<pre><code >y = u(time - delayTime) for time &gt; time.start + delayTime
= u(time.start)       for time ≤ time.start + delayTime</code></pre><p>
<br>
</p>
</html>"  ), Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Text(
      extent = {{8.0, -142.0}, {8.0, -102.0}}, 
      textString = "delayTime=%delayTime"), 
      Line(
      points = {{-92.0, 0.0}, {-80.7, 34.2}, {-73.5, 53.1}, {-67.1, 66.4}, {-61.4, 74.6}, {-55.8, 79.1}, {-50.2, 79.8}, {-44.6, 76.6}, {-38.9, 69.7}, {-33.3, 59.4}, {-26.9, 44.1}, {-18.83, 21.2}, {-1.9, -30.8}, {5.3, -50.2}, {11.7, -64.2}, {17.3, -73.1}, {23.0, -78.4}, {28.6, -80.0}, {34.2, -77.6}, {39.9, -71.5}, {45.5, -61.9}, {51.9, -47.2}, {60.0, -24.8}, {68.0, 0.0}}, 
      color = {0, 0, 127}, 
      smooth = Smooth.Bezier), 
      Line(
      points = {{-62.0, 0.0}, {-50.7, 34.2}, {-43.5, 53.1}, {-37.1, 66.4}, {-31.4, 74.6}, {-25.8, 79.1}, {-20.2, 79.8}, {-14.6, 76.6}, {-8.9, 69.7}, {-3.3, 59.4}, {3.1, 44.1}, {11.17, 21.2}, {28.1, -30.8}, {35.3, -50.2}, {41.7, -64.2}, {47.3, -73.1}, {53.0, -78.4}, {58.6, -80.0}, {64.2, -77.6}, {69.9, -71.5}, {75.5, -61.9}, {81.9, -47.2}, {90.0, -24.8}, {98.0, 0.0}}, 
      color = {160, 160, 164}, 
      smooth = Smooth.Bezier)}));
  end FixedDelay;

  block PadeDelay 
    "延迟模块的 Pade 近似值，延迟时间固定（使用 balance=true；这不是默认值，以便向后兼容）"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Time delayTime(start = 1) 
      "输出相对于输入信号的延迟时间";
    parameter Integer n(min = 1) = 1 "Pade 延迟的顺序";
    parameter Integer m(min = 1, max = n) = n 
      "分子的顺序(通常为m=n，或m=n-1)";
    parameter Boolean balance = false 
      "=true，如果状态空间系统是平衡的（强烈推荐），否则教材版本" 
      annotation(choices(checkBox = true));
    final output Real x[n] 
      "来自控制器标准型的传递函数状态（balance=false），或平衡的控制器标准型（balance=true）";

  protected
    parameter Real a1[n](each fixed = false) "矩阵A的第一行";
    parameter Real b11(fixed = false) "=B[1,1]";
    parameter Real c[n](each fixed = false) "C行矩阵";
    parameter Real d(fixed = false) "D矩阵";
    parameter Real s[n - 1](each fixed = false) "状态缩放";

    function padeCoefficients2
      extends Modelica.Icons.Function;
      input Real T "延迟时间";
      input Integer n "分母阶次";
      input Integer m "分子的阶次";
      input Boolean balance = false;
      output Real a1[n] "矩阵A的第一行";
      output Real b11 "=B[1,1]";
      output Real c[n] "C行矩阵";
      output Real d "D矩阵";
      output Real s[n - 1] "缩放，使得x[i]=s[i-1]*x[i-1]，i>1";
    protected
      Real b[m + 1] "传递函数的分母系数";
      Real a[n + 1] "传递函数的分母系";
      Real nm;
      Real bb[n + 1];
      Real A[n,n];
      Real B[n,1];
      Real C[1,n];
      Real A2[n,n] = zeros(n, n);
      Real B2[n,1] = zeros(n, 1);
      Real C2[1,n] "C矩阵";
      Integer nb = m + 1;
      Integer na = n + 1;
      Real sx[n];
      annotation();
    algorithm
      a[1] := 1;
      b[1] := 1;
      nm := n + m;

      for i in 1:n loop
        a[i + 1] := a[i] * (T * ((n - i + 1) / (nm - i + 1)) / i);
        if i <= m then
          b[i + 1] := -b[i] * (T * ((m - i + 1) / (nm - i + 1)) / i);
        end if;
      end for;

      b := b[m + 1:-1:1];
      a := a[n + 1:-1:1];
      bb := vector([zeros(n - m, 1); b]);
      d := bb[1] / a[1];

      if balance then
        A2[1,:] := -a[2:na] / a[1];
        B2[1,1] := 1 / a[1];
        for i in 1:n - 1 loop
          A2[i + 1,i] := 1;
        end for;
        C2[1,:] := bb[2:na] - d * a[2:na];
        (sx,A,B,C) := Modelica.Math.Matrices.balanceABC(A2, B2, C2);
        for i in 1:n - 1 loop
          s[i] := sx[i] / sx[i + 1];
        end for;
        a1 := A[1,:];
        b11 := B[1,1];
        c := vector(C);
      else
        s := ones(n - 1);
        a1 := -a[2:na] / a[1];
        b11 := 1 / a[1];
        c := bb[2:na] - d * a[2:na];
      end if;
    end padeCoefficients2;

  equation
    der(x[1]) = a1 * x + b11 * u;
    if n > 1 then
      der(x[2:n]) = s .* x[1:n - 1];
    end if;
    y = c * x + d * u;

  initial equation
    (a1,b11,c,d,s) = padeCoefficients2(delayTime, n, m, balance);

    if balance then
      der(x) = zeros(n);
    else
      // 为了保持向后兼容性
      x[n] = u;
    end if;
    annotation(
      Documentation(info="<html><p>
输入信号被延迟一个给定的时间瞬间，或者更准确地说：
</p>
<pre><code >y = u(time - delayTime) for time &gt; time.start + delayTime
= u(time.start)       for time ≤ time.start + delayTime</code></pre><p>
延迟可通过 Pade 近似法进行近似，即通过传递函数
</p>
<pre><code >b[1]*s^m + b[2]*s^[m-1] + ... + b[m+1]
y(s) = --------------------------------------------- * u(s)
a[1]*s^n + a[2]*s^[n-1] + ... + a[n+1]</code></pre><p>
其中，系数 b[:] 和 a[:] 的计算是为了使 s=0 附近的延迟 exp(-T*s) 泰勒展开的系数在 n+m 阶以内完全相同。
</p>
<p>
这种方法的主要优点是， 延迟由线性微分方程系统近似表示， 该系统具有连续性和连续可微分性。 例如，对一个包含 Pade 近似延迟的系统进行线性化是不严谨的。
</p>
<p>
标准教科书版本使用 “m=n” 阶，这也是本程序块的默认设置。 在某些情况下，设置 “m=n-1” 可能会得到更好的近似值。
</p>
<p>
强烈建议始终设置参数 <strong>balance</strong> = true，以获得更可靠的数值计算结果。 为了向后兼容，这不是默认设置，因此必须明确设置。 除了数值效果更好外，所有状态的初始化<strong>balance</strong> = true（在稳态下，所以 der(x)= 0）。 更详细的解释：
</p>
<p>
默认情况下，Pade 近似值的传递函数以控制器规范形式实现。 这样，A 矩阵的系数数量级为 1 到 O(1/delayTime)^n 的数量级。 对于相对较小的延迟时间和 n 值，这会导致系数的变化很大（例如，延迟时间=0.001，n=4，系数介于 1 和 1e12 之间）。 反过来，这又会导致系统矩阵 [A,B;C,D] 的范数过大，从而导致数值计算不可靠。 当设置参数 <strong>balance</strong> = true 时，将进行状态转换，从而显著减小系统矩阵的范数。 执行时不会产生舍入误差。详见函数<a href=\"modelica://Modelica.Math.Matrices.balanceABC\" target=\"\">balanceABC</a>。 因此，PadeDelay 模块的模拟，尤其是其线性化变得更加可靠。
</p>
<h5>参考文献</h5><p>
Otto Foellinger: Regelungstechnik, 8. Auflage, chapter 11.9, page 412-414, Huethig Verlag Heidelberg, 1994
</p>
<p>
<br>
</p>
</html>"  ,revisions = "<html>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<th>Date</th>
<th>Author</th>
<th>Comment</th>
</tr>
<tr>
<td>2015-01-05</td>
<td>Martin Otter (DLR-SR)</td>
<td>Introduced parameter balance=true and a new implementation
of the PadeDelay block with an optional, more reliable numerics</td>
</tr>
</table>
</html>"  ), Icon(
      coordinateSystem(preserveAspectRatio = false, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Text(extent = {{8.0, -142.0}, {8.0, -102.0}}, 
      textString = "delayTime=%delayTime"), 
      Line(points = {{-94.0, 0.0}, {-82.7, 34.2}, {-75.5, 53.1}, {-69.1, 66.4}, {-63.4, 74.6}, {-57.8, 79.1}, {-52.2, 79.8}, {-46.6, 76.6}, {-40.9, 69.7}, {-35.3, 59.4}, {-28.9, 44.1}, {-20.83, 21.2}, {-3.9, -30.8}, {3.3, -50.2}, {9.7, -64.2}, {15.3, -73.1}, {21.0, -78.4}, {26.6, -80.0}, {32.2, -77.6}, {37.9, -71.5}, {43.5, -61.9}, {49.9, -47.2}, {58.0, -24.8}, {66.0, 0.0}}, 
      color = {0, 0, 127}, 
      smooth = Smooth.Bezier), 
      Line(points = {{-72.0, 0.0}, {-60.7, 34.2}, {-53.5, 53.1}, {-47.1, 66.4}, {-41.4, 74.6}, {-35.8, 79.1}, {-30.2, 79.8}, {-24.6, 76.6}, {-18.9, 69.7}, {-13.3, 59.4}, {-6.9, 44.1}, {1.17, 21.2}, {18.1, -30.8}, {25.3, -50.2}, {31.7, -64.2}, {37.3, -73.1}, {43.0, -78.4}, {48.6, -80.0}, {54.2, -77.6}, {59.9, -71.5}, {65.5, -61.9}, {71.9, -47.2}, {80.0, -24.8}, {88.0, 0.0}}, 
      color = {160, 160, 164}, 
      smooth = Smooth.Bezier), 
      Text(textColor = {160, 160, 164}, 
      extent = {{-10.0, 38.0}, {100.0, 100.0}}, 
      textString = "m=%m"), 
      Text(textColor = {160, 160, 164}, 
      extent = {{-98.0, -96.0}, {6.0, -34.0}}, 
      textString = "n=%n"), 
      Text(visible = balance, textColor = {160, 160, 164}, 
      extent = {{-96, -20}, {98, 22}}, 
      textString = "balanced")}));
  end PadeDelay;

  block VariableDelay "具有可变延迟时间的延迟模块"
    extends Modelica.Blocks.Interfaces.SISO;
    parameter SI.Duration delayMax(min = 0, start = 1) "最大延迟时间";

    Modelica.Blocks.Interfaces.RealInput delayTime annotation(Placement(
      transformation(extent = {{-140, -80}, {-100, -40}})));
  equation
    y = delay(u, delayTime, delayMax);
    annotation(
      Documentation(info="<html><p>
输入信号被延迟一个给定的时间瞬间，或者更准确地说：
</p>
<pre><code >y = u(time - delayTime) for time &gt; time.start + delayTime
= u(time.start)       for time ≤ time.start + delayTime</code></pre><p>
其中，delayTime 是额外的输入信号，必须遵循以下关系：
</p>
<pre><code >0 ≤ delayTime ≤ delayMax</code></pre><p>
<br>
</p>
</html>"), 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {
      Text(extent = {{-100.0, -148.0}, {100.0, -108.0}}, 
      textString = "delayMax=%delayMax"), 
      Line(points = {{-92.0, 0.0}, {-80.7, 34.2}, {-73.5, 53.1}, {-67.1, 66.4}, {-61.4, 74.6}, {-55.8, 79.1}, {-50.2, 79.8}, {-44.6, 76.6}, {-38.9, 69.7}, {-33.3, 59.4}, {-26.9, 44.1}, {-18.83, 21.2}, {-1.9, -30.8}, {5.3, -50.2}, {11.7, -64.2}, {17.3, -73.1}, {23.0, -78.4}, {28.6, -80.0}, {34.2, -77.6}, {39.9, -71.5}, {45.5, -61.9}, {51.9, -47.2}, {60.0, -24.8}, {68.0, 0.0}}, 
      color = {0, 0, 127}, 
      smooth = Smooth.Bezier), 
      Line(points = {{-64.0, 0.0}, {-52.7, 34.2}, {-45.5, 53.1}, {-39.1, 66.4}, {-33.4, 74.6}, {-27.8, 79.1}, {-22.2, 79.8}, {-16.6, 76.6}, {-10.9, 69.7}, {-5.3, 59.4}, {1.1, 44.1}, {9.17, 21.2}, {26.1, -30.8}, {33.3, -50.2}, {39.7, -64.2}, {45.3, -73.1}, {51.0, -78.4}, {56.6, -80.0}, {62.2, -77.6}, {67.9, -71.5}, {73.5, -61.9}, {79.9, -47.2}, {88.0, -24.8}, {96.0, 0.0}}, 
      smooth = Smooth.Bezier), 
      Polygon(fillPattern = FillPattern.Solid, 
      lineColor = {0, 0, 127}, 
      fillColor = {0, 0, 127}, 
      points = {{6.0, 4.0}, {-14.0, -2.0}, {-6.0, -12.0}, {6.0, 4.0}}), 
      Line(color = {0, 0, 127}, 
      points = {{-100.0, -60.0}, {-76.0, -60.0}, {-8.0, -6.0}})}));
  end VariableDelay;

  annotation(
    Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">此软件包包含不连续和不可微分的代数输入/输出模块。</span>
</p>
</html>",revisions = "<html>
<ul>
<li><em>October 21, 2002</em>
       by Christian Schweiger:<br>
       新增模块VariableLimiter。</li>
<li><em>August 22, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       该模块是基于现有的Dymola库，由Dieter Moormann和Hilding Elmqvist提供实现。
</li>
</ul>
</html>"), Icon(graphics = {Line(points = {{-80, -66}, {-26, -66}, {28, 52}, {88, 52}}, 
    color = {95, 95, 95})}));
  model Relay "在两个常数之间切换输出"
    parameter Real op(start = Modelica.Constants.eps, unit = 1) "开点，当输入超过这个阈值时，Relay开启。开点值必须大于或等于关点值。指定一个大于关点的开点值可以模拟滞后效应，而指定相等的值则模拟在该值处具有阈值的开关。";
    parameter Real cp(start = -Modelica.Constants.eps, unit = 1) "关点，当输入超过这个阈值时，Relay关闭。关点值必须小于或等于开点值。";

    parameter Real ov(start = 1, unit = 1) "开启时输出，当Relay开启时的输出值。";
    parameter Real cv(start = -ov, unit = 1) "关闭时输出，当Relay关闭时的输出值。";

    parameter Boolean strict = false "= true, 如果使用严格限制且无事件(..)" 
      annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级"));

    Modelica.Blocks.Interfaces.RealInput u "控制Relay开关的输入信号。" 
      annotation(Placement(transformation(origin = {-120.132, -0.739285}, 
      extent = {{-20, -20}, {20, 20}})));
    Modelica.Blocks.Interfaces.RealOutput y "输出信号在由参数决定的两个值之间切换：开启时输出和关闭时输出。" 
      annotation(Placement(transformation(origin = {110.522, 1.48515e-5}, 
      extent = {{-10, -10}, {10, 10}})));

    output Real state(start = cv, unit = 1) "状态缓存，计算并缓存当前时间的输出值";
    annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
  grid={2,2}),graphics = {Rectangle(origin={0,0}, 
  fillColor={255,255,255}, 
  fillPattern=FillPattern.Solid, 
  extent={{-100,100},{100,-100}}), Line(origin={0,0}, 
  points={{-95.5557,-0.145215},{95.9162,-0.145215}}, 
  color={181,181,181}, 
  thickness=1, 
  arrow={Arrow.None,Arrow.Filled}, 
  smooth=Smooth.Bezier, 
  __MWorks_Manhattanize=true), Line(origin={0,0}, 
  rotation=90, 
  points={{-94.8178,0.333333},{95.1756,0.333333}}, 
  color={181,181,181}, 
  thickness=1, 
  arrow={Arrow.None,Arrow.Filled}, 
  smooth=Smooth.Bezier, 
  __MWorks_Manhattanize=true), Line(origin={-20,0}, 
  rotation=90, 
  points={{-50,0.333333},{50,0.333333}}, 
  color={35,35,35}, 
  thickness=1.3, 
  smooth=Smooth.Bezier, 
  __MWorks_Manhattanize=true), Line(origin={20,0}, 
  rotation=90, 
  points={{-50,0.333333},{50,0.333333}}, 
  color={35,35,35}, 
  thickness=1.3, 
  smooth=Smooth.Bezier, 
  __MWorks_Manhattanize=true), Line(origin={-30,-50}, 
  points={{-50,0.333333},{50,0.333333}}, 
  color={35,35,35}, 
  thickness=1.3, 
  smooth=Smooth.Bezier, 
  __MWorks_Manhattanize=true), Line(origin={30,50}, 
  points={{-50,0.333333},{50,0.333333}}, 
  color={35,35,35}, 
  thickness=1.3, 
  smooth=Smooth.Bezier, 
  __MWorks_Manhattanize=true), Text(origin={1.42109e-14,122}, 
  lineColor={0,0,255}, 
  extent={{-150,20},{150,-20}}, 
  textString="%name", 
  textColor={0,0,255})}),Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">继电器模块的输出在两个指定值之间切换。当继电器开启时，它会保持开启状态，直到输入值降到“关闭点”参数的值以下。当继电器关闭时，它会保持关闭状态，直到输入值超过“开启点”参数的值。该模块接受一个输入并生成一个输出。</span>
</p>
<p>
注意:
</p>
<p>
如果初始输入值介于“关点”和“开点”值之间，初始输出为继电器关闭时的值。
</p>
</html>"));

  equation
    if strict then
      if state < cv + 1e3 * Modelica.Constants.eps then
        state = smooth(0, noEvent(if u > op then ov else state));
      else
        state = smooth(0, noEvent(if u < cp then cv else state));
      end if;

    else
      if state < cv + 1e3 * Modelica.Constants.eps then
        state = smooth(0, if u > op then ov else state);
      else
        state = smooth(0, if u < cp then cv else state);
      end if;

    end if;
    y = state;

  end Relay;
end Nonlinear;