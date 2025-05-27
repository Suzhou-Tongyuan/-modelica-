within Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines;
model SM_ElectricalExcited 
  "带可选阻尼笼的电励磁同步电机"
  extends Magnetic.FundamentalWave.BaseClasses.Machine(
    is(start=zeros(m)), 
    Rs(start=0.03), 
    Lssigma(start=0.1/(2*pi*fsNominal)), 
    final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/ 
          effectiveStatorTurns^2), 
    redeclare final
      Modelica.Electrical.Machines.Thermal.SynchronousMachines.ThermalAmbientSMEE 
      thermalAmbient(
      final useDamperCage=useDamperCage, 
      final Te=TeOperational, 
      final Tr=TrOperational), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMEE 
      thermalPort(final useDamperCage=useDamperCage), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMEE 
      internalThermalPort(final useDamperCage=useDamperCage), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMEE 
      powerBalance(
      final lossPowerRotorWinding=damperCageLossPower, 
      final powerExcitation=ve*ie, 
      final lossPowerExcitation=excitation.resistor.LossPower, 
      final lossPowerBrush=brush.lossPower, 
      final lossPowerRotorCore=0));
  // 主要字段参数
  parameter SI.Inductance Lmd(start=1.5/(2*pi*fsNominal)) 
    "定子主磁场电感，d 轴" annotation (Dialog(tab= 
          "Nominal resistances and inductances", groupImage= 
          "modelica://Modelica/Resources/Images/Electrical/Machines/SMEE.png"));
  parameter SI.Inductance Lmq(start=1.5/(2*pi*fsNominal)) 
    "定子主磁场电感，q 轴" 
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
  // 运行温度
  parameter SI.Temperature TrOperational(start=293.15) 
    "风门架（可选）的工作温度" annotation (
      Dialog(group="Operational temperatures", enable=not useThermalPort 
           and useDamperCage));
  parameter SI.Temperature TeOperational(start=293.15) 
    "工作激励温度" annotation (Dialog(group= 
          "Operational temperatures", enable=not useThermalPort));
  // 激励参数
  parameter SI.Voltage VsNominal(start=100) 
    "额定定子电压" annotation (Dialog(tab="Excitation"));
  parameter SI.Current IeOpenCircuit(start=10) 
    "额定电压和频率下的开路励磁电流" 
    annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Re(start=2.5) 
    "热激电阻" annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef(start=293.15) 
    "激励电阻的参考温度" 
    annotation (Dialog(tab="Excitation"));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20e(start=0) "激励电阻的温度系数" 
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0, 
    max=1, 
    start=0.025) "Stray fraction of total excitation inductance" 
    annotation (Dialog(tab="Excitation"));
  parameter Modelica.Electrical.Machines.Losses.BrushParameters 
    brushParameters "电刷损耗参数记录" 
    annotation (Dialog(tab="Losses"));
  output SI.Voltage ve=pin_ep.v - pin_en.v 
    "激励电压";
  output SI.Current ie=pin_ep.i "激励电流";
  // 转子笼部件
  Modelica.Blocks.Interfaces.RealOutput ir[2](
    start=zeros(2), 
    each final quantity="ElectricCurrent", 
    each final unit="A") if useDamperCage "Damper cage currents" 
    annotation (Placement(visible=false),Dialog(showStartAttribute=true));
  Modelica.Blocks.Interfaces.RealOutput irRMS(
    final quantity="ElectricCurrent", 
    final unit="A") if useDamperCage "Damper cage RMS current" 
    annotation (Placement(visible=false));
  FundamentalWave.Components.Short short if not useDamperCage 
    "在没有阻尼笼的情况下进行磁连接" 
    annotation (Placement(transformation(
        origin={10,-40}, 
        extent={{10,10},{-10,-10}}, 
        rotation=270)));
  Components.SaliencyCageWinding rotorCage(
    final Lsigma(d=Lrsigmad, q=Lrsigmaq), 
    final effectiveTurns=sqrt(3.0/2.0)*effectiveStatorTurns, 
    final useHeatPort=true, 
    final TRef=TrRef, 
    final TOperational=TrOperational, 
    final RRef(d=Rrd, q=Rrq), 
    final alpha20=alpha20r) if useDamperCage 
    "对称转子笼形绕组，包括电阻和杂散电感" 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={30,-40})));
  // 激励元件
  Components.SinglePhaseWinding excitation(
    final orientation=0, 
    final RRef=Re, 
    final TRef=TeRef, 
    final Lsigma=Lesigma, 
    final effectiveTurns=effectiveStatorTurns*turnsRatio*m/2, 
    final useHeatPort=true, 
    final TOperational=TeOperational, 
    final alpha20=alpha20e) 
    "励磁绕组，包括电阻和杂散电感" 
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
    "激励正针" annotation (Placement(transformation(
          extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
    "激励负针" annotation (Placement(transformation(
          extent={{-90,-50},{-110,-70}})));
  Modelica.Electrical.Machines.Losses.DCMachines.Brush brush(final
      brushParameters=brushParameters, final useHeatPort=true) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,40})));
