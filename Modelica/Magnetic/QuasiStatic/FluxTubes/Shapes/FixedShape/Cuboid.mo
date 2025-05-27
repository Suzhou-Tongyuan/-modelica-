within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model Cuboid 
"具有固定形状和线性材料特性的矩形截面通量管"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Cuboid;

  parameter SI.Length l=0.01 "通量方向上的长度" annotation (
      Dialog(group="Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/CuboidParallelFlux_qs.png"));
  parameter SI.Length a=0.01 "矩形截面宽度" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Length b=0.01 "矩形截面高度" 
    annotation (Dialog(group="Fixed geometry"));

equation
  A = a*b;
  G_m = (mu_0*mu_r*A)/l;

  annotation (Documentation(info="<html>
<p>
长方体模拟磁阻，尺寸为<code>a</code>和<code>b</code>，长度为<code>l</code>
磁阻为:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/R_m_cuboid.png\">
</dd></dl>

<p>横截面的面积由:</p>
<dl><dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/A_cuboid.png\">
</dd></dl>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/CuboidParallelFlux_qs.png\">
</div></html>"));
end Cuboid;