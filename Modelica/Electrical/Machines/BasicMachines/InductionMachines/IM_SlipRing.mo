within Modelica.Electrical.Machines.BasicMachines.InductionMachines;
model IM_SlipRing "带滑环转子的感应电机"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    final idq_ss=airGap.i_ss, 
    final idq_sr=airGap.i_sr, 
    final idq_rs=airGap.i_rs, 
    final idq_rr=airGap.i_rr, 
    redeclare final Machines.Thermal.InductionMachines.ThermalAmbientIMS 
      thermalAmbient(final Tr=TrOperational, final mr=m), 
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMS 
      thermalPort(final mr=m), 
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMS 
      internalThermalPort(final mr=m), 
    redeclare final Machines.Interfaces.InductionMachines.PowerBalanceIMS 
      powerBalance(
      final lossPowerRotorWinding=sum(rr.resistor.LossPower), 
      final lossPowerRotorCore=rotorCore.lossPower, 
      final lossPowerBrush=0, 
      final powerRotor=Machines.SpacePhasors.Functions.activePower(vr, ir)), 
    statorCore(final w=statorCoreParameters.wRef));

  Machines.BasicMachines.Components.AirGapS airGap(
    final p=p, 
    final Lm=Lm, 
    final m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
          rotation=270)));
  parameter SI.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi 
        *fsNominal)) "每相定子主磁场电感" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lrsigma(start=3*(1 - sqrt(1 - 
        0.0667))/(2*pi*fsNominal)) 
    "每相转子侧的转子杂散电感" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lrzero=Lrsigma 
    "转子侧的转子零序电感" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance Rr(start=0.04) 
    "每相转子侧的转子阻抗" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrRef(start=293.15) 
    "转子阻抗的参考温度" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0) 
    "20摄氏度时转子阻抗的温度系数" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Boolean useTurnsRatio(start=true) 
    "使用匝数比还是根据空载转子电压计算？";
  parameter Real turnsRatio(final min=Modelica.Constants.small, start=1) 
    "有效的定子匝数与转子匝数的比值" 
    annotation (Dialog(enable=useTurnsRatio));
  parameter SI.Voltage VsNominal(start=100) 
    "每相定子的额定电压" 
    annotation (Dialog(enable=not useTurnsRatio));
  parameter SI.Voltage VrLockedRotor(start=100*(2*pi* 
        fsNominal*Lm)/sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2)) 
    "每相的锁定转子电压" 
    annotation (Dialog(enable=not useTurnsRatio));
  parameter SI.Temperature TrOperational(start=293.15) 
    "转子阻抗的工作温度" annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  parameter Machines.Losses.CoreParameters rotorCoreParameters(
    final m=3, 
    PRef=0, 
    VRef(start=1) = 1, 
    wRef(start=1) = 1) 
    "转子铁芯损耗参数记录；所有参数均参考转子侧" 
    annotation (Dialog(tab="Losses"));
  output SI.Current i_0_r(stateSelect=StateSelect.prefer)= 
       spacePhasorR.zero.i "转子零序电流";
  output SI.Voltage vr[m]=plug_rp.pin.v - plug_rn.pin.v 
    "转子瞬时电压";
  output SI.Current ir[m]=plug_rp.pin.i 
    "转子瞬时电流";
protected
  final parameter Real internalTurnsRatio=if useTurnsRatio then 
      turnsRatio else VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs 
      ^2 + (2*pi*fsNominal*(Lm + Lssigma))^2);
public
  Machines.SpacePhasors.Components.SpacePhasor spacePhasorR(final turnsRatio= 
        internalTurnsRatio) annotation (Placement(transformation(
        origin={-70,-50}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Modelica.Electrical.Polyphase.Basic.Resistor rr(
    final m=m, 
    final R=fill(Rr, m), 
    final T_ref=fill(TrRef, m), 
    final alpha=fill(Machines.Thermal.convertAlpha(alpha20r, TrRef), m), 
    final useHeatPort=true, 
    final T=fill(TrRef, m)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,40})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_rp(final m= 
        m) "转子正插头" annotation (Placement(transformation(
          extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_rn(final m= 
        m) "转子负插头" annotation (Placement(transformation(
          extent={{-110,-50},{-90,-70}})));
  Machines.BasicMachines.Components.Inductor lrsigma(final L=fill(
        internalTurnsRatio^2*Lrsigma, 2)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={20,-20})));
  Modelica.Electrical.Analog.Basic.Inductor lrzero(final L= 
        internalTurnsRatio^2*Lrzero) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=90, 
        origin={-50,-60})));
  Machines.Losses.InductionMachines.Core rotorCore(
    final coreParameters=rotorCoreParameters, 
    final w=rotorCoreParameters.wRef, 
    final useHeatPort=true, 
    final turnsRatio=internalTurnsRatio) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={0,-30})));


