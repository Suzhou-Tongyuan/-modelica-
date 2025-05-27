within Modelica.Electrical.Analog.Sources;
model SineCurrent "正弦电流源"
  parameter SI.Current I(start=1) "正弦波幅值";
  parameter SI.Angle phase=0 "正弦波相位";
  parameter SI.Frequency f(start=1) "正弦波频率";
  extends Interfaces.CurrentSource(redeclare Modelica.Blocks.Sources.Sine 
      signalSource(
      final amplitude=I, 
      final f=f, 
      final phase=phase));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={Line(points={{-70,0},{-60.2,29.9},{-53.8,46.5}, 
              {-48.2,58.1},{-43.3,65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67}, 
              {-23.6,61},{-18.6,52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{
              15.1,-44},{20.8,-56.2},{25.7,-64},{30.6,-68.6},{35.5,-70},{40.5, 
              -67.9},{45.4,-62.5},{50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}}, 
            color={192,192,192})}), 
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
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/Sources/SineCurrent.png\"
     alt=\"SineCurrent.png\">
</div>
</html>"));

end SineCurrent;