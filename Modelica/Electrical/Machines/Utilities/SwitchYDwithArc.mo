within Modelica.Electrical.Machines.Utilities;
model SwitchYDwithArc "带电弧的星-三角开关"
  parameter Integer m=3 "相数" annotation(Evaluate=true);
  parameter SI.Resistance Ron=1e-5 "闭合开关电阻";
  parameter SI.Conductance Goff=1e-5 "打开开关导纳";
  parameter SI.Time delayTime(final min=0)=0 "延迟时间";
  parameter SI.Voltage V0(start=30) "初始电弧电压";
  parameter SI.VoltageSlope dVdt(start=10E3) "电弧电压斜率";
  parameter SI.Voltage Vmax(start=60) "最大电弧电压";
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plugSupply(final m= 
       m) "接入电网" annotation (Placement(transformation(extent={{-10,90},{
            10,110}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_sp(final m=m) 
    "接入正相定子插头" annotation (Placement(transformation(extent={
            {50,-90},{70,-110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_sn(final m=m) 
    "接入负相定子插头" annotation (Placement(transformation(extent={
            {-70,-90},{-50,-110}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Electrical.Polyphase.Basic.Delta delta(final m=m) annotation (
      Placement(transformation(extent={{40,-80},{20,-60}})));
  Polyphase.Ideal.CloserWithArc      idealCloser(
    final m=m, 
    Ron=fill(Ron, m), 
    Goff=fill(Goff, m), 
    V0=fill(V0, m), 
    dVdt=fill(dVdt, m), 
    Vmax=fill(Vmax, m), 
    closerWithArc(off(start=fill(true, m), fixed=fill(true, m)))) 
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Modelica.Blocks.Interfaces.BooleanInput control[m] annotation (Placement(
        transformation(extent={{-120,0},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Polyphase.Ideal.OpenerWithArc      idealOpener(
    final m=m, 
    Ron=fill(Ron, m), 
    Goff=fill(Goff, m), 
    V0=fill(V0, m), 
    dVdt=fill(dVdt, m), 
    Vmax=fill(Vmax, m), 
    openerWithArc(off(start=fill(true, m), fixed=fill(true, m)))) 
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Blocks.Logical.LogicalDelay logicalDelay[m](delayTime=fill(delayTime, m)) 
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));


equation
  connect(delta.plug_p, plugSupply) annotation (Line(points={{40,-70},{60,-70}, 
          {60,100},{0,100}}, color={0,0,255}));
  connect(delta.plug_p, plug_sp) annotation (Line(points={{40,-70},{60,-70}, 
          {60,-100}}, color={0,0,255}));
  connect(idealCloser.plug_p, plug_sn) annotation (Line(points={{-10,-70},{-60,-70}, 
          {-60,-100}}, color={0,0,255}));
  connect(idealCloser.plug_n, delta.plug_n) 
    annotation (Line(points={{10,-70},{20,-70}}, color={0,0,255}));
  connect(idealOpener.plug_p, plug_sn) 
    annotation (Line(points={{-60,-40},{-60,-100}}, color={0,0,255}));
  connect(idealOpener.plug_n, star.plug_p) 
    annotation (Line(points={{-40,-40},{20,-40}}, color={0,0,255}));
  connect(control, logicalDelay.u) 
    annotation (Line(points={{-110,10},{-82,10}}, color={255,0,255}));
  connect(logicalDelay.y1, idealOpener.control) 
    annotation (Line(points={{-59,16},{-50,16},{-50,-28}}, color={255,0,255}));
  connect(logicalDelay.y2, idealCloser.control) 
    annotation (Line(points={{-59,4},{0,4},{0,-58}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={
        Line(
          points={{20,22},{40,12},{60,22},{40,12},{40,-10}}, 
          color={0,0,255}), 
        Ellipse(
          extent={{-64,-16},{-56,-24}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-4,4},{4,-4}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-4,-36},{4,-44}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-2,-20},{-56,-20}}, color={0,0,255}), 
        Line(points={{40,-62},{20,-30},{60,-30},{40,-62}}, color={0,0,255}), 
        Line(points={{0,90},{0,88},{0,80},{80,80},{80,78},{80,-40},{60,-40}}, color={0,0,255}), 
        Line(points={{4,0},{20,0}}, color={0,0,255}), 
        Line(points={{4,-40},{20,-40}}, color={0,0,255}), 
        Line(points={{-60,-24},{-60,-90}}, color={0,0,255}), 
        Line(
          points={{-100,0},{-30,0},{-30,-20}}, 
          color={255,0,255}, 
          pattern=LinePattern.Dash), 
        Line(points={{60,-90},{60,-40}}, color={0,0,255}), 
        Line(points={{-12,20},{-20,-6},{-4,2},{-12,-20}}, 
                                                      color={255,0,0}), 
        Line(points={{-12,-20},{-20,-46},{-4,-38},{-12,-60}}, 
                                                      color={255,0,0})}), 
                            Documentation(info="<html>
当开关打开时带有电弧的星-三角开关。<br>
如果<em>control</em>为false，则plug_sp和plug_sn是星形连接，并且plug_sp连接到供电插头。<br>
如果<em>control</em>为true，则plug_sp和plug_sn是三角形连接，并且它们连接到供电插头。<br>
请注意，在打开星形连接和关闭三角形连接之间有一段延迟，分别在打开三角形连接和关闭星形连接之间也有延迟。</html>"));
end SwitchYDwithArc;