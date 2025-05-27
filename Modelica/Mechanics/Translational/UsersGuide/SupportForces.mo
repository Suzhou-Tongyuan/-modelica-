within Modelica.Mechanics.Translational.UsersGuide;
class SupportForces "支撑力"
  extends Modelica.Icons.Information;

  annotation (
    DocumentationClass=true, 
    Documentation(info="<html>

<p>下图表示了装备有支撑一维平动接口（下方中央的带边框的一维平动接口）的组件示例，该一维平动接口可用于固定组件在地面或其他移动元件上，或将其与力元件结合使用。
通过布尔参数<strong>useSupport</strong>，一维平动接口的支撑组件可启用或禁用。如果启用了一维平动接口的支撑功能，则必须连接。如果禁用了一维平动接口的支撑功能，则无需连接。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/bearing.png\" alt=\"bearing\">
</div>

<p>
根据<strong>useSupport</strong>的设置，相应组件的图标会改变，以显示一维平动接口支撑部分或地面安装部分。
例如，以下图中的两种模型的实现会产生相同的结果。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/bearing2.png\" alt=\"bearing2\">
</div>
</html>"));

end SupportForces;