protected
  final parameter Real turnsRatio=sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd* 
      IeOpenCircuit) "Stator current / excitation current";
  final parameter SI.Inductance Lesigma=Lmd*turnsRatio^2*3/ 
      2*sigmae/(1 - sigmae) 
    "励磁绕组的漏感";
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "Damper losses";
equation
  connect(ir, rotorCage.i);
  connect(irRMS, rotorCage.iRMS);
  connect(damperCageLossPower, rotorCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(pin_en, excitation.pin_n) annotation (Line(points={{-100,-60},{
          -100,-60},{-100,-50},{-30,-50}}, color={0,0,255}));
  connect(airGap.port_rn, excitation.port_p) annotation (Line(
      points={{-10,-10},{-10,-20},{-10,-20},{-10,-30}}, color={255,128,0}));
  connect(pin_ep, brush.p) annotation (Line(
      points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
  connect(brush.n, excitation.pin_p) annotation (Line(
      points={{-80,30},{-80,-30},{-30,-30}}, color={0,0,255}));
  connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
      Line(
      points={{-70,50},{-40,50},{-40,-90}}, color={191,0,0}));
  connect(excitation.heatPortWinding, internalThermalPort.heatPortExcitation) 
    annotation (Line(
      points={{-20,-50},{-20,-80},{-40,-80},{-40,-90}}, color={191,0,0}));
  connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
      points={{10,-10},{10,-30},{30,-30}}, color={255,128,0}));
  connect(short.port_n, airGap.port_rp) annotation (Line(
      points={{10,-30},{10,-10}}, color={255,128,0}));
  connect(rotorCage.port_p, excitation.port_n) annotation (Line(
      points={{30,-50},{-10,-50}}, color={255,128,0}));
  connect(short.port_p, excitation.port_n) annotation (Line(
      points={{10,-50},{-10,-50}}, color={255,128,0}));
  connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{40,-40},{40,-80},{-40,-80},{-40,-90}},          color={191,0,0}));
  annotation (
    defaultComponentName="smee", 
    Icon(graphics={
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255}), 
        Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,255}), 
        Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111, 
              1},{-110,-4}}, color={0,0,255}), 
        Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1}, 
              {-90,-4}}, color={0,0,255}), 
        Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70, 
              -4}}, color={0,0,255}), 
        Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0, 
              0,255})}), 
    Documentation(info="<html>
<p>
假设定子对称。转子的不对称可通过 d 轴和 q 轴上的不同电阻和杂散电感加以考虑。机器模型考虑了以下损耗效应:
</p>

<ul>
<li>定子绕组电阻随温度变化的热损耗</li>
<li>与温度有关的励磁绕组电阻热损耗</li>
<li>可选项，启用时：与温度有关的风门保持架电阻中的热损失</li>
<li>励磁回路中的电刷损耗</li>
<li>摩擦损失</li>
<li>磁芯损耗（只有涡流损耗，没有磁滞损耗）</li>
<li>杂散负载损耗</li>
</ul>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousMachines.SM_ReluctanceRotor\">SM_ReluctanceRotor</a>,
</p>
</html>"));
end SM_ElectricalExcited;