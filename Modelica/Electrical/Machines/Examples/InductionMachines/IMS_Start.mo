within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMS_Start "测试示例：滑环型感应电机"
  extends Modelica.Icons.Example;
  constant Integer m=3 "相数";
  parameter SI.Voltage VNominal=100 
    "每相额定有效值电压";
  parameter SI.Frequency fNominal=50 "额定频率";
  parameter SI.Time tStart1=0.1 "起始时间";
  parameter SI.Resistance Rstart=0.16/aimsData.turnsRatio^2 
    "起动电阻";
  parameter SI.Time tStart2=1.0 
    "短接起动电阻的起始时间";
  parameter SI.Torque TLoad=161.4 "额定负载扭矩";
  parameter SI.AngularVelocity wLoad(displayUnit="rev/min")= 
       1440.45*2*Modelica.Constants.pi/60 "额定负载速度";
  parameter SI.Inertia JLoad=0.29 
    "负载的转动惯量";
  Machines.BasicMachines.InductionMachines.IM_SlipRing aims(
    p=aimsData.p, 
    Jr=aimsData.Jr, 
    Js=aimsData.Js, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true), 
    useTurnsRatio=aimsData.useTurnsRatio, 
    turnsRatio=aimsData.turnsRatio, 
    VsNominal=aimsData.VsNominal, 
    VrLockedRotor=aimsData.VrLockedRotor, 
    Rs=aimsData.Rs, 
    TsRef=aimsData.TsRef, 
    Lszero=aimsData.Lszero, 
    Lssigma=aimsData.Lssigma, 
    Lm=aimsData.Lm, 
    Lrsigma=aimsData.Lrsigma, 
    Lrzero=aimsData.Lrzero, 
    Rr=aimsData.Rr, 
    TrRef=aimsData.TrRef, 
    frictionParameters=aimsData.frictionParameters, 
    statorCoreParameters=aimsData.statorCoreParameters, 
    strayLoadParameters=aimsData.strayLoadParameters, 
    rotorCoreParameters=aimsData.rotorCoreParameters, 
    fsNominal=aimsData.fsNominal, 
    TsOperational=293.15, 
    alpha20s=aimsData.alpha20s, 
    alpha20r=aimsData.alpha20r, 
    TrOperational=293.15) 
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (
      Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage(
    final m=m, 
    f=fill(fNominal, m), 
    V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
        origin={0,60}, 
        extent={{10,-10},{-10,10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star star(final m=m) annotation (
      Placement(transformation(extent={{-50,80},{-70,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-90,90}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime= 
        tStart1) annotation (Placement(transformation(extent={{-80,30},{-60, 
            50}})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch idealCloser(
    final m=m, 
    Ron=fill(1e-5, m), 
    Goff=fill(1e-5, m)) annotation (Placement(transformation(
        origin={0,30}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque 
    quadraticLoadTorque(
    w_nominal=wLoad, 
    TorqueDirection=false, 
    tau_nominal=-TLoad, 
    useSupport=false) annotation (Placement(transformation(extent={{90,-50}, 
            {70,-30}})));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="D") 
    annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
  Machines.Utilities.SwitchedRheostat switchedRheostat(
    RStart=Rstart, 
    tStart=tStart2, 
    m=m) annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  parameter Utilities.ParameterRecords.IM_SlipRingData aimsData "感应电机数据" 
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
initial equation
  aims.is = zeros(3);
  aims.ir = zeros(3);
equation
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
  connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(points= 
         {{0,50},{0,48},{0,46},{0,40}}, color={0,0,255}));
  connect(loadInertia.flange_b, quadraticLoadTorque.flange) 
    annotation (Line(points={{60,-40},{70,-40}}));
  connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-59,40},{-20,40},{-20,30},{-12,30}}, 
                                          color={255,0,255}));
  connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p) 
    annotation (Line(points={{0,20},{0,16},{0,10}}, color={0,0,255}));
  connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n) 
    annotation (Line(
      points={{-10,-28},{-10,-20},{0,-20},{0,-10}}, 
      color={0,0,255}));
  connect(terminalBox.plug_sn, aims.plug_sn) annotation (Line(
      points={{-16,-30},{-16,-30}}, 
      color={0,0,255}));
  connect(terminalBox.plug_sp, aims.plug_sp) annotation (Line(
      points={{-4,-30},{-4,-30}}, 
      color={0,0,255}));
  connect(aims.flange, loadInertia.flange_a) annotation (Line(
      points={{0,-40},{40,-40}}));
  connect(switchedRheostat.plug_p, aims.plug_rp) annotation (Line(
      points={{-30,-34},{-20,-34}}, 
      color={0,0,255}));
  connect(switchedRheostat.plug_n, aims.plug_rn) annotation (Line(
      points={{-30,-46},{-20,-46}}, color={0,0,255}));
  annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
        info="<html>
<p>在起始时间 tStart1，三相电压被供应到带有滑环的感应电机；
电机从静止开始，对抗载荷扭矩，根据速度的平方变化，
使用起动电阻。在时间tStart2外部转子电阻被短接，最终达到额定转速。</p>

<p>该示例的仿真时长为1.5秒，用户可以在特定窗口通过勾选绘制以下结果变量的图像：</p>

<ul>
<li>currentQuasiRMSSensor.I：定子电流 RMS</li>
<li>aims.wMechanical：电机速度</li>
<li>aims.tauElectrical：电机扭矩</li>
</ul>

<p>使用默认电机参数。</p>
</html>"));
end IMS_Start;