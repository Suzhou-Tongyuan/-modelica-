within Modelica.Magnetic.FluxTubes.Shapes.Force;
model HollowCylinderAxialFlux 
  "(具有轴向通量的（空心）圆柱体；恒定渗透率"

  extends BaseClasses.Force;

  SI.Length l=s "轴向长度（通量方向） " annotation (Dialog(
        group="Variable geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png"));
  parameter SI.Radius r_i=0 "空心圆柱体的内半径";
  parameter SI.Radius r_o=0.01 "空心圆柱体外半径";

  SI.MagneticFluxDensity B "均匀磁通密度";

protected
  parameter SI.Area A=pi*(r_o^2 - r_i^2) 
    "与通量方向正交的横截面积";

equation
  G_m = mu_0*mu_r*A/l;

  dGmBydx = -1*mu_0*mu_r*A/l^2*dlBydx;

  B = Phi/A;

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Force\">Force</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end HollowCylinderAxialFlux;