within Modelica.Electrical.Machines.Examples.InductionMachines;
model IMC_InverterDrive 
  "测试示例：鼠笼型感应电机逆变器驱动"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Polyphase.Functions.factorY2DC;
  constant Integer m=3 "相数";
  parameter SI.Voltage VNominal=400 
    "每相额定有效电压";
  parameter SI.Frequency fNominal=50 "额定频率";
  parameter SI.Resistance RGrid=10e-3 "网格阻抗电阻";
  parameter SI.Inductance LGrid=500e-6 "网格阻抗电感";
  parameter SI.Voltage VDC=factorY2DC(m)*VNominal/sqrt(3) "理论直流电压";
  parameter SI.Capacitance CDC=5e-3 "直流电容";
  parameter SI.Torque TLoad=161.4 "额定负载扭矩";
  parameter SI.AngularVelocity wLoad=1440.45*2*pi/60 "额定负载转速";
  parameter SI.Inertia JLoad=0.29 "负载惯性矩";
  Polyphase.Sources.SineVoltage sineVoltage(
    final m=m, 
    final phase=-Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m), 
    final f=fill(fNominal, m), 
    final offset=zeros(m), 
    final startTime=zeros(m), 
    final V=fill(VNominal*sqrt(2/3), m)) 
  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,-30})));
  Polyphase.Basic.Star star(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,-60})));
  Analog.Basic.Ground ground annotation (Placement(transformation(
        origin={-80,-90}, 
        extent={{-10,-10},{10,10}})));
  Sensors.CurrentQuasiRMSSensor gridCurrent 
   annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={-80,0})));
  Polyphase.Basic.Resistor resistor(
    final m=m, 
    final R=fill(RGrid, m), 
    final T_ref=fill(20, m), 
    final alpha=zeros(m), 
    final T=fill(20, m))   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,30})));
  Polyphase.Basic.Inductor inductor(m=m, final L=fill(LGrid, m)) 
  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,60})));

  PowerConverters.ACDC.DiodeBridge2mPulse rectifier 
    annotation (Placement(transformation(extent={{-68,60},{-48,80}})));
  Analog.Basic.Capacitor capacitor(v(fixed=true, start=VDC), C=CDC) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-30,70})));
  PowerConverters.DCAC.Polyphase2Level inverter annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={0,70})));
  Machines.Sensors.CurrentQuasiRMSSensor machineCurrent annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={30,0})));
  Machines.Utilities.TerminalBox terminalBox(terminalConnection="D") 
    annotation (Placement(transformation(extent={{20,-24},{40,-4}})));
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
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  parameter Utilities.ParameterRecords.IM_SquirrelCageData aimcData(
    Rs=0.03*16, 
    Rr=0.04*16, 
    Lssigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*aimcData.fsNominal)*16, 
    Lm=3*sqrt(1 - 0.0667)/(2*pi*aimcData.fsNominal)*16, 
    Lrsigma=3*(1 - sqrt(1 - 0.0667))/(2*pi*aimcData.fsNominal)*16) "感应电机数据" 
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad) 
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque loadTorque(
    useSupport=false, tau_nominal=-TLoad, 
    TorqueDirection=false, 
    w_nominal=wLoad) 
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Sources.Ramp ramp(height=fNominal, 
    startTime=0, 
    duration=1.2) 
    annotation (
     Placement(transformation(extent={{-10,-10},{10,10}}, 
        origin={-20,-50})));
  Machines.Utilities.VfController vfController(
    final m=m, 
    VNominal=VNominal, 
    fNominal=fNominal, 
    EconomyMode=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={0,-20})));

  SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={0,10})));
  PowerConverters.DCAC.Control.PWM pwm(uMax=VDC, f=2000) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={0,40})));
initial equation
  inductor.i[1:2] = zeros(2);
  aimc.is[1:3] = zeros(3);
  aimc.ir = zeros(2);
