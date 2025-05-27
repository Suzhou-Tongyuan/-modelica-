within Modelica.Electrical.Analog.Interfaces;
partial model CurrentSource "电流源接口"
  extends Modelica.Electrical.Analog.Icons.CurrentSource;
  extends OnePort;
  replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
      final offset = offset, final startTime=startTime) annotation (Placement(
        transformation(extent={{70,69},{91,89}})));

  parameter SI.Current offset=0 "电流偏移";
  parameter SI.Time startTime=0 "时间偏移";
equation
  i = signalSource.y;
  annotation (
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>创建<br>
       </li>
</ul>
</html>", 
        info="<html>
<p>电流源部分模型通过提供引脚、偏移量和startTime参数来准备电流源，这些参数在所有电流源中都是相同的。源行为是从Modelica.Blocks信号源中通过继承和利用可替换模型获得的。
</p>

</html>"));
end CurrentSource;