within Modelica.Electrical.Machines.BasicMachines.Components;
model PermanentMagnet "永磁体励磁"
  parameter SI.Current Ie "等效励磁电流";
  Machines.Interfaces.SpacePhasor spacePhasor_r 
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
equation
  spacePhasor_r.i_ = {-Ie,0};
  annotation (defaultComponentName="magnet", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Ellipse(
                extent={{-60,60},{60,20}}, 
                lineColor={255,0,0}, 
                fillColor={255,0,0}, 
                fillPattern=FillPattern.Solid),Ellipse(
                extent={{-60,-20},{60,-60}}, 
                lineColor={0,255,0}, 
                fillColor={0,255,0}, 
                fillPattern=FillPattern.Solid),Rectangle(
                extent={{-60,40},{60,0}}, 
                lineColor={255,0,0}, 
                fillColor={255,0,0}, 
                fillPattern=FillPattern.Solid),Polygon(
                points={{-90,100},{-70,106},{-70,94},{-90,100}}, 
                lineColor={0,0,255}, 
                fillColor={0,0,255}, 
                fillPattern=FillPattern.Solid),Rectangle(
                extent={{-60,0},{60,-40}}, 
                lineColor={0,255,0}, 
                pattern=LinePattern.None, 
                lineThickness=0.5, 
                fillColor={0,255,0}, 
                fillPattern=FillPattern.Solid),Line(points={{-60,-40},{-60, 
          0}}, color={0,255,0}),Line(points={{60,-40},{60,0}}, color={0,255,0}), 
          Line(points={{0,100},{-70,100}}, color={0,0,255}),Line(
          points={{0,100},{0,60}}, color={255,0,0}),        Text(
                extent={{-150,-160},{150,-120}}, 
                textColor={0,0,255}, 
                textString="%name")}), Documentation(info="<html>
永磁体励磁的模型，由等效励磁电流表征。
</html>"));
end PermanentMagnet;