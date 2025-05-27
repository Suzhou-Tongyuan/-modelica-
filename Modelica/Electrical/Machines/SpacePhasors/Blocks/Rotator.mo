within Modelica.Electrical.Machines.SpacePhasors.Blocks;
block Rotator "旋转空间矢量"
  extends Modelica.Blocks.Interfaces.MIMOs(final n=2);
protected
  Real RotationMatrix[2, 2]={{+cos(-angle),-sin(-angle)},{+sin(-angle),+
      cos(-angle)}};
  //Real InverseRotator[2,2] = {{+cos(+angle),-sin(+angle)},{+sin(+angle),+cos(+angle)}};
public
  Modelica.Blocks.Interfaces.RealInput angle(unit="rad") annotation (Placement(
        transformation(
        origin={0,-120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=90)));
equation
  y = RotationMatrix*u;
  //u = InverseRotator*y;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Line(points={{0,0},{0,80},{-10, 
          60},{10,60},{0,80}}, color={0,0,255}),Line(points={{0,0},{80,0}, 
          {60,10},{60,-10},{80,0}}, color={0,0,255}), 
                                     Polygon(
                points={{50,0},{42,14},{54,16},{50,0}}, 
                lineColor={0,0,255}, 
                fillColor={0,0,255}, 
                fillPattern=FillPattern.Solid),Text(
                extent={{-88,-72},{84,-92}}, 
                textString="angle"), 
        Line(
          points={{0,50},{18,48},{32,40},{42,28},{48,16},{50,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier)}),     Documentation(info="<html>
将输入空间矢量(电压或电流)<code>u</code>按负数方向的数学角度<code>angle</code>旋转。该块表示一个空间矢量<code>u</code>从一个旋转参考(坐标)系到另一个旋转参考(坐标)系的转换，其中空间矢量为<code>y</code>。输出参考(坐标)系领先于输入参考(坐标)系<code>angle</code>角度。

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/Machines/Rotator.png\">
    </td>
  </tr>
  <caption align=\"bottom\"><strong>图 1：</strong> 空间矢量的原始和旋转参考（坐标）系 </caption>
</table>

</html>"));
end Rotator;