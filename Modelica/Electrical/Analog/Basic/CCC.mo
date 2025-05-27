within Modelica.Electrical.Analog.Basic;
model CCC "线性电流控制电流源"
  extends Interfaces.TwoPort;
  parameter Real gain(start=1) "电流增益";

equation
  i2 = i1*gain;
  v1 = 0;
  annotation (defaultComponentName="ccc", 
    Documentation(info="<html>
<p>线性电流控制电流源是一个二端口组件。右端口电流i2是通过左端口电流i1控制的</p>
<blockquote><pre>
i2 = i1 * gain.
</pre></blockquote>
<p>左端口电压为0。用户可以选择任何电流增益进行仿真。</p>
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
        Line(points={{-90,100},{-40,100},{-40,-100},{-90,-100}}, 
                                                               color={0,0,255}), 
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
          textColor={0,0,255})}));
end CCC;