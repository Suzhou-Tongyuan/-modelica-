within Modelica.Magnetic.FluxTubes.Utilities;
function initPreisach 
  "用于初始化普雷沙赫滞后模型的函数 GenericHystPreisachEverett"
  extends Modelica.Icons.Function;

  input SI.MagneticFieldStrength x;
  input SI.MagneticFieldStrength H;
  input FluxTubes.Material.HysteresisEverettParameter.BaseData p;
  output SI.MagneticFluxDensity B;

protected
  SI.MagneticFieldStrength hmax;
  SI.MagneticFieldStrength H_l;
  annotation();

algorithm
  H_l :=if H <= -p.Hsat then -p.Hsat elseif H >= p.Hsat then p.Hsat else H;
  hmax :=abs(H) + abs(x);
  B := if x < 0 
  then 
     -0.5*everett(hmax,-hmax,p,false) 
     + everett(H_l, -hmax, p, false) 
     + p.K*mu_0*H 
  else 
    0.5*everett(hmax, -hmax, p, false) 
     - everett(hmax, H_l, p, false) + p.K*mu_0*H;

end initPreisach;