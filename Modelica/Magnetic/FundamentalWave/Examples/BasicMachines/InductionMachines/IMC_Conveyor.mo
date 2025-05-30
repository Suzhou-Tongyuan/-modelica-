﻿within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Conveyor 
  "感应电机与鼠笼和变频器驱动的输送机"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "相数";
  constant SI.Frequency unitFrequency=1 annotation(HideResult=true);
  parameter SI.Voltage VNominal=100 
    "每相标称均方根电压";
  parameter SI.Frequency fNominal=aimcData.fsNominal 
    "标称频率";
  parameter SI.AngularVelocity wNominal=2*pi*fNominal/aimcData.p 
    "额定速度";
  parameter SI.Torque TLoad=161.4 "额定负载扭矩";
  parameter SI.Inertia JLoad=0.29 
    "载荷的转动惯量";
  parameter SI.Length r=0.05 "传输半径";
  Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage aimc(
    p=aimcData.p, 
    fsNominal=aimcData.fsNominal, 
    TsRef=aimcData.TsRef, 
    alpha20s(displayUnit="1/K") = aimcData.alpha20s, 
    Jr=aimcData.Jr, 
    Js=aimcData.Js, 
    frictionParameters=aimcData.frictionParameters, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    statorCoreParameters=aimcData.statorCoreParameters, 
    strayLoadParameters=aimcData.strayLoadParameters, 
    TrRef=aimcData.TrRef, 
    Rs=aimcData.Rs*m/3, 
    Lssigma=aimcData.Lssigma*m/3, 
    Lszero=aimcData.Lszero*m/3, 
    Lm=aimcData.Lm*m/3, 
    Lrsigma=aimcData.Lrsigma*m/3, 
    Rr=aimcData.Rr*m/3, 
    TsOperational=293.15, 
    effectiveStatorTurns=aimcData.effectiveStatorTurns, 
    alpha20r=aimcData.alpha20r, 
    TrOperational=293.15) 
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor 
    annotation (Placement(transformation(extent={{20,100},{40,80}})));
  Modelica.Blocks.Sources.CombiTimeTable dutyCycle(
    table=[0,0; 1,1; 4,1; 5,0; 10,0; 11,-1; 14,-1; 15,0; 20,0], 
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) 
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    final m=m, 
    VNominal=VNominal, 
    fNominal=fNominal) 
    annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={0,90}, 
        extent={{10,10},{-10,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-40,80},{-60,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-70,70}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y") 
    annotation (Placement(transformation(extent={{60,26},{40,46}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData 
    aimcData "感应电机数据" 
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
  Modelica.Blocks.Math.Gain gain(k=fNominal/unitFrequency) 
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=1/r) 
    annotation (Placement(transformation(extent={{32,10},{12,30}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m=JLoad/r^2) 
    annotation (Placement(transformation(extent={{0,10},{-20,30}})));
  Modelica.Mechanics.Translational.Sources.SignForce signForce(v0(displayUnit= 
          "m/s") = 0.01*wNominal*r, f_nominal=-TLoad/r) 
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
initial equation
  aimc.is[1:2] = zeros(2);
  aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
equation
  connect(signalVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{-10,90},{-40,90}},      color={0,0,255}));
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-60,90},{-70,90},{-70,80}}, 
                                                 color={0,0,255}));
  connect(vfController.y, signalVoltage.v) 
    annotation (Line(points={{-9,50},{0,50},{0,78}}, 
                                                color={0,0,255}));
  connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p) 
    annotation (Line(points={{10,90},{20,90}},      color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n) 
    annotation (Line(
      points={{50,32},{50,90},{40,90}},             color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{56,30},{56,30}},     color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{44,30},{44,30}},   color={0,0,255}));
  connect(vfController.u, gain.y) 
    annotation (Line(points={{-32,50},{-39,50}}, color={0,0,127}));
  connect(dutyCycle.y[1], gain.u) 
    annotation (Line(points={{-79,50},{-62,50}}, color={0,0,127}));
  connect(aimc.flange, idealGearR2T.flangeR) 
    annotation (Line(points={{40,20},{32,20}}));
  connect(idealGearR2T.flangeT, mass.flange_a) 
    annotation (Line(points={{12,20},{0,20}},             color={0,127,0}));
  connect(mass.flange_b, signForce.flange) 
    annotation (Line(points={{-20,20},{-30,20}},          color={0,127,0}));
  annotation (experiment(StopTime=20, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>利用VfController和三相信号电压对理想的变频器进行了建模。
频率由加速、匀速、减速和静止的负载循环驱动。
机械负载是一个恒定的扭矩，就像一个输送机(在零速度附近正则化)。.</p>

<p>模拟20秒并绘制(相对于时间):</p>

<ul>
<li>currentQuasiRMSSensor.I: 定子电流均方根</li>
<li>aimc.wMechanical: 电机的速度</li>
<li>aimc.tauElectrical: 电动机的转矩</li>
</ul>
<p>使用默认机器参数.</p>
</html>"));
end IMC_Conveyor;