within Modelica.Electrical.Machines.SpacePhasors.Functions;
function Rotator "旋转空间相量"
  extends Modelica.Icons.Function;
  input Real x[2] "输入空间相量";
  input SI.Angle angle "旋转角度";
  output Real y[2] "输出空间相量";
protected
  Real RotationMatrix[2, 2]={{+cos(-angle),-sin(-angle)},{+sin(-angle),+
      cos(-angle)}};
algorithm
  y := RotationMatrix*x;
  annotation (Inline=true, Documentation(info="<html>
通过负数的数学方向旋转空间相量(电压或电流)输入<code>u</code>，角度为<code>angle</code>。此模块代表了将一个空间相量<code>u</code>从一个旋转参考(坐标)系转换为另一个系，其中空间相量为<code>y</code>。输出参考系的角度超前于输入参考系的角度<code>angle</code>。

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/Rotator.png\">
    </td>
  </tr>
  <caption align=\"bottom\"><strong>图. 1:</strong> 空间相量的原始和旋转后的参考系 </caption>
</table>
</html>"));
end Rotator;