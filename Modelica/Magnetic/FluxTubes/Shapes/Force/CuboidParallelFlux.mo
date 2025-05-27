within Modelica.Magnetic.FluxTubes.Shapes.Force;
model CuboidParallelFlux 
  "运动方向有通量的立方体，如矩形截面的气隙；恒定渗透率"

  extends BaseClasses.Force;

  SI.Length l=s "轴向长度（通量方向）" annotation (Dialog(
        group="Variable geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidParallelFlux.png"));
  parameter SI.Length a=0.01 "矩形截面宽度";
  parameter SI.Length b=0.01 "矩形截面高度";

  SI.MagneticFluxDensity B "均匀磁通密度";

protected
  parameter SI.Area A=a*b 
    "与通量方向正交的横截面积";

equation
  G_m = mu_0*mu_r*A/l;

  dGmBydx = -1*mu_0*mu_r*A/l^2*dlBydx;

  B = Phi/A;

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Force\">Force</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end CuboidParallelFlux;