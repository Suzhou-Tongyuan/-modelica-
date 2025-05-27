within Modelica.Math;
package Random "生成随机数的函数库"
   extends Modelica.Icons.Package;

  package Examples 
    "示例演示了Random包中函数的用法"
    extends Modelica.Icons.ExamplesPackage;

    model GenerateRandomNumbers 
      "使用各种随机数生成器生成随机数"
       extends Modelica.Icons.Example;

    // 全局参数
      parameter Modelica.Units.SI.Period samplePeriod = 0.05 
        "随机数生成的采样周期";
      parameter Integer globalSeed = 30020 
        "初始化随机数生成器的全局种子";

    // 具有暴露状态的随机数生成器
      parameter Integer localSeed = 614657 
        "初始化随机数生成器的本地种子";
      output Real r64 "Xorshift64star生成的随机数";
      output Real r128 "使用Xorshift128plus生成的随机数";
      output Real r1024 "使用Xorshift1024star生成的随机数";
    protected
      discrete Integer state64[2](   each start=0, each fixed = true);
      discrete Integer state128[4](  each start=0, each fixed = true);
      discrete Integer state1024[33](each start=0, each fixed = true);
    algorithm
      when initial() then
        // 从localSeed和globalSeed生成初始状态
        state64   := Generators.Xorshift64star.initialState(  localSeed, globalSeed);
        state128  := Generators.Xorshift128plus.initialState( localSeed, globalSeed);
        state1024 := Generators.Xorshift1024star.initialState(localSeed, globalSeed);
        r64       := 0;
        r128      := 0;
        r1024     := 0;
      elsewhen sample(0,samplePeriod) then
        (r64,  state64)   := Generators.Xorshift64star.random(  pre(state64));
        (r128, state128)  := Generators.Xorshift128plus.random( pre(state128));
        (r1024,state1024) := Generators.Xorshift1024star.random(pre(state1024));
      end when;

    // 具有隐藏状态的不纯随机数生成器
    public
      parameter Integer id = Utilities.initializeImpureRandom(globalSeed) "用于正确排序方程的独特编号";
      discrete Real rImpure "非纯实数";
      Integer iImpure "非纯整数随机数";
    algorithm
      when initial() then
        rImpure := 0;
        iImpure := 0;
      elsewhen sample(0,samplePeriod) then
        rImpure := Utilities.impureRandom(id=id);
        iImpure := Utilities.impureRandomInteger(
              id=id, 
              imin=-1234, 
              imax=2345);
      end when;

      annotation (experiment(StopTime=2), Documentation(info="<html>
<p>
本例演示了如何在Modelica模型中使用<a href=\"modelica://Modelica.Math.Random.Generators\">Math.Random.Generators</a>包的随机数生成器。
该示例以0.05秒的采样周期定期计算可用随机数生成器在0到1范围内的随机数。
仿真结果如下图所示：
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Random/Examples/GenerateRandomNumbers.png\">
</blockquote>
</html>"        ,     revisions="<html>
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
</html>"        ));
    end GenerateRandomNumbers;
  annotation (Documentation(info="<html>
<p>
这个包包含了一些示例，演示了包中函数的用法
<strong>Random</strong>.
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
  end Examples;

  package Generators 
    "生成范围为0 < random <= 1.0的均匀随机数的函数库(带有暴露的状态向量)"
    extends Modelica.Icons.Package;

    package Xorshift64star "随机数生成器xorshift64*"
      constant Integer nState=2 "内部状态向量的维数";

      extends Modelica.Icons.Package;

      function initialState 
        "返回xorshift64*算法的初始状态"
        extends Modelica.Icons.Function;
        input Integer localSeed 
          "用于生成初始状态的本地种子";
        input Integer globalSeed 
          "要与本地种子组合的全局种子";
        output Integer state[nState] "生成的初始状态";
      protected
        Real r "未在函数外使用的随机数";

        /* 根据http://vigna.di.unimi.it/ftp/papers/xorshift.pdf, the xorshoft*
      随机数生成器从坏种子生成统计上的随机数
      在一次迭代中。为了安全起见，实际上使用了10次迭代
      */
        constant Integer p = 10 "要使用的迭代次数";

      algorithm
        // 如果seed=0，使用一个大质数作为seed (seed必须不同于0)。
        if localSeed == 0 and globalSeed == 0 then
          state := {126247697,globalSeed};
        else
          state := {localSeed,globalSeed};
        end if;

        // 生成p乘以一个随机数，以获得“良好”状态
        // 即使从一颗坏种子开始。
        for i in 1:p loop
          (r,state) := random(state);
        end for;
      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
state = Xorshift64star.<strong>initialState</strong>(localSeed, globalSeed);
</pre></blockquote>

<h4>描述</h4>
<p>
为Xorshift64star随机数生成器生成初始状态向量<strong>state</strong>
(= xorshift64*算法)，from
两个整数作为输入(参数localSeed, globalSeed)。任意整数
可给出(包括零或负数)。函数返回
一个合理的初始状态向量，策略如下:
</p>

<p>
如果两者都输入
参数为零，则localSeed在内部使用一个固定的非零值。
根据<a href=\"http://vigna.di.unimi.it/ftp/papers/xorshift.pdf\">xorshift.pdf</a>，
xorshift64*随机数生成器从a生成统计随机数
在一次迭代中产生坏种子。为了安全起见，实际上会生成10个随机数
返回的状态是上次迭代的状态。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Integer localSeed;
<strong>parameter</strong> Integer globalSeed;
Integer state[Xorshift64star.nState];
<strong>initial equation</strong>
state = initialState(localSeed, globalSeed);
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star.random\">Random.Generators.Xorshift64star.random</a>.
</p>
</html>"                  ,     revisions="<html>
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
</html>"                  ));
      end initialState;

      pure function random 
        "使用xorshift64*算法返回一个一致的随机数"
        extends Modelica.Icons.Function;
        input Integer stateIn[nState] 
          "随机数生成器的内部状态";
        output Real result 
          "在区间(0,1)上均匀分布的随机数";
        output Integer stateOut[nState] 
          "随机数生成器的新内部状态";
        external "C" ModelicaRandom_xorshift64star(stateIn, stateOut, result) 
          annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaRandom.h\"", Library="ModelicaExternalC");
        annotation(Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(r, stateOut) = Xorshift64star.<strong>random</strong>(stateIn);
</pre></blockquote>

<h4>描述</h4>
<p>
返回一个范围为0 &lt; r &le; 1的均匀随机数r,使用xorshift64*算法。
输入参数<strong>stateIn</strong>是前一次调用的状态向量。
输出参数<strong>stateOut</strong>是更新后的状态向量。
如果函数以相同的状态向量调用，则完全相同
返回相同的随机数r。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Integer localSeed;
<strong>parameter</strong> Integer globalSeed;
Real r;
Integer state[Xorshift64star.nState];
<strong>initial equation</strong>
state = initialState(localSeed, globalSeed);
<strong>equation</strong>
<strong>when</strong> sample(0,0.1) <strong>then</strong>
(r, state) = random(<strong>pre</strong>(state));
<strong>end when</strong>;
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star.initialState\">Random.Generators.Xorshift64star.initialState</a>.
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
      end random;
      annotation (Documentation(info="<html>
<p>
随机数生成器<strong>xorshift64*</strong>。这个生成器的周期是2^64
(周期定义在序列开始重复之前生成的随机数的数量)。
有关概述、与其他随机数生成器的比较以及文章链接，请参见
<a href=\"modelica://Modelica.Math.Random.Generators\">Math.Random.Generators</a>.
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
</html>"            ), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), 
            graphics={
        Ellipse(
          extent={{-64,0},{-14,-50}}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{12,52},{62,2}}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid)}));
    end Xorshift64star;

    package Xorshift128plus "随机数生成器xorshift128+"
      constant Integer nState=4 "内部状态向量的维数";

      extends Modelica.Icons.Package;

      function initialState 
        "返回xorshift128+算法的初始状态"
        extends Modelica.Icons.Function;
        input Integer localSeed 
          "用于生成初始状态的本地种子";
        input Integer globalSeed 
          "要与本地种子组合的全局种子";
        output Integer state[nState] "生成的初始状态";
      algorithm
        state := Utilities.initialStateWithXorshift64star(
                localSeed, 
                globalSeed, 
                size(state, 1));
        annotation(Inline=true, Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
state = Xorshift128plus.<strong>initialState</strong>(localSeed, globalSeed);
</pre></blockquote>

<h4>描述</h4>
<p>
为Xorshift128plus随机数生成器生成初始状态向量
(= xorshift128+算法)，from
两个整数作为输入(参数localSeed, globalSeed)。任意整数
可给出(包括零或负数)。函数返回
一个合理的初始状态向量，策略如下:
</p>

<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star\">Xorshift64star</a>
随机数生成器用于用64位随机数填充内部状态向量。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Integer localSeed;
<strong>parameter</strong> Integer globalSeed;
Integer state[Xorshift128plus.nState];
<strong>initial equation</strong>
state = initialState(localSeed, globalSeed);
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift128plus.random\">Random.Generators.Xorshift128plus.random</a>.
</p>
</html>"                      ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

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
</html>"                      ));
      end initialState;

      pure function random 
        "使用xorshift128+算法返回一个一致的随机数"
        extends Modelica.Icons.Function;
        input Integer stateIn[nState] 
          "随机数生成器的内部状态";
        output Real result 
          "在区间(0,1)上均匀分布的随机数";
        output Integer stateOut[nState] 
          "随机数生成器的新内部状态";
        external "C" ModelicaRandom_xorshift128plus(stateIn, stateOut, result) 
          annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaRandom.h\"", Library="ModelicaExternalC");
        annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
(r, stateOut) = Xorshift128plus.<strong>random</strong>(stateIn);
</pre></blockquote>

<h4>描述</h4>
<p>
返回0 &lt; r &le; 1范围内的均匀随机数;使用xorshift128+算法。
输入参数<strong>stateIn</strong>是前一次调用的状态向量。
输出参数<strong>stateOut</strong>是更新后的状态向量。
如果函数以相同的状态向量调用，则完全相同
返回相同的随机数r。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Integer localSeed;
<strong>parameter</strong> Integer globalSeed;
Real r;
Integer state[Xorshift128plus.nState];
<strong>initial equation</strong>
state = initialState(localSeed, globalSeed);
<strong>equation</strong>
<strong>when</strong> sample(0,0.1) <strong>then</strong>
(r, state) = random(<strong>pre</strong>(state));
<strong>end when</strong>;
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift128plus.initialState\">Random.Generators.Xorshift128plus.initialState</a>.
</p>
</html>"                            ,     revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

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
</html>"                            ));
      end random;
      annotation (Documentation(info="<html>
<p>
随机数生成器<strong>xorshift128+</strong>。这个发生器的周期是2^128
(周期定义在序列开始重复之前生成的随机数的数量)。
为概述，比较与
其他随机数生成器和文章链接参见<a href=\"modelica://Modelica.Math.Random.Generators\">Math.Random.Generators</a>。
</p>
</html>"                ,     revisions="<html>
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
</html>"                ), 
     Icon(graphics={
        Ellipse(
          extent={{-70,60},{-20,10}}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{32,58},{82,8}}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-20,-12},{30,-62}}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid)}));
    end Xorshift128plus;

    package Xorshift1024star "随机数生成器xorshift1024*"
      constant Integer nState = 33 "内部状态向量的维数";

      extends Modelica.Icons.Package;

      function initialState 
        "返回xorshift1024*算法的初始状态"
        extends Modelica.Icons.Function;
        input Integer localSeed 
          "用于生成初始状态的本地种子";
        input Integer globalSeed 
          "要与本地种子组合的全局种子";
        output Integer state[nState] "生成的初始状态";
      algorithm
        state := Utilities.initialStateWithXorshift64star(
          localSeed, globalSeed, size(state, 1));
        annotation(Inline = true, Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
state = Xorshift1024star.<strong>initialState</strong>(localSeed, globalSeed);
</pre></blockquote>

<h4>描述</h4>

<p>
为Xorshift1024star随机数生成器生成初始状态向量
(= xorshift1024*算法)，from
两个整数作为输入(参数localSeed, globalSeed)。任意整数
可给出(包括零或负数)。函数返回
一个合理的初始状态向量，策略如下:
</p>

<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star\">Xorshift64star</a>
随机数生成器用于用64位随机数填充内部状态向量。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Integer localSeed;
<strong>parameter</strong> Integer globalSeed;
Integer state[Xorshift1024star.nState];
<strong>初始方程</strong>
state = initialState(localSeed, globalSeed);
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift1024star.random\">Random.Generators.Xorshift1024star.random</a>.
</p>
</html>"    , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

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
      end initialState;

      pure function random 
        "使用xorshift1024*算法返回一个一致的随机数"
        extends Modelica.Icons.Function;
        input Integer stateIn[nState] 
          "随机数生成器的内部状态";
        output Real result 
          "在区间(0,1)上均匀分布的随机数";
        output Integer stateOut[nState] 
          "随机数生成器的新内部状态";
      external "C" ModelicaRandom_xorshift1024star(stateIn, stateOut, result) 
        annotation(IncludeDirectory = "modelica://Modelica/Resources/C-Sources", Include = "#include \"ModelicaRandom.h\"", Library = "ModelicaExternalC");
      annotation(Documentation(info = "<html>
<h4>语法</h4>
<blockquote><pre>
(r, stateOut) = Xorshift128plus.<strong>random</strong>(stateIn);
</pre></blockquote>

<h4>描述</h4>
<p>
返回0 &lt; r &le; 1范围内的均匀随机数;使用xorshift1024*算法。
输入参数<strong>stateIn</strong>是前一次调用的状态向量。
输出参数<strong>stateOut</strong>是更新后的状态向量。
如果函数以相同的状态向量调用，则完全相同
返回相同的随机数r。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Integer localSeed;
<strong>parameter</strong> Integer globalSeed;
Real r;
Integer state[Xorshift1024star.nState];
<strong>initial equation</strong>
state = initialState(localSeed, globalSeed);
<strong>equation</strong>
<strong>when</strong> sample(0,0.1) <strong>then</strong>
(r, state) = random(<strong>pre</strong>(state));
<strong>end when</strong>;
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift1024star.initialState\">Random.Generators.Xorshift1024star.initialState</a>.
</p>
</html>"    , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

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
      end random;
      annotation(Documentation(info = "<html>
<p>
随机数生成器<strong>xorshift1024*</strong>。这个生成器的周期是2^1024
(周期定义在序列开始重复之前生成的随机数的数量)。
有关概述、与其他随机数生成器的比较以及文章链接，请参见
<a href=\"modelica://Modelica.Math.Random.Generators\">Math.Random.Generators</a>。
</p>
</html>"    , revisions = "<html>
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
</html>"    ), 
        Icon(graphics = {
        Ellipse(
        extent = {{-70, 78}, {-20, 28}}, 
        fillColor = {215, 215, 215}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{20, 58}, {70, 8}}, 
        fillColor = {215, 215, 215}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{-64, 6}, {-14, -44}}, 
        fillColor = {215, 215, 215}, 
        fillPattern = FillPattern.Solid), 
        Ellipse(
        extent = {{16, -20}, {66, -70}}, 
        fillColor = {215, 215, 215}, 
        fillPattern = FillPattern.Solid)}));
    end Xorshift1024star;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
          -100,-100},{100,100}}), graphics={Line(
        points={{-90,-54},{-50,-54},{-50,54},{50,54},{50,-54},{84,-54}})}), Documentation(info="<html>
<p>
这个包包含各种伪随机数生成器。随机数生成器是一个包
这包括下列要素:
</p>
<ul>
<li> Integer <strong>nState</strong>是定义内部状态向量长度的常量
(为了能够声明该长度的适当Integer向量，具体取决于
所选随机数生成器).</li>
<li> 函数<strong>initialState(..)</strong>用于初始化随机数生成器的状态
通过提供Integer种子并经常调用随机数生成器
每次调用函数random(..)都会返回统计上相关的随机数。.</li>
<li> 函数<strong>random(..)</strong>用于返回一个范围内Real类型的随机数
0.0 & lt;随机勒;每个呼叫1.0。
此外，还会返回随机数生成器的更新(内部)状态.
</li>
</ul>

<p>
Generators包包含<strong>xorshift</strong>随机数生成器套件
来自Sebastiano Vigna(2014年起;基于George Marsaglia的作品)。
这些随机的性质
下面总结了数字生成器，并与常用的数字生成器进行了比较
梅森扭扭机(MT19937-64)发电机。该表是基于
<a href=\"http://xorshift.di.unimi.it/\">http://xorshift.di.unimi. it/</a>和
文章:
</p>
<blockquote>
<p>
Sebastiano Vigna:
<a href=\"http://vigna.di.unimi.it/ftp/papers/xorshift.pdf\">An experimental exploration of Marsaglia's xorshift generators, scrambled</a>, 2014.<br>
Sebastiano Vigna:
<a href=\"http://vigna.di.unimi.it/ftp/papers/xorshiftplus.pdf\">Further scramblings of Marsaglia's xorshift generators</a>, 2014.<br>
</p>
</blockquote>

<p>
随机数生成器的特性总结:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Property</th>
<th>xorshift64*</th>
<th>xorshift128+</th>
<th>xorshift1024*</th>
<th>MT19937-64</th></tr>

<tr><td>Period</td>
<td>2^64</td>
<td>2^128</td>
<td>2^1024</td>
<td>2^19937</td></tr>

<tr><td>Length of state (# 32 bit integer)</td>
<td>2</td>
<td>4</td>
<td>33</td>
<td>624</td></tr>

<tr><td>Statistic failures (Big Crush)</td>
<td>363</td>
<td>64</td>
<td>51</td>
<td>516</td></tr>

<tr><td>Systematic failures (Big Crush)</td>
<td>yes</td>
<td>no</td>
<td>no</td>
<td>yes</td></tr>

<tr><td>Worst case startup</td>
<td> &gt; 1 call       </td>
<td> &gt; 20 calls     </td>
<td> &gt; 100 calls    </td>
<td> &gt; 100000 calls </td></tr>

<tr><td>Run time (MT=1.0)</td>
<td> 0.39 </td>
<td> 0.27 </td>
<td> 0.33 </td>
<td> 1.0  </td></tr>
</table>
</blockquote>

<p>
对上述特性的进一步解释:
</p>

<ul>
<li> <strong>周期</strong>定义生成随机数的个数
在悲剧重演之前。根据
\"<a href=\"http://xorshift.di.unimi. it/\">A long period does not imply high quality</a>\"
2^1024的周期对于大规模并行模拟来说已经足够大了
每次模拟都有大量的随机数计算。
2^128的周期可能不足以进行大规模并行模拟。
 </li>

<li> <strong>状态长度(# 32位整型)</strong>定义了“int”(即Modelica integer)元素的个数
用于内部状态向量。</li>

<li> <strong>Big Crush</strong>是<a href=\"http://simul.iro.umontreal.ca/testu01/tu01.html\"> test01 </a>的一部分
一个测试随机数生成器的巨大框架。
根据这些测试，xorshift随机数的统计性质
产生的随机数比Mersenne Twister随机数产生的随机数要好。</li>

<li> <strong>最坏情况启动</strong>表示在得到之前需要调用多少次
从坏种子到具有适当统计属性的随机数。
在这里，xorshift随机数套件具有更好的属性
比梅森旋风还要厉害初始化随机数生成器时，上述属性
并生成适当的随机数，以便随后的
调用random(..)将生成统计上相关的随机数，即使用户
提供一个坏的初始种子(例如localSeed=1)。这意味着，任何整数都可以表示为
初始种子不影响生成随机数的质量。</li>

<li> <strong>运行时</strong>显示xorshift随机数生成器是
不过都比梅森扭扭机随机数生成器快得多
这与大多数模拟并不相关，因为执行
其他部分的模拟时间通常要大得多。</li>
</ul>

<p>
中的xorshift随机数生成器以以下方式使用
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks. Noise</a> :
</p>
<ol>
<li> xorshift64* (xorshift64*)用于生成初始内部状态向量
其他生成器从两个整数值，由于
非常好的启动属性。</li>

<li> xorshift128+ (xorshift128+)是随机数生成器
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>中的块使用。
由于这些块保存每个块实例的内部状态向量，并且
每当绘制新的随机数时，都会复制内部状态向量，这很重要
内部状态向量很短(并且仍然具有良好的统计特性)
如上表所示)。</li>

<li> xorshift1024* (xorshift1024*)是非纯函数的基础
<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\">Math.Random.Utilities.impureRandom</a>
Which依次与
<a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>。
内部状态向量没有暴露。它在内部更新，每当一个新的随机数
是画的。</li>
</ol>

<p>
注意，生成器生成64位随机数。
这些数字被映射到范围0.0 ..的52位双位数尾数。1.0.
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
  end Generators;

  package Utilities 
    "Random包的实用函数库(通常用户不感兴趣)"

    extends Modelica.Icons.UtilitiesPackage;

    function initialStateWithXorshift64star 
      "返回随机数生成器的初始状态向量(基于xorshift64star算法)"
      import Modelica.Math.Random.Generators.Xorshift64star;
      extends Modelica.Icons.Function;
      input Integer localSeed 
        "用于生成初始状态的本地种子";
      input Integer globalSeed 
        "要与本地种子组合的全局种子";
      input Integer nState(min=1) "状态向量的维数(>= 1)";
      output Integer[nState] state "生成的初始状态";

    protected
      Real r "随机数只在函数内部使用";
      Integer aux[2] "状态整数的中间容器";
      Integer nStateEven "最高偶数<= nState";
    algorithm
      // 使用initialState()函数设置前两个状态
      aux            := Xorshift64star.initialState(localSeed, globalSeed);
      if nState >= 2 then
        state[1:2]   := aux;
      else
        state[1]     := aux[1];
      end if;

      // 填充状态向量的下一个元素
      nStateEven     := 2*div(nState, 2);
      for i in 3:2:nStateEven loop
        //(r,aux)      := Xorshift64star.random(state[i-2:i-1]);
                (r,aux) := Xorshift64star.random({state[i - 2], state[i - 1]});
        //state[i:i+1] := aux;
                state[i] := aux[1];
        state[i + 1] := aux[2];
      end for;

      // 如果nState不均匀，也填充最后一个元素
      if nState >= 3 and nState <> nStateEven then
        //(r,aux)       := Xorshift64star.random(state[nState-2:nState-1]);
                (r,aux) := Xorshift64star.random({state[nState - 2], state[nState - 1]});
        state[nState] := aux[1];
      end if;

      annotation (Documentation(revisions="<html>
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
</html>"        ,     info="<html>
<h4>Syntax</h4>
<blockquote><pre>
state = Utilities.<strong>initialStateWithXorshift6star</strong>(localSeed, globalSeed, nState);
</pre></blockquote>

<h4>描述</h4>

<p>
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star\">Xorshift64star</a>
随机数生成器用于填充长度为nState (nState &ge;1)用随机数返回
这个向量。参数localSeed和globalSeed是任意整数(包括零或负数)。
表征了初始状态。
如果给出相同的localSeed, globalSeed, nState，则返回相同的状态向量。
</p>

<h4>例子</h4>
<blockquote><pre>
parameter Integer localSeed;
parameter Integer globalSeed;
Integer state[33];
<strong>initial equation</strong>
state = Utilities.initialStateWithXorshift64star(localSeed, globalSeed, size(state,1));
</pre></blockquote>
</html>"        ));
    end initialStateWithXorshift64star;

    impure function automaticGlobalSeed 
      "创建一个自动整数种子(通常从当前时间和进程id；这是一个不纯的函数)"
      extends Modelica.Icons.Function;
      output Integer seed "自动生成种子";

      external "C" seed = ModelicaRandom_automaticGlobalSeed(0.0) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaRandom.h\"", Library="ModelicaExternalC");
     annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
seed = Utilities.<strong>automaticGlobalSeed</strong>();
</pre></blockquote>

<h4>描述</h4>
<p>返回一个自动计算的种子(整数)。通常，这个种子是从:</p>
<ol>
<li> 通过计算到当前小时的毫秒数来计算当前本地时间</li>
<li> 进程id(通过将其与素数6007相乘添加到第一部分).</li>
</ol>
<p>
如果getTime和getPid函数在此Modelica函数所在的目标上不可用
，则可以使用其他方法来计算种子。
</p>

<p>
注意，这是一个不纯的函数，当它被新调用时总是返回一个不同的值。
这个函数应该只在初始化期间调用一次。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Boolean useAutomaticSeed = false;
<strong>parameter</strong> Integer fixedSeed = 67867967;
<strong>final parameter</strong> Integer seed = <strong>if</strong> useAutomaticSeed <strong>then</strong>
                      Random.Utilities.automaticGlobalSeed() <strong>else</strong> fixedSeed;
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Utilities.automaticLocalSeed\">automaticLocalSeed</a>.
</p>
<h4>备注</h4>
<p>此功能不纯!</p>
</html>"                ,     revisions="<html>
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
</html>"                ));
    end automaticGlobalSeed;

    function automaticLocalSeed 
      "根据实例名称自动创建本地种子"
      extends Modelica.Icons.Function;
      input String path 
        "实例的完整路径名（使用 getInstanceName() 查询）";
      output Integer seed "自动生成种子";
    algorithm
      // 根据实例名称生成哈希值
      seed := Modelica.Utilities.Strings.hashString(path);

     annotation (Documentation(info="<html><h4>语法</h4><p>
<br>
</p>
<pre><code >seed = Utilities.automaticLocalSeed(path);
</code></pre><p>
<br>
</p>
<h4>说明</h4><p>
返回由实例的全路径名哈希值自动计算出的种子（整数类型），该路径名需通过Modelica内置操作符<a href=\"https://specification.modelica.org/v3.4/Ch3.html#getinstancename\" target=\"\">getInstanceName()</a>)调用。 与<a href=\"modelica://Modelica.Math.Random.Utilities.automaticGlobalSeed\" target=\"\">automaticGlobalSeed()</a>相反，此函数为纯函数，即在提供相同路径的情况下，始终返回相同的种子值。
</p>
<h4>例子</h4><p>
<br>
</p>
<pre><code >parameter Boolean useAutomaticLocalSeed = true;
parameter Integer fixedLocalSeed        = 10;
final parameter Integer localSeed = if useAutomaticLocalSeed then
                           automaticLocalSeed(getInstanceName())
                         else
                           fixedLocalSeed;
</code></pre><p>
<br>
</p>
<h4>另见</h4><p>
<a href=\"modelica://Modelica.Math.Random.Utilities.automaticGlobalSeed\" target=\"\">automaticGlobalSeed</a>, <a href=\"modelica://Modelica.Utilities.Strings.hashString\" target=\"\">hashString</a> and <a href=\"https://specification.modelica.org/v3.4/Ch3.html#getinstancename\" target=\"\">getInstanceName</a>.
</p>
<p>
<br>
</p>
</html>",revisions="<html>
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
    end automaticLocalSeed;

    function initializeImpureRandom 
      "初始化非纯随机数生成器的内部状态"
      extends Modelica.Icons.Function;
      input Integer seed 
        "初始化非纯随机数生成器的输入种子";
      output Integer id 
        "为了使排序正确，将标识号作为输入传递给函数杂质随机";
    protected
      constant Integer localSeed = 715827883 
        "由于没有本地种子，所以使用较大的素数";
      Integer rngState[33] 
        "非纯随机数生成器的内部状态向量";

    public
      impure function setInternalState 
        "将给定的状态向量存储在外部静态变量中"
        extends Modelica.Icons.Function;
        input Integer[33] rngState "初始状态";
        input Integer id;
        annotation();
        external "C" ModelicaRandom_setInternalState_xorshift1024star(rngState, size(rngState,1), id) 
          annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaRandom.h\"", Library="ModelicaExternalC");
      end setInternalState;

    algorithm
      // 确定内部状态（使用快速生成良好数字的生成器进行多次迭代
      rngState := initialStateWithXorshift64star(localSeed, seed, size(rngState, 1));
      id :=localSeed;

      // 将内部状态复制到内部 C 静态存储器中
      setInternalState(rngState, id);
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
id = <strong>initializeImpureRandom</strong>(seed;
</pre></blockquote>

<h4>Description</h4>

<p>
生成隐藏的初始状态向量
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift1024star\">Xorshift1024star</a>
随机数生成器(= xorshift1024*算法)，从整数输入参数种子。论点的种子
可以给定任何值(包括零或负数)。函数返回
dummy整数id。这个数字需要作为输入传递给函数
<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\">impureRandom</a>,
以便排序顺序正确(以便始终调用杂质随机)
后initializeImpureRandom)。这个函数存储了一个合理的初始状态向量
在c静态内存中使用
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star\">Xorshift64star</a>
随机数生成器用64位随机数填充内部状态向量。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Integer seed;
Real r;
<strong>function</strong> random = impureRandom (<strong>final</strong> id=id);
<strong>protected </strong>
Integer id = initializeImpureRandom(seed);
<strong>equation</strong>
// Use the random number generator
<strong>when</strong> sample(0,0.001) <strong>then</strong>
r = random();
<strong>end when</strong>;
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\">Utilities.impureRandom</a>,
<a href=\"modelica://Modelica.Math.Random.Generators\">Random.Generators</a>
</p>
</html>"                ,     revisions="<html>
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
</html>"                ));
    end initializeImpureRandom;

    impure function impureRandom 
      "不纯随机数生成器(带有隐藏状态向量)"
      extends Modelica.Icons.Function;
      input Integer id 
        "initializeerroranddom(..)函数中的标识号(需要正确排序)";
      output Real y 
        "在区间(0,1)上均匀分布的随机数";
      external "C" y = ModelicaRandom_impureRandom_xorshift1024star(id) 
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaRandom.h\"", Library="ModelicaExternalC");
      annotation(Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
r = <strong>impureRandom</strong>(id);
</pre></blockquote>

<h4>描述</h4>
<p>
返回0 &lt范围内的均匀随机数;随机勒;1使用xorshift1024*算法。
虚拟输入整数参数id必须是函数调用的输出参数
<a href=\"modelica://Modelica.Math.Random.Utilities.initializeImpureRandom\">initializeImpureRandom</a>,
以便排序顺序正确(以便始终调用杂质随机)
后initializeImpureRandom)。对于每次调用errorrandom (id)，一个不同的随机数
返回，因此该函数是非纯函数。
</p>

<h4>例子</h4>
<blockquote><pre>
<strong>parameter</strong> Integer seed;
Real r;
<strong>function</strong> random = impureRandom (<strong>final</strong> id=id);
<strong>protected </strong>
Integer id;
<strong>equation</strong>
// 初始化随机数生成器
<strong>when</strong> initial() <strong>then</strong>
id = initializeImpureRandom(seed, time);
<strong>end when</strong>;

// 使用随机数生成器
<strong>when</strong> sample(0,0.001) <strong>then</strong>
r = random();
<strong>end when</strong>;
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Utilities.initializeImpureRandom\">initializeImpureRandom</a>,
<a href=\"modelica://Modelica.Math.Random.Generators\">Random.Generators</a>
</p>
<h4>备注</h4>
<p>此功能不纯!</p>
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
    end impureRandom;

    impure function impureRandomInteger 
      "整数值的不纯随机数生成器(带隐藏状态向量)"
      extends Modelica.Icons.Function;
      input Integer id 
        "来自 initializeImpureRandom(...) 函数的标识号（正确排序所需的标识号）";
      input Integer imin = 1 "生成的最小整数";
      input Integer imax = 268435456 "生成的最大整数（默认 = 2^28）";
      output Integer y 
        "在区间 [imin,imax] 上均匀分布的随机数";
    protected
      Real r "不纯真实随机数";
    algorithm
      r  := impureRandom(id=id);
      y  := min(imax, integer(r*(imax-imin+1))+imin);
      annotation (Documentation(info="<html>
<h4>语法</h4>
<blockquote><pre>
r = <strong>impureRandomInteger</strong>(id, imin=1, imax=Modelica.Constants.Integer_inf);
</pre></blockquote>

<h4>说明</h4>
<p>
返回一个在imin &le范围内的整数;随机勒;使用xorshift1024*算法的Imax，
(0…范围内的随机数)xorshift1024*算法返回的1被映射到
在imin…范围内的整数。imax)。
虚拟输入整数参数id必须是函数调用的输出参数
<a href=\"modelica://Modelica.Math.Random.Utilities.initializeImpureRandom\">initializeImpureRandom</a>,
以便排序顺序正确(以便始终调用errorandominteger)
后initializeImpureRandom)。对于每次调用errorandominteger (id)，一个不同的随机数
返回，因此该函数是非纯函数。
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.Random.Utilities.initializeImpureRandom\">initializeImpureRandom</a>,
<a href=\"modelica://Modelica.Math.Random.Generators\">Random.Generators</a>
</p>
<h4>备注</h4>
<p>这个函数不纯!</p>
</html>"            , revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>
<tr><td>June 2, 2017</td><td>Correct probabilities - especially for small ranges, by Hans Olsson, <a href=\"https://www.3ds.com\">Dassault Syst&egrave;mes</a></td></tr>
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
    end impureRandomInteger;
  annotation (Documentation(info="<html>
<p>
这个包包含随机数生成器的实用函数，
用户通常不感兴趣
(例如，在<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>中使用它们).
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
  end Utilities;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
        -100},{100,100}}), graphics={
    Ellipse(
      extent={{-84,84},{-24,24}}, 
      fillColor={215,215,215}, 
      fillPattern=FillPattern.Solid), 
    Ellipse(
      extent={{22,62},{82,2}}, 
      fillColor={215,215,215}, 
      fillPattern=FillPattern.Solid), 
    Ellipse(
      extent={{-58,6},{2,-54}}, 
      fillColor={215,215,215}, 
      fillPattern=FillPattern.Solid), 
    Ellipse(
      extent={{26,-30},{86,-90}}, 
      fillColor={215,215,215}, 
      fillPattern=FillPattern.Solid)}), Documentation(info="<html><p>
此包包含用于生成随机数的低级函数。 通常，这个包中的功能不是直接使用的，而是被利用的 作为高级功能的构建块。
</p>
<p>
<a href=\"modelica://Modelica.Math.Random.Generators\" target=\"\">Math.Random.Generators</a> 包含各种伪随机数生成器。这些生成器在区块中使用 <a href=\"modelica://Modelica.Blocks.Noise\" target=\"\">Blocks. Noise</a>产生 可重复噪声信号。 <a href=\"modelica://Modelica.Math.Random.Utilities\" target=\"\">Math.Random.Utilities</a> 包含随机数生成器的实用函数， 用户通常不感兴趣 (例如，它们用于实现中的块) <a href=\"modelica://Modelica.Blocks.Noise\" target=\"\">Blocks.Noise</a>)。
</p>
</html>",revisions="<html>
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
end Random;