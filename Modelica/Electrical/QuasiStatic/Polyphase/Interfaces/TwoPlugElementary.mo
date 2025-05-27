within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model TwoPlugElementary "两个带有引脚适配器和参考连接的接口，不声明电压和电流"
  parameter Integer m(min=1) = 3 "相位数" annotation(Evaluate=true);
  SI.AngularVelocity omega "参考框架的角速度";

  PositivePlug plug_p(final m=m) 
    "正准静态多相插头" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  NegativePlug plug_n(final m=m) 
    "负准静态多相插头" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Basic.PlugToPins_p plugToPins_p(final m=m) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));
  Basic.PlugToPins_n plugToPins_n(final m=m) annotation (Placement(
        transformation(
        origin={70,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=180)));
equation
  omega = der(plug_p.reference.gamma);
  connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,0},{-86,0},{-72,0}}, color={85,170,255}));
  connect(plugToPins_n.plug_n, plug_n) annotation (Line(points={{72,0},{86,0},{100,0}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
这个部分模型使用了一个<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">正</a>
和一个<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">负插头</a>，但没有复杂的电压、电流、功率等。
一个<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_p\">正</a>和
一个<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Basic.PlugToPins_n\">负适配器</a> 用于轻松访问两个插头的单个引脚。此外，准静态系统的角速度显式地定义为变量。此模型主要用于用户模型的图形表示。
</p>

<h4>另请参阅</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug\">NegativePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlug\">TwoPlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
end TwoPlugElementary;