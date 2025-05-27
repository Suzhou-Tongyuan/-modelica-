within Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase;
model SMPM_Inverter_Polyphase 
  "带逆变器的多相永磁同步电机的起动"

  extends Modelica.Icons.Example;
  constant Integer m3=3 "三相系统定子相数";
  parameter Integer m=5 "定子相数" annotation(Evaluate=true);
  parameter SI.Voltage VsNominal=100 
    "每相标称均方根电压";
  parameter SI.Frequency fsNominal=smpmData.fsNominal "标称频率";
  parameter SI.Frequency fKnee=50 
    "V/f 曲线的膝频率";
  parameter SI.Time tRamp=1 "频率斜波";
  parameter SI.Torque T_Load=181.4 "额定负载扭矩";
  parameter SI.Time tStep=1.2 "负载扭矩阶跃时间";
  parameter SI.Inertia J_Load=0.29 "负载惯性";
  Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
        transformation(
        origin={-90,90}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star3(final m=m3) annotation (
     Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltage3(
      final m=m3) annotation (Placement(transformation(
        origin={0,70}, 
        extent={{10,10},{-10,-10}}, 
        rotation=270)));
  Modelica.Blocks.Sources.Ramp ramp(height=fKnee, duration=tRamp) 
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Electrical.Machines.Utilities.VfController vfController3(
    VNominal=VsNominal, 
    fNominal=fsNominal, 
    BasePhase=+Modelica.Constants.pi/2, 
    final m=m3, 
    orientation=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m3)) 
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor 
    currentRMSsensorM(m=m) annotation (Placement(transformation(
        origin={30,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor 
    currentRMSsensor3 annotation (Placement(transformation(
        origin={-80,0}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
      terminalConnection="Y", m=m) annotation (Placement(transformation(
          extent={{-10,-14},{10,6}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
      terminalConnection="Y", m=m3) annotation (Placement(transformation(
          extent={{-10,-74},{10,-54}})));
  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet 
    smpmM(
    Jr=smpmData.Jr, 
    Js=smpmData.Js, 
    p=smpmData.p, 
    fsNominal=smpmData.fsNominal, 
    TsRef=smpmData.TsRef, 
    alpha20s(displayUnit="1/K") = smpmData.alpha20s, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    useDamperCage=smpmData.useDamperCage, 
    Lrsigmad=smpmData.Lrsigmad, 
    Lrsigmaq=smpmData.Lrsigmaq, 
    Rrd=smpmData.Rrd, 
    Rrq=smpmData.Rrq, 
    TrRef=smpmData.TrRef, 
    alpha20r(displayUnit="1/K") = smpmData.alpha20r, 
    VsOpenCircuit=smpmData.VsOpenCircuit, 
    frictionParameters=smpmData.frictionParameters, 
    statorCoreParameters=smpmData.statorCoreParameters, 
    strayLoadParameters=smpmData.strayLoadParameters, 
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters, 
    m=m, 
    Rs=smpmData.Rs*m/3, 
    Lssigma=smpmData.Lssigma*m/3, 
    Lszero=smpmData.Lszero*m/3, 
    Lmd=smpmData.Lmd*m/3, 
    Lmq=smpmData.Lmq*m/3, 
    ir(each fixed=true), 
    TsOperational=293.15, 
    effectiveStatorTurns=smpmData.effectiveStatorTurns, 
    TrOperational=293.15) 
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet 
    smpm3(
    p=smpmData.p, 
    fsNominal=smpmData.fsNominal, 
    Rs=smpmData.Rs, 
    TsRef=smpmData.TsRef, 
    alpha20s(displayUnit="1/K") = smpmData.alpha20s, 
    Lszero=smpmData.Lszero, 
    Lssigma=smpmData.Lssigma, 
    Jr=smpmData.Jr, 
    Js=smpmData.Js, 
    frictionParameters=smpmData.frictionParameters, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    statorCoreParameters=smpmData.statorCoreParameters, 
    strayLoadParameters=smpmData.strayLoadParameters, 
    VsOpenCircuit=smpmData.VsOpenCircuit, 
    Lmd=smpmData.Lmd, 
    Lmq=smpmData.Lmq, 
    useDamperCage=smpmData.useDamperCage, 
    Lrsigmad=smpmData.Lrsigmad, 
    Lrsigmaq=smpmData.Lrsigmaq, 
    Rrd=smpmData.Rrd, 
    Rrq=smpmData.Rrq, 
    TrRef=smpmData.TrRef, 
    alpha20r(displayUnit="1/K") = smpmData.alpha20r, 
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters, 
    m=m3, 
    ir(each fixed=true), 
    TsOperational=293.15, 
    effectiveStatorTurns=smpmData.effectiveStatorTurns, 
    TrOperational=293.15) 
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));

  Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle3(
     p=smpm3.p) annotation (Placement(transformation(
        origin={30,-80}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load) 
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=J_Load) 
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
    startTime=tStep, 
    stepTorque=-T_Load, 
    useSupport=false, 
    offsetTorque=0) annotation (Placement(transformation(extent={{100,-30}, 
            {80,-10}})));
  Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep3(
    startTime=tStep, 
    stepTorque=-T_Load, 
    useSupport=false, 
    offsetTorque=0) annotation (Placement(transformation(extent={{100,-90}, 
            {80,-70}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData 
    smpmData "同步机器数据" 
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalVoltageM(
      final m=m) annotation (Placement(transformation(
        origin={30,50}, 
        extent={{10,10},{-10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star starM(final m=m) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=180, 
        origin={60,90})));
  Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
        transformation(
        origin={90,90}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Modelica.Electrical.Machines.Utilities.VfController vfController(
    VNominal=VsNominal, 
    fNominal=fsNominal, 
    BasePhase=+Modelica.Constants.pi/2, 
    final m=m, 
    orientation=-
        Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m)) 
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={-30,50})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        origin={-50,0})));
  Modelica.Blocks.Math.Gain gain(k=(m/m3)) 
    annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
initial equation
  smpm3.is[1:2] = zeros(2);
  smpmM.is[1:2] = zeros(2);
  //条件阻尼器笼电流被定义为固定起始值
equation
  connect(signalVoltage3.plug_n, star3.plug_p) 
    annotation (Line(points={{0,80},{0,90},{-50,90}}, color={0,0,255}));
  connect(star3.pin_n, ground3.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(ramp.y, vfController3.u) 
    annotation (Line(points={{-59,70},{-42,70}}, color={0,0,255}));
  connect(vfController3.y, signalVoltage3.v) 
    annotation (Line(points={{-19,70},{-12,70}},color={0,0,255}));
  connect(loadInertiaM.flange_b, torqueStepM.flange) 
    annotation (Line(points={{70,-20},{80,-20}}));
  connect(smpmM.flange, loadInertiaM.flange_a) 
    annotation (Line(points={{10,-20},{50,-20}}));
  connect(terminalBoxM.plug_sn, smpmM.plug_sn) 
    annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plug_sp, smpmM.plug_sp) 
    annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
  connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
      Line(points={{0,-8},{0,-8},{0,10},{30,10}},        color={0,0,255}));
  connect(loadInertia3.flange_b, torqueStep3.flange) 
    annotation (Line(points={{70,-80},{80,-80}}));
  connect(rotorAngle3.plug_n, smpm3.plug_sn) annotation (Line(points={{36, 
          -70},{36,-64},{-6,-64},{-6,-70}}, color={0,0,255}));
  connect(rotorAngle3.plug_p, smpm3.plug_sp) 
    annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
  connect(rotorAngle3.flange, smpm3.flange) 
    annotation (Line(points={{20,-80},{10,-80}}));
  connect(smpm3.flange, loadInertia3.flange_a) 
    annotation (Line(points={{10,-80},{50,-80}}));
  connect(terminalBox3.plug_sn, smpm3.plug_sn) 
    annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
  connect(terminalBox3.plug_sp, smpm3.plug_sp) 
    annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
  connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
      Line(points={{-80,-10},{-80,-60},{0,-60},{0,-68}}, color={0,0,255}));
  connect(signalVoltage3.plug_p, currentRMSsensor3.plug_p) annotation (
      Line(
      points={{0,60},{0,34},{-80,34},{-80,10}}, 
      color={0,0,255}));
  connect(signalVoltageM.plug_n, starM.plug_p) annotation (Line(
      points={{30,60},{30,90},{50,90}}, 
      color={0,0,255}));
  connect(starM.pin_n, groundM.p) annotation (Line(
      points={{70,90},{80,90}}, 
      color={0,0,255}));
  connect(vfController.y, signalVoltageM.v) annotation (Line(
      points={{-19,50},{18,50}}, 
      color={0,0,127}));
  connect(vfController.u, ramp.y) annotation (Line(
      points={{-42,50},{-50,50},{-50,70},{-59,70}}, 
      color={0,0,127}));
  connect(signalVoltageM.plug_p, currentRMSsensorM.plug_p) annotation (
      Line(
      points={{30,40},{30,30}}, 
      color={0,0,255}));
  connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
      points={{-69,0},{-64.5,0},{-64.5,0},{-58,0}}, 
      color={0,0,255}));
  connect(gain.y, feedback.u2) annotation (Line(
      points={{-41,20},{-50,20},{-50,8}}, 
      color={0,0,127}));
  connect(gain.u, currentRMSsensorM.I) annotation (Line(
      points={{-18,20},{19,20}}, 
      color={0,0,127}));
  annotation (
    experiment(
      StopTime=1.5, 
      Interval=1E-4, 
      Tolerance=1e-006), 
    Documentation(info="<html>
<h4>由理想逆变器馈电的永磁同步电机</h4>
<p>

利用
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>s
和<a href=\"modelica://Modelica.Electrical.Polyphase.Sources.SignalVoltage\">SignalVoltages</a>s。
频率被一个斜坡提高，导致
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines. SM_PermanentMagnet\">permanent magnet synchronous machines</a>启动，
加速惯量。比较了两种不同相数的等效电机，证明了它们的等效性能.</p>

<p>在tStep时间，一个加载步骤被应用。模拟1.5秒并绘制(相对于时间):</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: 机器扭矩</li>
<li><code>aimsM|M3.wMechanical</code>: 机器速度</li>
<li><code>feedback.y</code>: 为零，因为三相电流相位差和缩放多相电流相位差相等</li>
</ul>

</html>"), 
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), 
                         graphics={Rectangle(
                extent={{-20,0},{100,-40}}, 
                fillColor={255,255,170}, 
                fillPattern=FillPattern.Solid, 
                pattern=LinePattern.Dash),Rectangle(
                extent={{-20,-60},{100,-100}}, 
                fillColor={255,255,170}, 
                fillPattern=FillPattern.Solid, 
                pattern=LinePattern.Dash),Text(
                extent={{40,-54},{100,-62}}, 
                fillColor={255,255,170}, 
                fillPattern=FillPattern.Solid, 
                textStyle={TextStyle.Bold}, 
                textString="Three-phase machine
"),     Text(
          extent={{40,-44},{100,-52}}, 
                fillColor={255,255,170}, 
                fillPattern=FillPattern.Solid, 
                textStyle={TextStyle.Bold}, 
                textString="%m-phase machine
")}));
end SMPM_Inverter_Polyphase;