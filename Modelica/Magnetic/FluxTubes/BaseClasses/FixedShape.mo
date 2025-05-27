within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model FixedShape "模拟过程中形状固定的磁通管的基类;线性或非线性材料特性"

  extends Interfaces.TwoPort;

  parameter Boolean nonLinearPermeability=true 
    "= true，如果使用非线性磁导率，否则使用恒定磁导率" 
    annotation (Dialog(group="Material"), Evaluate=true);
  parameter SI.RelativePermeability mu_rConst=1 
    "恒定相对渗透率;当nonLinearPermeability = false时使用" 
    annotation (Dialog(group="Material", enable=not nonLinearPermeability));

  parameter FluxTubes.Material.SoftMagnetic.BaseData material= 
      Material.SoftMagnetic.BaseData() 
    "铁磁材料特性;当nonLinearPermeability = true时使用" 
    annotation (choicesAllMatching=true, Dialog(group="Material", enable= 
          nonLinearPermeability));

  SI.Reluctance R_m "磁阻";
  SI.Permeance G_m "磁导";
  SI.MagneticFluxDensity B "磁通密度";
  SI.CrossSection A "被磁通量穿透的横截面积";
  SI.MagneticFieldStrength H "磁场强度";

  SI.RelativePermeability mu_r "相对磁导率";

protected
  Real B_N "归一化B的绝对值";

equation
  B_N = abs(B/material.B_myMax);
  mu_r = if nonLinearPermeability then 
    1 + (material.mu_i - 1 + material.c_a*B_N)/(1 + material.c_b*B_N + B_N^material.n) else mu_rConst;

  R_m = 1/G_m;
  V_m = Phi*R_m;
  B = Phi/A;
  H = B/(mu_0*mu_r);

  annotation (Documentation(info="<html>
<p>
请参阅子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a>用于使用此局部模型.
</p>
</html>"));
end FixedShape;