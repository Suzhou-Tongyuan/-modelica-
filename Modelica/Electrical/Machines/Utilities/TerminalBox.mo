within Modelica.Electrical.Machines.Utilities;
model TerminalBox "端子箱Y/D连接"
  parameter Integer m=3 "相数" annotation(Evaluate=true);
  parameter String terminalConnection(start="Y") "选择\"Y\"表示星形连接或\"D\"表示三角形连接" 
    annotation (choices(choice="Y" "星形连接", choice="D" 
        "三角形连接"));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_sp(final m=m) 
    "连接至正极子插头" annotation (Placement(transformation(extent={{50,-50}, 
            {70,-70}}), iconTransformation(extent={{
            50,-50},{70,-70}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_sn(final m=m) 
    "连接至负极子插头" annotation (Placement(transformation(extent={{-70,-50}, 
            {-50,-70}}), iconTransformation(extent={
            {-70,-50},{-50,-70}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) if (
    terminalConnection <> "D") annotation (Placement(transformation(
        origin={-70,-80}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Delta delta(final m=m) if (
    terminalConnection == "D") annotation (Placement(transformation(extent= 
            {{-20,-70},{-40,-50}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plugSupply(final m= 
       m) "连接至电网" annotation (Placement(transformation(extent={{-10,-30}, 
            {10,-50}}), iconTransformation(extent={{-10,-30},{
            10,-50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin starpoint if (
    terminalConnection <> "D") "星形连接点" annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}), 
      iconTransformation(extent={{-110,-50},{-90,-30}})));
equation
  connect(plug_sn, star.plug_p) 
    annotation (Line(points={{-60,-60},{-60,-80}}, color={0,0,255}));
  connect(plug_sn, delta.plug_n) annotation (Line(points={{-60,-60},{-40, 
          -60},{-40,-60}}, color={0,0,255}));
  connect(delta.plug_p, plug_sp) annotation (Line(points={{-20,-60},{60,-60}, 
          {60,-60}}, color={0,0,255}));
  connect(plug_sp, plugSupply) annotation (Line(points={{60,-60},{0,-60},{0, 
          -40}}, color={0,0,255}));
  connect(star.pin_n, starpoint) 
    annotation (Line(points={{-80,-80},{-86,-80},{-86,-40},{-100,-40}},color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Polygon(
          points={{-76,-40},{-80,-44},{-80,-80},{-40,-100},{40,-100},{80,-70},{80,-44},{76,-40},{-76,-40}}, 
          lineColor={95,95,95}, 
          fillColor={135,135,135}, 
          fillPattern=FillPattern.Solid), Text(
          extent={{-40,-50},{40,-90}}, 
          textString="%terminalConnection")}), Documentation(info="<html>
<p>
该模型表示电机端子箱的内部连接。
参数<code>terminalConnection</code>用于在星形连接(<code>terminalConnection=\"Y\"</code>)和三角形连接(<code>terminalConnection=\"D\"</code>)之间切换。
如果选择了星形连接，则(单相)连接器<code>starPoint</code>可用。
</p>
</html>"));
end TerminalBox;