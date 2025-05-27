within Modelica.Math;
package Nonlinear "非线性方程运算函数库"
  extends Modelica.Icons.Package;
  package Examples 
    "示例演示了非线性包中函数的用法"
    extends Modelica.Icons.ExamplesPackage;

    function quadratureLobatto1 "对固定的输入进行积分"
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Streams.print;

      input Real tolerance = 1e-5 "整数值的误差容忍度";
    protected
      Real I_numerical[3] "数值整数值";
      Real I_analytical[size(I_numerical, 1)] "解析积分值";
      Real I_err[size(I_numerical, 1)] 
        "数值和解析积分值之间的绝对误差";

    algorithm
      I_numerical[1] := Modelica.Math.Nonlinear.quadratureLobatto(
        function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun4(), 
        0, 
        1, 
        tolerance);
      I_analytical[1] := -cos(1) + cos(0);

      I_numerical[2] := Modelica.Math.Nonlinear.quadratureLobatto(
        function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun5(w = 5), 
        0, 
        13, 
        tolerance);
      I_analytical[2] := -cos(5 * 13) / 5 + cos(5 * 0) / 5;

      I_numerical[3] := Modelica.Math.Nonlinear.quadratureLobatto(
        function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun6(k = 1 / 
        sqrt(2)), 
        0, 
        Modelica.Constants.pi / 2, 
        tolerance);
      I_analytical[3] := 1.8540746773013719184338503;

      I_err := abs(I_numerical - I_analytical);

      print("\n... Results of Modelica.Math.Nonlinear.Examples.quadratureLobatto1:");
      print("Function 1 ( integral(sin(x)*dx) from x=0 to x=1): ");
      print("Analytical integral value = " + String(I_analytical[1], format = 
        "2.16f"));
      print("Numerical integral value  = " + String(I_numerical[1], format = 
        "2.16f"));
      print("Absolute difference       = " + String(I_err[1], format = "2.0e"));

      print("");
      print("Function 2 (integral(sin(5*x)*dx) from x=0 to x=13): ");
      print("Analytical integral value = " + String(I_analytical[2], format = 
        "2.16f"));
      print("Numerical integral value  = " + String(I_numerical[2], format = 
        "2.16f"));
      print("Absolute difference       = " + String(I_err[2], format = "2.0e"));

      print("");
      print("Function 3 (Elliptic integral from x=0 to pi/2): ");
      print("Analytical integral value = " + String(I_analytical[3], format = 
        "2.16f"));
      print("Numerical integral value  = " + String(I_numerical[3], format = 
        "2.16f"));
      print("Absolute difference       = " + String(I_err[3], format = "2.0e"));

      annotation(Documentation(info = "<html>
<p>
这个示例使用函数
<a href=\"modelica://Modelica.Math.Nonlinear.quadratureLobatto\">quadratureLobatto</a>
对以下被积函数进行积分，并将结果与解析解进行比较。示例还展示了如何将额外的输入参数传递给被积函数。计算的积分如下：
</p>

<ul>
<li> (sin(x)*dx) 从x = 0到x = 1的积分</li>
<li> (sin(5*x)*dx) 从x = 0到x = 13的积分</li>
<li> 从x = 0到pi/2的椭圆积分</li>
</ul>

</html>"    ) );
    end quadratureLobatto1;

    function quadratureLobatto2 "对与用户相关的输入积分"
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Streams.print;

      input Real Tolerance=1e-5 "整数值误差容限" 
        annotation (Dialog(group="General"));
      input Real a1=0 "下限" annotation (Dialog(group="Sine"));
      input Real b1=1 "上限" annotation (Dialog(group="Sine"));

      input Real a2=0 "下限" annotation (Dialog(group="Sine w"));
      input Real b2=13 "上限" annotation (Dialog(group="Sine w"));
      input Real w=5 "角速度" annotation (Dialog(group="Sine w"));

      input Real a3=0 "下限" 
        annotation (Dialog(group="Elliptic integral"));
      input Real b3=Modelica.Constants.pi/2 "上限" 
        annotation (Dialog(group="Elliptic integral"));
      input Real k=1/sqrt(2) "插件" 
        annotation (Dialog(group="Elliptic integral"));

    protected
      Real I[3] "数值整数值";

    algorithm
      I[1] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun4(), 
          a1, 
          b1, 
          Tolerance);

      I[2] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun5(w=w), 
          a2, 
          b2, 
          Tolerance);

      I[3] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun6(k=k), 
          a3, 
          b3, 
          Tolerance);

      print("\n... Results of Modelica.Math.Nonlinear.Examples.quadratureLobatto2:");
      print("Function 1 (integral(sin(x)*dx)): ");
      print("Numerical integral value  = " + String(I[1], format="2.16f"));

      print("");
      print("Function 2 (integral(sin(w*x)*dx)): ");
      print("Numerical integral value  = " + String(I[2], format="2.16f"));

      print("");
      print("Function 3 (Elliptic integral): ");
      print("Numerical integral value  = " + String(I[3], format="2.16f"));

      annotation (Documentation(info="<html>
<p>
这个例子用函数解决了以下被积函数
<a href=\"modelica://Modelica.Math.Nonlinear.quadratureLobatto\">quadratureLobatto</a>。
用户可以设置参数，如“w”或“k”，并可以进行实验
不同的积分间隔。
计算如下积分:
</p>

<ul>
<li> integral(sin(x)*dx)</li>
<li> integral(sin(w*x)*dx)</li>
<li> elliptic integral</li>
</ul>

</html>"          ));
    end quadratureLobatto2;

    function solveNonlinearEquations1 
      "求解具有固定输入的非线性方程"
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Streams.print;

      input Real tolerance=100*Modelica.Constants.eps 
        "溶液的相对容忍度";

    protected
      Real u_numerical[3];
      Real u_analytical[3];
      Real u_err[3];

    algorithm
      u_numerical[1] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun1(), 
          -0.5, 
          10, 
          tolerance);
      u_analytical[1] := 1.0;

      u_numerical[2] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun2(w=3), 
          0, 
          5, 
          tolerance);
      u_analytical[2] := 0.6448544035840080891877538;

      u_numerical[3] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun3(p={5,1}, 
          m=1), 
          1, 
          8, 
          tolerance);
      u_analytical[3] := 6.9368474072202187221643182;

      u_err := abs(u_numerical - u_analytical);

      print("\n... Results of Modelica.Math.Nonlinear.Examples.solveNonlinearEquations1:");
      print("Solve 3 nonlinear equations with relative tolerance = " + String(tolerance) +"\n");
      print("Function 1 (u^2 - 1 = 0): ");
      print("Analytical zero     = " + String(u_analytical[1], format="2.16f"));
      print("Numerical zero      = " + String(u_numerical[1], format="2.16f"));
      print("Absolute difference = " + String(u_err[1], format="2.0e"));

      print("");
      print("Function 2 (3*u - sin(3*u) - 1 = 0): ");
      print("Analytical zero     = " + String(u_analytical[2], format="2.16f"));
      print("Numerical zero      = " + String(u_numerical[2], format="2.16f"));
      print("Absolute difference = " + String(u_err[2], format="2.0e"));

      print("");
      print("Function 3 (5 + log(u) - u = 0): ");
      print("Analytical zero     = " + String(u_analytical[3], format="2.16f"));
      print("Numerical zero      = " + String(u_numerical[3], format="2.16f"));
      print("Absolute difference = " + String(u_err[3], format="2.0e"));

      annotation (Documentation(info="<html>
<p>
这个例子用函数求解了下面的非线性方程
<a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">solveOneNonlinearEquation</a>
并与现有的解析解进行了比较。
示例还演示了如何对非线性方程进行额外的输入参数
函数可以作为附加参数传递。
求解如下非线性方程:
</p>

<ul>
<li> 0 = u^2 - 1</li>
<li> 0 = 3*u - sin(3*u) - 1</li>
<li> 0 = 5 + log(u) - u</li>
</ul>

</html>"      ));
    end solveNonlinearEquations1;

    function solveNonlinearEquations2 
      "求解具有用户依赖输入的非线性方程"
      extends Modelica.Icons.Function;
      import Modelica.Utilities.Streams.print;

      input Real tolerance=100*Modelica.Constants.eps 
        "溶液的相对容忍度" 
        annotation (Dialog(group="General"));
      input Real u_min1=-0.5 "下限" annotation (Dialog(group="u^2-1"));
      input Real u_max1=10 "上限" annotation (Dialog(group="u^2-1"));
      input Real u_min2=0 "下限" 
        annotation (Dialog(group="3*u - sin(w*u) - 1"));
      input Real u_max2=5 "上限" 
        annotation (Dialog(group="3*u - sin(w*u) - 1"));
      input Real w=3 "角速度" 
        annotation (Dialog(group="3*u - sin(w*u) - 1"));
      input Real u_min3=1 "下限" 
        annotation (Dialog(group="p[1] + log(p[2]*u) - m*u"));
      input Real u_max3=8 "上限" 
        annotation (Dialog(group="p[1] + log(p[2]*u) - m*u"));
      input Real p[2]={5,1} "参数向量" 
        annotation (Dialog(group="p[1] + log(p[2]*u) - m*u"));
      input Real m=1 "参数" 
        annotation (Dialog(group="p[1] + log(p[2]*u) - m*u"));

    protected
      Real u[3];

    algorithm
      u[1] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun1(), 
          u_min1, 
          u_max1, 
          tolerance);

      u[2] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun2(w=w), 
          u_min2, 
          u_max2, 
          tolerance);

      u[3] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun3(p=p, m= 
          m), 
          u_min3, 
          u_max3, 
          tolerance);

      print("\n... Results of Modelica.Math.Nonlinear.Examples.solveNonlinearEquations2:");
      print("Solve 3 nonlinear equations with relative tolerance = " + String(tolerance) +"\n");

      print("Function 1 (u^2 - 1): ");
      print("Numerical zero = " + String(u[1], format="2.16f"));

      print("");
      print("Function 2 (3*u - sin(w*u) - 1): ");
      print("Numerical zero = " + String(u[2], format="2.16f"));

      print("");
      print("Function 3 (p[1] + log(p[2]*u) - m*u): ");
      print("Numerical zero = " + String(u[3], format="2.16f"));

      annotation (Documentation(info="<html>
<p>
这个例子用函数求解了下面的非线性方程
<a href=\"modelica://Modelica.Math.Nonlinear.solveOneNonlinearEquation\">solveOneNonlinearEquation</a>。
用户可以设置参数，如\"w\"或\"m\"，并可以进行实验
不同的启动间隔。
求解如下非线性方程:
</p>

<ul>
<li> 0 = u^2 - 1</li>
<li> 0 = 3*u - sin(w*u) - 1</li>
<li> 0 = p[1] + log(p[2]*u) - m*u</li>
</ul>

</html>"          ));
    end solveNonlinearEquations2;

    model QuadratureLobatto3 "在模型中集成功能"
      extends Modelica.Icons.Example;
      parameter Real A=1 "被积函数s的振幅";
      parameter Real ws=2 "被积函数s的角频率";
      parameter Real wq=3 "q的角频率的平方";
      Real q(start=1, fixed=true) "一阶状态变量";
      Real qd(start=0, fixed=true) "二阶状态变量";
      Real x "作为s和q的乘积的总体值";
      final parameter Real s = Modelica.Math.Nonlinear.quadratureLobatto(
                                  function UtilityFunctions.fun7(A=A, w=ws), 
                                  0,1) "Time-invariant integral value";
    equation
      qd = der(q);
      der(qd) + wq*q = 0 "自由无阻尼谐振子的运动方程";
      x = s*q;
      annotation (Documentation(info="<html><p>
从技术上讲，这个例子演示了如何利用函数作为输入参数 到模型中的函数。
</p>
<p>
从建模的角度来看，该示例以非常简化的方式演示了使用Ritz方法对分布式系统建模的基本方法。 质点的位移场<code>u(c,t)</code>(其中<code>c</code>为未变形的位置，<code>t</code>为时间)用与空间相关的模态振型<code>Φ(c)</code>和与时间相关的模态幅值<code>q(t)</code>表示，即<code>u</code> = <code>Φ(c)*q(t)</code>。当将这种分解插入到运动方程中，然后对所有粒子进行积分时，出现了诸如<code>∫(Φ(c) dc)*q(t)</code>之类的项，其中定常积分项可以事先用<a href=\"modelica://Modelica.Math.Nonlinear. quadratureLobatto\" target=\"\">Lobatto method</a>。用这种方法将偏微分方程转化为常微分方程组。
</p>
</html>"), 
        experiment(StopTime=5));
    end QuadratureLobatto3;

    package UtilityFunctions 
      "用作示例的函数参数的实用函数"
      extends Modelica.Icons.UtilitiesPackage;

      function fun1 "y = u^2 - 1"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        annotation();
      algorithm
        y := u^2 - 1;
      end fun1;

      function fun2 "y = 3*u - sin(w*u) - 1"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input Real w "角速度";
        annotation();
      algorithm
        y := 3*u - sin(w*u) - 1;
      end fun2;

      function fun3 "y = p[1] + log(p[2]*u) - m*u"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input Real p[2];
        input Real m;
        annotation();
      algorithm
        y := p[1] + log(p[2]*u) - m*u;
      end fun3;

      function fun4 "y = sin(u)"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        annotation();
      algorithm
        y := sin(u);
      end fun4;

      function fun5 "y = sin(w*u)"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input Real w "角速度";
        annotation();
      algorithm
        y := sin(w*u);
      end fun5;

      function fun6 "y = sqrt(1/(1 - k^2*sin(u)^2))"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input Real k "插件";
        annotation();
      algorithm
        y := sqrt(1/(1 - k^2*sin(u)^2));
      end fun6;

      function fun7 "y = A*sin(w*u)"
        extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
        input Real A "振幅";
        input Real w "角频率";
        annotation();
      algorithm
        y := A*sin(w*u);
      end fun7;
      annotation (Documentation(info="<html>
<p>
这个包提供了用作输入的实用程序函数
示例函数的参数。
</p>

</html>"      ));
    end UtilityFunctions;
    annotation();
  end Examples;

  package Interfaces "函数接口"
    extends Modelica.Icons.InterfacesPackage;
    encapsulated partial function partialScalarFunction 
      "一个函数接口，一个输入和一个输出实数信号"
      import Modelica;
      extends Modelica.Icons.Function;
      input Real u "独立变量";
      output Real y "因变量y=f(u)";
      annotation(Documentation(info = "<html>
<p>
这个部分函数定义了一个具有一个输入和一个输出实数信号的函数接口。
<a href=\"modelica://Modelica.Math.Nonlinear\">Modelica.Math.Nonlinear</a>
的标量函数通过继承这个基类型来派生。
这允许将这些函数直接作为函数的参数使用，例如，参见<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Math.Nonlinear.Examples</a>。
</p>

</html>"    ));
    end partialScalarFunction;
    annotation (Documentation(info="<html>
<p>
函数的接口定义。主要目的是使用函数
从这些接口定义派生为函数参数
对于一个函数，参见，例如，
<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Math.Nonlinear.Examples</a>.
</p>
</html>"  ));
  end Interfaces;

  function quadratureLobatto 
    "使用自适应Lobatto规则返回被积函数的积分"
    extends Modelica.Icons.Function;
    input Modelica.Math.Nonlinear.Interfaces.partialScalarFunction f 
      "被积函数的函数";
    input Real a "积分区间的下限";
    input Real b "积分区间的上限";
    input Real tolerance = 100 * Modelica.Constants.eps 
      "整数值的相对容差";
    output Real integral "积分值";

  protected
    constant Real x1 = 0.942882415695480;
    constant Real x2 = 0.641853342345781;
    constant Real x3 = 0.236383199662150;
    constant Real eps = 10 * Modelica.Constants.eps;
    Real m;
    Real h;
    Real alpha;
    Real beta;
    Real x[13];
    Real y[13];
    Real fa;
    Real fb;
    Real i1;
    Real i2;
    Real is;
    Real erri1;
    Real erri2;
    Real R;
    Real tol;
    Integer s;

    function quadStep "用递归函数求积分"
      input Modelica.Math.Nonlinear.Interfaces.partialScalarFunction f;
      input Real a "右间隔结束";
      input Real b "左间隔结束";
      input Real fa "a处的函数值";
      input Real fb "b处的函数值";
      input Real is "积分的第一个近似";
      output Real I "积分值";
    protected
      Real m;
      Real h;
      Real alpha;
      Real beta;
      Real x[5];
      Real y[5];
      Real mll;
      Real ml;
      Real mr;
      Real mrr;
      Real fmll;
      Real fml;
      Real fm;
      Real fmr;
      Real fmrr;
      Real i1;
      Real i2;
      annotation();
    algorithm
      h := (b - a) / 2;
      m := (a + b) / 2;
      alpha := sqrt(2 / 3);
      beta := 1 / sqrt(5);
      mll := m - alpha * h;
      ml := m - beta * h;
      mr := m + beta * h;
      mrr := m + alpha * h;
      x := {mll, ml, m, mr, mrr};
      for i in 1:size(x, 1) loop
        y[i] := f(x[i]);
      end for;
      fmll := y[1];
      fml := y[2];
      fm := y[3];
      fmr := y[4];
      fmrr := y[5];
      i2 := (h / 6) * (fa + fb + 5 * (fml + fmr));
      i1 := (h / 1470) * (77 * (fa + fb) + 432 * (fmll + fmrr) + 625 * (fml + fmr) + 
        672 * fm);

      if (is + (i1 - i2) == is) or (mll <= a) or (b <= mrr) then
        I := i1;

      else
        I := quadStep(f, a, mll, fa, fmll, is) + 
          quadStep(f, mll, ml, fmll, fml, is) + 
          quadStep(f, ml, m, fml, fm, is) + 
          quadStep(f, m, mr, fm, fmr, is) + 
          quadStep(f, mr, mrr, fmr, fmrr, is) + 
          quadStep(f, mrr, b, fmrr, fb, is);
      end if;
    end quadStep;

  algorithm
    /*
    采用自适应方法对积分进行数值计算
    Lobatto规则。
    见 Walter Gander: Adaptive Quadrature - Revisited, 1998
    ftp.inf.ethz.ch in pub/publications/tech-reports/3xx/306.ps
    
    x[:] 是节点
    y[:] = f(x[:]) 是函数值在节点上
    */
    tol := tolerance;
    m := (a + b) / 2;
    h := (b - a) / 2;
    alpha := sqrt(2 / 3);
    beta := 1 / sqrt(5);
    x := {a, 
      m - x1 * h, 
      m - alpha * h, 
      m - x2 * h, 
      m - beta * h, 
      m - x3 * h, 
      m, 
      m + x3 * h, 
      m + beta * h, 
      m + x2 * h, 
      m + alpha * h, 
      m + x1 * h, 
      b};
    for i in 1:size(x, 1) loop
      y[i] := f(x[i]);
    end for;
    fa := y[1];
    fb := y[13];
    i2 := (h / 6) * (y[1] + y[13] + 5 * (y[5] + y[9]));
    i1 := (h / 1470) * (77 * (y[1] + y[13]) + 432 * (y[3] + y[11]) + 625 * (y[5] + y[9]) 
      + 672 * y[7]);
    is := h * (0.0158271919734802 * (y[1] + y[13]) + 0.0942738402188500 * (y[2] + y[
      12]) + 0.155071987336585 * (y[3] + y[11]) + 0.188821573960182 * (y[4] + y[10]) 
      + 0.199773405226859 * (y[5] + y[9]) + 0.224926465333340 * (y[6] + y[8]) + 0.242611071901408 
      * y[7]);
    s := sign(is);
    if (s == 0) then
      s := 1;
    end if;
    erri1 := abs(i1 - is);
    erri2 := abs(i2 - is);
    R := 1;
    if (erri2 <> 0) then
      R := erri1 / erri2;
    end if;
    if (R > 0 and R < 1) then
      tol := tol / R;
    end if;
    is := s * abs(is) * tol / eps;
    if (is == 0) then
      is := b - a;
    end if;
    integral := quadStep(
      f, 
      a, 
      b, 
      fa, 
      fb, 
      is);

    annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
<strong>quadratureLobatto</strong>(function f(), a, b);
<strong>quadratureLobatto</strong>(function f(), a, b, tolerance=100*Modelica.Constants.eps);
</pre></blockquote>

<h4>描述</h4>

<p>
计算函数f(u，…)从u=a到u=b的定积分
根据自适应Lobatto规则:
</p>

<blockquote>
<dl>
<dt>Walter Gander:</dt>
<dd> <strong>Adaptive Quadrature - Revisited</strong>. 1998.
   <a href=\"ftp://ftp.inf.ethz.ch/pub/publications/tech-reports/3xx/306.ps\">ftp://ftp.inf.ethz.ch/pub/publications/tech-reports/3xx/306.ps</a>
   </dd>
</dl>
</blockquote>

<h4>示例</h4>

<p>
参见<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Modelica.Math.Nonlinear.Examples</a>.
</p>

</html>"  ));
  end quadratureLobatto;

  function solveOneNonlinearEquation 
    "以一种非常可靠和有效的方法求解f(u) = 0 (f(u_min)和f(u_max)必须有不同的符号)"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams.error;

    input Modelica.Math.Nonlinear.Interfaces.partialScalarFunction f 
      "函数y = f(u);U的计算使y=0";
    input Real u_min "搜索区间的下界";
    input Real u_max "搜索区间的上界";
    input Real tolerance=100*Modelica.Constants.eps 
      "溶液的相对容忍度";
    output Real u "自变量u的值，使f(u) = 0";

  protected
    constant Real eps=Modelica.Constants.eps "机器ε";
    Real a=u_min "当前最佳最小间隔值";
    Real b=u_max "当前最佳最大间隔值";
    Real c "中间点 a <= c <= b";
    Real d;
    Real e "b - a";
    Real m;
    Real s;
    Real p;
    Real q;
    Real r;
    Real tol;
    Real fa "= f(a)";
    Real fb "= f(b)";
    Real fc;
    Boolean found=false;
  algorithm
    // 检查 f(u_min) 和 f(u_max) 的符号是否不同
    fa := f(u_min);
    fb := f(u_max);
    fc := fb;
    if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
      error(
        "The arguments u_min and u_max provided in the function call\n"+ 
        "    solveOneNonlinearEquation(f,u_min,u_max)\n" + 
        "do not bracket the root of the single non-linear equation 0=f(u):\n" + 
        "  u_min  = " + String(u_min) + "\n" + "  u_max  = " + String(u_max) 
         + "\n" + "  fa = f(u_min) = " + String(fa) + "\n" + 
        "  fb = f(u_max) = " + String(fb) + "\n" + 
        "fa and fb must have opposite sign which is not the case");
    end if;

    // 初始化变量
    c := a;
    fc := fa;
    e := b - a;
    d := e;

    // 搜索回路
    while not found loop
      if abs(fc) < abs(fb) then
        a := b;
        b := c;
        c := a;
        fa := fb;
        fb := fc;
        fc := fa;
      end if;

      tol := 2*eps*abs(b) + tolerance;
      m := (c - b)/2;

      if abs(m) <= tol or fb == 0.0 then
        // 找到根（间隔足够小）
        found := true;
        u := b;
      else
        // 确定是否需要分段
        if abs(e) < tol or abs(fa) <= abs(fb) then
          e := m;
          d := e;
        else
          s := fb/fa;
          if a == c then
            // 线性插值
            p := 2*m*s;
            q := 1 - s;
          else
            // 反二次插值
            q := fa/fc;
            r := fb/fc;
            p := s*(2*m*q*(q - r) - (b - a)*(r - 1));
            q := (q - 1)*(r - 1)*(s - 1);
          end if;

          if p > 0 then
            q := -q;
          else
            p := -p;
          end if;

          s := e;
          e := d;
          if 2*p < 3*m*q - abs(tol*q) and p < abs(0.5*s*q) then
            // 插补成功
            d := p/q;
          else
            // 使用双节
            e := m;
            d := e;
          end if;
        end if;

        // 最佳猜测值定义为 "a"
        a := b;
        fa := fb;
        b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
        fb := f(b);

        if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
          // 初始化变量
          c := a;
          fc := fa;
          e := b - a;
          d := e;
        end if;
      end if;
    end while;

    annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
<strong>solveOneNonlinearEquation</strong>(function f(), u_min, u_max);
<strong>solveOneNonlinearEquation</strong>(function f(), u_min, u_max, tolerance=100*Modelica.Constants.eps);
</pre></blockquote>

<h4>描述</h4>

<p>
这个函数决定了<strong>一个非线性代数方程</strong> \"y=f(u)\"
in <strong>一个未知的</strong> \"u\"在一个可靠的方式。这是最好的数字之一
用于此目的的算法。作为输入，非线性函数f(u)
必须给出区间u_min和u_max
包含解，即\"f(u_min)\"和 \"f(u_max)\" 必须
有一个不同的标志。该函数计算一个较小的间隔
其中使用相对容差表示符号变化
“公差”可以作为第四个输入参数。
</p>

<p>
执行间隔缩减
逆二次插值(用二次多项式插值)
通过最后3个点和计算零)。如果失败了，
使用二分法，它总是将间隔缩短2倍。
逆二次插值法具有超线性收敛性。
这与全局收敛牛顿算法的收敛速率大致相同
方法，但不需要计算非线性的导数
函数。求解函数是Algol 60程序的直接映射
\"zero\" 到Modelica，从:
</p>

<blockquote>
<dl>
<dt> Brent R.P.:</dt>
<dd> <strong>Algorithms for Minimization without derivatives</strong>.
   Prentice Hall, 1973, pp. 58-59.<br>
   Download: <a href=\"https://maths-people.anu.edu.au/~brent/pd/rpb011i.pdf\">https://maths-people.anu.edu.au/~brent/pd/rpb011i.pdf</a><br>
   Errata and new print: <a href=\"https://maths-people.anu.edu.au/~brent/pub/pub011.html\">https://maths-people.anu.edu.au/~brent/pub/pub011.html</a>
</dd>
</dl>
</blockquote>

<h4>示例</h4>

<p>
参见 <a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Modelica.Math.Nonlinear.Examples</a>.
</p>
</html>"    ));
  end solveOneNonlinearEquation;

  annotation (Documentation(info="<html>
<p>
这个包包含执行诸如数值积分等任务的函数
一个函数，或解一个非线性代数方程组。
这个包中函数的共同特征是
非线性特性以用户可定义的方式传递
功能。
</p>

<p>
有关如何定义和使用函数作为输入参数的详细信息
有关函数，请参见
<a href=\"modelica://ModelicaReference.Classes.'function'\">ModelicaReference.Classes.'function'</a>
或<a href=\"https://specification.modelica.org/v3.4/Ch12.html#functional-input-arguments-to-functions\">Section 12.4.2
(Functional Input Arguments to Functions) of the Modelica 3.4 specification</a>的(函数输入参数).
</p>

</html>", revisions="<html>
<ul>
<li><em>July 2010 </em> by Martin Otter (DLR-RM):<br>
    包含在MSL 3.2中，经过改编，并改进了文档</li>

<li><em>March 2010 </em> by Andreas Pfeiffer (DLR-RM):<br>
    从Gerhard Schillhuber和
一个非线性方程在一个未知数中的解
Modelica.Media.Common.OneNonLinearEquation
使用函数对象。</li>

<li><em>June 2002 </em> by Gerhard Schillhuber (master thesis at DLR-RM):<br>
       自适应正交计算样条的曲线长度.</li>
</ul>
</html>"), Icon(graphics={Polygon(points={{-44,-52},{-44,-26},{-17.1, 
              44.4},{-11.4,52.6},{-5.8,57.1},{-0.2,57.8},{5.4,54.6},{11.1,47.7}, 
              {16.7,37.4},{23.1,22.1},{31.17,-0.8},{48,-52},{-44,-52}}, 
          lineColor={135,135,135}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid)}));
end Nonlinear;