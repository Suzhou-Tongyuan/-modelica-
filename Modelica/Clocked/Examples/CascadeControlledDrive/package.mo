within Modelica.Clocked.Examples;
package CascadeControlledDrive "基于带级联控制器的简单驱动器以及定义采样和超采样的不同方法的示例"
  extends Modelica.Icons.ExamplesPackage;

  annotation(Documentation(info="<html><p>
本软件包展示了同一示例的不同变体。
</p>
<p>
模型 <a href=\"modelica://Modelica.Clocked.Examples.CascadeControlledDrive.Continuous\" target=\"\">CascadeControlledDrive.Continuous</a>&nbsp; &nbsp;是 <strong>连续时间</strong> 模型， 采样数据版本就是从该模型衍生出来的。 \"CascadeControlledDrive\" 示例在 <a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive\" target=\"\">SimpleControlledDrive</a>&nbsp; &nbsp;示例的基础上增加了另一个位置控制级联。 该模型演示了一个具有两个级联控制回路的控制系统。 目标是控制负载惯性角。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">该软件包中的其他示例模型展示了如何将上述连续时间模型转换为具有两个采样周期的周期性采样数据系统的不同变体，其中两个离散时间控制器彼此精确地时间同步。</span>
</p>
</html>"));
end CascadeControlledDrive;