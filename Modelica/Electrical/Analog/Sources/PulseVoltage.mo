within Modelica.Electrical.Analog.Sources;
model PulseVoltage "脉冲电压源"
  parameter SI.Voltage V(start=1) "脉冲幅值";
  parameter Real width(
    final min=Modelica.Constants.small, 
    final max=100, 
    start=50) "脉冲的宽度，占据整个周期的%";
  parameter SI.Time period(final min=Modelica.Constants.small, start=1) 
    "周期时间";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Pulse 
      signalSource(
      final amplitude=V, 
      final width=width, 
      final period=period));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Line(points={{-70,-70},{-40,-70},{-40,70},{0,70}, 
              {0,-70},{40,-70},{40,70},{80,70}}, color={192,192,192})}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
        info="<html>

<p>这个电压源使用了Modelica.Blocks.Sources库中相应的信号源。关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/PulseVoltage.png\"
     alt=\"PulseVoltage.png\">
</div>
</html>"));
end PulseVoltage;