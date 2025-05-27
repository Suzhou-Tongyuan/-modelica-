within Modelica.Electrical.Batteries.Examples;
model CCCVcharging 
  "使用恒流-恒压特性充电电池"
  extends Modelica.Icons.Example;
  parameter Modelica.Electrical.Batteries.ParameterRecords.TransientData.ExampleData cellData(
    Qnom=18000, 
    useLinearSOCDependency=false, 
    Ri=cellData.OCVmax/1200, 
    Idis=0.001) 
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Electrical.Batteries.BatteryStacks.CellRCStack battery(
    Ns=10, 
    Np=2, 
    cellData=cellData, 
    useHeatPort=false, 
    SOC(fixed=true, start=0.1)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor 
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J")) 
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Utilities.CCCVcharger cccvCharger(I=50, Vend=42) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-50,0})));
equation
  connect(battery.n, ground.p) 
    annotation (Line(points={{0,-10},{0,-20},{-20,-20}}, color={0,0,255}));
  connect(powerSensor.nc, battery.p) 
    annotation (Line(points={{-10,40},{0,40},{0,10}}, color={0,0,255}));
  connect(powerSensor.nv, ground.p) 
    annotation (Line(points={{-20,30},{-20,-20}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv) annotation (Line(points={{-30,40}, 
          {-30,50},{-20,50}}, color={0,0,255}));
  connect(powerSensor.power, energy.u) 
    annotation (Line(points={{-30,29},{-30,20},{18,20}}, color={0,0,127}));
  connect(powerSensor.pc, cccvCharger.p) annotation (Line(points={{-30,40}, 
          {-50,40},{-50,10}}, color={0,0,255}));
  connect(ground.p, cccvCharger.n) annotation (Line(points={{-20,-20},{-50, 
          -20},{-50,-10}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1200, 
      Interval=0.1, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>
一个放电到<code>SOC=0.1</code>的电池正在使用CC-CV充电器充电。
在CC模式下的充电电流为5C，这意味着电池理论上在<code>0.9*3600s/5=648s</code>后几乎充满，并且充电器切换到CV模式。
</p>
</html>"));
end CCCVcharging;