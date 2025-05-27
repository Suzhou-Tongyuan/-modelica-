within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model EighthOfSphere 
  "通过八分之一球体的一条边和对边平面的泄漏通量"

  extends BaseClasses.Leakage;

  parameter SI.Radius r=0.01 "球面八分之一半径" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/EighthOfSphere.png"));

equation
  G_m = mu_0*0.308*r;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Leakage\">Leakage</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end EighthOfSphere;