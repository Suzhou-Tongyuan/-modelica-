within Modelica.Electrical.QuasiStatic.Polyphase.Basic;
model MultiStarResistance "星形的电阻连接"
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  final parameter Integer mBasic= 
      Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
      m) "对称基础系统的数量";
  parameter SI.Resistance R=1e6 
    "基础系统之间的绝缘电阻";
  Interfaces.PositivePlug plug(m=m) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  MultiStar multiStar(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-50,0})));
  Resistor resistor(m=mBasic, final R_ref=fill(R, mBasic)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}})));
  Star star(m=mBasic) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={50,0})));
  SinglePhase.Interfaces.NegativePin pin annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={100,0})));
equation
  connect(plug, multiStar.plug_p) annotation (Line(
      points={{-100,0},{-60,0}}, color={85,170,255}));
  connect(multiStar.starpoints, resistor.plug_p) annotation (Line(
      points={{-40,0},{-10,0}}, color={85,170,255}));
  connect(resistor.plug_n, star.plug_p) annotation (Line(
      points={{10,0},{40,0}}, color={85,170,255}));
  connect(star.pin_n, pin) annotation (Line(
      points={{60,0},{100,0}}, color={85,170,255}));
  annotation (defaultComponentName="multiStar", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Line(
              points={{-40,40},{0,0},{40,40},{0,0},{0,-40}}, 
              color={85,170,255}, 
              origin={-60,0}, 
              rotation=90),Rectangle(
              extent={{-10,20},{10,-20}}, 
              lineColor={85,170,255}, 
              rotation=90),Line(
              points={{-40,40},{0,0},{40,40},{0,0},{0,-40}}, 
              color={85,170,255}, 
              origin={60,0}, 
              rotation=90), 
        Text(
          extent={{-150,70},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-110},{150,-70}}, 
          textString="R=%R")}), 
    Documentation(info="<html>
<p>
星型点通过电阻连接。该模型用于操作偶数相数的多相系统，以避免基础系统星点的理想连接；请参阅<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">多相指南</a>。
</p>
</html>"));
end MultiStarResistance;