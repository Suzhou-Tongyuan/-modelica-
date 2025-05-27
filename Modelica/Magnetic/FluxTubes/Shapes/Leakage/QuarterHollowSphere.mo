within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model QuarterHollowSphere 
  "通过四分之一空心球边缘的泄漏流量"

  extends BaseClasses.Leakage;

  parameter SI.Length t(start=0.01) "球壳厚度" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowSphere.png"));

equation
  G_m = mu_0*0.25*t;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Leakage\">Leakage</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end QuarterHollowSphere;