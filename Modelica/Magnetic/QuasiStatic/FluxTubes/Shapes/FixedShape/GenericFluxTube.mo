within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model GenericFluxTube 
"具有固定截面、固定长度和线性材料特性的通量管"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Reluctance;

  parameter SI.Length l=0.01 "通量方向上的长度" 
    annotation(Dialog(group="Fixed geometry", groupImage= 
      "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/GenericFluxTube_qs.png"));
  parameter SI.CrossSection area=0.0001 "横截面面积" 
    annotation (Dialog(group="Fixed geometry"));
equation
  A=area;
  G_m = (mu_0*mu_r*A)/l;

  annotation (Documentation(info="<html>
<p>
一般磁通管用常数来模拟磁阻
<code>面积</code>，长度<code>l</code>
磁阻为:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_generic.png\">,
</dd></dl>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/GenericFluxTube_qs.png\">
</div></html>", 
    revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>加入 GenericFluxTube</li>
</ul>

</html>"));
end GenericFluxTube;