within Modelica.Electrical.Analog.Basic;
model Inductor "理想线性电感"
  extends Interfaces.OnePort(i(start=0));
  parameter SI.Inductance L(start=1) "电感";

equation
  L*der(i) = v;
  annotation (
    Documentation(info="<html>
<p>线性电感器将分支电压<em>v</em>与分支电流<em>i</em>联系起来，其中<em>v=L*di/dt</em>。电感<em>L</em>允许为正值或零值。</p>

</html>", 
        revisions="<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{60,0},{90,0}}, color={0,0,255}), 
        Line(points={{-90,0},{-60,0}}, color={0,0,255}), 
        Text(
          extent={{-150,-40},{150,-80}}, 
          textString="L=%L"), 
        Line(
          points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end Inductor;