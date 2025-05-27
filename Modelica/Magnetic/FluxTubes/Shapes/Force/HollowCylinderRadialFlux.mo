within Modelica.Magnetic.FluxTubes.Shapes.Force;
model HollowCylinderRadialFlux 
  "具有径向通量的空心圆柱体；恒定渗透率"

  extends BaseClasses.Force;

  SI.Length l=s "轴向长度（与通量方向正交）" 
    annotation (Dialog(group="Variable geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderRadialFlux.png"));
  parameter SI.Radius r_i=0.01 "空心圆柱体的内半径";
  parameter SI.Radius r_o=0.015 "空心圆柱体外半径";

  SI.MagneticFluxDensity B_avg 
    "平均通量密度（算术平均半径处）";

protected
  SI.Area A_avg 
    "与通量方向正交的平均截面积（算术平均半径处）";

equation
  G_m = mu_0*mu_r*2*pi*l/Modelica.Math.log(r_o/r_i);

  dGmBydx = mu_0*mu_r*2*pi/Modelica.Math.log(r_o/r_i)*dlBydx;

  A_avg = pi*(r_i + r_o)*l;
  B_avg = Phi/A_avg;

  annotation (defaultComponentName="force", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Force\">Force</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end HollowCylinderRadialFlux;