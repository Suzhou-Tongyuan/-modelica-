within Modelica.Fluid;
package Utilities 
  "用于构建流体组件的公用模型(不得直接使用)"
  extends Modelica.Icons.UtilitiesPackage;

  function checkBoundary "检查边界定义是否正确"
    extends Modelica.Icons.Function;
    input String mediumName;
    input String substanceNames[:] "物质名称";
    input Boolean singleState;
    input Boolean define_p;
    input Real X_boundary[:];
    input String modelName = "??? 边界 ???";
  protected
    Integer nX = size(X_boundary,1);
    String X_str;
    annotation();
  algorithm
    assert(not singleState or singleState and define_p, "
模型中参数 define_p 的值有误（= false） \""   + modelName + "\":
所选介质 \""   + mediumName + "\" 的 Medium.singleState=true。
因此，无法定义边界密度，需要 define_p = true。
"  );

    for i in 1:nX loop
      assert(X_boundary[i] >= 0.0, "
介质中的边界质量分数错误 \"" 
  + mediumName + "\" 模型中 \"" + modelName + "\":
边界值 X_boundary(" 
                              + String(i) + ") = " + String(
        X_boundary[i]) + "
是负的，必须是正的。
"  );
    end for;

    if nX > 0 and abs(sum(X_boundary) - 1.0) > 1e-10 then
       X_str :="";
       for i in 1:nX loop
          X_str :=X_str + "   X_boundary[" + String(i) + "] = " + String(X_boundary[
          i]) + " \"" + substanceNames[i] + "\"\n";
       end for;
       Modelica.Utilities.Streams.error(
          "介质中的边界质量分数 \"" + mediumName + "\" 模型中 \"" + modelName + "\"\n" + 
          "的总和不等于 1，相反，sum(X_boundary) = " + String(sum(X_boundary)) + ":\n" 
          + X_str);
    end if;
  end checkBoundary;

  function regRoot 
    "具有原点处导数有限的反对称平方根近似"
    extends Modelica.Icons.Function;
    input Real x;
    input Real delta=0.01 
      "sqrt(abs(x))*sgn(x) 的显著偏差范围";
    output Real y;
  algorithm
    y := x/(x*x+delta*delta)^0.25;
    annotation(derivative(zeroDerivative=delta)=regRoot_der, 
      Documentation(info="<html><p>
 &nbsp;该函数近似于 sqrt(abs(x))*sgn(x)，使得在 x=0 处的导数为有限且平滑。
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">函数</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">近似值</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">范围</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y = regRoot(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y ~= sqrt(abs(x))*sgn(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">abs(x) &gt;&gt;delta</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y = regRoot(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y ~= x/sqrt(delta)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">abs(x) &lt;&lt; delta</td></tr></tbody></table><p>
 &nbsp; &nbsp;当默认值 delta=0.01 时，sqrt(x) 和与regRoot(x) 的差异在 x=0.01 附近约为 16%，在 x=0.1 附近约为 0.25%，在 x=1 附近约为 0.0025%。
</p>
<p>
<br>
</p>
</html>"  ,revisions="<html>
<ul>
<li><em>15 Mar 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
   建立</li>
</ul>
</html>"  ));
  end regRoot;

  function regRoot_der "regRoot 的导数"
    extends Modelica.Icons.Function;
    input Real x;
    input Real delta=0.01 "sqrt(x) 的显著偏差范围";
    input Real dx "x 的导数";
    output Real dy;
  algorithm
    dy := dx*0.5*(x*x+2*delta*delta)/((x*x+delta*delta)^1.25);

  annotation (Documentation(info="<html>
</html>"  , 
        revisions="<html>
<ul>
<li><em>15 Mar 2005</em>
  by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
     建立</li>
</ul>
</html>"  ));
  end regRoot_der;

  function regSquare 
    "具有原点处导数非零的反对称平方近似"
    extends Modelica.Icons.Function;
    input Real x;
    input Real delta=0.01 "x^2*sgn(x) 的显著偏差范围";
    output Real y;
  algorithm
    y := x*sqrt(x*x+delta*delta);

    annotation(Documentation(info="<html><p>
 &nbsp; &nbsp; 该函数近似 于x^2*sgn(x)，使得在 x=0 处的导数非零。
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">函数</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">近似值</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">范围</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y = regSquare(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y ~= x^2*sgn(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">abs(x) &gt;&gt;delta</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y = regSquare(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y ~= x*delta</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">abs(x) &lt;&lt; delta</td></tr></tbody></table><p>
 &nbsp; &nbsp; &nbsp;在默认值 delta=0.01 时，x^2 和 regSquare(x) 的差异在 x=0.01 附近约为 41%，在 x=0.1 附近约为 0.4%，在 x=1 附近约为 0.005%。
</p>
<p>
<br>
</p>
</html>",revisions="<html>
<ul>
<li><em>15 Mar 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
   建立</li>
</ul>
</html>"));
  end regSquare;

  function regPow 
    "具有原点处导数非零的反对称幂近似"
    extends Modelica.Icons.Function;
    input Real x;
    input Real a;
    input Real delta=0.01 "x^a*sgn(x) 的显著偏差范围";
    output Real y;
  algorithm
    y := x*(x*x+delta*delta)^((a-1)/2);

    annotation(Documentation(info="<html><p>
 &nbsp; &nbsp; 该函数近似于 abs(x)^a*sign(x)，使得在 x=0 处的导数为正、有限且光滑。
</p>
<table style=\"width: 100%;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">函数</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">近似值</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">范围</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y = regPow(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y ~= abs(x)^a*sgn(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">abs(x) &gt;&gt;delta</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y = regPow(x)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">y ~= x*delta^(a-1)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">abs(x) &lt;&lt; delta</td></tr></tbody></table><p>
<br>
</p>
</html>",revisions="<html>
<ul>
<li><em>15 Mar 2005</em>
by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
   建立</li>
</ul>
</html>"));
  end regPow;

  function regRoot2 
    "带不连续因子的反对称近似平方根，使一阶导数有限且连续"

    extends Modelica.Icons.Function;
    input Real x "横坐标值";
    input Real x_small(min=0)=0.01 "|x| <= x_small 时的函数近似值";
    input Real k1(min=0)=1 "y = if x>=0 then sqrt(k1*x) else -sqrt(k2*|x|)";
    input Real k2(min=0)=1 "y = if x>=0 then sqrt(k1*x) else -sqrt(k2*|x|)";
    input Boolean use_yd0 = false "true：使用 yd0";
    input Real yd0(min=0)=1 "x=0 时的预期导数： dy/dx = yd0";
    output Real y "纵坐标值";
  protected
    Real sqrt_k1 = if k1 > 0 then sqrt(k1) else 0;
    Real sqrt_k2 = if k2 > 0 then sqrt(k2) else 0;
  public
    encapsulated function regRoot2_utility 
      "使用两个三阶多项式进行插值，并在 x=0 处预设导数值"
      import Modelica;
      extends Modelica.Icons.Function;
      import Modelica.Fluid.Utilities.evaluatePoly3_derivativeAtZero;
      input Real x;
      input Real x1 "函数 abs(x) < x1 的近似值";
      input Real k1 "y = if x>=0 then sqrt(k1*x) else -sqrt(k2*|x|); k1 >= k2";
      input Real k2 "y = if x>=0 then sqrt(k1*x) else -sqrt(k2*|x|))";
      input Boolean use_yd0 "true: 使用 yd0";
      input Real yd0(min=0) "x=0 时的预期导数： dy/dx = yd0";
      output Real y;
    protected
       Real x2;
       Real xsqrt1;
       Real xsqrt2;
       Real y1;
       Real y2;
       Real y1d;
       Real y2d;
       Real w;
       Real y0d;
       Real w1;
       Real w2;
       Real sqrt_k1 = if k1 > 0 then sqrt(k1) else 0;
       Real sqrt_k2 = if k2 > 0 then sqrt(k2) else 0;
    algorithm
       if k2 > 0 then
          // 因为要求 k1 >= k2，所以 k2 > 0 意味着 k1 > 0
          x2 :=-x1*(k2/k1);
       elseif k1 > 0 then
          x2 := -x1;
       else
          y := 0;
          return;
       end if;

       if x <= x2 then
          y := -sqrt_k2*sqrt(abs(x));
       else
          y1 :=sqrt_k1*sqrt(x1);
          y2 :=-sqrt_k2*sqrt(abs(x2));
          y1d :=sqrt_k1/sqrt(x1)/2;
          y2d :=sqrt_k2/sqrt(abs(x2))/2;

          if use_yd0 then
             y0d :=yd0;
          else
             /* 求导数，使左右多项式在 x=0 时的一阶导数和二阶导数相同：
           _
           基本方程：
              y_right = a1*(x/x1) + a2*(x/x1)^2 + a3*(x/x1)^3
              y_left  = b1*(x/x2) + b2*(x/x2)^2 + b3*(x/x2)^3
              yd_right*x1 = a1 + 2*a2*(x/x1) + 3*a3*(x/x1)^2
              yd_left *x2 = b1 + 2*b2*(x/x2) + 3*b3*(x/x2)^2
              ydd_right*x1^2 = 2*a2 + 6*a3*(x/x1)
              ydd_left *x2^2 = 2*b2 + 6*b3*(x/x2)
           _
           条件（6 个未知数的 6 个方程）：
                     y1 = a1 + a2 + a3
                     y2 = b1 + b2 + b3
                 y1d*x1 = a1 + 2*a2 + 3*a3
                 y2d*x2 = b1 + 2*b2 + 3*b3
                    y0d = a1/x1 = b1/x2
                   y0dd = 2*a2/x1^2 = 2*b2/x2^2
           _
           衍生方程：
              b1 = a1*x2/x1
              b2 = a2*(x2/x1)^2
              b3 = y2 - b1 - b2
                 = y2 - a1*(x2/x1) - a2*(x2/x1)^2
              a3 = y1 - a1 - a2
           _
           剩余方程：
              y1d*x1 = a1 + 2*a2 + 3*(y1 - a1 - a2)
                     = 3*y1 - 2*a1 - a2
              y2d*x2 = a1*(x2/x1) + 2*a2*(x2/x1)^2 +
                       3*(y2 - a1*(x2/x1) - a2*(x2/x1)^2)
                     = 3*y2 - 2*a1*(x2/x1) - a2*(x2/x1)^2
              y0d    = a1/x1
           _
           求解这些方程的结果是 y0d 如下
           (注意，分母"(1-w) "总是不为零，因为 w 是负数)
           */
             w :=x2/x1;
             y0d := ( (3*y2 - x2*y2d)/w - (3*y1 - x1*y1d)*w) /(2*x1*(1 - w));
          end if;

          /* 修改导数 y0d，使多项式单调递增。充分条件是 0 <= y0d <= sqrt(8.75*k_i/|x_i|)
        */
          w1 :=sqrt_k1*sqrt(8.75/x1);
          w2 :=sqrt_k2*sqrt(8.75/abs(x2));
          y0d :=smooth(2, min(y0d, 0.9*min(w1, w2)));

          /* 按比例多项式进行插值：
           y_new = y/y1
           x_new = x/x1
        */
          y := y1*(if x >= 0 then evaluatePoly3_derivativeAtZero(x/x1,1,1,y1d*x1/y1,y0d*x1/y1) else 
                                  evaluatePoly3_derivativeAtZero(x/x1,x2/x1,y2/y1,y2d*x1/y1,y0d*x1/y1));
       end if;
       annotation(smoothOrder=2);
    end regRoot2_utility;
  algorithm
    y := smooth(2, if x >= x_small then sqrt_k1*sqrt(x) else 
                   if x <= -x_small then -sqrt_k2*sqrt(abs(x)) else 
                   if k1 >= k2 then regRoot2_utility(x,x_small,k1,k2,use_yd0,yd0) else 
                                   -regRoot2_utility(-x,x_small,k2,k1,use_yd0,yd0));
    annotation(smoothOrder=2, Documentation(info="<html><p>
近似函数
</p>
<pre><code >y = if x ≥ 0 then sqrt(k1*x) else -sqrt(k2*abs(x)), with k1, k2 ≥ 0
</code></pre><p>
 &nbsp; &nbsp; &nbsp; &nbsp;在区间-x_small ≤ x ≤ x_small内，该函数由两个三阶多项式描述 (一个在区间-x_small≤ x ≤0，一个在区间 0 ≤ x ≤x_small ）。 使得：
</p>
<li>
在x=0 处的导数为有限值。</li>
<li>
整个函数处处连续且具有连续的一阶导数。</li>
<li>
若参数 use_yd0 = <strong>false</strong>，则构造的两个多项式在 x=0 处的二阶导数相同； 若参数 use_yd0 = <strong>true</strong>，则通过额外参数 yd0 显示指定 x=0 处的导数值。 必要时，系统会自动降低yd0 的值以确保多项式严格单调递增（ <em>参见[Fritsch and Carlson, 1980]）</em>。</li>
<p>
 &nbsp; &nbsp; &nbsp; &nbsp;两种不同配置的典型截图如下所示。第一个配置为 k1=k2=1：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Utilities/regRoot2_a.png\" alt=\"regRoot2_a.png\" data-href=\"\" style=\"\">
</p>
<p>
 &nbsp; &nbsp; &nbsp; &nbsp;第二个配置为 k1=1 and k2=3:
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Utilities/regRoot2_b.png\" alt=\"regRoot2_b.png\" data-href=\"\" style=\"\">
</p>
<p>
 &nbsp; &nbsp; &nbsp; &nbsp;参数为k1=1, k2=3 时，函数的（平滑）导数如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Utilities/regRoot2_c.png\" alt=\"regRoot2_c.png\" data-href=\"\" style=\"\">
</p>
<p>
<strong>文献</strong>
</p>
<p>
 Fritsch F.N. and Carlson R.E. (1980):
</p>
<p>
<strong>Monotone piecewise cubic interpolation</strong>.<br>SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246
</p>
<p>
<br>
</p>
</html>",revisions="<html>
<ul>
<li><em>Sept., 2010</em>
by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
进行改进，使 k1=0 和/或 k2=0。</li>
<li><em>Nov., 2005</em>
by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
设计并实施。</li>
</ul>
</html>"));
  end regRoot2;

  function regSquare2 
    "带不连续因子的反对称近似平方，使一阶导数不为零且连续"
    extends Modelica.Icons.Function;
    input Real x "横坐标值";
    input Real x_small(min=0)=0.01 
      "|x| <= x_small 时的函数近似值";
    input Real k1(min=0)=1 "y = (if x>=0 then k1 else k2)*x*|x|";
    input Real k2(min=0)=1 "y = (if x>=0 then k1 else k2)*x*|x|";
    input Boolean use_yd0 = false "true：使用 yd0";
    input Real yd0(min=0)=1 "x=0 时的预期导数： dy/dx = yd0";
    output Real y "纵坐标值";
  encapsulated function regSquare2_utility 
      "使用两个三阶多项式进行插值，并在 x=0 处预设导数值"
      import Modelica;
      extends Modelica.Icons.Function;
      import Modelica.Fluid.Utilities.evaluatePoly3_derivativeAtZero;
       input Real x;
       input Real x1 "函数 abs(x) < x1 的近似值";
       input Real k1 "y = (if x>=0 then k1 else -k2)*x*|x|; k1 >= k2";
       input Real k2 "y = (if x>=0 then k1 else -k2)*x*|x|";
       input Boolean use_yd0 = false "true: 使用 yd0";
       input Real yd0(min=0)=1 "x=0 时的预期导数：dy/dx = yd0";
       output Real y;
    protected
       Real x2;
       Real y1;
       Real y2;
       Real y1d;
       Real y2d;
       Real w;
       Real w1;
       Real w2;
       Real y0d;
       Real ww;
    algorithm
       // x2 :=-x1*(k2/k1)^2;
       x2 := -x1;
       if x <= x2 then
          y := -k2*x^2;
       else
           y1 := k1*x1^2;
           y2 :=-k2*x2^2;
          y1d := k1*2*x1;
          y2d :=-k2*2*x2;
          if use_yd0 then
             y0d :=yd0;
          else
             /* 确定导数，使左右多项式在 x=0 时的一阶导数和二阶导数相同：参见函数 regRoot2 中的推导过程 */
             w :=x2/x1;
             y0d := ( (3*y2 - x2*y2d)/w - (3*y1 - x1*y1d)*w) /(2*x1*(1 - w));
          end if;

          /* 修改导数 y0d，使多项式单调递增。充分条件是 0 <= y0d <= sqrt(5)*k_i*|x_i|
        */
          w1 :=sqrt(5)*k1*x1;
          w2 :=sqrt(5)*k2*abs(x2);
          // y0d :=min(y0d, 0.9*min(w1, w2));
          ww :=0.9*(if w1 < w2 then w1 else w2);
          if ww < y0d then
             y0d :=ww;
          end if;
          y := if x >= 0 then evaluatePoly3_derivativeAtZero(x,x1,y1,y1d,y0d) else 
                              evaluatePoly3_derivativeAtZero(x,x2,y2,y2d,y0d);
       end if;
       annotation(smoothOrder=2);
    end regSquare2_utility;
  algorithm
    y := smooth(2,if x >= x_small then k1*x^2 else 
                  if x <= -x_small then -k2*x^2 else 
                  if k1 >= k2 then regSquare2_utility(x,x_small,k1,k2,use_yd0,yd0) else 
                                  -regSquare2_utility(-x,x_small,k2,k1,use_yd0,yd0));
    annotation(smoothOrder=2, Documentation(info="<html><p>
 &nbsp; &nbsp; &nbsp; 近似函数
</p>
<pre><code >y = if x ≥ 0 then k1*x*x else -k2*x*x, with k1, k2 &gt; 0
</code></pre><p>
 &nbsp; &nbsp; &nbsp; 在区间-x_small ≤ x ≤ x_small内，该函数通过两个三阶多项式分段描述 (左区间 -x_small ≤ x ≤0 和右区间 0 ≤ x ≤x_small ）。使得：
</p>
<li>
函数在x=0 处的导数非零（以确保其反函数的导数不会为无穷大）。</li>
<li>
整体函数处处连续且一阶导数连续。</li>
<li>
若参数 use_yd0 = <strong>false</strong>，则构造的两个多项式在 x=0 处的二阶导数相同；若 use_yd0 = <strong>true</strong>，则通过额外参数 yd0 显示指定 x=0 处的导数值。 必要时，系统会自动降低yd0 的取值以确保多项式严格单调递增 <em>[Fritsch and Carlson, 1980]</em>。</li>
<p>
 &nbsp; &nbsp; &nbsp; &nbsp;参数为k1=1, k2=3 时，典型效果截图如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Utilities/regSquare2_b.png\" alt=\"regSquare2_b.png\" data-href=\"\" style=\"\">
</p>
<p>
 &nbsp; &nbsp; &nbsp; &nbsp;参数为k1=1, k2=3 时，函数的（平滑且非零的）导数如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Utilities/regSquare2_c.png\" alt=\"regSquare2_b.png\" data-href=\"\" style=\"\">
</p>
<p>
<strong>参考文献</strong>
</p>
<p>
Fritsch F.N. and Carlson R.E. (1980):
</p>
<p>
<strong>Monotone piecewise cubic interpolation</strong>.<br>SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246
</p>
</html>",revisions="<html>
<ul>
<li><em>Nov., 2005</em>
by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
设计并实施。</li>
</ul>
</html>"));
  end regSquare2;

  function regStep 
    "一般阶跃函数的近似值，使其特征保持连续且可微"
    extends Modelica.Icons.Function;
    input Real x "横坐标值";
    input Real y1 "x > 0 时的纵坐标值";
    input Real y2 "x < 0 时的纵坐标值";
    input Real x_small(min=0) = 1e-5 
      "步长为-x_small <= x <= x_small时的近似值； 需要 x_small >= 0";
    output Real y "近似纵坐标值 y = if x > 0 then y1 else y2";
  algorithm
    y := smooth(1, if x >  x_small then y1 else 
                   if x < -x_small then y2 else 
                   if x_small > 0 then (x/x_small)*((x/x_small)^2 - 3)*(y2-y1)/4 + (y1+y2)/2 else (y1+y2)/2);
    annotation(Documentation(revisions="<html>
<ul>
<li><em>April 29, 2008</em>
by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
设计并实施。</li>
<li><em>August 12, 2008</em>
by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
小修改以涵盖不除以零的极限情况 <code>x_small -> 0</code>。</li>
</ul>
</html>"      ,info="<html><p>
 &nbsp; &nbsp; 此函数用于对方程进行近似
</p>
<pre><code >y = if x &gt; 0 then y1 else y2;
</code></pre><p>
 &nbsp; &nbsp; &nbsp;通过光滑特性实现，使得表达式连续且可微：
</p>
<pre><code >y = smooth(1, if x &gt;  x_small then y1 else
        if x &lt; -x_small then y2 else f(y1, y2));
</code></pre><p>
 &nbsp; &nbsp; &nbsp; 在 区间-x_small &lt; x &lt; x_small内，使用二阶多项式实现从 y1 到 y2的平滑过渡。
</p>
</html>"));
  end regStep;

  function evaluatePoly3_derivativeAtZero 
    "求解经过原点且具有预设导数的三阶多项式"
    extends Modelica.Icons.Function;
    input Real x "多项式的评估值";
    input Real x1 "横坐标值";
    input Real y1 "y1=f(x1)";
    input Real y1d "y1 处的一阶导数";
    input Real y0d "f(x=0) 时的一阶导数";
    output Real y;
  protected
    Real a1;
    Real a2;
    Real a3;
    Real xx;
  algorithm
    a1 := x1*y0d;
    a2 := 3*y1 - x1*y1d - 2*a1;
    a3 := y1 - a2 - a1;
    xx := x/x1;
    y  := xx*(a1 + xx*(a2 + xx*a3));
    annotation(smoothOrder=3, Documentation(info="<html>

</html>"    ));
  end evaluatePoly3_derivativeAtZero;

  function regFun3 "协同单调且C1光滑的正则化函数"
    extends Modelica.Icons.Function;

    input Real x "横坐标值";
    input Real x0 "较小的横坐标值";
    input Real x1 "较大的横坐标值";
    input Real y0 "对应 x0 的纵坐标值";
    input Real y1 "对应 x1 的纵坐标值";
    input Real y0d "x0 处的导数";
    input Real y1d "x1 处的导数";

    output Real y "纵坐标值";
    output Real c 
      "两个三次多项式之间的线性斜率，如果使用单个三次多项式，则为假线性斜率";

  protected
    Real h0 "区间 i=0 的宽度";
    Real Delta0 "区间 i=0 上的割线斜率";
    Real xstar "三次多项式 S0 的拐点";
    Real mu "拐点与左极限 x0 的距离";
    Real eta "右极限 x1 与拐点的距离";
    Real omega "三次多项式 S0 在拐点处的斜率";
    Real rho "eta 和 eta_tilde、mu 和 mu_tilde 的加权系数";
    Real theta0 "斜率";
    Real mu_tilde "直线段起点与左极限 x0 的距离";
    Real eta_tilde "右极限 x1 与直线段末端的距离";
    Real xi1 "直线段起点";
    Real xi2 "直线段末端";
    Real a1 "左侧三次项系数";
    Real a2 "右侧三次项系数";
    Real const12 "左侧三次方线性部分的积分常数";
    Real const3 "右侧三次方的积分常数";
    Real aux01;
    Real aux02;
    Boolean useSingleCubicPolynomial=false 
      "表示覆盖进一步的逻辑并使用单个多项式";
  algorithm
    // 检查参数： 数据点位置
    assert(x0 < x1, "regFun3(): 数据点排序不当 (x0 = " + 
      String(x0) + " > x1 = " + String(x1) + ")，请翻转争论点。");
    // 检查参数： 数据点导数
    if y0d*y1d >= 0 then
      // 数据点上的导数可实现同单调插值，则与此无关
    else
      // 严格来说，数据点上的导数不允许同单调插值，但它们在数值上可能为零，因此可以这样断言
      assert(abs(y0d)<Modelica.Constants.eps or abs(y1d)<Modelica.Constants.eps, "regFun3(): 数据点的导数不允许共单调插值，因为两者都不为零，符号相反，且绝对值大于机械 eps (y0d = " + 
      String(y0d) + ", y1d = " + String(y1d) + ")，请更正论点。");
    end if;

    h0 := x1 - x0;
    Delta0 := (y1 - y0)/h0;

    if abs(Delta0) <= 0 then
      // 水平线上的点 (x0,y0) 和 (x1,y1)
      // 退化情况，因为我们无法同时实现 C1 目标和同单调行为
      y := y0 + Delta0*(x-x0);     // y == y0 == y1，带有辅助自动微分的附加项
      c := 0;
    elseif abs(y1d + y0d - 2*Delta0) < 100*Modelica.Constants.eps then
      // 拐点位于正负无穷大，因此 S0 是同单调的，可以直接返回
      y := y0 + (x-x0)*(y0d + (x-x0)/h0*( (-2*y0d-y1d+3*Delta0) + (x-x0)*(y0d+y1d-2*Delta0)/h0));
      // 将 x:=(x0+x1)/2 处的三次斜率设为 "假线性斜率"。
      aux01 := (x0 + x1)/2;
      c := 3*(y0d + y1d - 2*Delta0)*(aux01 - x0)^2/h0^2 + 2*(-2*y0d - y1d + 3*Delta0)*(aux01 - x0)/h0 
         + y0d;
    else
      // 点 (x0,y0) 和 (x1,y1) 不在水平线上，且 S0 的拐点不在正负无穷远处
      // 进行实际插值
      xstar := 1/3*(-3*x0*y0d - 3*x0*y1d + 6*x0*Delta0 - 2*h0*y0d - h0*y1d + 3*h0* 
        Delta0)/(-y0d - y1d + 2*Delta0);
      mu := xstar - x0;
      eta := x1 - xstar;
      omega := 3*(y0d + y1d - 2*Delta0)*(xstar - x0)^2/h0^2 + 2*(-2*y0d - y1d + 3* 
        Delta0)*(xstar - x0)/h0 + y0d;

      aux01 := 0.25*sign(Delta0)*min(abs(omega), abs(Delta0)) 
        "斜率 c(如果不使用三次多项式 S0)";
      if abs(y0d - y1d) <= 100*Modelica.Constants.eps then
        // y0 == y1(数值和符号相等)，则解决不确定的 0/0
        aux02 := y0d;
        if y1 > y0 + y0d*(x1 - x0) then
          // 如果 y1 在通过 (x0/y0) 的线性延长线之上
          // 斜率为 y0d（当斜率相同时）
          //  则一直使用单个三次多项式
          useSingleCubicPolynomial := true;
        end if;
      elseif abs(y1d + y0d - 2*Delta0) < 100*Modelica.Constants.eps then
        // (y1d+y0d-2*Delta0) 约等于 0，避免除以 0
        aux02 := (6*Delta0*(y1d + y0d - 3/2*Delta0) - y1d*y0d - y1d^2 - y0d^2)*(
          if (y1d + y0d - 2*Delta0) >= 0 then 1 else -1)*Modelica.Constants.inf;
      else
        // 目前无需看守
        aux02 := (6*Delta0*(y1d + y0d - 3/2*Delta0) - y1d*y0d - y1d^2 - y0d^2)/(3* 
          (y1d + y0d - 2*Delta0));
      end if;

      //aux02 := -1/3*(y0d^2+y0d*y1d-6*y0d*Delta0+y1d^2-6*y1d*Delta0+9*Delta0^2)/(y0d+y1d-2*Delta0);
      //aux02 := -1/3*(6*y1d*y0*x1+y0d*y1d*x1^2-6*y0d*x0*y0+y0d^2*x0^2+y0d^2*x1^2+y1d^2*x1^2+y1d^2*x0^2-2*y0d*x0*y1d*x1-2*x0*y0d^2*x1+y0d*y1d*x0^2+6*y0d*x0*y1-6*y0d*y1*x1+6*y0d*y0*x1-2*x0*y1d^2*x1-6*y1d*y1*x1+6*y1d*x0*y1-6*y1d*x0*y0-18*y1*y0+9*y1^2+9*y0^2)/(y0d*x1^2-2*x0*y0d*x1+y1d*x1^2-2*x0*y1d*x1-2*y1*x1+2*y0*x1+y0d*x0^2+y1d*x0^2+2*x0*y1-2*x0*y0);

      // 测试标准（也用于避免导致积分器收缩的鞍点）：
      //
      //  1. 三次多项式不单调 (Gasparo Morandi)
      //       ((mu > 0), (eta < h0), (Delta0*omega <= 0))
      //
      //  2. 三次多项式可能是单调的，但线性部分的斜率 c 要么太接近零，要么线性部分的终点位于起点的左侧
      //     但请注意，建议的斜率必须与 Delta0 的符号相同。
      //       (abs(aux01)<abs(aux02) and aux02*Delta0>=0)
      //
      //  3. 三次多项式可能是单调的，但线性部分的斜率太接近零（小于 Delta0 的 1/10）。
      //       (c < Delta0 / 10)
      //
      if (((mu > 0) and (eta < h0) and (Delta0*omega <= 0)) or (abs(aux01) < abs(
          aux02) and aux02*Delta0 >= 0) or (abs(aux01) < abs(0.1*Delta0))) and 
          not useSingleCubicPolynomial then
        // 使用三次多项式 S0 时不是单调的，应使用一小段的 S0 函数的斜线代替
        c := aux01;
        // 避免同单调但导致积分器收缩的鞍点
        if abs(c) < abs(aux02) and aux02*Delta0 >= 0 then
          c := aux02;
        end if;
        if abs(c) < abs(0.1*Delta0) then
          c := 0.1*Delta0;
        end if;
        theta0 := (y0d*mu + y1d*eta)/h0;
        if abs(theta0 - c) < 1e-6 then
          // 略微减小 c，以避免出现问题
          c := (1 - 1e-6)*theta0;
        end if;
        rho := 3*(Delta0 - c)/(theta0 - c);
        mu_tilde := rho*mu;
        eta_tilde := rho*eta;
        xi1 := x0 + mu_tilde;
        xi2 := x1 - eta_tilde;
        a1 := (y0d - c)/max(mu_tilde^2, 100*Modelica.Constants.eps);
        a2 := (y1d - c)/max(eta_tilde^2, 100*Modelica.Constants.eps);
        const12 := y0 - a1/3*(x0 - xi1)^3 - c*x0;
        const3 := y1 - a2/3*(x1 - xi2)^3 - c*x1;
        // 进行实际插值
        if (x < xi1) then
          y := a1/3*(x - xi1)^3 + c*x + const12;
        elseif (x < xi2) then
          y := c*x + const12;
        else
          y := a2/3*(x - xi2)^3 + c*x + const3;
        end if;
      else
        // 三次多项式 S0 是单调的，仍然使用
        y := y0 + (x-x0)*(y0d + (x-x0)/h0*( (-2*y0d-y1d+3*Delta0) + (x-x0)*(y0d+y1d-2*Delta0)/h0));
        // 将 x:=(x0+x1)/2 处的三次斜率设为 "假线性斜率"。
        aux01 := (x0 + x1)/2;
        c := 3*(y0d + y1d - 2*Delta0)*(aux01 - x0)^2/h0^2 + 2*(-2*y0d - y1d + 3*Delta0)*(aux01 - x0)/h0 
           + y0d;
      end if;
    end if;

    annotation (smoothOrder=1, Documentation(revisions="<html>
<ul>
<li><em>May 2008</em> by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>设计并实施。</li>
<li><em>February 2011</em> by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
如果三次多项式 S0 的拐点位于正负无穷大，<em>[Gasparo and Morandi, 1991]</em> 的检验标准就会导致除以零。现在这种情况已得到妥善处理。</li>
<li><em>March 2013</em> by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
如果参数规定了水平线上的点 <code>(x0,y0)</code> 和 <code>(x1,y1)</code> 的退化情况，则计算值 <code>c</code> 是未定义的。这一点已得到纠正。此外，在这种情况下计算 <code>y</code> 时还加入了一个附加项，以帮助自动微分。</li>
</ul>
</html>"              ,info="<html><p>
 &nbsp; &nbsp;在 区间<code>x0</code> 和 <code>x1</code> 内构造函数近似，满足以下条件：
</p>
<li>
整体函数处处连续且具有连续的一阶导数。</li>
<li>
函数与给定数据点协同单调。</li>
<p>
 &nbsp; &nbsp;在该区域内，根据给定点 (x0，y0)、(x1，y1) 及其给定的导数值构造连续函数。为此，可采用单一的三次多项式或中间含线性段连接的两个三次多项式 <em>[Gasparo and Morandi, 1991]</em>。为避免因导数为零/无穷大导致的鞍点引发积分器步长缩减至零的问题，该算法扩展增加了两个约束条件。
</p>
<p>
 &nbsp; &nbsp;<span style=\"font-size: 16px;\">此函数专为压降关联式而开发，在满足单调性和光滑性既定要求的基础上，进一步妥善处理了静压头的影响。在此情况下，当x1-x0趋近于零或y1-y0趋近于零时，该函数可实现精确解的极限逼近。</span>
</p>
<p>
 &nbsp; &nbsp;下方展示了两组不同配置的典型截图。第一个截图展示了 <code>xi</code> 和 <code>yid</code> 参数的五种不同设定组合：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Utilities/regFun3_a.png\" alt=\"regFun3_a.png\" data-href=\"\" style=\"\">
</p>
<p>
 &nbsp; &nbsp; 第二张图展示了该正则化函数的连续导数变化：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Fluid/Utilities/regFun3_b.png\" alt=\"regFun3_a.png\" data-href=\"\" style=\"\">
</p>
<p>
<strong>参考文献</strong>
</p>
<p>
Gasparo M. G. and Morandi R. (1991):
</p>
<p>
<strong>Piecewise cubic monotone interpolation with assigned slopes</strong>.<br>Computing, Vol. 46, Issue 4, December 1991, pp. 355 - 365.
</p>
</html>"));
  end regFun3;

  function cubicHermite "三次 Hermite 样条曲线求值"
    extends Modelica.Icons.Function;

    input Real x "横坐标值";
    input Real x1 "较小的横坐标值";
    input Real x2 "较大的横坐标值";
    input Real y1 "较小的纵坐标值";
    input Real y2 "较大的纵坐标值";
    input Real y1d "小梯度";
    input Real y2d "大梯度";
    output Real y "插值纵坐标值";
  protected
    Real h "x1 和 x2 之间的距离";
    Real t "按 h 缩放的横坐标，即 x=[x1...x2] 内的 t=[0...1]";
    Real h00 "三次 Hermite 样条曲线的基本函数 00";
    Real h10 "三次 Hermite 样条曲线的基本函数 10";
    Real h01 "三次 Hermite 样条曲线的基本函数 01";
    Real h11 "三次 Hermite 样条曲线的基本函数 11";
    Real aux3 "t 的立方";
    Real aux2 "t 的平方";
  algorithm
    h := x2 - x1;
    if abs(h)>0 then
      // 常规情况
      t := (x - x1)/h;

      aux3 :=t^3;
      aux2 :=t^2;

      h00 := 2*aux3 - 3*aux2 + 1;
      h10 := aux3 - 2*aux2 + t;
      h01 := -2*aux3 + 3*aux2;
      h11 := aux3 - aux2;
      y := y1*h00 + h*y1d*h10 + y2*h01 + h*y2d*h11;
    else
      // 退化情况，x1 和 x2 相同，计算阶跃函数
      y := (y1 + y2)/2;
    end if;
    annotation(smoothOrder=3, Documentation(revisions="<html>
<ul>
<li><em>May 2008</em>
by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
设计并实施。</li>
</ul>
</html>"        ));
  end cubicHermite;

  function cubicHermite_withDerivative 
    "评估三次 Hermite 样条曲线，返回函数值及其导数"
    extends Modelica.Icons.Function;

    input Real x "横坐标值";
    input Real x1 "较小的横坐标值";
    input Real x2 "较大的横坐标值";
    input Real y1 "较小的纵坐标值";
    input Real y2 "较大的纵坐标值";
    input Real y1d "小梯度";
    input Real y2d "大梯度";
    output Real y "插值纵坐标值";
    output Real dy_dx "横坐标 x 时的导数 dy/dx";
  protected
    Real h "x1 和 x2 之间的距离";
    Real t "按 h 缩放的横坐标，即 x=[x1...x2] 内的 t=[0...1]";
    Real h00 "三次 Hermite 样条曲线的基本函数 00";
    Real h10 "三次 Hermite 样条曲线的基本函数 10";
    Real h01 "三次 Hermite 样条曲线的基本函数 01";
    Real h11 "三次 Hermite 样条曲线的基本函数 11";

    Real h00d "d/dt h00";
    Real h10d "d/dt h10";
    Real h01d "d/dt h01";
    Real h11d "d/dt h11";

    Real aux3 "t 的立方";
    Real aux2 "t 的平方";
  algorithm
    h := x2 - x1;
    if abs(h)>0 then
      // 常规情况
      t := (x - x1)/h;

      aux3 :=t^3;
      aux2 :=t^2;

      h00 := 2*aux3 - 3*aux2 + 1;
      h10 := aux3 - 2*aux2 + t;
      h01 := -2*aux3 + 3*aux2;
      h11 := aux3 - aux2;

      h00d := 6*(aux2 - t);
      h10d := 3*aux2 - 4*t + 1;
      h01d := 6*(t - aux2);
      h11d := 3*aux2 - 2*t;

      y := y1*h00 + h*y1d*h10 + y2*h01 + h*y2d*h11;
      dy_dx := y1*h00d/h + y1d*h10d + y2*h01d/h + y2d*h11d;
    else
      // 退化情况，x1 和 x2 相同，计算阶跃函数
      y := (y1 + y2)/2;
      dy_dx := sign(y2 - y1)*Modelica.Constants.inf;
    end if;
    annotation(smoothOrder=3, Documentation(revisions="<html>
<ul>
<li><em>May 2008</em>
by <a href=\"mailto:Michael.Sielemann@dlr.de\">Michael Sielemann</a>:<br>
设计并实施。</li>
</ul>
</html>"                          ));
  end cubicHermite_withDerivative;

  annotation (Documentation(info="<html>

</html>"));
end Utilities;