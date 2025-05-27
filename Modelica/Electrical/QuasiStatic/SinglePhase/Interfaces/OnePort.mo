within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model OnePort "两引脚，电流通过"
  extends TwoPin;
equation
  pin_p.i + pin_n.i = Complex(0);
  annotation (Documentation(info="<html>
<p>
这个部分模型基于 <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPin\">TwoPin</a>，
并且额外考虑了<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">正极</a> 和
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">负极</a> 的复电流平衡。
这个模型意图用于用户模型的文本表示。
</p>
<h4>另请参阅</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPinElementary\">TwoPinElementary</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPin\">TwoPin</a>
</p>
</html>"));
end OnePort;