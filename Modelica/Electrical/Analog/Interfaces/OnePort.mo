within Modelica.Electrical.Analog.Interfaces;
partial model OnePort 
  "具有两个电气引脚(p和n)的组件，该组件的电流方向为p流向n"
  extends TwoPin;
  SI.Current i "Current flowing from pin p to pin n";
equation
  0 = p.i + n.i;
  i = p.i;
  annotation (
    Documentation(info="<html>
<p>这是一个电路元件的抽象超类(例如二极管或类似的电子元件)。这类元件有<strong>两个</strong>电极，一个标记为正极(pin p)，一个标记为负极(pin n)。它们的主要特性是电流通过时具有单向性，即电流从正极流入时，等量的电流会从负极流出。
</p>

</html>", 
 revisions="<html>
<ul>
<li><em> 1998   </em>
       由Christoph Clauss<br>初版创建<br>
       </li>
</ul>
</html>"));
end OnePort;