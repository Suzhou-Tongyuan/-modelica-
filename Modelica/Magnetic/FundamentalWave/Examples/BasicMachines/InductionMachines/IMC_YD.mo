within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_YD 
  "鼠笼式Y-D起动感应电机"

  extends Modelica.Icons.Example;
  constant Integer m=3 "相数";
  parameter SI.Voltage VNominal=100 
    "每相标称均方根电压";
  parameter SI.Frequency fNominal=aimcData.fsNominal "标称频率";
  parameter SI.Time tStart1=0.1 "开始时间";
  parameter SI.Time tStart2=2.0 "从Y到D的起始时间";
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
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor 
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={30,70})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m, 
    f=fill(fNominal, m), 
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={-30,90}, 
        extent={{10,10},{-10,-10}})));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime= 
        tStart1) annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m, 
    Ron=fill(1e-5, m), 
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,90}, 
        extent={{-10,10},{10,-10}})));
  Modelica.Electrical.Machines.Utilities.SwitchYD switchYD(m=m) 
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepYD[m](each startTime= 
        tStart2) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    quadraticLoadTorque(
    w_nominal=wLoad, 
    TorqueDirection=false, 
    tau_nominal=-TLoad, 
    useSupport=false) annotation (Placement(transformation(extent={{100,10},{80,30}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData 
    aimcData "感应电机数据" 
    annotation (Placement(transformation(extent={{70,72},{90,92}})));
initial equation
  aimc.is = zeros(3);
  aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
equation
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{-40,90},{-50,90}},      color={0,0,255}));
  connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(points={{-20,90},{-20,90},{-10,90},{-10,90}}, 
                                        color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) 
    annotation (Line(points={{70,20},{80,20}}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-59,60},{0,60},{0,78}}, 
                                          color={255,0,255}));
  connect(booleanStepYD.y, switchYD.control) 
    annotation (Line(points={{-19,40},{18,40}},    color={255,0,255}));
  connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p) 
    annotation (Line(points={{10,90},{30,90},{30,90},{30,90},{30,80},{30,80}}, 
                                                    color={0,0,255}));
  connect(switchYD.plug_sn, aimc.plug_sn) annotation (Line(
      points={{24,30},{24,30}},     color={0,0,255}));
  connect(switchYD.plug_sp, aimc.plug_sp) annotation (Line(
      points={{36,30},{36,30}},   color={0,0,255}));
  connect(switchYD.plugSupply, currentQuasiRMSSensor.plug_n) annotation (
      Line(
      points={{30,50},{30,50},{30,56},{30,56},{30,60}}, 
                                  color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{40,20},{50,20}}));
  annotation (experiment(
      StopTime=2.5, 
      Interval=1E-4, 
      Tolerance=1e-05),                                 Documentation(
        info="<html>
<p>启动时，给鼠笼式感应电机提供启动三相电压，
先是星形连接，然后是三角连接;机器从静止状态启动，
加速惯量对负载转矩的二次依赖于速度，最终达到公称速度.</p>

<p>模拟2.5秒并绘制(相对于时间):</p>

<ul>
<li>currentQuasiRMSSensor.I: 定子电流均方根</li>
<li>aimc.wMechanical: 电机的速度</li>
<li>aimc.tauElectrical: 电动机的转矩</li>
</ul>

<p>使用默认机器参数.</p>
</html>"));
end IMC_YD;