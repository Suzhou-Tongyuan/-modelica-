within Modelica.Electrical.Polyphase;
package Sources "多相电压和电流源"
  extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html>
<p>
该库含有时间相关和可控多相电压和电流源：
</p>
<ul>
<li>SignalVoltage：由Modelica.Blocks.Sources提供，可以使用任意波形的电压</li>
<li>ConstantVoltage：恒定的多相电压</li>
<li>SineVoltage：连续电压之间的默认相移由
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>给出</li>
<li>CosineVoltage：连续电压之间的默认相移由
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>给出</li>
<li>SignalCurrent：由Modelica.Blocks.Sources提供，可以使用任意波形的电流</li>
<li>ConstantCurrent：恒定的多相电流</li>
<li>SineCurrent：连续电流之间的默认相移由
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>给出</li>
<li>CosineCurrent：连续电流之间的默认相移由
<a href=\"modelica://Modelica.Electrical.Polyphase.Functions.symmetricOrientation\">symmetricOrientation</a>给出</li>
</ul>
</html>", 
        revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical Engineering<br>
  D-93049 RegensburgGermany<br>
  电子邮件：<a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>发布说明：</strong></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
</dl>
</html>"));
end Sources;