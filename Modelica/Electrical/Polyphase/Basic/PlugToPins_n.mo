within Modelica.Electrical.Polyphase.Basic;
model PlugToPins_n "连接多个(负)引脚"
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n[m] annotation (
      Placement(transformation(extent={{10,-10},{30,10}})));
equation
  pin_n.v = plug_n.pin.v;
  plug_n.pin.i = -pin_n.i;
  annotation (defaultComponentName="plugToPins", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}), 
        Rectangle(
          extent={{-20,20},{40,-20}}, 
          pattern=LinePattern.None, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Ellipse(
          extent={{-40,20},{0,-20}}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}), 
        Text(
          extent={{-150,40},{150,80}}, 
          textString="%name", 
          textColor={0,0,255})}), 
      Documentation(info="<html>
<p>
将插头plug_n的所有引脚连接到引脚数组pin_n。
</p>
</html>"));
end PlugToPins_n;