within Modelica.Electrical.Analog;
package Lines "有损和无损分段传输线，以及LC分布式线模型"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>这个库包含有损和无损分段传输线，以及LC分布式线模型。这些线型模型目前还没有条件加热端口。</p>
</html>", revisions="<html>
<dl>
<dt>
<strong>主要作者：</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Joachim Haase;
    &lt;<a href=\"mailto:haase@eas.iis.fhg.de\">haase@eas.iis.fhg.de</a>&gt;<br>
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
        Line(points={{-60,50},{-90,50}}), 
        Rectangle(
          extent={{-60,60},{60,-60}}), 
        Line(points={{-60,-50},{-90,-50}}), 
        Line(points={{36,20},{-36,20}}), 
        Line(points={{-36,40},{-36,0}}), 
        Line(points={{36,40},{36,0}}), 
        Line(points={{60,50},{90,50}}), 
        Line(points={{60,-50},{90,-50}})}));
end Lines;