within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage;
model CoaxCylindersEndFaces 
"内实心圆柱体和同轴外空心圆柱体端面之间的泄漏通量"

  extends BaseClasses.Leakage;

  parameter SI.Radius r_0=10e-3 "内实心圆柱半径" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/CoaxCylindersEndFaces.png"));
  parameter SI.Radius r_1=17e-3 "外空心圆筒的内半径";
  parameter SI.Radius r_2=20e-3 "外空心圆柱的外半径";

  final parameter SI.Distance l_g=r_1 - r_0 
  "两气缸之间的径向间隙长度";
  final parameter SI.Length t=r_2 - r_1 
  "外空心圆筒径向厚度";

equation
  // [Ro41], p. 139, Eq. (22)
  G_m = if t <= r_0 then 2*mu_0*(r_0 + l_g/2)*Modelica.Math.log(1 + 2*t/ 
    l_g) else 2*mu_0*(r_0 + l_g/2)*Modelica.Math.log(1 + 2*r_0/l_g);

  annotation (Documentation(info="<html>
<p>
在
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>
确定磁阻的方程
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m.png\">
进行了总结。作为基于几何的数据a的替代方案
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Basic. LeakageWithCoefficient\">generic leakage</a>模型在这个库中提供.
</p></html>"));
end CoaxCylindersEndFaces;