within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model HollowCylinderRadialFlux 
"具有固定形状径向通量和线性材料特性的空心圆筒"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.HollowCylinderRadialFlux;

  parameter SI.Length l=0.01 "宽度（与通量方向正交）" 
                                           annotation (Dialog(group= 
          "Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderRadialFlux_qs.png"));
  parameter SI.Radius r_i=0.01 "空心圆柱体的内半径" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Radius r_o=0.02 "空心圆柱体外半径" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Angle alpha=2*Modelica.Constants.pi 
  "中心角";
equation
  A = l*pi*(r_o + r_i);
  // 用于计算平均通量密度的算术平均半径处的面积
  G_m = 2*pi*mu_0*mu_r*l/Modelica.Math.log(r_o/r_i)*alpha/(2*Modelica.Constants.pi);

  annotation (Documentation(info="<html>
<p>径向圆柱体模型的特征是外径<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_o.png\"/>，内径<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/r_i.png\"/>，长度<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/l.png\"/>，角度<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/>。磁阻由:</p>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_radial.png\"/></div>
<p>在该模型中，磁通量和磁位差分别是径向取向的.</p>
<div><img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/HollowCylinderRadialFlux_qs.png\"/></div>
<p>左上图显示了一个径向磁通圆柱体，<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha2pi.png\"/>。右图表示在考虑圆柱体截面时的中心角<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/alpha.png\"/>.</p>
</html>"));
end HollowCylinderRadialFlux;