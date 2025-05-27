within Modelica.Electrical.Polyphase.Ideal;
model Short "多相短路分支"
  extends Interfaces.TwoPlug; // 继承双插头接口
  Modelica.Electrical.Analog.Ideal.Short short[m] annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}))); // 短接模型
equation
  connect(plug_p.pin, short.p) 
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255})); // 连接插头到短接模型的正端
  connect(short.n, plug_n.pin) 
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255})); // 连接短接模型的负端到插头
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{-90,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,130},{150,90}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-90},{150,-130}}, 
          textString="m=%m")}), Documentation(
        info="<html>
<p>
包含m个短接支路(Modelica.Electrical.Analog.Ideal.Short)
</p>
</html>"));
end Short;