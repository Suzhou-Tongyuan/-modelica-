within Modelica.Magnetic.FluxTubes.Material;
package HardMagnetic "常用永磁材料的特性(考虑温度依赖性)"
  extends Modelica.Icons.MaterialPropertiesPackage;

  annotation (Documentation(info="<html>
<p>
下面给出了常见永磁材料的剩磁、矫顽力和剩磁温度系数的典型值。</p>
<dl>
<dd>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Material/HardMagnetic/HardMagneticMaterials.png\" alt=\"Demagnetization characteristics of included permanent magnetic materials\">
</dd>
</dl>
<p>
建立了线性退磁曲线模型。许多永磁材料的特性，温度依赖的“膝盖”没有被考虑，因为正确的永磁路设计应该避免永磁体由于部分退磁而“低于”该点而运行。因此，没有考虑矫顽力的温度系数。只考虑了剩磁的温度系数，因为它充分描述了“膝点以上”区域的退磁曲线对温度的依赖关系。.
</p>
<p>
可以根据需要定义其他用户特定材料。
</p>
</html>"));
end HardMagnetic;