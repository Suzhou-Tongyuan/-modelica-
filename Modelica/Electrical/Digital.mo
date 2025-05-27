within Modelica.Electrical;
package Digital 
  "基于VHDL标准的数字电路元件库，具有9值逻辑和可转换为2值、3值、4值逻辑"

  extends Modelica.Icons.Package;

  package UsersGuide "用户指南"
    extends Modelica.Icons.Information;

    class ReleaseNotes "版本说明"
      extends Modelica.Icons.ReleaseNotes;

      annotation(Documentation(info = "<html>
<h4>版本1.0.8，2009-10-01</h4>
<ul>
<li>增加了带触发器和锁存器的Package Register</li>
<li>增加了InertialDealySensitiveVector</li>
</ul>
<h4>版本1.0.7，2005-07-01</h4>
<ul>
<li>改进了InertialDelaySensitive</li>
<li>在基本模型和延迟模型中修正了次要错误(引入了 final)</li>
<li>重写了Sources.Pulse以避免警告</li>
<li>修正了源的默认值中的次要错误</li>
</ul>
<h4>版本1.0.6，2004-10-18</h4>
<ul>
<li>添加了缺失的HTML标签(修复了pre标签不匹配的问题)。</li>
<li>删除了CVS ID字符串。</li>
</ul>
<h4>版本1.0.5，2004-10-01</h4>
<ul>
<li>修正了HalfAdder示例中的错误标识符x0和Tdel。</li>
<li>删除了FlipFlop示例中的Experiment命令。</li>
<li>已知问题：Pulse源在Dymola中引发警告。建议使用DigitalClock源。</li>
</ul>
<h4>版本1.0.4，2004-09-30</h4>
<ul>
<li>改进了文档。</li>
</ul>
<h4>版本1.0.3，2004-09-21</h4>
<ul>
<li>将表名称从“map”更改为“Table”。</li>
<li>修改了转换器的图标。</li>
<li>将LogicValueType重命名为Logic。对于Electrical.Digital库，类型Logic具有基本意义。Logic类似于其他库中的Real、Integer或Boolean。现在转换器的名称更一致了(LogicToBoolean、RealToLogic等)。</li>
<li>改进了门和源的图标。</li>
<li>添加了新示例。</li>
<li>统一了信号和端口的内部名称。</li>
<li>为方便起见，除了Pulse源外，还添加了简单的DigitalClock源。</li>
</ul>
<h4>版本1.0.2，2004-09-13</h4>
<ul>
<li>为第40届Modelica设计会议的讨论发布的第一个预发布版本。</li>
</ul>
<h4>版本1.0.1，2004-06-01</h4>
<ul>
<li>创建了Tables、Basic和Gates库。</li>
<li>创建了传输和惯性延迟，并已成功测试。</li>
</ul>
<h4>版本1.0.0，2003-05-01</h4>
<ul>
<li>为案例研究创建了第一个版本。</li>
</ul>
</html>"                ));
    end ReleaseNotes;

    class Literature "参考文献"
      extends Modelica.Icons.References;

      annotation(Documentation(info = "<html>
<p>
Electrical.Digital库基于以下参考文献搭建：
</p>
<dl>
<dt>Ashenden, P. J.:</dt>
<dd> <strong>The Designer's Guide to VHDL.</strong> San Francisco: Morgan Kaufmann, 1995, 688 p. ISBN 1-55860-270-4.
<br>&nbsp;</dd>
</dl>
<dl>
<dt>IEEE 1076-1993:</dt>
<dd> <strong>IEEE Standard VHDL Language Reference Manual (ANSI).</strong> 288 p. ISBN 1-55937-376-8. IEEE Ref. SH16840-NYF.
<br>&nbsp;</dd>
</dl>
<dl>
<dt>IEEE 1164-1993:</dt>
<dd> <strong>IEEE Standard Multivalue Logic System for VHDL Model Interoperability (Std_logic_1164).</strong> 24 p. ISBN 1-55937-299-0. IEEE Ref. SH16097-NYF.
<br>&nbsp;</dd>
</dl>
<dl>
<dt>Lipsett, R.; Schaefer, C.; Ussery, C.:</dt>
<dd> <strong>VHDL: Hardware Description and Design.</strong> Boston: Kluwer, 1989, 299 p. ISBN 079239030X.
<br>&nbsp;</dd>
</dl>
<dl>
<dt>Navabi, Z:</dt>
<dd> <strong>VHDL: Analysis and Modeling of Digital Systems.</strong> New York: McGraw-Hill, 1993, 375 p. ISBN 0070464723.
<br>&nbsp;</dd>
</dl>
</html>"      ));

    end Literature;

    class Contact "联系方式"
      extends Modelica.Icons.Contact;

      annotation(Documentation(info = "<html>
<h4>主要作者</h4>

<dl>
<dt><strong>Christoph Clau&szlig;</strong></dt>
<dd>电子邮件：<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a></dd>
<dt><strong>Andr&eacute; Schneider</strong></dt>
<dd>电子邮件：<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a></dd>
<dt><strong>Ulrich Donath</strong></dt>
<dd>电子邮件：<a href=\"mailto:Ulrich.Donath@eas.iis.fraunhofer.de\">Ulrich.Donath@eas.iis.fraunhofer.de</a></dd>
</dl>

<dl>
<dt>地址</dt>
Fraunhofer Institute for Integrated Circuits(IIS)
Design Automation Department(EAS)
Zeunerstraße 38
D-01069 Dresden
Germany
</dl>

<h4>致谢</h4>

<p>
感谢Teresa Schlegel

和EnricoWeber创建和仔细测试了许多模型和示例。
</p>
</html>"        ));

    end Contact;

    annotation(DocumentationClass = true, Documentation(info = "<html>
<p>
电气数字库是一个提供用于方便建模组合逻辑和时序逻辑的数字电子系统组件的<strong>免费</strong>Modelica库。此库包含库的<strong>用户指南</strong>，内容如下：
</p>
<ol>
<li><a href=\"modelica://Modelica.Electrical.Digital.UsersGuide.ReleaseNotes\">发布说明</a>总结了此库不同版本之间的差异。</li>
<li><a href=\"modelica://Modelica.Electrical.Digital.UsersGuide.Literature\">文献</a>提供了设计和实现此库所使用的参考资料。</li>
<li><a href=\"modelica://Modelica.Electrical.Digital.UsersGuide.Contact\">联系方式</a>提供了有关库的作者以及致谢的信息。</li>
</ol>
</html>"    ));
  end UsersGuide;

  package Examples "演示数字电气元件用法的示例"
    extends Modelica.Icons.ExamplesPackage;

    model Multiplexer "4到1位多路复用器示例"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      D.Sources.DigitalClock CLK(period = 20, startTime = 0, width = 50) annotation(Placement(transformation(
        extent = {{-80, -56}, {-60, -36}})));
      D.Sources.Table D0(
        y0 = L.'0', 
        x = {L.'1', L.'0', L.'1', L.'0'}, 
        t = {50, 100, 145, 200}) annotation(Placement(transformation(extent = {{-80, 58}, 
        {-60, 78}})));
      D.Sources.Table D1(
        y0 = L.'0', 
        x = {L.'1', L.'0', L.'1', L.'0'}, 
        t = {22, 140, 150, 180}) annotation(Placement(transformation(extent = {{-80, 32}, 
        {-60, 52}})));
      D.Examples.Utilities.MUX4 MUX annotation(Placement(transformation(extent = {{-10, 0}, 
        {70, 80}})));
      D.Sources.Table D2(
        y0 = L.'0', 
        x = {L.'1', L.'0', L.'1', L.'0'}, 
        t = {22, 140, 150, 180}) annotation(Placement(transformation(extent = {{-80, 6}, 
        {-60, 26}})));
      D.Sources.Table D3(
        y0 = L.'0', 
        x = {L.'1', L.'0', L.'1', L.'0'}, 
        t = {22, 140, 150, 180}) annotation(Placement(transformation(extent = {{-80, -20}, 
        {-60, 0}})));
      D.Examples.Utilities.JKFF FF annotation(Placement(transformation(extent = {{-20, -62}, 
        {0, -42}})));
      D.Sources.Set Enable(x = Modelica.Electrical.Digital.Interfaces.Logic.'1') annotation(Placement(transformation(extent = {{-80, -82}, 
        {-60, -62}})));
    equation
      connect(CLK.y, FF.clk) annotation(Line(
        points = {{-60, -46}, {-36, -46}, {-36, -52}, {-20, -52}}, color = {127, 0, 127}));
      connect(Enable.y, FF.k) annotation(Line(
        points = {{-60, -72}, {-30, -72}, {-30, -59}, {-20, -59}}, color = {127, 0, 127}));
      connect(Enable.y, FF.j) annotation(Line(
        points = {{-60, -72}, {-30, -72}, {-30, -45}, {-20, -45}}, color = {127, 0, 127}));
      connect(CLK.y, MUX.a0) annotation(Line(
        points = {{-60, -46}, {-36, -46}, {-36, 22.4}, {-10, 22.4}}, color = {127, 0, 127}));
      connect(D0.y, MUX.d0) annotation(Line(
        points = {{-60, 68}, {-10, 68}}, color = {127, 0, 127}));
      connect(D1.y, MUX.d1) annotation(Line(
        points = {{-60, 42}, {-54, 42}, {-54, 57.6}, {-10, 57.6}}, color = {127, 0, 127}));
      connect(D2.y, MUX.d2) annotation(Line(
        points = {{-60, 16}, {-50, 16}, {-50, 47.2}, {-10, 47.2}}, color = {127, 0, 127}));
      connect(D3.y, MUX.d3) annotation(Line(
        points = {{-60, -10}, {-46, -10}, {-46, 36.8}, {-10, 36.8}}, color = {127, 0, 127}));
      connect(FF.q, MUX.a1) annotation(Line(
        points = {{0, -45}, {2, -45}, {2, -22}, {-20, -22}, {-20, 12}, {-10, 12}}, color = {127, 0, 127}));
      annotation(
    Documentation(info = "<html>
<p>多路复用器将并行的4位信号转换为串行的1位流。多路复用器组件由基本门组成。它可以在Utilities子库中找到。此示例旨在测试和演示基本门组件。</p>
</html>"    ), experiment(StopTime = 250));


    end Multiplexer;

    model FlipFlop "脉冲触发的主从触发器"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      D.Examples.Utilities.JKFF FF 
        annotation(Placement(transformation(extent = {{-10, -40}, {70, 
        40}})));
      D.Sources.DigitalClock CLK(period = 10, startTime = 0, width = 50) annotation(Placement(transformation(
        extent = {{-80, -10}, {-60, 10}})));
      D.Sources.Table J(
        y0 = L.'0', 
        x = {L.'1', L.'0', L.'1', L.'0'}, 
        t = {50, 100, 145, 200}) annotation(Placement(transformation(extent = {{-80, 
        18}, {-60, 38}})));
      D.Sources.Table K(
        y0 = L.'0', 
        x = {L.'1', L.'0', L.'1', L.'0'}, 
        t = {22, 140, 150, 180}) annotation(Placement(transformation(extent = {{-80, 
        -38}, {-60, -18}})));
    equation
      connect(J.y, FF.j) annotation(Line(
        points = {{-60, 28}, {-10, 28}}, color = {127, 0, 127}));
      connect(CLK.y, FF.clk) annotation(Line(
        points = {{-60, 0}, {-10, 0}}, color = {127, 0, 127}));
      connect(K.y, FF.k) annotation(Line(
        points = {{-60, -28}, {-10, -28}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>该示例展示了一个脉冲触发的主从触发器。触发器组件由基本门组成。它可以在Utilities子库中找到。此示例旨在测试和演示基本门组件。</p>
</html>"    ), experiment(StopTime = 250));
    end FlipFlop;

    model HalfAdder "用于二进制数的加法电路，不带输入进位位"
      import Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table a(
        t = {1, 2, 3, 4}, 
        x = {L.'1', L.'0', L.'1', L.'0'}, 
        y0 = L.'0') annotation(Placement(transformation(extent = {{-80, 18}, {-60, 38}})));
      Modelica.Electrical.Digital.Sources.Table b(
        x = {L.'1', L.'0'}, 
        t = {2, 4}, 
        y0 = L.'0') annotation(Placement(transformation(extent = {{-80, -38}, {-60, -18}})));
      Modelica.Electrical.Digital.Examples.Utilities.HalfAdder Adder(delayTime = 0.3, AND(G2(
        y(start = L.'U', fixed = true))), 
        XOR(G2(y(start = L.'U', fixed = true)))) 
        annotation(Placement(transformation(extent = {{-40, 
        -40}, {40, 40}})));
      Modelica.Electrical.Digital.Converters.LogicToReal s(
        n = 1, 
        value_U = 0.5, 
        value_X = 0.5, 
        value_0 = 0, 
        value_1 = 1, 
        value_Z = 0.5, 
        value_W = 0.5, 
        value_L = 0, 
        value_H = 1, 
        value_m = 0.5) annotation(Placement(transformation(extent = {{60, 
        18}, {80, 38}})));
      Modelica.Electrical.Digital.Converters.LogicToReal c(
        n = 1, 
        value_U = 0.5, 
        value_X = 0.5, 
        value_0 = 0, 
        value_1 = 1, 
        value_Z = 0.5, 
        value_W = 0.5, 
        value_L = 0, 
        value_H = 1, 
        value_m = 0.5) annotation(Placement(transformation(extent = {{60, 
        -38}, {80, -18}})));
    equation
      connect(b.y, Adder.b) annotation(Line(
        points = {{-60, -28}, {-40, -28}}, color = {127, 0, 127}));
      connect(a.y, Adder.a) annotation(Line(
        points = {{-60, 28}, {-40, 28}}, color = {127, 0, 127}));
      connect(Adder.s, s.x[1]) annotation(Line(points = {{40, 28}, {65, 28}}, color = {127, 0, 127}));
      connect(Adder.c, c.x[1]) annotation(Line(points = {{40, -28}, {65, -28}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>
这个例子演示了一个用于二进制数的加法电路，它在内部实现了与门和异或门的连接以得到最终的和。</p>
<br>
<br>
1 + 0 = 1<br>
0 + 1 = 1<br>
1 + 1 = 10<br>
0 + 0 = 0
<br>
<br>
<strong>a</strong>+<strong>b</strong>=<strong>s</strong>
<br>(此加法的进位为<strong>c</strong>。)
<br>
<br>和
<br>
<br>
<strong>a</strong>*<strong>b</strong>=<strong>s</strong>
<br>  (它是一个与门的连接。)
<br>
<br>
<strong>a</strong>*<strong>b</strong>+<strong>a</strong>*<strong>b</strong>=<strong>a</strong>异或<strong>b</strong>=<strong>c</strong>
<br>(它是一个异或门的连接。)
<br>
<blockquote><pre>
<strong>a</strong>     <strong>b</strong>     <strong>c</strong>      <strong>s</strong>     <strong>t</strong>

1     0     1      0     1
0     1     1      0     2
1     1     0      1     3
0     0     0      0     4
</pre></blockquote>
<p>
<strong>t</strong>是模拟中下一位的捕获时刻。
模拟停止时间应为5秒。
</p>
</html>"              ), experiment(StopTime = 5));
    end HalfAdder;

    model FullAdder "全加器示例"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      D.Examples.Utilities.FullAdder Adder1 annotation(Placement(
        transformation(extent = {{0, -30}, {60, 30}})));
      D.Converters.LogicToReal s(value_0 = 0, value_1 = 1, value_H = 1, value_L = 0, value_m = 0.5, value_U = 0.5, value_W = 0.5, value_X = 0.5, value_Z = 0.5, n = 1) 
        annotation(Placement(transformation(extent = {{70, 
        12}, {90, 32}})));
      D.Converters.LogicToReal c_out(value_0 = 0, value_1 = 1, value_H = 1, value_L = 0, value_m = 0.5, value_U = 0.5, value_W = 0.5, value_X = 0.5, value_Z = 0.5, n = 1) 
        annotation(Placement(transformation(extent = 
        {{70, -32}, {90, -12}})));
      D.Examples.Utilities.Counter3 Counter 
        annotation(Placement(transformation(extent = {{-60, -18}, {-20, 22}})));
      D.Sources.Set Enable(x = L.'1') annotation(Placement(transformation(
        extent = {{-90, 6}, {-70, 26}})));
      D.Sources.DigitalClock CLK(period = 1, startTime = 0, width = 50) annotation(Placement(transformation(extent = {{
        -90, -22}, {-70, -2}})));
    equation
      connect(Adder1.s, s.x[1]) 
        annotation(Line(points = {{60.3, 21}, {68, 21}, {68, 
        22}, {75, 22}}, color = {127, 0, 127}));
      connect(Adder1.c_out, c_out.x[1]) 
        annotation(Line(points = {{60, -21}, {68, 
        -21}, {68, -22}, {75, -22}}, color = {127, 0, 127}));
      connect(CLK.y, Counter.count) annotation(Line(points = {{-70, -12}, {-60, -12}}, color = {127, 0, 127}));
      connect(Enable.y, Counter.enable) annotation(Line(points = {{-70, 16}, {-60, 
        16}}, color = {127, 0, 127}));
      connect(Counter.q2, Adder1.a) annotation(Line(points = {{-20, 16}, {-10, 16}, 
        {-10, 21}, {0, 21}}, color = {127, 0, 127}));
      connect(Counter.q1, Adder1.b) annotation(Line(points = {{-20, 2}, {-10, 2}, {
        -10, 9}, {0, 9}}, color = {127, 0, 127}));
      connect(Counter.q0, Adder1.c_in) annotation(Line(points = {{-20, -12}, {-10, 
        -12}, {-10, -21}, {0, -21}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>
<br>这是一个带有输入进位位的二进制数的加法电路，由两个HalfAdders组成。
<br>
<br>
<strong>a</strong>.y，<strong>b</strong>.y和<strong>c</strong>.y是FullAdder的输入。
<br>
<strong>c</strong>out=<strong>Or1</strong>.y和<strong>h</strong>.s是FullAdder的输出。
<br>
<br>
<strong>t</strong>是模拟中下一位的捕获时刻。</p>
<blockquote><pre>
<strong>a</strong>.y      <strong>b</strong>.y     <strong>c</strong>.y      <strong>c</strong>out       <strong>h</strong>.s        <strong>t</strong>

1        0        0        0          1        1
0        1        0        0          1        2
0        0        1        0          1        3
1        1        0        1          0        4
0        1        1        1          0        5
1        0        1        1          0        6
1        1        1        1          1        7
0        0        0        0          0        8
</pre></blockquote>
<p>
模拟停止时间应为10秒。
</p>
</html>"          ), experiment(StopTime = 10));
    end FullAdder;

    model Adder4 "4位加法器示例"
      import Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;

      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table b4(
        y0 = L.'0', 
        x = {L.'1', L.'0'}, 
        t = {1, 3}) annotation(Placement(transformation(extent = {{70, -20}, {110, 20}})));
      Modelica.Electrical.Digital.Sources.Table b1(
        x = {L.'1', L.'0', L.'1'}, 
        y0 = L.'0', 
        t = {1, 2, 3}) annotation(Placement(transformation(extent = {{-170, -20}, {
        -130, 20}})));
      Modelica.Electrical.Digital.Sources.Table b2(
        y0 = L.'0', 
        x = {L.'1'}, 
        t = {4}) annotation(Placement(transformation(extent = {{-90, -20}, {-50, 20}})));
      Modelica.Electrical.Digital.Sources.Table b3(
        y0 = L.'0', 
        x = {L.'1'}, 
        t = {1}) annotation(Placement(transformation(extent = {{-10, -20}, {30, 20}})));
      Modelica.Electrical.Digital.Sources.Table a1(
        y0 = L.'0', 
        x = {L.'1', L.'0', L.'1'}, 
        t = {1, 2, 3}) annotation(Placement(transformation(extent = {{-170, 40}, {-130, 
        80}})));
      Modelica.Electrical.Digital.Sources.Table a2(
        y0 = L.'0', 
        x = {L.'1'}, 
        t = {1}) annotation(Placement(transformation(extent = {{-90, 40}, {-50, 80}})));
      Modelica.Electrical.Digital.Sources.Table a3(
        y0 = L.'0', 
        x = {L.'1', L.'0'}, 
        t = {1, 4}) annotation(Placement(transformation(extent = {{-8, 40}, {30, 80}})));
      Modelica.Electrical.Digital.Sources.Table a4(
        y0 = L.'0', 
        x = {L.'0'}, 
        t = {1}) annotation(Placement(transformation(extent = {{70, 40}, {110, 80}})));
      Modelica.Electrical.Digital.Sources.Set Set(x = L.'0') 
        annotation(Placement(transformation(
        origin = {-150, -74}, 
        extent = {{20, 20}, {-20, -20}}, 
        rotation = 180)));
      Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder1(Adder1(AND(G2(
        y(start = L.'U', fixed = true))), XOR(G2(y(start = L.'U', fixed = true)))), Adder2(AND(G2(
        y(start = L.'U', fixed = true))), XOR(G2(y(start = L.'U', fixed = true))))) 
        annotation(Placement(transformation(extent = 
        {{-100, -80}, {-60, -40}})));
      Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder2(Adder1(AND(G2(
        y(start = L.'U', fixed = true))), XOR(G2(y(start = L.'U', fixed = true)))), Adder2(AND(G2(
        y(start = L.'U', fixed = true))), XOR(G2(y(start = L.'U', fixed = true))))) 
        annotation(Placement(transformation(extent = {
        {-20, -80}, {20, -40}})));
      Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder3(Adder1(AND(G2(
        y(start = L.'U', fixed = true))), XOR(G2(y(start = L.'U', fixed = true)))), Adder2(AND(G2(
        y(start = L.'U', fixed = true))), XOR(G2(y(start = L.'U', fixed = true))))) 
        annotation(Placement(transformation(extent = {
        {60, -80}, {100, -40}})));
      Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder4(Adder1(AND(G2(
        y(start = L.'U', fixed = true))), XOR(G2(y(start = L.'U', fixed = true)))), Adder2(AND(G2(
        y(start = L.'U', fixed = true))), XOR(G2(y(start = L.'U', fixed = true))))) 
        annotation(Placement(transformation(extent = {
        {140, -80}, {180, -40}})));
    equation
      connect(b1.y, Adder1.b) annotation(Line(
        points = {{-130, 0}, {-120, 0}, {-120, -54}, {-100, -54}}, color = {127, 0, 127}));
      connect(a1.y, Adder1.a) annotation(Line(
        points = {{-130, 60}, {-110, 60}, {-110, -46}, {-100, -46}}, color = {127, 0, 127}));
      connect(Set.y, Adder1.c_in) annotation(Line(
        points = {{-130, -74}, {-100, -74}}, color = {127, 0, 127}));
      connect(Adder1.c_out, Adder2.c_in) annotation(Line(
        points = {{-60, -74}, {-20, -74}}, color = {127, 0, 127}));
      connect(Adder2.c_out, Adder3.c_in) annotation(Line(
        points = {{20, -74}, {60, -74}}, color = {127, 0, 127}));
      connect(Adder3.c_out, Adder4.c_in) annotation(Line(
        points = {{100, -74}, {140, -74}}, color = {127, 0, 127}));
      connect(b2.y, Adder2.b) annotation(Line(
        points = {{-50, 0}, {-40, 0}, {-40, -54}, {-20, -54}}, color = {127, 0, 127}));
      connect(a2.y, Adder2.a) annotation(Line(
        points = {{-50, 60}, {-30, 60}, {-30, -46}, {-20, -46}}, color = {127, 0, 127}));
      connect(b3.y, Adder3.b) annotation(Line(
        points = {{30, 0}, {40, 0}, {40, -54}, {60, -54}}, color = {127, 0, 127}));
      connect(a3.y, Adder3.a) annotation(Line(
        points = {{30, 60}, {50, 60}, {50, -46}, {60, -46}}, color = {127, 0, 127}));
      connect(b4.y, Adder4.b) annotation(Line(
        points = {{110, 0}, {120, 0}, {120, -54}, {140, -54}}, color = {127, 0, 127}));
      connect(a4.y, Adder4.a) annotation(Line(
        points = {{110, 60}, {130, 60}, {130, -46}, {140, -46}}, color = {127, 0, 127}));
      annotation(
        Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})), 
        Documentation(info = "<html>
<p>
四个FullAdder被组合成一个四位加法器单元。
</p>
<br>
<br>
根据时间的不同，进行了五次加法运算：
<br>
<blockquote><pre>
在t=0时                            在t=1时
a       0 0 0 0                       a      1 1 1 0
b    +  0 0 0 0                       b   +  1 0 1 1
<strong>s     0 0 0 0 0</strong>                      <strong>s     1 0 0 1 0</strong>
在t=2时                             在t=3时
a       0 1 1 0                       a      1 1 1 0
b    +  0 0 1 1                       b   +  1 0 1 0
<strong>s     1 0 1 0 0</strong>                      <strong>s     0 0 0 1 1</strong>

在t=4时
a      1 1 0 0
b   +  1 1 1 0
<strong>s    0 0 1 0 1</strong>
</pre></blockquote>
<p>
为了显示延迟的影响，选择了较大的延迟时间为0.1秒。
此外，所有信号都使用未初始化值 U 进行初始化。
请记住，这九个逻辑值由数字 1,...,9 编码。
被加数 a 和 b 可以在 taba 和 tabb 源的输出信号中找到。
结果可以在 FullAdders 的输出信号中看到，如下所示：</p>
<blockquote><pre>
a                    <strong>a4</strong>.y      <strong>a3</strong>.y      <strong>a2</strong>.y      <strong>a1</strong>.y
b                    <strong>b4</strong>.y      <strong>b3</strong>.y      <strong>b2</strong>.y      <strong>b1</strong>.y
sum   <strong>Adder4</strong>.c_out  <strong>Adder4.s</strong>  <strong>Adder3.s</strong>  <strong>Adder2.s</strong>  <strong>Adder1.s</strong>
</pre></blockquote>
<p>模拟停止时间必须为5秒。</p>
</html>"              ), experiment(StopTime = 5));
    end Adder4;

    model Counter3 "3位计数器示例"
      import D = Modelica.Electrical.Digital;
      extends Modelica.Icons.Example;

      D.Sources.Step Enable(after = D.Interfaces.Logic.'1', before = D.Interfaces.Logic.'0', stepTime = 1) annotation(Placement(transformation(extent = {
        {-90, 8}, {-50, 48}})));
      D.Sources.DigitalClock clock(period = 1, startTime = 0, width = 50) annotation(Placement(transformation(extent = {
        {-90, -48}, {-50, -8}})));
      D.Examples.Utilities.Counter3 Counter 
        annotation(Placement(transformation(extent = {{-30, -40}, {50, 40}})));
    equation
      connect(Enable.y, Counter.enable) annotation(Line(
        points = {{-50, 28}, {-30, 28}}, color = {127, 0, 127}));
      connect(clock.y, Counter.count) annotation(Line(
        points = {{-50, -28}, {-30, -28}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>这个三位计数器示例由Utilities库的组件构成，该包使用了Gates库的组件。</p>
<p>如果使能信号被设置为true，计数器将计算时钟信号的高低沿。否则，如果设置为零，则计数器不计数。</p>
<p>用户可以在特定界面绘制以下结果变量的图像：Counter.count(时钟信号)，Counter.enable，以及输出位信号Counter.q0，Counter.q1和Counter.q2。</p>
</html>"              ), experiment(StopTime = 10));
    end Counter3;

    model Counter "通用N位计数器示例"
      import D = Modelica.Electrical.Digital;
      extends Modelica.Icons.Example;

      D.Sources.Step Enable(after = D.Interfaces.Logic.'1', before = D.Interfaces.Logic.'0', stepTime = 1) annotation(Placement(transformation(extent = {
        {-90, 8}, {-50, 48}})));
      D.Sources.DigitalClock clock(period = 1, startTime = 0, width = 50) annotation(Placement(transformation(extent = {
        {-90, -48}, {-50, -8}})));
      D.Examples.Utilities.Counter Counter(n = 4) 
        annotation(Placement(transformation(extent = {{-30, -40}, {50, 40}})));
      D.Converters.LogicToReal Q0(value_0 = 0, value_1 = 1, value_H = 1, value_L = 0, value_m = 0.5, value_U = 0.5, value_W = 0.5, value_X = 0.5, value_Z = 0.5, n = 1) annotation(Placement(transformation(extent = {
        {66, -40}, {86, -20}})));
      D.Converters.LogicToReal Q1(value_0 = 0, value_1 = 1, value_H = 1, value_L = 0, value_m = 0.5, value_U = 0.5, value_W = 0.5, value_X = 0.5, value_Z = 0.5, n = 1) annotation(Placement(transformation(extent = {
        {66, -20}, {86, 0}})));
      D.Converters.LogicToReal Q2(value_0 = 0, value_1 = 1, value_H = 1, value_L = 0, value_m = 0.5, value_U = 0.5, value_W = 0.5, value_X = 0.5, value_Z = 0.5, n = 1) annotation(Placement(transformation(extent = {
        {66, 0}, {86, 20}})));
      D.Converters.LogicToReal Q3(value_0 = 0, value_1 = 1, value_H = 1, value_L = 0, value_m = 0.5, value_U = 0.5, value_W = 0.5, value_X = 0.5, value_Z = 0.5, n = 1) annotation(Placement(transformation(extent = {
        {66, 20}, {86, 40}})));
    equation
      connect(Enable.y, Counter.enable) annotation(Line(
        points = {{-50, 28}, {-30, 28}}, color = {127, 0, 127}));
      connect(clock.y, Counter.count) annotation(Line(
        points = {{-50, -28}, {-30, -28}}, color = {127, 0, 127}));
      connect(Q0.x[1], Counter.q[1]) annotation(Line(points = {{71, -30}, {58, -30}, 
        {58, -24}, {50, -24}}, color = {127, 0, 127}));
      connect(Q1.x[1], Counter.q[2]) annotation(Line(points = {{71, -10}, {60, -10}, 
        {60, -8}, {50, -8}}, color = {127, 0, 127}));
      connect(Q2.x[1], Counter.q[3]) annotation(Line(points = {{71, 10}, {60, 10}, {
        60, 8}, {50, 8}}, color = {127, 0, 127}));
      connect(Q3.x[1], Counter.q[4]) annotation(Line(points = {{71, 30}, {60, 30}, {
        60, 24}, {50, 24}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>计数器示例由Utilities库的组件构成，该库使用了Gates库的组件。它演示了通用计数器模型。参数n是计数位的数量。在本例中设置为4。</p>
<p>如果使能信号被设置为true，计数器将计算时钟信号的高低沿。否则，如果设置为零，则计数器不计数。</p>
<p>用户可以在特定界面绘制以下变量的图像：Counter.count(时钟信号)，Counter.enable，以及输出位信号Counter.q[0]、Counter.q[1]、Counter.q[2]和Counter.q[3]</p>
</html>"          ), experiment(StopTime = 100));
    end Counter;

    model VectorDelay "向量延迟"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Delay.InertialDelaySensitiveVector delay(
        final tHL = 1, 
        final tLH = 2, 
        final n = 3, inertialDelaySensitive(each y(start = L.'U', fixed = true))) 
        annotation(Placement(transformation(extent = {{-36, -28}, {40, 48}})));
      Modelica.Electrical.Digital.Sources.Table table(x = {L.'0', L.'1', L.'0', L.'1', L.'0'}, t = {0, 1, 5, 7, 8}) 
        annotation(Placement(transformation(extent = {{-96, 40}, {-76, 60}})));
      Modelica.Electrical.Digital.Sources.Table table1(x = {L.'0', L.'1'}, t = {0, 1}) 
        annotation(Placement(transformation(extent = {{-96, 0}, {-76, 20}})));
      Modelica.Electrical.Digital.Sources.Table table2(x = {L.'0', L.'1', L.'0'}, t = {0, 1, 6}) 
        annotation(Placement(transformation(extent = {{-96, -50}, {-76, -30}})));
    equation

      connect(table.y, delay.x[1]) annotation(Line(
        points = {{-76, 50}, {-30.68, 50}, {-30.68, 6.13667}}, color = {127, 0, 127}));
      connect(table1.y, delay.x[2]) annotation(Line(
        points = {{-76, 10}, {-30.68, 10}, {-30.68, 9.81}}, color = {127, 0, 127}));
      connect(table2.y, delay.x[3]) annotation(Line(
        points = {{-76, -40}, {-30.68, -40}, {-30.68, 13.4833}}, color = {127, 0, 127}));
      annotation(Documentation(info = "<html>
<p>这个示例是对向量值敏感延迟组件的简单测试。延迟时间选择不同。为了检查结果，请绘制输入向量x和输出向量y。</p>
</html>"      ), 
        experiment(StopTime = 10));
    end VectorDelay;

    model DFFREG "脉冲触发的D寄存器组，高有效复位"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table clock(x = {L.'0', L.'1', L.'0', L.'1', L.'0', L.'1', L.'0'}, t = {0, 7, 8, 10, 11, 15, 16}) 
        annotation(Placement(transformation(extent = {{-86, -32}, {-66, -12}})));
      Modelica.Electrical.Digital.Sources.Table data_0(x = {L.'1', L.'0'}, t = {0, 12}) 
        annotation(Placement(transformation(extent = {{-86, 8}, {-66, 28}})));
      Modelica.Electrical.Digital.Sources.Table reset(x = {L.'0', L.'1', L.'0'}, t = {0, 1, 2}) 
        annotation(Placement(transformation(extent = {{-86, -70}, {-66, -50}})));
      Modelica.Electrical.Digital.Sources.Table data_1(t = {0, 10}, x = {L.'H', L.'X'}) 
        annotation(Placement(transformation(extent = {{-86, 40}, {-66, 60}})));
      Modelica.Electrical.Digital.Registers.DFFREG dFFREG(
        n = 2, 
        tHL = 5, 
        tLH = 6, 
        delay(inertialDelaySensitive(each y(start = L.'U', fixed = true))), 
        dFFR(clock(start = L.'U', fixed = true), reset(start = L.'U', fixed = true))) 
        annotation(Placement(transformation(extent = {{-24, -26}, {70, 68}})));

    equation
      connect(clock.y, dFFREG.clock) annotation(Line(
        points = {{-66, -22}, {-46, -22}, {-46, 11.6}, {-20.24, 11.6}}, color = {127, 0, 127}));
      connect(reset.y, dFFREG.reset) annotation(Line(
        points = {{-66, -60}, {-20.24, -60}, {-20.24, -7.2}}, color = {127, 0, 127}));
      connect(data_0.y, dFFREG.dataIn[1]) annotation(Line(
        points = {{-66, 18}, {-44, 18}, {-44, 37.92}, {-20.24, 37.92}}, color = {127, 0, 127}));
      connect(data_1.y, dFFREG.dataIn[2]) annotation(Line(
        points = {{-66, 50}, {-44, 50}, {-44, 41.68}, {-20.24, 41.68}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 25), 
        Documentation(info = "<html>
<p>这个示例是对Registers.DFFREG组件的简单测试。数据宽度设置为两个。在模拟之后用户可以在特定界面绘制dataIn和dataOut向量。为了验证结果，用户可以比较在DFFREG组件中记录的真值表。</p>
</html>"          ));
    end DFFREG;

    model DFFREGL "脉冲触发的D寄存器组，低有效复位"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table clock(x = {L.'0', L.'1', L.'0', L.'1', L.'0', L.'1', L.'0'}, t = {0, 7, 8, 10, 11, 15, 16}) 
        annotation(Placement(transformation(extent = {{-86, -30}, {-66, -10}})));
      Modelica.Electrical.Digital.Sources.Table data_0(x = {L.'1', L.'0'}, t = {0, 12}) 
        annotation(Placement(transformation(extent = {{-88, 10}, {-68, 30}})));
      Modelica.Electrical.Digital.Sources.Table reset(t = {0, 1, 2}, x = {L.'1', L.'0', L.'1'}) 
        annotation(Placement(transformation(extent = {{-86, -70}, {-66, -50}})));
      Modelica.Electrical.Digital.Sources.Table data_1(t = {0, 10}, x = {L.'H', L.'X'}) 
        annotation(Placement(transformation(extent = {{-86, 40}, {-66, 60}})));
      Modelica.Electrical.Digital.Registers.DFFREGL dFFREGL(
        n = 2, 
        tHL = 5, 
        tLH = 6, delay(inertialDelaySensitive(each y(start = L.'U', fixed = true))), 
        dFFR(clock(start = L.'U', fixed = true), reset(start = L.'U', fixed = true))) 
        annotation(Placement(transformation(extent = {{-41, -39}, {62, 65}})));
    equation

      connect(reset.y, dFFREGL.reset) annotation(Line(
        points = {{-66, -60}, {-36.88, -60}, {-36.88, -18.2}}, color = {127, 0, 127}));
      connect(clock.y, dFFREGL.clock) annotation(Line(
        points = {{-66, -20}, {-62, -20}, {-62, 2.6}, {-36.88, 2.6}}, color = {127, 0, 127}));
      connect(data_0.y, dFFREGL.dataIn[1]) annotation(Line(
        points = {{-68, 20}, {-52, 20}, {-52, 31.72}, {-36.88, 31.72}}, color = {127, 0, 127}));
      connect(data_1.y, dFFREGL.dataIn[2]) annotation(Line(
        points = {{-66, 50}, {-52, 50}, {-52, 35.88}, {-36.88, 35.88}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 25), 
        Documentation(info = "<html>
<p>这个示例是对Registers.DFFREGL组件的简单测试。数据宽度设置为两个。在模拟后，用户可以在特定窗口绘制dataIn和dataOut向量。为了验证结果，用户可以比较在DFFREGL组件中记录的真值表。</p>
</html>"      ));
    end DFFREGL;

    model DFFREGSRH "脉冲触发的D寄存器组，高有效置位和复位"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table clock(x = {L.'0', L.'1', L.'0'}, t = {0, 10, 11}) 
        annotation(Placement(transformation(extent = {{-86, -32}, {-66, -12}})));
      Modelica.Electrical.Digital.Sources.Table data_0(x = {L.'W'}, t = {0}) 
        annotation(Placement(transformation(extent = {{-86, 8}, {-66, 28}})));
      Modelica.Electrical.Digital.Sources.Table reset(x = {L.'0', L.'1', L.'0'}, t = {0, 1, 2}) 
        annotation(Placement(transformation(extent = {{-86, -70}, {-66, -50}})));
      Modelica.Electrical.Digital.Sources.Table data_1(x = {L.'0'}, t = {0}) 
        annotation(Placement(transformation(extent = {{-86, 40}, {-66, 60}})));
      Modelica.Electrical.Digital.Sources.Table set(x = {L.'0', L.'1', L.'0'}, t = {0, 5, 6}) 
        annotation(Placement(transformation(extent = {{-86, 74}, {-66, 94}})));
      Modelica.Electrical.Digital.Registers.DFFREGSRH dFFREGSRH(
        tHL = 2, 
        tLH = 3, 
        n = 2) 
        annotation(Placement(transformation(extent = {{-34, -37}, {73, 71}})));
    equation

      connect(clock.y, dFFREGSRH.clock) annotation(Line(
        points = {{-66, -22}, {-50, -22}, {-50, 6.2}, {-29.72, 6.2}}, color = {127, 0, 127}));
      connect(set.y, dFFREGSRH.set) annotation(Line(
        points = {{-66, 84}, {-48, 84}, {-48, 60.2}, {-29.72, 60.2}}, color = {127, 0, 127}));
      connect(reset.y, dFFREGSRH.reset) annotation(Line(
        points = {{-66, -60}, {-29.72, -60}, {-29.72, -15.4}}, color = {127, 0, 127}));
      connect(data_0.y, dFFREGSRH.dataIn[1]) annotation(Line(
        points = {{-66, 18}, {-48, 18}, {-48, 36.44}, {-29.72, 36.44}}, color = {127, 0, 127}));
      connect(data_1.y, dFFREGSRH.dataIn[2]) annotation(Line(
        points = {{-66, 50}, {-48, 50}, {-48, 40.76}, {-29.72, 40.76}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 15), 
        Documentation(info = "<html>
<p>这个示例是对Registers.DFFREGSRH组件的简单测试。数据宽度设置为两个。在模拟后，绘制dataIn和dataOut向量，并且可以通过比较在DFFREGSRH组件中记录的真值表来验证结果。</p>
</html>"          ));
    end DFFREGSRH;

    model DFFREGSRL "脉冲触发的D寄存器组，低有效置位和复位"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table clock(x = {L.'0', L.'1', L.'0'}, t = {0, 10, 11}) 
        annotation(Placement(transformation(extent = {{-86, -32}, {-66, -12}})));
      Modelica.Electrical.Digital.Sources.Table data_0(x = {L.'W'}, t = {0}) 
        annotation(Placement(transformation(extent = {{-86, 8}, {-66, 28}})));
      Modelica.Electrical.Digital.Sources.Table reset(t = {0, 1, 2}, x = {L.'1', L.'0', L.'1'}) 
        annotation(Placement(transformation(extent = {{-86, -70}, {-66, -50}})));
      Modelica.Electrical.Digital.Sources.Table data_1(x = {L.'0'}, t = {0}) 
        annotation(Placement(transformation(extent = {{-86, 40}, {-66, 60}})));
      Modelica.Electrical.Digital.Sources.Table set(t = {0, 5, 6}, x = {L.'1', L.'0', L.'1'}) 
        annotation(Placement(transformation(extent = {{-86, 74}, {-66, 94}})));
      Modelica.Electrical.Digital.Registers.DFFREGSRL dFFREGSRL(
        tHL = 2, 
        tLH = 3, 
        n = 2) annotation(Placement(transformation(extent = {{-45, -54}, {81, 72}})));
    equation
      connect(reset.y, dFFREGSRL.reset) annotation(Line(
        points = {{-66, -60}, {-39.96, -60}, {-39.96, -28.8}}, color = {127, 0, 127}));
      connect(clock.y, dFFREGSRL.clock) annotation(Line(
        points = {{-66, -22}, {-56, -22}, {-56, -3.6}, {-39.96, -3.6}}, color = {127, 0, 127}));
      connect(set.y, dFFREGSRL.set) annotation(Line(
        points = {{-66, 84}, {-39.96, 84}, {-39.96, 59.4}}, color = {127, 0, 127}));
      connect(data_0.y, dFFREGSRL.dataIn[1]) annotation(Line(
        points = {{-66, 18}, {-56, 18}, {-56, 31.68}, {-39.96, 31.68}}, color = {127, 0, 127}));
      connect(data_1.y, dFFREGSRL.dataIn[2]) annotation(Line(
        points = {{-66, 50}, {-56, 50}, {-56, 36.72}, {-39.96, 36.72}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 15), 
        Documentation(info = "<html>
<p>这个示例是对Registers.DFFREGSRL组件的简单测试。数据宽度设置为两个。在模拟后，用户可以特定窗口绘制dataIn和dataOut向量，并且可以通过比较在DFFREGSRL组件中记录的真值表来验证结果。</p>
</html>"      ));
    end DFFREGSRL;

    model DLATREG "电平触发的D寄存器组，高有效复位"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table enable(x = {L.'0', L.'1', L.'0'}, t = {0, 10, 18}) 
        annotation(Placement(transformation(extent = {{-86, -32}, {-66, -12}})));
      Modelica.Electrical.Digital.Sources.Table data_0(x = {L.'W', L.'1'}, t = {0, 15}) 
        annotation(Placement(transformation(extent = {{-86, 8}, {-66, 28}})));
      Modelica.Electrical.Digital.Sources.Table reset(x = {L.'0', L.'1', L.'0', L.'1', L.'0'}, t = {0, 1, 2, 20, 21}) 
        annotation(Placement(transformation(extent = {{-86, -70}, {-66, -50}})));
      Modelica.Electrical.Digital.Sources.Table data_1(x = {L.'0', L.'1'}, t = {0, 16}) 
        annotation(Placement(transformation(extent = {{-86, 40}, {-66, 60}})));
      Modelica.Electrical.Digital.Registers.DLATREG dLATREG(
        n = 2, 
        tHL = 2, 
        tLH = 3, delay(inertialDelaySensitive(each y(start = L.'U', fixed = true)))) 
        annotation(Placement(transformation(extent = {{-45, -50}, {84, 79}})));
    equation

      connect(reset.y, dLATREG.reset) annotation(Line(
        points = {{-66, -60}, {-39.84, -60}, {-39.84, -24.2}}, color = {127, 0, 127}));
      connect(enable.y, dLATREG.enable) annotation(Line(
        points = {{-66, -22}, {-56, -22}, {-56, 1.6}, {-39.84, 1.6}}, color = {127, 0, 127}));
      connect(data_0.y, dLATREG.dataIn[1]) annotation(Line(
        points = {{-66, 18}, {-56, 18}, {-56, 37.72}, {-39.84, 37.72}}, color = {127, 0, 127}));
      connect(data_1.y, dLATREG.dataIn[2]) annotation(Line(
        points = {{-66, 50}, {-56, 50}, {-56, 42.88}, {-39.84, 42.88}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 25), 
        Documentation(info = "<html>
<p>这个示例是对Registers.DLATREG组件的简单测试。数据宽度设置为两个。在模拟后，用户可以在特定窗口绘制dataIn和dataOut向量图，并且可以通过比较在DLATREG组件中记录的真值表来验证结果。</p>
</html>"          ));
    end DLATREG;

    model DLATREGL "电平触发的D寄存器组，低有效复位"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table enable(x = {L.'0', L.'1', L.'0'}, t = {0, 10, 18}) 
        annotation(Placement(transformation(extent = {{-86, -32}, {-66, -12}})));
      Modelica.Electrical.Digital.Sources.Table data_0(x = {L.'W', L.'1'}, t = {0, 15}) 
        annotation(Placement(transformation(extent = {{-86, 8}, {-66, 28}})));
      Modelica.Electrical.Digital.Sources.Table reset(t = {0, 1, 2, 20, 21}, x = {L.'1', L.'0', L.'1', L.'0', L.'1'}) 
        annotation(Placement(transformation(extent = {{-86, -70}, {-66, -50}})));
      Modelica.Electrical.Digital.Sources.Table data_1(x = {L.'0', L.'1'}, t = {0, 16}) 
        annotation(Placement(transformation(extent = {{-86, 40}, {-66, 60}})));
      Modelica.Electrical.Digital.Registers.DLATREGL dLATREGL(
        tHL = 2, 
        tLH = 3, 
        n = 2, delay(inertialDelaySensitive(each y(start = L.'U', fixed = true)))) annotation(Placement(transformation(extent = {{-45, -50}, {84, 79}})));
    equation

      connect(reset.y, dLATREGL.reset) annotation(Line(
        points = {{-66, -60}, {-39.84, -60}, {-39.84, -24.2}}, color = {127, 0, 127}));
      connect(enable.y, dLATREGL.enable) annotation(Line(
        points = {{-66, -22}, {-54, -22}, {-54, 1.6}, {-39.84, 1.6}}, color = {127, 0, 127}));
      connect(data_0.y, dLATREGL.dataIn[1]) annotation(Line(
        points = {{-66, 18}, {-56, 18}, {-56, 37.72}, {-39.84, 37.72}}, color = {127, 0, 127}));
      connect(data_1.y, dLATREGL.dataIn[2]) annotation(Line(
        points = {{-66, 50}, {-56, 50}, {-56, 42.88}, {-39.84, 42.88}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 25), 
        Documentation(info = "<html>
<p>这个示例是对Registers.DLATREGL组件的简单测试。数据宽度设置为两个。在模拟后，用户可以在特定窗口绘制dataIn和dataOut向量，并且可以通过比较在DLATREGL组件中记录的真值表来验证结果。</p>
</html>"      ));
    end DLATREGL;

    model DLATREGSRH "电平触发的D寄存器组，高有效置位和复位"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table enable(x = {L.'0', L.'1', L.'0'}, t = {0, 10, 18}) 
        annotation(Placement(transformation(extent = {{-86, -32}, {-66, -12}})));
      Modelica.Electrical.Digital.Sources.Table data_0(x = {L.'W', L.'1'}, t = {0, 15}) 
        annotation(Placement(transformation(extent = {{-86, 8}, {-66, 28}})));
      Modelica.Electrical.Digital.Sources.Table reset(x = {L.'0', L.'1', L.'0', L.'1', L.'0'}, t = {0, 1, 2, 20, 21}) 
        annotation(Placement(transformation(extent = {{-86, -70}, {-66, -50}})));
      Modelica.Electrical.Digital.Sources.Table data_1(x = {L.'0', L.'1'}, t = {0, 16}) 
        annotation(Placement(transformation(extent = {{-86, 40}, {-66, 60}})));
      Modelica.Electrical.Digital.Sources.Table set(x = {L.'0', L.'1', L.'0'}, t = {0, 5, 6}) 
        annotation(Placement(transformation(extent = {{-86, 74}, {-66, 94}})));
      Modelica.Electrical.Digital.Registers.DLATREGSRH dLATREGSRH(
        tHL = 2, 
        tLH = 3, 
        n = 2, delay(inertialDelaySensitive(each y(start = L.'U', fixed = true)))) annotation(Placement(transformation(extent = {{-45, -42}, {69, 71}})));
    equation

      connect(reset.y, dLATREGSRH.reset) annotation(Line(
        points = {{-66, -60}, {-40.44, -60}, {-40.44, -19.4}}, color = {127, 0, 127}));
      connect(enable.y, dLATREGSRH.enable) annotation(Line(
        points = {{-66, -22}, {-52, -22}, {-52, 3.2}, {-40.44, 3.2}}, color = {127, 0, 127}));
      connect(data_0.y, dLATREGSRH.dataIn[1]) annotation(Line(
        points = {{-66, 18}, {-52, 18}, {-52, 34.84}, {-40.44, 34.84}}, color = {127, 0, 127}));
      connect(data_1.y, dLATREGSRH.dataIn[2]) annotation(Line(
        points = {{-66, 50}, {-52, 50}, {-52, 39.36}, {-40.44, 39.36}}, color = {127, 0, 127}));
      connect(set.y, dLATREGSRH.set) annotation(Line(
        points = {{-66, 84}, {-40.44, 84}, {-40.44, 59.7}}, color = {127, 0, 127}));

      annotation(experiment(StopTime = 25), 
        Documentation(info = "<html>
<p>这个示例是对Registers.DLATREGSRH组件的简单测试。数据宽度设置为两个。在模拟后，可以绘制dataIn和dataOut向量，并且可以通过比较在DLATREGSRH组件中记录的真值表来验证结果。</p>
</html>"      ));
    end DLATREGSRH;

    model DLATREGSRL "电平触发的D寄存器组，低有效置位和复位"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table enable(t = {0, 10, 18}, x = {L.'0', L.'1', L.'0'}) 
        annotation(Placement(transformation(extent = {{-86, -32}, {-66, -12}})));
      Modelica.Electrical.Digital.Sources.Table data_0(x = {L.'W', L.'1'}, t = {0, 15}) 
        annotation(Placement(transformation(extent = {{-86, 8}, {-66, 28}})));
      Modelica.Electrical.Digital.Sources.Table reset(t = {0, 1, 2, 20, 21}, x = {L.'1', L.'0', L.'1', L.'0', L.'1'}) 
        annotation(Placement(transformation(extent = {{-86, -70}, {-66, -50}})));
      Modelica.Electrical.Digital.Sources.Table data_1(x = {L.'0', L.'1'}, t = {0, 16}) 
        annotation(Placement(transformation(extent = {{-86, 40}, {-66, 60}})));
      Modelica.Electrical.Digital.Sources.Table set(t = {0, 5, 6}, x = {L.'1', L.'0', L.'1'}) 
        annotation(Placement(transformation(extent = {{-86, 74}, {-66, 94}})));
      Modelica.Electrical.Digital.Registers.DLATREGSRL dLATREGSRL(
        tHL = 2, 
        tLH = 3, 
        n = 2, delay(inertialDelaySensitive(each y(start = L.'U', fixed = true)))) annotation(Placement(transformation(extent = {{-45, -43}, {69, 71}})));
    equation

      connect(reset.y, dLATREGSRL.reset) annotation(Line(
        points = {{-66, -60}, {-40.44, -60}, {-40.44, -20.2}}, color = {127, 0, 127}));
      connect(enable.y, dLATREGSRL.enable) annotation(Line(
        points = {{-66, -22}, {-56, -22}, {-56, 2.6}, {-40.44, 2.6}}, color = {127, 0, 127}));
      connect(data_0.y, dLATREGSRL.dataIn[1]) annotation(Line(
        points = {{-66, 18}, {-56, 18}, {-56, 34.52}, {-40.44, 34.52}}, color = {127, 0, 127}));
      connect(data_1.y, dLATREGSRL.dataIn[2]) annotation(Line(
        points = {{-66, 50}, {-56, 50}, {-56, 39.08}, {-40.44, 39.08}}, color = {127, 0, 127}));
      connect(set.y, dLATREGSRL.set) annotation(Line(
        points = {{-66, 84}, {-40.44, 84}, {-40.44, 59.6}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 25), 
        Documentation(info = "<html>
<p>这个示例是对Registers.DLATREGSRL组件的简单测试。数据宽度设置为两个。在模拟后，用户可以在特定窗口绘制dataIn和dataOut向量，并且可以通过比较在DLATREGSRL组件中记录的真值表来验证结果。</p>
</html>"      ));
    end DLATREGSRL;

    model NXFER "NXFERGATE的功能测试"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;
      Modelica.Electrical.Digital.Sources.Table e_table(
        y0 = Modelica.Electrical.Digital.Interfaces.Logic.'U', 
        x = {L.'0', L.'1', L.'Z'}, 
        t = {0, 5, 9}) 
        annotation(Placement(transformation(extent = {{-75, 30}, {-55, 50}})));
      Modelica.Electrical.Digital.Sources.Table x_table(
        y0 = Modelica.Electrical.Digital.Interfaces.Logic.'U', 
        x = {L.'1', L.'0'}, 
        t = {1, 7}) 
        annotation(Placement(transformation(extent = {{-75, -20}, {-55, 0}})));
      Modelica.Electrical.Digital.Tristates.NXFERGATE nXFERGATE(
        tHL = 1, tLH = 1) 
        annotation(Placement(transformation(extent = {{-40, -52}, {52, 41}})));
    equation

      connect(x_table.y, nXFERGATE.x) annotation(Line(
        points = {{-55, -10}, {-45.2, -10}, {-45.2, -10.15}, {-35.4, -10.15}}, color = {127, 0, 127}));
      connect(e_table.y, nXFERGATE.enable) annotation(Line(
        points = {{-55, 40}, {-35.4, 40}, {-35.4, 27.05}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 12), 
        Documentation(info = "<html>
<p>这个示例是对Tristates.NXFERGATE组件的简单测试。</p>
</html>"    ));
    end NXFER;

    model NRXFER "NRXFERGATE的功能测试"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table e_table(
        y0 = Modelica.Electrical.Digital.Interfaces.Logic.'U', 
        x = {L.'0', L.'1', L.'Z'}, 
        t = {0, 5, 9}) 
        annotation(Placement(transformation(extent = {{-75, 30}, {-55, 50}})));
      Modelica.Electrical.Digital.Sources.Table x_table(
        y0 = Modelica.Electrical.Digital.Interfaces.Logic.'U', 
        x = {L.'1', L.'0'}, 
        t = {1, 7}) 
        annotation(Placement(transformation(extent = {{-75, -20}, {-55, 0}})));
      Modelica.Electrical.Digital.Tristates.NRXFERGATE nRXFERGATE(
        tHL = 1, tLH = 1) 
        annotation(Placement(transformation(extent = {{-40, -54}, {58, 44}})));
    equation
      connect(x_table.y, nRXFERGATE.x) annotation(Line(
        points = {{-55, -10}, {-45.05, -10}, {-45.05, -9.9}, {-35.1, -9.9}}, color = {127, 0, 127}));
      connect(e_table.y, nRXFERGATE.enable) annotation(Line(
        points = {{-55, 40}, {-35.1, 40}, {-35.1, 29.3}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 12), 
        Documentation(info = "<html>
<p>这个示例是对Tristates.NRXFER组件的简单测试。模拟到12秒时用户可以在特定窗口绘制<code>nRXFERGATE</code>组件的x、enable和y。要验证结果，请将其与真值表<code>NRXferTable</code>进行比较。</p>
</html>"      ));
    end NRXFER;

    model BUF3S "BUF3S的功能测试"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;
      Modelica.Electrical.Digital.Sources.Table e_table(
        y0 = Modelica.Electrical.Digital.Interfaces.Logic.'U', 
        x = {L.'0', L.'1', L.'Z'}, 
        t = {0, 5, 9}) 
        annotation(Placement(transformation(extent = {{-75, 30}, {-55, 50}})));
      Modelica.Electrical.Digital.Sources.Table x_table(
        y0 = Modelica.Electrical.Digital.Interfaces.Logic.'U', 
        x = {L.'1', L.'0'}, 
        t = {1, 7}) 
        annotation(Placement(transformation(extent = {{-75, -20}, {-55, 0}})));
      Modelica.Electrical.Digital.Tristates.BUF3S bUF3S(
        tHL = 1, 
        tLH = 1, 
        strength = Modelica.Electrical.Digital.Interfaces.Strength.'S_X01') 
        annotation(Placement(transformation(extent = {{-40, -50}, {48, 38}})));
    equation
      connect(x_table.y, bUF3S.x) annotation(Line(
        points = {{-55, -10}, {-35.6, -10.4}}, color = {127, 0, 127}));
      connect(e_table.y, bUF3S.enable) annotation(Line(
        points = {{-55, 40}, {-35.6, 40}, {-35.6, 24.8}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 12), 
        Documentation(info = "<html>
<p>这个示例是对Tristates.BUF3S组件的简单测试。在模拟到12秒时，用户可以在特定窗口绘制<code>bUF3S</code>组件的x、enable和y。要验证结果，请将其与真值表Buf3sTable进行比较。</p>
</html>"      ));
    end BUF3S;

    model INV3S "INV3S的功能测试"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Sources.Table e_table(
        y0 = L.'U', 
        x = {L.'0', L.'1', L.'Z'}, 
        t = {0, 5, 9}) 
        annotation(Placement(transformation(extent = {{-75, 30}, {-55, 50}})));
      Modelica.Electrical.Digital.Sources.Table x_table(
        y0 = L.'U', 
        x = {L.'1', L.'0'}, 
        t = {1, 7}) 
        annotation(Placement(transformation(extent = {{-75, -20}, {-55, 0}})));
      Modelica.Electrical.Digital.Tristates.INV3S iNV3S 
        annotation(Placement(transformation(extent = {{-34, -44}, {42, 32}})));
    equation
      connect(x_table.y, iNV3S.x) annotation(Line(
        points = {{-55, -10}, {-42.6, -10}, {-42.6, -9.8}, {-30.2, -9.8}}, color = {127, 0, 127}));
      connect(e_table.y, iNV3S.enable) annotation(Line(
        points = {{-55, 40}, {-30.2, 40}, {-30.2, 20.6}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 12), 
        Documentation(info = "<html>
<p>这个示例是对Tristates.INV3S组件的简单测试。在模拟到12秒时绘制<code>iNV3S</code>组件的x、enable和y。要验证结果，请将其与真值表T.UX01Table进行比较。</p>
</html>"      ));
    end INV3S;

    model WiredX "WiredX的功能测试"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;
      Modelica.Electrical.Digital.Sources.Table e_table2(
        y0 = L.'U', 
        x = {L.'0', L.'1', L.'0'}, 
        t = {0, 3, 9}) 
        annotation(Placement(transformation(extent = {{-85, 68}, {-65, 88}})));
      Modelica.Electrical.Digital.Sources.Table x_table2(
        y0 = L.'U', 
        x = {L.'1', L.'0'}, 
        t = {1, 7}) 
        annotation(Placement(transformation(extent = {{-85, 18}, {-65, 38}})));
      Modelica.Electrical.Digital.Tristates.BUF3S bUF3S2(
        tHL = 1, 
        tLH = 1, 
        strength = Modelica.Electrical.Digital.Interfaces.Strength.'S_X01') 
        annotation(Placement(transformation(extent = {{-48, -1}, {16, 63}})));
      Modelica.Electrical.Digital.Sources.Table e_table1(
        y0 = L.'U', 
        t = {0, 3, 9}, 
        x = {L.'0', L.'1', L.'0'}) 
        annotation(Placement(transformation(extent = {{-85, -24}, {-65, -4}})));
      Modelica.Electrical.Digital.Sources.Table x_table1(
        y0 = L.'U', 
        x = {L.'0', L.'1', L.'0'}, 
        t = {1, 5, 7}) 
        annotation(Placement(transformation(extent = {{-85, -74}, {-65, -54}})));
      Modelica.Electrical.Digital.Tristates.BUF3S bUF3S1(
        tHL = 1, 
        tLH = 1, 
        strength = Modelica.Electrical.Digital.Interfaces.Strength.'S_X01') 
        annotation(Placement(transformation(extent = {{-52, -94}, {14, -28}})));
      Modelica.Electrical.Digital.Tristates.WiredX wiredX(n = 2) 
        annotation(Placement(transformation(extent = {{26, -38}, {80, 16}})));
    equation
      connect(x_table2.y, bUF3S2.x) annotation(Line(
        points = {{-65, 28}, {-44.8, 27.8}}, color = {127, 0, 127}));
      connect(e_table2.y, bUF3S2.enable) annotation(Line(
        points = {{-65, 78}, {-44.8, 78}, {-44.8, 53.4}}, color = {127, 0, 127}));
      connect(x_table1.y, bUF3S1.x) annotation(Line(
        points = {{-65, -64}, {-48.7, -64.3}}, color = {127, 0, 127}));
      connect(e_table1.y, bUF3S1.enable) annotation(Line(
        points = {{-65, -14}, {-48.7, -14}, {-48.7, -37.9}}, color = {127, 0, 127}));
      connect(bUF3S1.y, wiredX.x[1]) annotation(Line(
        points = {{10.7, -64.3}, {24, -64.3}, {24, -21.8}, {36.8, -21.8}}, color = {127, 0, 127}));
      connect(bUF3S2.y, wiredX.x[2]) annotation(Line(
        points = {{12.8, 27.8}, {26, 27.8}, {26, -0.2}, {36.8, -0.2}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 12), 
        Documentation(info = "<html>
<p>这个示例是对Tristates.WiredX组件的简单测试。输入宽度设置为两个。在模拟到12秒时用户可以在特定窗口绘制WiredX组件的x[1]、x[2]和y。要验证结果，请将其与真值表Tables.ResolutionTable进行比较。</p>
</html>"      ));
    end WiredX;

    model MUX2x1 "简单的多路复用器测试"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;
      D.Multiplexers.MUX2x1 Mux2x1 
        annotation(Placement(transformation(extent = {{-34, -48}, {56, 48}})));
      D.Sources.Table Input1(
        y0 = L.'U', 
        x = {L.'X', L.'0', L.'1', L.'0', L.'X', L.'U'}, 
        t = {2, 4, 6, 8, 10, 12}) 
        annotation(Placement(transformation(extent = {{-90, 14}, {-70, 34}})));
      D.Sources.Step Select(
        before = L.'0', 
        after = L.'1', 
        stepTime = 7) 
        annotation(Placement(transformation(extent = {{-90, 58}, {-70, 78}})));
      D.Sources.Table Input0(
        y0 = L.'U', 
        t = {2, 4, 6, 8, 10, 12}, 
        x = {L.'1', L.'X', L.'0', L.'X', L.'1', L.'U'}) 
        annotation(Placement(transformation(extent = {{-90, -34}, {-70, -14}})));
    equation
      connect(Select.y, Mux2x1.sel) annotation(Line(
        points = {{-70, 68}, {11, 68}, {11, 43.2}}, color = {127, 0, 127}));
      connect(Input0.y, Mux2x1.in0) annotation(Line(
        points = {{-70, -24}, {-29.5, -24}}, color = {127, 0, 127}));
      connect(Input1.y, Mux2x1.in1) annotation(Line(
        points = {{-70, 24}, {-29.5, 24}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 15), 
        Documentation(info = "<html>
<p>这个示例是一个简单的单路复用器组件测试，有2个输入(由源指定，一个选择输入和一个输出)。在模拟到15秒时用户可以在特定窗口绘制Mux2x1.in0、Mux2x1.in1、Mux2x1.sel和Mux2x1.out。将输出信号与输入信号进行比较。如果选择信号发生变化，输出就会切换到另一个输入。</p>
</html>"      ));
    end MUX2x1;

    model RAM "简单的RAM测试示例"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends Modelica.Icons.Example;

      Modelica.Electrical.Digital.Memories.DLATRAM 
        dLATRAM 
        annotation(Placement(transformation(extent = {{-11, -41}, {103, 73}})));
      Modelica.Electrical.Digital.Sources.Table 
        addr_1(
        y0 = L.'U', 
        x = {L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-', 
           L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-', 
           L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-', 
           L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-', 
           L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-', 
           L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-', 
           L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-', 
           L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-', 
           L.'U',L.'X',L.'0',L.'1',L.'Z',L.'W',L.'L',L.'H',L.'-'}, 
        t = {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 
        115, 120, 125, 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, 195, 
        200, 205, 210, 215, 220, 225, 230, 235, 240, 245, 250, 255, 260, 265, 270, 275, 280, 
        285, 290, 295, 300, 305, 310, 315, 320, 325, 330, 335, 340, 345, 350, 355, 360, 365, 
        370, 375, 380, 385, 390, 395, 400}) 
        annotation(Placement(transformation(extent = {{-78, 76}, {-58, 96}})));
      Modelica.Electrical.Digital.Sources.Set 
        data_1(x = Modelica.Electrical.Digital.Interfaces.Logic.'0') 
        annotation(Placement(transformation(extent = {{-78, 20}, {-58, 40}})));
      Modelica.Electrical.Digital.Sources.Set 
        data_0(x = Modelica.Electrical.Digital.Interfaces.Logic.'0') 
        annotation(Placement(transformation(extent = {{-78, -8}, {-58, 12}})));
      Modelica.Electrical.Digital.Sources.Set 
        WE(x = Modelica.Electrical.Digital.Interfaces.Logic.'1') 
        annotation(Placement(transformation(extent = {{-78, -70}, {-58, -50}})));
      Modelica.Electrical.Digital.Sources.Table 
        addr_0(
        y0 = Modelica.Electrical.Digital.Interfaces.Logic.'U', 
        t = {45, 90, 135, 180, 225, 270, 315, 360}, 
        x = {L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'-'}) 
        annotation(Placement(transformation(extent = {{-78, 48}, {-58, 68}})));
      Modelica.Electrical.Digital.Sources.Set 
        RE(x = Modelica.Electrical.Digital.Interfaces.Logic.'1') 
        annotation(Placement(transformation(extent = {{-78, -38}, {-58, -18}})));

    equation
      connect(RE.y, dLATRAM.RE) annotation(Line(
        points = {{-58, -28}, {-28, -28}, {-28, 4.6}, {-6.44, 4.6}}, color = {127, 0, 127}));
      connect(WE.y, dLATRAM.WE) annotation(Line(
        points = {{-58, -60}, {-24, -60}, {-24, -12.5}, {-6.44, -12.5}}, color = {127, 0, 127}));
      connect(addr_0.y, dLATRAM.addr[1]) annotation(Line(
        points = {{-58, 58}, {-34, 58}, {-34, 47.35}, {-5.3, 47.35}}, color = {127, 0, 127}));
      connect(addr_1.y, dLATRAM.addr[2]) annotation(Line(
        points = {{-58, 86}, {-32, 86}, {-32, 53.05}, {-5.3, 53.05}}, color = {127, 0, 127}));
      connect(data_1.y, dLATRAM.dataIn[2]) annotation(Line(
        points = {{-58, 30}, {-32, 30}, {-32, 30.25}, {-5.3, 30.25}}, color = {127, 0, 127}));
      connect(data_0.y, dLATRAM.dataIn[1]) annotation(Line(
        points = {{-58, 2}, {-34, 2}, {-34, 24.55}, {-5.3, 24.55}}, color = {127, 0, 127}));
      annotation(experiment(StopTime = 400), 
        Documentation(info = "<html>
<p>这个示例是一个简单而不完整的单个DLATRAM组件测试。在模拟到400秒时绘制dLATRAM.addr[1]、dLATRAM.addr[2]和dLATRAM.dataOUT[1]、dLATRAM.dataOut[2]。地址输入使用所有可能的逻辑值组合进行指定。可以检查在哪些地址值情况下输出为'X'或'0'。</p>
</html>"              ));
    end RAM;

    package Utilities "Examples库使用的实用组件"
      extends Modelica.Icons.UtilitiesPackage;

      model MUX4 "4到1位多路复用器"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

        parameter SI.Time delayTime = 0.001 "延迟时间";
        parameter D.Interfaces.Logic q0 = L.'0' "初始值";
        D.Interfaces.DigitalInput d0 annotation(Placement(transformation(
          extent = {{-110, 60}, {-90, 80}})));
        D.Interfaces.DigitalInput d1 annotation(Placement(transformation(
          extent = {{-110, 34}, {-90, 54}})));
        D.Interfaces.DigitalInput d2 annotation(Placement(transformation(
          extent = {{-110, 8}, {-90, 28}})));
        D.Interfaces.DigitalInput d3 annotation(Placement(transformation(
          extent = {{-110, -18}, {-90, 2}})));
        D.Interfaces.DigitalInput a0 annotation(Placement(transformation(
          extent = {{-110, -54}, {-90, -34}})));
        D.Interfaces.DigitalInput a1 annotation(Placement(transformation(
          extent = {{-110, -80}, {-90, -60}})));
        D.Interfaces.DigitalOutput d annotation(Placement(transformation(
          extent = {{90, -10}, {110, 10}})));
        D.Basic.Or Or1(n = 4) annotation(Placement(transformation(extent = {{50, 20}, 
          {70, 40}})));
        D.Basic.And And1(n = 3) annotation(Placement(transformation(extent = {{-20, 
          60}, {0, 80}})));
        D.Basic.And And2(n = 3) annotation(Placement(transformation(extent = {{-20, 
          34}, {0, 54}})));
        D.Basic.And And3(n = 3) annotation(Placement(transformation(extent = {{-20, 
          8}, {0, 28}})));
        D.Basic.And And4(n = 3) annotation(Placement(transformation(extent = {{-20, 
          -18}, {0, 2}})));
        D.Basic.Not Not1 annotation(Placement(transformation(extent = {{-76, -54}, 
          {-56, -34}})));
        D.Basic.Not Not2 annotation(Placement(transformation(extent = {{-76, -80}, 
          {-56, -60}})));
      equation
        connect(a0, Not1.x) annotation(Line(
          points = {{-100, -44}, {-72, -44}}, color = {127, 0, 127}));
        connect(a1, Not2.x) annotation(Line(
          points = {{-100, -70}, {-72, -70}}, color = {127, 0, 127}));
        connect(d0, And1.x[2]) annotation(Line(
          points = {{-100, 70}, {-58, 70}, {-58, 70}, {-16, 70}}, color = {127, 0, 127}));
        connect(d1, And2.x[2]) annotation(Line(
          points = {{-100, 44}, {-16, 44}}, color = {127, 0, 127}));
        connect(d2, And3.x[2]) annotation(Line(
          points = {{-100, 18}, {-16, 18}}, color = {127, 0, 127}));
        connect(d3, And4.x[2]) annotation(Line(
          points = {{-100, -8}, {-58, -8}, {-58, -8}, {-16, -8}}, color = {127, 0, 127}));
        connect(And4.y, Or1.x[1]) annotation(Line(
          points = {{0, -8}, {40, -8}, {40, 24}, {54, 24}}, color = {127, 0, 127}));
        connect(And3.y, Or1.x[2]) annotation(Line(
          points = {{0, 18}, {20, 18}, {20, 28}, {54, 28}}, color = {127, 0, 127}));
        connect(And2.y, Or1.x[3]) annotation(Line(
          points = {{0, 44}, {20, 44}, {20, 32}, {54, 32}}, color = {127, 0, 127}));
        connect(And1.y, Or1.x[4]) annotation(Line(
          points = {{0, 70}, {40, 70}, {40, 36}, {54, 36}}, color = {127, 0, 127}));
        connect(Or1.y, d) annotation(Line(
          points = {{70, 30}, {80, 30}, {80, 0}, {100, 0}}, color = {127, 0, 127}));
        connect(Not1.y, And1.x[3]) annotation(Line(
          points = {{-56, -44}, {-50, -44}, {-50, 75.3333}, {-16, 75.3333}}, color = {127, 0, 127}));
        connect(Not1.y, And3.x[3]) annotation(Line(
          points = {{-56, -44}, {-50, -44}, {-50, 23.3333}, {-16, 23.3333}}, color = {127, 0, 127}));
        connect(Not2.y, And1.x[1]) annotation(Line(
          points = {{-56, -70}, {-40, -70}, {-40, 64.6667}, {-16, 64.6667}}, color = {127, 0, 127}));
        connect(Not2.y, And2.x[1]) annotation(Line(
          points = {{-56, -70}, {-40, -70}, {-40, 38.6667}, {-16, 38.6667}}, color = {127, 0, 127}));
        connect(a0, And4.x[3]) annotation(Line(
          points = {{-100, -44}, {-80, -44}, {-80, -2.66667}, {-16, -2.66667}}, color = {127, 0, 127}));
        connect(a0, And2.x[3]) annotation(Line(
          points = {{-100, -44}, {-80, -44}, {-80, 49.3333}, {-16, 49.3333}}, color = {127, 0, 127}));
        connect(a1, And4.x[1]) annotation(Line(
          points = {{-100, -70}, {-80, -70}, {-80, -90}, {-30, -90}, {-30, -13.3333}, 
          {-16, -13.3333}}, color = {127, 0, 127}));
        connect(a1, And3.x[1]) annotation(Line(
          points = {{-100, -70}, {-80, -70}, {-80, -90}, {-30, -90}, {-30, 12.6667}, 
          {-16, 12.6667}}, color = {127, 0, 127}));
        annotation(
          Documentation(info = "<html>
<p>MUX4是一个四位多路复用器，根据原理图由And、Not和Or门构建而成。</p>
<p>参数delayTime和q0已存在但<strong>尚未</strong>在组件中使用。MUX4组件在其组件中使用标准值。</p>
</html>"                ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Line(
          points = {{-60, 100}, {-60, -100}}, 
          thickness = 0.5), 
          Line(
          points = {{60, 100}, {60, -100}}, 
          thickness = 0.5), 
          Text(
          extent = {{-86, 80}, {-64, 60}}, 
          textString = "D0"), 
          Text(
          extent = {{64, 12}, {86, -8}}, 
          textString = "D"), 
          Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), 
          Text(
          extent = {{-60, 100}, {60, 40}}, 
          textString = "MUX"), 
          Text(
          extent = {{-86, -60}, {-64, -80}}, 
          textString = "A1"), 
          Text(
          extent = {{-86, 54}, {-64, 34}}, 
          textString = "D1"), 
          Text(
          extent = {{-86, 28}, {-64, 8}}, 
          textString = "D2"), 
          Text(
          extent = {{-86, 2}, {-64, -18}}, 
          textString = "D3"), 
          Text(
          extent = {{-86, -36}, {-64, -56}}, 
          textString = "A0")}));
      end MUX4;

      model RS "无时钟控制的RS触发器"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

        parameter SI.Time delayTime = 0 "延迟时间";
        parameter D.Interfaces.Logic q0 = L.'U' "输出的初始值";
        D.Basic.Nor Nor1 annotation(Placement(transformation(extent = {{-40, 42}, 
          {0, 82}})));
        D.Basic.Nor Nor2 annotation(Placement(transformation(extent = {{-40, -82}, 
          {0, -42}})));
        D.Interfaces.DigitalInput s annotation(Placement(transformation(extent = 
          {{-110, 60}, {-90, 80}})));
        D.Interfaces.DigitalInput r annotation(Placement(transformation(
          extent = {{-110, -80}, {-90, -60}})));
        D.Interfaces.DigitalOutput q annotation(Placement(transformation(
          extent = {{90, 60}, {110, 80}})));
        D.Interfaces.DigitalOutput qn annotation(Placement(transformation(
          extent = {{90, -80}, {110, -60}})));
        D.Delay.TransportDelay TD1(delayTime = delayTime, y0 = q0) 
          annotation(Placement(transformation(extent = {{-60, -64}, {-40, -44}})));
      equation
        connect(s, Nor1.x[2]) annotation(Line(points = {{-100, 70}, {-32, 70}}, color = {127, 0, 127}));
        connect(r, Nor2.x[1]) annotation(Line(points = {{-100, -70}, {-32, -70}}, color = {127, 0, 127}));
        connect(Nor2.y, Nor1.x[1]) annotation(Line(points = {{0, -62}, {20, -62}, {
          20, -20}, {-70, 20}, {-70, 54}, {-32, 54}}, color = {127, 0, 127}));
        connect(Nor1.y, qn) annotation(Line(
          points = {{0, 62}, {50, 62}, {50, -70}, {100, -70}}, color = {127, 0, 127}));
        connect(Nor2.y, q) annotation(Line(
          points = {{0, -62}, {70, -62}, {70, 70}, {100, 70}}, color = {127, 0, 127}));
        connect(TD1.y, Nor2.x[2]) annotation(Line(points = {{-40, -54}, {-32, -54}}, color = {127, 0, 127}));
        connect(TD1.x, Nor1.y) annotation(Line(points = {{-56, -54}, {-70, -54}, {-70, 
          -20}, {20, 20}, {20, 62}, {0, 62}}, color = {127, 0, 127}));
        annotation(
          Documentation(info = "<html>
<p>RS是一个基本组件，例如RS(设定-复位)触发器，根据原理图由Nor门构建而成。为了避免数值环路，组件中插入了一个小的传输延迟，其延迟时间是RS组件的参数。初始值也可以通过参数设置。</p>
</html>"                ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Text(
          extent = {{-100, 100}, {100, 40}}, 
          textString = "RS"), 
          Line(
          points = {{-60, 100}, {-60, -100}}, 
          thickness = 0.5), 
          Line(
          points = {{60, 100}, {60, -100}}, 
          thickness = 0.5), 
          Text(
          extent = {{-86, -60}, {-64, -80}}, 
          textString = "R"), 
          Text(
          extent = {{-86, 80}, {-64, 60}}, 
          textString = "S"), 
          Text(
          extent = {{64, 80}, {86, 60}}, 
          textString = "Q"), 
          Text(
          extent = {{64, -60}, {86, -80}}, 
          textString = "QN"), 
          Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name")}));
      end RS;

      model RSFF "无时钟控制的RS触发器"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

        parameter SI.Time delayTime = 0.01 "延迟时间";
        parameter D.Interfaces.Logic q0 = L.'U' "初始值";
        D.Interfaces.DigitalInput s annotation(Placement(transformation(extent = 
          {{-110, 60}, {-90, 80}})));
        D.Interfaces.DigitalInput r annotation(Placement(transformation(
          extent = {{-110, -80}, {-90, -60}})));
        D.Interfaces.DigitalOutput q annotation(Placement(transformation(extent = 
          {{90, 60}, {110, 80}})));
        D.Interfaces.DigitalOutput qn "非 Q" 
          annotation(Placement(transformation(extent = {{90, -80}, {110, -60}})));
        D.Interfaces.DigitalInput clk annotation(Placement(transformation(
          extent = {{-110, -10}, {-90, 10}})));
        D.Examples.Utilities.RS RS1(delayTime = delayTime, q0 = q0) 
          annotation(Placement(transformation(
          extent = {{-10, -40}, {70, 40}})));
        D.Basic.And And1 annotation(Placement(transformation(extent = {{-70, 
          8}, {-30, 48}})));
        D.Basic.And And2 annotation(Placement(transformation(extent = {{-70, 
          -48}, {-30, -8}})));
      equation
        connect(And2.y, RS1.r) 
          annotation(Line(
          points = {{-30, -28}, {-10, -28}}, color = {127, 0, 127}));
        connect(And1.y, RS1.s) 
          annotation(Line(
          points = {{-30, 28}, {-10, 28}}, color = {127, 0, 127}));
        connect(s, And1.x[2]) annotation(Line(
          points = {{-100, 70}, {-70, 70}, {-70, 36}, {-62, 36}}, color = {127, 0, 127}));
        connect(clk, And1.x[1]) annotation(Line(
          points = {{-100, 0}, {-70, 0}, {-70, 20}, {-62, 20}}, color = {127, 0, 127}));
        connect(clk, And2.x[2]) annotation(Line(
          points = {{-100, 0}, {-70, 0}, {-70, -20}, {-62, -20}}, color = {127, 0, 127}));
        connect(r, And2.x[1]) annotation(Line(
          points = {{-100, -70}, {-70, -70}, {-70, -36}, {-62, -36}}, color = {127, 0, 127}));
        connect(RS1.q, q) annotation(Line(
          points = {{70, 28}, {80, 28}, {80, 70}, {100, 70}}, color = {127, 0, 127}));
        connect(RS1.qn, qn) annotation(Line(
          points = {{70, -28}, {80, -28}, {80, -70}, {100, -70}}, color = {127, 0, 127}));
        annotation(
          Documentation(info = "<html>
<p>RSFF是根据RS组件原理图组成的RS(设定-复位)触发器。其参数delayTime是RS组件传输延迟的延迟时间，q0是该延迟的初始值。</p>
</html>"                      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Text(
          extent = {{-100, 100}, {100, 40}}, 
          textString = "RS"), 
          Line(
          points = {{-60, 100}, {-60, -100}}, 
          thickness = 0.5), 
          Line(
          points = {{60, 100}, {60, -100}}, 
          thickness = 0.5), 
          Text(
          extent = {{-86, -60}, {-64, -80}}, 
          textString = "R"), 
          Text(
          extent = {{-86, 80}, {-64, 60}}, 
          textString = "S"), 
          Text(
          extent = {{64, 80}, {86, 60}}, 
          textString = "Q"), 
          Text(
          extent = {{64, -60}, {86, -80}}, 
          textString = "QN"), 
          Line(points = {{-90, 20}, {-60, 0}, {-90, -20}}), 
          Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name")}));
      end RSFF;

      model DFF "D触发器"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

        parameter SI.Time Tdel = 0.01 "延迟时间";
        parameter L QInit = L.'U' "初始值";
        D.Interfaces.DigitalInput d annotation(Placement(transformation(extent = 
          {{-110, 60}, {-90, 80}})));
        D.Interfaces.DigitalOutput q annotation(Placement(transformation(extent = 
          {{90, 60}, {110, 80}})));
        D.Interfaces.DigitalOutput qn "非 Q" 
          annotation(Placement(transformation(extent = {{90, -80}, {110, -60}})));
        D.Interfaces.DigitalInput clk annotation(Placement(transformation(
          extent = {{-110, -10}, {-90, 10}})));
        D.Examples.Utilities.RSFF RSFF1 annotation(Placement(transformation(
          extent = {{-10, -40}, {70, 40}})));
        D.Basic.Not Not1 annotation(Placement(transformation(extent = {{-70, 
          -48}, {-30, -8}})));
      equation
        connect(RSFF1.q, q) 
          annotation(Line(
          points = {{70, 28}, {80, 28}, {80, 70}, {100, 70}}, color = {127, 0, 127}));
        connect(RSFF1.qn, qn) 
          annotation(Line(
          points = {{70, -28}, {80, -28}, {80, -70}, {100, -70}}, color = {127, 0, 127}));
        connect(Not1.y, RSFF1.r) 
          annotation(Line(
          points = {{-30, -28}, {-22, -28}, {-10, -28}}, color = {127, 0, 127}));
        connect(d, Not1.x) annotation(Line(
          points = {{-100, 70}, {-80, 70}, {-80, -28}, {-62, -28}}, color = {127, 0, 127}));
        connect(d, RSFF1.s) annotation(Line(
          points = {{-100, 70}, {-80, 70}, {-80, 28}, {-10, 28}}, color = {127, 0, 127}));
        connect(clk, RSFF1.clk) annotation(Line(
          points = {{-100, 0}, {-10, 0}}, color = {127, 0, 127}));
        annotation(
          Documentation(info = "<html>
<p>DFF是根据RS组件原理图组成的D触发器。其参数delayTime是RS组件传输延迟的延迟时间，q0是该延迟的初始值。</p>
</html>"                ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Line(
          points = {{-60, 100}, {-60, -100}}, 
          thickness = 0.5), 
          Line(
          points = {{60, 100}, {60, -100}}, 
          thickness = 0.5), 
          Text(
          extent = {{-86, 80}, {-64, 60}}, 
          textString = "D"), 
          Text(
          extent = {{64, 80}, {86, 60}}, 
          textString = "Q"), 
          Text(
          extent = {{64, -60}, {86, -80}}, 
          textString = "QN"), 
          Line(points = {{-90, 20}, {-60, 0}, {-90, -20}}), 
          Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), 
          Text(
          extent = {{-100, 100}, {100, 40}}, 
          textString = "D")}));
      end DFF;

      model JKFF "JK触发器"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

        parameter SI.Time delayTime = 0.001 "延迟时间";
        parameter D.Interfaces.Logic q0 = L.'0' "初始值";
        D.Interfaces.DigitalInput j annotation(Placement(transformation(extent = 
          {{-110, 60}, {-90, 80}})));
        D.Interfaces.DigitalOutput q annotation(Placement(transformation(extent = 
          {{90, 60}, {110, 80}})));
        D.Interfaces.DigitalOutput qn "非Q" 
          annotation(Placement(transformation(extent = {{90, -80}, {110, -60}})));
        D.Interfaces.DigitalInput clk annotation(Placement(transformation(
          extent = {{-110, -10}, {-90, 10}})));
        D.Interfaces.DigitalInput k annotation(Placement(transformation(extent = 
          {{-110, -80}, {-90, -60}})));
        D.Examples.Utilities.RS RS1(delayTime = delayTime, q0 = q0) 
          annotation(Placement(transformation(
          extent = {{30, -24}, {70, 16}})));
        D.Examples.Utilities.RS RS2(delayTime = delayTime, q0 = q0) 
          annotation(Placement(transformation(
          extent = {{-44, -20}, {-4, 20}})));
        D.Basic.And And1(n = 3) annotation(Placement(transformation(extent = {{-70, 
          4}, {-50, 24}})));
        D.Basic.And And2(n = 3) annotation(Placement(transformation(extent = {{-70, 
          -24}, {-50, -4}})));
        D.Basic.And And3 annotation(Placement(transformation(extent = {{4, 0}, {24, 
          20}})));
        D.Basic.And And4 annotation(Placement(transformation(extent = {{4, -28}, {
          24, -8}})));
        D.Basic.Not Not1 annotation(Placement(transformation(extent = {{-34, -66}, 
          {-14, -46}})));
      equation
        connect(And2.y, RS2.r) annotation(Line(points = {{-50, -14}, {-44, -14}}, color = {127, 0, 127}));
        connect(And1.y, RS2.s) annotation(Line(points = {{-50, 14}, {-44, 14}}, color = {127, 0, 127}));
        connect(clk, And2.x[3]) annotation(Line(points = {{-100, 0}, {-74, 0}, {
          -74, -8.66667}, {-66, -8.66667}}, color = {127, 0, 127}));
        connect(clk, And1.x[1]) annotation(Line(points = {{-100, 0}, {-74, 0}, {
          -74, 8.66667}, {-66, 8.66667}}, color = {127, 0, 127}));
        connect(k, And2.x[2]) annotation(Line(points = {{-100, -70}, {-74, -70}, {
          -74, -14}, {-66, -14}}, color = {127, 0, 127}));
        connect(And4.y, RS1.r) annotation(Line(points = {{24, -18}, {30, -18}}, color = {127, 0, 127}));
        connect(And3.y, RS1.s) annotation(Line(points = {{24, 10}, {30, 10}}, color = {127, 0, 127}));
        connect(RS2.qn, And4.x[2]) annotation(Line(points = {{-4, -14}, {8, -14}}, color = {127, 0, 127}));
        connect(RS2.q, And3.x[2]) annotation(Line(points = {{-4, 14}, {8, 14}}, color = {127, 0, 127}));
        connect(clk, Not1.x) annotation(Line(points = {{-100, 0}, {-80, 0}, {-80, -56}, 
          {-30, -56}}, color = {127, 0, 127}));
        connect(Not1.y, And3.x[1]) annotation(Line(points = {{-14, -56}, {2, -56}, {
          2, 6}, {8, 6}}, color = {127, 0, 127}));
        connect(Not1.y, And4.x[1]) annotation(Line(points = {{-14, -56}, {2, -56}, {
          2, -22}, {8, -22}}, color = {127, 0, 127}));
        connect(j, And1.x[2]) annotation(Line(points = {{-100, 70}, {-74, 70}, {-74, 
          14}, {-66, 14}}, color = {127, 0, 127}));
        connect(RS1.q, And2.x[1]) annotation(Line(points = {{70, 10}, {80, 10}, 
          {80, -36}, {-70, -36}, {-70, -19.3333}, {-66, -19.3333}}, color = {127, 0, 127}));
        connect(RS1.qn, And1.x[3]) annotation(Line(points = {{70, -18}, {86, 
          -18}, {86, 36}, {-70, 36}, {-70, 19.3333}, {-66, 19.3333}}, color = {127, 0, 127}));
        connect(RS1.qn, q) annotation(Line(points = {{70, -18}, {86, -18}, {86, 70}, {
          100, 70}}, color = {127, 0, 127}));
        connect(RS1.q, qn) annotation(Line(points = {{70, 10}, {80, 10}, {80, -70}, {100, 
          -70}}, color = {127, 0, 127}));
        annotation(
          Documentation(info = "<html>
<p>JKFF是基于RS组件原理图构成的J-K触发器。其参数delayTime是RS组件传输延迟的延迟时间，q0是该延迟的初始值。</p>
</html>"                ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Line(
          points = {{-60, 100}, {-60, -100}}, 
          thickness = 0.5), 
          Line(
          points = {{60, 100}, {60, -100}}, 
          thickness = 0.5), 
          Text(
          extent = {{-86, 80}, {-64, 60}}, 
          textString = "J"), 
          Text(
          extent = {{64, 80}, {86, 60}}, 
          textString = "Q"), 
          Text(
          extent = {{64, -60}, {86, -80}}, 
          textString = "QN"), 
          Line(points = {{-90, 20}, {-60, 0}, {-90, -20}}), 
          Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), 
          Text(
          extent = {{-100, 100}, {100, 40}}, 
          textString = "JK"), 
          Text(
          extent = {{-86, -60}, {-64, -80}}, 
          textString = "K")}));
      end JKFF;

      model HalfAdder "半加器"
        import L = Modelica.Electrical.Digital.Interfaces.Logic;
        parameter Real delayTime = 0 "延迟时间";
        Modelica.Electrical.Digital.Interfaces.DigitalInput b 
          annotation(Placement(transformation(extent = {{-110, -80}, {-90, 
          -60}})));
        Modelica.Electrical.Digital.Interfaces.DigitalOutput s 
          annotation(Placement(transformation(
          extent = {{90, 60}, {110, 80}})));
        Modelica.Electrical.Digital.Interfaces.DigitalInput a 
          annotation(Placement(transformation(extent = {{-110, 60}, {-90, 
          80}})));
        Modelica.Electrical.Digital.Interfaces.DigitalOutput c 
          annotation(Placement(transformation(
          extent = {{90, -80}, {110, -60}})));
        Modelica.Electrical.Digital.Gates.AndGate AND(tLH = delayTime, tHL = delayTime, G2(y(start = L.'U', fixed = true))) 
          annotation(Placement(transformation(extent = {{-20, -82}, {20, 
          -42}})));
        Modelica.Electrical.Digital.Gates.XorGate XOR(tLH = delayTime, tHL = delayTime, G2(y(start = L.'U', fixed = true))) 
          annotation(Placement(transformation(extent = {{-20, 42}, {20, 82}})));

      equation
        connect(AND.y, c) 
          annotation(Line(points = {{20, -62}, {60, -62}, {60, -70}, 
          {100, -70}}, color = {127, 0, 127}));
        connect(XOR.y, s) 
          annotation(Line(points = {{20, 62}, {60, 62}, {60, 70}, 
          {100, 70}}, color = {127, 0, 127}));
        connect(b, AND.x[1]) 
          annotation(Line(points = {{-100, -70}, {-12, -70}}, color = {127, 0, 127}));
        connect(b, XOR.x[1]) 
          annotation(Line(points = {{-100, -70}, {-30, -70}, 
          {-30, 54}, {-12, 54}}, color = {127, 0, 127}));
        connect(a, XOR.x[2]) 
          annotation(Line(points = {{-100, 70}, {-12, 70}}, color = {127, 0, 127}));
        connect(a, AND.x[2]) 
          annotation(Line(points = {{-100, 70}, {-40, 70}, {
          -40, -54}, {-12, -54}}, color = {127, 0, 127}));
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, 
          extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), Text(
          extent = {{-90, 80}, {-60, 60}}, 
          textString = "a"), Text(
          extent = {{-90, -60}, {-60, -80}}, 
          textString = "b"), Text(
          extent = {{60, 80}, {90, 60}}, 
          textString = "s"), Text(
          extent = {{60, -60}, {90, -80}}, 
          textString = "c"), Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), Text(
          extent = {{-100, 100}, {100, 0}}, 
          textString = "+"), Line(
          points = {{-60, 100}, {-60, -100}}, 
          thickness = 0.5), Line(
          points = {{60, 100}, {60, -100}}, 
          thickness = 0.5)}), 
          Documentation(info = "<html>
<p>半加器是一个由门组件组成的二进制加法器。</p>
<p>其逻辑行为如下：</p>
<p><strong>半加器行为</strong></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>输入a</h4></td>
<td><h4>输入b</h4></td>
<td><h4>和s</h4></td>
<td><h4>进位c</h4></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
</table>
<p>参数delayTime是两个组件的延迟时间(tLH=tHL)。</p>
</html>"                ));
      end HalfAdder;

      model FullAdder 
        "具有输入进位位的二进制数加法电路"

        HalfAdder Adder2(delayTime = 0.001) 
          annotation(Placement(transformation(
          extent = {{10, 36}, {50, 76}})));
        HalfAdder Adder1(delayTime = 0.001) 
          annotation(Placement(transformation(
          extent = {{-60, 36}, {-20, 76}})));
        Modelica.Electrical.Digital.Interfaces.DigitalInput a 
          annotation(Placement(transformation(
          origin = {-100, 70}, 
          extent = {{-10, -10}, {10, 10}}, 
          rotation = 180)));
        Modelica.Electrical.Digital.Interfaces.DigitalInput b 
          annotation(Placement(transformation(
          origin = {-100, 30}, 
          extent = {{-10, -10}, {10, 10}}, 
          rotation = 180)));
        Modelica.Electrical.Digital.Interfaces.DigitalInput c_in 
          annotation(Placement(transformation(
          origin = {-100, -70}, 
          extent = {{-10, -10}, {10, 10}}, 
          rotation = 180)));
        Modelica.Electrical.Digital.Interfaces.DigitalOutput s 
          annotation(Placement(transformation(
          origin = {101, 70}, 
          extent = {{11, -10}, {-11, 10}}, 
          rotation = 180)));
        Modelica.Electrical.Digital.Interfaces.DigitalOutput c_out 
          annotation(Placement(transformation(
          origin = {100, -70}, 
          extent = {{10, -10}, {-10, 10}}, 
          rotation = 180)));
        Modelica.Electrical.Digital.Basic.Or OR 
          annotation(Placement(transformation(extent = {{10, -90}, {50, 
          -50}})));
      equation

        connect(c_out, OR.y) annotation(Line(
          points = {{100, -70}, {50, -70}}, color = {127, 0, 127}));
        connect(Adder2.c, OR.x[2]) 
          annotation(Line(
          points = {{50, 42}, {70, 42}, {70, -40}, {10, -40}, {10, -62}, {18, -62}}, color = {127, 0, 127}));
        connect(Adder2.s, s) 
          annotation(Line(points = {{50, 70}, {101, 70}}, color = {127, 0, 127}));
        connect(Adder1.a, a) annotation(Line(points = {{-60, 70}, {-100, 70}}, color = {127, 0, 127}));
        connect(b, Adder1.b) annotation(Line(points = {{-100, 30}, {-70, 30}, {-70, 
          42}, {-60, 42}}, color = {127, 0, 127}));
        connect(Adder1.s, Adder2.a) annotation(Line(points = {{-20, 70}, {10, 70}}, color = {127, 0, 127}));
        connect(Adder1.c, OR.x[1]) annotation(Line(points = {{-20, 42}, {-10, 42}, {
          -10, -78}, {18, -78}}, color = {127, 0, 127}));
        connect(c_in, Adder2.b) annotation(Line(points = {{-100, -70}, {0, -70}, {0, 
          42}, {10, 42}}, color = {127, 0, 127}));
        annotation(
          Documentation(info = "<html>
<p>FullAdder是一个具有附加进位位的两位加法器，由门组件组成。</p>
<p>其逻辑行为如下：</p>
<p><strong>FullAdder行为</strong></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>输入a</h4></td>
<td><h4>输入b</h4></td>
<td><h4>输入进位c_in</h4></td>
<td><h4>和s</h4></td>
<td><h4>输出进位c_out</h4></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>0</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>0</p></td>
<td><p>1</p></td>
</tr>
<tr>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
<td><p>1</p></td>
</tr>
</table>
</html>"                ), Icon(coordinateSystem(
          preserveAspectRatio = true, 
          extent = {{-100, -100}, {100, 100}}), graphics = {
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Text(
          extent = {{-150, -96}, {150, -151}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), 
          Text(
          extent = {{-86, 80}, {-64, 60}}, 
          textString = "a"), 
          Text(
          extent = {{-86, 40}, {-64, 20}}, 
          textString = "b"), 
          Text(
          extent = {{-86, -60}, {-64, -80}}, 
          textString = "c_in"), 
          Text(
          extent = {{60, -60}, {90, -80}}, 
          textString = "c_out"), 
          Text(
          extent = {{64, 80}, {86, 60}}, 
          textString = "s"), 
          Text(
          extent = {{-100, 100}, {100, 0}}, 
          textString = "+"), 
          Line(
          points = {{-60, 100}, {-60, -100}}, 
          thickness = 0.5), 
          Line(
          points = {{60, 100}, {60, -100}}, 
          thickness = 0.5)}));
      end FullAdder;

      model Adder "通用N位加法器"
        import Modelica.Electrical.Digital;

        parameter Integer n = 2 "单个加法器的数量";
        Modelica.Electrical.Digital.Examples.Utilities.FullAdder Adder[n] 
          annotation(Placement(transformation(extent = 
          {{-20, -20}, {20, 20}})));
        Modelica.Electrical.Digital.Interfaces.DigitalInput a[n] 
          annotation(Placement(transformation(
          extent = {{-110, 60}, {-90, 80}})));
        Modelica.Electrical.Digital.Interfaces.DigitalInput b[n] 
          annotation(Placement(transformation(
          extent = {{-110, 20}, {-90, 40}})));
        Modelica.Electrical.Digital.Interfaces.DigitalInput c_in 
          annotation(Placement(transformation(
          extent = {{-110, -80}, {-90, -60}})));
        Modelica.Electrical.Digital.Interfaces.DigitalOutput s[n] 
          annotation(Placement(
          transformation(extent = {{90, 60}, {110, 80}})));
        Modelica.Electrical.Digital.Interfaces.DigitalOutput c_out 
          annotation(Placement(
          transformation(extent = {{90, -80}, {110, -60}})));
      equation
        connect(c_in, Adder[1].c_in);
        for i in 1:n loop
          connect(a[i], Adder[i].a);
          connect(b[i], Adder[i].b);
          connect(Adder[i].a, s[i]);
          if i > 1 then
            connect(Adder[i - 1].c_out, Adder[i].c_in);
          end if;
        end for;
        connect(Adder[n].c_out, c_out);
        annotation(
          Documentation(info = "<html>
<p>加法器是一个通用的n位加法器，由一系列FullAdder组件连接而成。用户可以选择n，a和b是n位输入向量，s是和向量，c_out是“最高位”FullAdder的进位位。所有组件都是由门组件构建的。</p>
</html>"                      ), Icon(coordinateSystem(
          preserveAspectRatio = true, 
          extent = {{-100, -100}, {100, 100}}), graphics = {
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Text(
          extent = {{68, 80}, {88, 60}}, 
          textString = "S"), 
          Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), 
          Text(
          extent = {{-40, 60}, {40, 20}}, 
          textString = "Adder"), 
          Text(
          extent = {{48, -60}, {88, -80}}, 
          textString = "Cout"), 
          Text(
          extent = {{-90, -60}, {-50, -80}}, 
          textString = "Cin"), 
          Text(
          extent = {{-88, 80}, {-68, 60}}, 
          textString = "A"), 
          Text(
          extent = {{-88, 40}, {-68, 20}}, 
          textString = "B")}));
      end Adder;

      model Counter3 "3位计数器"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

        D.Interfaces.DigitalInput enable 
          annotation(Placement(transformation(
          extent = {{-110, 60}, {-90, 80}})));
        D.Interfaces.DigitalOutput q2 annotation(Placement(transformation(extent = 
          {{90, 60}, {110, 80}})));
        D.Interfaces.DigitalInput count 
          annotation(Placement(transformation(
          extent = {{-110, -80}, {-90, -60}})));
        D.Examples.Utilities.JKFF FF1 
          annotation(Placement(transformation(extent = {{-74, -20}, {-34, 20}})));
        D.Examples.Utilities.JKFF FF2 
          annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}})));
        D.Examples.Utilities.JKFF FF3 
          annotation(Placement(transformation(extent = {{34, -20}, {74, 20}})));
        D.Interfaces.DigitalOutput q1 annotation(Placement(transformation(extent = 
          {{90, -10}, {110, 10}})));
        D.Interfaces.DigitalOutput q0 annotation(Placement(transformation(extent = 
          {{90, -80}, {110, -60}})));
      equation
        connect(enable, FF1.j) annotation(Line(
          points = {{-100, 70}, {-80, 70}, {-80, 14}, {-74, 14}}, color = {127, 0, 127}));
        connect(enable, FF1.k) annotation(Line(
          points = {{-100, 70}, {-80, 70}, {-80, -14}, {-74, -14}}, color = {127, 0, 127}));
        connect(count, FF1.clk) annotation(Line(
          points = {{-100, -70}, {-86, -70}, {-86, 0}, {-74, 0}}, color = {127, 0, 127}));
        connect(FF1.q, FF2.clk) annotation(Line(
          points = {{-34, 14}, {-30, 14}, {-30, 0}, {-20, 0}}, color = {127, 0, 127}));
        connect(FF2.q, FF3.clk) annotation(Line(
          points = {{20, 14}, {24, 14}, {24, 0}, {34, 0}}, color = {127, 0, 127}));
        connect(FF2.j, enable) annotation(Line(
          points = {{-20, 14}, {-26, 14}, {-26, 70}, {-100, 70}}, color = {127, 0, 127}));
        connect(FF2.k, FF2.j) annotation(Line(
          points = {{-20, -14}, {-26, -14}, {-26, 14}, {-20, 14}}, color = {127, 0, 127}));
        connect(FF3.k, FF3.j) annotation(Line(
          points = {{34, -14}, {28, -14}, {28, 14}, {34, 14}}, color = {127, 0, 127}));
        connect(FF3.j, enable) annotation(Line(
          points = {{34, 14}, {28, 14}, {28, 70}, {-100, 70}}, color = {127, 0, 127}));
        connect(FF3.q, q2) annotation(Line(
          points = {{74, 14}, {80, 14}, {80, 70}, {100, 70}}, color = {127, 0, 127}));
        connect(FF1.q, q0) annotation(Line(points = {{-34, 14}, {-30, 14}, {-30, -70}, {
          100, -70}}, color = {127, 0, 127}));
        connect(FF2.q, q1) annotation(Line(points = {{20, 14}, {24, 14}, {24, -50}, {86, 
          -50}, {86, 0}, {100, 0}}, color = {127, 0, 127}));
        annotation(
          Documentation(info = "<html>
<p>Counter3在使能信号为真时计数计数信号的高低电平。它由三个JK 触发器组成。q0、q1和q2是结果数字的位，其中q0是最低位，q2是最高位。</p>
</html>"                ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Text(
          extent = {{-80, 80}, {-40, 60}}, 
          textString = "ENABLE"), 
          Text(
          extent = {{64, 80}, {86, 60}}, 
          textString = "Q2"), 
          Text(
          extent = {{64, -60}, {86, -80}}, 
          textString = "Q0"), 
          Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), 
          Text(
          extent = {{-60, 40}, {60, 0}}, 
          textString = "Counter3"), 
          Text(
          extent = {{-80, -60}, {-40, -80}}, 
          textString = "COUNT"), 
          Text(
          extent = {{62, 8}, {84, -12}}, 
          textString = "Q1")}));
      end Counter3;

      model Counter "通用N位计数器"
        import D = Modelica.Electrical.Digital;
        import L = Modelica.Electrical.Digital.Interfaces.Logic;

        parameter Integer n = 3 "位数";
        parameter SI.Time delayTime = 0.001 "每个 JKFF 的延迟时间";
        parameter D.Interfaces.Logic q0 = L.'0' "初始值";
        D.Interfaces.DigitalInput enable 
          annotation(Placement(transformation(extent = 
          {{-110, 60}, {-90, 80}})));
        D.Interfaces.DigitalInput count 
          annotation(Placement(transformation(extent = 
          {{-110, -80}, {-90, -60}})));
        D.Examples.Utilities.JKFF FF[n](each delayTime = delayTime, each q0 = q0);
        D.Interfaces.DigitalOutput q[n] annotation(Placement(transformation(
          extent = {{90, -80}, {110, 80}})));
      equation
        connect(enable, FF[1].j);
        connect(enable, FF[1].k);
        connect(count, FF[1].clk);
        connect(FF[1].q, q[1]);
        for i in 2:n loop
          connect(enable, FF[i].j);
          connect(enable, FF[i].k);
          connect(FF[i - 1].q, FF[i].clk);
          connect(FF[i].q, q[i]);
        end for;
        annotation(
          Documentation(info = "<html>
<p>计数器是一个通用组件，如果使能信号被设置为真，则计数信号的高低电平将被计数。它由n个JK触发器组成。q是结果数字，其中q[0]是最低位，q[n]是最高位。</p>
</html>"                ), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Rectangle(
          extent = {{90, 80}, {110, -80}}, 
          lineColor = {127, 0, 127}, 
          fillColor = {127, 0, 127}, 
          fillPattern = FillPattern.Solid)}), 
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
          {100, 100}}), graphics = {
          Rectangle(
          extent = {{90, 80}, {110, -80}}, 
          lineColor = {127, 0, 127}, 
          fillColor = {127, 0, 127}, 
          fillPattern = FillPattern.Solid), 
          Rectangle(
          extent = {{-90, 100}, {90, -100}}, 
          lineThickness = 0.5, 
          fillColor = {255, 255, 170}, 
          fillPattern = FillPattern.Solid), 
          Text(
          extent = {{-80, 80}, {-40, 60}}, 
          textString = "ENABLE"), 
          Text(
          extent = {{66, 8}, {88, -12}}, 
          textString = "Q"), 
          Text(
          extent = {{-150, -100}, {150, -160}}, 
          textColor = {0, 0, 255}, 
          textString = "%name"), 
          Text(
          extent = {{-40, 40}, {40, 0}}, 
          textString = "Counter"), 
          Text(
          extent = {{-80, -60}, {-40, -80}}, 
          textString = "COUNT")}));
      end Counter;
      annotation(Documentation(info = "<html>

<p>这个库含Examples库使用的实用组件。每个组件都是由Gates库中的组件层次构建起来的。这样就可以测试Gates组件的使用方法，并演示其功能。
</p>
</html>"          ));
    end Utilities;


  annotation(Documentation(info = "<html>
<p>这个库包含演示Electrical.Digital库组件用法的示例。</p>
<p>这些示例简单易懂。它们将展示组件的典型行为，并为用户提供提示。</p>
</html>"  ));

  end Examples;

  package Interfaces "基本定义"
    extends Modelica.Icons.InterfacesPackage;

    type Logic = enumeration(
      'U' "U  未初始化", 
      'X' "X  强制未知", 
      '0' "0  强制0", 
      '1' "1  强制1", 
      'Z' "Z  高阻", 
      'W' "W  弱未知", 
      'L' "L  弱0", 
      'H' "H  弱1", 
      '-' "-  无关") "逻辑值及其根据IEEE 1164 STD_ULOGIC类型进行编码的编码" 
      annotation(Documentation(info = "<html>
<p><strong>代码表：</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>逻辑值</strong></td>
<td><strong>含义</strong></td>
</tr>

<tr><td>'U'</td> <td>未初始化</td></tr>
<tr><td>'X'</td> <td>强制未知</td></tr>
<tr><td>'0'</td> <td>强制0</td></tr>
<tr><td>'1'</td> <td>强制1</td></tr>
<tr><td>'Z'</td> <td>高阻</td></tr>
<tr><td>'W'</td> <td>弱未知</td></tr>
<tr><td>'L'</td> <td>弱0</td></tr>
<tr><td>'H'</td> <td>弱1</td></tr>
<tr><td>'-'</td> <td>无关</td></tr>
</table>

</html>"      ));

    type UX01 = enumeration(
      'U' "U  未初始化", 
      'X' "X  强制未知", 
      '0' "0  强制0", 
      '1' "1  强制1") "IEEE1164 STD_ULOGIC类型的4值子类型" 
      annotation(Documentation(info = "<html>
<p><strong>代码表：</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>逻辑值</strong></td>
<td><strong>含义</strong></td>
</tr>

<tr><td>'U'</td> <td>未初始化</td></tr>
<tr><td>'X'</td> <td>强制未知</td></tr>
<tr><td>'0'</td> <td>强制0</td></tr>
<tr><td>'1'</td> <td>强制1</td></tr>

</table>
</html>"      ));
    type Strength = enumeration(
      'S_X01' "S_X01  强制 X, 0 和 1", 
      'S_X0H' "S_X0H  强制 X, 0 和 弱1", 
      'S_XL1' "S_XL1  强制 X, 1 和 弱0", 
      'S_X0Z' "S_X0Z  强制 X, 0 和 高阻", 
      'S_XZ1' "S_XZ1  强制 X, 1 和 高阻", 
      'S_WLH' "S_WLH  弱 X, 0 和 1", 
      'S_WLZ' "S_WLZ  弱 X, 0 和 高阻", 
      'S_WZH' "S_WZH  弱 X, 1 和 高阻", 
      'S_W0H' "S_W0H  弱 X, 1 和 强制0", 
      'S_WL1' "S_WL1  弱 X, 0 和 强制1") "寄存器的输出强度" annotation(Documentation(info = "<html>

<p><strong>强度表：</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>强度</strong></td>
    <td><strong>输出转换为</strong></td>
</tr>

<tr><td>'S_X01'</td> <td>强制 X, 0, 1</td></tr>
<tr><td>'S_X0H'</td> <td>强制 X, 0 和 弱1</td></tr>
<tr><td>'S_XL1'</td> <td>强制 X, 1 和 弱0</td></tr>
<tr><td>'S_X0Z'</td> <td>强制 X, 0 和 高阻</td></tr>
<tr><td>'S_XZ1'</td> <td>强制 X, 1 和 高阻</td></tr>
<tr><td>'S_WLH'</td> <td>弱 X, 0, 1</td></tr>
<tr><td>'S_WLZ'</td> <td>弱 X, 0 和 高阻</td></tr>
<tr><td>'S_WZH'</td> <td>弱 X, 1 和 高阻</td></tr>
<tr><td>'S_W0H'</td> <td>弱 X, 1 和 强制0</td></tr>
<tr><td>'S_WL1'</td> <td>弱 X, 0 和 强制1</td></tr>
</table>
</html>"  ));

    connector DigitalSignal = Logic "数字端口(可输入/输出)" 
      annotation(Documentation(info = "<html>
<p>DigitalSignal是基本数字连接器定义。方向(输入、输出)尚未定义。DigitalSignal是Logic类型的。它可以具有逻辑值(U、X、0、1等)，这些逻辑值通过使用枚举进行内部编码(参见Logic类型的定义)。</p>
</html>"          ));

    connector DigitalInput = input DigitalSignal "输入DigitalSignal连接器" 
      annotation(defaultComponentName = "x", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
      {100, 100}}), graphics = {Rectangle(
      extent = {{-100, -100}, {100, 100}}, 
      lineColor = {127, 0, 127}, 
      fillColor = {127, 0, 127}, 
      fillPattern = FillPattern.Solid)}), 
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
      -100}, {100, 100}}), graphics = {Text(
      extent = {{-150, -100}, {150, -160}}, 
      textColor = {127, 0, 127}, 
      textString = "%name"), Rectangle(
      extent = {{-100, -100}, {100, 100}}, 
      lineColor = {127, 0, 127}, 
      fillColor = {127, 0, 127}, 
      fillPattern = FillPattern.Solid)}), 
      Documentation(info = "<html>
<p>DigitalInput是数字输入连接器定义。DigitalInput是Logic类型的。它可以具有逻辑值(U、X、0、1等)，这些逻辑值通过使用枚举进行内部编码(参见Logic类型的定义)。</p>
</html>"      ));

    connector DigitalOutput = output DigitalSignal "输出DigitalSignal连接器" 
      annotation(defaultComponentName = "y", Icon(coordinateSystem(
      preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
      graphics = {Polygon(
      points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
      lineColor = {127, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid)}), 
      Diagram(coordinateSystem(
      preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
      graphics = {Polygon(
      points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}}, 
      lineColor = {127, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid), Text(
      extent = {{-150, -100}, {150, -160}}, 
      textColor = {127, 0, 127}, 
      textString = "%name")}), 
      Documentation(info = 
      "<html>
<p>DigitalOutput是数字输出连接器定义。DigitalOutput是Logic类型的。它可以具有逻辑值(U、X、0、1等)，这些逻辑值通过使用枚举进行内部编码(参见Logic类型的定义)。箭头形状表示信号流方向。</p>
</html>"      ));

    partial block SISO "单输入，单输出"
      import D = Modelica.Electrical.Digital;
      D.Interfaces.DigitalInput x "Digital 输入信号连接器" 
        annotation(Placement(transformation(extent = {{-70, -10}, {-50, 
        10}})));
      D.Interfaces.DigitalOutput y "Digital 输出信号连接器" 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 
        10}})));
      annotation(Icon(
        coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), Line(points = {{50, 0}, {92, 0}}, 
        color = {127, 0, 127})}), 
        Documentation(info = "<html>
<p>SISO是连接模式的部分模型，具有单个(标量)数字输入和单个(标量)数字输出。除了连接器外，它还提供了一个可以由继承SISO模型的组件填充的图标矩形。</p>
</html>"      ));
    end SISO;

    partial block MISO "多输入-单输出"
      import D = Modelica.Electrical.Digital;

      parameter Integer n(final min = 2) = 2 "输入数量";
      D.Interfaces.DigitalInput x[n] 
        "数字输入信号矢量的连接器" 
        annotation(Placement(transformation(
        extent = {{-70, -80}, {-50, 80}})));
      D.Interfaces.DigitalOutput y "数字输出信号连接器" 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 
        10}})));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), Line(points = {{50, 0}, {90, 0}}, 
        color = {127, 0, 127})}), 
        Documentation(info = "<html>
<p>MISO是连接模式的部分模型，具有多个(矢量)数字输入和单个(标量)数字输出。除了连接器外，它还提供了一个可以由继承MISO模型的组件填充的图标矩形。</p>
</html>"          ));
    end MISO;

    partial block MIMO "多输入-多输出"
      import D = Modelica.Electrical.Digital;

      parameter Integer n(final min = 1) = 1 
        "输入数量=输出数量";
      D.Interfaces.DigitalInput x[n] 
        "数字输入信号矢量的连接器" 
        annotation(Placement(transformation(
        extent = {{-70, -80}, {-50, 80}})));
      D.Interfaces.DigitalOutput y[n] 
        "数字输出信号矢量的连接器" 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 
        10}})));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(points = {{50, 0}, {90, 0}}, color = {127, 0, 127}), 
        Rectangle(
        extent = {{50, 80}, {70, -80}}, 
        lineColor = {127, 33, 107}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}), 
        Documentation(info = "<html>
<p>MIMO是连接模式的部分模型，具有多个(矢量)数字输入和多个(矢量)数字输出。除了连接器外，它还提供了一个可以由继承MISO模型的组件填充的图标矩形。</p>
</html>"      ));
    end MIMO;

    partial model MemoryBase "内存元素的基础模型"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;

      parameter SI.Time tHL = 0 "高->低延迟";
      parameter SI.Time tLH = 0 "低->高延迟";
      parameter S strength = S.'S_X01' "输出强度";
      parameter Integer n_addr(min = 1) = 2 "地址位宽";
      parameter Integer n_data(min = 1) = 2 "数据位宽";
      parameter String fileName = Modelica.Utilities.Files.loadResource("modelica://Modelica/Resources/Data/Electrical/Digital/Memory_Matrix.txt") 
        "存储内存矩阵的文件" 
        annotation(Dialog(group = "表数据定义", loadSelector(filter = "Text files (*.txt)", caption = "打开包含表的文件")));

      DigitalInput RE "读取使能" annotation(Placement(transformation(
        extent = {{-100, -30}, {-84, -14}}), iconTransformation(extent = {{-100, -30}, {-84, -14}})));
      DigitalInput addr[n_addr] "地址" annotation(Placement(transformation(
        extent = {{-100, 50}, {-80, 70}}), iconTransformation(extent = {{-100, 50}, {-80, 70}})));
      DigitalOutput dataOut[n_data] "数据输出" annotation(Placement(transformation(
        extent = {{80, 10}, {100, 30}}), iconTransformation(extent = {{80, 10}, {100, 30}})));

      function getMemory "获取内存"
        extends Modelica.Icons.Function;
        input String filename;
        input Integer n_addr "地址位宽";
        input Integer n_data "数据位宽";
        output L m[integer(2 ^ n_addr),n_data] "带有数据的内存，最低位在左侧";
        output String data;
        output Integer bit;
        annotation();
      algorithm
        for i in 1:(2 ^ n_addr) loop
          data := Modelica.Utilities.Streams.readLine(filename, integer(i));
          for j in 1:n_data loop
            bit := Modelica.Utilities.Strings.scanInteger(data, (2 * j - 1));
            if bit == 1 then
              m[integer(i),j] := L.'1';
            elseif bit == 0 then
              m[integer(i),j] := L.'0';
            else
              m[integer(i),j] := L.'X';
            end if;
          end for;
        end for;
      end getMemory;

    protected
      L nextstate[n_data](start = fill(L.'U', n_data));
      L mem_word[n_data](start = fill(L.'U', n_data));
      Integer int_addr;
      DigitalOutput yy[n_data](start = fill(L.'U', n_data));
      D.Delay.InertialDelaySensitive inertialDelaySensitive[n_data](each tLH = tLH, each tHL = tHL);

      function address "计算内存地址"
        extends Modelica.Icons.Function;
        input Integer n_addr;
        input L addr[n_addr];
        output Integer int_addr;
      protected
        L addr_bit;
        annotation();
      algorithm
        int_addr := 1;
        for i in 1:n_addr loop
          addr_bit := T.X01Table[addr[i]];
          if addr_bit == L.'1' then
            int_addr := int_addr + integer(2 ^ (i - 1));
          elseif addr_bit == L.'X' then
            int_addr := 0;
            break;
          end if;
        end for;
      end address;

    equation
      for i in 1:n_data loop
        connect(yy[i], inertialDelaySensitive[i].x);
        connect(inertialDelaySensitive[i].y, dataOut[i]);
      end for;

      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-60, 80}, {60, -80}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5), 
        Line(
        points = {{-84, 60}, {-60, 60}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{60, 20}, {84, 20}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-84, -20}, {-60, -20}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{-60, -10}, {-46, -20}, {-60, -30}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-41, -5}, {-24, -34}}, 
        textColor = {127, 33, 107}, 
        textString = "RE")}));
    end MemoryBase;

    annotation(Documentation(info = "<html>
<p>此处包含基本定义：Logic和Strength的类型定义，数字电气组件的接口定义(连接器)，以及经常使用的连接模式的部分模型。</p>
</html>"  ));
  end Interfaces;

  package Tables "所有组件的真值表"
    extends Modelica.Icons.Package;

    import D = Modelica.Electrical.Digital;
    import L = Modelica.Electrical.Digital.Interfaces.Logic;
    import R = Modelica.Electrical.Digital.Interfaces.UX01;
    import S = Modelica.Electrical.Digital.Interfaces.Strength;

    constant D.Interfaces.Logic AndTable[L, L]=[
        L.'U', L.'U', L.'0', L.'U', L.'U', L.'U', L.'0', L.'U', L.'U';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X';
        L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0', L.'0';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'X', L.'X', L.'0', L.'X', L.'X'] 
      "'and'的9值逻辑";

    constant D.Interfaces.Logic OrTable[L, L]=[
        L.'U', L.'U', L.'U', L.'1', L.'U', L.'U', L.'U', L.'1', L.'U';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1', L.'1';
        L.'U', L.'X', L.'X', L.'1', L.'X', L.'X', L.'X', L.'1', L.'X'] 
      "'or'的9值逻辑";

    constant D.Interfaces.Logic NotTable[L]={
        L.'U',L.'X',L.'1',L.'0',L.'X',L.'X',L.'1',L.'0',L.'X'} 
      "'not'的9值逻辑";

    constant D.Interfaces.Logic XorTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'1', L.'0', L.'X', L.'X', L.'1', L.'0', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'X', L.'X', L.'0', L.'1', L.'X';
        L.'U', L.'X', L.'1', L.'0', L.'X', L.'X', L.'1', L.'0', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X'] 
      "'xor'的9值逻辑";

    constant D.Interfaces.Logic ResolutionTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'X', L.'0', L.'0', L.'0', L.'0', L.'X';
        L.'U', L.'X', L.'X', L.'1', L.'1', L.'1', L.'1', L.'1', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'W', L.'W', L.'W', L.'W', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'L', L.'W', L.'L', L.'W', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'H', L.'W', L.'W', L.'H', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X'] 
      "'wiredX'的9值逻辑";
    constant D.Interfaces.Logic X01Table[L]={
        L.'X',L.'X',L.'0',L.'1',L.'X',L.'X',L.'0',L.'1',L.'X'};

    constant D.Interfaces.Logic X01ZTable[L]={
        L.'X',L.'X',L.'0',L.'1',L.'Z',L.'X',L.'0',L.'1',L.'Z'};

    constant D.Interfaces.Logic UX01Table[L]={
        L.'U',L.'X',L.'0',L.'1',L.'X',L.'X',L.'0',L.'1',L.'X'};

    constant D.Interfaces.UX01 UX01Conv[L]={
        R.'U',R.'X',R.'0',R.'1',R.'X',R.'X',R.'0',R.'1',R.'X'};

    constant Integer DelayTable[L, L]=[
         0,  0, -1,  1,  0,  0, -1,  1,  0;
         0,  0, -1,  1,  0,  0, -1,  1,  0;
         1,  1,  0,  1,  1,  1,  0,  1,  1;
        -1, -1, -1,  0, -1, -1, -1,  0, -1;
         0,  0, -1,  1,  0,  0, -1,  1,  0;
         0,  0, -1,  1,  0,  0, -1,  1,  0;
         1,  1,  0,  1,  1,  1,  0,  1,  1;
        -1, -1, -1,  0, -1, -1, -1,  0, -1;
         0,  0, -1,  1,  0,  0, -1,  1,  0] "读取[old_signal, new_signal]时信号变化的延迟选择:
  -1: 高低延迟 |
   0: 没有延迟 |
   1: 低延迟"    ;

    constant Integer ClockMap[L, L]=[
        0, 0, 0, 2, 0, 0, 0, 2, 0;
        0, 0, 0, 2, 0, 0, 0, 2, 0;
        2, 2, 0, 1, 2, 2, 0, 1, 2;
        0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 2, 0, 0, 0, 2, 0;
        0, 0, 0, 2, 0, 0, 0, 2, 0;
        2, 2, 0, 1, 2, 2, 0, 1, 0;
        0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 2, 0, 0, 0, 2, 0] "通过 [pre(clock)，clock] 读数进行边缘检测：
0: 0-过渡 |
1: 上升沿  |
2: X 过渡"    ;

    constant D.Interfaces.Logic StrengthMap[L, S]= 
        [L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
         L.'X', L.'X', L.'X', L.'X', L.'X', L.'W', L.'W', L.'W', L.'W', L.'W';
         L.'0', L.'0', L.'L', L.'0', L.'Z', L.'L', L.'L', L.'Z', L.'0', L.'L';
         L.'1', L.'H', L.'1', L.'Z', L.'1', L.'H', L.'Z', L.'H', L.'H', L.'1';
         L.'X', L.'X', L.'X', L.'X', L.'X', L.'W', L.'W', L.'W', L.'W', L.'W';
         L.'X', L.'X', L.'X', L.'X', L.'X', L.'W', L.'W', L.'W', L.'W', L.'W';
         L.'0', L.'0', L.'L', L.'0', L.'Z', L.'L', L.'L', L.'Z', L.'0', L.'L';
         L.'1', L.'H', L.'1', L.'Z', L.'1', L.'H', L.'Z', L.'H', L.'H', L.'1';
         L.'X', L.'X', L.'X', L.'X', L.'X', L.'W', L.'W', L.'W', L.'W', L.'W'] 
      "通过 [信号，强度] 读数转换输出强度";

    constant D.Interfaces.Logic NXferTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X'] 
      "NX Transfer by [enable, input] reading";

    constant D.Interfaces.Logic NRXferTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'W', L.'L', L.'H', L.'Z', L.'W', L.'L', L.'H', L.'W';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'W', L.'L', L.'H', L.'Z', L.'W', L.'L', L.'H', L.'W';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W'] 
      "通过读取 [启用、输入] 进行 NRX 传输";

    constant D.Interfaces.Logic PXferTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X';
        L.'U', L.'X', L.'0', L.'1', L.'Z', L.'W', L.'L', L.'H', L.'X';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X', L.'X'] 
      "通过读取 [启用、输入] 进行 PX 传输";

    constant D.Interfaces.Logic PRXferTable[L, L]=[
        L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U', L.'U';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'U', L.'W', L.'L', L.'H', L.'Z', L.'W', L.'L', L.'H', L.'W';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W';
        L.'U', L.'W', L.'L', L.'H', L.'Z', L.'W', L.'L', L.'H', L.'W';
        L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z', L.'Z';
        L.'U', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W', L.'W'] 
      "通过读取 [启用、输入] 进行 PRX 传输";

    constant D.Interfaces.Logic Buf3sTable[S, R, R]=[
        {{{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'0',L.'1'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'0',L.'H'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'L',L.'1'}}, 
         {{L.'U',L.'U',L.'U',L.'Z'},{L.'U',L.'X',L.'X',L.'Z'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'0',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'X',L.'Z',L.'1'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'L',L.'H'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'Z'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'L',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'Z',L.'H'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'0',L.'H'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'Z',L.'Z',L.'Z',L.'Z'},{L.'U',L.'W',L.'L',L.'1'}}}] 
      "按 [强度、启用、输入] 读取的三态表，高活性启用";

    constant D.Interfaces.Logic Buf3slTable[S, R, R]=[
        {{{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'0',L.'1'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'0',L.'H'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'L',L.'1'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'Z'},{L.'U',L.'X',L.'X',L.'Z'},{L.'U',L.'X',L.'0',L.'Z'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'Z',L.'1'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'U',L.'W',L.'L',L.'H'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'Z'},{L.'U',L.'W',L.'L',L.'Z'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'U',L.'W',L.'Z',L.'H'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'U',L.'W',L.'0',L.'H'},{L.'Z',L.'Z',L.'Z',L.'Z'}}, 
         {{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'W',L.'W',L.'W'},{L.'U',L.'W',L.'L',L.'1'},{L.'Z',L.'Z',L.'Z',L.'Z'}}}] 
      "按 [强度、启用、输入] 读取的三态表，低电平启用";

    constant D.Interfaces.Logic MUX2x1Table[R, R, R]=[
        {{{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'U',L.'U',L.'U'},{L.'U',L.'X',L.'0',L.'1'},{L.'U',L.'U',L.'U',L.'U'}}, 
         {{L.'U',L.'X',L.'U',L.'U'},{L.'U',L.'X',L.'X',L.'X'},{L.'U',L.'X',L.'0',L.'1'},{L.'X',L.'X',L.'X',L.'X'}}, 
         {{L.'U',L.'U',L.'0',L.'U'},{L.'U',L.'X',L.'0',L.'X'},{L.'U',L.'X',L.'0',L.'1'},{L.'0',L.'0',L.'0',L.'0'}}, 
         {{L.'U',L.'U',L.'U',L.'1'},{L.'U',L.'X',L.'X',L.'1'},{L.'U',L.'X',L.'0',L.'1'},{L.'1',L.'1',L.'1',L.'1'}}}] 
      "按 [选择、输入 1、输入 0] 读取的多路复用器表";

    annotation (Documentation(info="<html>

</html>"    ));
  end Tables;

  package Delay "延迟模块"
    extends Modelica.Icons.Package;

    partial block DelayParams "延迟参数的定义"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      parameter SI.Time tLH(start = 0) "上升惯性延迟";
      parameter SI.Time tHL(start = 0) "下降惯性延迟";
      parameter L y0 = L.'U' "输出的初始值";
      annotation(Documentation(info = "<html>
<p>DelayParams是一个提供延迟时间和惯性值的部分模型。它用于需要相同参数的Gates库的组件中。部分模型没有任何工作输出或方程。</p>
</html>"      ));
    end DelayParams;

    model TransportDelay "具有初始参数的传输延迟"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.SISO(x(start = L.'U', fixed = true));
      parameter SI.Time delayTime(start = 0) "延迟时间";
      parameter D.Interfaces.Logic y0 = L.'U' "输出的初始值";
      constant D.Interfaces.Logic LogicValues[:] = L.'U':L.'-';
    protected
      D.Interfaces.Logic x_delayed;
      Real xr "在 delay() 中使用的实型辅助变量";

    equation
      xr = Integer(pre(x));
      x_delayed = LogicValues[integer(delay(xr, delayTime))];
      y = if delayTime > 0 then 
        (if time >= delayTime then x_delayed else y0) else 
        pre(x);
      annotation(Documentation(info = "<html>
<p>
提供输入作为延迟了<em>Tdel</em>的输出。
如果时间小于<em>Tdel</em>，则保持初始值 <em>initout</em>。
</p>
</html>"      , revisions = "<html>
<dl>
<dt><em>2003年8月11日</em></dt>
<dd>由Christoph Clauss最初建模。</dd>
</dl>
</html>"      ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
        100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Polygon(points = {{-6, 60}, {-16, 40}, {4, 40}, {-6, 60}}), 
        Line(points = {{0, 60}, {20, 60}}), 
        Line(points = {{10, 60}, {10, 40}}), 
        Text(
        extent = {{-50, -40}, {50, -20}}, 
        textString = "传输"), 
        Text(
        extent = {{-50, -60}, {50, -40}}, 
        textString = "延迟")}));
    end TransportDelay;

    block InertialDelay "具有初始参数的惯性延迟"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.SISO;
      parameter SI.Time delayTime(start = 0) 
        "保持值的最小时间";
      parameter D.Interfaces.Logic y0 = L.'U' "输出y的初始值";
    protected
      D.Interfaces.Logic y_auxiliary(start = y0, fixed = true);
      D.Interfaces.Logic x_old(start = y0, fixed = true);
      discrete SI.Time t_next(start = delayTime, fixed = true);

    algorithm
      when delayTime > 0 and change(x) then
        x_old := x;
        t_next := time + delayTime;
      elsewhen time >= t_next then
        y_auxiliary := x;
      end when;
      y := if delayTime > 0 then y_auxiliary else x;
      annotation(
        Documentation(info = "<html>
<p>
如果输入保持其值的时间超过<em>delayTime</em>，则提供输入作为延迟了<em>delayTime</em>的输出。
如果时间小于<em>delayTime</em>，则保持初始值<em>y0</em>。
</p>
</html>"          , revisions = "<html>
<dl>
<dt><em>2003年8月12日</em></dt>
<dd>由Christoph Clauss修订</dd>
<dt><em>2003年3月19日</em></dt>
<dd>由Martin Otter最初建模。</dd>
</dl>
</html>"          ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Polygon(points = {{-6, 60}, {-16, 40}, {4, 40}, {-6, 60}}), 
        Line(points = {{10, 60}, {10, 40}}), 
        Line(points = {{0, 60}, {20, 60}}), 
        Text(
        extent = {{-50, -40}, {50, -20}}, 
        textString = "惯性"), 
        Text(
        extent = {{-50, -60}, {50, -40}}, 
        textString = "延迟")}));
    end InertialDelay;

    model InertialDelaySensitive "如果输入保持其值一定时间，则提供输入作为输出"

      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.SISO(x(start = L.'U', fixed = true), y(start = y0, fixed = true));
      parameter SI.Time tLH(start = 0) "上升惯性延迟";
      parameter SI.Time tHL(start = 0) "下降惯性延迟";
      parameter D.Interfaces.Logic y0 = L.'U' "输出的初始值";
    protected
      constant Integer delayTable[L,L] = Modelica.Electrical.Digital.Tables.DelayTable 
        "根据信号变化规定的延迟表";
      SI.Time delayTime;
      D.Interfaces.Logic y_auxiliary(start = y0, fixed = true);
      D.Interfaces.Logic y_old(start = y0, fixed = true);
      Integer lh;
      discrete SI.Time t_next;

    algorithm
      when {initial(), (tLH > 0 or tHL > 0) and change(x) and not initial()} then
        y_old := if initial() or pre(y) == L.'U' then y0 else pre(y);
        lh := delayTable[y_old,x];
        delayTime := if (lh > 0) then tLH else (if (lh < 0) then tHL else 0);
        t_next := time + delayTime;
        if (lh == 0 or abs(delayTime) < Modelica.Constants.small) then
          y_auxiliary := x;
        end if;
      elsewhen time >= t_next then
        y_auxiliary := x;
      end when;
      y := if ((tLH > 0 or tHL > 0)) then y_auxiliary else x;
      annotation(
        Documentation(info = "<html>
<p>
如果输入保持其值的时间超过<em>Tdel</em>，则提供输入作为延迟了<em>Tdel</em>的输出。
如果时间小于<em>Tdel</em>，则保持初始值<em>y0</em>。<br>
延迟<em>Tdel</em>取决于信号变化的值。要计算<em>Tdel</em>，使用 Digital.Tables中指定的DelayTable。
如果对应的值为1，则使用<em>tLH</em>，如果为-1，则使用<em>tHL</em>，如果为零，则输入不延迟。
</p>
</html>"          , revisions = "<html>
<ul>
<li><em>2013年1月24日</em>由Kristin Majetta和Christoph Clauss将y的初始值设置为y0</li>
<li><em>2009年9月8日</em>由Ulrich Donath使用pre(y)和x选择 <em>tHL</em> 或 <em>tLH</em></li>
<li><em>2005年1月13日</em>由Dynasim改进 when 条件和delayTable的声明</li>
<li><em>2004年9月15日</em>由Christoph Clauss更改颜色、更改名称</li>
<li><em>2004年5月12日</em>由Christoph Clauss替换了对<em>if Tdel=0</em> 的测试</li>
<li><em>2004年2月5日</em>由Christoph Clauss修订了处理<em>tHL=0</em>或<em>tLH=0</em></li>
<li><em>2003年10月12日</em>由Christoph Clauss最初建模</li>
</ul>
</html>"          ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-50, -40}, {50, -20}}, 
        textString = "惯性"), 
        Text(
        extent = {{-50, -60}, {50, -40}}, 
        textString = "延迟"), 
        Text(
        extent = {{-50, -80}, {50, -60}}, 
        textString = "敏感"), 
        Polygon(points = {{-6, 60}, {-16, 40}, {4, 40}, {-6, 60}}), 
        Line(points = {{10, 60}, {10, 40}}), 
        Line(points = {{0, 60}, {20, 60}})}));
    end InertialDelaySensitive;

    model InertialDelaySensitiveVector "数字信号向量的延迟"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter SI.Time tHL = 0 "高->低延迟";
      parameter SI.Time tLH = 0 "低->高延迟";
      parameter Integer n(min = 1) = 1 "数据宽度";
      D.Interfaces.DigitalInput x[n] 
        annotation(Placement(transformation(extent = {{-100, -12}, {-76, 12}}), 
        iconTransformation(extent = {{-100, -15}, {-72, 14}})));
      D.Interfaces.DigitalOutput y[n] annotation(Placement(transformation(
        extent = {{72, -14}, {100, 14}}), iconTransformation(extent = {{72, -14}, 
        {100, 14}})));
      Digital.Delay.InertialDelaySensitive inertialDelaySensitive[n](each tLH = 
        tLH, each tHL = tHL);
    equation
      for i in 1:n loop
        connect(x[i], inertialDelaySensitive[i].x);
        connect(inertialDelaySensitive[i].y, y[i]);
      end for;
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-50, 54}, {48, -54}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillPattern = FillPattern.Solid, 
        fillColor = {255, 255, 255}), 
        Line(
        points = {{-80, 0}, {-50, 0}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{48, 0}, {80, 0}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-40, 52}, {38, -20}}, 
        textColor = {127, 33, 107}, 
        textString = "延迟"), 
        Text(
        extent = {{-26, 12}, {18, -32}}, 
        textColor = {127, 0, 127}, 
        textString = "信号"), 
        Text(
        extent = {{-32, 0}, {28, -62}}, 
        textColor = {127, 0, 127}, 
        textString = "敏感")}), Documentation(info = "<html>

<p>
延迟元件<strong>Inertial Delay Sensitive</strong>适用于n个信号的向量。
参数<em>tLH</em>和<em>tHL</em>对每个信号都有效。
</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2009年9月11日</em>由 Ulrich Donath创建</li>
</ul>
</html>"      ));
    end InertialDelaySensitiveVector;
    annotation(Documentation(info = "<html>
<p>Delay库收集了许多组件中使用的延迟块。标量连接器提供了传输和惯性延迟。最先进的组件是敏感惯性延迟，其延迟时间根据信号值的依赖性选择。该组件还适用于向量输入。</p>
</html>"  ));
  end Delay;

  package Basic "不带延迟的基本逻辑块"
    extends Modelica.Icons.Package;

    model Not "不带延迟的非逻辑组件"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.SISO;
    protected
      D.Interfaces.Logic auxiliary(start = L.'0', fixed = true);
    equation
      auxiliary = Modelica.Electrical.Digital.Tables.NotTable[x];
      y = pre(auxiliary);
      annotation(
        Documentation(info = "<html>
<p>带有一个输入值的非逻辑组件，无延迟。</p>
<p>根据标准逻辑非真值表(Tables.NotTable)计算输出值。</p>
<p>为避免在数值处理中出现循环，对输出应用预操作符。</p>
</html>"    , revisions = "<html>
<dl>
<dt><em>2003年8月14日</em></dt>
<dd>由Teresa Schlegel最初建模。</dd>
</dl>
</html>"    ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = "1"), 
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Ellipse(
        extent = {{50, 6}, {62, -6}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}));
    end Not;

    model And "具有多个输入和一个输出的与逻辑组件"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.MISO;
    protected
      D.Interfaces.Logic auxiliary[n](each start = L.'U');
      D.Interfaces.Logic auxiliary_n(start = L.'U', fixed = true);
    equation
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = Modelica.Electrical.Digital.Tables.AndTable[
          auxiliary[i],x[i + 1]];
      end for;
      auxiliary_n = auxiliary[n];
      y = pre(auxiliary_n);
      annotation(
        Documentation(info = "<html>
<p>具有多个输入值和一个输出的与组件。</p>
<p>根据标准逻辑和表(Tables.AndTable)计算输出值。</p>
<p>为避免在数值处理中出现循环，对输出应用预操作符。</p>
</html>"    , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>Christoph Clauss使用向量方法处理所有固定数量的输入</li>
<li><em>2003年10月22日</em>Teresa Schlegel最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = "&"), Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}));
    end And;

    model Nand "具有多个输入和一个输出的与非逻辑组件"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.MISO;
    protected
      D.Interfaces.Logic auxiliary[n](each start = L.'U');
      D.Interfaces.Logic auxiliary_n(start = L.'U', fixed = true);
    equation
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = Modelica.Electrical.Digital.Tables.AndTable[
          auxiliary[i],x[i + 1]];
      end for;
      auxiliary_n = Modelica.Electrical.Digital.Tables.NotTable[auxiliary[n]];
      y = pre(auxiliary_n);
      annotation(
        Documentation(info = "<html>
<p>具有多个输入值和一个输出的与非组件。</p>
<p>根据标准逻辑和表(Tables.AndTable)计算中间值，然后应用非表(Tables.NotTable)。</p>
<p>为避免在数值处理中出现循环，对输出应用预操作符。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>Christoph Clauss使用向量方法处理所有固定数量的输入</li>
<li><em>2003年10月22日</em>Teresa Schlegel最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = "&"), 
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Ellipse(
        extent = {{50, 6}, {62, -6}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}));
    end Nand;

    model Or "具有多个输入和一个输出的或逻辑组件"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.MISO;
    protected
      D.Interfaces.Logic auxiliary[n](each start = L.'U');
      D.Interfaces.Logic auxiliary_n(start = L.'U', fixed = true);
    equation
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = Modelica.Electrical.Digital.Tables.OrTable[
          auxiliary[i],x[i + 1]];
      end for;
      auxiliary_n = auxiliary[n];
      y = pre(auxiliary_n);
      annotation(
        Documentation(info = "<html>
<p>具有多个输入值和一个输出的或组件。</p>
<p>根据标准逻辑或表(Tables.OrTable)计算输出值。</p>
<p>为避免在数值处理中出现循环，对输出应用预操作符。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>Christoph Clauss使用向量方法处理所有固定数量的输入</li>
<li><em>2003年10月22日</em>Teresa Schlegel最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = ">=1"), Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}));
    end Or;

    model Nor "具有多个输入和一个输出的非或逻辑组件"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.MISO;
    protected
      D.Interfaces.Logic auxiliary[n](each start = L.'U');
      D.Interfaces.Logic auxiliary_n(start = L.'U', fixed = true);
    equation
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = Modelica.Electrical.Digital.Tables.OrTable[
          auxiliary[i],x[i + 1]];
      end for;
      auxiliary_n = Modelica.Electrical.Digital.Tables.NotTable[auxiliary[n]];
      y = pre(auxiliary_n);
      annotation(
        Documentation(info = "<html>
<p>具有多个输入值和一个输出的非或组件。</p>
<p>根据标准逻辑或表(Tables.OrTable)计算中间值，然后将非表(Tables.NotTable)应用于该中间值。</p>
<p>为避免在数值处理中出现循环，对输出应用预操作符。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>Christoph Clauss使用向量方法处理所有固定数量的输入</li>
<li><em>2003年10月22日</em>Liane Jacobi最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = ">=1"), 
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Ellipse(
        extent = {{50, 6}, {62, -6}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}));
    end Nor;

    model Xor "具有多个输入和一个输出的异或逻辑组件"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.MISO;
    protected
      D.Interfaces.Logic auxiliary[n](each start = L.'U');
      D.Interfaces.Logic auxiliary_n(start = L.'U', fixed = true);
    equation
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = Modelica.Electrical.Digital.Tables.XorTable[
          auxiliary[i],x[i + 1]];
      end for;
      auxiliary_n = auxiliary[n];
      y = pre(auxiliary_n);
      annotation(
        Documentation(info = "<html>
<p>具有多个输入值和一个输出的异或组件。</p>
<p>根据标准逻辑异或表(Tables.XorTable)计算输出值。</p>
<p>为避免在数值处理中出现循环，对输出应用预操作符。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>Christoph Clauss使用向量方法处理所有固定数量的输入</li>
<li><em>2003年10月22日</em>Liane Jacobi最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = "=1"), Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}));
    end Xor;

    model Xnor "具有多个输入和一个输出的异或非逻辑组件"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      extends D.Interfaces.MISO;
    protected
      D.Interfaces.Logic auxiliary[n](each start = L.'U');
      D.Interfaces.Logic auxiliary_n(start = L.'U', fixed = true);
    equation
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = Modelica.Electrical.Digital.Tables.XorTable[
          auxiliary[i],x[i + 1]];
      end for;
      auxiliary_n = Modelica.Electrical.Digital.Tables.NotTable[auxiliary[n]];
      y = pre(auxiliary_n);
      annotation(
        Documentation(info = "<html>
<p>具有多个输入值和一个输出的异或非组件。</p>
<p>根据标准逻辑异或表(Tables.XorTable)计算一个中间值，然后将非表(Tables.NotTable)应用于该中间值。</p>
<p>为避免在数值处理中出现循环，对输出应用预操作符。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>Christoph Clauss使用向量方法处理所有固定数量的输入</li>
<li><em>2003年10月22日</em>Liane Jacobi最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = "="), Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}));
    end Xnor;
    annotation(Documentation(info = "<html>

<p>Basic库含了标准逻辑中的基本门。Basic中的组件使用相应的真值表计算结果。它们不包含任何延迟组件。</p>


</html>"  ));
  end Basic;

  package Gates "包含延迟的逻辑门"
    extends Modelica.Icons.Package;

    model InvGate "具有1个输入值的反相门，由非门组成，并且具有惯性延迟特性"
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.SISO;
      D.Basic.Not G1 annotation(Placement(transformation(extent = {{-60, -20}, {-20, 20}})));
      D.Delay.InertialDelaySensitive G2(tLH = tLH, tHL = tHL) 
        annotation(Placement(transformation(extent = {{20, -20}, {60, 20}})));
    equation
      connect(G2.y, y) annotation(Line(points = {{60, 0}, {100, 0}}, color = {127, 0, 127}));
      connect(G1.x, x) annotation(Line(points = {{-52, 0}, {-60, 0}}, color = {127, 0, 127}));
      connect(G1.y, G2.x) 
        annotation(Line(points = {{-20, 0}, {28, 0}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>InvGate模型具有单一值输入和单一值输出。它由一个基本的Not和一个InertialDelaySensitive组成。其参数是延迟参数(上升和下降惯性延迟时间以及初始值)。</p>
</html>"      , revisions = "<html>
<dl>
<dt><em>August 14, 2003</em></dt>
<dd>by Teresa Schlegel initially modelled.</dd>
</dl>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-50, 80}, {50, 40}}, 
        textString = "1"), 
        Text(
        extent = {{-18, -60}, {20, -100}}, 
        textString = "Gate"), 
        Ellipse(
        extent = {{50, 6}, {62, -6}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}));
    end InvGate;

    model AndGate "多输入的And门"
      import D = Modelica.Electrical.Digital;
      extends D.Interfaces.MISO;
      extends D.Delay.DelayParams;
      D.Basic.And G1(final n = n) annotation(Placement(transformation(extent = {
        {-40, -20}, {0, 20}})));
      D.Delay.InertialDelaySensitive G2(
        tLH = tLH, 
        tHL = tHL, 
        y0 = y0) annotation(Placement(transformation(extent = {{20, -20}, {60, 20}})));
    equation
      connect(x, G1.x) 
        annotation(Line(points = {{-60, 0}, {-32, 0}}, color = {127, 0, 127}));
      connect(y, G2.y) 
        annotation(Line(points = {{100, 0}, {60, 0}}, color = {127, 0, 127}));
      connect(G1.y, G2.x) 
        annotation(Line(points = {{0, 0}, {28, 0}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>AndGate模型具有多值(n)输入向量和单值输出。它由一个基本And和一个InertialDelaySensitive组成。其参数是延迟参数(上升和下降惯性延迟时间以及初始值)。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
 by Christoph Clauss<br>
 </li>
<li><em>October 22, 2003</em>
 by Teresa Schlegel<br>
 initially modelled.</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-50, 80}, {50, 40}}, 
        textString = "&"), 
        Text(
        extent = {{-20, -60}, {20, -100}}, 
        textString = "Gate")}));
    end AndGate;

    model NandGate "多输入的Nand门"
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Nand G1(final n = n) annotation(Placement(transformation(extent = 
        {{-40, -20}, {0, 20}})));
      D.Delay.InertialDelaySensitive G2(
        tLH = tLH, 
        tHL = tHL, 
        y0 = y0) annotation(Placement(transformation(extent = {{20, -20}, {60, 20}})));
    equation
      connect(x, G1.x) 
        annotation(Line(points = {{-60, 0}, {-32, 0}}, color = {127, 0, 127}));
      connect(G1.y, G2.x) 
        annotation(Line(points = {{0, 0}, {28, 0}}, color = {127, 0, 127}));
      connect(G2.y, y) 
        annotation(Line(points = {{60, 0}, {100, 0}}, color = {127, 0, 127}));
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-40, 40}, {40, 80}}, 
        textString = "&"), 
        Text(
        extent = {{-50, -64}, {50, -86}}, 
        textString = "Gate"), 
        Ellipse(
        extent = {{50, 6}, {62, -6}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}), 
        Documentation(revisions = "<html>
<ul>
<li><em>September 15, 2004</em> vector approach used for all fixed numbers of inputs
by Christoph Clauss<br>
</li>
<li><em>October 22, 2003</em>
by Teresa Schlegel<br>
initially modelled.</li>
</ul>
</html>"          , info = "<html>
<p>NandGate模型具有多值(n)输入向量和单值输出。它由一个基本Nand和一个InertialDelaySensitive组成。其参数是延迟参数(上升和下降惯性延迟时间以及初始值)。</p>
</html>"          ));
    end NandGate;

    model OrGate "多输入的Or门"
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Or G1(final n = n) annotation(Placement(transformation(extent = {{
        -40, -20}, {0, 20}})));
      D.Delay.InertialDelaySensitive G2(
        tLH = tLH, 
        tHL = tHL, 
        y0 = y0) annotation(Placement(transformation(extent = {{20, -20}, {60, 20}})));
    equation
      connect(G1.y, G2.x) 
        annotation(Line(points = {{0, 0}, {28, 0}}, color = {127, 0, 127}));
      connect(x, G1.x) 
        annotation(Line(points = {{-60, 0}, {-32, 0}}, color = {127, 0, 127}));
      connect(y, G2.y) 
        annotation(Line(points = {{100, 0}, {60, 0}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>Or门模型具有多值(n)输入向量和单值输出。它由基本Or和惯性延迟敏感元件组成。其参数是延迟参数(上升和下降惯性延迟时间，以及初始值)。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em> Christoph Clauss使用向量方法处理所有固定数量的输入<br>
 </li>
<li><em>2003年10月22日</em>
 Teresa Schlegel最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-50, 80}, {50, 40}}, 
        textString = ">=1"), 
        Text(
        extent = {{-20, -60}, {20, -100}}, 
        textString = "Gate")}));
    end OrGate;

    model NorGate "多输入的Nor门"
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Nor G1(final n = n) annotation(Placement(transformation(extent = {
        {-40, -20}, {0, 20}})));
      D.Delay.InertialDelaySensitive G2(
        tLH = tLH, 
        tHL = tHL, 
        y0 = y0) annotation(Placement(transformation(extent = {{20, -20}, {60, 20}})));
    equation
      connect(G1.y, G2.x) 
        annotation(Line(points = {{0, 0}, {28, 0}}, color = {127, 0, 127}));
      connect(x, G1.x) 
        annotation(Line(points = {{-60, 0}, {-32, 0}}, color = {127, 0, 127}));
      connect(y, G2.y) 
        annotation(Line(points = {{100, 0}, {60, 0}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>Nor门模型具有多值(n)输入向量和单值输出。它由基本Nor和惯性延迟敏感元件组成。其参数是延迟参数(上升和下降惯性延迟时间，以及初始值)。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em> Christoph Clauss使用向量方法处理所有固定数量的输入<br>
 </li>
<li><em>2003年10月22日</em>
 Liane Jacobi最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-50, 80}, {50, 40}}, 
        textString = ">=1"), 
        Text(
        extent = {{-20, -60}, {20, -100}}, 
        textString = "Gate"), 
        Ellipse(
        extent = {{50, 6}, {62, -6}}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid)}));
    end NorGate;

    model XorGate "多输入的异或门"
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Xor G1(final n = n) annotation(Placement(transformation(extent = {
        {-40, -20}, {0, 20}})));
      D.Delay.InertialDelaySensitive G2(
        tLH = tLH, 
        tHL = tHL, 
        y0 = y0) annotation(Placement(transformation(extent = {{20, -20}, {60, 20}})));
    equation
      connect(x, G1.x) 
        annotation(Line(points = {{-60, 0}, {-32, 0}}, color = {127, 0, 127}));
      connect(G1.y, G2.x) 
        annotation(Line(points = {{0, 0}, {28, 0}}, color = {127, 0, 127}));
      connect(G2.y, y) 
        annotation(Line(points = {{60, 0}, {100, 0}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>异或门模型具有多值(n)输入向量和单值输出。它由基本异或和惯性延迟敏感元件组成。其参数是延迟参数(上升和下降惯性延迟时间，以及初始值)。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em> Christoph Clauss使用向量方法处理所有固定数量的输入<br>
 </li>
<li><em>2003年10月22日</em>
 Liane Jacobi最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-50, 80}, {50, 40}}, 
        textString = "=1"), 
        Text(
        extent = {{-20, -60}, {20, -100}}, 
        textString = "Gate")}));
    end XorGate;

    model XnorGate "多输入的异或非门"
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.MISO;
      D.Basic.Xnor G1(final n = n) annotation(Placement(transformation(extent = 
        {{-40, -20}, {0, 20}})));
      D.Delay.InertialDelaySensitive G2(
        tLH = tLH, 
        tHL = tHL, 
        y0 = y0) annotation(Placement(transformation(extent = {{20, -20}, {60, 20}})));
    equation
      connect(x, G1.x) 
        annotation(Line(points = {{-60, 0}, {-32, 0}}, color = {127, 0, 127}));
      connect(G2.y, y) 
        annotation(Line(points = {{60, 0}, {100, 0}}, color = {127, 0, 127}));
      connect(G1.y, G2.x) 
        annotation(Line(points = {{0, 0}, {28, 0}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>异或非门模型具有多值(n)输入向量和单值输出。它由基本异或非和惯性延迟敏感元件组成。其参数是延迟参数(上升和下降惯性延迟时间，以及初始值)。</p>
</html>"      , revisions = "<html>
<ul>
<li><em>2004年9月15日</em> Christoph Clauss使用向量方法处理所有固定数量的输入<br>
 </li>
<li><em>2003年10月22日</em>
 Liane Jacobi最初建模。</li>
</ul>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-40, 80}, {40, 40}}, 
        textString = "="), 
        Text(
        extent = {{-20, -60}, {20, -100}}, 
        textString = "Gate")}));
    end XnorGate;

    model BufGate "具有1个输入值的缓冲门，由非门组成，并且具有惯性延迟特性"
      import D = Modelica.Electrical.Digital;
      extends D.Delay.DelayParams;
      extends D.Interfaces.SISO;
      D.Delay.InertialDelaySensitive G1(tLH = tLH, tHL = tHL) 
        annotation(Placement(transformation(extent = {{-30, -20}, {10, 20}})));
    equation
      connect(G1.y, y) annotation(Line(points = {{10, 0}, {
        100, 0}}, color = {127, 0, 127}));
      connect(G1.x, x) annotation(Line(points = {{-22, 0}, {-60, 0}}, color = {127, 0, 
        127}));
      annotation(
        Documentation(info = "<html>
<p>BufGate模型具有单值输入和单值输出。它仅由InertialDelaySensitive组成。其参数是延迟参数(上升和下降惯性延迟时间，以及初始值)。</p>
</html>"      , revisions = "<html>
<dl>
<dt><em>2004年9月21日</em></dt>
<dd>由Andre Schneider最初建模。</dd>
</dl>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-18, -60}, {20, -100}}, 
        textString = "Gate"), 
        Text(
        extent = {{-50, 80}, {50, 40}}, 
        textString = "1")}));
    end BufGate;
    annotation(Documentation(info = "<html>

<p>门(Gates)包含基本门，这些基本门根据标准逻辑提供在基本包中。此外，它们包含一个可感知滞后的反应性组件。门的组成是通过图形方式进行的，而不是使用任何方程。
</p>

</html>"  ));
  end Gates;

  package Sources "时间相关数字信号源"
    extends Modelica.Icons.SourcesPackage;

    block Set "数字置位源"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      parameter D.Interfaces.Logic x(start = L.'1') "要设置的逻辑值";
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 
        10}})));
    algorithm
      y := x;
      annotation(Documentation(info = "<html>
<p>
设置一个由<em>setval</em>参数指定的九值数字信号。
</p>
<p>
要指定<em>setval</em>，必须使用整数代码。
</p>
<p><strong>代码表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>逻辑值</strong></td>
<td><strong>整数代码</strong></td>
<td><strong>含义</strong></td>
</tr>

<tr><td>'U'</td> <td>1</td> <td>未初始化</td></tr>
<tr><td>'X'</td> <td>2</td> <td>强制未知</td></tr>
<tr><td>'0'</td> <td>3</td> <td>强制0</td></tr>
<tr><td>'1'</td> <td>4</td> <td>强制1</td></tr>
<tr><td>'Z'</td> <td>5</td> <td>高阻态</td></tr>
<tr><td>'W'</td> <td>6</td> <td>弱未知</td></tr>
<tr><td>'L'</td> <td>7</td> <td>弱0</td></tr>
<tr><td>'H'</td> <td>8</td> <td>弱1</td></tr>
<tr><td>'-'</td> <td>9</td> <td>不关心</td></tr>
</table>

<p>
如果逻辑值由<br><strong>import L=Digital.Interfaces.Logic;</strong><br>
导入，可以用于指定参数，例如，<strong>L.'0'</strong>表示强制0。
</p>
</html>"      , revisions = "<html>
<dl>
<dt><em>2003年8月20日</em></dt>
<dd>由Teresa Schlegel最初建模。</dd>
</dl>
</html>"      ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
        100, 100}}), graphics = {
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 255, 170}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = "SET"), 
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Line(points = {{50, 0}, {90, 0}}, color = {127, 0, 127})}));
    end Set;

    block Step "数字阶跃源"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      parameter D.Interfaces.Logic before(start = L.'0') 
        "步进前的逻辑值";
      parameter D.Interfaces.Logic after(start = L.'1') 
        "步进后的逻辑值";
      parameter Real stepTime(start = 1) "步进时间";
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 
        10}})));
    algorithm
      // assert(before >= L.min and before <= L.max, "Parameter is no logic value");
      // assert(after >= L.min and after <= L.max, "Parameter is no logic value");
      if time >= stepTime then
        y := after;
      else
        y := before;
      end if;
      annotation(
        Documentation(info = "<html>
<p>
步进源输出信号在时间<em>stepTime</em>时从<em>before</em>值步进到<em>after</em>值。
</p>
<p>
要指定逻辑值参数，必须使用整数代码。
</p>
<p><strong>代码表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>逻辑值</strong></td>
<td><strong>整数代码</strong></td>
<td><strong>含义</strong></td>
</tr>

<tr><td>'U'</td> <td>1</td> <td>未初始化</td></tr>
<tr><td>'X'</td> <td>2</td> <td>强制未知</td></tr>
<tr><td>'0'</td> <td>3</td> <td>强制0</td></tr>
<tr><td>'1'</td> <td>4</td> <td>强制1</td></tr>
<tr><td>'Z'</td> <td>5</td> <td>高阻态</td></tr>
<tr><td>'W'</td> <td>6</td> <td>弱未知</td></tr>
<tr><td>'L'</td> <td>7</td> <td>弱0</td></tr>
<tr><td>'H'</td> <td>8</td> <td>弱1</td></tr>
<tr><td>'-'</td> <td>9</td> <td>不关心</td></tr>
</table>
<p>
如果逻辑值由<br><strong>import L=Digital.Interfaces.Logic;</strong><br>
导入，可以用于指定参数，例如，<strong>L.'0'</strong>表示强制0。
</p>
</html>"      , revisions = "<html>
<dl>
<dt><em>2003年8月20日</em></dt>
<dd>由Teresa Schlegel最初建模。</dd>
</dl>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 255, 170}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Line(points = {{-30, 40}, {0, 40}, {0, 80}, {30, 80}}), 
        Line(points = {{50, 0}, {90, 0}}, color = {127, 0, 127})}));
    end Step;

    block Table "数字表格源"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      parameter D.Interfaces.Logic x[:] = {L.'1'} "值向量";
      parameter Real t[size(x, 1)] = {1} 
        "相应时间点的向量";
      parameter D.Interfaces.Logic y0 = L.'U' "初始输出值";
      final parameter Integer n = size(x, 1) "表格大小";
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 
        10}})));
    algorithm
      if initial() then
        // assert(y0 >= L.min and y0 <= L.max, "Parameter y0 is not of type Logic");
        assert(n > 0, "Invalid size of table (n < 1)");
        for i in 1:n loop
        // assert(x[i] >= L.min and x[i] <= L.max, "Table element is not of type Logic");
        end for;
      end if;
      y := y0;
      for i in 1:n loop
        if time >= t[i] then
          y := x[i];
        end if;
      end for;
      annotation(
        Documentation(info = "<html>
<p>
表格源输出信号<em>y</em>在<em>t</em>表中的相应时间点处步进到<em>x</em>表中的值。
初始值由<em>y0</em>指定。
</p>
<p>
要指定逻辑值参数，必须使用整数代码。
</p>
<p><strong>代码表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>逻辑值</strong></td>
<td><strong>整数代码</strong></td>
<td><strong>含义</strong></td>
</tr>

<tr><td>'U'</td> <td>1</td> <td>未初始化</td></tr>
<tr><td>'X'</td> <td>2</td> <td>强制未知</td></tr>
<tr><td>'0'</td> <td>3</td> <td>强制0</td></tr>
<tr><td>'1'</td> <td>4</td> <td>强制1</td></tr>
<tr><td>'Z'</td> <td>5</td> <td>高阻态</td></tr>
<tr><td>'W'</td> <td>6</td> <td>弱未知</td></tr>
<tr><td>'L'</td> <td>7</td> <td>弱0</td></tr>
<tr><td>'H'</td> <td>8</td> <td>弱1</td></tr>
<tr><td>'-'</td> <td>9</td> <td>不关心</td></tr>
</table>
<p>
如果逻辑值由<br><strong>import L=Digital.Interfaces.Logic;</strong><br>
导入，可以用于指定参数，例如，<strong>L.'0'</strong>表示强制0。
</p>
</html>"      , revisions = "<html>
<dl>
<dt><em>2003年8月20日</em></dt>
<dd>由Teresa Schlegel最初建模。</dd>
</dl>
</html>"      ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 255, 170}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Line(points = {{50, 0}, {90, 0}}, color = {127, 0, 127}), 
        Rectangle(
        extent = {{-30, 80}, {32, 70}}, 
        fillColor = {215, 215, 215}, 
        fillPattern = FillPattern.Solid), 
        Rectangle(
        extent = {{-30, 70}, {32, 40}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(points = {{0, 80}, {0, 40}}), 
        Line(points = {{-30, 60}, {32, 60}}), 
        Line(points = {{-30, 50}, {32, 50}})}));
    end Table;

    model Pulse "数字脉冲源"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      parameter Real width(
        final min = Modelica.Constants.small, final max = 100, start = 50) 
        "周期的宽度，以百分比表示";
      parameter SI.Time period(
        final min = Modelica.Constants.small, start = 1) "一个周期的时间";
      parameter SI.Time startTime(start = 0) "输出在<em>startTime</em>之前为安静状态";
      parameter D.Interfaces.Logic pulse(start = L.'0') "脉冲值";
      parameter D.Interfaces.Logic quiet(start = L.'1') "静态值";
      SI.Time T0(final start = startTime, fixed = true) "当前周期的开始时间";
      parameter Integer nperiod(start = -1) 
        "周期数（<0表示无限周期数）";
      Integer np(start = 0, fixed = true);
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 
        10}})));
    protected
      Boolean sampling;

    equation
      sampling = nperiod <> 0 and (nperiod >= pre(np) or nperiod < 0);

      when sampling and sample(startTime, period) then
        T0 = time;
        np = if nperiod > 0 then pre(np) + 1 else pre(np);
      end when;

      if sampling then
        y = if time < startTime or time >= T0 + ((width * period) / 100) then quiet else pulse;
      else
        y = quiet;
      end if;
      annotation(Documentation(info = "<html>
<p>
脉冲源在<em>quiet</em>值和<em>pulse</em>值之间形成脉冲。
脉冲长度<em>width</em>以周期长度<em>period</em>的百分比表示。
周期数由<em>nperiod</em>指定。如果<em>nperiod</em>小于零，则周期数不限。
</p>
<p>
要指定逻辑值参数，必须使用整数代码。
</p>
<p><strong>代码表</strong></p>
<table border=\"1\" cellspacing=\"0"       + 
        " cellpadding=\"2\">
<tr><td><strong>逻辑值</strong></td>
<td><strong>整数代码</strong></td>
<td><strong>含义</strong></td>
</tr>

<tr><td>'U'</td> <td>1</td> <td>未初始化</td></tr>
<tr><td>'X'</td> <td>2</td> <td>强制未知</td></tr>
<tr><td>'0'</td> <td>3</td> <td>强制0</td></tr>
<tr><td>'1'</td> <td>4</td> <td>强制1</td></tr>
<tr><td>'Z'</td> <td>5</td> <td>高阻态</td></tr>
<tr><td>'W'</td> <td>6</td> <td>弱未知</td></tr>
<tr><td>'L'</td> <td>7</td> <td>弱0</td></tr>
<tr><td>'H'</td> <td>8</td> <td>弱1</td></tr>
<tr><td>'-'</td> <td>9</td> <td>不关心</td></tr>
</table>
<p>
如果逻辑值由<br><strong>import L=Digital.Interfaces.Logic;</strong><br>
导入，可以用于指定参数，例如，<strong>L.'0'</strong>表示强制0。
</p>
</html>"      , revisions = "<html>
<dl>
<dt><em>2003年9月2日</em></dt>
<dd>由Christoph Clauss最初建模。</dd>
</dl>
</html>"      ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
        100, 100}}), graphics = {
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 255, 170}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Line(points = {{50, 0}, {90, 0}}, color = {127, 0, 127}), 
        Line(points = {{-36, 40}, {-30, 40}, {-30, 40}, {-18, 40}, {-18, 40}, {-14, 40}, 
        {-14, 80}, {14, 80}, {14, 40}, {14, 40}, {14, 40}, {28, 40}, {30, 40}, {36, 
        40}})}));
    end Pulse;

    model DigitalClock "数字时钟源"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      parameter SI.Time startTime(start = 0) 
        "在<em>startTime</em>之前的输出 = 偏移量";
      parameter SI.Time period(
        final min = Modelica.Constants.small, start = 1) "一个周期的时间";
      parameter Real width(
        final min = Modelica.Constants.small, final max = 100, start = 50) 
        "周期的宽度，以百分比表示";
      D.Interfaces.DigitalOutput y "数字输出信号的连接器" 
        annotation(Placement(transformation(extent = {{90, -10}, {110, 
        10}})));
    protected
      SI.Time t_i(final start = startTime, fixed = true) "当前周期的开始时间";
      SI.Time t_width = period * width / 100;
    equation
      when sample(startTime, period) then
        t_i = time;
      end when;
      y = if (not time >= startTime) or time >= t_i + t_width then L.'0' else L.'1';
      annotation(
        Documentation(info = "<html>
<p>
数字时钟源提供一个周期性的数字信号。
输出以周期<em>period</em>的宽度<em>width</em>的百分比表示。
</p>
<p>
要指定逻辑值参数，必须使用整数代码。
</p>
<p><strong>代码表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>逻辑值</strong></td>
<td><strong>整数代码</strong></td>
<td><strong>含义</strong></td>
</tr>

<tr><td>'U'</td> <td>1</td> <td>未初始化</td></tr>
<tr><td>'X'</td> <td>2</td> <td>强制未知</td></tr>
<tr><td>'0'</td> <td>3</td> <td>强制0</td></tr>
<tr><td>'1'</td> <td>4</td> <td>强制1</td></tr>
<tr><td>'Z'</td> <td>5</td> <td>高阻态</td></tr>
<tr><td>'W'</td> <td>6</td> <td>弱未知</td></tr>
<tr><td>'L'</td> <td>7</td> <td>弱0</td></tr>
<tr><td>'H'</td> <td>8</td> <td>弱1</td></tr>
<tr><td>'-'</td> <td>9</td> <td>不关心</td></tr>
</table>
<p>
如果逻辑值由<br><strong>import L=Digital.Interfaces.Logic;</strong><br>
导入，可以用于指定参数，例如，<strong>L.'0'</strong>表示强制0。
</p>
</html>"      , revisions = "<html>
<dl>
<dt><em>2003年9月3日</em></dt>
<dd>由Christoph Clauss最初建模。</dd>
</dl>
</html>"      ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
        100, 100}}), graphics = {
        Rectangle(
        extent = {{-50, 100}, {50, -100}}, 
        lineThickness = 0.5, 
        fillColor = {213, 255, 170}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Line(points = {{50, 0}, {90, 0}}, color = {127, 0, 127}), 
        Rectangle(
        extent = {{-40, 80}, {42, 60}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(points = {{-30, 80}, {30, 80}, {30, 60}, {-30, 60}, 
        {-30, 60}, {-30, 80}, {-10, 80}, {-10, 70}, {10, 70}, 
        {10, 80}}), 
        Rectangle(
        extent = {{-26, 70}, {26, 62}}, 
        fillColor = {0, 0, 0}, 
        fillPattern = FillPattern.Solid), 
        Line(points = {{-22, 66}, {22, 66}}), 
        Line(points = {{-18, 74}, {18, 74}}), 
        Line(points = {{-14, 78}, {14, 78}})}));
    end DigitalClock;
    annotation();

  end Sources;

  package Converters "2-、3-、4-和9-值逻辑之间的转换器"
    extends Modelica.Icons.Package;

    block LogicToX01 "转换为X01"
      import D = Modelica.Electrical.Digital;
      import T = Modelica.Electrical.Digital.Tables;
      D.Interfaces.DigitalInput x[n] 
        annotation(Placement(transformation(extent = {{-60, -10}, 
        {-40, 10}})));
      D.Interfaces.DigitalOutput y[n] 
        annotation(Placement(transformation(extent = {{40, -10}, 
        {60, 10}})));
      parameter Integer n(final min = 1, start = 1) "信号宽度";
    algorithm
      for i in 1:n loop
        y[i] := T.X01Table[x[i]];
      end for;
      annotation(
        Documentation(info = "<html>
<p>
将九值数字输入转换为X01数字输出，无延迟，根据IEEE 1164 To_X01函数。
</p>
<p><strong>转换表：</strong></p>
<blockquote><pre>
输入                  输出
'U' (编码为1)       'X'  (编码为2)
'X' (编码为2)       'X'  (编码为2)
'0' (编码为3)       '0'  (编码为3)
'1' (编码为4)       '1'  (编码为4)
'Z' (编码为5)       'X'  (编码为2)
'W' (编码为6)       'X'  (编码为2)
'L' (编码为7)       '0'  (编码为3)
'H' (编码为8)       '1'  (编码为4)
'-' (编码为9)       'X'  (编码为2)
</pre></blockquote>
<p>
如果信号宽度大于1，则对每个信号进行转换。
</p>
</html>"  , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>
     由Christoph Clauss将名称从cvt_to_x01转换为LogicToX01<br>
     </li>
<li><em>2003年11月5日</em>
     由Christoph Clauss<br>
     最初建模。</li>
</ul>
</html>"  ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -100}, {-148, -40}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Polygon(
        points = {{-40, -40}, {-40, 40}, {40, 40}, {-40, -40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid), 
        Polygon(
        points = {{-40, -40}, {40, -40}, {40, 40}, {-40, -40}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{0, -20}, {40, -40}}, 
        textString = "X01"), 
        Rectangle(
        extent = {{-40, 40}, {40, -40}}, 
        lineThickness = 0.5)}));
    end LogicToX01;

    block LogicToX01Z "转换为X01Z"
      import D = Modelica.Electrical.Digital;
      import T = Modelica.Electrical.Digital.Tables;
      D.Interfaces.DigitalInput x[n] 
        annotation(Placement(transformation(extent = {{-60, -10}, 
        {-40, 10}})));
      D.Interfaces.DigitalOutput y[n] 
        annotation(Placement(transformation(extent = {{40, -10}, 
        {60, 10}})));
      parameter Integer n(final min = 1, start = 1) "信号宽度";
    algorithm
      for i in 1:n loop
        y[i] := T.X01ZTable[x[i]];
      end for;
      annotation(
        Documentation(info = "<html>
<p>
将九值数字输入转换为X01Z数字输出，无延迟，根据IEEE 1164 To_X01Z函数。
</p>
<p><strong>转换表：</strong></p>
<blockquote><pre>
输入                  输出
'U' (编码为1)       'X'  (编码为2)
'X' (编码为2)       'X'  (编码为2)
'0' (编码为3)       '0'  (编码为3)
'1' (编码为4)       '1'  (编码为4)
'Z' (编码为5)       'Z'  (编码为5)
'W' (编码为6)       'X'  (编码为2)
'L' (编码为7)       '0'  (编码为3)
'H' (编码为8)       '1'  (编码为4)
'-' (编码为9)       'X'  (编码为2)
</pre></blockquote>
<p>
如果信号宽度大于1，则对每个信号进行转换。
</p>
</html>"  , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>
     由Christoph Clauss将名称从cvt_to_x01z转换为LogicToX01Z<br>
     </li>
<li><em>2003年11月5日</em>
     由Christoph Clauss<br>
     最初建模。</li>
</ul>
</html>"  ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -100}, {-148, -40}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Polygon(
        points = {{-40, -40}, {-40, 40}, {40, 40}, {-40, -40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid), 
        Polygon(
        points = {{-40, -40}, {40, -40}, {40, 40}, {-40, -40}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{0, -20}, {40, -40}}, 
        textString = "X01Z"), 
        Rectangle(
        extent = {{-40, 40}, {40, -40}}, 
        lineThickness = 0.5)}));
    end LogicToX01Z;

    block LogicToUX01 "转换为UX01"
      import D = Modelica.Electrical.Digital;
      import T = Modelica.Electrical.Digital.Tables;
      D.Interfaces.DigitalInput x[n] 
        annotation(Placement(transformation(extent = {{-60, -10}, 
        {-40, 10}})));
      D.Interfaces.DigitalOutput y[n] 
        annotation(Placement(transformation(extent = {{40, -10}, 
        {60, 10}})));
      parameter Integer n(final min = 1, start = 1) "信号宽度";
    algorithm
      for i in 1:n loop
        y[i] := T.UX01Table[x[i]];
      end for;
      annotation(
        Documentation(info = "<html>
<p>
将九值数字输入转换为UX01数字输出，无延迟，根据IEEE 1164 To_UX01函数。
</p>
<p><strong>转换表：</strong></p>
<blockquote><pre>
输入                  输出
'U' (编码为1)       'U'  (编码为1)
'X' (编码为2)       'X'  (编码为2)
'0' (编码为3)       '0'  (编码为3)
'1' (编码为4)       '1'  (编码为4)
'Z' (编码为5)       'X'  (编码为2)
'W' (编码为6)       'X'  (编码为2)
'L' (编码为7)       '0'  (编码为3)
'H' (编码为8)       '1'  (编码为4)
'-' (编码为9)       'X'  (编码为2)
</pre></blockquote>
<p>
如果信号宽度大于1，则对每个信号进行转换。
</p>
</html>"  , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>
     由Christoph Clauss将名称从cvt_to_ux01转换为LogicToUX01<br>
     </li>
<li><em>2003年11月5日</em>
     由Christoph Clauss<br>
     最初建模。</li>
</ul>
</html>"  ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Text(
        extent = {{152, -100}, {-148, -40}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Polygon(
        points = {{-40, -40}, {-40, 40}, {40, 40}, {-40, -40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid), 
        Polygon(
        points = {{-40, -40}, {40, -40}, {40, 40}, {-40, -40}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{0, -20}, {40, -40}}, 
        textString = "UX01"), 
        Rectangle(
        extent = {{-40, 40}, {40, -40}}, 
        lineThickness = 0.5)}));
    end LogicToUX01;

    block BooleanToLogic "布尔转逻辑转换器"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      Modelica.Blocks.Interfaces.BooleanInput x[n] 
        annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
      parameter Integer n(final min = 1, start = 1) "信号宽度";
      Modelica.Electrical.Digital.Interfaces.DigitalOutput y[n] 
        annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
    equation
      for i in 1:n loop
        y[i] = if x[i] then L.'1' else L.'0';
      end for;
      annotation(
        Documentation(info = "<html>
<p>
将布尔输入转换为数字输出，无延迟，根据以下规则：
</p>
<blockquote><pre>
输入      输出
true     '1'  (编码为4)
false    '0'  (编码为3)
</pre></blockquote>
<p>
如果信号宽度大于1，则对每个信号进行转换。
</p>
</html>"  , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>
     由Christoph Clauss更改颜色<br>
     </li>
<li><em>2003年11月4日</em>
     由Christoph Clauss<br>
     最初建模。</li>
</ul>
</html>"  ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Polygon(
        points = {{-40, -40}, {40, 40}, {40, -40}, {-40, -40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid), 
        Polygon(
        points = {{-40, 40}, {40, 40}, {-40, -40}, {-40, 40}}, 
        lineColor = {255, 0, 255}, 
        fillColor = {255, 0, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{152, -100}, {-148, -40}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-40, 40}, {40, -40}}, 
        lineThickness = 0.5)}));
    end BooleanToLogic;

    block LogicToBoolean "逻辑转布尔转换器"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      Modelica.Electrical.Digital.Interfaces.DigitalInput x[n] 
        annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
      Modelica.Blocks.Interfaces.BooleanOutput y[n] 
        annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
      parameter Integer n(final min = 1, start = 2) "信号宽度";
    equation
      for i in 1:n loop
        y[i] = (x[i] == L.'1' or x[i] == L.'H');
      end for;
      annotation(Documentation(info = "<html>
<p>
将数字输入转换为布尔输出，无延迟，根据以下规则：
</p>
<blockquote><pre>
输入                 输出
'U'  (编码为1)     false
'X'  (编码为2)     false
'0'  (编码为3)     false
'1'  (编码为4)     true
'Z'  (编码为5)     false
'W'  (编码为6)     false
'L'  (编码为7)     false
'H'  (编码为8)     true
'-'  (编码为9)     false
</pre></blockquote>
<p>
如果信号宽度大于1，则对每个信号进行转换。
</p>
</html>"  , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>
     由Christoph Clauss更改颜色<br>
     </li>
<li><em>2003年11月4日</em>
     由Christoph Clauss<br>
     最初建模。</li>
</ul>
</html>"  ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
        100, 100}}), graphics = {
        Polygon(
        points = {{-40, 40}, {40, 40}, {-40, -40}, {-40, 40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{152, -100}, {-148, -40}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Polygon(
        points = {{-40, -40}, {40, -40}, {40, 40}, {-40, -40}}, 
        lineColor = {255, 0, 255}, 
        fillColor = {255, 0, 255}, 
        fillPattern = FillPattern.Solid), 
        Rectangle(
        extent = {{-40, 40}, {40, -40}}, 
        lineThickness = 0.5)}));
    end LogicToBoolean;

    block RealToLogic "实数到逻辑转换器"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      Modelica.Blocks.Interfaces.RealInput x[n] 
        annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
      Digital.Interfaces.DigitalOutput y[n] 
        annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
      parameter Integer n(final min = 1, start = 1) "信号宽度";
      parameter Real upper_limit(start = 1) "上限";
      parameter Real lower_limit(start = 0) "下限";
      parameter L upper_value(start = L.'1') "输入大于上限时的输出";
      parameter L lower_value(start = L.'0') "输入小于下限时的输出";
      parameter L middle_value(start = L.'X') "其他输出";
    equation
      for i in 1:n loop
        y[i] = if x[i] > upper_limit then upper_value else 
          if x[i] < lower_limit then lower_value else middle_value;
      end for;
      annotation(
        Documentation(info = "<html>
<p>
将实数输入转换为数字输出，无延迟，根据以下规则：
</p>
<blockquote><pre>
                         条件            输出
第一检查：               输入大于上限    上限
第二检查：               输入小于下限    下限
                         其他           中间值
</pre></blockquote>
<p>
如果信号宽度大于1，则对每个信号进行转换。
</p>
</html>"  , revisions = "<html>
<ul>
<li><em>2004年9月15日</em>
     由Christoph Clauss更改颜色<br>
     </li>
<li><em>2003年11月5日</em>
     由Christoph Clauss<br>
     最初建模。</li>
</ul>
</html>"  ), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, 
        {100, 100}}), graphics = {
        Polygon(
        points = {{-40, -40}, {40, 40}, {40, -40}, {-40, -40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid), 
        Polygon(points = {{-40, 40}, {40, 40}, {-40, -40}, {-40, 40}}, lineColor = {0, 
        0, 255}), 
        Text(
        extent = {{148, -100}, {-152, -40}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Rectangle(
        extent = {{-40, 40}, {40, -40}}, 
        lineThickness = 0.5)}));
    end RealToLogic;

    block LogicToReal "逻辑到实数转换器"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      Modelica.Electrical.Digital.Interfaces.DigitalInput x[n] 
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Blocks.Interfaces.RealOutput y[n] 
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      parameter Integer n(final min=1, start=1) "信号宽度";
      parameter Real value_U(start=0.5) 
    "数字 U 的值（未初始化）";
      parameter Real value_X(start=0.5) 
    "数字 X 的值（强制未知）";
      parameter Real value_0(start=0) "数字 0 的值（强制 0）";
      parameter Real value_1(start=1) "数字 1 的值（强制 1）";
      parameter Real value_Z(start=0.5) 
    "数字 Z 值（高阻抗）";
      parameter Real value_W(start=0.5) 
    "数字 W（弱未知）的值";
      parameter Real value_L(start=0) "数字 L 的值（弱 0）";
      parameter Real value_H(start=1) "数字 H 的值（弱 1）";
      parameter Real value_m(start=0.5) "数字 m 的价值（不关心）";
    equation
      for i in 1:n loop
       y[i]= if x[i] == L.'U' then value_U else 
                if x[i] == L.'X' then value_X else if 
          x[i] == L.'0' then value_0 else if x[i] == L.'1' then 
               value_1 else if x[i] == L.
          'Z' then value_Z else if x[i] == L.'W' then value_W else 
                if x[i] == L.'L' then value_L else if 
          x[i] == L.'H' then value_H else value_m;
      end for;
      annotation (Documentation(info="<html>
<p>
将数字输入无延迟地转换为实数输出：
</p>
<blockquote><pre>
input                 output
'U'  (coded by 1)     val_U
'X'  (coded by 2)     val_X
'0'  (coded by 3)     val_0
'1'  (coded by 4)     val_1
'Z'  (coded by 5)     val_Z
'W'  (coded by 6)     val_W
'L'  (coded by 7)     val_L
'H'  (coded by 8)     val_H
'-'  (coded by 9)     val_m
</pre></blockquote>
<p>
val......的值由参数给出。</p>
<p>如果信号宽度大于 1，则对每个信号进行转换。
</p>
</html>"        , revisions="<html>
<ul>
<li><em>September 15, 2004</em>
by Christoph Clauss colors changed<br>
</li>
<li><em>November 5, 2003</em>
by Christoph Clauss<br>
initially modelled.</li>
</ul>
</html>"        ), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Polygon(
          points={{-40,40},{40,40},{-40,-40},{-40,40}}, 
          lineColor={127,0,127}, 
          fillColor={127,0,127}, 
          fillPattern=FillPattern.Solid), 
        Polygon(points={{-40,-40},{40,-40},{40,40},{-40,-40}}, lineColor={0, 
              0,255}), 
        Text(
          extent={{152,-100},{-148,-40}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Rectangle(
          extent={{-40,40},{40,-40}}, 
          lineThickness=0.5)}));
    end LogicToReal;
    annotation();
  end Converters;

  package Registers "具有N位输入数据和输出数据的寄存器"
    extends Modelica.Icons.Package;

    model DFFR "带复位的边沿触发寄存器组"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter Integer ResetMap[L] = {1, 4, 3, 2, 4, 4, 3, 2, 4} 
        "功能选择，默认为高电平复位";
      parameter D.Interfaces.Strength strength = S.'S_X01' 
        "输出强度";
      parameter Integer n(min = 1) = 1 "数据宽度";

      D.Interfaces.DigitalInput reset 
        annotation(Placement(transformation(extent = {{-10, -100}, {10, -80}}), 
        iconTransformation(extent = {{-10, -100}, {10, -80}})));
      D.Interfaces.DigitalInput clock annotation(Placement(transformation(
        extent = {{-90, -30}, {-70, -10}}), iconTransformation(extent = {{-90, -30}, {
        -70, -10}})));
      D.Interfaces.DigitalInput dataIn[n] annotation(Placement(transformation(
        extent = {{-90, 20}, {-70, 40}}), iconTransformation(extent = {{-90, 20}, {-70, 
        40}})));
      D.Interfaces.DigitalOutput dataOut[n] annotation(Placement(
        transformation(extent = {{64, 26}, {84, 46}}), iconTransformation(
        extent = {{69, 20}, {89, 40}})));
    protected
      Integer clock_flag(start = 0);
      // 0: 0-转换
      // 1: 上升沿
      // 2: X-转换

      Integer reset_flag(start = 1);
      // 1: 输出 := U
      // 2: 输出 := 0
      // 3: 输出 := -dataInUX
      // 4: 输出 := U-0X
    protected
      D.Interfaces.Logic nextstate[n](start = fill(L.'U', n));
      D.Interfaces.Logic next_assign_val[n](start = fill(L.'U', n));

    algorithm
      if change(clock) or change(reset) then

        if change(clock) then
          if initial() then
            clock_flag := T.ClockMap[L.'U',clock];
          else
            clock_flag := T.ClockMap[pre(clock),clock];
          end if;
        end if;

        reset_flag := ResetMap[reset];
        for i in 1:n loop
          if reset_flag == 1 then
            nextstate[i] := L.'U';
          elseif reset_flag == 2 then
            nextstate[i] := T.StrengthMap[L.'0',strength];
          elseif reset_flag == 3 then
            if clock_flag == 0 then
              break;
            elseif clock_flag == 1 then
              nextstate[i] := T.StrengthMap[dataIn[i],strength];
            else
              if (next_assign_val[i] == T.StrengthMap[dataIn[i],strength]) 
                or (next_assign_val[i] == L.'U') then
                break;
              elseif dataIn[i] == L.'U' then
                nextstate[i] := L.'U';
              else
                nextstate[i] := T.StrengthMap[L.'X',strength];
              end if;
            end if;
          elseif reset_flag == 4 then
            if (next_assign_val[i] == T.StrengthMap[L.'0',strength]) 
              and (dataIn[i] == L.'0' or dataIn[i] == L.'L' or clock_flag == 0) then
              break;
            elseif (dataIn[i] == L.'0' or dataIn[i] == L.'L') and (clock_flag == 1) then
              nextstate[i] := T.StrengthMap[L.'0',strength];
            elseif ((next_assign_val[i] == L.'U') and not (clock_flag == 1)) 
              or ((dataIn[i] == L.'U') and not (clock_flag == 0)) then
              nextstate[i] := L.'U';
            else
              nextstate[i] := T.StrengthMap[L.'X',strength];
            end if;
          end if;
        end for;
      end if;
      next_assign_val := nextstate;
      dataOut := nextstate;
      annotation(Icon(coordinateSystem(
        preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-50, 60}, {50, -60}}, 
        lineColor = {127, 33, 107}, 
        lineThickness = 0.5, 
        fillPattern = FillPattern.Solid, 
        fillColor = {255, 255, 255}), 
        Line(
        points = {{-70, 30}, {-50, 30}}, 
        color = {127, 33, 107}, 
        thickness = 1), 
        Line(
        points = {{50, 30}, {76, 30}}, 
        color = {127, 33, 107}, 
        thickness = 1), 
        Line(
        points = {{-80, -20}, {-50, -20}}, 
        color = {127, 33, 107}), 
        Line(
        points = {{0, -84}, {0, -60}}, 
        color = {127, 33, 107}), 
        Line(
        points = {{-50, -8}, {-34, -20}, {-50, -32}}, 
        color = {127, 33, 107}), 
        Text(
        extent = {{-30, 54}, {20, 8}}, 
        textColor = {127, 33, 107}, 
        textString = "DFFR"), 
        Text(
        extent = {{-32, -14}, {-6, -26}}, 
        textColor = {127, 33, 107}, 
        textString = "clock"), 
        Text(
        extent = {{-14, -44}, {12, -56}}, 
        textColor = {127, 33, 107}, 
        textString = "reset")}), 
        Documentation(info = "<html>
<p>VHDL中的描述见 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities</a></p>

<p><strong>高电平复位的真值表：</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Clock</strong></td>
<td><strong>Reset</strong></td>
<td><strong>DataOut</strong></td>
<td>Map</td>
</tr>

<tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>2</td> </tr>
<tr><td>*</td> <td>0-转换</td> <td>0</td>  <td>NC</td> <td>3</td> </tr>
<tr><td>*</td> <td>1-转换</td> <td>0</td>  <td>DataIn</td> <td>3</td> </tr>
<tr><td>*</td> <td>X-转换</td> <td>0</td>  <td>X或U或NC</td> <td>3</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>X或U或0或NC</td> <td>4</td> </tr>
</table>

<p><strong>低电平复位的真值表：</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Clock</strong></td>
<td><strong>Reset</strong></td>
<td><strong>DataOut</strong></td>
<td>Map</td>
</tr>

<tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>0</td> <td>2</td> </tr>
<tr><td>*</td> <td>0-转换</td> <td>1</td>  <td>NC</td> <td>3</td> </tr>
<tr><td>*</td> <td>1-转换</td> <td>1</td>  <td>DataIn</td> <td>3</td> </tr>
<tr><td>*</td> <td>X-转换</td> <td>1</td>  <td>X或U或NC</td> <td>3</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>X或U或0或NC</td> <td>4</td> </tr>
</table>

<blockquote><pre>
*  = 不关心
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 无变化

时钟转换定义：
1-转换：0 -> 1
0-转换：~ -> 0 或 1 -> * 或 X -> X|U 或 U -> X|U
X-转换：0 -> X|U 或 X|U -> 1
</pre></blockquote>
</html>"          , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          ));
    end DFFR;






    model DFFREG "带高电平复位的边沿触发寄存器组"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' 
        "输出强度";
      parameter Integer n(min = 1) = 1 "数据宽度";
    protected
      constant Integer ResetMap[L] = {1, 4, 3, 2, 4, 4, 3, 2, 4};
      // 通过 [reset] 读取的功能选择
      // 1: 输出 := U
      // 2: 输出 := 0
      // 3: 输出 := -dataInUX
      // 4: 输出 := U-0X

    public
      Modelica.Electrical.Digital.Delay.InertialDelaySensitiveVector delay(
        tHL = tHL, 
        tLH = tLH, 
        n = n) 
        annotation(Placement(transformation(extent = {{22, 11}, {79, 69}})));
      D.Interfaces.DigitalInput reset 
        annotation(Placement(transformation(extent = {{-100, -68}, {-84, -52}}), 
        iconTransformation(extent = {{-100, -68}, {-84, -52}})));
      D.Interfaces.DigitalInput clock 
        annotation(Placement(transformation(extent = {{-100, -28}, {-84, -12}})));
      D.Interfaces.DigitalInput dataIn[n] 
        annotation(Placement(transformation(extent = {{-100, 32}, {-84, 48}})));
      D.Interfaces.DigitalOutput dataOut[n] 
        annotation(Placement(transformation(extent = {{84, 32}, {100, 48}}), 
        iconTransformation(extent = {{84, 32}, {100, 48}})));

      D.Registers.DFFR dFFR(n = n, 
        ResetMap = ResetMap, 
        strength = strength) 
        annotation(Placement(transformation(extent = {{-78, -23}, {18, 74}})));
    equation
      connect(delay.y, dataOut) annotation(Line(
        points = {{75.01, 40}, {92, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(dataIn, dFFR.dataIn) annotation(Line(
        points = {{-92, 40}, {-68.4, 40}, {-68.4, 40.05}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(dFFR.dataOut, delay.x) annotation(Line(
        points = {{7.92, 40.05}, {25.99, 39.855}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(clock, dFFR.clock) annotation(Line(
        points = {{-92, -20}, {-68.4, -20}, {-68.4, 15.8}}, color = {127, 0, 127}));
      connect(reset, dFFR.reset) annotation(Line(
        points = {{-92, -60}, {-30, -60}, {-30, -18.15}}, color = {127, 0, 127}));
      annotation(Icon(coordinateSystem(
        preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-50, 70}, {50, -50}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillPattern = FillPattern.Solid, 
        fillColor = {255, 255, 255}), 
        Line(
        points = {{-86, 40}, {-50, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-84, -20}, {-50, -20}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{-84, -60}, {0, -60}, {0, -50}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{50, 40}, {84, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-50, -10}, {-36, -20}, {-50, -30}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-32, 70}, {30, 10}}, 
        textColor = {127, 33, 107}, 
        textString = "DFFREG"), 
        Text(
        extent = {{-14, -34}, {12, -46}}, 
        textColor = {127, 33, 107}, 
        textString = "reset"), 
        Text(
        extent = {{-28, -14}, {-2, -26}}, 
        textColor = {127, 33, 107}, 
        textString = "clock"), 
        Text(
        extent = {{-26, 44}, {26, 2}}, 
        textColor = {127, 33, 107}, 
        textString = "high active")}), 
        Documentation(info = "<html>
<p>VHDL中的描述见 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>

<p><strong>真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Clock</strong></td>
<td><strong>Reset</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> </tr>
<tr><td>*</td> <td>0-转换</td> <td>0</td>  <td>NC</td> </tr>
<tr><td>*</td> <td>1-转换</td> <td>0</td>  <td>DataIn</td> </tr>
<tr><td>*</td> <td>X-转换</td> <td>0</td>  <td>X或U或NC</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>X或U或0或NC</td> </tr>
</table>

<blockquote><pre>
*  = 不关心
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 无变化

时钟转换定义：
1-转换：0 -> 1
0-转换：~ -> 0 或 1 -> * 或 X -> X|U 或 U -> X|U
X-转换：0 -> X|U 或 X|U -> 1
</pre></blockquote>
</html>"          , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          ));
    end DFFREG;

    model DFFREGL "带低电平复位的边沿触发寄存器组"
      extends DFFREG(final ResetMap = {1, 4, 2, 3, 4, 4, 2, 3, 4});
      // 通过 [reset] 读取的功能选择
      // 1: 输出 := U
      // 2: 输出 := 0
      // 3: 输出 := -dataInUX
      // 4: 输出 := U-0X;
      annotation(Documentation(info = "<html>
<p>VHDL中的描述见 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>

<p><strong>真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Clock</strong></td>
<td><strong>Reset</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>0</td> </tr>
<tr><td>*</td> <td>0-转换</td> <td>1</td>  <td>NC</td> </tr>
<tr><td>*</td> <td>1-转换</td> <td>1</td>  <td>DataIn</td> </tr>
<tr><td>*</td> <td>X-转换</td> <td>1</td>  <td>X或U或NC</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>X或U或0或NC</td> </tr>
</table>

<blockquote><pre>
*  = 不关心
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 无变化

时钟转换定义：
1-转换：0 -> 1
0-转换：~ -> 0 或 1 -> * 或 X -> X|U 或 U -> X|U
X-转换：0 -> X|U 或 X|U -> 1
</pre></blockquote>
</html>"          , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          ), Icon(graphics = {Rectangle(
        extent = {{-30, 30}, {28, 16}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid, 
        pattern = LinePattern.None), Text(
        extent = {{-28, 48}, {24, -1}}, 
        textColor = {127, 33, 107}, 
        textString = "low active")}));
    end DFFREGL;

    model DFFSR "带置位和复位的边沿触发寄存器组"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter Integer ResetSetMap[L,L] = [
        1, 1, 1, 1, 1, 1, 1, 1, 1;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 5, 8, 2, 5, 5, 8, 2, 5;
        1, 6, 3, 2, 6, 6, 3, 2, 6;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 5, 8, 2, 5, 5, 8, 2, 5;
        1, 6, 3, 2, 6, 6, 3, 2, 6;
        1, 4, 7, 2, 4, 4, 7, 2, 4] 
        "通过 [reset, set] 读取的功能选择";
      /* 默认为高电平的设置和复位 */
      parameter D.Interfaces.Strength strength = S.'S_X01' 
        "输出强度";
      parameter Integer n(min = 1) = 1 "数据宽度";

      D.Interfaces.DigitalInput set 
        annotation(Placement(transformation(extent = {{-10, 100}, {10, 80}})));
      D.Interfaces.DigitalInput reset 
        annotation(Placement(transformation(extent = {{-10, -100}, {10, -80}}), 
        iconTransformation(extent = {{-10, -100}, {10, -80}})));
      D.Interfaces.DigitalInput clock annotation(Placement(transformation(
        extent = {{-90, -20}, {-70, 0}}), iconTransformation(extent = {{-90, -30}, 
        {-70, -10}})));
      D.Interfaces.DigitalInput dataIn[n] annotation(Placement(transformation(
        extent = {{-90, 20}, {-70, 40}}), iconTransformation(extent = {{-90, 20}, 
        {-70, 40}})));
      D.Interfaces.DigitalOutput dataOut[n] annotation(Placement(
        transformation(extent = {{68, 20}, {88, 40}}), iconTransformation(
        extent = {{69, 20}, {89, 40}})));

    protected
      Integer clock_flag(start = 0);
      // 0: 0-转换
      // 1: 上升沿
      // 2: X-转换

      Integer reset_set_flag(start = 1);
      // 1: 输出 := U
      // 2: 输出 := 1
      // 3: 输出 := 0
      // 4: 输出 := UX
      // 5: 输出 := -1UX
      // 6: 输出 := X
      // 7: 输出 := -0UX
      // 8: 输出 := -dataInUX

      D.Interfaces.Logic nextstate[n](start = fill(L.'U', n));
      D.Interfaces.Logic next_assign_val[n](start = fill(L.'U', n));

    algorithm
      if change(clock) or change(reset) or change(set) then

        if change(clock) then
          if initial() then
            clock_flag := T.ClockMap[L.'U',clock];
          else
            clock_flag := T.ClockMap[pre(clock),clock];
          end if;
        end if;

        reset_set_flag := ResetSetMap[reset,set];
        for i in 1:n loop
          if reset_set_flag == 1 then
            nextstate[i] := L.'U';
          elseif reset_set_flag == 2 then
            nextstate[i] := T.StrengthMap[L.'1',strength];
          elseif reset_set_flag == 3 then
            nextstate[i] := T.StrengthMap[L.'0',strength];
          elseif reset_set_flag == 4 then
            if (next_assign_val[i] == L.'U' and clock_flag <> 1) 
              or (dataIn[i] == L.'U' and clock_flag <> 0) then
              nextstate[i] := L.'U';
            else
              nextstate[i] := T.StrengthMap[L.'X',strength];
            end if;
          elseif reset_set_flag == 5 then
            if next_assign_val[i] == T.StrengthMap[L.'1',strength] 
              and (dataIn[i] == L.'1' or dataIn[i] == L.'H' or clock_flag == 0) then
              break;
            elseif (dataIn[i] == L.'1' or dataIn[i] == L.'H') and clock_flag == 1 then
              nextstate[i] := T.StrengthMap[L.'1',strength];
            elseif (next_assign_val[i] == L.'U' and clock_flag <> 1) 
              or (dataIn[i] == L.'U' and clock_flag <> 0) then
              nextstate[i] := L.'U';
            else
              nextstate[i] := T.StrengthMap[L.'X',strength];
            end if;
          elseif reset_set_flag == 6 then
            nextstate[i] := T.StrengthMap[L.'X',strength];
          elseif reset_set_flag == 7 then
            if next_assign_val[i] == T.StrengthMap[L.'0',strength] 
              and (dataIn[i] == L.'0' or dataIn[i] == L.'L' or clock_flag == 0) then
              break;
            elseif (dataIn[i] == L.'0' or dataIn[i] == L.'L') and clock_flag == 1 then
              nextstate[i] := T.StrengthMap[L.'0',strength];
            elseif (next_assign_val[i] == L.'U' and clock_flag <> 1) 
              or (dataIn[i] == L.'U' and clock_flag <> 0) then
              nextstate[i] := L.'U';
            else
              nextstate[i] := T.StrengthMap[L.'X',strength];
            end if;
          elseif reset_set_flag == 8 then
            if clock_flag == 0 then
              break;
            elseif clock_flag == 1 then
              nextstate[i] := T.StrengthMap[dataIn[i],strength];
            else
              if next_assign_val[i] == T.StrengthMap[dataIn[i],strength] 
                or next_assign_val[i] == L.'U' then
                break;
              elseif (dataIn[i] == L.'U') then
                nextstate[i] := L.'U';
              else
                nextstate[i] := T.StrengthMap[L.'X',strength];
              end if;
            end if;
          end if;
        end for;
      end if;

      next_assign_val := nextstate;
      dataOut := nextstate;
      annotation(Icon(coordinateSystem(
        preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-50, 60}, {50, -60}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillPattern = FillPattern.Solid, 
        fillColor = {255, 255, 255}), 
        Line(
        points = {{-80, 30}, {-50, 30}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{50, 30}, {80, 30}}, 
        color = {127, 33, 107}, 
        thickness = 1), 
        Line(
        points = {{-80, -20}, {-50, -20}}, 
        color = {127, 33, 107}), 
        Line(
        points = {{0, -84}, {0, -60}}, 
        color = {127, 33, 107}), 
        Line(
        points = {{-50, -8}, {-34, -20}, {-50, -32}}, 
        color = {127, 33, 107}), 
        Text(
        extent = {{-36, 66}, {34, -8}}, 
        textColor = {127, 33, 107}, 
        textString = "DFFSR"), 
        Text(
        extent = {{-28, -14}, {-2, -26}}, 
        textColor = {127, 33, 107}, 
        textString = "clock"), 
        Text(
        extent = {{-14, -44}, {12, -56}}, 
        textColor = {127, 33, 107}, 
        textString = "reset"), 
        Line(
        points = {{0, 80}, {0, 60}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-13, 56}, {13, 44}}, 
        textColor = {127, 33, 107}, 
        textString = "set")}), 
        Documentation(info = "<html>
<p>VHDL中的描述见 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>

<p><strong>高电平设置和复位的真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Clock</strong></td>
<td><strong>Reset</strong></td>
<td><strong>Set</strong></td>
<td><strong>DataOut</strong></td>
<td>映射</td>
</tr>

<tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>U</td>  <td>*</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>*</td>  <td>1</td> <td>1</td> <td>2</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>0</td> <td>3</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>X</td> <td>X</td> <td>6</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>X</td> <td>X或U</td> <td>4</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td> <td>X</td> <td>X或U或1或NC</td> <td>5</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>0</td> <td>X或U或0或NC</td> <td>7</td> </tr>
<tr><td>*</td> <td>X-Trns</td> <td>0</td>  <td>0</td> <td>X或U或NC</td> <td>8</td> </tr>
<tr><td>*</td> <td>1-Trns</td> <td>0</td>  <td>0</td> <td>DataIn</td> <td>8</td> </tr>
<tr><td>*</td> <td>0-Trns</td> <td>0</td>  <td>0</td> <td>NC</td> <td>8</td> </tr>

</table>

<p><strong>低电平设置和复位的真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Clock</strong></td>
<td><strong>Reset</strong></td>
<td><strong>Set</strong></td>
<td><strong>DataOut</strong></td>
<td>映射</td>
</tr>

<tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>U</td>  <td>*</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>*</td>  <td>0</td> <td>1</td> <td>2</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>1</td> <td>0</td> <td>3</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>X</td> <td>X</td> <td>6</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>X</td> <td>X或U</td> <td>4</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td> <td>X</td> <td>X或U或1或NC</td> <td>5</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>1</td> <td>X或U或0或NC</td> <td>7</td> </tr>
<tr><td>*</td> <td>X-Trns</td> <td>1</td>  <td>1</td> <td>X或U或NC</td> <td>8</td> </tr>
<tr><td>*</td> <td>1-Trns</td> <td>1</td>  <td>1</td> <td>DataIn</td> <td>8</td> </tr>
<tr><td>*</td> <td>0-Trns</td> <td>1</td>  <td>1</td> <td>NC</td> <td>8</td> </tr>
</table>

<blockquote><pre>
*  = 不关心
~  = 不相等
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 保持不变

时钟转换定义：
1-Trns: 0 -> 1
0-Trns: ~ -> 0 或 1 -> * 或 X -> X|U 或 U -> X|U
X-Trns: 0 -> X|U 或 X|U -> 1
</pre></blockquote>
</html>"              , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由 Ulrich Donath 创建<br>
</li>
</ul>
</html>"              ));
    end DFFSR;

    model DFFREGSRH "带高有效置位和清零的边沿触发寄存器组"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' 
        "输出强度";
      parameter Integer n(min = 1) = 1 "数据宽度";

    protected
      constant Integer ResetSetMap[L,L] = [
        1, 1, 1, 1, 1, 1, 1, 1, 1;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 5, 8, 2, 5, 5, 8, 2, 5;
        1, 6, 3, 2, 6, 6, 3, 2, 6;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 5, 8, 2, 5, 5, 8, 2, 5;
        1, 6, 3, 2, 6, 6, 3, 2, 6;
        1, 4, 7, 2, 4, 4, 7, 2, 4];
      // [清零, 置位] 读取的功能选择，高电平有效;

    protected
      D.Delay.InertialDelaySensitiveVector delay(
        tHL = tHL, 
        tLH = tLH, 
        n = n, inertialDelaySensitive(each y(start = L.'U', fixed = true))) 
        annotation(Placement(transformation(extent = {{23, 12}, {79, 68}})));

      D.Registers.DFFSR dFFSR(
        strength = strength, 
        n = n, 
        ResetSetMap = ResetSetMap, clock(start = L.'U', fixed = true), reset(start = L.'U', fixed = true), set(start = L.'U', fixed = true)) 
        annotation(Placement(transformation(extent = {{-80, -25}, {20, 75}})));
    public
      D.Interfaces.DigitalInput set 
        annotation(Placement(transformation(extent = {{-100, 72}, {-84, 88}})));
      D.Interfaces.DigitalInput reset 
        annotation(Placement(transformation(extent = {{-100, -68}, {-84, -52}})));
      D.Interfaces.DigitalInput clock 
        annotation(Placement(transformation(extent = {{-100, -28}, {-84, -12}})));
      D.Interfaces.DigitalInput dataIn[n] 
        annotation(Placement(transformation(extent = {{-100, 32}, {-84, 48}})));
      D.Interfaces.DigitalOutput dataOut[n] 
        annotation(Placement(transformation(extent = {{84, 32}, {100, 48}})));
    equation
      connect(dFFSR.dataOut, delay.x) annotation(Line(
        points = {{9.5, 40}, {26.92, 40}, {26.92, 39.86}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(set, dFFSR.set) annotation(Line(
        points = {{-92, 80}, {-30, 80}, {-30, 70}}, color = {127, 0, 127}));
      connect(reset, dFFSR.reset) annotation(Line(
        points = {{-92, -60}, {-30, -60}, {-30, -20}}, color = {127, 0, 127}));
      connect(clock, dFFSR.clock) annotation(Line(
        points = {{-92, -20}, {-70, -20}, {-70, 15}}, color = {127, 0, 127}));
      connect(dataIn, dFFSR.dataIn) annotation(Line(
        points = {{-92, 40}, {-70, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(delay.y, dataOut) annotation(Line(
        points = {{75.08, 40}, {92, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      annotation(Icon(coordinateSystem(
        preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-50, 70}, {52, -50}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-86, 40}, {-50, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-84, -20}, {-50, -20}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{52, 40}, {84, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-50, -10}, {-36, -20}, {-50, -30}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-44, 94}, {38, -14}}, 
        textColor = {127, 33, 107}, 
        textString = "DFFREGSR"), 
        Text(
        extent = {{-14, -32}, {12, -44}}, 
        textColor = {127, 33, 107}, 
        textString = "清零"), 
        Text(
        extent = {{-33, -13}, {-7, -25}}, 
        textColor = {127, 33, 107}, 
        textString = "时钟"), 
        Line(
        points = {{-84, 80}, {0, 80}, {0, 70}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{-84, -60}, {0, -60}, {0, -50}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-14, 66}, {12, 54}}, 
        textColor = {127, 33, 107}, 
        textString = "置位"), 
        Text(
        extent = {{-32, 38}, {26, 10}}, 
        textColor = {127, 0, 127}, 
        textString = "高电平有效")}), 
        Documentation(info = "<html>
<p>VHDL中的描述见 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>

<p><strong>真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>数据输入</strong></td>
<td><strong>时钟</strong></td>
<td><strong>清零</strong></td>
<td><strong>置位</strong></td>
<td><strong>数据输出</strong></td>
</tr>

<tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>U</td>  <td>*</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>*</td>  <td>1</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>0</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>X</td> <td>X</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>X</td> <td>X或U</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td> <td>X</td> <td>X或U或1或NC</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>0</td> <td>X或U或0或NC</td> </tr>
<tr><td>*</td> <td>X-转换</td> <td>0</td>  <td>0</td> <td>X或U或NC</td> </tr>
<tr><td>*</td> <td>1-转换</td> <td>0</td>  <td>0</td> <td>数据输入</td> </tr>
<tr><td>*</td> <td>0-转换</td> <td>0</td>  <td>0</td> <td>NC</td> </tr>
</table>

<blockquote><pre>
*  = 无需考虑
~  = 不相等
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 无变化

时钟转换定义：
1-转换: 0 -> 1
0-转换: ~ -> 0 或 1 -> * 或 X -> X|U 或 U -> X|U
X-转换: 0 -> X|U 或 X|U -> 1
</pre></blockquote>
</html>"          , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          ));
    end DFFREGSRH;

    model DFFREGSRL "带低有效置位和清零的边沿触发寄存器组"
      extends Digital.Registers.DFFREGSRH(final ResetSetMap = [1, 1, 1, 1, 1, 1, 1, 1, 1;
        1, 4, 2, 7, 4, 4, 2, 7, 4; 1, 6, 2, 3, 6, 6, 2, 3, 6; 1, 5, 2, 8, 5, 5, 2, 8, 5; 1, 4, 2, 7, 4,
        4, 2, 7, 4; 1, 4, 2, 7, 4, 4, 2, 7, 4; 1, 6, 2, 3, 6, 6, 2, 3, 6; 1, 5, 2, 8, 5, 5, 2, 8, 5; 1,
        4, 2, 7, 4, 4, 2, 7, 4]);
      // [清零, 置位] 读取的功能选择;
      annotation(Icon(graphics = {Rectangle(
        extent = {{-36, 30}, {28, 16}}, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid, 
        pattern = LinePattern.None), Text(
        extent = {{-30, 38}, {24, 12}}, 
        textColor = {127, 0, 127}, 
        textString = "低有效")}), Documentation(info = "<html>
<p>VHDL中的描述见 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>

<p><strong>真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>数据输入</strong></td>
<td><strong>时钟</strong></td>
<td><strong>清零</strong></td>
<td><strong>置位</strong></td>
<td><strong>数据输出</strong></td>
</tr>

<tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>U</td>  <td>*</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>*</td>  <td>0</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>1</td> <td>0</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>X</td> <td>X</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>X</td> <td>X或U</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td> <td>X</td> <td>X或U或1或NC</td> </tr>
<tr><td>*</td> <td>*</td> <td>X</td> <td>1</td> <td>X或U或0或NC</td> </tr>
<tr><td>*</td> <td>X-转换</td> <td>1</td>  <td>1</td> <td>X或U或NC</td> </tr>
<tr><td>*</td> <td>1-转换</td> <td>1</td>  <td>1</td> <td>数据输入</td> </tr>
<tr><td>*</td> <td>0-转换</td> <td>1</td>  <td>1</td> <td>NC</td> </tr>
</table>

<blockquote><pre>
*  = 无需考虑
~  = 不相等
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 无变化

时钟转换定义：
1-转换: 0 -> 1
0-转换: ~ -> 0 或 1 -> * 或 X -> X|U 或 U -> X|U
X-转换: 0 -> X|U 或 X|U -> 1
</pre></blockquote>
</html>"          , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          ));
    end DFFREGSRL;

    model DLATR "带复位的电平敏感寄存器组"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter Integer ResetMap[L] = {1, 4, 3, 2, 4, 4, 3, 2, 4} 
        "功能选择，默认为高有效复位";
      parameter D.Interfaces.Strength strength = S.'S_X01' 
        "输出强度";
      parameter Integer n(min = 1) = 1 "数据宽度";

      D.Interfaces.DigitalInput reset 
        annotation(Placement(transformation(extent = {{-10, -100}, {10, -80}}), 
        iconTransformation(extent = {{-10, -100}, {10, -80}})));
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(
        extent = {{-90, -20}, {-70, 0}}), iconTransformation(extent = {{-90, -30}, 
        {-70, -10}})));
      D.Interfaces.DigitalInput dataIn[n] annotation(Placement(transformation(
        extent = {{-90, 20}, {-70, 40}}), iconTransformation(extent = {{-90, 20}, 
        {-70, 40}})));
      D.Interfaces.DigitalOutput dataOut[n] annotation(Placement(
        transformation(extent = {{66, 24}, {86, 44}}), iconTransformation(
        extent = {{69, 20}, {89, 40}})));

    protected
      Integer enable_flag(start = 0);
      // 0: 低电平
      // 1: 高电平
      // 2: 未知
      // 3: 未初始化

      Integer reset_flag(start = 1);
      // 1: 输出 := U
      // 2: 输出 := 0
      // 3: 输出 := -UdataIn
      // 4: 输出 := U-0X

      D.Interfaces.Logic nextstate[n](start = fill(L.'U', n));
      D.Interfaces.Logic next_assign_val[n](start = fill(L.'U', n));
    algorithm
      if enable == L.'1' or enable == L.'H' then
        enable_flag := 1;
      elseif enable == L.'0' or enable == L.'L' then
        enable_flag := 0;
      elseif enable == L.'U' then
        enable_flag := 3;
      else
        enable_flag := 2;
      end if;

      reset_flag := ResetMap[reset];
      for i in 1:n loop
        if reset_flag == 1 then
          nextstate[i] := L.'U';
        elseif reset_flag == 2 then
          nextstate[i] := T.StrengthMap[L.'0',strength];
        elseif reset_flag == 3 then
          if enable_flag == 0 then
            break;
          elseif enable_flag == 3 then
            nextstate[i] := L.'U';
          elseif enable_flag == 1 then
            nextstate[i] := T.StrengthMap[dataIn[i],strength];
          else
            if next_assign_val[i] == T.StrengthMap[dataIn[i],strength] 
              or next_assign_val[i] == L.'U' then
              break;
            elseif dataIn[i] == L.'U' then
              nextstate[i] := L.'U';
            else
              nextstate[i] := T.StrengthMap[L.'X',strength];
            end if;
          end if;
        elseif reset_flag == 4 then
          if enable_flag == 3 
            or (next_assign_val[i] == L.'U' and enable_flag <> 1) 
            or (dataIn[i] == L.'U' and enable_flag <> 0) then
            nextstate[i] := L.'U';
          elseif next_assign_val[i] == T.StrengthMap[L.'0',strength] 
            and (dataIn[i] == L.'0' or dataIn[i] == L.'L' or enable_flag == 0) then
            break;
          elseif (dataIn[i] == L.'0' or dataIn[i] == L.'L') and enable_flag == 1 then
            nextstate[i] := T.StrengthMap[L.'0',strength];
          else
            nextstate[i] := T.StrengthMap[L.'X',strength];
          end if;
        end if;
      end for;
      next_assign_val := nextstate;
      dataOut := nextstate;
      annotation(
        Documentation(info = "<html>

<p> 在VHDL 中的描述，请参见 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>高有效复位的真值表:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>Reset</strong></td>
<td><strong>DataOut</strong></td>
<td>Map</td>
</tr>

<tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>2</td> </tr>
<tr><td>*</td> <td>0</td> <td>0</td>  <td>NC</td> <td>3</td> </tr>
<tr><td>*</td> <td>1</td> <td>0</td>  <td>DataIn</td> <td>3</td> </tr>
<tr><td>*</td> <td>X</td> <td>0</td>  <td>X 或 U 或 NC</td> <td>3</td> </tr>
<tr><td>*</td> <td>U</td> <td>~1</td> <td>U</td> <td>4</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>X 或 U 或 0 或 NC</td> <td>4</td> </tr>
</table>

<p><strong>低有效复位的真值表:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>Reset</strong></td>
<td><strong>DataOut</strong></td>
<td>Map</td>
</tr>

<tr><td>*</td> <td>*</td> <td>U</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td> <td>0</td> <td>2</td> </tr>
<tr><td>*</td> <td>0</td> <td>1</td> <td>NC</td> <td>3</td> </tr>
<tr><td>*</td> <td>1</td> <td>1</td> <td>DataIn</td> <td>3</td> </tr>
<tr><td>*</td> <td>X</td> <td>1</td> <td>X 或 U 或 NC</td> <td>3</td> </tr>
<tr><td>*</td> <td>U</td> <td>~0</td> <td>U</td> <td>4</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>X 或 U 或 0 或 NC</td> <td>4</td> </tr>
</table>

<blockquote><pre>
*  = 不考虑
~  = 不相等
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 无变化
</pre></blockquote>
</html>"      , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      ), Icon(coordinateSystem(
        preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-50, 60}, {50, -60}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillPattern = FillPattern.Solid, 
        fillColor = {255, 255, 255}), 
        Line(
        points = {{-80, 30}, {-50, 30}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{50, 30}, {80, 30}}, 
        color = {127, 33, 107}, 
        thickness = 1), 
        Line(
        points = {{-80, -20}, {-50, -20}}, 
        color = {127, 33, 107}), 
        Line(
        points = {{0, -84}, {0, -60}}, 
        color = {127, 33, 107}), 
        Line(
        points = {{-50, -8}, {-34, -20}, {-50, -32}}, 
        color = {127, 33, 107}), 
        Text(
        extent = {{-30, 58}, {26, 2}}, 
        textColor = {127, 33, 107}, 
        textString = "DLATR"), 
        Text(
        extent = {{-29, -8}, {6, -32}}, 
        textColor = {127, 33, 107}, 
        textString = "enable"), 
        Text(
        extent = {{-14, -44}, {12, -56}}, 
        textColor = {127, 33, 107}, 
        textString = "reset")}));
    end DLATR;

    model DLATREG "带高有效复位的电平敏感寄存器组"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter SI.Time tHL = 0 "高->低延迟";
      parameter SI.Time tLH = 0 "低->高延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' 
        "输出强度";
      parameter Integer n(min = 1) = 1 "数据宽度";

    protected
      constant Integer ResetMap[L] = {1, 4, 3, 2, 4, 4, 3, 2, 4};
      // 根据[reset]读取的功能选择
      // 1: 输出 := U
      // 2: 输出 := 0
      // 3: 输出 := -UdataIn
      // 4: 输出 := U-0X

    public
      D.Delay.InertialDelaySensitiveVector delay(
        tHL = tHL, 
        tLH = tLH, 
        n = n) 
        annotation(Placement(transformation(extent = {{20, 12}, {76, 68}})));
      D.Interfaces.DigitalInput reset 
        annotation(Placement(transformation(extent = {{-100, -68}, {-84, -52}})));
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, -28}, {-84, -12}})));
      D.Interfaces.DigitalInput dataIn[n] 
        annotation(Placement(transformation(extent = {{-100, 32}, {-84, 48}})));
      D.Interfaces.DigitalOutput dataOut[n] 
        annotation(Placement(transformation(extent = {{84, 32}, {100, 48}}), 
        iconTransformation(extent = {{84, 32}, {100, 48}})));
      D.Registers.DLATR dLATR(n = n, 
        strength = strength, 
        ResetMap = ResetMap) 
        annotation(Placement(transformation(extent = {{-78, -23}, {18, 74}})));
    equation

      connect(delay.y, dataOut) annotation(Line(
        points = {{72.08, 40}, {92, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(dLATR.dataOut, delay.x) annotation(Line(
        points = {{7.92, 40.05}, {15.96, 39.86}, {23.92, 39.86}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(dataIn, dLATR.dataIn) annotation(Line(
        points = {{-92, 40}, {-80.2, 40}, {-80.2, 40.05}, {-68.4, 40.05}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(enable, dLATR.enable) annotation(Line(
        points = {{-92, -20}, {-68.4, -20}, {-68.4, 15.8}}, color = {127, 0, 127}));
      connect(reset, dLATR.reset) annotation(Line(
        points = {{-92, -60}, {-30, -60}, {-30, -18.15}}, color = {127, 0, 127}));
      annotation(
        Documentation(info = "<html>
<p>在VHDL中的描述，请参见<a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>Reset</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>*</td> <td>U</td>  <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> </tr>
<tr><td>*</td> <td>0</td> <td>0</td>  <td>NC</td> </tr>
<tr><td>*</td> <td>1</td> <td>0</td>  <td>DataIn</td> </tr>
<tr><td>*</td> <td>X</td> <td>0</td>  <td>X 或 U 或 NC</td> </tr>
<tr><td>*</td> <td>U</td> <td>~1</td> <td>U</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>X 或 U 或 0 或 NC</td> </tr>
</table>

<blockquote><pre>
*  = 不考虑
~  = 不相等
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 无变化
</pre></blockquote>
</html>"      , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      ), Icon(coordinateSystem(
        preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-50, 70}, {52, -50}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillPattern = FillPattern.Solid, 
        fillColor = {255, 255, 255}), 
        Line(
        points = {{-86, 40}, {-50, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-84, -20}, {-50, -20}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{52, 40}, {84, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-50, -10}, {-36, -20}, {-50, -30}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-32, 82}, {32, -2}}, 
        textColor = {127, 0, 127}, 
        textString = "DLATREG"), 
        Text(
        extent = {{-14, -33}, {12, -45}}, 
        textColor = {127, 33, 107}, 
        textString = "reset"), 
        Text(
        extent = {{-33, -7}, {-1, -32}}, 
        textColor = {127, 33, 107}, 
        textString = "enable"), 
        Line(
        points = {{-84, -60}, {0, -60}, {0, -50}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-26, 44}, {26, 2}}, 
        textColor = {127, 33, 107}, 
        textString = "高有效")}));
    end DLATREG;

    model DLATREGL "带低有效复位的电平敏感寄存器组"
      extends DLATREG(final ResetMap = {1, 4, 2, 3, 4, 4, 2, 3, 4});
      // 根据[reset]读取的功能选择
      // 1: 输出 := U
      // 2: 输出 := 0
      // 3: 输出 := -UdataIn
      // 4: 输出 := U-0X

      annotation(
        Documentation(info = "<html>
<p>在VHDL中的描述，请参见<a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>Reset</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>*</td> <td>U</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td> <td>0</td> </tr>
<tr><td>*</td> <td>0</td> <td>1</td> <td>NC</td> </tr>
<tr><td>*</td> <td>1</td> <td>1</td> <td>DataIn</td> </tr>
<tr><td>*</td> <td>X</td> <td>1</td> <td>X 或 U 或 NC</td> </tr>
<tr><td>*</td> <td>U</td> <td>~0</td> <td>U</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>X 或 U 或 0 或 NC</td> </tr>
</table>

<blockquote><pre>
*  = 不考虑
~  = 不相等
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 无变化
</pre></blockquote>
</html>"      , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      ), Icon(graphics = {Rectangle(
        extent = {{-28, 30}, {30, 18}}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), Text(
        extent = {{-26, 48}, {26, -1}}, 
        textColor = {127, 33, 107}, 
        textString = "low active")}));
    end DLATREGL;

    model DLATSR "带置位和复位的电平敏感寄存器组"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter Integer ResetSetMap[L,L] = [
        1, 1, 1, 1, 1, 1, 1, 1, 1;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 5, 8, 2, 5, 5, 8, 2, 5;
        1, 6, 3, 2, 6, 6, 3, 2, 6;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 5, 8, 2, 5, 5, 8, 2, 5;
        1, 6, 3, 2, 6, 6, 3, 2, 6;
        1, 4, 7, 2, 4, 4, 7, 2, 4] 
        "根据[reset, set]读取的功能选择";
      /* 默认置位和复位为高电平 */
      parameter D.Interfaces.Strength strength = S.'S_X01' 
        "输出强度";
      parameter Integer n(min = 1) = 1 "数据宽度";

      D.Interfaces.DigitalInput set 
        annotation(Placement(transformation(extent = {{-10, 100}, {10, 80}})));
      D.Interfaces.DigitalInput reset 
        annotation(Placement(transformation(extent = {{-10, -100}, {10, -80}}), 
        iconTransformation(extent = {{-10, -100}, {10, -80}})));
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(
        extent = {{-90, -20}, {-70, 0}}), iconTransformation(extent = {{-90, -30}, 
        {-70, -10}})));
      D.Interfaces.DigitalInput dataIn[n] annotation(Placement(transformation(
        extent = {{-90, 20}, {-70, 40}}), iconTransformation(extent = {{-90, 20}, 
        {-70, 40}})));
      D.Interfaces.DigitalOutput dataOut[n] annotation(Placement(
        transformation(extent = {{68, 20}, {88, 40}}), iconTransformation(
        extent = {{69, 20}, {89, 40}})));

    protected
      Integer enable_flag(start = 0);
      // 0: 低电平
      // 1: 高电平
      // 2: 未知
      // 3: 未初始化

      Integer reset_set_flag(start = 1);
      // 1: 输出 := U
      // 2: 输出 := 1
      // 3: 输出 := 0
      // 4: 输出 := UX
      // 5: 输出 := U-1X
      // 6: 输出 := X
      // 7: 输出 := U-0X
      // 8: 输出 := -UdataInX

      D.Interfaces.Logic nextstate[n](start = fill(L.'U', n));
      D.Interfaces.Logic next_assign_val[n](start = fill(L.'U', n));

    algorithm
      if enable == L.'1' or enable == L.'H' then
        enable_flag := 1;
      elseif enable == L.'0' or enable == L.'L' then
        enable_flag := 0;
      elseif enable == L.'U' then
        enable_flag := 3;
      else
        enable_flag := 2;
      end if;

      reset_set_flag := ResetSetMap[reset,set];
      for i in 1:n loop
        if reset_set_flag == 1 then
          nextstate[i] := L.'U';
        elseif reset_set_flag == 2 then
          nextstate[i] := T.StrengthMap[L.'1',strength];
        elseif reset_set_flag == 3 then
          nextstate[i] := T.StrengthMap[L.'0',strength];
        elseif reset_set_flag == 4 then
          if enable_flag == 3 
            or (next_assign_val[i] == L.'U' and enable_flag <> 1) 
            or (dataIn[i] == L.'U' and enable_flag <> 0) then
            nextstate[i] := L.'U';
          else
            nextstate[i] := T.StrengthMap[L.'X',strength];
          end if;
        elseif reset_set_flag == 5 then
          if enable_flag == 3 
            or (next_assign_val[i] == L.'U' and enable_flag <> 1) 
            or (dataIn[i] == L.'U' and enable_flag <> 0) then
            nextstate[i] := L.'U';
          elseif next_assign_val[i] == T.StrengthMap[L.'1',strength] 
            and (dataIn[i] == L.'1' or dataIn[i] == L.'H' or enable_flag == 0) then
            break;
          elseif (dataIn[i] == L.'1' or dataIn[i] == L.'H') and enable_flag == 1 then
            nextstate[i] := T.StrengthMap[L.'1',strength];
          else
            nextstate[i] := T.StrengthMap[L.'X',strength];
          end if;
        elseif reset_set_flag == 6 then
          nextstate[i] := T.StrengthMap[L.'X',strength];
        elseif reset_set_flag == 7 then
          if enable_flag == 3 
            or (next_assign_val[i] == L.'U' and enable_flag <> 1) 
            or (dataIn[i] == L.'U' and enable_flag <> 0) then
            nextstate[i] := L.'U';
          elseif next_assign_val[i] == T.StrengthMap[L.'0',strength] 
            and (dataIn[i] == L.'0' or dataIn[i] == L.'L' or enable_flag == 0) then
            break;
          elseif (dataIn[i] == L.'0' or dataIn[i] == L.'L') and enable_flag == 1 then
            nextstate[i] := T.StrengthMap[L.'0',strength];
          else
            nextstate[i] := T.StrengthMap[L.'X',strength];
          end if;
        elseif reset_set_flag == 8 then
          if enable_flag == 0 then
            break;
          elseif enable_flag == 3 then
            nextstate[i] := L.'U';
          elseif enable_flag == 1 then
            nextstate[i] := T.StrengthMap[dataIn[i],strength];
          else
            if next_assign_val[i] == T.StrengthMap[dataIn[i],strength] 
              or next_assign_val[i] == L.'U' then
              break;
            elseif dataIn[i] == L.'U' then
              nextstate[i] := L.'U';
            else
              nextstate[i] := T.StrengthMap[L.'X',strength];
            end if;
          end if;
        end if;
      end for;
      next_assign_val := nextstate;
      dataOut := nextstate;
      annotation(
        Documentation(info = "<html>
<p>VHDL中的描述请参见<a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>高有效置位和复位的真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>Reset</strong></td>
<td><strong>Set</strong></td>
<td><strong>DataOut</strong></td>
<td>映射</td>
</tr>

<tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>U</td>  <td>~1</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>*</td>  <td>1</td> <td>1</td> <td>2</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>0</td> <td>3</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>X</td> <td>X</td> <td>6</td> </tr>
<tr><td>*</td> <td>U</td> <td>~1</td> <td>~1</td> <td>U</td> <td>4,5,7,8</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>X</td> <td>X or U</td> <td>4</td> </tr>
<tr><td>*</td> <td>~U</td> <td>0</td> <td>X</td> <td>X or U or 1 or NC</td> <td>5</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>0</td> <td>X or U or 0 or NC</td> <td>7</td> </tr>
<tr><td>*</td> <td>X</td> <td>0</td>  <td>0</td> <td>X or U or NC</td> <td>8</td> </tr>
<tr><td>*</td> <td>1</td> <td>0</td>  <td>0</td> <td>DataIn</td> <td>8</td> </tr>
<tr><td>*</td> <td>0</td> <td>0</td>  <td>0</td> <td>NC</td> <td>8</td> </tr>

</table>

<p><strong>低有效置位和复位的真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>Reset</strong></td>
<td><strong>Set</strong></td>
<td><strong>DataOut</strong></td>
<td>映射</td>
</tr>

<tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>U</td>  <td>~0</td> <td>U</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>*</td>  <td>0</td> <td>1</td> <td>2</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>1</td> <td>0</td> <td>3</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>X</td> <td>X</td> <td>6</td> </tr>
<tr><td>*</td> <td>U</td> <td>~0</td> <td>~0</td> <td>U</td> <td>4,5,7,8</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>X</td> <td>X or U</td> <td>4</td> </tr>
<tr><td>*</td> <td>~U</td> <td>1</td> <td>X</td> <td>X or U or 1 or NC</td> <td>5</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>1</td> <td>X or U or 0 or NC</td> <td>7</td> </tr>
<tr><td>*</td> <td>X</td> <td>1</td>  <td>1</td> <td>X or U or NC</td> <td>8</td> </tr>
<tr><td>*</td> <td>1</td> <td>1</td>  <td>1</td> <td>DataIn</td> <td>8</td> </tr>
<tr><td>*</td> <td>0</td> <td>1</td>  <td>1</td> <td>NC</td> <td>8</td> </tr>

</table>

<blockquote><pre>
*  = 不关心
~  = 不等于
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 不改变
</pre></blockquote>
</html>"      , revisions = "<html>
<ul>
<li><em>2009年9月11日</em>由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      ), Icon(coordinateSystem(
        preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-50, 60}, {50, -60}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillPattern = FillPattern.Solid, 
        fillColor = {255, 255, 255}), 
        Line(
        points = {{-80, 30}, {-50, 30}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{50, 30}, {80, 30}}, 
        color = {127, 33, 107}, 
        thickness = 1), 
        Line(
        points = {{-80, -20}, {-50, -20}}, 
        color = {127, 33, 107}), 
        Line(
        points = {{0, -84}, {0, -60}}, 
        color = {127, 33, 107}), 
        Line(
        points = {{-50, -8}, {-34, -20}, {-50, -32}}, 
        color = {127, 33, 107}), 
        Text(
        extent = {{-34, 60}, {32, -6}}, 
        textColor = {127, 33, 107}, 
        textString = "DLATSR"), 
        Text(
        extent = {{-29, -8}, {5, -30}}, 
        textColor = {127, 33, 107}, 
        textString = "enable"), 
        Text(
        extent = {{-14, -44}, {12, -56}}, 
        textColor = {127, 33, 107}, 
        textString = "reset"), 
        Line(
        points = {{0, 80}, {0, 60}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-13, 56}, {13, 44}}, 
        textColor = {127, 33, 107}, 
        textString = "set")}));
    end DLATSR;

    model DLATREGSRH "带置位和复位的电平敏感型寄存器组，高电平有效"

      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' 
        "输出强度";
      parameter Integer n(min = 1) = 1 "数据宽度";

    protected
      constant Integer ResetSetMap[L,L] = [
        1, 1, 1, 1, 1, 1, 1, 1, 1;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 5, 8, 2, 5, 5, 8, 2, 5;
        1, 6, 3, 2, 6, 6, 3, 2, 6;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 4, 7, 2, 4, 4, 7, 2, 4;
        1, 5, 8, 2, 5, 5, 8, 2, 5;
        1, 6, 3, 2, 6, 6, 3, 2, 6;
        1, 4, 7, 2, 4, 4, 7, 2, 4];
      // 通过[复位，置位]读取功能，高电平有效;

    public
      D.Delay.InertialDelaySensitiveVector delay(
        tHL = tHL, 
        tLH = tLH, 
        n = n) 
        annotation(Placement(transformation(extent = {{20, 12}, {76, 68}})));
      D.Interfaces.DigitalInput set 
        annotation(Placement(transformation(extent = {{-100, 72}, {-84, 88}})));
      D.Interfaces.DigitalInput reset 
        annotation(Placement(transformation(extent = {{-100, -68}, {-84, -52}})));
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, -28}, {-84, -12}})));
      D.Interfaces.DigitalInput dataIn[n] 
        annotation(Placement(transformation(extent = {{-100, 32}, {-84, 48}})));
      D.Interfaces.DigitalOutput dataOut[n] 
        annotation(Placement(transformation(extent = {{84, 32}, {100, 48}}), 
        iconTransformation(extent = {{84, 32}, {100, 48}})));
      D.Registers.DLATSR dLATSR(n = n, 
        ResetSetMap = ResetSetMap, 
        strength = strength) 
        annotation(Placement(transformation(extent = {{-78, -23}, {18, 74}})));
    equation

      connect(delay.y, dataOut) annotation(Line(
        points = {{72.08, 40}, {92, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(set, dLATSR.set) annotation(Line(
        points = {{-92, 80}, {-30, 80}, {-30, 69.15}}, color = {127, 0, 127}));
      connect(reset, dLATSR.reset) annotation(Line(
        points = {{-92, -60}, {-30, -60}, {-30, -18.15}}, color = {127, 0, 127}));
      connect(enable, dLATSR.enable) annotation(Line(
        points = {{-92, -20}, {-68.4, -20}, {-68.4, 15.8}}, color = {127, 0, 127}));
      connect(dataIn, dLATSR.dataIn) annotation(Line(
        points = {{-92, 40}, {-80.2, 40}, {-80.2, 40.05}, {-68.4, 40.05}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      connect(dLATSR.dataOut, delay.x) annotation(Line(
        points = {{7.92, 40.05}, {23.92, 40.05}, {23.92, 39.86}}, 
        color = {127, 0, 127}, 
        thickness = 1));
      annotation(
        Documentation(info = "<html>
<p>VHDL中的描述见 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>真值表:</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>Reset</strong></td>
<td><strong>Set</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>U</td>  <td>~1</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>*</td>  <td>1</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>0</td> <td>0</td> </tr>
<tr><td>*</td> <td>*</td> <td>1</td>  <td>X</td> <td>X</td> </tr>
<tr><td>*</td> <td>U</td> <td>~1</td> <td>~1</td> <td>U</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>X</td> <td>X或U</td> </tr>
<tr><td>*</td> <td>~U</td> <td>0</td> <td>X</td> <td>X或U或1或NC</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>0</td> <td>X或U或0或NC</td> </tr>
<tr><td>*</td> <td>X</td> <td>0</td>  <td>0</td> <td>X或U或NC</td> </tr>
<tr><td>*</td> <td>1</td> <td>0</td>  <td>0</td> <td>DataIn</td> </tr>
<tr><td>*</td> <td>0</td> <td>0</td>  <td>0</td> <td>NC</td> </tr>

</table>

<blockquote><pre>
*  = 任意值
~  = 不等于
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 保持不变
</pre></blockquote>
</html>"          , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          ), Icon(coordinateSystem(
        preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Rectangle(
        extent = {{-50, 70}, {52, -50}}, 
        lineColor = {127, 0, 127}, 
        lineThickness = 0.5, 
        fillPattern = FillPattern.Solid, 
        fillColor = {255, 255, 255}), 
        Line(
        points = {{-86, 40}, {-50, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-84, -20}, {-50, -20}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{52, 40}, {84, 40}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-50, -10}, {-36, -20}, {-50, -30}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-46, 96}, {46, -18}}, 
        textColor = {127, 0, 127}, 
        textString = "DLATREGSR"), 
        Text(
        extent = {{-14, -32}, {14, -45}}, 
        textColor = {127, 33, 107}, 
        textString = "复位"), 
        Text(
        extent = {{-33, -7}, {-1, -32}}, 
        textColor = {127, 33, 107}, 
        textString = "使能"), 
        Line(
        points = {{-84, 80}, {0, 80}, {0, 70}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{-84, -60}, {0, -60}, {0, -50}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-14, 67}, {12, 53}}, 
        textColor = {127, 33, 107}, 
        textString = "置位"), 
        Text(
        extent = {{-28, 38}, {30, 10}}, 
        textColor = {127, 0, 127}, 
        textString = "高电平有效")}));
    end DLATREGSRH;

    model DLATREGSRL "带置位和复位的电平敏感型寄存器组，低电平有效"

      extends Digital.Registers.DLATREGSRH(final ResetSetMap = [1, 1, 1, 1, 1, 1, 1, 1, 1;
        1, 4, 2, 7, 4, 4, 2, 7, 4; 1, 6, 2, 3, 5, 5, 2, 3, 6; 1, 5, 2, 8, 6, 6, 2, 8, 5; 1, 4, 2, 7, 4,
        4, 2, 7, 4; 1, 4, 2, 7, 4, 4, 2, 7, 4; 1, 6, 2, 3, 5, 5, 2, 3, 6; 1, 5, 2, 8, 6, 6, 2, 8, 5; 1,
        4, 2, 7, 4, 4, 2, 7, 4]);
      // 通过[复位，置位]读取功能;
      annotation(
        Documentation(info = "<html>

<p>VHDL中的描述可参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>

<p><strong>真值表</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>Reset</strong></td>
<td><strong>Set</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>*</td> <td>*</td>  <td>U</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>U</td>  <td>~0</td> <td>U</td> </tr>
<tr><td>*</td> <td>*</td> <td>*</td>  <td>0</td> <td>1</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>1</td> <td>0</td> </tr>
<tr><td>*</td> <td>*</td> <td>0</td>  <td>X</td> <td>X</td> </tr>
<tr><td>*</td> <td>U</td> <td>~0</td> <td>~0</td> <td>U</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>X</td> <td>X或U</td> </tr>
<tr><td>*</td> <td>~U</td> <td>1</td> <td>X</td> <td>X或U或1或NC</td> </tr>
<tr><td>*</td> <td>~U</td> <td>X</td> <td>1</td> <td>X或U或0或NC</td> </tr>
<tr><td>*</td> <td>X</td> <td>1</td>  <td>1</td> <td>X或U或NC</td> </tr>
<tr><td>*</td> <td>1</td> <td>1</td>  <td>1</td> <td>DataIn</td> </tr>
<tr><td>*</td> <td>0</td> <td>1</td>  <td>1</td> <td>NC</td> </tr>
</table>

<blockquote><pre>
*  = 任意值
~  = 不等于
U  = L.'U'
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-'
NC = 保持不变
</pre></blockquote>
</html>"          , revisions = "<html>
<ul>
<li><em>2009年9月11日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          ), Icon(graphics = {Rectangle(
        extent = {{-40, 30}, {40, 16}}, 
        pattern = LinePattern.None, 
        fillColor = {255, 255, 255}, 
        fillPattern = FillPattern.Solid), Text(
        extent = {{-30, 30}, {30, 16}}, 
        textColor = {127, 0, 127}, 
        textString = "低电平有效")}));
    end DLATREGSRL;

    annotation(Documentation(info = 
      "<html>
<p>Registers是一组触发器和锁存器。与Examples.Utilities模型相反，Register模型是模型的算法部分中的一系列赋值。该模型文本几乎与标准逻辑文本相同。</p>
</html>"  ));
  end Registers;

  package Tristates "传输门、缓冲器、反相器和有线X"
    extends Modelica.Icons.Package;
    import D = Modelica.Electrical.Digital;
    import L = Modelica.Electrical.Digital.Interfaces.Logic;
    import T = Modelica.Electrical.Digital.Tables;
    import S = Modelica.Electrical.Digital.Interfaces.Strength;

    model NXFERGATE "使能端口高电平有效的传输门"
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), 
        iconTransformation(extent = {{-100, 60}, {-80, 80}})));
      D.Interfaces.DigitalInput x 
        annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), 
        iconTransformation(extent = {{-100, -20}, {-80, 0}})));
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), 
        iconTransformation(extent = {{80, -20}, {100, 0}})));
    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL, y(start = L.'U', fixed = true));
    algorithm
      nextstate := T.NXferTable[enable,x];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-60, 60}, {60, -20}}, 
        lineColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid, 
        fillColor = {213, 170, 255}, 
        lineThickness = 0.5), 
        Line(
        points = {{-33, 16}, {31, 16}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-80, -10}, {-32, -10}, {-32, 10}, {30, 10}, {30, -10}, {80, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-7, 46}, {39, 18}}, 
        textColor = {127, 0, 127}, 
        textString = "N"), 
        Line(
        points = {{-82, 70}, {0, 70}, {0, 16}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-44, -24}, {30, -46}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}), 
        Documentation(revisions = "<html>
<ul>
<li><em>2010年1月15日</em>由Ulrich Donath创建<br>
</li>
</ul>
</html>"              , info = "<html>
<p>在VHDL中的描述请参考<a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>真值表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>U</td> <td>U</td></tr>
<tr><td>*</td> <td>X</td> <td>UX</td></tr>
<tr><td>*</td> <td>0</td> <td>Z</td></tr>
<tr><td>*</td> <td>1</td> <td>DataIn</td></tr>
<tr><td>*</td> <td>Z</td> <td>UX</td></tr>
<tr><td>*</td> <td>W</td> <td>UX</td></tr>
<tr><td>*</td> <td>L</td> <td>Z</td></tr>
<tr><td>*</td> <td>H</td> <td>DataIn</td></tr>
<tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: 如果dataIn ==U则返回U，否则返回X
</pre></blockquote>
</html>"              ));

    end NXFERGATE;

    model NRXFERGATE 
      "使能端口路高电平有效的传输门，输出强度减小"
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), 
        iconTransformation(extent = {{-100, 60}, {-80, 80}})));
      D.Interfaces.DigitalInput x 
        annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), 
        iconTransformation(extent = {{-100, -20}, {-80, 0}})));
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), 
        iconTransformation(extent = {{80, -20}, {100, 0}})));
    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL, y(start = L.'U', fixed = true));
    algorithm
      nextstate := T.NRXferTable[enable,x];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-60, 60}, {60, -20}}, 
        lineColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid, 
        fillColor = {213, 170, 255}, 
        lineThickness = 0.5), 
        Line(
        points = {{-33, 16}, {31, 16}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-80, -10}, {-32, -10}, {-32, 10}, {30, 10}, {30, -10}, {80, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-2, 46}, {44, 18}}, 
        textColor = {127, 0, 127}, 
        textString = "NR"), 
        Line(
        points = {{-82, 70}, {0, 70}, {0, 16}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-36, -24}, {38, -46}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}), 
        Documentation(revisions = "<html>
<ul>
<li><em>2010年1月15日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"                  , info = "<html>
<p>在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>真值表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>U</td> <td>U</td></tr>
<tr><td>*</td> <td>X</td> <td>UW</td></tr>
<tr><td>*</td> <td>0</td> <td>Z</td></tr>
<tr><td>*</td> <td>1</td> <td>DataIn, 强度减小</td></tr>
<tr><td>*</td> <td>Z</td> <td>UW</td></tr>
<tr><td>*</td> <td>W</td> <td>UW</td></tr>
<tr><td>*</td> <td>L</td> <td>Z</td></tr>
<tr><td>*</td> <td>H</td> <td>DataIn, 强度减小</td></tr>
<tr><td>*</td> <td>-</td> <td>UW</td></tr>
</table>

<blockquote><pre>
UW: 如果 dataIn == U 则返回 U，否则返回 W
强度减小: 0 -> L, 1 -> H, X -> W
</pre></blockquote>
</html>"                  ));
    end NRXFERGATE;

    model PXFERGATE 
      "使能端口低电平有效的传输门"
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), 
        iconTransformation(extent = {{-100, 60}, {-80, 80}})));
      D.Interfaces.DigitalInput x 
        annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), 
        iconTransformation(extent = {{-100, -20}, {-80, 0}})));
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), 
        iconTransformation(extent = {{80, -20}, {100, 0}})));
    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL);
    algorithm
      nextstate := T.PXferTable[enable,x];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-60, 60}, {60, -20}}, 
        lineColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid, 
        fillColor = {213, 170, 255}, 
        lineThickness = 0.5), 
        Line(
        points = {{-33, 16}, {31, 16}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-80, -10}, {-32, -10}, {-32, 10}, {30, 10}, {30, -10}, {80, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-7, 46}, {39, 18}}, 
        textColor = {127, 0, 127}, 
        textString = "P"), 
        Line(
        points = {{-82, 70}, {0, 70}, {0, 16}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-36, -24}, {38, -46}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}), 
        Documentation(revisions = "<html>
<ul>
<li><em>2010年1月15日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          , info = "<html>
<p>在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>真值表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>U</td> <td>U</td></tr>
<tr><td>*</td> <td>X</td> <td>UX</td></tr>
<tr><td>*</td> <td>0</td> <td>DataIn</td></tr>
<tr><td>*</td> <td>1</td> <td>Z</td></tr>
<tr><td>*</td> <td>Z</td> <td>UX</td></tr>
<tr><td>*</td> <td>W</td> <td>UX</td></tr>
<tr><td>*</td> <td>L</td> <td>DataIn</td></tr>
<tr><td>*</td> <td>H</td> <td>Z</td></tr>
<tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: 如果 dataIn == U 则返回 U，否则返回 X
</pre></blockquote>
</html>"          ));
    end PXFERGATE;

    model PRXFERGATE 
      "使能端口低电平有效的传输门，输出强度减小"
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), 
        iconTransformation(extent = {{-100, 60}, {-80, 80}})));
      D.Interfaces.DigitalInput x 
        annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), 
        iconTransformation(extent = {{-100, -20}, {-80, 0}})));
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), 
        iconTransformation(extent = {{80, -20}, {100, 0}})));
    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL);
    algorithm
      nextstate := T.PRXferTable[enable,x];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Rectangle(
        extent = {{-60, 60}, {60, -20}}, 
        lineColor = {127, 0, 127}, 
        fillPattern = FillPattern.Solid, 
        fillColor = {213, 170, 255}, 
        lineThickness = 0.5), 
        Line(
        points = {{-33, 16}, {31, 16}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-80, -10}, {-32, -10}, {-32, 10}, {30, 10}, {30, -10}, {80, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-2, 46}, {44, 18}}, 
        textColor = {127, 0, 127}, 
        textString = "PR"), 
        Line(
        points = {{-82, 70}, {0, 70}, {0, 16}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-40, -24}, {34, -46}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}), 
        Documentation(revisions = "<html>
<ul>
<li><em>2010年1月15日</em> 由Ulrich Donath创建<br>
</li>
</ul>
</html>"          , info = "<html>
<p>在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p><strong>真值表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>DataOut</strong></td>
</tr>

<tr><td>*</td> <td>U</td> <td>U</td></tr>
<tr><td>*</td> <td>X</td> <td>UW</td></tr>
<tr><td>*</td> <td>0</td> <td>DataIn, 强度减小</td></tr>
<tr><td>*</td> <td>1</td> <td>Z</td></tr>
<tr><td>*</td> <td>Z</td> <td>UW</td></tr>
<tr><td>*</td> <td>W</td> <td>UW</td></tr>
<tr><td>*</td> <td>L</td> <td>DataIn, 强度减小</td></tr>
<tr><td>*</td> <td>H</td> <td>Z</td></tr>
<tr><td>*</td> <td>-</td> <td>UW</td></tr>
</table>
<p>
UW: 如果 dataIn == U 则返回 U，否则返回 W
强度减小: 0 -> L, 1 -> H, X -> W
</p>
</html>"          ));
    end PRXFERGATE;

    model BUF3S "使能端口高电平有效的三态缓冲器"
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' "输出强度";
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), 
        iconTransformation(extent = {{-100, 60}, {-80, 80}})));
      D.Interfaces.DigitalInput x 
        annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), 
        iconTransformation(extent = {{-100, -20}, {-80, 0}})));
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), 
        iconTransformation(extent = {{80, -20}, {100, 0}})));
    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL, y(start = L.'U', fixed = true));
    algorithm
      nextstate := T.Buf3sTable[strength,T.UX01Conv[enable],T.UX01Conv[x]];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Line(
        points = {{-80, 70}, {0, 70}, {0, 14}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Polygon(
        points = {{-40, 40}, {-40, -60}, {40, -10}, {-40, 40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-80, -10}, {-40, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{40, -10}, {82, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-54, -62}, {20, -84}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}), 
        Documentation(revisions = "<html>
<ul>
<li><em>2010年1月22日</em> 由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      , info = "<html>
<p>在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p>关于三态表格，请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</a></p>
<p><strong>真值表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>DataOut*</strong></td>
</tr>

<tr><td>*</td> <td>U</td> <td>U</td></tr>
<tr><td>*</td> <td>X</td> <td>UX</td></tr>
<tr><td>*</td> <td>0</td> <td>Z</td></tr>
<tr><td>*</td> <td>1</td> <td>DataIn</td></tr>
<tr><td>*</td> <td>Z</td> <td>UX</td></tr>
<tr><td>*</td> <td>W</td> <td>UX</td></tr>
<tr><td>*</td> <td>L</td> <td>Z</td></tr>
<tr><td>*</td> <td>H</td> <td>DataIn</td></tr>
<tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: 如果 dataIn == U 则返回 U，否则返回 X
DataOut*: 根据三态表格 Buf3sTable 映射的 DataOut 强度
</pre></blockquote>
</html>"      ));
    end BUF3S;

    model BUF3SL "使能端口低电平有效的三态缓冲器"
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' "输出强度";
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), 
        iconTransformation(extent = {{-100, 60}, {-80, 80}})));
      D.Interfaces.DigitalInput x 
        annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), 
        iconTransformation(extent = {{-100, -20}, {-80, 0}})));
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), 
        iconTransformation(extent = {{80, -20}, {100, 0}})));
    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL);
    algorithm
      nextstate := T.Buf3slTable[strength,T.UX01Conv[enable],T.UX01Conv[x]];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Line(
        points = {{-80, 70}, {0, 70}, {0, 14}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Polygon(
        points = {{-40, 40}, {-40, -60}, {40, -10}, {-40, 40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-80, -10}, {-40, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{40, -10}, {82, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Text(
        extent = {{-54, -62}, {20, -84}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}), 
        Documentation(revisions = "<html>
<ul>
<li><em>2010年1月22日</em> 由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      , info = "<html>
<p>在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p>关于三态表格，请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</a></p>
<p><strong>真值表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>DataOut*</strong></td>
</tr>

<tr><td>*</td> <td>U</td> <td>U</td></tr>
<tr><td>*</td> <td>X</td> <td>UX</td></tr>
<tr><td>*</td> <td>0</td> <td>DataIn</td></tr>
<tr><td>*</td> <td>1</td> <td>Z</td></tr>
<tr><td>*</td> <td>Z</td> <td>UX</td></tr>
<tr><td>*</td> <td>W</td> <td>UX</td></tr>
<tr><td>*</td> <td>L</td> <td>DataIn</td></tr>
<tr><td>*</td> <td>H</td> <td>Z</td></tr>
<tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: 如果 dataIn == U 则返回 U，否则返回 X
DataOut*: 根据三态表格 Buf3slTable 映射的 DataOut 强度
</pre></blockquote>
</html>"      ));
    end BUF3SL;

    model INV3S "使能端口高电平有效的三态反相器"
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' "输出强度";
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), 
        iconTransformation(extent = {{-100, 60}, {-80, 80}})));
      D.Interfaces.DigitalInput x 
        annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), 
        iconTransformation(extent = {{-100, -20}, {-80, 0}})));
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), 
        iconTransformation(extent = {{80, -20}, {100, 0}})));
    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL, y(start = L.'U', fixed = true));
    algorithm
      nextstate := T.Buf3sTable[strength,T.UX01Conv[enable],T.UX01Conv[T.NotTable[x]]];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Line(
        points = {{-80, 70}, {0, 70}, {0, 14}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Polygon(
        points = {{-40, 40}, {-40, -60}, {40, -10}, {-40, 40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-80, -10}, {-40, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{40, -10}, {82, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Ellipse(
        extent = {{40, -3}, {54, -17}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-54, -62}, {20, -84}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}), 
        Documentation(revisions = "<html>
<ul>
<li><em>2010年1月22日</em> 由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      , info = "<html>
<p>在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p>关于三态表格，请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</a></p>
<p><strong>真值表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>DataOut*</strong></td>
</tr>

<tr><td>*</td> <td>U</td> <td>U</td></tr>
<tr><td>*</td> <td>X</td> <td>UX</td></tr>
<tr><td>*</td> <td>0</td> <td>Z</td></tr>
<tr><td>*</td> <td>1</td> <td>非 DataIn</td></tr>
<tr><td>*</td> <td>Z</td> <td>UX</td></tr>
<tr><td>*</td> <td>W</td> <td>UX</td></tr>
<tr><td>*</td> <td>L</td> <td>Z</td></tr>
<tr><td>*</td> <td>H</td> <td>非 DataIn</td></tr>
<tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: 如果 dataIn == U 则返回 U，否则返回 X
DataOut*: 根据三态表格 Buf3sTable 映射的 DataOut 强度
</pre></blockquote>
</html>"      ));
    end INV3S;

    model INV3SL "使能端口低电平有效的三态反相器"
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' "输出强度";
      D.Interfaces.DigitalInput enable 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}}), 
        iconTransformation(extent = {{-100, 60}, {-80, 80}})));
      D.Interfaces.DigitalInput x 
        annotation(Placement(transformation(extent = {{-100, -20}, {-80, 0}}), 
        iconTransformation(extent = {{-100, -20}, {-80, 0}})));
      D.Interfaces.DigitalOutput y 
        annotation(Placement(transformation(extent = {{80, -20}, {100, 0}}), 
        iconTransformation(extent = {{80, -20}, {100, 0}})));
    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL);
    algorithm
      nextstate := T.Buf3sTable[strength,T.UX01Conv[T.NotTable[enable]],T.UX01Conv[T.NotTable[x]]];
      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, y);
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
        -100}, {100, 100}}), graphics = {
        Polygon(
        points = {{-40, 40}, {-40, -60}, {40, -10}, {-40, 40}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Line(
        points = {{-80, 70}, {0, 70}, {0, 14}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-80, -10}, {-40, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{40, -10}, {82, -10}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Ellipse(
        extent = {{40, -3}, {54, -17}}, 
        lineColor = {127, 0, 127}, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-54, -62}, {20, -84}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}), 
        Documentation(revisions = "<html>
<ul>
<li><em>2010年1月22日</em> 由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      , info = "<html>
<p>在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p>关于三态表格，请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</a></p>
<p><strong>真值表</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>DataIn</strong></td>
<td><strong>Enable</strong></td>
<td><strong>DataOut*</strong></td>
</tr>

<tr><td>*</td> <td>U</td> <td>U</td></tr>
<tr><td>*</td> <td>X</td> <td>UX</td></tr>
<tr><td>*</td> <td>0</td> <td>非 DataIn</td></tr>
<tr><td>*</td> <td>1</td> <td>Z</td></tr>
<tr><td>*</td> <td>Z</td> <td>UX</td></tr>
<tr><td>*</td> <td>W</td> <td>UX</td></tr>
<tr><td>*</td> <td>L</td> <td>非 DataIn</td></tr>
<tr><td>*</td> <td>H</td> <td>Z</td></tr>
<tr><td>*</td> <td>-</td> <td>UX</td></tr>
</table>

<blockquote><pre>
UX: 如果 dataIn == U 则返回 U，否则返回 X
DataOut*: 根据三态表格 Buf3slTable 映射的 DataOut 强度
</pre></blockquote>
</html>"      ));
    end INV3SL;

    model WiredX "多输入单输出的有线节点"
      extends D.Interfaces.MISO;
    protected
      D.Interfaces.Logic auxiliary[n](each start = L.'Z', each fixed = true);
    equation
      auxiliary[1] = x[1];
      for i in 1:n - 1 loop
        auxiliary[i + 1] = D.Tables.ResolutionTable[auxiliary[i],x[i + 1]];
      end for;
      y = pre(auxiliary[n]);
      annotation(
        Documentation(info = "<html>
<p>
将n个输入信号连接成一个输出信号，无延迟。
</p>
<p>分辨率表格请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</a></p>
</html>"      , revisions = "<html>
<ul>
<li><em>2010年1月22日</em> 由Ulrich Donath创建<br>
 </li>
</ul>
</html>"      ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
        100, 100}}), graphics = {Text(
        extent = {{-50, 40}, {50, 80}}, 
        textString = "Wire"), Text(
        extent = {{152, -160}, {-148, -100}}, 
        textColor = {0, 0, 255}, 
        textString = "%name")}));
    end WiredX;
    annotation();
  end Tristates;

  package Memories
    extends Modelica.Icons.Package;

    model DLATRAM "电平敏感的随机存取存储器"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import T = Modelica.Electrical.Digital.Tables;
      extends Interfaces.MemoryBase;

      Interfaces.DigitalInput WE "写使能" annotation(Placement(transformation(
        extent = {{-100, -60}, {-84, -44}}), iconTransformation(extent = {{-100, -60}, {-84, -44}})));
      Interfaces.DigitalInput dataIn[n_data] "数据输入" annotation(Placement(transformation(
        extent = {{-100, 10}, {-80, 30}}), iconTransformation(extent = {{-100, 10}, {-80, 30}})));
      L mem[integer(2 ^ n_addr),n_data](start = fill(L.'U', integer(2 ^ n_addr), n_data)) "带数据的存储器，最低位在左侧";

    algorithm
      if initial() then
        mem := getMemory(fileName, n_addr, n_data);
      end if;

      /* 写入内存 */
      if WE == L.'1' or WE == L.'H' then
        // 写入数据
        int_addr := address(n_addr, addr);
        //assert(int_addr > 0, "Attempted write to bad RAM address");
        if int_addr > 0 then
          for i in 1:n_data loop
            mem_word[i] := T.X01Table[dataIn[i]];
          end for;
          mem[int_addr,1:n_data] := mem_word;
        end if;
      elseif WE == L.'X' or WE == L.'W' or WE == L.'Z' or WE == L.'U' or WE == L.'-' then
        // 写入 X
        int_addr := address(n_addr, addr);
        //assert(int_addr > 0, "Attempted write to bad RAM address");
        if int_addr > 0 then
          mem_word := fill(L.'X', n_data);
          mem[int_addr,1:n_data] := mem_word;
        end if;
      end if;

      /* 从内存读取 */
      if RE == L.'0' or RE == L.'L' then
        nextstate := fill(L.'Z', n_data);
      elseif RE == L.'1' or RE == L.'H' then
        int_addr := address(n_addr, addr);
        // 读取数据
        if int_addr > 0 then
          mem_word := mem[int_addr,1:n_data];
          for i in 1:n_data loop
            nextstate[i] := T.StrengthMap[mem_word[i],strength];
          end for;
        else
          nextstate := fill(T.StrengthMap[L.'X',strength], n_data);
        end if;
      else
        nextstate := fill(T.StrengthMap[L.'X',strength], n_data);
      end if;
      yy := nextstate;

      annotation(Documentation(info = "<html>
<p>
在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a>
</p>
<p><strong>高电平激活的读使能 RE 的真值表：</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>RE</strong></td>
<td><strong>地址</strong></td>
<td><strong>数据输出</strong></td>
</tr>
<tr><td>0</td>  <td>*</td>              <td>全为 Z</td>  </tr>
<tr><td>1</td>  <td>  地址中没有 X</td> <td>数据输出=m(地址)</td>     </tr>
<tr><td>1</td>  <td>地址中有 X</td>      <td>全为 X</td>  </tr>
<tr><td>X</td>  <td>*</td>              <td>全为 X</td>  </tr>
</table>
<p><strong>高电平激活的写使能 WE 的真值表：</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>WE</strong></td>
<td><strong>地址</strong></td>
<td><strong>内存</strong></td>
</tr>
<tr><td>0</td>  <td>*</td>              <td>不写入</td>           </tr>
<tr><td>1</td>  <td>地址中没有 X</td>   <td>m(地址)=数据输入</td>     </tr>
<tr><td>1</td>  <td>地址中有 X</td>      <td>不写入</td>  </tr>
<tr><td>X</td>  <td>地址中没有 X</td>   <td>m(地址)=全为 X</td> </tr>
<tr><td>X</td>  <td>地址中有 X</td>      <td>不写入</td>  </tr>
</table>

<blockquote><pre>
*  = 不关心
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-' 或 L.'U'
Z  = L.'Z'
</pre></blockquote>

<p><strong>允许同时进行读/写操作。
首先进行写入，然后进行读取。</strong></p>
</html>"      , revisions = "<html>
<dl>
<dt><em>2010年11月9日</em></dt>
<dd>由Ulrich Donath创建</dd>
</dl>
</html>"      ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Text(
        extent = {{-50, 70}, {50, 30}}, 
        textColor = {127, 33, 107}, 
        textString = "DLATRAM"), 
        Line(
        points = {{-60, -40}, {-46, -50}, {-60, -60}}, 
        color = {127, 0, 127}), 
        Text(
        extent = {{-41, -35}, {-24, -62}}, 
        textColor = {127, 33, 107}, 
        textString = "WE"), 
        Line(
        points = {{-84, -50}, {-60, -50}}, 
        color = {127, 0, 127}), 
        Line(
        points = {{-80, 20}, {-60, 20}}, 
        color = {127, 0, 127}, 
        thickness = 1)}));
    end DLATRAM;

    model DLATROM "电平敏感的只读存储器"
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import T = Modelica.Electrical.Digital.Tables;
      extends Interfaces.MemoryBase;

    protected
      L m[integer(2 ^ n_addr),n_data](start = fill(L.'U', integer(2 ^ n_addr), n_data)) "带数据的存储器，最低位在左侧";

    algorithm
      if initial() then
        m := getMemory(fileName, n_addr, n_data);
      end if;

      if RE == L.'0' or RE == L.'L' then
        nextstate := fill(L.'Z', n_data);
      elseif RE == L.'1' or RE == L.'H' then
        int_addr := address(n_addr, addr);
        // 读取数据
        if int_addr > 0 then
          mem_word := m[int_addr,1:n_data];
          for i in 1:n_data loop
            nextstate[i] := T.StrengthMap[mem_word[i],strength];
          end for;
        else
          nextstate := fill(T.StrengthMap[L.'X',strength], n_data);
        end if;
      else
        nextstate := fill(T.StrengthMap[L.'X',strength], n_data);
      end if;
      yy := nextstate;

      annotation(Documentation(info = "<html>
<p>
在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a>
</p>
<p><strong>高电平激活的读使能 RE 的真值表：</strong></p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>RE</strong></td>
<td><strong>地址</strong></td>
<td><strong>数据输出</strong></td>
</tr>
<tr><td>0</td> <td>*</td> <td>全为 Z</td>  </tr>
<tr><td>1</td> <td>  地址中没有 X</td> <td>数据输出=m(地址)</td>  </tr>
<tr><td>1</td> <td>X in Addr</td> <td>X over all</td> </tr>
<tr><td>X</td> <td>*</td> <td>X over all</td> </tr>
</table>

<blockquote><pre>
*  = 不关心
0  = L.'0' 或 L.'L'
1  = L.'1' 或 L.'H'
X  = L.'X' 或 L.'W' 或 L.'Z' 或 L.'-' 或 L.'U'
Z  = L.'Z'
</pre></blockquote>

</html>"      , revisions = "<html>
<dl>
<dt><em>2010年10月19日</em></dt>
<dd>由Ulrich Donath创建</dd>
</dl>
</html>"      ), 
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
        graphics = {
        Text(
        extent = {{-50, 70}, {50, 30}}, 
        textColor = {127, 33, 107}, 
        textString = "DLATROM")}));
    end DLATROM;
    annotation();
  end Memories;

  package Multiplexers
    extends Modelica.Icons.Package;

    model MUX2x1 "一个用于多值逻辑的两输入多路选择器(2个数据输入，1个选择输入，1个输出)"
      import D = Modelica.Electrical.Digital;
      import L = Modelica.Electrical.Digital.Interfaces.Logic;
      import S = Modelica.Electrical.Digital.Interfaces.Strength;
      import T = Modelica.Electrical.Digital.Tables;
      parameter SI.Time tHL = 0 "高电平到低电平延迟";
      parameter SI.Time tLH = 0 "低电平到高电平延迟";
      parameter D.Interfaces.Strength strength = S.'S_X01' "输出强度";
      D.Interfaces.DigitalInput in1 "数据输入 1" 
        annotation(Placement(transformation(extent = {{-100, 40}, {-80, 60}}), 
        iconTransformation(extent = {{-100, 40}, {-80, 60}})));
      D.Interfaces.DigitalInput in0 "数据输入 0" 
        annotation(Placement(transformation(extent = {{-100, -60}, {-80, -40}}), 
        iconTransformation(extent = {{-100, -60}, {-80, -40}})));
      D.Interfaces.DigitalInput sel "选择输入" 
        annotation(Placement(transformation(extent = {{-10, 80}, {10, 100}}), 
        iconTransformation(extent = {{-10, 80}, {10, 100}})));
      D.Interfaces.DigitalOutput out "输出" 
        annotation(Placement(transformation(extent = {{80, -10}, {100, 10}}), 
        iconTransformation(extent = {{80, -10}, {100, 10}})));

    protected
      D.Interfaces.Logic nextstate(start = L.'U');
      D.Interfaces.DigitalOutput yy(start = L.'U');
      D.Delay.InertialDelaySensitive inertialDelaySensitive(tLH = tLH, tHL = tHL, y(start = L.'U', fixed = true));

    algorithm
      nextstate := T.MUX2x1Table[T.UX01Conv[in1],T.UX01Conv[sel],T.UX01Conv[in0]];

      nextstate := T.StrengthMap[nextstate,strength];

      yy := nextstate;
    equation
      connect(yy, inertialDelaySensitive.x);
      connect(inertialDelaySensitive.y, out);

      annotation(Icon(graphics = {
        Line(
        points = {{-80, 50}, {-40, 50}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-62, -50}, {-62, -50}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{-80, -50}, {-40, -50}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{0, 60}, {0, 80}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Line(
        points = {{40, 0}, {80, 0}}, 
        color = {127, 0, 127}, 
        thickness = 1), 
        Polygon(
        points = {{-40, 80}, {-40, -80}, {40, -40}, {40, 40}, {-40, 80}}, 
        lineColor = {213, 170, 255}, 
        lineThickness = 1, 
        fillColor = {213, 170, 255}, 
        fillPattern = FillPattern.Solid), 
        Text(
        extent = {{-36, -70}, {38, -92}}, 
        textColor = {0, 0, 255}, 
        textString = "%name"), 
        Text(
        extent = {{-38, 10}, {38, -10}}, 
        textColor = {127, 0, 127}, 
        textString = "MUX2x1")}), 
        Documentation(info = "<html>
<p>在VHDL中的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_entities.vhd</a></p>
<p>以及多路选择器表的描述请参考 <a href=\"http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd\">http://www.cs.sfu.ca/~ggbaker/reference/std_logic/src/std_logic_misc.vhd</a></p>
<h4>真值表</h4>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>DataIn</h4></td>
<td><h4>Select</h4></td>
<td><h4>DataOut</h4></td>
</tr>
<tr>
<td><p>*</p></td>
<td><p>0</p></td>
<td><p>输入 0</p></td>
</tr>
<tr>
<td><p>*</p></td>
<td><p>1</p></td>
<td><p>输入 1</p></td>
</tr>
<tr>
<td><p>输入相等</p></td>
<td><p>U</p></td>
<td><p>输入</p></td>
</tr>
<tr>
<td><p>输入不相等</p></td>
<td><p>U</p></td>
<td><p>U</p></td>
</tr>
<tr>
<td><p>输入中有 U</p></td>
<td><p>X</p></td>
<td><p>U</p></td>
</tr>
<tr>
<td><p>输入相等</p></td>
<td><p>X</p></td>
<td><p>输入</p></td>
</tr>
<tr>
<td><p>输入中没有 U 且输入不相等</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
</tr>
</table>
<blockquote><pre>
*  = 不关心
0  = L.&#39;0&#39; 或 L.&#39;L&#39;
1  = L.&#39;1&#39; 或 L.&#39;H&#39;
X  = L.&#39;X&#39; 或 L.&#39;W&#39; 或 L.&#39;Z&#39; 或 L.&#39;-&#39;
U  = L.&#39;U&#39;
</pre></blockquote>
</html>"      , revisions = "<html>
<dl>
<dt><em>2011年1月24日</em></dt>
<dd>由Christian G&uuml;nther创建</dd>
</dl>
</html>"      ));
    end MUX2x1;
    annotation();
  end Multiplexers;
  annotation(
    Documentation(info = "<html>
<p>这个库包含了数字电气元件。类型系统和模型都是基于VHDL标准(IEEE Std 1076-1987 VHDL，IEEE Std 1076-1993 VHDL，IEEE Std 1164多值逻辑系统)。
</p>
<ul>
<li>Interfaces：信号和接口的定义
</li>

<li>Tables：所有需要的真值表
</li>

<li>Delay：传输延迟和惯性延迟
</li>

<li>Basic：无延迟的基本逻辑
</li>

<li>Gates：由基本组件构成的基本门电路及其惯性延迟
</li>

<li>Tristate：(尚未可用)
</li>

<li>FlipFlops：数据锁存器
</li>

<li>Latches：D锁存器
</li>

<li>TransferGates：传输门(尚未提供)</li>
<li>Multiplexers：多路复用器(尚未提供)</li>
<li>Memory：内存，Ram、Rom(尚未提供)</li>
<li>Sources：源，时间相关信号源</li>
<li>Converters：转换器</li>
<li>Examples：示例</li>
</ul>

<p>
逻辑值由整数值编码。以下代码表对于设置输入和解释输出值都是必要的。
</p>

<p><strong>代码表：</strong></p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>逻辑值</strong></td>
      <td><strong>整数编码</strong></td>
      <td><strong>含义</strong></td>
  </tr>

  <tr><td>'U'</td> <td>1</td> <td>未初始化</td></tr>
  <tr><td>'X'</td> <td>2</td> <td>强制未知</td></tr>
  <tr><td>'0'</td> <td>3</td> <td>强制 0</td></tr>
  <tr><td>'1'</td> <td>4</td> <td>强制 1</td></tr>
  <tr><td>'Z'</td> <td>5</td> <td>高阻态</td></tr>
  <tr><td>'W'</td> <td>6</td> <td>弱未知</td></tr>
  <tr><td>'L'</td> <td>7</td> <td>弱 0</td></tr>
  <tr><td>'H'</td> <td>8</td> <td>弱 1</td></tr>
  <tr><td>'-'</td> <td>9</td> <td>不关心</td></tr>
</table>

<p>
该库将分两个主要步骤开发。第一步包括基本组件和门。在接下来的步骤中，将添加更复杂的设备。当前，该库的第一步已经实现并发布供公众使用。
</p>

<p>
版权所有 &copy; 1998-2020，Modelica Association 及贡献者
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio = false, 
    extent = {{-100, -100}, {100, 100}}), graphics = {
    Line(
    origin = {7, 47}, 
    points = {{-84, -6}, {-52, -6}}), 
    Rectangle(
    origin = {59, 53}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-104, -63}, {-64, 7}}), 
    Rectangle(
    origin = {146, 34}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    extent = {{-104, -63}, {-64, 7}}), 
    Line(
    origin = {7, 15}, 
    points = {{-84, -6}, {-52, -6}}), 
    Line(
    origin = {79, 30}, 
    points = {{-84, -6}, {-37, -6}}), 
    Line(
    points = {{42, -12}, {17, -12}, {17, -54}, {-71, -54}})}));
end Digital;