within Modelica.Electrical.Analog;
package Ideal "理想电气元件，如开关、电阻、电容、电抗等，在理想状态下表现出完美的特性"

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>这个库包含了表现出理想化行为的电气元件。为了在纯粹的真实行为下使能更为真实的应用，某些元件被增强了额外的特性。例如，开关在未接通和接通的情况下都有可以参数化的电阻。</p>
</html>", revisions="<html>
<dl>
<dt>
<strong>主要作者：</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
</dl>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"), Icon(graphics={
        Line(points={{-90,0},{-40,0}}), 
        Line(points={{-40,0},{32,60}}), 
        Line(points={{40,0},{90,0}})}));
end Ideal;