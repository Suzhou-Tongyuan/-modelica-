within Modelica.Magnetic.FluxTubes.Shapes.FixedShape;
model GenericFluxTube 
  "具有固定截面和长度的通量管；线性或非线性材料特性"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.FluxTubes.Icons.Reluctance;

  parameter SI.Length l=0.01 "通量方向上的长度" 
    annotation(Dialog(group="Fixed geometry", groupImage= 
      "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/GenericFluxTube.png"));
  parameter SI.CrossSection area=0.0001 "横截面积" 
    annotation (Dialog(group="Fixed geometry"));
equation
  A=area;
  G_m = (mu_0*mu_r*A)/l;

  annotation (defaultComponentName="generic", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. FixedShape\">FixedShape</a> 获取此包的所有元素的描述，并查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a> 为渗透率G_m方程的导数和/或系数.
</p>
</html>", 
    revisions="<html>
<h5>Version 3.2.2, 2014-01-15 (Christian&nbsp;Kral)</h5>
<ul>
<li>已添加 GenericFluxTube</li>
</ul>

</html>"));
end GenericFluxTube;