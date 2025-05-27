within Modelica.Electrical.Machines.Utilities;
model SwitchedRheostat "在给定时间后缩短的电阻器"
  parameter Integer m=3 "相数" annotation(Evaluate=true);
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(final m=m) 
    "连接至正转子插头" annotation (Placement(transformation(extent={{
            90,70},{110,50}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(final m=m) 
    "连接至负转子插头" annotation (Placement(transformation(extent={{
            90,-50},{110,-70}})));
  parameter SI.Resistance RStart "起始电阻";
  parameter SI.Time tStart 
    "打开起始电阻器的持续时间";
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-40,-70},{-60,-50}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-80,-60}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Ideal.IdealCommutingSwitch 
    idealCommutingSwitch(
    final m=m, 
    Ron=fill(1e-5, m), 
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={40,20}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Resistor rheostat(final m=m, final R= 
       fill(RStart, m)) annotation (Placement(transformation(extent={{0,-30}, 
            {-20,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star starRheostat(final m=m) 
    annotation (Placement(transformation(extent={{-40,-30},{-60,-10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](final startTime=fill(
        tStart, m), final startValue=fill(false, m)) annotation (Placement(
        transformation(extent={{-60,10},{-40,30}})));
equation
  connect(plug_p, idealCommutingSwitch.plug_p) annotation (Line(
      points={{100,60},{40,60},{40,30}}, color={0,0,255}));
  connect(idealCommutingSwitch.plug_n2, plug_n) annotation (Line(
      points={{40,10},{40,-60},{100,-60}}, color={0,0,255}));
  connect(rheostat.plug_p, idealCommutingSwitch.plug_n1) annotation (Line(
      points={{0,-20},{36,-20},{36,10}}, color={0,0,255}));
  connect(idealCommutingSwitch.plug_n2, star.plug_p) annotation (Line(
      points={{40,10},{40,-60},{-40,-60}}, color={0,0,255}));
  connect(rheostat.plug_n, starRheostat.plug_p) annotation (Line(
      points={{-20,-20},{-40,-20}}, color={0,0,255}));
  connect(starRheostat.pin_n, star.pin_n) annotation (Line(
      points={{-60,-20},{-60,-60}}, color={0,0,255}));
  connect(star.pin_n, ground.p) annotation (Line(
      points={{-60,-60},{-70,-60}}, color={0,0,255}));
  connect(booleanStep.y, idealCommutingSwitch.control) annotation (Line(
      points={{-39,20},{28,20}}, color={255,0,255}));
  annotation (defaultComponentName="rheostat", 
    Icon(graphics={
        Rectangle(
          extent={{26,40},{54,-40}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{100,60},{-40,60},{-40,40}}, color={0,0,255}), 
        Line(points={{100,-60},{-40,-60},{-40,-40}}, color={0,0,255}), 
        Ellipse(extent={{-44,40},{-36,32}}, lineColor={0,0,255}), 
        Ellipse(extent={{-44,-32},{-36,-40}}, lineColor={0,0,255}), 
        Line(points={{-80,40},{-42,-34}}, color={0,0,255}), 
        Line(points={{40,40},{40,42},{40,60}}, color={0,0,255}), 
        Line(points={{40,-40},{40,-60}}, color={0,0,255}), 
        Line(points={{10,-80},{70,-80}}, color={0,0,255}), 
        Line(points={{40,-60},{40,-80}}, color={0,0,255}), 
        Line(points={{20,-90},{60,-90}}, color={0,0,255}), 
        Line(points={{30,-100},{50,-100}}, color={0,0,255})}), 
      Documentation(info="<html>
<p>用于带滑环转子的感应电机启动的切换电阻器：</p>
<p>外部转子电阻<code>RStart</code>在时间<code>tStart</code>后被缩短。</p>
</html>"));
end SwitchedRheostat;