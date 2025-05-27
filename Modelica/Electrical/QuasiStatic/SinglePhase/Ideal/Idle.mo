within Modelica.Electrical.QuasiStatic.SinglePhase.Ideal;
model Idle "开路分支"
  extends Interfaces.OnePort;
equation
  i = Complex(0);
  annotation (Icon(graphics={
        Rectangle(
          extent={{-60,60},{60,-60}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-41,0}}, color={85,170,255}), 
        Line(points={{91,0},{40,0}}, color={85,170,255}), 
        Text(
          extent={{-150,110},{150,70}}, 
          textString="%name", 
          textColor={0,0,255})}), Documentation(info="<html>
<p>
这个模型是一个简单的空闲分支，考虑了复电流 <em><u>i</u></em> = 0。
</p>
<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Ideal.Short\">短接</a>
</p>
</html>"));
end Idle;