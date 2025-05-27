within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Inverter 
  "带鼠笼和逆变器的感应电机"
  extends Modelica.Icons.Example;
  constant Integer m=3 "相数";
  parameter SI.Voltage VNominal=100 
    "每相标称均方根电压";
  parameter SI.Frequency fNominal=aimcData.fsNominal "标称频率";
  parameter SI.Frequency f=fNominal "最大工作频率";
  SI.Frequency fActual=ramp.y "实际的频率";
  parameter SI.Time tRamp=1 "频率增加";
  parameter SI.Torque TLoad=161.4 "额定负载扭矩";
  parameter SI.Time tStep=1.2 "负载转矩阶跃时间";
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
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor 
    annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation= 
            270)));
  Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) annotation (
     Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    final m=m, 
    VNominal=VNominal, 
    fNominal=fNominal) 
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage(
      final m=m) annotation (Placement(transformation(
        origin={0,60}, 
        extent={{10,10},{-10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
    startTime=tStep, 
    stepTorque=-TLoad, 
    useSupport=false, 
    offsetTorque=0) annotation (Placement(transformation(extent={{90,-50}, 
            {70,-30}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y") 
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.IM_SquirrelCageData 
    aimcData "感应电机数据" 
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
initial equation
  aimc.is[1:2] = zeros(2);
  aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
equation
  connect(signalVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(ramp.y, vfController.u) 
    annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
  connect(vfController.y, signalVoltage.v) 
    annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
  connect(loadTorqueStep.flange, loadInertia.flange_b) 
    annotation (Line(points={{70,-40},{60,-40}}));
  connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p) 
    annotation (Line(points={{0,50},{0,40},{0,10}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n) 
    annotation (Line(
      points={{-10,-28},{-10,-20},{0,-20},{0,-10}}, color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}}, color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}}, color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>利用VfController和三相信号电压对理想的变频器进行了建模。
通过匝道提高频率，使带鼠笼的感应电机启动，
加速惯量。在tStep时间，一个加载步骤被应用.</p>

<p>模拟1.5秒并绘制(相对于时间):</p>

<ul>
<li>currentQuasiRMSSensor.I: 定子电流均方根</li>
<li>aimc.wMechanical: 电机的速度</li>
<li>aimc.tauElectrical: 电动机的转矩</li>
</ul>
使用默认机器参数.
</html>"));
end IMC_Inverter;