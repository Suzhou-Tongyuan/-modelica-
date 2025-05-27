within Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities;
model TerminalBox "接线盒Y/ d型连接"
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  parameter String terminalConnection(start="Y") "选择“Y”作为星型连接，选择“D”作为delta连接" 
    annotation (choices(choice="Y" "Star connection", choice="D" 
        "Delta connection"));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug 
    plug_sp(final m=m) "用正极定子插头连接" annotation (Placement(
        transformation(extent={{50,-50},{70,-70}}), 
        iconTransformation(extent={{50,-50},{70,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug 
    plug_sn(final m=m) "用负极定子插头连接" annotation (Placement(
        transformation(extent={{-70,-50},{-50,-70}}), 
        iconTransformation(extent={{-70,-50},{-50,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star star(final m=m) if (
    terminalConnection <> "D") annotation (Placement(transformation(
        origin={-70,-80}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Delta delta(final m=m) if (
    terminalConnection == "D") 
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug 
    plugSupply(final m=m) "与电网相连" annotation (Placement(transformation(
          extent={{-10,-30},{10,-50}}), iconTransformation(
          extent={{-10,-30},{10,-50}})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.NegativePin starpoint if (
    terminalConnection <> "D") "Star point" annotation (Placement(
        transformation(extent={{-110,-50},{-90,-30}}), iconTransformation(
          extent={{-110,-50},{-90,-30}})));
equation
  connect(star.plug_p, plug_sn) annotation (Line(
      points={{-60,-80},{-60,-60}}, color={85,170,255}));
  connect(delta.plug_n, plug_sn) annotation (Line(
      points={{-40,-60},{-40,-60},{-60,-60}}, color={85,170,255}));
  connect(delta.plug_p, plug_sp) annotation (Line(
      points={{-20,-60},{60,-60},{60,-60}}, color={85,170,255}));
  connect(plugSupply, plug_sp) annotation (Line(
      points={{0,-40},{0,-60},{60,-60}}, color={85,170,255}));
  connect(star.pin_n, starpoint) annotation (Line(
      points={{-80,-80},{-86,-80},{-86,-40},{-100,-40}},color={85,170,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
              extent={{-40,-50},{40,-90}}, 
              textString="%terminalConnection"),Polygon(
              points={{-80,-40},{-80,-44},{-80,-80},{-40,-100},{40,-100},{
              80,-70},{80,-44},{76,-40},{-80,-40}}, 
              lineColor={95,95,95}, 
              fillColor={135,135,135}, 
              fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p>
该模型表示电机接线盒的内部连接。
参数<code>terminalConnection</code>用于在星号之间切换
(<code>terminalConnection = \"Y\"</code>)和delta (<code>terminalConnection = \"D\"</code>)连接。
(单相)连接器<code>starPoint</code>仅在选择星型连接时可用.
</p>
</html>"));
end TerminalBox;