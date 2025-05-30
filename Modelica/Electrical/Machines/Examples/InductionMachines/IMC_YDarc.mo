﻿within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMC_YDarc "测试示例：Y-D鼠笼型感应电机"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "相数";
  parameter SI.Voltage VNominal=100 
    "每相额定有效值电压";
  parameter SI.Frequency fNominal=50 "额定频率";
  parameter SI.Resistance RLine=0.0001 "线路电阻";
  parameter SI.Inductance LLine=0.0001/(2*pi*fNominal) "线路电感";
  parameter SI.Time tStart1=0.1 "起始时间";
  parameter SI.Time tStart2=2.0 "从 Y 到 D 的起始时间";
  parameter SI.Torque TLoad=161.4 "额定负载扭矩";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")= 
       1440.45*2*Modelica.Constants.pi/60 "额定负载速度";
  parameter SI.Inertia JLoad=0.29 
    "负载的转动惯量";
  Machines.BasicMachines.InductionMachines.IM_SquirrelCage aimc(
    p=aimcData.p, 
    fsNominal=aimcData.fsNominal, 
    Rs=aimcData.Rs, 
    TsRef=aimcData.TsRef, 
    alpha20s(displayUnit="1/K") = aimcData.alpha20s, 
    Lszero=aimcData.Lszero, 
    Lssigma=aimcData.Lssigma, 
    Jr=aimcData.Jr, 
    Js=aimcData.Js, 
    frictionParameters=aimcData.frictionParameters, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    statorCoreParameters=aimcData.statorCoreParameters, 
    strayLoadParameters=aimcData.strayLoadParameters, 
    Lm=aimcData.Lm, 
    Lrsigma=aimcData.Lrsigma, 
    Rr=aimcData.Rr, 
    TrRef=aimcData.TrRef, 
    TsOperational=293.15, 
    alpha20r=aimcData.alpha20r, 
    TrOperational=293.15) 
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270, 
        origin={0,-10})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m, 
    f=fill(fNominal, m), 
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={-30,90}, 
        extent={{10,-10},{-10,10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime= 
        tStart1) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m, 
    Ron=fill(1e-5, m), 
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,20}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Utilities.SwitchYDwithArc   switchYDwithArc(
                                       m=m, delayTime=0.02, 
    V0=10, 
    dVdt=10E3, 
    Vmax=100) 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepYD[m](each startTime= 
        tStart2) annotation (Placement(transformation(extent={{-80,-40},{-60, 
            -20}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    quadraticLoadTorque(
    w_nominal=wLoad, 
    TorqueDirection=false, 
    tau_nominal=-TLoad, 
    useSupport=false) annotation (Placement(transformation(extent={{90,-60},{70, 
            -40}})));
  parameter Utilities.ParameterRecords.IM_SquirrelCageData aimcData "感应电机数据" 
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Polyphase.Basic.Resistor resistor(m=m, R=fill(RLine, m)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,80})));
  Polyphase.Basic.Inductor inductor(m=m, L=fill(LLine, m)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={0,50})));
initial equation
  inductor.i[1:2] = zeros(2);
  aimc.is = zeros(3);
  aimc.ir = zeros(2);
equation
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{-40,90},{-50,90}},      color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) 
    annotation (Line(points={{60,-50},{70,-50}}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-59,30}, 
          {-20,30},{-20,20},{-12,20}},    color={255,0,255}));
  connect(booleanStepYD.y, switchYDwithArc.control) 
    annotation (Line(points={{-59,-30},{-22,-30}}, color={255,0,255}));
  connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p) 
    annotation (Line(points={{0,10},{0,0}},         color={0,0,255}));
  connect(switchYDwithArc.plug_sn, aimc.plug_sn) 
    annotation (Line(points={{-16,-40},{-16,-40}}, color={0,0,255}));
  connect(switchYDwithArc.plug_sp, aimc.plug_sp) 
    annotation (Line(points={{-4,-40},{-4,-40}}, color={0,0,255}));
  connect(switchYDwithArc.plugSupply, currentQuasiRMSSensor.plug_n) 
    annotation (Line(points={{-10,-20},{0,-20}}, color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-50},{40,-50}}));
  connect(sineVoltage.plug_p, resistor.plug_p) 
    annotation (Line(points={{-20,90},{0,90}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p) 
    annotation (Line(points={{0,70},{0,60}}, color={0,0,255}));
  connect(inductor.plug_n, idealCloser.plug_p) 
    annotation (Line(points={{0,40},{0,30}}, color={0,0,255}));
  annotation (experiment(StopTime=2.5, Interval=0.0001, Tolerance=1e-06), Documentation(
        info="<html>
<p>
与IMC_YD相同的示例，但在Y切断和D接通之间增加了时间延迟。
</p>

<p>
请注意，此处使用switchYDwithArc以避免打开Y连接时出现不合理的电压峰值。
</p>

<p>使用默认电机参数。</p>
</html>"));
end IMC_YDarc;