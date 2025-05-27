within Modelica.Electrical.QuasiStatic.UsersGuide.Overview;
class ACCircuit "交流电路"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
下面将解释一个简单的<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Examples.SeriesResonance\">
          串联电阻、电感和电容的示例</a>，如图1所示。对于不同的频率，应确定电阻、电感和电容的电压降。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/resonance_circuit.png\"
           alt=\"resonance_circuit.png\">
    </td>
  </tr>
  <caption align=\"bottom\">图1：可变频率下串联交流电阻和电感电路</caption>
</table>

<p>
电阻上的电压降
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img1.png\"
 alt=\"
\\underline{v}_{r}=R\\underline{i}\">
</div>

<p>
电感上的电压降
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img2.png\"
 alt=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</div>

<p>
以及电容上的电压降
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img3.png\"
 alt=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</div>

<p>
相加得到总电压
</p>

<div>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img4.png\"
 alt=\"
\\underline{v}=\\underline{v}_{r}+\\underline{v}_{l}\">
</div>

<p>
如图2中的相量图所示。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/phasor_diagram.png\"
           alt=\"phasor_diagram.png\">
    </td>
  </tr>
  <caption align=\"bottom\">图2：电阻和电感串联连接的相量图</caption>
</table>

<p>由于电阻、电感和电容的串联连接，三个电流都相等：</p>

<div>
<img border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/UsersGuide/Overview/ACCircuit/img5.png\"
 alt=\"img5.png\">
</div>

<h4>参见</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">
          简介</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Power\">
          功率</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ReferenceSystem\">
          参考系统</a>

</html>"));
end ACCircuit;