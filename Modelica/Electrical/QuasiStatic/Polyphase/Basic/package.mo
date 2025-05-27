within Modelica.Electrical.QuasiStatic.Polyphase;
package Basic "交流多相的基本组件"
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
<p>此包托管了准静态多相电路的基本模型。
准静态理论可以在
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">参考资料</a>
中找到。
</p>
<h4>参见</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Basic\">SinglePhase.Basic</a>

</html>"));
end Basic;