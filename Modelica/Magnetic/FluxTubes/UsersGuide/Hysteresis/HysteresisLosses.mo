within Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis;
class HysteresisLosses "磁滞损耗"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>磁滞功率损耗</h4>
<p>磁滞磁通管元件的总功率损耗(<code>LossPower</code>)是由静态铁磁滞回引起的功率损耗(<code>LossPowerStat</code>)和涡流引起的功率损耗(<code>LossPowerEddy</code>)之和。.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower01.png\">
    </td>
  </tr>
</table>

<p>
<code>LossPowerStat</code>和<code>LossPowerEddy</code>这两个组件的计算方法如下.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower02.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/Eqn_LossPower03.png\">
    </td>
  </tr>
</table>

<p>
其中<code>&sigma;<sub>cl</sub></code>为经典涡流因子(见<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.DynamicHysteresis\">UsersGuide.Hysteresis.DynamicHysteresis</a>)， V为磁芯材料的体积。方程表明，<code>LossPowerStat</code>作为功率吸收和电源(磁能存储)，而<code>LossPowerEddy</code>总是正的(功率吸收)。通过一个简单的例子，下图显示了磁通密度、磁场强度和磁滞损耗的时间过程。功率损耗的脉动过程(见图3c)使得平均损耗难以估计。因此，迟滞磁通管元件能够直接计算功率损耗的移动平均值。因此，可以调整元素参数对话框的“LossesAndHeat”选项卡的<code>t_avg</code>以设置适当的时间间隔(见图3d)。.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Diagram of a simple transformer with ferromagnetic core (model available at <a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.Hysteresis.SinglePhaseTransformerWithHysteresis1\">Examples.Hysteresis.SinglePhaseTransformerWithHysteresis1</a>)</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis01.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2:</strong> Simulated total dynamic hysteresis loop with its static and eddy current fractions</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis02.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3:</strong> Simulated outputs of the <code>Core</code> component of Fig. 1</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/HysteresisLosses/PowerLoss_Hysteresis03.png\">
    </td>
  </tr>
</table>

</html>"));
end HysteresisLosses;