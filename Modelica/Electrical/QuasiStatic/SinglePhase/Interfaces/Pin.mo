within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
connector Pin "准静态单相引脚"
  SI.ComplexElectricPotential v "准静态单相引脚处的复电位";
  flow SI.ComplexCurrent i "流入准静态单相引脚的复电流";
  annotation (Documentation(info="<html>
<p>
此连接器的电位是复电压，流变量是复电流。
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">正极</a> 和
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">负极</a> 
是从此基础连接器派生出来的。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>
</p>

</html>"));
end Pin;