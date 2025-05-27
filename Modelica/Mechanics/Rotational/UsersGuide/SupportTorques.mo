within Modelica.Mechanics.Rotational.UsersGuide;
class SupportTorques "支撑扭矩"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html><p>
下图为配备支撑组件的一维转动接口（位于下部中央的框架一维转动接口）的组件示例，它可以用于将组件固定在地面上或其他旋转元件上，或与边界元件结合使用。 开启方法是通过将布尔参数<strong>useSupport</strong>设置为ture来开启。 支撑一维转动组件的接口可以启用或禁用。如果启用则必须连接。如果禁用则无需连接。 例如在对安装在地面上的齿轮箱进行仿真的过程中，通过建立弹簧阻尼系统来对其进行仿真并用带支撑组件的一维转动接口来模拟与安装在地面的条件。 （弹簧阻尼系统参见示例<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.ElasticBearing\" target=\"\">ElasticBearing</a>）
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/bearing1.png\" alt=\"bearing1\" data-href=\"\" style=\"\"/>
</p>
<p>
根据<strong>useSupport</strong>的参数的不同，相应组件的图标会改变，以显示支撑一维转动接口或地面安装。下图分别为开启了支撑和未开启支撑的两种情形。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/bearing2.png\" alt=\"bearing2\" data-href=\"\" style=\"\"/>
</p>
</html>"));

end SupportTorques;