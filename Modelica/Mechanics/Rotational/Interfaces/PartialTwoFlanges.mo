within Modelica.Mechanics.Rotational.Interfaces;
partial model PartialTwoFlanges 
  "具有两个一维转动接口的组件的部分模型"

  Flange_a flange_a "一维转动接口a" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Flange_b flange_b "一维转动接口b" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  annotation (Documentation(info="<html>
<p>
这是一个具有两个一维转动接口的一维转动组件。
它用于构建由多个组件组成的传动系统的部件。
</p>
</html>"));
end PartialTwoFlanges;