within Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines;
model SM_PermanentMagnet 
  "带可选阻尼笼的永磁同步电机"
  extends Magnetic.FundamentalWave.BaseClasses.Machine(
    is(start=zeros(m)), 
    Rs(start=0.03), 
    Lssigma(start=0.1/(2*pi*fsNominal)), 
    final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/ 
          effectiveStatorTurns^2), 
    redeclare final
      Modelica.Electrical.Machines.Thermal.SynchronousMachines.ThermalAmbientSMPM 
      thermalAmbient(
      final useDamperCage=useDamperCage, 
      final Tr=TrOperational, 
      final Tpm=TpmOperational), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMPM 
      thermalPort(final useDamperCage=useDamperCage), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMPM 
      internalThermalPort(final useDamperCage=useDamperCage), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMPM 
      powerBalance(
      final lossPowerRotorWinding=damperCageLossPower, 
      final lossPowerRotorCore=0, 
      final lossPowerPermanentMagnet=permanentMagnet.lossPower));
  // 主要字段参数
  parameter SI.Inductance Lmd(start=0.3/(2*pi*fsNominal)) 
    "定子主磁场电感, d-axis" annotation (Dialog(tab= 
          "Nominal resistances and inductances", groupImage= 
          "modelica://Modelica/Resources/Images/Electrical/Machines/SMPM.png"));
  parameter SI.Inductance Lmq(start=0.3/(2*pi*fsNominal)) 
    "定子主磁场电感, q-axis" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  // 转子笼参数
  parameter Boolean useDamperCage(start=true) 
    "启用/禁用阻尼笼" annotation (Dialog(tab= 
          "Nominal resistances and inductances", group="Damper cage"));
  parameter SI.Inductance Lrsigmad(start=0.05/(2*pi* 
        fsNominal)) 
    "转子漏感，d 轴，相对于定子侧" annotation (
      Dialog(
      tab="Nominal resistances and inductances", 
      group="Damper cage", 
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad 
    "转子漏感，q 轴，相对于定子侧" annotation (
      Dialog(
      tab="Nominal resistances and inductances", 
      group="Damper cage", 
      enable=useDamperCage));
  parameter SI.Resistance Rrd(start=0.04) 
    "转子电阻，d 轴，相对于定子侧" annotation (Dialog(
      tab="Nominal resistances and inductances", 
      group="Damper cage", 
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd 
    "转子电阻，q 轴，相对于定子侧" annotation (Dialog(
      tab="Nominal resistances and inductances", 
      group="Damper cage", 
      enable=useDamperCage));
  parameter SI.Temperature TrRef(start=293.15) 
    "阻尼器 d 轴和 q 轴电阻的参考温度" 
    annotation (Dialog(
      tab="Nominal resistances and inductances", 
      group="Damper cage", 
      enable=useDamperCage));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20r(start=0) 
    "d 轴和 q 轴阻尼器电阻的温度系数" 
    annotation (Dialog(
      tab="Nominal resistances and inductances", 
      group="Damper cage", 
      enable=useDamperCage));
  // 运行参数
  final parameter SI.Temperature TpmOperational=293.15 
    "永磁体的工作温度" 
    annotation (Dialog(group="Operational temperatures"));
  parameter SI.Temperature TrOperational(start=293.15) 
    "风门架（可选）的工作温度" annotation (
      Dialog(group="Operational temperatures", enable=not useThermalPort 
           and useDamperCage));
  // 永磁参数
  parameter SI.Voltage VsOpenCircuit(start=112.3) 
    "每相开路有效值电压 @ fsNominal";
  parameter
    Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters 
    permanentMagnetLossParameters(IRef(start=100), wRef(start=2*pi* 
          fsNominal/p)) "Permanent magnet loss parameter record" 
    annotation (Dialog(tab="Losses"));
  // 转子笼部件
  Modelica.Blocks.Interfaces.RealOutput ir[2](
    start=zeros(2), 
    each final quantity="ElectricCurrent", 
    each final unit="A") if useDamperCage "Damper cage currents" 
    annotation (Placement(visible=false),Dialog(showStartAttribute=true));
  Magnetic.FundamentalWave.Components.Short short if not useDamperCage 
    "在没有阻尼笼的情况下进行磁连接" annotation (
      Placement(transformation(
        origin={10,-40}, 
        extent={{10,10},{-10,-10}}, 
        rotation=270)));
  Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding rotorCage(
    final RRef(d=Rrd, q=Rrq), 
    final Lsigma(d=Lrsigmad, q=Lrsigmaq), 
    final effectiveTurns=sqrt(3.0/2.0)*effectiveStatorTurns, 
    final useHeatPort=true, 
    final TRef=TrRef, 
    final alpha20=alpha20r, 
    final TOperational=TrOperational) if useDamperCage 
    "对称转子笼形绕组，包括电阻和杂散电感" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={30,-40})));
  // 永磁组件
  Components.PermanentMagnet permanentMagnet(
    final V_m=Complex(V_mPM, 0), 
    final m=m, 
    final permanentMagnetLossParameters=permanentMagnetLossParameters, 
    final useHeatPort=true, 
    final is=is) "Magnetic potential difference of permanent magnet" 
    annotation (Placement(transformation(
        origin={-10,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
protected
  final parameter SI.MagneticPotentialDifference V_mPM=(2/ 
      pi)*sqrt(2)*(m/2)*VsOpenCircuit/effectiveStatorTurns/(Lmd/ 
      effectiveStatorTurns^2*2*pi*fsNominal) 
    "等效激磁磁势差";
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "Damper losses";
equation
  connect(ir, rotorCage.i);
  connect(damperCageLossPower, rotorCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(permanentMagnet.port_p, airGap.port_rn) annotation (Line(
      points={{-10,-30},{-10,-10}}, color={255,128,0}));
  connect(permanentMagnet.support, airGap.support) annotation (Line(
      points={{-20,-40},{-50,-40},{-50,0},{-10,0}}));
  connect(permanentMagnet.heatPort, internalThermalPort.heatPortPermanentMagnet) 
    annotation (Line(
      points={{-20,-30},{-40,-30},{-40,-90}}, color={191,0,0}));
  connect(permanentMagnet.flange, inertiaRotor.flange_b) annotation (Line(
      points={{0,-40},{0,-20},{90,-20},{90,0}}));
  connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
      points={{10,-10},{10,-30},{30,-30}},                                     color={255,128,0}));

  connect(short.port_n, airGap.port_rp) annotation (Line(
      points={{10,-30},{10,-10}}, color={255,128,0}));
  connect(short.port_p, permanentMagnet.port_n) annotation (Line(
      points={{10,-50},{-10,-50}}, color={255,128,0}));
  connect(rotorCage.port_p, permanentMagnet.port_n) annotation (Line(
      points={{30,-50},{-10,-50}}, color={255,128,0}));
  connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{40,-40},{40,-80},{-40,-80},{-40,-90}},          color={191,0,0}));
  annotation (
    defaultComponentName="smpm", 
    Icon(graphics={
        Rectangle(
          extent={{-130,10},{-100,-10}}, 
          fillColor={0,255,0}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-100,10},{-70,-10}}, 
          fillColor={255,0,0}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}), 
    Documentation(info="<html>
<p>
机器的电阻和杂散电感指的是 <code>m</code> 相定子。假设定子对称。转子的不对称可通过 d 轴和 q 轴上不同的电阻和杂散电感加以考虑。机器模型考虑了以下损耗效应:
</p>

<ul>
<li>定子绕组电阻随温度变化的热损耗</li>
<li>可选项，启用时：与温度有关的风门保持架电阻中的热损失</li>
<li>摩擦损失</li>
<li>磁芯损耗（只有涡流损耗，没有磁滞损耗）</li>
<li>杂散负载损耗</li>
<li>永磁损耗</li>
</ul>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">SM_ReluctanceRotor</a>,
</p>
</html>"));
end SM_PermanentMagnet;