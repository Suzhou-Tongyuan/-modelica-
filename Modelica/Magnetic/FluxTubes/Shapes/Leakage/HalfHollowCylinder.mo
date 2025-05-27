within Modelica.Magnetic.FluxTubes.Shapes.Leakage;
model HalfHollowCylinder 
  "通过半空心圆柱体的圆周方向泄漏通量"

  extends BaseClasses.Leakage;

  parameter SI.Length l=0.1 
    "轴向长度与通量正交(对于圆柱极，r>>r_i =2*pi*r)" 
    annotation (Dialog(group="Parameters", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Leakage/HalfHollowCylinder.png"));
  parameter Real ratio(start=1) "常数比t/r_i";

equation
  G_m = mu_0*l*Modelica.Math.log(1 + ratio)/pi;

  annotation (defaultComponentName="leakage", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Leakage\">Leakage</a> <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. Leakage\">Leakage</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"));
end HalfHollowCylinder;