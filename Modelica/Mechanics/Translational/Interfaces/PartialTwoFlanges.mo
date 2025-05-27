within Modelica.Mechanics.Translational.Interfaces;
partial model PartialTwoFlanges 
  "具有两个一维平动接口的组件"

  Flange_a flange_a 
    "(左侧) 传动一维平动接口（一维平动接口轴向内切割平面，例如从左到右）" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b 
    "(右侧) 被动一维平动接口（一维平动接口轴向外切割平面）" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  annotation (Documentation(info="<html>
<p>
这是一个具有两个一维平动接口的一维传动组件。
例如，它用于构建由多个基础组件组成的传动系统的部件。
</p>
</html>"));
end PartialTwoFlanges;