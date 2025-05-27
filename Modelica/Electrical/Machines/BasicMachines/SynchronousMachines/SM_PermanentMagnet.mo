within Modelica.Electrical.Machines.BasicMachines.SynchronousMachines;
model SM_PermanentMagnet "永磁同步电机"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    Lssigma(start=0.1/(2*pi*fsNominal)), 
    final idq_ss=airGap.i_ss, 
    final idq_sr=airGap.i_sr, 
    final idq_rs=airGap.i_rs, 
    final idq_rr=airGap.i_rr, 
    redeclare final Machines.Thermal.SynchronousMachines.ThermalAmbientSMPM 
      thermalAmbient(
      final useDamperCage=useDamperCage, 
      final Tr=TrOperational, 
      final Tpm=TpmOperational), 
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM 
      thermalPort(final useDamperCage=useDamperCage), 
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMPM 
      internalThermalPort(final useDamperCage=useDamperCage), 
    redeclare final Machines.Interfaces.InductionMachines.PowerBalanceSMPM 
      powerBalance(
      final lossPowerRotorWinding=damperCageLossPower, 
      final lossPowerRotorCore=0, 
      final lossPowerPermanentMagnet=permanentMagnet.lossPower), 
    statorCore(final w=statorCoreParameters.wRef));
  Modelica.Blocks.Interfaces.RealOutput ir[2](
    start=zeros(2), 
    each final quantity="ElectricCurrent", 
    each final unit="A") if useDamperCage "阻尼笼电流" 
    annotation (Placement(visible=false),Dialog(showStartAttribute=true));
  Modelica.Blocks.Interfaces.RealOutput idq_dr[2](
    each stateSelect=StateSelect.prefer, 
    each final quantity="ElectricCurrent", 
    each final unit="A") if useDamperCage 
    "阻尼空间矢量电流 / 转子固定坐标系" 
    annotation (Placement(visible=false));
  Machines.BasicMachines.Components.AirGapR airGap(
    final p=p, 
    final Lmd=Lmd, 
    final Lmq=Lmq, 
    final m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
          rotation=270)));
  final parameter SI.Temperature TpmOperational=293.15 
    "永磁体的运行温度" 
    annotation (Dialog(group="操作温度"));
  parameter SI.Temperature TrOperational(start=293.15) 
    "（可选）阻尼笼的运行温度" annotation (
      Dialog(group="操作温度", enable=not useThermalPort 
           and useDamperCage));
  parameter SI.Voltage VsOpenCircuit(start=112.3) 
    "空载时每相的有效值电压 @ fsNominal";
  parameter SI.Inductance Lmd(start=0.3/(2*pi*fsNominal)) 
    "d轴的每相定子主场电感" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter SI.Inductance Lmq(start=0.3/(2*pi*fsNominal)) 
    "q轴的每相定子主场电感" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter Boolean useDamperCage(start=true) 
    "启用/禁用阻尼笼" annotation (Evaluate=true, Dialog(tab= 
          "额定电阻和电感", group="阻尼笼"));
  parameter SI.Inductance Lrsigmad(start=0.05/(2*pi* 
        fsNominal)) "d轴的阻尼漏感" annotation (
      Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad 
    "q轴的阻尼漏感" annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Resistance Rrd(start=0.04) 
    "TRef时d轴的阻尼电阻" annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd 
    "TRef时q轴的阻尼电阻" annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Temperature TrRef(start=293.15) 
    "d-和q-轴阻尼电阻的参考温度" 
    annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0) 
    "d-和q-轴阻尼电阻的温度系数" 
    annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters(IRef(
        start=100), wRef(start=2*pi*fsNominal/p)) 
    "永磁体损耗参数记录" annotation (Dialog(tab="损耗"));
  Components.PermanentMagnetWithLosses permanentMagnet(
    final Ie=Ie, 
    final useHeatPort=true, 
    final m=m, 
    final permanentMagnetLossParameters=permanentMagnetLossParameters, 
    final is=is) annotation (Placement(transformation(
        origin={30,-30}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Machines.BasicMachines.Components.DamperCage damperCage(
    final Lrsigmad=Lrsigmad, 
    final Lrsigmaq=Lrsigmaq, 
    final Rrd=Rrd, 
    final Rrq=Rrq, 
    final T_ref=TrRef, 
    final alpha=Machines.Thermal.convertAlpha(alpha20r, TrRef), 
    final useHeatPort=true) if useDamperCage annotation (Placement(
        transformation(
        origin={0,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
protected
  final parameter SI.Current Ie=sqrt(2)*VsOpenCircuit/(Lmd* 
      2*pi*fsNominal) "等效励磁电流";
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "阻尼损耗";
equation
  connect(ir, damperCage.i);
  connect(idq_dr, damperCage.i);
  connect(damperCageLossPower, damperCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(airGap.spacePhasor_r, damperCage.spacePhasor_r) 
    annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
  connect(airGap.spacePhasor_r, permanentMagnet.spacePhasor_r) 
    annotation (Line(points={{10,-10},{10,-20},{20,-20}}, color={0,0,255}));
  connect(airGap.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation (Line(
      points={{20,10},{10,10}}, color={0,0,255}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0}}));
  connect(permanentMagnet.heatPort, internalThermalPort.heatPortPermanentMagnet) 
    annotation (Line(
      points={{20,-40},{20,-80},{0,-80}}, color={191,0,0}));
  connect(permanentMagnet.flange, inertiaRotor.flange_b) annotation (Line(
      points={{30,-20},{90,-20},{90,0}}));
  connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{-10,-40},{-10,-80},{0,-80},{0,-80}}, color={191,0,0}));
  connect(internalSupport, permanentMagnet.support) annotation (Line(
      points={{60,-100},{60,-100},{60,-90},{30,-90},{30,-40},{30,-40}}));
  annotation (
    defaultComponentName="smpm", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
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
<p><strong>三相永磁同步机模型。</strong><br>
定子的电阻和漏感直接建模在定子相中，然后使用空间矢量变换和一个转子固定的<em>AirGap</em>模型。 转子鼠笼的电阻和漏感在转子固定坐标系的两个轴上建模。永磁体励磁由恒定的等效励磁电流模拟，供给d轴。 机器模型考虑以下损耗效应：
</p>

<ul>
<li>温度依赖的定子绕组电阻的热损耗</li>
<li>可选的，当启用时：温度依赖的阻尼笼电阻的热损耗</li>
<li>摩擦损失</li>
<li>铁芯损耗(仅涡流损耗，无滞后损耗)</li>
<li>漏损</li>
<li>永磁体损耗</li>
</ul>

<p>是否存在阻尼笼可以通过布尔参数useDamperCage进行选择(默认值为true)。
<br><strong>机器参数的默认值(一个实际的例子)如下：</strong><br></p>
<table>
<tr>
<td>极对数p</td>
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
<td>额定频率fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>每相的额定电压</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>空载时每相的电压</td>
<td>112.3</td><td>V RMS @ 额定转速</td>
</tr>
<tr>
<td>每相的额定电流</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>额定转矩</td>
<td>181.4</td><td>Nm</td>
</tr>
<tr>
<td>额定转速</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>额定机械输出</td>
<td>28.5</td><td>kW</td>
</tr>
<tr>
<td>额定转子角度</td>
<td>20.75</td><td>度</td>
</tr>
<tr>
<td>效率</td>
<td>95.0</td><td>%</td>
</tr>
<tr>
<td>功率因数</td>
<td>0.98</td><td> </td>
</tr>
<tr>
<td>定子电阻</td>
<td>0.03</td><td>参考温度下的每相欧姆</td>
</tr>
<tr>
<td>参考温度TsRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>温度系数alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>d轴电抗Xd</td>
<td>0.4</td><td>每相的欧姆</td>
</tr>
<tr>
<td>q轴电抗Xq</td>
<td>0.4</td><td>每相的欧姆</td>
</tr>
<tr>
<td>定子漏电抗Xss</td>
<td>0.1</td><td>每相的欧姆</td>
</tr>
<tr>
<td>d轴的阻尼电阻</td>
<td>0.04</td><td>参考温度下的欧姆</td>
</tr>
<tr>
<td>q轴的阻尼电阻</td>
<td>同d轴</td><td> </td>
</tr>
<tr>
<td>参考温度TrRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>温度系数alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>d轴的阻尼漏感XDds</td>
<td>0.05</td><td>欧姆</td>
</tr>
<tr>
<td>q轴的阻尼漏感XDqs</td>
<td>同d轴</td><td> </td>
</tr>
<tr>
<td>定子操作温度TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>阻尼操作温度TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>这些值给出以下电感：</td>
<td> </td><td> </td>
</tr>
<tr>
<td>d轴的主场电感</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>q轴的主场电感</td>
<td>(Xq - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>每相的定子漏电感</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>d轴的阻尼漏感</td>
<td>XDds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>q轴的阻尼漏感</td>
<td>XDqs/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
end SM_PermanentMagnet;