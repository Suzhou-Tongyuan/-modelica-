within Modelica.Electrical.Batteries.Examples;
model CCCV_CellRC 
  "使用恒流-恒压特性充电瞬态电池"
  extends Modelica.Icons.Example;
  parameter Modelica.Electrical.Batteries.ParameterRecords.TransientData.ExampleData cellData(
    Qnom=18000, 
    useLinearSOCDependency=false, 
    Ri=4.2/1200, 
    Idis=0.001) "电池数据" 
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Batteries.Utilities.CCCVcharger cccvCharger(I=25, Vend=4.2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-50,0})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Electrical.Batteries.BatteryStacksWithSensors.CellRC cell(cellData=cellData) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Analog.Sensors.MultiSensor multiSensor 
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J")) 
    annotation (Placement(transformation(extent={{-60,24},{-80,44}})));
equation
  connect(cell.n, ground.p) 
    annotation (Line(points={{0,-10},{0,-20},{-20,-20}}, color={0,0,255}));
  connect(ground.p, cccvCharger.n) 
    annotation (Line(points={{-20,-20},{-50,-20},{-50,-10}}, color={0,0,255}));
  connect(multiSensor.nc, cell.p) 
    annotation (Line(points={{-10,40},{0,40},{0,10}}, color={0,0,255}));
  connect(multiSensor.power, energy.u) 
    annotation (Line(points={{-31,34},{-58,34}}, color={0,0,127}));
  connect(ground.p, multiSensor.nv) 
    annotation (Line(points={{-20,-20},{-20,30}}, color={0,0,255}));
  connect(multiSensor.pc, multiSensor.pv) 
    annotation (Line(points={{-30,40},{-30,50},{-20,50}}, color={0,0,255}));
  connect(multiSensor.pc, cccvCharger.p) 
    annotation (Line(points={{-30,40},{-50,40},{-50,10}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1200, 
      Interval=0.1, 
      Tolerance=1e-06), 
    Documentation(info="<html>
<p>
一个放电到<code>SOC=0.1</code>的单个瞬态电池正在使用CC-CV充电器充电。
在CC模式下的充电电流为5C，这意味着电池理论上在<code>0.9*3600s/5=648s</code>后几乎充满，并且充电器切换到CV模式。
模拟1200秒，用户可以在特定界面绘制<code>cell.cellBus.soc</code>与<code>time</code>的图。
</p>
</html>"));
end CCCV_CellRC;