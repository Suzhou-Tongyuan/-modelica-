within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
connector NegativePin "负准静态单相引脚"
  extends Pin;
  QuasiStatic.Types.Reference reference "参考角度";
  annotation (
    Diagram(graphics={Text(
          extent={{-100,100},{100,60}}, 
          textColor={0,0,255}, 
          textString="%name"), Rectangle(
          extent={{-40,40},{40,-40}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>

<p>
负极是基于<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>。
此外，连接器中指定了参考角度。参考角度的时间导数是准静态电压和电流的实际角速度。符号也设计成与<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">正极引脚</a>不同。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
end NegativePin;