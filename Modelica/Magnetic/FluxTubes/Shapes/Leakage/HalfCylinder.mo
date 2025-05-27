within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model HalfCylinder "通过半圆柱体边缘的泄漏流量"

  extends BaseClasses.Leakage;

  parameter SI.Length l=0.1 
    "与磁通量正交的轴向长度（=2*pi*r 适用于圆柱形磁极，且 r>> 边缘间距）" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfCylinder.png"));

equation
  G_m = mu_0*0.26*l;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Leakage\">Leakage</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end HalfCylinder;