within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenSoft 
  "基于Tellinen模型和简单tanh()函数的具有软磁滞回的通用磁通管"
  // 对话组滞后
  parameter SI.MagneticFluxDensity Js = 1.8 "饱和偏振" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/SoftMagneticHysteresis2.png"));
  parameter SI.MagneticFluxDensity Br=0.9 "余热" annotation (Dialog(group="Hysteresis"));
  parameter SI.MagneticFieldStrength Hc=120 "矫顽力" annotation (Dialog(group="Hysteresis"));
  parameter Real K=1 "饱和区的滞后斜率 (K*mu_0)" annotation (Dialog(group="Hysteresis"));

  extends BaseClasses.GenericHysteresisTellinen(      mu0=K*mu_0);

protected
  parameter SI.MagneticFluxDensity eps=Js/1000;
  //参数 Real mu0（最终单位="N/A2"）=K*mu_0;
  parameter Real H0=0.5*Modelica.Math.log((1 + Br/Js)/(1 - Br/Js));
  parameter Real M=H0/Hc;
  constant SI.MagneticFieldStrength unitH = 1;

equation
  hystR = Js*tanh((M*Hstat - H0)/unitH) + mu0*Hstat - eps/2;
  hystF = Js*tanh((M*Hstat + H0)/unitH) + mu0*Hstat + eps/2;

  annotation (defaultComponentName="core", Documentation(info="<html>
<p>用于模拟具有铁磁和动态磁滞(涡流)的软磁材料的磁通管元件。铁磁滞回行为是由<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis. Tellinen\">Tellinen hysteresis model</a>。极限滞回线的形状(见图1)用带有4个参数的简单双曲正切函数来描述。因此，迟滞形状变化有限，但模型的参数化非常简单，模型具有较快的鲁棒性。极限滞回线的上升分支(hyst<sub>R</sub>)和下降分支(hyst<sub>F</sub>)由下式定义.</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/Eqn_ShapeFunctionsTellinen.png\"/></div><p><br><strong>Fig. 1:</strong> 双曲切线函数定义了铁磁（静态）磁滞的形状</p><div><img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenSoft/SoftMagneticHysteresis1.png\"/></div>
<p><br>概述了可用的滞后和永久磁铁的元素包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. HysteresisAndMagnets\">HysteresisAndMagnets</a>  <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>中找到.</p>
</td>
</tr>
</table>
</html>"), 
     Icon(graphics={Text(
          extent={{40,0},{40,-30}}, 
          textColor={255,128,0}, 
          textString="TS")}));
end GenericHystTellinenSoft;