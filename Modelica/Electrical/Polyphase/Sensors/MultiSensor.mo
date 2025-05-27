within Modelica.Electrical.Polyphase.Sensors;
model MultiSensor "多相传感器，用于测量电流、电压和功率"
  extends Modelica.Icons.RoundSensor;
  parameter Integer m(min=1) = 3 "相数" annotation(Evaluate=true);
  Polyphase.Interfaces.PositivePlug pc(final m=m) "正极，电流路径" 
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  Polyphase.Interfaces.NegativePlug nc(final m=m) "负极，电流路径" 
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Polyphase.Interfaces.PositivePlug pv(final m=m) "正极，电压路径" 
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  Polyphase.Interfaces.NegativePlug nv(final m=m) "负极，电压路径" 
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput i[m](each final quantity="ElectricCurrent", each final unit="A") 
    "作为输出信号的电流" annotation (Placement(transformation(
        origin={-60,-110}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput v[m](each final quantity="ElectricPotential", each final unit="V") 
    "作为输出信号的电压" annotation (Placement(transformation(
        origin={60,-110}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput power[m](each final quantity="Power", each final unit="W") 
    "作为输出信号的瞬时功率" annotation (Placement(transformation(
        origin={-110,-60}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  Modelica.Blocks.Interfaces.RealOutput powerTotal(final quantity="Power", final unit="W") 
    "作为输出信号的瞬时功率总和" annotation (Placement(transformation(
        origin={110,-60}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
equation
  pc.pin.i + nc.pin.i = zeros(m);
  pc.pin.v - nc.pin.v = zeros(m);
  pv.pin.i = zeros(m);
  nv.pin.i = zeros(m);
  i = pc.pin.i;
  v = pv.pin.v - nv.pin.v;
  power = v.*i;
  powerTotal = sum(power);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
      Line(points = {{0,100},{0,70}}, color = {0,0,255}), 
      Line(points = {{0,-70},{0,-100}}, color = {0,0,255}), 
      Line(points = {{-100,0},{100,0}}, color = {0,0,255}), 
      Line(points = {{0,70},{0,40}}), 
        Line(points={{-100,-60},{-80,-60},{-56,-42}}, 
                                                   color={0,0,127}), 
        Line(points={{-60,-100},{-60,-80},{-42,-56}}, 
                                                   color={0,0,127}), 
        Line(points={{60,-100},{60,-80},{42,-56}}, 
                                                color={0,0,127}), 
        Text(
          extent={{-100,-40},{-60,-80}}, 
            textColor={64,64,64}, 
            textString="W"), 
        Text(
          extent={{-80,-60},{-40,-100}}, 
            textColor={64,64,64}, 
            textString="A"), 
        Text(
          extent={{40,-60},{80,-100}}, 
            textColor={64,64,64}, 
            textString="V"), 
        Line(points={{100,-60},{80,-60},{56,-42}}, color={0,0,127}), 
        Text(
          extent={{-150,110},{150,150}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>
<p>该多传感器测量多相系统的电流、电压和瞬时电功率，并具有分离的电压和电流路径。
电压路径的插头是pv和nv，电流路径的插头是pc和nc。
每条电流路径的内部电阻为零，每条电压路径的内部电阻为无穷大。</p>
</html>", revisions="<html>
<ul>
<li><em>20170306</em>由Anton Haumer首次实现</li>
</ul>
</html>"));
end MultiSensor;