within Modelica.Electrical.PowerConverters.UsersGuide;
class ACACConcept "AC/AC转换器概念"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>

<p>以下AC/AC转换器拓扑结构目前包含在PowerConverters库中。</p>

<ul>
<li>带有<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">晶闸管</a>的单相调光器</li>
<li>带有<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.PolyphaseTriac\">晶闸管</a>的多相感应电机软启动器</li>
</ul>

<h4>控制</h4>

<p>为了向晶闸管应用触发信号，提供了<a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM\">SignalPWM模型</a>。</p>
<p>
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">VoltageToAngle块</a>
从参考电压计算相角。
</p>
<p>
为了控制感应电机的软启动，
提供了<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.SoftStartControl\">SoftStartControl块</a>。
它在启动期间应用电压斜坡，当测量电流超过最大电流时，设置斜坡暂停。
此外，可以为停止驱动应用斜坡下降。
</p>

<h4>示例</h4>

<p>一些示例可在<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACAC\">Examples.ACAC</a>中找到。</p>
</html>"));
end ACACConcept;