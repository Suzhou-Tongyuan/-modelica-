within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
record BaseData 
  "软磁材料的近似系数"

  extends Modelica.Icons.Record;

  parameter SI.RelativePermeability mu_i=1 
    "B=0时的初始相对渗透率";
  parameter SI.MagneticFluxDensity B_myMax=1 
    "最大相对磁导率时的磁通密度";
  parameter Real c_a=1 "近似函数系数";
  parameter Real c_b=1 "近似函数系数";
  parameter Real n=1 "近似函数的指数";

  annotation (Documentation(info="<html>
<p>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox\">approximation of the magnetisation characteristics</a>近似值在本记录中声明.
</p>
</html>"));
end BaseData;