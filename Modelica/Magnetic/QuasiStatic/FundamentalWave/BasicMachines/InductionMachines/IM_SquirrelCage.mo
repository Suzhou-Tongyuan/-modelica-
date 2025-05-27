within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines;
model IM_SquirrelCage "鼠笼式感应电机"
  // 从基本波浪模型的扩展中移除： is(start=zeros(m)) ##
  extends BaseClasses.Machine(
    Rs(start=0.03), 
    Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)), 
    final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/ 
          effectiveStatorTurns^2), 
    redeclare final
      Modelica.Electrical.Machines.Thermal.InductionMachines.ThermalAmbientIMC 
      thermalAmbient(final Tr=TrOperational), 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortIMC 
      thermalPort, 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortIMC 
      internalThermalPort, 
    redeclare final
      Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceIMC 
      powerBalance(final lossPowerRotorWinding=sum(rotorCage.resistor.resistor.LossPower), 
        final lossPowerRotorCore=0));
  parameter SI.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi 
        *fsNominal)) "Stator main field inductance per phase" annotation (
     Dialog(tab="Nominal resistances and inductances", groupImage= 
          "modelica://Modelica/Resources/Images/Electrical/Machines/IMC.png"));
  parameter SI.Inductance Lrsigma(start=3*(1 - sqrt(1 - 
        0.0667))/(2*pi*fsNominal)) 
    "定子侧等效 m 相绕组的转子漏感" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance Rr(start=0.04) 
    "定子侧等效 m 相绕组的转子电阻" 
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
  output SI.ComplexCurrent ir[m]=rotorCage.i 
    "转子电流";
  SI.Current abs_ir[m]=Modelica.ComplexMath.abs(ir) 
    "复转子电流幅度";
  SI.Angle arg_ir[m]=Modelica.ComplexMath.arg(ir) 
    "复转子电流参数";

  Components.SymmetricPolyphaseCageWinding rotorCage(
    final Lsigma=Lrsigma, 
    final effectiveTurns=effectiveStatorTurns, 
    final useHeatPort=true, 
    final RRef=Rr, 
    final TRef=TrRef, 
    final TOperational=TrRef, 
    final m=m, 
    final alpha20=alpha20r) 
    "对称转子笼形绕组，包括电阻和杂散电感" 
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
equation
  connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{0,-40},{-40,-40},{-40,-90}}, color={191,0,0}));
  connect(airGap.port_rn, rotorCage.port_p) annotation (Line(
      points={{-10,-10},{-10,-30}}, color={255,170,85}));
  connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
      points={{10,-10},{10,-30}}, color={255,170,85}));
  annotation (
    defaultComponentName="imc", 
    Documentation(info="<html>
<p>
机器的电阻和杂散电感指的是 <code>m</code> 相定子。假设定子、转子和电源对称。机器模型考虑了以下损耗效应:
</p>

<ul>
<li>定子绕组电阻随温度变化的热损耗</li>
<li>与温度有关的笼形电阻的热损失</li>
<li>摩擦损失</li>
<li>磁芯损耗（只有涡流损耗，没有磁滞损耗）</li>
<li>杂散负载损耗</li>
</ul>

<h4>另见</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">
IM_SlipRing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing\">
Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SlipRing</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage\">
Magnetic.FundamentalWave.BasicMachines.InductionMachines.IM_SquirrelCage</a>,
</p>
</html>"));
end IM_SquirrelCage;