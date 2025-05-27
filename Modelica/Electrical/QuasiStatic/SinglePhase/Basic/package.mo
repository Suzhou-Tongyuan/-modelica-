within Modelica.Electrical.QuasiStatic.SinglePhase;
package Basic "AC单相模型的基本组件"
  extends Modelica.Icons.Package;
  annotation (Icon(graphics={
        Line(origin={10,40}, points={{-100,-40},{-80,-40}}), 
        Line(origin={10,40}, points={{60,-40},{80,-40}}), 
        Rectangle(
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{-70,-30},{70,30}})}, coordinateSystem(extent={{-100,-100}, 
            {100,100}}, preserveAspectRatio=true)), Documentation(info="<html>
<p>此包托管了准静态单相电路的基本模型。
单相电路的准静态理论可在
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">参考资料</a>
中找到。
</p>
<h4>另请参阅</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic\">Polyphase.Basic</a>

</html>"));
end Basic;