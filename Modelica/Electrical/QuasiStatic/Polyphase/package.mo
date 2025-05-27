within Modelica.Electrical.QuasiStatic;
package Polyphase "多相交流组件"
  extends Modelica.Icons.Package;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Ellipse(
          origin={14,56}, 
          lineColor={0,0,255}, 
          extent={{-84,-126},{56,14}}), 
        Ellipse(
          origin={-0,40}, 
          lineColor={0,0,255}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{-40,-34},{-20,-14}}), 
        Ellipse(
          origin={20,40}, 
          lineColor={0,0,255}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{0,-34},{20,-14}}), 
        Ellipse(
          origin={10,34}, 
          lineColor={0,0,255}, 
          fillColor={170,213,255}, 
          fillPattern=FillPattern.Solid, 
          extent={{-20,-74},{0,-54}})}), Documentation(info="<html>
<p>该包含了准静态多相电路的模型。
关于准静态理论的信息可以在
[<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Vaske1973</a>]
以及其他
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">参考资料</a>
中找到。
</p>
<h4>参见</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase\">SinglePhase</a>

</html>"));
end Polyphase;