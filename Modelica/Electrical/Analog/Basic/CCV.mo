within Modelica.Electrical.Analog.Basic;
model CCV "线性电流控制电压源"
  extends Interfaces.TwoPort;

  parameter SI.Resistance transResistance(start=1) "转阻值";

equation
  v2 = i1*transResistance;
  v1 = 0;
  annotation (defaultComponentName="ccv", 
    Documentation(info="<html>
<p>线性电流控制电压源是一个双端口元件。右端口的电压v2由左端口的电流i1控制。</p>
<blockquote><pre>
v2=i1*transResistance.
</pre></blockquote>
<p>左端口电压为0。用户可以选择任何转阻值进行仿真。</p>
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
        Line(points={{90,100},{40,100},{40,-100},{90,-100}}, 
                                                           color={0,0,255}), 
        Ellipse(extent={{20,20},{60,-20}}, lineColor={0,0,255}), 
        Line(points={{-20,60},{20,60}}, color={0,0,255}), 
        Polygon(
          points={{20,60},{10,63},{10,57},{20,60}}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{-90,100},{-40,100},{-40,-100},{-90,-100}}, 
                                                             color={0,0,255}), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}));
end CCV;