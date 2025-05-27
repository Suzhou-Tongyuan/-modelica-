within Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis;
class DynamicHysteresis "动态磁滞（涡流）"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>

<h4>动态磁滞（涡流）</h4>

<p>
<<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. HysteresisAndMagnets\">HysteresisAndMagnets</a> 能够模拟涡流(动态迟滞)，外加核心材料的静态迟滞行为。涡流的计算可以通过相应元素参数对话框的“LossesAndHeat”选项卡中的开关<code>includeEddyCurrents</code>激活。元件的总磁场强度<code>H</code>为铁磁部分<code>Hstat</code>与涡流部分<code>Heddy:</code>之和。
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eqn_EddyCurrent_Ht.png\">
    </td>
  </tr>
</table>

<p>
磁场强度的涡流部分是经典涡流因子(<code>&sigma;<sub>cl</sub></code>)的乘积<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[BE01,Te98]</a>和磁通密度B(t)的时间导数:
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eqn_EddyCurrent_Heddy.png\">
    </td>
  </tr>
</table>

<p>
式中<code>&sigma;</code>为电导率，<code>d</code>为所用电钢板的厚度。图1显示了示例性动态迟滞在其静态和涡流部分的分解.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 1:</strong> Static and dynamic portion of the hysteresis B(H)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/Eddy_BHBHstatBHeddy.png\">
    </td>
  </tr>
</table>

<p>
下面两幅图显示了几个频率下实测和模拟动态迟滞的比较。根据DIN EN 60404-2，使用25厘米爱泼斯坦框架进行测量。磁芯由四层M330-50A钢板组成。旧爱泼斯坦框架的主绕组有720圈。调整一次电压，使磁激励约为Hmax = 400 A/m，但最大为72 V。模拟结果(见图3)是使用<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystTellinenTable\">GenericHystTellinenTable</a> 磁滞磁通管元件，用于模拟磁芯.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 2:</strong> Dynamic hysteresis measurements with an 25 cm Epstein frame according to DIN EN 60404-2 (Material: M330-50A, 4 Sheets)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/EddyCurrent_Epstein_Meas.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<caption align=\"bottom\"><strong>Fig. 3:</strong> Simulation results of a 25 cm Epstein frame model according to the measurement setup of Fig. 1</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/DynamicHysteresis/EddyCurrent_Epstein_Sim.png\">
    </td>
  </tr>
</table>

</html>"));
end DynamicHysteresis;