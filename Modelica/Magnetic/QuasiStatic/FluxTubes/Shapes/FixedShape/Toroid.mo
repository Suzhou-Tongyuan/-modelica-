within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape;
model Toroid "具有圆形截面的环面;固定的形状"

  extends Modelica.Magnetic.QuasiStatic.FluxTubes.BaseClasses.FixedShape;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Toroid;
  import Modelica.Constants.pi;
  parameter SI.Radius r=0.1 "环面半径(中)" 
    annotation (Dialog(group="Fixed geometry", groupImage= 
          "modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Shapes/Toroid.png"));
  parameter SI.Radius d=0.01 "圆柱芯直径" 
    annotation (Dialog(group="Fixed geometry"));
  parameter SI.Angle alpha=pi/2 "环面截面角" 
    annotation (Dialog(group="Fixed geometry"));
equation
  A = d^2*pi/4 "计算平均磁通密度的算术平均半径面积";
  G_m = mu_0*mu_r*A/(r*alpha);

  annotation (defaultComponentName="cylinder", Documentation(info="<html>
<p>
请参阅所附的子包<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">FixedShape</a>获取此包的所有元素的描述，并查看<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>为渗透率G_m方程的导数和/或系数.
</p>

<p>
对于具有环向磁通的环面磁通管，磁通密度是半径的函数。
因此，对磁通管平均半径处的磁通密度求特征<code>mu_r(B)</code>.
</p>

<p>
对于具有非线性材料特性<code>mu_r(B)</code>和内外半径<code>r_o/r_i</code>长径比较大的磁性器件磁通管截面，可将该截面拆分成若干个径向磁通的空心圆柱形磁通管串联连接。与仅使用一个磁通管单元进行建模相比，这样可以更真实地模拟磁通密度对半径的依赖关系.
</p>
</html>"));
end Toroid;