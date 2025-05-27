within Modelica.Electrical.Polyphase;
package Ideal "具有理想行为的多相组件"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
该包含有理想行为的模拟电气多相组件，
如可控硅、二极管、开关、变压器。
</p>
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
</html>"), 
         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Line(
          origin={10,40}, 
          points={{-100,-40},{80,-40}}, 
          color={0,0,255}), 
        Polygon(
          origin={10,40}, 
          fillColor={255,255,255}, 
          points={{20,-40},{-40,0},{-40,-80},{20,-40}}), 
        Line(
          origin={-10,0}, 
          points={{40,40},{40,-40}}, 
          color={0,0,255})}));
end Ideal;