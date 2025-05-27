within Modelica.Mechanics.MultiBody.Types;
type SpecularCoefficient = Modelica.Icons.TypeReal(min=0) 
  "环境光的反射(=0：光完全被吸收)" 
     annotation (choices(
       choice=0 "0.0\"暗淡\"", 
       choice=0.7 "0.7\"中等\"", 
       choice=1 "1.0\"光亮\""), 
  Documentation(info="<html>
<p>
类型<strong>SpecularCoefficient</strong>定义了形状表面对环境光的反射。
如果值=0，则光完全被吸收。
通常情况下，0.7是一个合理的值。
如果SpecularCoefficient值过高，则从某些视角可能看不到物体。
在下面的图像中，展示了圆柱体的不同SpecularCoefficient值：</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Types/SpecularCoefficient.png\"/>
</div>
</html>"));