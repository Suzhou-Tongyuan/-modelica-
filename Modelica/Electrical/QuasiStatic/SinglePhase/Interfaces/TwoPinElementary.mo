within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model TwoPinElementary "两引脚基本模型，带有参考连接，不声明电压和电流"
  import Modelica.Constants.eps;
  SI.AngularVelocity omega "参考框架的角速度";

  PositivePin pin_p "正向准静态单相引脚" annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  NegativePin pin_n "负向准静态单相引脚" annotation (Placement(transformation(
          extent={{90,-10},{110,10}})));
equation
  Connections.branch(pin_p.reference, pin_n.reference);
  pin_p.reference.gamma = pin_n.reference.gamma;
  omega = der(pin_p.reference.gamma);
  annotation (Documentation(info="<html>
<p>
该部分模型使用<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">正向</a>
和<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">负向引脚</a>，
但不包括复杂的电压、电流、功率等。此外，准静态系统的角速度被明确定义为变量。此模型主要用于用户模型的图形表示。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPin\">TwoPin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPinElementary;