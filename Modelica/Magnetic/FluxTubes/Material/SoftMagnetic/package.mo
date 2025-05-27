within Modelica.Magnetic.FluxTubes.Material;
package SoftMagnetic "常用软磁材料的mu_r(B)特性滞后被忽视"
  extends Modelica.Icons.MaterialPropertiesPackage;

  annotation (Documentation(info="<html>
<p>
目前包含在这个库中的所有软磁材料的磁化特性mu_r(B)都是用<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.mu_rApprox\">function</a>近似的。每种材料都有这一功能的五个参数。目前所包括的大多数铁磁材料的近似特性mu_r(B)显示在下面的图中(实线)，以及从测量和文献中编译的原始数据点.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/Steel.png\" alt=\"Approximated magnetization characteristics of selected steels\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/Miscellaneous.png\" alt=\"Approximated magnetization characteristics of miscellaneous soft magnetic materials\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/SoftMagnetic/ElectricSheet.png\" alt=\"Approximated magnetization characteristics of included electric sheets\"><br>
</div>

<p>
对于非线性曲线拟合，高通量密度(约为B>1T)的数据点权重高于低通量密度的数据点。这是由于与相对磁导率mu_r>>1的非饱和部分相比，磁路中饱和铁磁部分的影响更大.
</p>

<p>
请注意，磁化特性在很大程度上取决于先前可能的加工和测量条件。未经加工的材料通常比经过加工的相同材料具有高得多的磁导率(在电子片材的情况下是封装组装)。这在上面的图中由类似材料的不同磁化曲线表示。在大多数情况下，原始数据点表示以50Hz测量获得的换相曲线.
</p>

<p>
可以根据需要定义其他用户特定材料。这需要从原始数据点确定近似参数，最好是非线性曲线拟合.
</p>
</html>"));
end SoftMagnetic;