within Modelica.Electrical.Analog.Basic;
model VCV "线性电压控制电压源"
  extends Interfaces.TwoPort;
  parameter Real gain(start=1) "电压增益";

equation
  v2 = v1*gain;
  i1 = 0;
  annotation (defaultComponentName="vcv", 
    Documentation(info="<html>
<p>线性电压控制电压源是一个双端口器件。右端口电压v2通过以下方式由左端口电压v1控制：</p>
<blockquote><pre>
v2=v1*gain.
</pre></blockquote>
<p>左侧端口的电流为零。可以选择任何电压增益。</p>
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
        Rectangle(
          extent={{-80,80},{80,-80}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{90,100},{40,100},{40,-100},{100,-100}}, 
                                                           color={0,0,255}), 
        Ellipse(extent={{20,20},{60,-20}}, lineColor={0,0,255}), 
        Line(points={{-20,60},{20,60}}, color={0,0,255}), 
        Polygon(
          points={{20,60},{10,63},{10,57},{20,60}}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Text(
          extent={{-150,151},{150,111}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-90,100},{-40,100},{-40,62}}, color={0,0,255}), 
        Line(points={{-90,-100},{-40,-100},{-40,-60}}, color={0,0,255})}));
end VCV;