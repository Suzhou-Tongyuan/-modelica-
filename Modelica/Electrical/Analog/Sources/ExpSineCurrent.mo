within Modelica.Electrical.Analog.Sources;
model ExpSineCurrent "指数衰减的正弦电流源"
  parameter Real I(start=1) "正弦波幅值";
  parameter SI.Frequency f(start=2) "正弦波频率";
  parameter SI.Angle phase=0 "正弦波相位";
  parameter SI.Damping damping(start=1) "正弦波的阻尼系数";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.ExpSine 
      signalSource(
      final amplitude=I, 
      final f=f, 
      final phase=phase, 
      final damping=damping));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Line(points={{-80,-14},{-75.2,18.3},{-72,36.3}, 
              {-68.7,50.5},{-65.5,60.2},{-62.3,65.3},{-59.1,65.6},{-55.9,61.3}, 
              {-52.7,53.1},{-48.6,38.2},{-43,11.8},{-35,-27.9},{-30.2,-47.7}, 
              {-26.1,-59.9},{-22.1,-67.2},{-18.1,-69.3},{-14.1,-66.5},{-10.1, 
              -59.3},{-5.23,-46.1},{8.44,-0.3},{13.3,12.4},{18.1,20.8},{22.1, 
              24},{26.9,23.2},{31.8,17.8},{38.2,5.4},{51.1,-24.5},{57.5,-35.2}, 
              {63.1,-39.9},{68.7,-39.9},{75.2,-34.5},{80,-27.8}}, color={192, 
              192,192})}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
        info="<html>

<p>这个电流源使用了Modelica.Blocks.Sources库中相应的信号源。关于Blocks库中参数的意义，需要特别注意。另外，这里引入了一个offset参数，它将被添加到blocks源计算出的值中。startTime参数可用于沿时间轴平移的源模块。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/ExpSineCurrent.png\"
     alt=\"ExpSineCurrent.png\">
</div>
</html>"));
end ExpSineCurrent;