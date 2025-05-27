within Modelica.Electrical.Analog.Sources;
model ExpSineVoltage "指数衰减的正弦电压源"
  parameter SI.Voltage V(start=1) "正弦波幅值";
  parameter SI.Frequency f(start=2) "正弦波频率";
  parameter SI.Angle phase=0 "正弦波相位";
  parameter SI.Damping damping(start=1) "阻尼系数";
  extends Interfaces.VoltageSource(redeclare Modelica.Blocks.Sources.ExpSine 
      signalSource(
      final amplitude=V, 
      final f=f, 
      final phase=phase, 
      final damping=damping));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Line(points={{-64,-14},{-59.2,18.3},{-56,36.3}, 
              {-52.7,50.5},{-49.5,60.2},{-46.3,65.3},{-43.1,65.6},{-39.9,61.3}, 
              {-36.7,53.1},{-32.6,38.2},{-27,11.8},{-19,-27.9},{-14.2,-47.7}, 
              {-10.1,-59.9},{-6.1,-67.2},{-2.1,-69.3},{1.9,-66.5},{5.9,-59.3}, 
              {10.77,-46.1},{24.44,-0.3},{29.3,12.4},{34.1,20.8},{38.1,24},{
              42.9,23.2},{47.8,17.8},{54.2,5.4},{67.1,-24.5},{73.5,-35.2},{
              79.1,-39.9},{84.7,-39.9},{91.2,-34.5},{96,-27.8}}, color={192, 
              192,192})}), 
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExpSineVoltage.png\"
     alt=\"ExpSineVoltage.png\">
</div>
</html>"));
end ExpSineVoltage;