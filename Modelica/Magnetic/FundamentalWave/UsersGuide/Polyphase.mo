within Modelica.Magnetic.FundamentalWave.UsersGuide;
class Polyphase "多相绕组"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>对称三相系统</h4>

<p>
对称的三相电流（或电压）系统由三个正弦波组成。
正弦波，其角位移为
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/2pi_3.png\"/>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/i123.png\"/>,
</div>

<p>
三相电机具有（通常）对称的三相绕组，其
激发空间磁势，空间位移为
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/2pi_3.png\"/>
- 相对于基波,
见 [<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Laughton02</a>].
这样一个对称的三相电流（或电压）系统可表示为
<a href=\"http://en.wikipedia.org/wiki/Phasor\">phasors</a>, 在 Fig. 1(a)所描述.
相关的三相绕组如图 2（a）所示。绕组轴线位移为
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/2pi_3.png\"/>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/orientationk_3.png\"/>
</div>

<p>
因此，时域和空间域的角位移之间具有很强的一致性。
这也适用于多相系统。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>对称(a)三相和(b)五相电流系统</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/phase35.png\"
           alt=\"phase35.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2: </strong>对称(a)三相和(b)五相绕组</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/winding35.png\"
           alt=\"winding35.png\">
    </td>
  </tr>
</table>

<h4>对称多相系统</h4>

<p>
在对称多相系统中，必须区分奇数相位和偶数相位.
</p>

<h5>奇数阶段</h5>

<p>
对于对称多相系统，其 <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/m.png\"/>
相位在时域和空间域的位移为
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/2pi_m.png\"/>,
如图 1 和图 2 所示.
</p>

<p>
在数学上，这种对称性用相电流表示为:
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/ik_odd.png\"/></div>

<p>
这种绕组的绕组轴线方向由以下公式给出:
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/orientationk_m.png\"/></div>

<h5>偶数阶段</h5>

<p>
在FundamentalWave库的当前实现中，相位数相等
不支持2的次方。然而，任何其他多相系统与偶
一个相位数，<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/m.png\"/>，
可以递归地分裂成各种奇数相的对称系统，如图3和图4所示。
两个对称体系之间的位移为
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/pi_m.png\"/>。
一个计算<a href=\"modelica://Modelica.Electrical.Polyphase.Functions. symmetricOrientation\">symmetricOrientation</a>是可用的.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3: </strong>Symmetrical (a) six and (b) ten phase current system</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/phase610.png\"
           alt=\"phase610.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 4: </strong>Symmetrical (a) six and (b) ten phase winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Polyphase/winding610.png\"
           alt=\"winding610.png\">
    </td>
  </tr>
</table>

<h4>请注意</h4>

<p>
在完全对称的机器中，绕组轴的方向和对称的电流(或电压)
<a href=\"http://en.wikipedia.org/wiki/Phasor\">phasors</a> 有不同的符号;奇数相数见图1和图2
偶相数见图3和图4.
</p>
</html>"));
end Polyphase;