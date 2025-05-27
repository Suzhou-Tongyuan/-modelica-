within Modelica.Electrical.Analog.Sources;
model StepVoltage "阶跃电压源"
  parameter SI.Voltage V(start=1) "步高";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.Step 
      signalSource(final height=V));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Line(points={{-70,-70},{0,-70},{0,70},{69,70}}, 
            color={192,192,192})}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
        info="<html>
<p>这个电压源利用了Modelica.Blocks.Sources库中的信号源组件，可以在这个库中查看相关信息。此外，模型引入了一个偏置参数，它将被添加到信号源计算得出的值上。startTime参数允许沿时间轴平移信号源的行为。
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/StepVoltage.png\"
     alt=\"StepVoltage.png\">
</div>
</html>"));
end StepVoltage;