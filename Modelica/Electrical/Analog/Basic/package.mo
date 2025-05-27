within Modelica.Electrical.Analog;
package Basic "基础电气组件"

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>这个库含了很基本的模拟电气元件，例如电阻器、导电体、电容器、电感器，以及接地组件(电路描述中需要的电路的组成部分)。此外，库还包括受控源、耦合元件以及一些改进但仍然基本的元件。</p>
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
    D-01069 Dresden<br>
</dd>
</dl>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"), Icon(graphics={
        Line(points={{-12,60},{-12,-60}}), 
        Line(points={{-80,0},{-12,0}}), 
        Line(points={{12,60},{12,-60}}), 
        Line(points={{12,0},{80,0}})}));
end Basic;