within Modelica.Electrical.Analog;
package Interfaces "连接器和模拟电子元件的局部模型"
  extends Modelica.Icons.InterfacesPackage;

  annotation (Documentation(info="<html>

<p>这个库包含了模拟电子元件的连接器和接口(部分模型)。部分模型通常包含了常见的引脚组合以及内部变量，这些变量在电路设计中非常常见。它们被设计用来代表实际元件的行为，比如电阻的阻值、电容的电容量等。此外，这个包还包括了热端口，这是一种用于模拟元件温度效应的接口，通过继承的方式可以将其添加到电路模型中。使用这些部分模型和连接器，工程师可以更方便地构建和分析电路的热性能和电气特性。
</p>
</html>", 
   revisions="<html>
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

<ul>
<li><em> 1998</em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"));
end Interfaces;