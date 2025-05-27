within Modelica.Electrical.Analog.Sources;
model RampVoltage "斜坡电压源"
  parameter SI.Voltage V(start=1) "斜坡高度";
  parameter SI.Time duration(min=Modelica.Constants.small, start=2) 
    "斜坡的持续时间";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Ramp 
      signalSource(final height=V, final duration=duration));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Line(points={{-80,-60},{-50,-60},{50,60},{80,60}}, 
            color={192,192,192})}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
        info="<html>
<p>这个电压源采用了Modelica.Blocks.Sources库中的相应信号源。请留意Blocks库中参数的意义。另外，模型引入了一个偏移参数，它会被加到由块源计算出的值上。startTime参数允许在时间轴上调整块源的行为。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/RampVoltage.png\"
     alt=\"RampVoltage.png\">
</div>
</html>"));
end RampVoltage;