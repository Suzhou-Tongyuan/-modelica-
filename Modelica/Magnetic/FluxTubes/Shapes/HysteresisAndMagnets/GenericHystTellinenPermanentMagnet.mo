within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenPermanentMagnet 
  "基于特利南磁滞模型的永磁体用于初始化普雷萨赫模型的变量"

  extends BaseClasses.GenericHysteresisTellinen(                mu0=K* 
        Modelica.Constants.mu_0, MagRel(start=-1, fixed=true));

  parameter SI.MagneticFluxDensity Br=1.2 "余热" annotation (Dialog(group="Hysteresis", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HysteresisAndMagnets/GenericHystTellinenHard/HardMagneticHysteresis.png"));
  parameter SI.MagneticFieldStrength Hc=5e5 "矫顽力" annotation (Dialog(group="Hysteresis"));
  parameter Real M(final unit="1") = unitH*10/Hc 
    "tanh()- 函数的斜率" annotation (Dialog(group="Hysteresis"));
  parameter Real K(final unit="1")=1 "mu_0 倍增器" annotation (Dialog(group="Hysteresis"));

protected
  constant SI.MagneticFieldStrength unitH = 1;
  parameter SI.MagneticFluxDensity eps= Br/1000;
  parameter SI.MagneticFieldStrength H0= 0.5*log((1+mu0*Hc/Br)/(1-mu0*Hc/Br)) + M*Hc;

equation
  hystR = Br*tanh((M*H - H0)/unitH) + mu0*H - eps/2;
  hystF = Br*tanh((M*H + H0)/unitH) + mu0*H + eps/2;

  annotation (defaultComponentName="pm", 
              Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100, 
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{70,0},{100,0}}, 
          color={255,128,0}), 
        Rectangle(
          extent={{34,20},{60,-20}}, 
          lineColor={0,127,0}, 
          fillColor={0,127,0}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-20,13},{20,-13}}, 
          textStyle={TextStyle.Bold}, 
          origin={47,0}, 
          rotation=90, 
          textString="S"), Line(
          points={{-38,-20},{-4,-20},{4,-16},{12,0},{20,16},{28,20},{36, 
              20}}, 
          color={255,128,0}, 
          smooth=Smooth.Bezier), Line(
          points={{-42,-20},{-14,-20},{-6,-16},{2,0},{10,16},{18,20},{28, 
              20}}, 
          color={255,128,0}, 
          smooth=Smooth.Bezier, 
          origin={-6,0}, 
          rotation=180), 
        Line(
          points={{-100,0},{-70,0}}, 
          color={255,128,0}), 
        Rectangle(
          extent={{-60,20},{-34,-20}}, 
          lineColor={255,0,0}, 
          fillColor={255,0,0}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-20,13},{20,-13}}, 
          textStyle={TextStyle.Bold}, 
          textString="N", 
          origin={-47,0}, 
          rotation=90), 
        Text(
          extent={{22,0},{22,-18}}, 
          textColor={255,128,0}, 
          textString="TH")}), Documentation(info="<html>

<p>
用于永磁体硬磁滞回建模的磁通管元件。模型类似于<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystTellinenHard\">GenericHystTellinenHard</a>，但有一个初始磁化预设为-100%和一个适应的图标，以更好的可读性的图表.
</p>

<p>
概述了所有可用的包的滞后和永磁元素<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. HysteresisAndMagnets\">HysteresisAndMagnets</a>可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>中找到.
</p>

</html>"));
end GenericHystTellinenPermanentMagnet;