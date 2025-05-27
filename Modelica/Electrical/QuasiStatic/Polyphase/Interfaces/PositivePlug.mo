within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
connector PositivePlug "正准静态多相接口"
  extends Plug;
  QuasiStatic.Types.Reference reference "参考";
  annotation (
    Icon(graphics={Ellipse(
          extent={{-100,100},{100,-100}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid)}), 
    Diagram(graphics={Ellipse(
          extent={{-40,40},{40,-40}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,100},{100,60}}, 
          textColor={0,0,255}, 
          textString="%name")}), 
    Documentation(info="<html>

<p>
正极插头基于 <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>。
此外，连接器中指定了参考角度。参考角度的时间导数是每个准静态电压和电流的实际角速度。该符号的设计也是为了与 <a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">负极插头</a> 不同而设计的。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
end PositivePlug;