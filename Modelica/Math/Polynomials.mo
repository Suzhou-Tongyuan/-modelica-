within Modelica.Math;
    package Polynomials 
      "多项式运算函数库(包括多项式拟合)"
      extends Modelica.Icons.FunctionsPackage;

      function evaluate "在给定的横坐标值处计算多项式"
        extends Modelica.Icons.Function;
        input Real p[:] 
          "多项式系数(p[1]为最高幂系数)";
        input Real u "横坐标值";
        output Real y "多项式在u处的值";
      algorithm
        y := p[1];
        for j in 2:size(p, 1) loop
          y := p[j] + u*y;
        end for;
        annotation(derivative(zeroDerivative=p)=evaluate_der);
      end evaluate;

      function evaluateWithRange 
        "用定义范围外的线性外推计算给定横坐标值处的多项式"
        extends Modelica.Icons.Function;
        input Real p[:] 
          "多项式系数(p[1]为最高幂系数)";
        input Real uMin "在uMin ..范围内有效的多项式uMax";
        input Real uMax "在uMin ..范围内有效的多项式uMax";
        input Real u "横坐标值";
        output Real y 
          "在uMin,uMax之外，使用线性外推";
      algorithm
        if u < uMin then
          y := evaluate(p, uMin) - evaluate_der(
                  p, 
                  uMin, 
                  uMin - u);
        elseif u > uMax then
          y := evaluate(p, uMax) + evaluate_der(
                  p, 
                  uMax, 
                  u - uMax);
        else
          y := evaluate(p, u);
        end if;
        annotation (derivative(
            zeroDerivative=p, 
            zeroDerivative=uMin, 
            zeroDerivative=uMax) = evaluateWithRange_der);
      end evaluateWithRange;

      function derivative "多项式的导数"
        extends Modelica.Icons.Function;
        input Real p1[:] 
          "多项式系数(p1[1]为最高幂系数)";
        output Real p2[size(p1, 1) - 1] "多项式p1的导数";
      protected
        Integer n=size(p1, 1);
        annotation();
      algorithm
        for j in 1:n-1 loop
          p2[j] := p1[j]*(n - j);
        end for;
      end derivative;

      function derivativeValue 
        "多项式在横坐标u处的导数值"
        extends Modelica.Icons.Function;
        input Real p[:] 
          "多项式系数(p[1]为最高幂系数)";
        input Real u "横坐标值";
        output Real y "多项式在u处的导数值";
      protected
        Integer n=size(p, 1);
      algorithm
        y := p[1]*(n - 1);
        for j in 2:size(p, 1)-1 loop
          y := p[j]*(n - j) + u*y;
        end for;
        annotation(derivative(zeroDerivative=p)=derivativeValue_der);
      end derivativeValue;

      function secondDerivativeValue 
        "多项式的二阶导数在横坐标u处的值"
        extends Modelica.Icons.Function;
        input Real p[:] 
          "多项式系数(p[1]为最高幂系数)";
        input Real u "横坐标值";
        output Real y "多项式在u处二阶导数的值";
      protected
        Integer n=size(p, 1);
        annotation();
      algorithm
        y := p[1]*(n - 1)*(n - 2);
        for j in 2:size(p, 1)-2 loop
          y := p[j]*(n - j)*(n - j - 1) + u*y;
        end for;
      end secondDerivativeValue;

      function integral "多项式p(u)的不定积分"
        extends Modelica.Icons.Function;
        input Real p1[:] 
          "多项式系数(p1[1]为最高幂系数)";
        output Real p2[size(p1, 1) + 1] 
          "多项式p1不定积分的多项式系数(多项式p2 + C为p1不定积分，其中C为任意常数)";
      protected
        Integer n=size(p1, 1) + 1 "输出多项式的次数";
        annotation();
      algorithm
        for j in 1:n-1 loop
          p2[j] := p1[j]/(n-j);
        end for;
        p2[n] := 0.0;
      end integral;

      function integralValue "多项式p(u)从u_low到u_high的积分"
        extends Modelica.Icons.Function;
        input Real p[:] "多项式的系数";
        input Real u_high "高积值";
        input Real u_low=0 "低积分值，默认为0";
        output Real integral=0.0 
          "多项式p从u_low到u_high的积分";
      protected
        Integer n=size(p, 1) "多项式的积分度";
        Real y_low=0 "下被积函数处的值";
      algorithm
        for j in 1:n loop
          integral := u_high*(p[j]/(n - j + 1) + integral);
          y_low := u_low*(p[j]/(n - j + 1) + y_low);
        end for;
        integral := integral - y_low;
        annotation(derivative(zeroDerivative=p)=integralValue_der);
      end integralValue;

      function fitting 
        "在最小二乘意义上计算拟合一组数据点的多项式的系数"
        extends Modelica.Icons.Function;
        input Real u[:] "横坐标数据值";
        input Real y[size(u, 1)] "坐标数据值";
        input Integer n(min=1) 
          "拟合数据点(u,y)的期望多项式的阶数";
        output Real p[n + 1] 
          "多项式的多项式系数符合日期点";
      protected
        Real V[size(u, 1), n + 1] "范德蒙矩阵";
      algorithm
        // 构造Vandermonde矩阵
        V[:, n + 1] := ones(size(u, 1));
        for j in n:-1:1 loop
          V[:, j] := {u[i] * V[i, j + 1] for i in 1:size(u,1)};
        end for;

        // 求解最小二乘问题
        p :=Modelica.Math.Matrices.leastSquares(V, y);
        annotation (Documentation(info="<html>
<p>
多项式。拟合(u,y,n)计算多项式的系数
P (u)次为n，符合数据P (u[i]) - y[i]
在最小二乘的意义上。多项式是
返回为具有以下定义的向量p[n+1]:
</p>
<blockquote><pre>
p(u) = p[1]*u^n + p[2]*u^(n-1) + ... + p[n]*u + p[n+1];
</pre></blockquote>
</html>"      ));
      end fitting;

      function evaluate_der 
        "在给定的横坐标处求多项式的导数"
        extends Modelica.Icons.Function;
        input Real p[:] 
          "多项式系数(p[1]为最高幂系数)";
        input Real u "横坐标值";
        input Real du "横坐标的值";
        output Real dy "多项式在u处的导数值";
      protected
        Integer n=size(p, 1);
        annotation();
      algorithm
        dy := p[1]*(n - 1);
        for j in 2:size(p, 1)-1 loop
          dy := p[j]*(n - j) + u*dy;
        end for;
        dy := dy*du;
      end evaluate_der;

      function evaluateWithRange_der 
        "在给定的横坐标值处计算多项式的导数，并在定义的范围外外推"
        extends Modelica.Icons.Function;
        input Real p[:] 
          "多项式系数(p[1]为最高幂系数)";
        input Real uMin "在uMin ..范围内有效的多项式uMax";
        input Real uMax "在uMin ..范围内有效的多项式uMax";
        input Real u "横坐标值";
        input Real du "横坐标的值";
        output Real dy "多项式在u处的导数值";
        annotation();
      algorithm
        if u < uMin then
          dy := evaluate_der(
                  p, 
                  uMin, 
                  du);
        elseif u > uMax then
          dy := evaluate_der(
                  p, 
                  uMax, 
                  du);
        else
          dy := evaluate_der(
                  p, 
                  u, 
                  du);
        end if;
      end evaluateWithRange_der;

      function integralValue_der 
        "多项式p(u)从u_low到u_high的积分的时间导数，仅假设u_high是时间相关的(莱布尼茨规则)"
        extends Modelica.Icons.Function;
        input Real p[:] "多项式的系数";
        input Real u_high "高积值";
        input Real u_low=0 "低积分值，默认为0";
        input Real du_high "高积值";
        input Real du_low=0 "低积分值，默认为0";
        output Real dintegral=0.0 
          "多项式p从u_low到u_high的积分";
        annotation();
      algorithm
        dintegral := evaluate(p,u_high)*du_high;
      end integralValue_der;

      function derivativeValue_der 
        "多项式导数的时间导数"
        extends Modelica.Icons.Function;
        input Real p[:] 
          "多项式系数(p[1]为最高幂系数)";
        input Real u "横坐标值";
        input Real du "横坐标的值";
        output Real dy 
          "输入变量在u处的多项式w.r.t.的导数的时间导数";
      protected
        Integer n=size(p, 1);
        annotation();
      algorithm
        dy := secondDerivativeValue(p,u)*du;
      end derivativeValue_der;

      encapsulated function roots 
        "在假设最高系数不为零的情况下，计算多项式的零"
        import Modelica.Math.Matrices;
        import Modelica;
        extends Modelica.Icons.Function;
        input Real p[:] 
          "多项式系数向量 p[1]*x^n + p[2]*x^(n-1) + p[n]*x +p[n-1]";
        output Real roots[max(0, size(p, 1) - 1), 2]=fill(
                  0, 
                  max(0, size(p, 1) - 1), 
                  2) 
          "roots[:,1]和roots[:,2]是多项式p根的实部和虚部";
      protected
        Integer np=size(p, 1);
        Integer n=size(p, 1) - 1;
        Real A[max(size(p, 1) - 1, 0), max(size(p, 1) - 1, 0)] "同伴矩阵";
        Real ev[max(size(p, 1) - 1, 0), 2] "特征值";
      algorithm
        if n > 0 then
          assert(abs(p[1]) > 0, 
            "Computing the roots of a polynomial with function \"Modelica.Math.Polynomials.roots\"\n" 
             + 
            "failed because the first element of the coefficient vector is zero, but should not be.");

          // 同伴矩阵
          A[1, :] := -p[2:np]/p[1];
          A[2:n, :] := [identity(n - 1), zeros(n - 1)];

          // 根是伴随矩阵的特征值
          roots := Matrices.Utilities.eigenvaluesHessenberg(A);
        end if;
        annotation (Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >r = Polynomials.roots(p);
</code></pre><p>
<br>
</p>
<h4>描述</h4><p>
这个函数计算多项式P (x)的根
</p>
<p>
<br>
</p>
<pre><code >P = p[1]*x^n + p[2]*x^(n-1) + ... + p[n-1]*x + p[n+1];
</code></pre><p>
<br>
</p>
<p>
与系数向量<strong>p</strong>。假设<strong>p</strong>的第一个元素不为零，即多项式的阶大小为(p,1)-1。
</p>
<p>
为了计算根，对应的伴矩阵<strong>C</strong>的特征值
</p>
<p>
<br>
</p>
<pre><code > |-p[2]/p[1]  -p[3]/p[1]  ...  -p[n-2]/p[1]  -p[n-1]/p[1]  -p[n]/p[1] |
 |    1            0                0               0           0     |
 |    0            1      ...       0               0           0     |
C =    |    .            .      ...       .               .           .     |
 |    .            .      ...       .               .           .     |
 |    0            0      ...       0               1           0     |
</code></pre><p>
<br>
</p>
<p>
计算。这些是多项式的根。<br> 由于伴生矩阵已经是海森堡形式，所以不需要进行向海森堡形式的变换。 Function <a href=\"modelica://Modelica.Math.Matrices.Utilities.eigenvaluesHessenberg\" target=\"\">eigenvaluesHessenberg</a><br> 为这些矩阵提供了有效的特征值计算。
</p>
<h4>示例</h4><p>
<br>
</p>
<pre><code >r = roots({1,2,3});
// r = [-1.0,  1.41421356237309;
//      -1.0, -1.41421356237309]
// which corresponds to the roots: -1.0 +/- j*1.41421356237309
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"));
      end roots;
      annotation (Documentation(info="<html>
<p>
这个包包含了对多项式进行运算的函数，
特别是要确定导数和积分
用一个多项式来拟合一个给定的集合
数据点。
</p>

<p>
Copyright &copy; 2004-2020, Modelica Association and contributors
</p>
</html>",     revisions="<html>
<ul>
<li><em>Oct. 22, 2004</em> by Martin Otter (DLR):<br>
       重命名函数以不包含缩写。<br>
基于LAPACK拟合<br>
       返回不定积分多项式的新函数</li>
<li><em>Sept. 3, 2004</em> by Jonas Eborn (Scynamics):<br>
       Polyderval, polyintval补充道</li>
<li><em>March 1, 2004</em> by Martin Otter (DLR):<br>
       实现的第一个版本</li>
</ul>
</html>"));
    end Polynomials;