within Modelica.Electrical.Analog.Examples;
model Resistor "带基础热网结构的电阻"
  extends Modelica.Icons.Example;
  Basic.Resistor resistor(
    R=100, 
    alpha=1e-3, 
    T_ref=293.15, 
    i(start=0), 
    useHeatPort=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=-90, 
        origin={-32,34})));
  Modelica.Electrical.Analog.Basic.Ground G 
  annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(V=220, f=1) 
  annotation (Placement(transformation(
        origin={-70,40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G= 
        50) 
  annotation (Placement(transformation(
        origin={4,34}, 
        extent={{-10,-10},{10,10}})));
  Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature(T=20) 
    annotation (Placement(transformation(extent={{52,24},{32,44}})));
equation
  connect(SineVoltage1.n, G.p) 
  annotation (Line(points={{-70,30},{-70,20}}, color={0,0,255}));
  connect(resistor.heatPort, thermalConductor.port_a) 
    annotation (Line(points={{-22,34},{-6,34}}, color={191,0,0}));

  connect(SineVoltage1.p, resistor.p) 
    annotation (Line(points={{-70,50},{-32,50},{-32,44}}, color={0,0,255}));

  connect(G.p, resistor.n) 
    annotation (Line(points={{-70,20},{-32,20},{-32,24}}, color={0,0,255}));
  connect(thermalConductor.port_b, fixedTemperature.port) annotation (Line(
      points={{14,34},{32,34}}, color={191,0,0}));
annotation (Documentation(info="<html>
<p>这是一个非常简单的电路，该电路由一个电压源和一个电阻组成。电阻中的损耗功率通过自身的热端口传输到外部(环境)。</p>
</html>"), experiment(StopTime=5));
end Resistor;