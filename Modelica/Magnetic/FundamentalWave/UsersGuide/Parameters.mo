within Modelica.Magnetic.FundamentalWave.UsersGuide;
class Parameters "等效机器模型参数"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>

<h4>定子主电感</h4>

<p>
定子主电感
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m.png\">
的
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
与定子相位上的自感有关。,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lss.png\">,
by:</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m_Lss.png\">
</div>

<h4>等效多相感应机模型参数</h4>

<p>假设一组参数,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_3.png\">,
的三相感应器和一组参数,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m.png\">,
的
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
相感应机。还假设</p>
<ul>
<li>额定相电压</li>
<li>额定定子频率</li>
</ul>
<p>的三个和
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
相感应电动机的参数相等。在这种情况下，两个参数集的关系为:</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_3m.png\"></div>
<p>
这样产生的扭矩相同，机器电流的关系式为:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/is_3m.png\">
</div>

<p>
转子参数也是如此。
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">
slip ring induction machine</a>, 其中相位数
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
改为
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/mr.png\">
用于将等效三相变为
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/mr.png\">
相绕组参数 -- 在相同额定转子电压和频率下.
</p>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase.IMC_DOL_Polyphase\">IMC_DOL_Polyphase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase.IMS_Start_Polyphase\">IMS_Start_Polyphase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase.SMPM_Inverter_Polyphase\">SMPM_Inverter_Polyphase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase.SMEE_Generator_Polyphase\">SMEE_Generator_Polyphase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase.SMR_Inverter_Polyphase\">SMR_Inverter_Polyphase</a>
</p>

</html>"));
end Parameters;