equation
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation (Line(
      points={{20,10},{10,10}}, color={0,0,255}));
  connect(lrsigma.spacePhasor_b, airGap.spacePhasor_r) annotation (Line(
      points={{20,-10},{10,-10}}, color={0,0,255}));
  connect(rr.plug_n, spacePhasorR.plug_p) annotation (Line(
      points={{-80,30},{-80,-40}}, color={0,0,255}));
  connect(spacePhasorR.plug_n, plug_rn) annotation (Line(
      points={{-80,-60},{-100,-60}}, color={0,0,255}));
  connect(spacePhasorR.zero, lrzero.p) annotation (Line(
      points={{-60,-50},{-50,-50}}, color={0,0,255}));
  connect(spacePhasorR.ground, lrzero.n) annotation (Line(
      points={{-60,-60},{-60,-70},{-50,-70}}, color={0,0,255}));
  connect(spacePhasorR.spacePhasor, lrsigma.spacePhasor_a) annotation (
      Line(
      points={{-60,-40},{-20,-40},{-20,-50},{20,-50},{20,-30}}, color={0,0,255}));
  connect(rotorCore.spacePhasor, lrsigma.spacePhasor_a) annotation (Line(
      points={{10,-30},{20,-30}}, color={0,0,255}));
  connect(rotorCore.heatPort, internalThermalPort.heatPortRotorCore) 
    annotation (Line(
      points={{10,-40},{0.4,-40},{0.4,-80.8}}, color={191,0,0}));
  connect(rr.heatPort, internalThermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{-70,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  connect(plug_rp, rr.plug_p) annotation (Line(
      points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0}}));
  connect(fixed.flange, internalSupport) annotation (Line(
      points={{50,-100},{60,-100}}));
  connect(internalSupport, airGap.support) annotation (Line(
      points={{60,-100},{60,-90},{-40,-90},{-40,0},{-10,0}}));
  annotation (
    defaultComponentName="ims", 
    Documentation(info="<html>
<p><strong>带滑环转子的三相感应电机模型。</strong><br>
定子和转子的电阻和杂散电感直接建模在定子和转子相位中，然后使用空间矢量变换和一个定子固定的<em>AirGap</em>模型。该电机模型考虑以下损耗效应：
</p>

<ul>
<li>温度相关的定子绕组电阻的热损耗</li>
<li>温度相关的转子绕组电阻的热损耗</li>
<li>摩擦损耗</li>
<li>铁芯损耗(仅涡流损耗，没有磁滞损耗)</li>
<li>杂散负载损耗</li>
</ul>


<p><strong>机器参数的默认值(一个现实示例)为：</strong><br></p>
<table>
<tr>
<td>极对数 p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>定子惯性矩</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>转子惯性矩</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>额定频率 fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>每相额定电压</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>每相额定电流</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>额定扭矩</td>
<td>161.4</td><td>Nm</td>
</tr>
<tr>
<td>额定转速</td>
<td>1440.45</td><td>rpm</td>
</tr>
<tr>
<td>额定机械输出</td>
<td>24.346</td><td>kW</td>
</tr>
<tr>
<td>效率</td>
<td>92.7</td><td>%</td>
</tr>
<tr>
<td>功率因数</td>
<td>0.875</td><td> </td>
</tr>
<tr>
<td>定子电阻</td>
<td>0.03</td><td>参考温度下的每相欧姆</td>
</tr>
<tr>
<td>参考温度 TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>温度系数 alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>转子电阻</td>
<td>0.04</td><td>参考温度下的每相欧姆</td>
</tr>
<tr>
<td>参考温度 TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>温度系数 alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>定子电抗 Xs</td>
<td>3</td><td>每相欧姆</td>
</tr>
<tr>
<td>转子电抗 Xr</td>
<td>3</td><td>每相欧姆</td>
</tr>
<tr>
<td>总杂散系数 sigma</td>
<td>0.0667</td><td> </td>
</tr>
<tr>
<td>匝比</td>
<td>1</td><td>定子和转子电流的有效比率</td>
</tr>
<tr>
<td>定子工作温度 TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>转子工作温度 TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>这些值给出以下电感：</td>
<td> </td><td> </td>
</tr>
<tr>
<td>定子每相杂散电感</td>
<td>Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>转子杂散电感</td>
<td>Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>每相主场电感</td>
<td>sqrt(Xs*Xr * (1-sigma))/(2*pi*f)</td><td> </td>
</tr>
</table>
<p>
参数turnsRatio可以从以下关系式中得到，
在静止状态下，开路转子电路，额定电压和额定频率，<br>
使用锁转电压VR，空载定子电流I0和功率因数PF0：<br>
turnsRatio*<u>V</u><sub>R</sub>=<u>V</u><sub>s</sub>-(R<sub>s</sub>+jX<sub>s,sigma</sub>)<u>I</u><sub>0</sub>
</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{-100,50},{-100,20},{-60, 
              20}}, color={0,0,255}), Line(points={{-100,-50},{-100,-20}, 
              {-60,-20}}, color={0,0,255})}));
end IM_SlipRing;