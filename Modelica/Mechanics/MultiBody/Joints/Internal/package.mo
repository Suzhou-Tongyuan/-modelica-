within Modelica.Mechanics.MultiBody.Joints;
package Internal "用于解析运动闭环的组件(仅在知道自己在做什么时使用)"
  extends Modelica.Icons.InternalPackage;

  annotation (Documentation(info="<html>
<p>
此包中的模型不应该由用户使用。
它们被设计用于构建MultiBody库中的其他模型，其中一些模型不能以任意方式使用，并且需要特定的知识来设置参数菜单中的选项。
不要使用此包中的模型。
</p>
</html>"));
end Internal;