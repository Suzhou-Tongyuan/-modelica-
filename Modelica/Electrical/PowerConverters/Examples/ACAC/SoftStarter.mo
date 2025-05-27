within Modelica.Electrical.PowerConverters.Examples.ACAC;
model SoftStarter "感应电机的软启动"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "相位数量";
  constant Real y2d=Modelica.Electrical.Polyphase.Functions.factorY2D(m);
  parameter SI.Voltage VNominal=100 "线对线标称有效值电压";
  parameter SI.Current INominal=100*y2d "端子上的标称有效值电流";
  parameter SI.Frequency fNominal=aimcData.fsNominal "标称频率";
  parameter SI.Inertia JLoad=aimcData.Jr "负载的惯性矩";
  parameter SI.Torque TLoad=161.4 "额定负载扭矩";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")= 
       1440.45*2*Modelica.Constants.pi/60 "额定负载速度";
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m, 
    f=fill(fNominal, m), 
    V=sqrt(2)*fill(VNominal, m)/y2d) 
    annotation (Placement(transformation(
        origin={-80,0}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) 
    annotation (
      Placement(transformation(extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,-30})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(
        transformation(
        origin={-80,-60}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor(m=m) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={-80,30})));
  PowerConverters.ACAC.PolyphaseTriac triac(final m=m, useHeatPort=false) 
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m=m) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-60,0})));
  Modelica.Electrical.Polyphase.Basic.Star star1(m=m) 
    annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={-60,-30})));
  Modelica.Electrical.Analog.Basic.Ground ground1 
    annotation (Placement(
        transformation(
        origin={-60,-60}, 
        extent={{-10,-10},{10,10}})));
  PowerConverters.ACDC.Control.Signal2mPulse adaptor(
    m=m, 
    useConstantFiringAngle=false, 
    useFilter=false, 
    f=fNominal) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  PowerConverters.ACAC.Control.VoltageToAngle voltageToAngle(VNominal=1, 
      voltage2Angle=PowerConverters.Types.Voltage2AngleType.H01) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-30,-30})));
  Modelica.Electrical.Polyphase.Sensors.MultiSensor multiSensor(m=m) 
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Electrical.Polyphase.Basic.Star star2(m=m) 
    annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground2 
    annotation (Placement(
        transformation(
        origin={0,-30}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquare(f=fNominal) 
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Blocks.Math.Harmonic harmonic(f=fNominal,k=1) 
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Electrical.Machines.Utilities.MultiTerminalBox terminalBox(m=m, 
      terminalConnection="D") 
    annotation (Placement(transformation(extent={{10,6},{30,26}})));
  Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage 
    imc(
    m=m, 
    p=aimcData.p, 
    fsNominal=aimcData.fsNominal, 
    Rs=aimcData.Rs*m/3, 
    TsRef=aimcData.TsRef, 
    alpha20s(displayUnit="1/K") = aimcData.alpha20s, 
    effectiveStatorTurns=aimcData.effectiveStatorTurns, 
    Lszero=aimcData.Lszero*m/3, 
    Lssigma=aimcData.Lssigma*m/3, 
    Jr=aimcData.Jr, 
    Js=aimcData.Js, 
    frictionParameters=aimcData.frictionParameters, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    statorCoreParameters=aimcData.statorCoreParameters, 
    strayLoadParameters=aimcData.strayLoadParameters, 
    Lm=aimcData.Lm*m/3, 
    Lrsigma=aimcData.Lrsigma*m/3, 
    Rr=aimcData.Rr*m/3, 
    TrRef=aimcData.TrRef, 
    TsOperational=293.15, 
    alpha20r=aimcData.alpha20r, 
    TrOperational=293.15) 
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  parameter Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData aimcData 
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    quadraticLoadTorque(
    w_nominal=wLoad, 
    TorqueDirection=false, 
    tau_nominal=-TLoad, 
    useSupport=false) annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  PowerConverters.ACAC.Control.SoftStartControl softStartControl(
    tRampUp=4, 
    vStart=0.3, 
    iMax=2.5, 
    iMin=2.4, 
    INominal=INominal, 
    tRampDown=3, 
    vRef(fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-30,-60})));
  Modelica.Blocks.Continuous.Filter filter(analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping, 
      f_cut=2*fNominal) 
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Blocks.Sources.BooleanTable booleanTable(table={0.1,5.5}, 
      startTime=0) 
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
initial equation
  imc.is[1:3] = zeros(3);
  imc.ir[1:2] = zeros(2);
equation
  connect(ground.p, star.pin_n) 
    annotation (Line(points={{-80,-50},{-80,-40}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(imc.flange, loadInertia.flange_a) 
    annotation (Line(points={{30,0},{40,0}}, color={0,0,0}));
  connect(triac.plug_n, multiSensor.pc) 
    annotation (Line(points={{-20,40},{-10,40}}, color={0,0,255}));
  connect(multiSensor.pc, multiSensor.pv) 
    annotation (Line(points={{-10,40},{-10,50},{0,50}}, color={0,0,255}));
  connect(multiSensor.nv,star2. plug_p) 
    annotation (Line(points={{0,30},{0,10},{1.77636e-15,10}}, 
                                             color={0,0,255}));
  connect(terminalBox.plug_sn, imc.plug_sn) 
    annotation (Line(points={{14,10},{14,10}}, color={0,0,255}));
  connect(terminalBox.plug_sp, imc.plug_sp) 
    annotation (Line(points={{26,10},{26,10}}, color={0,0,255}));
  connect(triac.fire1, adaptor.fire_p) 
    annotation (Line(points={{-36,28},{-36,11}}, color={255,0,255}));
  connect(triac.fire2, adaptor.fire_n) 
    annotation (Line(points={{-24,28},{-24,11}}, color={255,0,255}));
  connect(voltageSensor.v, adaptor.v) 
    annotation (Line(points={{-49,-8.88178e-16},{-46,-8.88178e-16},{-46,0},{-42, 
          0}},                                 color={0,0,127}));
  connect(currentQuasiRMSSensor.plug_p, sineVoltage.plug_p) 
    annotation (Line(points={{-80,20},{-80,10}}, color={0,0,255}));
  connect(currentQuasiRMSSensor.plug_n, triac.plug_p) 
    annotation (Line(points={{-80,40},{-40,40}}, color={0,0,255}));
  connect(multiSensor.nc, terminalBox.plugSupply) 
    annotation (Line(points={{10,40},{20,40},{20,12}}, color={0,0,255}));
  connect(triac.plug_p, voltageSensor.plug_p) 
    annotation (Line(points={{-40,40},{-60,40},{-60,10}}, color={0,0,255}));
  connect(voltageSensor.plug_n, star1.plug_p) 
    annotation (Line(points={{-60,-10},{-60,-20}}, color={0,0,255}));
  connect(star1.pin_n, ground1.p) 
    annotation (Line(points={{-60,-40},{-60,-50}}, color={0,0,255}));
  connect(star2.pin_n, ground2.p) 
    annotation (Line(points={{0,-10},{0,-20}}, color={0,0,255}));
  connect(multiSensor.v[1], harmonic.u) annotation (Line(points={{6,29},{6,20},{
          30,20},{30,30},{38,30}},      color={0,0,127}));
  connect(multiSensor.v[1], rootMeanSquare.u) annotation (Line(points={{6,29},{6, 
          20},{30,20},{30,60},{38,60}},    color={0,0,127}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) 
    annotation (Line(points={{60,0},{70,0}}, color={0,0,0}));
  connect(currentQuasiRMSSensor.I, filter.u) annotation (Line(points={{-91, 
          30},{-100,30},{-100,-80},{-62,-80}}, color={0,0,127}));
  connect(voltageToAngle.firingAngle, adaptor.firingAngle) 
    annotation (Line(points={{-30,-19},{-30,-12}}, color={0,0,127}));
  connect(filter.y, softStartControl.iRMS) 
    annotation (Line(points={{-39,-80},{-30,-80},{-30,-72}}, color={0,0,127}));
  connect(voltageToAngle.vRef, softStartControl.vRef) 
    annotation (Line(points={{-30,-42},{-30,-49}}, color={0,0,127}));
  connect(booleanTable.y, softStartControl.start) 
    annotation (Line(points={{-11,-60},{-18,-60}}, color={255,0,255}));
  annotation (experiment(
      StopTime=10, 
      Interval=0.0001, 
      Tolerance=1e-06), Documentation(info="<html><p>
该模型演示了感应电机的软启动： 电压斜坡从 0.1 秒开始，应在 4 秒内斜坡上升到额定电压，但电流限制在额定电流的 2.5 倍。在 5.5 秒时，需要在 3 秒内降低电压斜坡。
</p>
<p>
参考电压由<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.SoftStartControl\" target=\"\">softStartControl block</a>，
参考电压通过<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\" target=\"\">voltageToAngle block</a>。
发射角度由<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\" target=\"\">Signal2mPulse adaptor</a>将发射信号应用于<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.PolyphaseTriac\" target=\"\">triac</a>。</p>
<p>
比较从发射角度开始<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines. IMC_DOL\" target=\"\">starting direct on line</a>，
<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines. IMC_YD\" target=\"\">star-delta starting</a>和<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines. IMC_Transformer\" target=\"\">starting via a transformer</a>启动。
</p>
</html>"));
end SoftStarter;