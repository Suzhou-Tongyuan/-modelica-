within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage;
model EighthOfSphere 
"泄漏通量通过一个边缘和八分之一球面的另一个平面"

  extends BaseClasses.Leakage;

  parameter SI.Radius r=0.01 "球面半径的八分之一" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfSphere.png"));

equation
  G_m = mu_0*0.308*r;

  annotation (Documentation(info="<html>
<p>
在
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
确定磁阻的方程
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
进行了总结。作为基于几何的数据a的替代方案
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic. LeakageWithCoefficient\">generic leakage</a>模型在这个库中提供.
</p></html>"));
end EighthOfSphere;