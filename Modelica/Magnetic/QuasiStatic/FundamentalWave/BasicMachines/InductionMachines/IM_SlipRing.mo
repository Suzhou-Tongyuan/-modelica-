within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines;
model IM_SlipRing "带滑环转子的感应电机"
  parameter Integer mr(min=3) = m "转子相数" annotation(Evaluate=true);
  extends BaseClasses.Machine(
    Rs(start=0.03), 
    Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)), 
    final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/ 
          effectiveStatorTurns^2), 
    redeclare final
      Modelica.Electrical.Machines.Thermal.InductionMachines.ThermalAmbientIMS 
      thermalAmbient(final Tr=TrOperational, final mr=mr), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortIMS 
      thermalPort(final mr=mr), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortIMS 
      internalThermalPort(final mr=mr), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceIMS 
      powerBalance(
      final lossPowerRotorWinding=sum(rotor.resistor.resistor.LossPower), 
      final lossPowerRotorCore=rotor.core.lossPower, 
      final lossPowerBrush=0, 
      final powerRotor= 
          Modelica.Electrical.QuasiStatic.Polyphase.Functions.activePower(
                                                                 vr, 
          ir)));

  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug 
    plug_rn(final m=mr) "转子负极插头" annotation (Placement(
        transformation(extent={{-110,-50},{-90,-70}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug 
    plug_rp(final m=mr) "转子正塞" annotation (Placement(
        transformation(extent={{-110,70},{-90,50}})));
  parameter SI.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi 
        *fsNominal)) "Stator main field inductance per phase" annotation (
     Dialog(tab="Nominal resistances and inductances", groupImage= 
          "modelica://Modelica/Resources/Images/Electrical/Machines/IMS.png"));
  parameter SI.Inductance Lrsigma(start=3*(1 - sqrt(1 - 
        0.0667))/(2*pi*fsNominal)) 
    "每相转子漏感（相对于转子侧）" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance Rr(start=0.04) 
    "转子每相电阻（相对于转子侧" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrRef(start=293.15) 
    "转子电阻参考温度" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20r(start=0) 
    "20 摄氏度时转子电阻的温度系数" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrOperational(start=293.15) 
    "转子电阻的工作温度" annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  parameter Boolean useTurnsRatio(start=true) 
    "使用匝数比还是根据锁定转子电压计算？";
  parameter Real TurnsRatio(final min=Modelica.Constants.small, start=1) 
    "定子有效匝数/转子有效匝数" 
    annotation (Dialog(enable=useTurnsRatio));
  parameter SI.Voltage VsNominal(start=100) 
    "每相额定定子电压" 
    annotation (Dialog(enable=not useTurnsRatio));
  parameter SI.Voltage VrLockedRotor(start=100*(2*pi* 
        fsNominal*Lm)/sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2)) 
    "每相锁定转子电压" 
    annotation (Dialog(enable=not useTurnsRatio));
  parameter Modelica.Electrical.Machines.Losses.CoreParameters 
    rotorCoreParameters(
    final m=3, 
    PRef=0, 
    VRef(start=1) = 1, 
    wRef(start=1) = 1) 
    "转子铁芯损耗参数记录，所有量均指转子侧" 
    annotation (Dialog(tab="Losses"));
  output SI.ComplexVoltage vr[mr]=plug_rp.pin.v - plug_rn.pin.v 
    "复转子电压";
  SI.Voltage abs_vr[mr]=Modelica.ComplexMath.abs(vr) 
    "复转子电压幅度";
  SI.Angle arg_vr[mr]=Modelica.ComplexMath.arg(vr) 
    "复转子电压参数";

  output SI.ComplexCurrent ir[mr]=plug_rp.pin.i 
    "复杂转子电流";
  SI.Current abs_ir[mr]=Modelica.ComplexMath.abs(ir) 
    "复转子电流幅度";
  SI.Angle arg_ir[mr]=Modelica.ComplexMath.arg(ir) 
    "复转子电流参数";

  SI.ActivePower Pr[mr]={Modelica.ComplexMath.real(vr[k]* 
      Modelica.ComplexMath.conj(ir[k])) for k in 1:mr} 
    "有功转子功率";
  SI.ActivePower Pr_total=sum(Pr) 
    "有功转子总功率";
  SI.ReactivePower Qr[mr]={Modelica.ComplexMath.imag(vr[k]* 
      Modelica.ComplexMath.conj(ir[k])) for k in 1:mr} 
    "无功转子功率";
  SI.ReactivePower Qr_total=sum(Qr) 
    "转子总无功功率";
  SI.ApparentPower Sr[mr]={Modelica.ComplexMath.abs(vr[k] 
      *Modelica.ComplexMath.conj(ir[k])) for k in 1:mr} 
    "复杂转子视在功率的大小";
  SI.ApparentPower Sr_total=sqrt(Pr_total^2 + Qr_total^2) 
    "复杂转子总视在功率的大小";
  Real pfr[m]={cos(Modelica.ComplexMath.arg(Complex(Pr[k], Qr[k]))) for k in 
          1:m} "转子功率因数";

protected
  final parameter Real internalTurnsRatio=if useTurnsRatio then 
      TurnsRatio else VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs 
      ^2 + (2*pi*fsNominal*(Lm + Lssigma))^2);
