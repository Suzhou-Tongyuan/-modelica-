within Modelica.Electrical.Polyphase;
package Basic "电气多相模型的基本组件"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
该库含有基本的模拟电气多相组件。
</p>
</html>", 
        revisions="<html>
<dl>
  <dt><strong>主要作者：</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting & Electrical<br>
  Engineering D-93049 RegensburgGermany<br>
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
        Rectangle(
          origin={11.626,40}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{-80,-70},{60,-10}}), 
        Line(
          origin={11.626,40}, 
          points={{60,-40},{80,-40}}, 
          color={0,0,255}), 
        Line(points={{-88.374,0},{-68.374,0}}, color={0,0,255})}));
end Basic;