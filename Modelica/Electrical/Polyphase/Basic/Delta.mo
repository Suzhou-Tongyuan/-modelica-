within Modelica.Electrical.Polyphase.Basic;
model Delta "三角形连接"
  parameter Integer m(final min=2) = 3 "相数" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));

equation
  for j in 1:m-1 loop
    connect(plug_n.pin[j], plug_p.pin[j + 1]);
  end for;
  connect(plug_n.pin[m], plug_p.pin[1]);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(
          points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}}, 
          thickness=0.5, 
          color={0,0,255}), 
        Line(points={{-90,0},{-40,0}}, color={0,0,255}), 
        Line(points={{80,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,-110},{150,-70}}, 
          textString="m=%m"), 
        Text(
          extent={{-150,70},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), Documentation(info= 
         "<html>
<p>
将plug_n.pin[j]与plug_p.pin[j+1]循环连接，从而在与另一个组件并联使用时建立所谓的delta(或多边形)连接。
</p>

<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.Polyphase.Basic.MultiDelta\">MultiDelta</a>
</p>
</html>"));
end Delta;