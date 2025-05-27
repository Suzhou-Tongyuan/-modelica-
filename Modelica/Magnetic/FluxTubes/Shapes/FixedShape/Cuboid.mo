within Modelica.Magnetic.FluxTubes.Shapes.FixedShape;
model Cuboid 
  "通量管，矩形截面；固定形状；线性或非线性材料特性"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.FluxTubes.Icons.Cuboid;

  parameter SI.Length l=0.01 "通量方向上的长度" annotation (
      Dialog(group="Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/CuboidParallelFlux.png"));
  parameter SI.Length a=0.01 "矩形截面宽度" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Length b=0.01 "矩形截面高度" 
    annotation (Dialog(group="Fixed geometry"));

equation
  A = a*b;
  G_m = (mu_0*mu_r*A)/l;

  annotation (Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a>获取此包的所有元素的描述，并查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>
</html>"), Icon(graphics={
        Text(
          extent={{-150,50},{150,90}}, 
          textString="%name", 
          textColor={0,0,255})}));
end Cuboid;