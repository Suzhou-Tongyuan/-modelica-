within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
function random "伪随机数生成器"
  extends Modelica.Icons.Function;

  input Integer seedIn[3] 
    "定义随机数序列的整数向量，例如 {23,87,187}";
  output Real x "0到1之间的随机数";
  output Integer seedOut[3] 
    "修改后的种子，用于下一次调用random()";
algorithm
  seedOut[1] := rem((171 * seedIn[1]), 30269);
  seedOut[2] := rem((172 * seedIn[2]), 30307);
  seedOut[3] := rem((170 * seedIn[3]), 30323);
  // 零是一个较差的种子，因此用1替代；
  if seedOut[1] == 0 then
    seedOut[1] := 1;
  end if;
  if seedOut[2] == 0 then
    seedOut[2] := 1;
  end if;
  if seedOut[3] == 0 then
    seedOut[3] := 1;
  end if;
  x := rem((seedOut[1] / 30269.0 + seedOut[2] / 30307.0 + seedOut[3] / 30323.0), 1.0);
  annotation(
    Documentation(info = "<html>
<p>
<em>Random</em> 生成一系列均匀分布的伪随机数。该算法是乘法同余算法的一种变体，称为Wichmann-Hill生成器：</p>
<blockquote><pre>
x(k) = (a1*x(k-1)) mod m1
y(k) = (a2*y(k-1)) mod m2
z(k) = (a3*z(k-1)) mod m3
U(k) = (x(k)/m1 + y(k)/m2 + z(k)/m3) mod 1
</pre></blockquote>
<p>
这会生成在区间 (0,1) 上均匀分布的伪随机数 U(k)。根据参数 m（质数）和 a 的不同，生成器有许多形式。该序列需要一个初始的整数向量 {x,y,z}，即种子。使用相同的种子将产生相同的数字序列。
</p>
<p>
<strong>备注</strong>
</p>
<p>随机数生成器（RNG）是伪函数，不是真正的函数，而是算法，生成一个固定的（通常是整数）数字序列，该序列应该具有很长的周期，直到它开始重复，并且具有合适的统计特性，使得该序列看起来像是随机抽取的。对于实数型随机数，整数会被缩放到实数区间 0.0-1.0。它们会产生一个均匀分布的随机变量，值在 0 到 1 之间，之后需要进行转换才能得到想要的分布的随机变量。转换随机变量的技术有两种：
</p>
<ul>
<li>接受-拒绝技术</li>
<li>转换技术</li>
</ul>
<p>接受-拒绝技术会丢弃一些生成的变量，因此效率较低。并非所有分布都能避免使用这种方法。关于随机数生成和下文使用的大多数转换技术，有一个很好的总结：</p>
 <address> 离散事件仿真 <br>
 Jerry Banks 和 John S. Carson II<br>
 Prentice Hall Inc.<br>
 Englewood Cliffs, New Jersey<br>
 </address>
<p>以下是一些其他引用的参考文献。</p>
<blockquote><pre>
WICHMANN-HILL 随机数生成器
Wichmann, B. A. & Hill, I. D. (1982)
  算法 AS 183:
  一种高效且可移植的伪随机数生成器
  应用统计学 31 (1982) 188-190
另见：
  算法 AS 183 的修正
  应用统计学 33 (1984) 123
McLeod, A. I. (1985)
  对算法 AS 183 的评论
  应用统计学 34 (1985),198-200
为了完全避免外部函数，所有种子都通过参数设置。对于仿真用途，这几乎总是期望的行为。
由 Hubertus Tummescheit 翻译，源自 Guido van Rossum 提供的 Python 代码，翻译自 Adrian Baddeley 提供的 C 代码。
http://www.python.org/doc/current/lib/module-random.html
随机变量生成器
实线上的分布：
------------------------------
    正态（高斯） 2 个版本
</pre></blockquote>
<h4>参考文献</h4>
<ul>
<li>函数 random: Wichmann, B. A. & Hill, I. D. (1982), 算法 AS 183:
  <br>
  一种高效且可移植的伪随机数生成器，应用统计学 31 (1982) 188-190<br>
  另见：算法 AS 183 的修正，应用统计学 33 (1984) 123 <br>
  McLeod, A. I. (1985)，对算法 AS 183 的评论，应用统计学 34 (1985)，198-200</li>
<li>函数 normalvariate: Kinderman, A.J. 和 Monahan, J.F., '使用均匀分布的比率生成随机变量'，ACM 数学软件学报，3，（1977），第257-260页。</li>
<li>函数 gaussianvariate: 离散事件仿真，Jerry Banks 和 John S. Carson II，
<br>
  Prentice Hall Inc. Englewood Cliffs, New Jersey，第315/316页</li>
</ul>
<p>
版权所有 &copy; Hubertus Tummescheit 和瑞典隆德大学自动化控制系。
</p>
<p>
<em>此Modelica函数是<strong>免费</strong>软件；可以根据BSD-3-Clause许可证条款重新分发和/或修改。</em>
</p>
</html>", 
    revisions = "<html>
<p>2019-05-20: 在与Hubertus Tummescheit协商后，将许可证更改为BSD-3-Clause。</p>
</html>"));
end random;