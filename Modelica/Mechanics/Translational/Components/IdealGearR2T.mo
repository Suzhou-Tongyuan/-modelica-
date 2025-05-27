within Modelica.Mechanics.Translational.Components;
model IdealGearR2T 
  "将旋转运动转换为平移运动的变速箱"
  extends Modelica.Mechanics.Rotational.Components.IdealGearR2T;
  annotation (
    Documentation(info="<html>
<p>将旋转运动和平移运动耦合在一起，就像齿轮和齿条一样，指定了旋转/平移运动的比例。</p>
</html>"));
end IdealGearR2T;