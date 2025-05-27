within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenHard 
  "基于 Tellinen 模型和简单 tanh()函数的具有硬磁滞的通用磁通管"

  extends BaseClasses.GenericHysteresisTellinen(      mu0=K*mu_0);

  //磁滞参数
  parameter SI.MagneticFluxDensity Br=1.2 "余热" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png"));
  parameter SI.MagneticFieldStrength Hc=5e5 "矫顽力" annotation (Dialog(group="Hysteresis"));
  parameter Real M = 10/Hc "tanh()- 函数的斜率" annotation (Dialog(group="Hysteresis"));
  parameter Real K=1 "饱和区的滞后斜率 (K*mu_0)" annotation (Dialog(group="Hysteresis"));

protected
  final parameter SI.MagneticFluxDensity eps = Br/1000;
  //最终参数 Real mu0（最终单位="N/A2"）= K*mu_0;
  final parameter SI.MagneticFieldStrength H0= 0.5*log((1+mu0*Hc/Br)/(1-mu0*Hc/Br)) + M*Hc;
  constant SI.MagneticFieldStrength unitH = 1;

  Real tanhR;
  Real tanhF;

equation
  tanhR = tanh((M*H - H0)/unitH);
  tanhF = tanh((M*H + H0)/unitH);
  hystR = Br*tanhR + mu0*H - eps/2;
  hystF = Br*tanhF + mu0*H + eps/2;

 annotation (defaultComponentName="core", Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100, 
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-70,32},{70,-30}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{70,0},{100,0}}, 
          color={255,128,0}), 
        Line(
          points={{-90,0},{-70,0}}, 
          color={255,128,0}), Line(
          points={{-30,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{26,20}}, 
          color={255,128,0}, 
          smooth=Smooth.Bezier, 
          origin={-14,0}, 
          rotation=180), Line(
          points={{-18,-20},{-2,-20},{6,-16},{14,0},{22,16},{30,20},{38, 
              20}}, 
          color={255,128,0}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-18,-20},{-42,-20}}, 
          color={255,128,0}), 
        Line(
          points={{16,20},{40,20}}, 
          color={255,128,0}), 
        Text(
          extent={{40,-2},{40,-30}}, 
          textColor={255,128,0}, 
          textString="TH")}), Documentation(info="<html>
<p>
  用于模拟硬磁材料铁磁(静)滞回的磁通管元件。铁磁滞回行为是由<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis.Tellinen\">Tellinen hysteresis model</a>。极限滞回线的形状用4个参数的简单双曲正切函数描述.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> 双曲正切函数定义了铁磁（静态）磁滞的形状</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png\">
   </td>
  </tr>
</table>

<p>
概述的所有可用的滞后和永磁元素包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. HysteresisAndMagnets\">HysteresisAndMagnets</a>  <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>中找到.
</p>
</html>"));
end GenericHystTellinenHard;