within Modelica.Electrical.Polyphase.Interfaces;
partial model FourPlug "具有两个多相电气端口的元件"
  parameter Integer m(final min=1) = 3 "相数" annotation(Evaluate=true);
  SI.Voltage v1[m] "端口1的电压降";
  SI.Voltage v2[m] "端口2的电压降";
  SI.Current i1[m] 
    "流入端口1的正多相插头的电流";
  SI.Current i2[m] 
    "流入端口2的正多相插头的电流";
  PositivePlug plug_p1(final m=m) "具有m个引脚的端口1的正电气多相插头" annotation (Placement(transformation(
          extent={{-110,90},{-90,110}})));
  PositivePlug plug_p2(final m=m) "具有m个引脚的端口2的正电气多相插头" annotation (Placement(transformation(
          extent={{90,90},{110,110}})));
  NegativePlug plug_n1(final m=m) "具有 m 个引脚的端口1的负电气多相插头" annotation (Placement(transformation(
          extent={{-110,-110},{-90,-90}})));
  NegativePlug plug_n2(final m=m) "具有m个引脚的端口2的负电气多相插头" annotation (Placement(transformation(
          extent={{90,-110},{110,-90}})));
equation
  v1 = plug_p1.pin.v - plug_n1.pin.v;
  v2 = plug_p2.pin.v - plug_n2.pin.v;
  i1 = plug_p1.pin.i;
  i2 = plug_p2.pin.i;
  annotation (Documentation(info="<html>
<p>
具有<strong>四个</strong>电气插头的元件的超类。
</p>
</html>"));
end FourPlug;