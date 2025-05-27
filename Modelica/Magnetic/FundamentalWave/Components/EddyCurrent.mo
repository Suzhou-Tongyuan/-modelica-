within Modelica.Magnetic.FundamentalWave.Components;
model EddyCurrent 
  "正弦磁场条件下的恒定损耗模型"
  import Modelica.Constants.pi;
  extends Magnetic.FundamentalWave.Interfaces.TwoPort;
  parameter SI.Conductance G(min=0) 
    "等效对称损耗电导";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
      final T=273.15);
equation
  lossPower = (pi/2)*(V_m.re*der(Phi.re) + V_m.im*der(Phi.im));
  if G > 0 then
    (pi/2)*V_m.re = G*der(Phi.re);
    (pi/2)*V_m.im = G*der(Phi.im);
  else
    V_m.re = 0;
    V_m.im = 0;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Rectangle(
              extent={{-70,30},{70,-30}}, 
              lineColor={255,128,0}, 
              fillColor={255,128,0}, 
              fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}}, 
          color={255,128,0}),Line(points={{70,0},{96,0}}, color={255,128,0}), 
                                  Text(
              extent={{0,-40},{0,-80}}, 
              textString="G=%G"), 
          Text(
              extent={{-150,50},{150,90}}, 
              textColor={0,0,255}, 
              textString="%name")}),Documentation(info="<html>
<p>
与基波效应有关的涡流损耗模型是根据以下标准设计的
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a>.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent.png\"
     alt=\"eddycurrent.png\">
</blockquote>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Fig. 1: 涡流损耗等效模型</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent_electric.png\"
           alt=\"eddycurrent_electric.png\">
    </td>
  </tr>
</table>

<p>由于涡流损耗的性质，可以用对称表示
等效电路中的导体(图1)，各自的
阶段数<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\">必须考虑在内。
假设<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\">电导
等效电路<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/Gc.png\" alt=\"G_c\">，
涡流损耗模型的电导由</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/GGc.png\"
     alt=\"GGc\">
</blockquote>

<p>
其中<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/N.png\" alt=\"N\">是对称电磁耦合的匝数.
</p>

<p>对于这样一个<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\">相位系统
电压与电流的关系<a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasors</a>
磁通与磁势之差相量为
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/vPhi.png\" alt=\"vPhi\">,<br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/iV_m.png\" alt=\"iV_m\">,
</blockquote>

<p>
其中 <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k.png\" alt=\"v_k\">
and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\" alt=\"i_k\">
分别是相电压和电流.
</p>

<p>
损耗功率
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/lossPower.png\" alt=\"lossPower\">
</blockquote>
<p>
<a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasor</a>
电压和电流空间相量的关系.
</p>
<h4>另见</h4>

<p><a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a></p>

</html>"));
end EddyCurrent;