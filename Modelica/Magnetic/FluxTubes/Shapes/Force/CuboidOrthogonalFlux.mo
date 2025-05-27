within Modelica.Magnetic.FluxTubes.Shapes.Force;
model CuboidOrthogonalFlux 
  "磁通量与运动方向正交的立方体；恒定磁导率"

  extends BaseClasses.Force;

  SI.Length l=s "运动方向上的长度（与通量正交）" 
    annotation (Dialog(group="可变几何形状", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidOrthogonalFlux.png"));
  parameter SI.Length a=0.01 "矩形截面宽度";
  parameter SI.Length b=0.01 
    "矩形截面高度（通量方向）";

  SI.MagneticFluxDensity B "均匀磁通密度";

protected
  SI.Area A "与通量方向正交的横截面积";

equation
  A = a*l;
  G_m = mu_0*mu_r*A/b;

  dGmBydx = mu_0*mu_r*a/b*dlBydx;

  B = Phi/A;

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Force\">Force</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end CuboidOrthogonalFlux;