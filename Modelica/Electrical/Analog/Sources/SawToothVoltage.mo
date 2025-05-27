within Modelica.Electrical.Analog.Sources;
model SawToothVoltage "锯齿波电压源"
  parameter SI.Voltage V(start=1) "锯齿波幅值";
  parameter SI.Time period(start=1) "周期时间";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.SawTooth 
      signalSource(final amplitude=V, final period=period));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Line(points={{-85,-70},{-65,-70},{-5,71},{-5,-70}, 
              {55,71},{55,-70}}, color={192,192,192})}), 
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SawToothVoltage.png\"
     alt=\"SawToothVoltage.png\">
</div>
</html>"));
end SawToothVoltage;