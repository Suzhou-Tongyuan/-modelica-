within Modelica.Electrical.QuasiStatic.SinglePhase;
package Ideal "AC单相模型的理想元件"
  extends Modelica.Icons.Package;
  annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
          preserveAspectRatio=true), graphics={
        Line(origin={10,34}, points={{-100,-60},{-54,-60}}), 
        Ellipse(origin={10,34}, extent={{-54,-64},{-46,-56}}), 
        Line(origin={10,34}, points={{-47,-58},{30,-10}}), 
        Line(origin={10,34}, points={{30,-40},{30,-60}}), 
        Line(origin={10,34}, points={{30,-60},{80,-60}})}), Documentation(
        info="<html>
<p>这个包包含准静态单相电路的理想模型。
单相电路的准静态理论可以在
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">参考资料</a>
中找到。
</p>
<h4>另请参阅</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Ideal\">Polyphase.Ideal</a>

</html>"));
end Ideal;