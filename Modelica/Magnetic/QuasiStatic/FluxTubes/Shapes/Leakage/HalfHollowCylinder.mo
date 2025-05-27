within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage;
model HalfHollowCylinder 
"通过半空心圆柱体的周向泄漏通量"

  extends BaseClasses.Leakage;

  parameter SI.Length l=0.1 
  "轴向长度与通量正交(对于圆柱极，r>>r_i =2*pi*r)" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfHollowCylinder.png"));
  parameter Real ratio(start=1) "常数比t/r_i";

equation
  G_m = mu_0*l*Modelica.Math.log(1 + ratio)/pi;

  annotation (Documentation(info="<html>
<p>
在
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
确定磁阻的方程
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
进行了总结。作为基于几何的数据a的替代方案
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic. LeakageWithCoefficient\">generic leakage</a> 模型在这个库中提供.
</p></html>"));
end HalfHollowCylinder;