equation
  connect(loadTorque.flange, loadInertia.flange_b) 
    annotation (Line(points={{80,-30},{70,-30}}));
  connect(terminalBox.plugSupply, machineCurrent.plug_n) 
    annotation (Line(points={{30,-18},{30,-10}}, 
                                               color={0,0,255}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
      points={{24,-20},{24,-20}}, 
      color={0,0,255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
      points={{36,-20},{36,-20}}, 
      color={0,0,255}));
  connect(aimc.flange, loadInertia.flange_a) annotation (Line(
      points={{40,-30},{50,-30}}));
  connect(vfController.u, ramp.y) 
    annotation (Line(points={{0,-32},{0,-50},{-9,-50}}, 
                                               color={0,0,127}));
  connect(toSpacePhasor.u, vfController.y) 
    annotation (Line(points={{0,-2},{0,-9}},   color={0,0,127}));
  connect(pwm.u, toSpacePhasor.y) 
    annotation (Line(points={{0,28},{0,21}},   color={0,0,127}));
  connect(inverter.fire_p, pwm.fire_p) 
    annotation (Line(points={{-6,58},{-6,51}}, color={255,0,255}));
  connect(inverter.fire_n, pwm.fire_n) 
    annotation (Line(points={{6,58},{6,51}}, color={255,0,255}));
  connect(inverter.ac, machineCurrent.plug_p) 
    annotation (Line(points={{10,70},{30,70},{30,10}}, color={0,0,255}));
  connect(capacitor.p, inverter.dc_p) annotation (Line(points={{-30,80},{-20,80}, 
          {-20,76},{-10,76}}, color={0,0,255}));
  connect(capacitor.n, inverter.dc_n) annotation (Line(points={{-30,60},{-20,60}, 
          {-20,64},{-10,64}}, color={0,0,255}));
  connect(rectifier.dc_p, capacitor.p) annotation (Line(points={{-48,76},{-40,76}, 
          {-40,80},{-30,80}}, color={0,0,255}));
  connect(rectifier.dc_n, capacitor.n) annotation (Line(points={{-48,64},{-40,64}, 
          {-40,60},{-30,60}}, color={0,0,255}));
  connect(sineVoltage.plug_n, star.plug_p) 
    annotation (Line(points={{-80,-40},{-80,-50}},   color={0,0,255}));
  connect(star.pin_n, ground.p) 
    annotation (Line(points={{-80,-70},{-80,-80}}, color={0,0,255}));
  connect(resistor.plug_n, inductor.plug_p) 
    annotation (Line(points={{-80,40},{-80,50}},   color={0,0,255}));
  connect(inductor.plug_n, rectifier.ac) 
    annotation (Line(points={{-80,70},{-68,70}},  color={0,0,255}));
  connect(resistor.plug_p, gridCurrent.plug_p) 
    annotation (Line(points={{-80,20},{-80,10}}, color={0,0,255}));
  connect(gridCurrent.plug_n, sineVoltage.plug_p) 
    annotation (Line(points={{-80,-10},{-80,-20}}, color={0,0,255}));
  annotation (experiment(
      StopTime=1.5, 
      Interval=5e-05, 
      Tolerance=1e-06), Documentation(
        info="<html>
<p>
这是一个完整逆变器驱动的模型，包括：
</p>
<ul>
<li>一个网格模型和一个线圈电感</li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse\">一个二极管整流器</a></li>
<li>一个缓冲电容</li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Polyphase2Level\">一个开关逆变器</a></li>
<li><a href=\"modelica://Modelica.Electrical.PowerConverters.DCAC.Control.PWM\">一个脉宽调制</a></li>
<li><a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">一个电压/频率特性</a></li>
<li>参考频率逐渐增加</li>
<li>一个带松鼠笼的感应电机</li>
<li>一个负载惯性和二次速度相关负载扭矩(如风扇或泵)</li>
</ul>
<p>请注意：请耐心等待，两个开关设备会导致许多事件迭代，会降低性能。</p>
<p>由于电压降，机器的电压无法达到满电压，这意味着扭矩会减小。</p>
<p>默认机器参数适用于额定相电压400V和额定相电流25A。</p>
</html>"));
end IMC_InverterDrive;