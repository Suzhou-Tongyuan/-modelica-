within Modelica.Electrical.QuasiStatic.UsersGuide.Overview;
class Power "有功和无功功率"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>

<p>对于周期波形，瞬时功率的平均值为<strong>有功功率</strong> <em>P</em>。
<strong>无功功率</strong> <em>Q</em> 是与电感和电容相关的术语。对于纯电感和电容，有功功率等于零。
然而，与连接网络交换瞬时功率存在。</p>

将研究
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Examples.SeriesResonance\">
          串联谐振电路</a>，该电路也在
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">
          交流电路</a>
中讨论过。

<h5>电阻的功率</h5>

<p>
瞬时电压和电流是同相的：
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/v_r.png\"
                   alt=\"v_r.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/i_r.png\"
                   alt=\"i_r.png\">
</div>

<p>
因此，瞬时功率是
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_r.png\"
                   alt=\"power_r.png\">
</div>

<p>这些方程的图形表示如图1所示</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_resistor.png\"
           alt=\"power_resistor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">图1：电阻的瞬时电压、电流和功率</caption>
</table>

<p>电阻的有功功率是瞬时功率的平均值：</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/p_r.png\"
                   alt=\"p_r.png\">
</div>

<h5>电感的功率</h5>

<p>
瞬时电压领先于电流四分之一个周期：
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/v_l.png\"
                   alt=\"v_l.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/i_l.png\"
                   alt=\"i_l.png\">
</div>

<p>
因此，瞬时功率是
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_l.png\"
                   alt=\"power_l.png\">
</div>

<p>这些方程的图形表示如图2所示</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_inductor.png\"
           alt=\"power_inductor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">图2：电感的瞬时电压、电流和功率</caption>
</table>

<p>电感的无功功率是：</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/q_l.png\"
                   alt=\"q_l.png\">
</div>

<h5>电容的功率</h5>

<p>
瞬时电压落后于电流四分之一个周期：
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/v_c.png\"
                   alt=\"v_c.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/i_c.png\"
                   alt=\"i_c.png\">
</div>

<p>
因此，瞬时功率是
</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_c.png\"
                   alt=\"power_c.png\">
</div>

<p>这些方程的图形表示如图3所示</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/power_capacitor.png\"
           alt=\"power_capacitor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">图3：电容的瞬时电压、电流和功率</caption>
</table>

<p>电容的无功功率是：</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/q_c.png\"
                   alt=\"q_c.png\">
</div>

<h5>复视在功率</h5>

<p>对于具有两个引脚的任意组件，可以通过复相量确定有功功率和无功功率：</p>
<div>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Power/s.png\"
                   alt=\"s.png\">
</div>

<p>
在这个方程中 <sup>*</sup> 表示共轭复数运算符
</p>

<h4>参见</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">
          简介</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">
          交流电路</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ReferenceSystem\">
          参考系统</a>
</html>"));
end Power;