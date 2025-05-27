within Modelica.Electrical.PowerConverters.UsersGuide;
class DCACConcept "DC/AC转换器概念"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>

<p>PowerConverters库提供了单相和多相DC/AC转换器模型。</p>

<h4>控制</h4>

<p>目前提供了<a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.SVPWM\">空间矢量PWM</a>和<a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.IntersectivePWM\">交错PWM</a>模型。
然而，对于单相逆变器的操作，可以使用PWM<a href=\"modelica://Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM\">控制器</a>。</p>

<h4>示例</h4>

<p>一些示例可在<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCAC\">Examples.DCAC</a>中找到。</p>
</html>"));
end DCACConcept;