within Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator;
model ForceCurrentBehaviour 
  "电枢闭锁在中间位置时两种变流器型号的力-电流特性比较"

  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground pmGround annotation (Placement(
        transformation(extent={{-70,-100},{-50,-80}})));
  FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator pmActuator(x(start=0), 
      material=Material.HardMagnetic.PlasticNdFeB()) 
    "用磁导模型描述动圈传动器" annotation (
      Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Mechanics.Translational.Components.Fixed pmFixedPos(s0=0) 
    "固定电枢位置" annotation (Placement(transformation(extent= 
           {{10,-70},{30,-50}})));
  Modelica.Electrical.Analog.Sources.RampCurrent pmRampCurrent(
    I=-6, 
    duration=6, 
    offset=3) "Ideal current source" annotation (Placement(
        transformation(
        origin={-60,-60}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground cGround annotation (Placement(
        transformation(extent={{-70,-20},{-50,0}})));
  Modelica.Mechanics.Translational.Components.Fixed cFixedPos(s0=0) 
    "固定电枢位置" annotation (Placement(transformation(extent= 
           {{10,10},{30,30}})));
  Modelica.Electrical.Analog.Sources.RampCurrent cRampCurrent(
    I=-6, 
    duration=6, 
    offset=3) "Ideal current source" annotation (Placement(
        transformation(
        origin={-60,20}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  FluxTubes.Examples.MovingCoilActuator.Components.ConstantActuator cActuator 
    "用转换器常数描述动圈传动器" annotation (
      Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Blocks.Tables.CombiTable1Ds comparisonWithFEA(table=[-3, -9.65653;
        -2.5, -8.28587; -2, -6.82002; -1.5, -5.25898; -1, -3.60274; -0.5,
        -1.85131; 0, -0.00468; 0.5, 1.93714; 1, 3.97415; 1.5, 6.10636; 2,
        8.33376; 2.5, 10.65636; 3, 13.07415]) 
    "第 1 列：电流，第 2 列：力；有限元模型中 mu_rFe=const.=1000" 
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor iSensor 
    "有限元分析结果查询表的输入值" annotation (
      Placement(transformation(extent={{-50,40},{-30,20}})));
equation
  connect(pmFixedPos.flange, pmActuator.flange) 
    annotation (Line(points={{20,-60},{0,-60}}, color={0,127,0}));
  connect(pmRampCurrent.p, pmActuator.p) annotation (Line(points={{-60,-50},{-30,-50},{-30,-50},{-20,-50}}, 
                                          color={0,0,255}));
  connect(pmActuator.n, pmRampCurrent.n) annotation (Line(points={{-20,-70},{-30,-70},{-30,-70},{-60,-70}}, 
                                          color={0,0,255}));
  connect(pmGround.p, pmRampCurrent.n) 
    annotation (Line(points={{-60,-80},{-60,-70}}, color={0,0,255}));
  connect(cGround.p, cRampCurrent.n) 
    annotation (Line(points={{-60,0},{-60,10}}, color={0,0,255}));
  connect(cActuator.flange, cFixedPos.flange) 
    annotation (Line(points={{0,20},{20,20}}, color={0,127,0}));
  connect(cRampCurrent.n, cActuator.n) annotation (Line(points={{-60,10},{-30,10},{-30,10},{-20,10}}, 
                                       color={0,0,255}));
  connect(cRampCurrent.p, iSensor.p) 
    annotation (Line(points={{-60,30},{-50,30}}, color={0,0,255}));
  connect(cActuator.p, iSensor.n) annotation (Line(points={{-20,30},{-30,30},{-30,30}}, 
                         color={0,0,255}));
  connect(iSensor.i, comparisonWithFEA.u) annotation (Line(points={{-40,41},{-40,50},{38,50}}, 
                                 color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100}, 
            {100,100}}), graphics={Text(
                extent={{-98,96},{100,86}}, 
                textColor={0,0,255}, 
                textString= 
            "Comparison of the force-current characteristics of both converter models"), 
          Text( extent={{-98,88},{2,78}}, 
                textColor={0,0,255}, 
                textString="with armature blocked at mid-position")}), 
    experiment(StopTime=6, Tolerance=1e-007), 
    Documentation(info="<html>
<p>
看一下<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. ConstantActuator\">ConstantActuator</a>和<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. PermeanceActuator\">PermeanceActuator</a>两个转换器模型的解释.<br>
</p>
<p>
对电枢在中间位置x=0阻塞时两种变换器模型的力电流特性进行了仿真，揭示了两种模型的差异。在<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. ConstantActuator\">ConstantActuator</a>，力与电流成正比。在简单的<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components. PermeanceActuator\">PermeanceActuator</a>有一个额外的非线性力分量，这是由于电感对电枢位置的依赖。通过与有限元分析结果的比较，验证了<a href=\"modelica://Modelica.Magnetic.FluxTubes.Examples.MovingCoilActuator.Components.PermeanceActuator\">PermeanceActuator</a>的较高精度。在有限元模型中，定子铁的相对磁导率设为mu_rFe=const。=1000，以避免由于饱和而产生的额外非线性力分量。<strong>模拟6秒</strong>和<strong>图对电流(例如，issensor i)</strong></p>
<blockquote><pre>
pmFixedPos.flange_b.f       // 渗透力模型
cFixedPos.flange_b.f        // 变流器恒力模型
comparisonWithFEA.y[1]      // 用于比较的有限元模型力
</pre></blockquote>
</html>"));
end ForceCurrentBehaviour;