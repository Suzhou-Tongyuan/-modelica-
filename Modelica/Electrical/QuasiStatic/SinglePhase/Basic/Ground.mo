within Modelica.Electrical.QuasiStatic.SinglePhase.Basic;
model Ground "电气接地"

  Interfaces.PositivePin pin annotation (Placement(transformation(extent={{
            -10,90},{10,110}})));
equation
  Connections.potentialRoot(pin.reference, 256);
  if Connections.isRoot(pin.reference) then
    pin.reference.gamma = 0;
  end if;
  pin.v = Complex(0);
  annotation (Icon(graphics={
        Line(points={{-60,50},{60,50}}, color={85,170,255}), 
        Line(points={{-40,30},{40,30}}, color={85,170,255}), 
        Line(points={{-20,10},{20,10}}, color={85,170,255}), 
        Line(points={{0,90},{0,50}}, color={85,170,255}), 
        Text(
          extent={{150,-50},{-150,-10}}, 
          textString="%name", 
          textColor={0,0,255})}), Documentation(info="<html>
<p>
单相电路的接地。接地节点的电势为零。
每个电气电路，例如，一个串联谐振
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Examples.SeriesResonance\">
          示例</a>，都必须包含至少一个地对象。
</p>

</html>"));
end Ground;