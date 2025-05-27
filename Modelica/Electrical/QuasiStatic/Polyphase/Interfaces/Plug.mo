within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
connector Plug "准静态多相接口"
  parameter Integer m=3 "相数" annotation(Evaluate=true);
  QuasiStatic.SinglePhase.Interfaces.Pin pin[m] "插头引脚";
  annotation (Documentation(info="<html>

<p>
该多相插头包含一个 <em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">单相引脚</a> 的向量。
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">正极</a> 和
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">负极</a> 是从这个基本连接器派生出来的。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
end Plug;