within Modelica.Magnetic.QuasiStatic.FundamentalWave.Components;
model EddyCurrent 
  "正弦磁场条件下的恒定损耗模型"
  import Modelica.Constants.pi;
  constant Complex j=Complex(0, 1);
  extends Interfaces.TwoPort;
  parameter SI.Conductance G(min=0) 
    "等效对称损耗电导";
  extends 
    Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
      final T=273.15);
  SI.AngularVelocity omega=der(port_p.reference.gamma) 
    "角速度";
equation
  lossPower = (pi/2)*Modelica.ComplexMath.imag(omega*V_m* 
    Modelica.ComplexMath.conj(Phi));
  // 损耗功率的替代计算方法
  // lossPower = -(pi/2)*Modelica.ComplexMath.real(j*omega*V_m*Modelica.ComplexMath.conj(Phi));
  if G > 0 then
    (pi/2)*V_m = j*omega*G*Phi;
  else
    V_m = Complex(0, 0);
  end if;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
              extent={{-70,30},{70,-30}}, 
              lineColor={255,170,85}, 
              fillColor={255,170,85}, 
              fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}}, 
          color={255,170,85}),Line(points={{70,0},{96,0}}, color={255,170,85}), 
                                  Text(
              extent={{0,-40},{0,-80}}, 
              textString="G=%G"), 
        Text(
          extent={{150,90},{-150,50}}, 
          textColor={0,0,255}, 
          textString="%name")}), 
    Documentation(info="<html>
<p>
考虑基波效应的涡流损耗模型根据
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic. EddyCurrent</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">FundamentalWave.Components.EddyCurrent</a>.
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent.png\">.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Fig. 1: equivalent models of eddy current losses</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent_electric.png\">
    </td>
  </tr>
</table>

<p>由于涡流损耗的性质，可以用对称表示
等效电路中的导体(图1)，各自的
相位数<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\">必须考虑在内。
假设<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\">电导
等效电路<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/Gc.png\">，
涡流损耗模型的电导由</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/GGc.png\">
</p>

<p>
其中 <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/N.png\"> 是对称电磁耦合器的匝数.
</p>

<p>对于这样一个<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\">相位系统
电压与电流的关系<a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasors</a>
磁通与磁势之差相量为
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/vPhi.png\">,<br>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/iV_m.png\">,
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k.png\">
和 <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\">
相电压和电流。
</p>

<p>
耗散的损耗功率
</p>
<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/lossPower.png\">
</p>
<p>
<a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasor</a>
电压和电流空间相量的关系.
</p>
<h4>另外</h4>

<p><a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a></p>
</html>"));
end EddyCurrent;