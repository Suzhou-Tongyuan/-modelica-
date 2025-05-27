within Modelica.Thermal.HeatTransfer.Components;
model ConvectiveResistor 
  "用于热对流的集总热元件(dT = Rc*Q_flow)"
  SI.HeatFlowRate Q_flow "固体 -> 流体的热流速率";
  SI.TemperatureDifference dT "= solid.T - fluid.T";
  Modelica.Blocks.Interfaces.RealInput Rc(unit="K/W") 
    "代表对流热阻的信号（单位：[K/W］" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  Interfaces.HeatPort_a solid annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  Interfaces.HeatPort_b fluid annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
equation
  dT = solid.T - fluid.T;
  solid.Q_flow = Q_flow;
  fluid.Q_flow = -Q_flow;
  dT = Rc*Q_flow;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-62,80},{98,-80}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-90,80},{-60,-80}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Forward), 
        Text(
          extent={{-150,-90},{150,-130}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{100,0},{100,0}}, color={0,127,255}), 
        Line(points={{-60,20},{76,20}}, color={191,0,0}), 
        Line(points={{-60,-20},{76,-20}}, color={191,0,0}), 
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}), 
        Line(points={{6,80},{6,-80}}, color={0,127,255}), 
        Line(points={{40,80},{40,-80}}, color={0,127,255}), 
        Line(points={{76,80},{76,-80}}, color={0,127,255}), 
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}), 
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}), 
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}), 
        Line(points={{6,-80},{16,-60}}, color={0,127,255}), 
        Line(points={{40,-80},{30,-60}}, color={0,127,255}), 
        Line(points={{40,-80},{50,-60}}, color={0,127,255}), 
        Line(points={{76,-80},{66,-60}}, color={0,127,255}), 
        Line(points={{76,-80},{86,-60}}, color={0,127,255}), 
        Line(points={{56,-30},{76,-20}}, color={191,0,0}), 
        Line(points={{56,-10},{76,-20}}, color={191,0,0}), 
        Line(points={{56,10},{76,20}}, color={191,0,0}), 
        Line(points={{56,30},{76,20}}, color={191,0,0}), 
        Text(
          extent={{22,124},{92,98}}, 
          textString="Rc")}), 
    Documentation(info="<html><p>
这是一种线性热对流模型，例如板与周围空气之间的热传递；与 <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.Convection\" target=\"\">Convection</a>&nbsp; &nbsp;模型相同，但使用热阻而不是热导率作为输入。 这对串联热阻非常有利，尤其是在允许对流热阻定义为零（即无温差）的情况下。
</p>
</html>"), 
       Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{100,0},{100,0}}, color={0,127,255}), 
        Line(points={{100,0},{100,0}}, color={0,127,255}), 
        Line(points={{100,0},{100,0}}, color={0,127,255})}));
end ConvectiveResistor;