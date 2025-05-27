within Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis;
class Tellinen "Tellinen磁滞模型"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<h4>Tellinen磁滞模型</h4>

<p>
Tellinen迟滞模型在<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Te98, ZB12]</a>。这是描述铁磁材料静态磁滞特性的一个简单模型。它只需要极限迟滞回路的上B<sub>U</sub>(H)和下B<sub>L</sub>(H)分支来适应材料特定的迟滞形状。从负磁饱和出发，随着磁场强度H(t)的增大，磁通密度B(t)沿B<sub>L</sub>(H)传播。随着H(t)的减小，B(t)从正饱和开始，沿着B<下标>U</下标>(H)传播。Tellinen模型由下式定义，给出了磁通密度B(t)对B(t)、H(t)的电流值及其斜率dH(t)/dt的时间导数的计算规则.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/Eqn_Tellinen01.png\"/></div></td>
</tr>
</table>

<p>
其中S<sub>U</sub>(H)和S<sub>L</sub>(H)为磁滞回线极限支路对磁场强度H的导数，如图1所示.
</p>
<p>
<strong>Fig. 1:</strong> 滞回包络曲线的上B<sub>U</sub>(H)和下B<sub>L</sub>(H)分支，其对应的斜率函数S<sub>UH</sub>(H)和S<sub>LH</sub>(H)以及实际工作点H(t)、B(t).</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\"><tr>
<td><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/UsersGuide/Hysteresis/StaticHysteresis/Tellinen/TellinenDesc1.png\"/></div></td>
</tr>
</table>
</html>"));
end Tellinen;