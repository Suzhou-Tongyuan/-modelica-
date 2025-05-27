within Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets;
model GenericLinearPermanentMagnet 
  "永磁体具有线性特性"
  extends BaseClasses.Generic;

  parameter Material.HardMagnetic.BaseData mat= 
      Material.HardMagnetic.BaseData() "材料" annotation (Dialog(group="Material"),choicesAllMatching=true);

  output SI.MagneticFieldStrength H;
  output SI.MagneticFluxDensity B;

equation
  V_m = H*l;
  Phi = B*A;
  B = -mat.B_r+mu_0*mat.mu_r*H;
  annotation (defaultComponentName="pm",Icon(graphics={
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-100,0},{-70,0}}, 
          color={255,128,0}), 
        Line(
          points={{70,0},{100,0}}, 
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
          textString="S")}), 
    Documentation(info="<html>
<p>
线性永磁体的简单模型。常见永磁材料的典型特性可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.HardMagnetic\">FluxTubes.Material.HardMagnetic</a>找到.
</p>

<p>
概述了所有可用的包的滞后和永磁元素<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets\">HysteresisAndMagnets</a>可以在<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Hysteresis\">UsersGuide.Hysteresis</a>中找到.
</p>

</html>"));
end GenericLinearPermanentMagnet;