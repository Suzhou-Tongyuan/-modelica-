within Modelica.Electrical.Machines.BasicMachines.SynchronousMachines;
model SM_ReluctanceRotor 
  "带磁阻转子和阻尼笼的同步电机"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    Lssigma(start=0.1/(2*pi*fsNominal)), 
    final idq_ss=airGap.i_ss, 
    final idq_sr=airGap.i_sr, 
    final idq_rs=airGap.i_rs, 
    final idq_rr=airGap.i_rr, 
    redeclare final Machines.Thermal.SynchronousMachines.ThermalAmbientSMR 
      thermalAmbient(final useDamperCage=useDamperCage, final Tr=TrOperational), 

    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMR 
      thermalPort(final useDamperCage=useDamperCage), 
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMR 
      internalThermalPort(final useDamperCage=useDamperCage), 
    redeclare final Machines.Interfaces.InductionMachines.PowerBalanceSMR 
      powerBalance(final lossPowerRotorWinding=damperCageLossPower, final
        lossPowerRotorCore=0), 
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
    "阻尼空间矢量电流/转子固定坐标系" 
    annotation (Placement(visible=false));
  Machines.BasicMachines.Components.AirGapR airGap(
    final p=p, 
    final Lmd=Lmd, 
    final Lmq=Lmq, 
    final m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
          rotation=270)));
  parameter SI.Temperature TrOperational(start=293.15) 
    "(可选)阻尼笼的运行温度" annotation (
      Dialog(group="操作温度", enable=not useThermalPort 
           and useDamperCage));
  parameter SI.Inductance Lmd(start=2.9/(2*pi*fsNominal)) 
    "定子d轴主场电感每相" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter SI.Inductance Lmq(start=0.9/(2*pi*fsNominal)) 
    "定子q轴主场电感每相" 
    annotation (Dialog(tab="标称电阻和电感"));
  parameter Boolean useDamperCage(start=true) 
    "启用/禁用阻尼笼" annotation (Evaluate=true, Dialog(tab= 
          "标称电阻和电感", group="阻尼笼"));
  parameter SI.Inductance Lrsigmad(start=0.05/(2*pi* 
        fsNominal)) "阻尼d轴漏感" annotation (
      Dialog(
      tab="标称电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad 
    "阻尼q轴漏感" annotation (Dialog(
      tab="标称电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Resistance Rrd(start=0.04) 
    "在TRef下的阻尼d轴电阻" annotation (Dialog(
      tab="标称电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd 
    "在TRef下的阻尼q轴电阻" annotation (Dialog(
      tab="标称电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Temperature TrRef(start=293.15) 
    "d轴和q轴阻尼电阻的参考温度" 
    annotation (Dialog(
      tab="标称电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0) 
    "d轴和q轴阻尼电阻的温度系数" 
    annotation (Dialog(
      tab="标称电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
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
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "阻尼损耗";
equation
  connect(ir, damperCage.i);
  connect(idq_dr, damperCage.i);
  connect(damperCageLossPower, damperCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(airGap.spacePhasor_r, damperCage.spacePhasor_r) annotation (
      Line(points={{10,-10},{10,-15},{10,-30}}, color={0,0,255}));
  connect(airGap.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation (Line(
      points={{20,10},{10,10}}, color={0,0,255}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0}}));
  connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{-10,-40},{-10,-60},{-10,-60},{-10,-80},{0,-80}}, color={191,0,0}));
  annotation (
    defaultComponentName="smr", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-130,10},{-100,-10}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-100,10},{-70,-10}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}), 
    Documentation(info="<html>
<p><strong>带有磁阻转子和阻尼笼的三相同步机模型。</strong><br>
定子电阻和漏感直接建模在定子相位中，然后使用空间矢量变换。转子鼠笼的电阻和漏感在转子固定坐标系的两个轴上建模。两者通过转子固定的<em>空气间隙</em>模型连接。该机器模型考虑以下损耗效应：
</p>

<ul>
<li>在温度依赖的定子绕组电阻中的热损耗</li>
<li>可选的，在启用时：在温度依赖的阻尼笼电阻中的热损耗</li>
<li>摩擦损耗</li>
<li>铁芯损耗(仅涡流损耗，无磁滞损耗)</li>
<li>漏损</li>
</ul>

<p>是否存在阻尼笼可以通过布尔参数useDamperCage进行选择(默认值为true)。
<br><strong>机器参数的默认值(一个实际例子)为：</strong><br></p>
<table>
<tr>
<td>极对数 p</td>
<td>2</td><td> </td>
</tr>
<tr>
<td>定子转动惯量</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>转子转动惯量</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>额定频率 fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>每相额定电压</td>
<td>100</td><td>V有效值</td>
</tr>
<tr>
<td>每相额定电流</td>
<td>50</td><td>A有效值</td>
</tr>
<tr>
<td>额定转矩</td>
<td>46</td><td>Nm</td>
</tr>
<tr>
<td>额定转速</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>额定机械输出</td>
<td>7.23</td><td>kW</td>
</tr>
<tr>
<td>效率</td>
<td>96.98</td><td>%</td>
</tr>
<tr>
<td>功率因数</td>
<td>0.497</td><td> </td>
</tr>
<tr>
<td>定子电阻</td>
<td>0.03</td><td>每相在参考温度下的欧姆</td>
</tr>
<tr>
<td>参考温度TsRef</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>温度系数alpha20s </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>d轴转子电阻</td>
<td>0.04</td><td>每相在参考温度下的欧姆</td>
</tr>
<tr>
<td>q轴转子电阻</td>
<td>与d轴相同</td><td> </td>
</tr>
<tr>
<td>参考温度TrRef</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>温度系数alpha20r </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>d轴定子电抗Xsd</td>
<td>3</td><td>每相欧姆</td>
</tr>
<tr>
<td>q轴定子电抗Xsq</td>
<td>1</td><td>欧姆</td>
</tr>
<tr>
<td>定子漏电抗Xss</td>
<td>0.1</td><td>每相欧姆</td>
</tr>
<tr>
<td>d轴转子漏电抗Xrds</td>
<td>0.05</td><td>每相欧姆</td>
</tr>
<tr>
<td>q轴转子漏电抗Xrqs</td>
<td>与d轴相同</td><td> </td>
</tr>
<tr>
<td>定子操作温度TsOperational</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>阻尼操作温度TrOperational</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>这些值给出了以下电感：</td>
<td> </td><td> </td>
</tr>
<tr>
<td>每相定子漏电感</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>d轴转子漏电感</td>
<td>Xrds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>q轴转子漏电感</td>
<td>Xrqs/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>d轴定子主场电感</td>
<td>(Xsd-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>q轴定子主场电感</td>
<td>(Xsq-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
end SM_ReluctanceRotor;