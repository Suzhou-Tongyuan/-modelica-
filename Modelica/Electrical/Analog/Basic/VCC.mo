within Modelica.Electrical.Analog.Basic;
model VCC "线性电压控制电流源"
  extends Interfaces.TwoPort;
  parameter SI.Conductance transConductance(start=1) "跨导";
equation
  i2 = v1*transConductance;
  i1 = 0;
  annotation (defaultComponentName="vcc", 
    Documentation(info="<html>
<p>线性电压控制电流源是一个二端口元件。右端口电流i2通过左端口电压v1进行控制。</p>
<blockquote><pre>
i2=v1*transConductance.
</pre></blockquote>
<p>左端口电流为零。用户可以选择任何跨导值进行仿真。</p>
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
        Ellipse(extent={{20,20},{60,-20}}, lineColor={0,0,255}), 
        Line(points={{-20,60},{20,60}}, color={0,0,255}), 
        Polygon(
          points={{20,60},{10,63},{10,57},{20,60}}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{90,100},{40,100},{40,20}}, 
                                               color={0,0,255}), 
        Line(points={{90,-100},{40,-100},{40,-20}}, 
                                                  color={0,0,255}), 
        Line(points={{20,0},{60,0}}, color={0,0,255}), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-90,100},{-40,100},{-40,60}}, color={0,0,255}), 
        Line(
          points={{10,25},{-40,25},{-40,-15}}, 
          color={0,0,255}, 
          origin={-80,-75}, 
          rotation=180)}));
end VCC;