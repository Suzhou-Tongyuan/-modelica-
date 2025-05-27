within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Transformer 
  "鼠笼式感应电机，变压器起动"

  extends Modelica.Icons.Example;
  constant Integer m=3 "相数";
  parameter SI.Voltage VNominal=100 
    "每相标称均方根电压";
  parameter SI.Frequency fNominal=aimcData.fsNominal "标称频率";
  parameter SI.Time tStart1=0.1 "开始时间";
  parameter SI.Time tStart2=2.0 
    "旁路变压器启动时间";
  parameter SI.Torque TLoad=161.4 "额定负载扭矩";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")= 
       1440.45*2*Modelica.Constants.pi/60 "额定负载速度";
  parameter SI.Inertia JLoad=0.29 
    "载荷的转动惯量";
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
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor 
    annotation (Placement(transformation(origin={-40,80}, extent={{-10,10},{10, 
            -10}})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m, 
    f=fill(fNominal, m), 
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={-70,80}, 
        extent={{10,10},{-10,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,50})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-80,20}, 
        extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1[m](each startTime= 
        tStart1) annotation (Placement(transformation(extent={{-60,40},{-40, 
            60}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m, 
    Ron=fill(1e-5, m), 
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={-10,80}, 
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Machines.BasicMachines.Transformers.Yy.Yy00 transformer(
    n=transformerData.n, 
    R1=transformerData.R1, 
    L1sigma=transformerData.L1sigma, 
    R2=transformerData.R2, 
    L2sigma=transformerData.L2sigma, 
    T1Ref=293.15, 
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero, 

    T2Ref=293.15, 
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero, 

    T1Operational=293.15, 
    T2Operational=293.15) annotation (Placement(transformation(extent={{-10,-10}, 
            {10,10}}, origin={20,80})));

  Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(
        transformation(
        origin={20,50}, 
        extent={{-10,-10},{10,10}})));
  parameter Modelica.Electrical.Machines.Utilities.TransformerData transformerData(
    f=fNominal, 
    V1=VNominal, 
    C1=Modelica.Utilities.Strings.substring(
        transformer.VectorGroup, 
        1, 
        1), 
    V2=VNominal/sqrt(3), 
    C2=Modelica.Utilities.Strings.substring(
        transformer.VectorGroup, 
        2, 
        2), 
    SNominal=50E3, 
    v_sc=0.06, 
    P_sc=500) "Transformer data" 
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep2[m](each startTime= 
        tStart2) annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Electrical.Polyphase.Ideal.IdealCommutingSwitch 
    idealCommutingSwitch(
    final m=m, 
    Ron=fill(1e-5, m), 
    Goff=fill(50E-5, m)) annotation (Placement(transformation(
        extent={{60,90},{40,70}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{50,10},{30,30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    quadraticLoadTorque(
    w_nominal=wLoad, 
    TorqueDirection=false, 
    tau_nominal=-TLoad, 
    useSupport=false) annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="D") 
    annotation (Placement(transformation(extent={{80,26},{60,46}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData 
    aimcData "感应电机数据" 
    annotation (Placement(transformation(extent={{80,52},{100,72}})));
initial equation
  aimc.is = zeros(3);
  aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
  transformer.i1[1:2] = zeros(2);
equation
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-80,40},{-80,40},{-80,34},{-80,34},{-80,30},{-80,30}}, 
                                                 color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{76,30},{76,30}},     color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{64,30},{64,30}},   color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
      Line(
      points={{30,20},{20,20}}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{60,20},{50,20}}));
  connect(star.plug_p, sineVoltage.plug_n) annotation (Line(
      points={{-80,60},{-80,80}}, color={0,0,255}));
  connect(booleanStep2.y, idealCommutingSwitch.control) annotation (Line(
      points={{-39,20},{-30,20},{-30,20},{-10,20},{-10,40},{50,40},{50,68}}, 
                               color={255,0,255}));
  connect(transformer.starpoint2, ground2.p) annotation (Line(
      points={{25,70},{25,60},{20,60}},    color={0,0,255}));
  connect(idealCommutingSwitch.plug_p, terminalBox.plugSupply) 
    annotation (Line(
      points={{60,80},{60,80},{68,80},{68,80},{70,80},{70,32},{70,32}}, 
                                            color={0,0,255}));
  connect(transformer.plug2, idealCommutingSwitch.plug_n1) annotation (
      Line(
      points={{30,80},{40,80},{40,76}},  color={0,0,255}));
  connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
      Line(
      points={{-60,80},{-50,80}}, 
                                color={0,0,255}));
  connect(booleanStep1.y, idealCloser.control) annotation (Line(
      points={{-39,50},{-10,50},{-10,68},{-10,68}}, 
                                 color={255,0,255}));
  connect(currentQuasiRMSSensor.plug_n, idealCloser.plug_p) annotation (
      Line(
      points={{-30,80},{-20,80}}, 
                              color={0,0,255}));
  connect(transformer.plug1, idealCloser.plug_n) annotation (Line(
      points={{10,80},{0,80}},  color={0,0,255}));
  connect(idealCloser.plug_n, idealCommutingSwitch.plug_n2) annotation (
      Line(
      points={{0,80},{0,80},{0,100},{40,100},{40,80}}, 
                              color={0,0,255}));
  annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>启动时间tStart1三相电压通过变压器给鼠笼感应电机供电;
机器从静止状态启动，加速惯量对负载转矩的二次依赖于速度;
在启动时间tStart2，机器直接从电压源馈电，最终达到标称速度.</p>

<p>模拟2.5秒并绘制(相对于时间):</p>

<ul>
<li>currentQuasiRMSSensor.I: 定子电流均方根</li>
<li>aimc.wMechanical: 电机的速度</li>
<li>aimc.tauElectrical: 电动机的转矩</li>
</ul>

<p>使用默认机器参数.</p>
</html>"));
end IMC_Transformer;