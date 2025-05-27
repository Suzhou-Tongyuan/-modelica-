within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model QuarterHollowCylinder 
  "通过四分之一空心圆柱体的圆周方向泄漏通量"

  extends BaseClasses.Leakage;

  parameter SI.Length l=0.1 
    "与磁通量正交的轴向长度（=2*pi*r 适用于圆柱形磁极，且 r>>r_i）" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/QuarterHollowCylinder.png"));
  parameter Real ratio(start=1) "恒定比率 t/r_i";

equation
  G_m = 2*mu_0*l*Modelica.Math.log(1 + ratio)/pi;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.Leakage\">Leakage</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end QuarterHollowCylinder;