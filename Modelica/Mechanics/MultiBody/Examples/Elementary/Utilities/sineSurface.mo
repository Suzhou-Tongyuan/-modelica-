within Modelica.Mechanics.MultiBody.Examples.Elementary.Utilities;
function sineSurface 
  "定义三维移动正弦特性的函数"
   extends Modelica.Mechanics.MultiBody.Interfaces.partialSurfaceCharacteristic;
   input Real x_min "x的最小值";
   input Real x_max "x的最大值";
   input Real y_min "y的最小值";
   input Real y_max "y的最大值";
   input Real z_min "z的最小值";
   input Real z_max "z的最大值";
   input Real wz "角频率因子";
protected
   Real aux_y;
   Real A=(z_max-z_min)/2;
algorithm
   for i in 1:nu loop
      aux_y := y_min + (y_max - y_min)*(i-1)/(nu-1);
      for j in 1:nv loop
         X[i,j] := x_min + (x_max - x_min)*(j - 1)/(nv - 1);
         Y[i,j] := aux_y;
         Z[i,j] := A*Modelica.Math.sin(wz + 0.1*j + 0.1*i)+A;
      end for;
   end for;

   if multiColoredSurface then
      C := {{(Z[i,j]+1)*200,255,0} for j in 1:nv, i in 1:nu};
   end if;
  annotation (Documentation(info="<html><p>
定义三维移动正弦特性的函数。此函数用于示例 
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.Surfaces\" target=\"\">Elementary.Surfaces</a>。
</p>
</html>"));
end sineSurface;