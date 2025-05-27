within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
function mu_rApprox 
  "软磁材料相对磁导率mu_r随磁通密度B的近似"

  extends Modelica.Icons.Function;

  input SI.MagneticFluxDensity B 
    "铁磁通管元件的磁通密度";
  //材料特定参数集:
  input SI.RelativePermeability mu_i 
    "B=0时的初始相对渗透率";
  input SI.MagneticFluxDensity B_myMax 
    "最大相对磁导率时的磁通密度";
  input Real c_a "近似函数系数";
  input Real c_b "近似函数系数";
  input Real n "近似函数的指数";

  output SI.RelativePermeability mu_r 
    "铁磁通管元件的相对磁导率";

protected
  Real B_N 
    "磁通密度B归一化为最大相对磁导率B_myMax时的磁通密度";

algorithm
  B_N := abs(B/B_myMax);
  mu_r := 1 + (mu_i - 1 + c_a*B_N)/(1 + c_b*B_N + B_N^n);

  annotation (Documentation(info="<html>
<p>
对于目前包含在这个库中的所有软磁材料，相对磁导率mu_r作为磁通密度B的函数可以用下面的函数<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro00]</a>:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/eq_mu_rApprox.png\" alt=\"Equation for approximation mu_r(B)\"/>
</div>

<p>
方程的5个参数中有2个具有物理意义，即B=0时的初始相对磁导率mu_i和最大磁导率时的磁通密度B_myMax。B_N为归一化后的通量密度。</p>
</html>"));
end mu_rApprox;