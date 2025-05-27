within Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_MTPA "测试示例:永磁同步机，研究每安培的最大扭矩"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m=3 "相数" annotation(Evaluate=true);
  parameter SI.Voltage VNominal=100 "每相标称均方根电压";
  parameter SI.Frequency fNominal=50 "标称频率";
  parameter SI.Frequency f=50 "实际的频率";
  parameter SI.Time tRamp=1 "频率增加";
  parameter SI.Torque TLoad=181.4 "额定负载扭矩";
  parameter SI.Time tStep=1.2 "负载转矩阶跃时间";
  parameter SI.Inertia JLoad=0.29 "载荷的转动惯量";
  parameter SI.AngularVelocity wNominal = 2*pi*fNominal/smpmData.p "标称角速度";
  parameter Boolean positiveRange = false "如果为真，请使用正的角度范围";
  output SI.Angle theta=rotorAngleQS.rotorDisplacementAngle "转子位移角，准静态";
  output SI.Angle phi_i = Modelica.Math.wrapAngle(smpmQS.arg_is[1],positiveRange) "电流角";
  output SI.Angle phi_v = Modelica.Math.wrapAngle(smpmQS.arg_vs[1],positiveRange) "电压角";
  output SI.Angle phi = Modelica.Math.wrapAngle(phi_v-phi_i,positiveRange) "电压和电流之间的夹角";
  output SI.Angle epsilon = Modelica.Math.wrapAngle(phi-theta,positiveRange) "目前的角";

  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData 
    smpmData(useDamperCage=false, effectiveStatorTurns=64, 
    fsNominal=fNominal, 
    Lmd=0.1/(2*pi*fNominal), 
    Lmq=0.3/(2*pi*fNominal), 
    TsRef=373.15) "Synchronous machine data" 
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Magnetic.QuasiStatic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet 
    smpmQS(
    p=smpmData.p, 
    fsNominal=smpmData.fsNominal, 
    Rs=smpmData.Rs, 
    TsRef=smpmData.TsRef, 
    Lssigma=smpmData.Lssigma, 
    Jr=smpmData.Jr, 
    Js=smpmData.Js, 
    frictionParameters=smpmData.frictionParameters, 
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
    permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters, 
    phiMechanical(fixed=true, start=0), 
    m=m, 
    effectiveStatorTurns=smpmData.effectiveStatorTurns, 
    TsOperational=373.15, 
    alpha20s=smpmData.alpha20s, 
    alpha20r=smpmData.alpha20r, 
    TrOperational=373.15) 
    annotation (Placement(transformation(extent={{0,10},{20,30}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed 
    quadraticSpeedDependentTorqueQS(w_fixed=wNominal) 
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star 
    starMachineQS(m= 
        Modelica.Electrical.Polyphase.Functions.numberOfSymmetricBaseSystems(
                                                                     m)) 
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={-20,20})));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground 
    groundMQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-50,10})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.MultiTerminalBox terminalBoxQS(
      terminalConnection="Y", m=m) 
    annotation (Placement(transformation(extent={{0,26},{20,46}})));
  Magnetic.QuasiStatic.FundamentalWave.Utilities.CurrentController currentControllerQS(m=m, p= 
        smpmQS.p) 
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensorQS 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={40,60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sources.ReferenceCurrentSource referenceCurrentSourceQS(m=m) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={10,90})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starQS(m=m) 
    annotation (Placement(transformation(
        origin={60,90}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.QuasiStatic.SinglePhase.Basic.Ground 
    groundeQS annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={60,70})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Resistor resistorQS(m=m, R_ref=fill(1e5, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={30,90})));
  Magnetic.QuasiStatic.FundamentalWave.Sensors.RotorDisplacementAngle rotorAngleQS(
    m=m, 
    p=smpmData.p, 
    positiveRange=positiveRange) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={40,20})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.CurrentQuasiRMSSensor currentRMSSensorQS(m=m) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=90, 
        origin={10,60})));
  Modelica.Electrical.QuasiStatic.Polyphase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensorQS(m=m) annotation (Placement(transformation(extent={{-30,60},{-10,40}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Basic.Star starMQS(m=m) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={-40,40})));
  Modelica.ComplexBlocks.Sources.ComplexRotatingPhasor rotSource(magnitude=100, w=2*pi) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-70,30})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToReal toReal annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-70,60})));