public
  Components.SymmetricPolyphaseWinding rotor(
    final Lsigma=Lrsigma, 
    final effectiveTurns=effectiveStatorTurns/internalTurnsRatio, 
    final useHeatPort=true, 
    final RRef=Rr, 
    final TRef=TrRef, 
    final TOperational=TrOperational, 
    final GcRef=rotorCoreParameters.GcRef, 
    final m=mr, 
    final alpha20=alpha20r) 
    "对称转子绕组，包括电阻、零电感和杂散电感以及零磁芯损耗" 
    annotation (Placement(transformation(
        origin={0,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
equation
  connect(rotor.plug_n, plug_rn) annotation (Line(points={{10,-50},{10,-60}, 
          {-100,-60}}, color={85,170,255}));
  connect(rotor.heatPortCore, internalThermalPort.heatPortRotorCore) 
    annotation (Line(
      points={{10,-36},{20,-36},{20,-80},{-39.6,-80},{-39.6,-90.8}}, color={191,0,0}));
  connect(rotor.heatPortWinding, internalThermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{10,-44},{20,-44},{20,-80},{-40,-80},{-40,-90}}, color={191,0,0}));
  connect(plug_rp, rotor.plug_p) annotation (Line(
      points={{-100,60},{-80,60},{-80,-50},{-10,-50}}, color={85,170,255}));
  connect(airGap.port_rn, rotor.port_p) annotation (Line(
      points={{-10,-10},{-10,-30}}, color={255,170,85}));
  connect(airGap.port_rp, rotor.port_n) annotation (Line(
      points={{10,-10},{10,-30}}, color={255,170,85}));
  annotation (
    defaultComponentName="ims", 
    Icon(graphics={Line(points={{-100,50},{-100,20},{-60,20}}, color={85,170,255}), 
               Line(points={{-100,-50},{-100,-20},{-60,-20}}, 
            color={85,170,255})}), 
    Documentation(info="<html>
<p>
机器的电阻和杂散电感总是指定子或转子。假设定子、转子和电源对称。定子和转子的相数可能不同。机器模型考虑了以下损耗效应:
</p>

<ul>
<li>定子绕组电阻随温度变化的热损耗</li>
<li>转子绕组电阻随温度变化的热损失</li>
<li>摩擦损失</li>
<li>定子和转子铁芯损耗（只有涡流损耗，没有磁滞损耗）</li>
<li>杂散负载损耗</li>
</ul>

<h4>另外</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">
IM_SquirrelCage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">
Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">
Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage</a>,
</p>
</html>"));
end IM_SlipRing;