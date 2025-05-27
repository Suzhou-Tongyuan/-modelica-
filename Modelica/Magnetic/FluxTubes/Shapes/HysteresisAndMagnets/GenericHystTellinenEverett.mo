within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericHystTellinenEverett 
  "基于泰利宁模型和埃弗雷特函数 [Ya89] 的具有铁磁滞后的通用磁通管)"

  parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat= 
      FluxTubes.Material.HysteresisEverettParameter.BaseData() 
    "材料特性" 
    annotation (Dialog(group="Material"), choicesAllMatching=true);
  extends BaseClasses.GenericHysteresisTellinen(      mu0=mat.K*mu_0, sigma=mat.sigma);

protected
  parameter SI.MagneticFluxDensity Js = 0.5 * FluxTubes.Utilities.everett(
                                                     mat.Hsat,-mat.Hsat, mat, false) 
    "饱和偏振";
  //最终参数 Real mu0 = mat.K * mu_0;
  parameter SI.MagneticFluxDensity eps=mat.M/1000;
  parameter Real P1 = (mat.M*mat.r*(2/pi*atan(mat.q*(mat.Hsat-mat.Hc))+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*(mat.Hsat-mat.Hc))+exp(-mat.p2*(mat.Hsat-mat.Hc)))));
  parameter Real P4 = (mat.M*mat.r*(2/pi*atan(mat.q*(-mat.Hsat-mat.Hc))+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*(-mat.Hsat-mat.Hc))+exp(-mat.p2*(-mat.Hsat-mat.Hc)))));

  SI.MagneticFieldStrength H2;
  SI.MagneticFieldStrength H3;
  Real P2;
  Real P3;
  Real H_lim;
  constant SI.MagneticFluxDensity unitT = 1;

equation
  H_lim = if Hstat<-mat.Hsat then -mat.Hsat elseif Hstat>mat.Hsat then mat.Hsat else Hstat;
  H2 = H_lim-mat.Hc;
  H3 = -H_lim-mat.Hc;

  P2 = (mat.M*mat.r*(2/pi*atan(mat.q*H2)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H2)+exp(-mat.p2*H2))));
  P3 = (mat.M*mat.r*(2/pi*atan(mat.q*H3)+1)+(2*mat.M*(1-mat.r))/(1+1/2*(exp(-mat.p1*H3)+exp(-mat.p2*H3))));

  hystR = -Js + unitT*(P1*P2-P3*P4) + mu0*Hstat - eps/2;
  hystF =  Js + unitT*(P4*P2-P3*P1) + mu0*Hstat + eps/2;

  annotation (defaultComponentName="core", Icon(graphics={Text(
          extent={{40,0},{40,-30}}, 
          textColor={255,128,0}, 
          textString="TE")}), 
    Documentation(info="<html>

<p>
用于模拟具有铁磁和动态磁滞(涡流)的软磁材料的磁通管元件。铁磁滞回行为是由 <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis.StaticHysteresis. Tellinen\">Tellinen hysteresis model</a>。极限铁磁磁滞回线的形状由Everett函数的解析描述指定，
该函数也用于参数化<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystPreisachEverett\">GenericHystPreisachEverett</a>模型。预定义参数集的库可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HysteresisEverettParameter\">FluxTubes.Material.HysteresisEverettParameter</a>中找到.
</p>

<p>
概述的所有可用的滞后和永磁元素包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. HysteresisAndMagnets\">HysteresisAndMagnets</a>可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>中找到.
</p>

</html>"));
end GenericHystTellinenEverett;