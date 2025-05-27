within Modelica.Electrical.Machines.Losses.InductionMachines;
model Brush "考虑碳刷电压降和损耗的模型"
  extends Modelica.Electrical.Polyphase.Interfaces.TwoPlug;
  parameter Machines.Losses.BrushParameters brushParameters 
    "碳刷损耗参数";
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(
      useHeatPort=false,final T=293.15);
  DCMachines.Brush brush[3](each final brushParameters=brushParameters, 
      each final useHeatPort=true) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p.pin, brush.p) annotation (Line(
      points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(brush.n, plug_n.pin) annotation (Line(
      points={{10,0},{100,0}}, color={0,0,255}));
  for j in 1:m loop
    connect(brush[j].heatPort, internalHeatPort) annotation (Line(
        points={{-10,-10},{-10,-60},{-100,-60},{-100,-80}}, color={191,0,0}));
  end for;
  annotation (Icon(graphics={Line(points={{-100,-100},{-92,-80},{-80,-60}, 
          {-60,-40},{-40,-28},{-20,-22},{0,-20},{20,-22},{40,-28},{60,-40}, 
          {80,-60},{92,-80},{100,-100}}, color={0,0,255}),Polygon(
                points={{-20,-22},{-40,-28},{-40,20},{40,20},{40,-28},{20, 
            -22},{0,-20},{-20,-22}}, 
                lineColor={0,0,255}, 
                fillColor={0,0,255}, 
                fillPattern=FillPattern.Solid),Line(points={{-90,0},{-40, 
          0}}, color={0,0,255}),Line(points={{40,0},{90,0}}, color={0,0,255}), 
          Text( extent={{-150,80},{150,40}}, 
                textColor={0,0,255}, 
                textString="%name")}), Documentation(info="<html>
<p>
考虑碳刷电压降和损耗的模型。此三相模型使用三个<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Brush\">直流电刷</a>损耗模型。
</p>
</html>"));
end Brush;