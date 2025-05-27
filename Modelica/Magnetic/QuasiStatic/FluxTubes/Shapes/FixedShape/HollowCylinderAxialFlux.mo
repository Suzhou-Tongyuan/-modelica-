within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model HollowCylinderAxialFlux 
"(空心)圆柱体，具有固定形状的轴向磁通和线性材料特性"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.HollowCylinderAxialFlux;

  parameter SI.Length l=0.01 "轴向长度(磁通方向)" 
    annotation (Dialog(group="Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderAxialFlux_qs.png"));
  parameter SI.Radius r_i=0 
  "空心气缸内半径(气缸为零)" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Radius r_o=0.01 "(空心)圆柱体的外半径" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Angle alpha=2*Modelica.Constants.pi 
  "中央角";
equation
  A = pi*(r_o^2 - r_i^2)*alpha/(2*Modelica.Constants.pi);
  G_m = (mu_0*mu_r*A)/l;

  annotation (Documentation(info="<html>
<p>轴向圆柱模型的特征是外径<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_o.png\"/>，内径<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>，长度<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\"/>。磁阻由:</p>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\"/></div>
<p>横截面面积为:</p>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A_axial.png\"/></div>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderAxialFlux_qs.png\"/></div>
<p>左图<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha2pi.png\"/>显示了一个空心圆柱体。可以通过设置内半径<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>等于零来考虑固体圆柱形磁通管.</p>
<p>右上图描绘了圆心角<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/>的横截面面积的圆形扇形.</p>
</html>"));
end HollowCylinderAxialFlux;