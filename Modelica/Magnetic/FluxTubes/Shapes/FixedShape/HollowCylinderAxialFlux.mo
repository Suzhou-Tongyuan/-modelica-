within Modelica.Magnetic.FluxTubes.Shapes.FixedShape;
model HollowCylinderAxialFlux 
  "(空心)轴向磁通筒;固定的形状;线性或非线性材料特性"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.FluxTubes.Icons.HollowCylinderAxialFlux;

  parameter SI.Length l=0.01 "轴向长度(磁通方向)" 
    annotation (Dialog(group="Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderAxialFlux.png"));
  parameter SI.Radius r_i=0 
    "空心气缸内半径(气缸为零)" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Radius r_o=0.01 "(空心)圆柱体的外半径" 
    annotation (Dialog(group="Fixed geometry"));

equation
  A = pi*(r_o^2 - r_i^2);
  G_m = (mu_0*mu_r*A)/l;

  annotation (defaultComponentName="cylinder", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. FixedShape\">FixedShape</a>获取此包的所有元素的描述，并查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>

<p>
设置内半径 r_i=0 以模拟实心圆柱形通量管.
</p>
</html>"), 
    Icon(graphics={
        Text(
          extent={{-150,50},{150,90}}, 
          textString="%name", 
          textColor={0,0,255})}));
end HollowCylinderAxialFlux;