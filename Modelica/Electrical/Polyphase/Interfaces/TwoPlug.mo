within Modelica.Electrical.Polyphase.Interfaces;
partial model TwoPlug "具有一个多相电气端口的组件"
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  SI.Voltage v[m] "两个多相插头的电压降";
  SI.Current i[m] "流入正多相插头的电流";
  PositivePlug plug_p(final m=m) "具有m个引脚的正多相电气插头" annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}})));
  NegativePlug plug_n(final m=m) "具有m个引脚的负多相电气插头" annotation (Placement(transformation(
          extent={{90,-10},{110,10}})));
equation
  v = plug_p.pin.v - plug_n.pin.v;
  i = plug_p.pin.i;
  annotation (Documentation(info="<html>
<p>
具有<strong>两个</strong>电气插头的元件的超类：
正多相插头连接器<em>plug_p</em>和负多相插头连接器<em>plug_n</em>。
流入plug_p的电流作为电流i[m]明确提供。
</p>
</html>"));
end TwoPlug;