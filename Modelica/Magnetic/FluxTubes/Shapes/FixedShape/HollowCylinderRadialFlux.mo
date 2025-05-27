within Modelica.Magnetic.FluxTubes.Shapes.FixedShape;
model HollowCylinderRadialFlux 
  "具有径向通量的空心圆柱体；固定形状；线性或非线性材料特性"

  extends BaseClasses.FixedShape;
  extends Modelica.Magnetic.FluxTubes.Icons.HollowCylinderRadialFlux;

  parameter SI.Length l=0.01 "宽度（与通量方向正交）" 
                                           annotation (Dialog(group= 
          "Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/HollowCylinderRadialFlux.png"));
  parameter SI.Radius r_i=0.01 "空心圆柱体的内半径" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Radius r_o=0.02 "空心圆柱体外半径" 
    annotation (Dialog(group="Fixed geometry"));

equation
  A = l*pi*(r_o + r_i);
  // 用于计算平均通量密度的算术平均半径处的面积
  G_m = 2*pi*mu_0*mu_r*l/Modelica.Math.log(r_o/r_i);

  annotation (defaultComponentName="cylinder", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes. FixedShape\">FixedShape</a> 获取此包的所有元素的描述，并查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>

<p>
对于具有径向磁通的空心圆柱磁通管，磁通密度是半径的函数。因此，对磁通管平均半径处的磁通密度进行特征mu_r(B)的计算.
</p>

<p>
对于具有非线性材料特性mu_r(B)、内外半径r_o/r_i长径比较大的磁性器件磁通管截面，可将其分成若干个径向磁通的空心圆筒磁通管串联。与仅使用一个磁通管单元进行建模相比，这样可以更真实地模拟磁通密度对半径的依赖关系.
</p>
</html>"), 
    Icon(graphics={
        Text(
          extent={{-150,50},{150,90}}, 
          textString="%name", 
          textColor={0,0,255})}));
end HollowCylinderRadialFlux;