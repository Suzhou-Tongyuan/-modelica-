within Modelica.Math;
package FastFourierTransform 
  "快速傅立叶变换 (FFT) 函数库"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  package Examples 
    "演示 Math.FastFourierTransform 函数用法的示例"
    extends Modelica.Icons.ExamplesPackage;

    model RealFFT1 
      "演示在仿真过程中使用FFT计算(并在文件中存储振幅和相位)"
      import Modelica.Constants.pi;
      extends Modelica.Icons.Example;
      parameter SI.Frequency f_max = 4 
        "最高关注频率";
      parameter SI.Frequency f_resolution = 0.2 
        "频率分辨率";
      parameter SI.Frequency f1 = 2 "正弦波频率";
      parameter SI.Frequency f2 = 3 "余弦频率";
      parameter String FFT_resultFileName = "RealFFT1_resultFFT.mat" 
        "文件中的 FFT 将存储为 [f,A,Phi]，其中 f 单位为[Hz]，A 为振幅，Phi 为相位，单位为[rad]。";
      final parameter Integer nfi = max(1,min(integer(ceil(f_max/f_resolution))+1,nf)) 
        "相关频率范围内的频率点数量（仅到 f_max）。";
      final parameter SI.Frequency fi[nfi](each fixed=false) 
        "相关频点的 FFT 频率";
      Real y(final start=0, final fixed=true) 
        "计算 FFT 的信号";
      final output Real Ai[nfi](each start=0, each fixed=true) 
        "相关频点的 FFT 振幅";
      final output Real Phii[nfi](each start=0, each fixed=true) 
        "相关频点的 FFT 相位";
      output Integer info(final start=0, final fixed=true) 
        "FFT 计算的信息标志；= 0：FFT 计算成功";

    protected
      parameter Integer ns = realFFTsamplePoints(f_max, f_resolution, f_max_factor=5)"FFT点数";
      parameter SI.Frequency f_max_FFT = f_resolution*div(ns, 2) 
        "FFT 使用的最大频率";
      parameter Integer nf = div(ns,2) + 1 "频率点数";
      parameter SI.Time Ts = 1/(2*f_max_FFT) "抽样期";
      parameter SI.Time T = (ns - 1)*Ts 
        "一次 FFT 计算的模拟时间";

      Integer iTick(start=0, fixed=true);
      Real y_buf[ns](start=vector([6.5; fill(0, ns - 1)]), each fixed=true);
    initial equation
      for i in 1:nfi loop
         fi[i] = (i-1)*f_resolution;
      end for;

    algorithm
      when sample(0,Ts) then
         iTick :=pre(iTick) + 1;
         y := 5 + 3*sin(2*pi*f1*time) + 1.5*cos(2*pi*f2*time);
         if iTick >= 1 and iTick <= ns then
            y_buf[iTick] := y;
         end if;

         if iTick == ns then
           (info,Ai,Phii) := realFFT(y_buf, nfi);
           Modelica.Math.FastFourierTransform.realFFTwriteToFile(time,FFT_resultFileName,f_max,Ai,Phii);
         end if;
      end when;

      annotation (experiment(StopTime=6), preferredView="text", 
        Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Nov. 29, 2015 </td>
<td>
最初版本由
马丁-R-库恩和马丁-奥特
(<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"                      , 
      info="<html>
<p>
在这个例子中，信号y
</p>

<blockquote><pre>
y = 5 + 3*sin(2*pi*f1) + 1.5*cos(2*pi*f2)
</pre></blockquote>

<p>
采样并从采样信号中计算FFT(默认:f1 = 2hz, f2 = 3hz)。
在公共部分，FFT存储到f_max(内部在保护部分，FFT存储到5*f_max)。
使用f_max (= 4 Hz)和f_resolution (= 0.2 Hz)的默认值，可以获得以下结果:
</p>

<blockquote><pre>
fi[0]  = 0,  Ai[0]  = 5;   // 信号均值
fi[11] = 2,  Ai[11] = 3;   // 正弦的频率/振幅
fi[16] = 3,  Ai[16] = 1.5; // 余弦的频率/振幅
</pre></blockquote>

<p>
得到的FFT图如下图所示:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/FastFourierTransform/FFT1.png\">
</blockquote>

<p>
注意，小振幅的相位(=小于0.0001*maximalAmplitude)被显式设置为零，因为对应的
“phase”是数值噪声(而且会令人困惑)。
此外，请注意FFT相位是相对于cos(…)信号的。
</p>
</html>"                      ));
    end RealFFT1;

    model RealFFT2 
      "演示在仿真期间使用FFT计算的示例(并且仅在文件中存储振幅)"
      import Modelica.Constants.pi;
      extends Modelica.Icons.Example;
      parameter SI.Frequency f_max = 4 
        "最大感兴趣频率";
      parameter SI.Frequency f_resolution = 0.2 
        "频率分辨率";
      parameter SI.Frequency f1 = 2 "正弦频率";
      parameter SI.Frequency f2 = 3 "余弦频率";
      parameter String FFT_resultFileName = "RealFFT2_resultFFT.mat" 
        "文件，其中FFT将存储为[f,A,Phi]，其中f在[Hz]中，A是振幅，Phi在[rad]中是相位";
      final parameter Integer nfi = max(1,min(integer(ceil(f_max/f_resolution))+1,nf)) 
        "感兴趣频率范围的频率点数(仅限f_max)";
      final parameter SI.Frequency fi[nfi](each fixed=false) 
        "感兴趣频率点的FFT频率";
      Real y(final start=0, final fixed=true) 
        "用来计算FFT的信号";
      final output Real Ai[nfi](each start=0, each fixed=true) 
        "感兴趣频率点的FFT幅值";
      output Integer info(final start=0, final fixed=true) 
        "FFT计算的信息标志;= 0: FFT计算成功";

    protected
      parameter Integer ns = realFFTsamplePoints(f_max, f_resolution, f_max_factor=5)"FFT点数";
      parameter SI.Frequency f_max_FFT = f_resolution*div(ns, 2) 
        "FFT使用的最大频率";
      parameter Integer nf = div(ns,2) + 1 "频率点数";
      parameter SI.Time Ts = 1/(2*f_max_FFT) "样品时间";
      parameter SI.Time T = (ns - 1)*Ts 
        "一次FFT计算的仿真时间";

      Integer iTick(start=0, fixed=true);
      Real y_buf[ns](start=vector([6.5; fill(0, ns - 1)]), each fixed=true);
    initial equation
      for i in 1:nfi loop
         fi[i] = (i-1)*f_resolution;
      end for;

    algorithm
      when sample(0,Ts) then
         iTick :=pre(iTick) + 1;
         y := 5 + 3*sin(2*pi*f1*time) + 1.5*cos(2*pi*f2*time);
         if iTick >= 1 and iTick <= ns then
            y_buf[iTick] := y;
         end if;

         if iTick == ns then
           (info,Ai) := realFFT(y_buf, nfi);
           Modelica.Math.FastFourierTransform.realFFTwriteToFile(time,FFT_resultFileName,f_max,Ai);
         end if;
      end when;

      annotation (experiment(StopTime=6), preferredView="text", 
        Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Nov. 29, 2015 </td>
<td>
实现的初始版本
马丁·库恩和马丁·奥特
(<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"          , 
      info="<html>
<p>
这是一个与 <a href=\"modelica://Modelica.Math.FastFourierTransform.Examples.RealFFT1\">Examples.RealFFT1</a>相同的示例。
唯一不同的是，文件中只存储 FFT 的振幅（而不存储相位）。
</p>
</html>"          ));
    end RealFFT2;
    annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Nov. 29, 2015 </td>
  <td>
   Initial version implemented by
   Martin R. Kuhn and Martin Otter
   (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"  ));
  end Examples;

  function realFFTinfo 
    "打印给定f_max和f_resolution的实FFT信息"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams.print;
    input SI.Frequency f_max "最高频率";
    input SI.Frequency f_resolution "频率分辨率";
    input Integer f_max_factor(min=1)=5 
      "最大FFT频率 >= f_max*f_max_factor(采样频率 = 2* 最大 FFT 频率)";
  protected
    Integer ns = realFFTsamplePoints(f_max, f_resolution, f_max_factor);
    Integer nf = div(ns,2)+1;
    SI.Frequency f_max_used = f_resolution*div(ns, 2);
    SI.Frequency fs = f_max_used*2;
    SI.Time Ts= 1/(2*f_max_used) "采样期";
    SI.Time T=(ns - 1)*Ts "FFT计算的模拟时间";
    Integer e2, e3, e5;
    Boolean success;
  algorithm
    (success,e2,e3,e5) :=Internal.prime235Factorization(ns);

    print("\n... Real FFT properties");
    print(" Desired:");
    print("    f_max         = " + String(f_max) + " Hz");
    print("    f_resolution  = " + String(f_resolution) + " Hz");
    print("    f_max_factor  = " + String(f_max_factor));
    print(" Calculated:");
    print("    Number of sample points    = " + String(ns) + " (= 2^"+String(e2)+"*3^"+String(e3)+"*5^"+String(e5)+")");
    print("    Sampling frequency         = " + String(fs) + " Hz (= " + String(f_resolution) + "*" + String(ns) + ")");
    print("    Sampling period            = " + String(Ts) + " s (= " + "1/" + String(fs) + ")");
    print("    Maximum FFT frequency      = " + String(f_max_used) + " Hz (= " + String(f_resolution) + "*" + String(ns) + "/2; " 
                                                                   + "f={0," + String(f_resolution) + "," 
                                                                   + String(2*f_resolution) + ",...," 
                                                                   + String(f_max_used) + "} Hz)");
    print("    Number of frequency points = " + String(nf) + " (= " + String(ns) + "/2+1)");
    print("    Simulation time            = " + String(T) + " s");
    annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Nov. 29, 2015 </td>
  <td>
   最初版本由
   马丁-R-库恩和马丁-奥特
   (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"    , 
        info="<html>
<h4>语法</h4>

<blockquote><pre>
<strong>realFFTinfo</strong>(f_max, f_resolution, f_max_factor=5);
</pre></blockquote>

<h4>说明</h4>
<p>
根据感兴趣的最大频率 f_max（单位 [Hz]）和频率分辨率 f_resolution（单位 [Hz]），函数将计算出 FFT 块使用的关键 FFT 数据，并打印到输出窗口。
函数计算 FFT 块使用的关键 FFT 数据，并将其打印到输出窗口。
</p>

<h4>示例</h4>
<blockquote>
realFFTinfo(f_max=170, f_resolution=0.3)
</blockquote>

<p>
结果输出如下：
</p>

<blockquote><pre>
... Real FFT properties
Desired:
  f_max         = 170 Hz
  f_resolution  = 0.3 Hz
  f_max_factor  = 5
Calculated:
  Number of sample points    = 5760 (= 2^7*3^2*5^1)
  Sampling frequency         = 1728 Hz (= 0.3*5760)
  Sampling period            = 0.000578704 s (= 1/1728)
  Maximum FFT frequency      = 864 Hz (= 0.3*5760/2; f={0,0.3,0.6,...,864} Hz)
  Number of frequency points = 2881 (= 5760/2+1)
  Simulation time            = 3.33275 s
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTsamplePoints\">realFFTsamplePoints</a>,
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFT\">realFFT</a>,
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTwriteToFile\">realFFTwriteToFile</a>
</p>
</html>"    ));
  end realFFTinfo;

  function realFFTsamplePoints "返回实FFT的采样点数"
     extends Modelica.Icons.Function;
     input SI.Frequency f_max "最高关注频率";
     input SI.Frequency f_resolution "频率分辨率";
     input Integer f_max_factor(min=1)=5 
      "最大 FFT 频率 >= f_max*f_max_factor（采样频率 = 2* 最大 FFT 频率）";
     output Integer ns 
      "可表示为 ns = 2^i*3^j*5^k 且 ns 为偶数的样本点数";
  protected
     Integer ns1;
  algorithm
     // 检查输入参数
     assert(f_resolution > 0, "f_resolution > 0 required");
     assert(f_max > f_resolution, "f_max > f_resolution required");

     // 根据 f_max*f_max_factor 和 f_resolution = roundAgainstInfinity(2*f_max*f_max_factor/f_resolution)
     ns1 :=2*integer(ceil(f_max*f_max_factor/f_resolution));

     // 如有必要，可放大 ns1，使其为偶数，并可表示为 2^i*3^j*5^k
     ns :=if mod(ns1, 2) == 0 then ns1 else ns1 + 1;

     while true loop
        ns1 :=ns;
        while mod(ns1,2) == 0 loop ns1 :=div(ns1, 2);end while;
        while mod(ns1,3) == 0 loop ns1 :=div(ns1, 3);end while;
        while mod(ns1,5) == 0 loop ns1 :=div(ns1, 5);end while;

        if ns1 <= 1 then
           break;
        end if;
        ns :=ns + 2;
     end while;
    annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Nov. 29, 2015 </td>
<td>
 最初版本由
 马丁-R-库恩和马丁-奥特
 (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"      , 
      info="<html>
<h4>语法</h4>

<blockquote><pre>
ns = <strong>realFFTsamplePoints</strong>(f_max, f_resolution, f_max_factor=5);
</pre></blockquote>

<h4>说明</h4>
<p>
根据感兴趣的最大频率 f_max（单位 [Hz]）和频率分辨率 f_resolution（单位 [Hz]），函数
函数计算出尽可能少的采样点 ns，并满足以下条件：
</p>

<ul>
<li> 最大 FFT 频率 &ge; f_max_factor*f_max (= 频率向量的最大频率值).</li>
<li> 频率轴分辨率为 f_resolution.</li>
<li> 采样点的数量表示为 2^a*3^b*5^c
 (a、b、c 为适当的整数）.</li>
<li> 采样点数为偶数.</li>
</ul>

<p>
注意，在关于FFT高效计算的原始出版物(Cooley and Tukey, 1965)中，
样本点的个数必须是2^a。然而，所有较新的FFT算法都没有
这种强烈的限制尤其是对开源软件的限制
<a href=\"http://sourceforge.net/projects/kissfft/\">KissFFT</a>来自Mark Borgerding
用于此函数
</p>

<h4>参考文献</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <strong>KissFFT, version 1.3.0</strong>.
 <a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
 <br>&nbsp;
 </dd>

<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <strong>复傅里叶级数机器计算算法</strong>.
 Math. Comput. 19: 297-301. doi:10.2307/2003354.
 <br>&nbsp;
 </dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <strong>飞机系统设计中基于模型的规范</strong>.
 Modelica 2015 Conference, Versailles, France,
 pp. 491-500, Sept.23-25, 2015.
 Download from:
 <a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
 </dd>
</dl>

<h4>示例</h4>
<blockquote>
ns = realFFTinfo(f_max=170, f_resolution=0.3)
</blockquote>

<p>
结果输出如下:
</p>

<blockquote><pre>
ns = 5760
</pre></blockquote>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTinfo\">realFFTinfo</a>,
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFT\">realFFT</a>,
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTwriteToFile\">realFFTwriteToFile</a>
</p>
</html>"      ));
  end realFFTsamplePoints;

  function realFFT "实FFT的返回幅度和相位矢量"
    extends Modelica.Icons.Function;
    input Real  u[:] 
      "需要计算FFT的信号(size(nu,1)必须是偶数，并且应该是2,3,5的整数倍，即size(nu,1) = 2^a*3^b*5^c，其中a,b,c integer >= 0)";
    input Integer nfi 
      "应以幅度和相位返回的频率点数(通常为:nfi = max(1,min(integer(ceil(f_max/f_resolution))+1,nf));最大可能的值是nfi=div(size(u,1)，2)+1)";
    output Integer info 
      "信息标志(0:FFT计算，1:nu不是偶数，3:另一个错误)";
    output Real amplitudes[nfi] "FFT的振幅";
    output Real phases[nfi] "FFT的相位[deg]";
  protected
    Integer nu = size(u,1);
    Integer nf = div(size(u,1),2)+1;
    Real u_DC;
    Real u2[size(u,1)];
    Real A[div(size(u,1),2)+1];
    Real Phi[div(size(u,1),2)+1];
    Real Aeps;
  algorithm
    assert(nfi > 0 and nfi <= div(size(u,1),2)+1, "参数nfi超出了范围");

    u_DC :=sum(u)/nu;
    u2   :=u - fill(u_DC, nu);
    (info, A, Phi) :=Internal.rawRealFFT(u2);
    amplitudes :=A[1:nfi];
    phases :=Modelica.Units.Conversions.to_deg(Phi[1:nfi]);
    Aeps :=0.0001*max(amplitudes);
    amplitudes[1] :=u_DC;
    phases[1] := 0.0;

    // 如果相应的振幅< Aeps (= 0.0001*Amax;=数值噪声)。

    for i in 2:nfi loop
       if amplitudes[i] < Aeps then
          phases[i] :=0.0;
       end if;
    end for;

  annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> Nov. 29, 2015 </td>
  <td>
   Initial version implemented by
   Martin R. Kuhn and Martin Otter
   (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"      , 
      info="<html>
<h4>语法</h4>

<blockquote><pre>
(info, amplitudes, phases) = <strong>realFFT</strong>(u);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数的输入参数是一个实向量u。size(u,1) <strong>必须</strong>是偶数。高效的计算
如果size(u,1) = 2^a*3^b*5^c (a,b,c) Integer &ge;0)。
用函数可以计算出向量u的适当长度
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTsamplePoints\">realFFTsamplePoints</a>。
函数<strong>realFFT</strong>计算u的实FFT(快速傅里叶变换)并返回结果
以输出振幅和相位的形式表示。参数info提供了附加信息:
</p>

<blockquote><pre>
info = 0: 成功的FFT计算。
info = 1: Size (u,1)不是偶数。
info = 3: 另一个错误。
</pre></blockquote>

<p>
注意，在关于FFT高效计算的原始出版物(Cooley and Tukey, 1965)中，
样本点的个数必须是2^a。然而，所有较新的FFT算法都没有
这种强烈的限制尤其是对开源软件的限制
<a href=\"http://sourceforge.net/projects/kissfft/\">KissFFT</a>来自Mark Borgerding
用于此函数。
</p>

<p>
函数返回FFT，使得振幅[1]是u (= sum(u)/size(u,1))的平均值，并且
振幅[i]是正弦函数在第i个频率处的振幅。
</p>

<h4>参考文献</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <strong>KissFFT, version 1.3.0</strong>.
   <a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
   <br>&nbsp;
   </dd>

<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <strong>复傅立叶级数的机器计算算法</strong>.
   Math. Comput. 19: 297-301. doi:10.2307/2003354.
   <br>&nbsp;
   </dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <strong>飞机系统设计中基于模型的规范</strong>.
   Modelica 2015 Conference, Versailles, France,
   pp. 491-500, Sept.23-25, 2015.
   Download from:
   <a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
   </dd>
</dl>

<h4>例子</h4>
<blockquote>
(info, A) = realFFT({0,0.1,0.2,0.4,0.5, 0.6})
</blockquote>

<p>
另见 <a href=\"modelica://Modelica.Math.FastFourierTransform.Examples.RealFFT1\">Examples.RealFFT1</a>
which is a complete example where an FFT is computed during simulation and stored on file.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTinfo\">realFFTinfo</a>,
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTsamplePoints\">realFFTsamplePoints</a>,
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTwriteToFile\">realFFTwriteToFile</a>
</p>
</html>"      ));
  end realFFT;

  function realFFTwriteToFile "将实FFT计算写入文件"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams.print;
    import Modelica.Units.Conversions.to_deg;
    import Modelica.Utilities.Streams.writeRealMatrix;
    input Real t_computed "计算FFT的时间瞬间";
    input String fileName 
      "存储FFT的文件(如果存在，则删除后重新创建)";
    input SI.Frequency f_max "最大频率";
    input Real amplitudes[:] "FFT的振幅";
    input Real phases[:] = fill(0.0, 0) 
      "FFT的相位(要么不提供参数，要么提供与振幅相同长度的矢量)";
    input String format = "4" 
      "MATLAB MAT-file version: \"4\" -> v4, \"6\" -> v6, \"7\" -> v7" 
      annotation(choices(choice = "4" "MATLAB v4 MAT-file", 
      choice = "6" "MATLAB v6 MAT-file", 
      choice = "7" "MATLAB v7 MAT-file"));
    output Boolean success "= true，如果成功";
  protected
    Integer nA = size(amplitudes, 1);
    Real fA[3 * size(amplitudes, 1),if size(phases, 1) == 0 then 2 else 3];
    Real f;
  algorithm
    assert(size(phases, 1) == 0 or size(phases, 1) == size(amplitudes, 1), "Input vector phases has the wrong size");

    // 删除文件(如果存在)
    Modelica.Utilities.Files.removeFile(fileName);

    // 构造输出矩阵
    if size(phases, 1) == size(amplitudes, 1) then
      for i in 1:nA loop
        f := f_max * (i - 1) / (nA - 1);
        //fA[1+3*(i-1):1+3*(i-1)+2,:] :=[f,0,0; f,amplitudes[i],phases[i]; f,0,0];
        fA[1 + 3 * (i - 1),:] := {f, 0, 0};
        fA[1 + 3 * (i - 1) + 1,:] := {f, amplitudes[i], phases[i]};
        fA[1 + 3 * (i - 1) + 2,:] := {f, 0, 0};
      end for;
    else
      for i in 1:nA loop
        f := f_max * (i - 1) / (nA - 1);
        //fA[1+3*(i-1):1+3*(i-1)+2,:] :=[f,0; f,amplitudes[i]; f,0];
        fA[1 + 3 * (i - 1),:] := {f, 0};
        fA[1 + 3 * (i - 1) + 1,:] := {f, amplitudes[i]};
        fA[1 + 3 * (i - 1) + 2,:] := {f, 0};
      end for;
    end if;

    // 将矩阵写入文件并打印信息
    success := writeRealMatrix(fileName, "FFT", fA, format = format);
    if success then
      print("... FFT result computed at time = " + String(t_computed) + " s stored on file: " + Modelica.Utilities.Files.fullPathName(fileName));
    end if;
    annotation(Documentation(info = "<html>
<h4>语法</h4>

<blockquote><pre>
success = <strong>realFFTwriteToFile</strong>(t_computed, fileName, f_max, amplitudes, phases, format);
</pre></blockquote>

<h4>描述</h4>
<p>
这个函数将FFT计算的结果存储在文件中，这样它就可以
很容易绘制。<strong>振幅</strong>和<strong>相位</strong>是保持
振幅和相位值的FFT计算。如果相位矢量的大小为零，
没有阶段将被存储在文件中。否则，相位必须与振幅具有相同的量纲
向量。频率向量f在函数内由的维数构成
振幅矢量和振幅[end]在频率<strong>f_max</strong>处的信息。
<strong>format</strong>参数定义文件格式(详细信息请参见
<a href=\"modelica://Modelica.Utilities.Streams.writeRealMatrix\">writeRealMatrix</a>))。
参数<strong>t_computed</strong>是计算FFT的实际时间。
在结果存储到文件后，在打印消息中使用它。
</p>

<p>
存档的矩阵具有以下结构:
</p>

<ul>
<li> 第一列：等距频率矢量 f，单位为 Hz，从 0 Hz ...f_max Hz.</li>
<li> 第二列：振幅[:]</li>
<li> 可选的第三列：阶段[:]</li>
</ul>

<h4>示例</h4>

<p>
参见详细的示例模型:
<a href=\"modelica://Modelica.Math.FastFourierTransform.Examples.RealFFT1\">Examples.RealFFT1</a>.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTinfo\">realFFTinfo</a>,
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTsamplePoints\">realFFTsamplePoints</a>,
<a href=\"modelica://Modelica.Math.FastFourierTransform.realFFT\">realFFT</a>
</p>
</html>"    ));
  end realFFTwriteToFile;

  package Internal 
    "不应由用户直接使用的内部库"
    extends Modelica.Icons.InternalPackage;
    pure function rawRealFFT "计算原始的快速傅立叶变换为实际信号向量"
      extends Modelica.Icons.Function;
      input Real  u[:] 
        "需要计算FFT的信号(size(nu,1)必须是偶数，并且应该是2,3,5的整数倍，即size(nu,1) = 2^a*3^b*5^c，其中a,b,c integer >= 0)";
      output Integer info 
        "信息标志(0:FFT计算，1:nu不是偶数，2:网络错误，3:另一个错误)";
      output Real amplitudes[div(size(u,1),2)+1] "FFT的振幅";
      output Real phases[    div(size(u,1),2)+1] "FFT的相位";
    protected
      Real work[3*size(u,1) + 2*(div(size(u,1),2)+1)];
      external "C" info = ModelicaFFT_kiss_fftr(u, size(u,1), work, size(work,1), amplitudes, phases) 
                   annotation(IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaFFT.h\"", Library="ModelicaExternalC");
      annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Nov. 29, 2015 </td>
<td>
实现的初始版本
马丁·库恩和马丁·奥特
(<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"            , 
      info="<html>
<h4>语法</h4>

<blockquote><p>
(info, amplitudes, phases) = <strong>rawRealFFT</strong>(u);
</p></blockquote>

<h4>描述</h4>
<p>
原始接口到一个函数的Kiss_FFT包来计算一个真实的FFT，采样信号。
这个函数的输入参数是一个实向量u。size(u,1) <strong>必须</strong>是偶数。高效的计算
如果size(u,1) = 2^a*3^b*5^c (a,b,c) Integer &ge;0)。
该函数计算u的实FFT(快速傅里叶变换)并返回结果
以输出振幅和相位的形式表示。参数info提供了附加信息:
</p>

<blockquote><pre>
info = 0: 成功的FFT计算.
info = 1: size(u,1) 不是偶数.
info = 2: size(work,1) 不正确(=受保护的实用程序数组).
info = 3: 另一个错误.
</pre></blockquote>

<p>
注意，在关于FFT高效计算的原始出版物(Cooley and Tukey, 1965)中，
样本点的个数必须是2^a。然而，所有较新的FFT算法都没有
这种强烈的限制尤其是对开源软件的限制
<<a href=\"http://sourceforge.net/projects/kissfft/\">KissFFT</a> 来自Mark Borgerding
用于此函数。
</p>

<h4>参考文献</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <strong>KissFFT, version 1.3.0</strong>.
<a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
<br>&nbsp;
</dd>

<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <strong>复傅立叶级数的机器计算算法</strong>.
Math. Comput. 19: 297-301. doi:10.2307/2003354.
<br>&nbsp;
</dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <strong>飞机系统设计中基于模型的规范</strong>.
Modelica 2015 Conference, Versailles, France,
pp. 491-500, Sept.23-25, 2015.
Download from:
<a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
</dd>
</dl>

<h4>示例</h4>
<blockquote>
(info, A, phases) = realFFT({0,0.1,0.2,0.4,0.5, 0.6})
</blockquote>
</html>"            ));
    end rawRealFFT;

    function prime235Factorization "将一个整数分解为质因数2、3、5"
      extends Modelica.Icons.Function;
      input Integer n;
      output Boolean success "= true，如果可以分解为2,3,5";
      output Integer e2 "n = 2^e2*3^e3*5^e5";
      output Integer e3 "n = 2^e2*3^e3*5^e5";
      output Integer e5 "n = 2^e2*3^e3*5^e5";
    protected
      Integer ns1 = n;
    algorithm
      e2:=0;
      e3:=0;
      e5:=0;
      while mod(ns1,2) == 0 loop
         ns1 :=div(ns1, 2);
         e2 :=e2 + 1;
      end while;

      while mod(ns1,3) == 0 loop
         ns1 :=div(ns1, 3);
         e3 := e3+1;
      end while;

      while mod(ns1,5) == 0 loop
         ns1 :=div(ns1, 5);
         e5 :=e5 + 1;
      end while;

      success :=ns1 <= 1;
      annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> Nov. 29, 2015 </td>
<td>
实现的初始版本
马丁·库恩和马丁·奥特
(<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"            , 
      info="<html>
<h4>语法</h4>

<blockquote><p>
(success, e2, e3, e5) = <strong>prime235Factorization</strong>(n);
</p></blockquote>

<h4>描述</h4>
<p>
计算输入整数n的质数2、3和5的因数分解。如果这是可能的，那么success = true和
e2是质数的个数s2, e3是质数的个数3,e5是质数的个数5。
如果这是不可能的，success = false，e2, e3, e5是无效值。
</p>

<h4>Example</h4>
<blockquote><pre>
(success, e2, e3, e5) = prime235Factorization(60)   // success=true, e2=2, e3=1, e5=1 (= 2^2*3^1*5^1)
(success, e2, e3, e5) = prime235Factorization(7)    // success=false
</pre></blockquote>
</html>"            ));
    end prime235Factorization;
  annotation (Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">描述</th></tr>

<tr><td> Nov. 29, 2015 </td>
<td>
 实现的初始版本
马丁·库恩和马丁·奥特
 (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"    ));
  end Internal;
annotation (Documentation(info="<html>
<p>
该软件包提供计算快速傅立叶变换 (FFT) 的函数.</p>

<p>
示例见<a href=\"modelica://Modelica.Math.FastFourierTransform.Examples.RealFFT1\">Examples.RealFFT1</a>。
其中在仿真过程中计算了以下信号
</p>

<blockquote><pre>
y = 5 + 3*sin(2*pi*2) + 1.5*cos(2*pi*3)
</pre></blockquote>

<p>
对连续时间信号 y 进行采样，并调用 realFFT(f_max=4, f_resolution=0.2) 计算 FFT、
得出:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/FastFourierTransform/FFT1.png\">
</blockquote>

<h4>参考资料</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <strong>KissFFT, version 1.3.0</strong>.
     <a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
     <br>&nbsp;
     </dd>

<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <strong>复傅里叶级数机器计算算法</strong>.
     Math. Comput. 19: 297-301. doi:10.2307/2003354.
     <br>&nbsp;
     </dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <strong>飞机系统设计中基于模型的规范</strong>.
     Modelica 2015 Conference, Versailles, France,
     pp. 491-500, Sept.23-25, 2015.
     下载:
     <a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
     </dd>
</dl>
</html>", 
      revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>日期</th> <th align=\"left\">说明</th></tr>

<tr><td> Nov. 29, 2015 </td>
    <td>
     最初版本由
     Martin R. Kuhn and Martin Otter
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>.</td></tr>
</table>
</html>"), Icon(graphics={
        Line(points={{-60,20},{-60,-80}}, color={95,95,95}), 
        Line(points={{-20,60},{-20,-80}}, color={95,95,95}), 
        Line(points={{20,40},{20,-80}}, color={95,95,95}), 
        Line(points={{60,-20},{60,-80}}, color={95,95,95})}));
end FastFourierTransform;