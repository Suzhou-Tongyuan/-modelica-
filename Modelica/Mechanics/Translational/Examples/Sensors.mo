within Modelica.Mechanics.Translational.Examples;
model Sensors "用于平移系统的传感器"
  extends Modelica.Icons.Example;

  Translational.Sensors.ForceSensor forceSensor annotation (Placement(
        transformation(extent={{-40,10},{-20,30}})));
  Modelica.Mechanics.Translational.Sensors.MultiSensor multiSensor 
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Translational.Sensors.SpeedSensor speedSensor1 annotation (Placement(
        transformation(extent={{60,-50},{80,-30}})));
  Translational.Sensors.PositionSensor positionSensor1 annotation (
      Placement(transformation(extent={{60,-20},{80,0}})));
  Translational.Sensors.AccSensor accSensor1 annotation (Placement(
        transformation(extent={{60,-80},{80,-60}})));
  Translational.Sensors.PositionSensor positionSensor2 annotation (
      Placement(transformation(extent={{60,10},{80,30}})));
  Translational.Components.Mass mass(
    L=1, 
    s(fixed=true), 
    v(fixed=true), 
    m=1) annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Translational.Sources.Force force annotation (Placement(transformation(
          extent={{-70,10},{-50,30}})));
  Modelica.Blocks.Sources.Sine sineForce(amplitude=10, f=4) 
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
equation
  connect(sineForce.y, force.f) 
    annotation (Line(points={{-79,20},{-72,20}}, color={0,0,127}));
  connect(forceSensor.flange_a, force.flange) annotation (Line(
      points={{-40,20},{-50,20}}, color={0,127,0}));
  connect(mass.flange_a, positionSensor1.flange) annotation (Line(
      points={{30,20},{20,20},{20,-10},{60,-10}}, 
                                        color={0,127,0}));
  connect(mass.flange_a, speedSensor1.flange) annotation (Line(
      points={{30,20},{20,20},{20,-40},{60,-40}}, 
                                          color={0,127,0}));
  connect(mass.flange_a, accSensor1.flange) annotation (Line(
      points={{30,20},{20,20},{20,-70},{60,-70}}, 
                                          color={0,127,0}));
  connect(mass.flange_b, positionSensor2.flange) annotation (Line(
      points={{50,20},{60,20}}, color={0,127,0}));
  connect(forceSensor.flange_b, multiSensor.flange_a) annotation (Line(
      points={{-20,20},{-10,20}},color={0,127,0}));
  connect(multiSensor.flange_b, mass.flange_a) annotation (Line(
      points={{10,20},{30,20}}, color={0,127,0}));
  annotation (Documentation(info="<html>
<p>
这些传感器测量
</p>

<blockquote><pre>
force f in N
position s in m
velocity v in m/s
acceleration a in m/s2
</pre></blockquote>

<p>
在此示例中，测得的速度和加速度与传感器连接到的一维平动接口无关。相反，测得的位置取决于一维平动接口（flange_a 或 flange_b）和组件的长度&nbsp;<var>L</var>。
可通过绘制 <code>positionSensor1.s</code>、<code>positionSensor2.s</code> 和 <code>mass.s</code> 来查看差异。
</p>
</html>"), 
       experiment(StopTime=1.0, Interval=0.001));
end Sensors;