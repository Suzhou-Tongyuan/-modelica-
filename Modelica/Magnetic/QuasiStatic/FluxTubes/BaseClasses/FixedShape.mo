within Modelica.Magnetic.QuasiStatic.FluxTubes.BaseClasses;
partial model FixedShape "模拟过程中具有固定形状的磁通管的基类"

  extends Interfaces.TwoPort;

  parameter SI.RelativePermeability mu_rConst = 1 "恒定相对渗透率";

  SI.Reluctance R_m "磁阻";
  SI.Permeance G_m "磁导";
  SI.ComplexMagneticFluxDensity B 
  "磁通密度(法向分量)";
  SI.MagneticFluxDensity abs_B = Modelica.ComplexMath.abs(B) 
  "复磁通密度的大小";
  SI.Angle arg_B = Modelica.ComplexMath.arg(B) 
  "复磁通密度的参数";
  SI.CrossSection A "磁通穿透的横截面面积";
  SI.ComplexMagneticFieldStrength H 
  "磁场强度(正分量)";
  SI.MagneticFieldStrength abs_H = Modelica.ComplexMath.abs(H) 
  "复磁场强度的大小";
  SI.Angle arg_H = Modelica.ComplexMath.arg(H) 
  "复磁场强度的参数";

  SI.RelativePermeability mu_r "相对磁导率";

equation
  mu_r = mu_rConst;
  R_m = 1/G_m;
  V_m = Phi*R_m;
  B = Phi/A;
  H = B/(mu_0*mu_r);

  annotation (Documentation(info="<html>
<p>
请参考子包的描述
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a>
为了利用这个局部模型.
</p>
</html>"));
end FixedShape;