within Modelica.Magnetic.QuasiStatic.FundamentalWave.Utilities;
model MultiTerminalBox "接线盒 Y/D 连接"
  parameter Integer m(min=1) = 3 "阶段数" annotation(Evaluate=true);
  final parameter Integer mSystems= 
      Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                  m) "Number of symmetric base systems";
  final parameter Integer mBasic=integer(m/mSystems) "基本系统的阶段数" annotation(Evaluate=true);
  parameter String terminalConnection(start="Y") "选择 Y 表示星形连接，D 表示三角连接" 
    annotation (choices(choice="Y" "Star connection", choice="D" 
        "Delta connection"));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug 
    plug_sp(final m=m) "与正极定子插头连接" annotation (Placement(
        transformation(extent={{50,-50},{70,-70}}), 
        iconTransformation(extent={{50,-50},{70,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug 
    plug_sn(final m=m) "与定子负极插头连接" annotation (Placement(
        transformation(extent={{-70,-50},{-50,-70}}), 
        iconTransformation(extent={{-70,-50},{-50,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiStar multiStar(final m=m) 
    if (terminalConnection <> "D") annotation (Placement(transformation(
        origin={-70,-80}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.MultiDelta multiDelta(final m=m) 
    if (terminalConnection == "D") 
    annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug 
    plugSupply(final m=m) "与电网连接" annotation (Placement(transformation(
          extent={{-10,-30},{10,-50}}), iconTransformation(
          extent={{-10,-30},{10,-50}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug 
    starpoint(final m=mSystems) if (terminalConnection <> "D") "星点" annotation (
      Placement(transformation(extent={{-110,-50},{-90,-30}}), 
        iconTransformation(extent={{-110,-50},{-90,-30}})));
equation
  connect(multiStar.plug_p, plug_sn) annotation (Line(
      points={{-60,-80},{-60,-60}}, color={85,170,255}));
  connect(starpoint, multiStar.starpoints) annotation (Line(
      points={{-100,-40},{-86,-40},{-86,-80},{-80,-80}},color={85,170,255}));
  connect(multiDelta.plug_n, plug_sn) annotation (Line(
      points={{-40,-60},{-40,-60},{-60,-60}}, color={85,170,255}));
  connect(multiDelta.plug_p, plug_sp) annotation (Line(
      points={{-20,-60},{60,-60},{60,-60}}, color={85,170,255}));
  connect(plugSupply, plug_sp) annotation (Line(
      points={{0,-40},{0,-60},{60,-60}}, color={85,170,255}));
  annotation (defaultComponentName="terminalBox", 
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
              points={{-74,-40},{-80,-46},{-80,-80},{-40,-100},{40,-100},{
              80,-70},{80,-44},{76,-40},{-74,-40}}, 
              lineColor={95,95,95}, 
              fillColor={135,135,135}, 
              fillPattern=FillPattern.CrossDiag),Text(
              extent={{-40,-50},{40,-90}}, 
              textString="%terminalConnection")}), 
    Documentation(info="<html>
<p>
该模型表示电机接线盒的内部连接。
参数<code>terminalConnection</code>用于在星号之间切换
(<code>terminalConnection = \"Y\"</code>)和delta (<code>terminalConnection = \"D\"</code>)连接.
</p>

<p>连接器<code>starPoint</code>仅在选择星型连接时可用。
这个连接器是一个插头
<code>mSystem = Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(m)</code> phases，
表示每个基系的星点;看到
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase\">Modelica.Magnetic.FundamentalWave.UsersGuide.Polyphase</a>.
</p>
</html>"));
end MultiTerminalBox;