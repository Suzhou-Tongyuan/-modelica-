within Modelica.Electrical.Analog.Sensors;
model MultiSensor "电流传感器、电压传感器和功率传感器"
  extends Modelica.Icons.RoundSensor;
  Modelica.Electrical.Analog.Interfaces.PositivePin pc 
      "正极，电流路径" 
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nc 
      "负极，电流路径" 
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pv 
      "正极，电压路径" 
    annotation (Placement(transformation(extent={{-10,110},{10,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin nv 
      "负极，电压路径" 
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput i(final quantity="ElectricCurrent", final unit="A") 
    "输出信号为电流" annotation (Placement(transformation(
        origin={-60,-110}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput v(final quantity="ElectricPotential", final unit="V") 
    "输出信号为电压" annotation (Placement(transformation(
        origin={60,-110}, 
        extent={{10,10},{-10,-10}}, 
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput power(final quantity="Power", final unit="W") 
    "输出信号为瞬时功率" 
    annotation (Placement(transformation(
          origin={-110,-60}, 
          extent={{-10,10},{10,-10}}, 
          rotation=180)));
equation
  pc.i + nc.i = 0;
  pc.v - nc.v = 0;
  pv.i = 0;
  nv.i = 0;
  i = pc.i;
  v = pv.v - nv.v;
  power = v*i;
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
      Text(textColor = {0,0,255}, extent = {{-150,120},{150,160}}, textString = "%name")}), 
    Documentation(info="<html>
<p>这个多合一传感器用于测量单相系统中的电流、电压和瞬时电功率。它具有独立的电压和电流路径。电压路径的引脚为pv(positive voltage)和nv(negative voltage)，电流路径的引脚为pc(positive current)和nc(negative current)。电流路径的内部电阻为零，这意味着电流通过时几乎没有电阻损耗；而电压路径的内部电阻为无穷大，这意味着它主要用于测量电压，不会对电压测量造成显著影响。这样设计是为了确保测量的准确性和独立性。</p>
</html>", revisions="<html>
<ul>
<li><em>20170306</em>Anton Haumer创建</li>
</ul>
</html>"));
end MultiSensor;