within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model HollowCylinderCircumferentialFlux "带有圆周通量的空心圆柱体；固定形状"

  extends Modelica.Magnetic.QuasiStatic.FluxTubes.BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.HollowCylinderCircumferentialFlux;
  import Modelica.Constants.pi;
  parameter SI.Length l=0.02 "宽度（与通量方向正交）" 
    annotation (Dialog(group= 
          "Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Circumferential.png"));
  parameter SI.Radius r_i=0.01 "空心圆柱体的内半径" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Radius r_o=0.02 "空心圆柱体外半径" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Angle alpha=pi/2 "气缸截面角度" 
    annotation (Dialog(group="Fixed geometry"));
equation
  A = l*(r_o - r_i) "用于计算平均通量密度的算术平均半径处的面积";
  G_m = mu_0*mu_r*A/((r_o + r_i)/2*alpha);

  annotation (defaultComponentName="cylinder", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a>获取此包的所有元素的描述，并查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide. Literature\">[Ro41]</a>为导率<code>G_m</code>方程的导数和/或系数.
</p>

<p>
对于具有周向磁通的空心圆柱形磁通管，磁通密度是半径的函数。
因此，对磁通管平均半径处的磁通密度求特征<code>mu_r(B)</code>.
</p>

<p>
对于具有非线性材料特性<code>mu_r(B)</code>和内外半径<code>r_o/r_i</code>长径比较大的磁性器件磁通管截面，可将该截面拆分成若干个径向磁通的空心圆柱形磁通管串联连接。与仅使用一个磁通管单元进行建模相比，这样可以更真实地模拟磁通密度对半径的依赖关系.
</p>
</html>"));
end HollowCylinderCircumferentialFlux;