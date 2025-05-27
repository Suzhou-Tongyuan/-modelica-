within Modelica.Electrical.Polyphase.Basic;
model Star "星形连接"
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));

equation
  for j in 1:m loop
    connect(plug_p.pin[j], pin_n);
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,70},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{80,0},{0,0}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(
          points={{0,0},{-39,68}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(
          points={{0,0},{-38,-69}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Text(
          extent={{-150,-110},{150,-70}}, 
          textString="m=%m"), 
        Line(points={{-90,0},{-40,0}}, color={0,0,255}), 
        Line(points={{80,0},{90,0}}, color={0,0,255})}), Documentation(info= 
         "<html>
<p>
将plug_p的所有引脚连接到pin_n，从而建立所谓的星形连接。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiDelta\">MultiDelta</a>
</p>

</html>"));
end Star;