within Modelica.Clocked.Examples;
package SimpleControlledDrive "基于简单受控驱动器的示例，以不同方式定义采样"
extends Modelica.Icons.ExamplesPackage;

annotation (Documentation(info="<html><p>
本软件包展示了同一示例的不同变体。
</p>
<p>
<a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive.Continuous\" target=\"\">SimpleControlledDrive.Continuous</a>&nbsp; &nbsp;模型是一个 <strong>连续时间</strong> 模型， 采样数据模型就是从这个模型衍生出来的。 该模型由一个参考控制器（“斜坡”）、一个反馈控制器（“反馈 ”和 “PI”）和 一个被控对象（“扭矩”、“负载 ”和 “速度”）组成。 控制器的任务是使用简单的 PI 控制器控制负载惯性的速度。
</p>
<p>
本软件包中的其他示例模型展示了如何将上述连续时间模型转换为一个采样周期的周期性采样数据系统的不同变体。
</p>
</html>"));
end SimpleControlledDrive;