within Modelica.Electrical.QuasiStatic.UsersGuide.Overview;
class Introduction "相量简介"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>

<p>
在时间域中，纯正弦电压
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Introduction/img1.png\"
 alt=\"v=\\sqrt{2}V_{\\mathrm{RMS}}\\cos(\\omega t+\\varphi_{v})\">
</div>

<p>
可以由复<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Glossar\">有效值</a>相量表示
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Introduction/img2.png\"
 alt=\"\\underline{v}=V_{\\mathrm{RMS}}e^{j\\varphi_{v}}.\">
</div>

<p>对于这些准静态相量，以下关系成立：</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Introduction/img3.png\"
 alt=\"\\begin{displaymath}
v=\\mathrm{Re}(\\sqrt{2}\\underline{v}e^{j\\omega t})\\end{displaymath}\">
</div>

<p>
这个方程也在图1中有所说明。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/Introduction/phasor_voltage.png\"
           alt=\"phasor_voltage.png\">
    </td>
  </tr>
  <caption align=\"bottom\">图1：电压相量与时间域电压之间的关系</caption>
</table>

<p>
从上述方程可以看出，在 <em>t</em> = 0 时，时间域电压为 <em>v</em> = cos(<em>&phi;<sub>v</sub></em>)。
相量的复数表示也与这个实例对应，因为相量领先于实轴 <em>&phi;<sub>v</sub></em> 角度。
</p>

<p>
对于正弦电流，给出的解释当然也适用。</p>

<h4>参见</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">
          交流电路</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Power\">
          功率</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ReferenceSystem\">
          参考系统</a>

</html>"));
end Introduction;