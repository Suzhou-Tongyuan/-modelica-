within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
connector PositivePin "正交流单相接线针脚"
  extends Pin; // 继承 Pin 接口
  QuasiStatic.Types.Reference reference "参考";
  annotation (
    Diagram(graphics={Text(
          extent={{-100,100},{100,60}}, 
          textColor={0,0,255}, 
          textString="%name"), Rectangle(
          extent={{-40,40},{40,-40}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid)}), // 在图示中指定图形
    Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid)}), // 在图标中指定图形
    Documentation(info="<html>

<p>
正极针脚基于<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>。
此外，在连接器中指定了参考角度。参考角度的时间导数即为准静态电压和电流的实际角速度。该符号的设计也与<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">负极针脚</a>不同。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
end PositivePin;