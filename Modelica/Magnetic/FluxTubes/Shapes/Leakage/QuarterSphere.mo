within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model QuarterSphere 
  "通过四分之一球体四角的漏磁通量"

  extends BaseClasses.Leakage;

  parameter SI.Radius r=0.005 "四分之一球半径" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterSphere.png"));

equation
  G_m = mu_0*0.077*2*r;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Leakage\">Leakage</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数。</p>
</html>"));
end QuarterSphere;