equation
  connect(starMachineQS.plug_p, terminalBoxQS.starpoint) annotation (
      Line(
      points={{-10,20},{-10,32},{0,32}}, 
      color={85,170,255}));
  connect(groundMQS.pin, starMachineQS.pin_n) annotation (Line(
      points={{-50,20},{-30,20}}, 
      color={85,170,255}));
  connect(terminalBoxQS.plug_sn, smpmQS.plug_sn) annotation (Line(
      points={{4,30},{4,30}}, 
      color={85,170,255}));
  connect(terminalBoxQS.plug_sp, smpmQS.plug_sp) annotation (Line(
      points={{16,30},{16,30}}, 
      color={85,170,255}));
  connect(currentControllerQS.I, referenceCurrentSourceQS.I) annotation (Line(points={{-19,94},{-10,94},{-10,96},{-2,96}}, 
                                                                                                          color={85,170,255}));
  connect(referenceCurrentSourceQS.plug_p, starQS.plug_p) annotation (Line(points={{10,100},{60,100}},          color={85,170,255}));
  connect(starQS.pin_n, groundeQS.pin) annotation (Line(
      points={{60,80},{60,80}}, 
      color={85,170,255}));
  connect(angleSensorQS.flange, smpmQS.flange) annotation (Line(
      points={{40,50},{40,40},{30,40},{30,20},{20,20}}));
  connect(referenceCurrentSourceQS.plug_p, resistorQS.plug_p) annotation (Line(points={{10,100},{30,100}},          color={85,170,255}));
  connect(resistorQS.plug_n, referenceCurrentSourceQS.plug_n) annotation (Line(points={{30,80},{10,80}},           color={85,170,255}));
  connect(currentControllerQS.gamma, referenceCurrentSourceQS.gamma) annotation (Line(points={{-19,86},{-10,86},{-10,84},{-2,84}}, 
                                                                                                                  color={0,0,127}));
  connect(angleSensorQS.phi, currentControllerQS.phi) annotation (Line(points={{40,71},{40,74},{-30,74},{-30,78}}, color={0,0,127}));
  connect(smpmQS.flange, rotorAngleQS.flange) annotation (Line(points={{20,20},{30,20}}));
  connect(terminalBoxQS.plug_sp, rotorAngleQS.plug_p) annotation (Line(points={{16,30},{34,30}},color={85,170,255}));
  connect(terminalBoxQS.plugSupply, currentRMSSensorQS.plug_n) annotation (Line(points={{10,32},{10,50}},   color={85,170,255}));
  connect(currentRMSSensorQS.plug_p, referenceCurrentSourceQS.plug_n) annotation (Line(points={{10,70},{10,80}}, 
                                                                                                               color={85,170,255}));
  connect(rotorAngleQS.plug_n, terminalBoxQS.plug_sn) annotation (Line(points={{46,30},{46,36},{4,36},{4,30}},   color={85,170,255}));
  connect(voltageQuasiRMSSensorQS.plug_n, currentRMSSensorQS.plug_n) annotation (Line(points={{-10,50},{10,50}},color={85,170,255}));
  connect(starMQS.pin_n, starMachineQS.pin_n) annotation (Line(points={{-40,30},{-40,20},{-30,20}}, color={85,170,255}));
  connect(starMQS.plug_p, voltageQuasiRMSSensorQS.plug_p) annotation (Line(points={{-40,50},{-30,50}}, color={85,170,255}));
  connect(quadraticSpeedDependentTorqueQS.flange, rotorAngleQS.flange) annotation (Line(points={{60,20},{30,20}}));
  connect(toReal.u, rotSource.y) annotation (Line(points={{-70,48},{-70,41}}, color={85,170,255}));
  connect(toReal.re, currentControllerQS.id_rms) annotation (Line(points={{-76,72},{-76,96},{-42,96}}, color={0,0,127}));
  connect(currentControllerQS.iq_rms, toReal.im) annotation (Line(points={{-42,84},{-64,84},{-64,72}}, color={0,0,127}));
  annotation (
    experiment(StopTime=1, Interval=1E-3, Tolerance=1E-6), 
    Documentation(info="<html>
<p>
这个例子研究了准静态永磁同步电机的最大转矩每安培(MTPA)。
这些机器是匀速运转的。电流大小保持恒定，电流角度为
从0到360度旋转，模拟周期为一秒.</p>

<p>
在这个模拟中，角度是以下角度计算:</p>

<ul>
<li><code>phi_v</code> = 电压相量角</li>
<li><code>phi_i</code> = 电流相角</li>
<li><code>phiphi_v - phi_i</code> = 电压和电流相量之间的夹角</li>
<li><code>theta</code> = 转子位移角</li>
<li><code>epsilon = phi - theta</code> = 目前的角</li>
</ul>

<p>
模拟1秒并绘制(相对于角度):
</p>

<ul>
<li><code>smpmQS.tauElectrical</code>: 机转矩</li>
<li><code>smpmQS.abs_vs[1]</code>: 机相电压幅值</li>
<li><code>phi</code>: 电压和电流相角之间的相角</li>
</ul>

<h5>注释</h5>
<p>连接到准静态机器模型的绕组端子上的电阻是必要的
在数值上稳定模拟.</p>
</html>"), 
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100, 
            -100},{100,100}}), graphics={
        Text(
          extent={{20,0},{100,-8}}, 
                  textStyle={TextStyle.Bold}, 
          textString="%m phase quasi-static")}));
end SMPM_MTPA;