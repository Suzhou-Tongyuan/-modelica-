within Modelica.Electrical.Machines.BasicMachines.SynchronousMachines;
  model SM_ElectricalExcited 
  "带阻尼笼的电励磁同步电机"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    Lssigma(start=0.1/(2*pi*fsNominal)), 
    final idq_ss=airGap.i_ss, 
    final idq_sr=airGap.i_sr, 
    final idq_rs=airGap.i_rs, 
    final idq_rr=airGap.i_rr, 
    redeclare final Machines.Thermal.SynchronousMachines.ThermalAmbientSMEE 
      thermalAmbient(
      final useDamperCage=useDamperCage, 
      final Te=TeOperational, 
      final Tr=TrOperational), 
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMEE 
      thermalPort(final useDamperCage=useDamperCage), 
    redeclare final Machines.Interfaces.InductionMachines.ThermalPortSMEE 
      internalThermalPort(final useDamperCage=useDamperCage), 
    redeclare final Machines.Interfaces.InductionMachines.PowerBalanceSMEE 
      powerBalance(
      final lossPowerRotorWinding=damperCageLossPower, 
      final powerExcitation=ve*ie, 
      final lossPowerExcitation=re.LossPower, 
      final lossPowerBrush=brush.lossPower, 
      final lossPowerRotorCore=0), 
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
      Dialog(group="运行温度", enable=not useThermalPort 
           and useDamperCage));
  parameter SI.Inductance Lmd(start=1.5/(2*pi*fsNominal)) 
    "每相定子主场在d轴上的电感" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter SI.Inductance Lmq(start=1.5/(2*pi*fsNominal)) 
    "每相定子主场在q轴上的电感" 
    annotation (Dialog(tab="额定电阻和电感"));
  parameter Boolean useDamperCage(start=true) 
    "启用/禁用阻尼笼" annotation (Evaluate=true, Dialog(tab= 
          "额定电阻和电感", group="阻尼笼"));
  parameter SI.Inductance Lrsigmad(start=0.05/(2*pi* 
        fsNominal)) "d轴上的阻尼笼漏电感" annotation (
      Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Inductance Lrsigmaq=Lrsigmad 
    "q轴上的阻尼笼漏电感" annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Resistance Rrd(start=0.04) 
    "TRef时d轴上的阻尼电阻" annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Resistance Rrq=Rrd 
    "TRef时q轴上的阻尼电阻" annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Temperature TrRef(start=293.15) 
    "d轴和q轴阻尼电阻的参考温度" 
    annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=0) 
    "d轴和q轴阻尼电阻的温度系数" 
    annotation (Dialog(
      tab="额定电阻和电感", 
      group="阻尼笼", 
      enable=useDamperCage));
  parameter SI.Voltage VsNominal(start=100) 
    "每相定子的额定有效值电压" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Current IeOpenCircuit(start=10) 
    "额定电压和频率下的空载励磁电流" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Resistance Re(start=2.5) 
    "TRef时的励磁电阻" annotation (Dialog(tab="励磁"));
  parameter SI.Temperature TeRef(start=293.15) 
    "励磁电阻的参考温度" 
    annotation (Dialog(tab="励磁"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0) 
    "励磁电阻的温度系数" 
    annotation (Dialog(tab="励磁"));
  parameter Real sigmae(
    min=0, 
    max=0.99, 
    start=0.025) "总励磁电感的串扰系数" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Temperature TeOperational(start=293.15) 
    "运行励磁温度" annotation (Dialog(group= 
          "运行温度", enable=not useThermalPort));
  parameter Machines.Losses.BrushParameters brushParameters 
    "刷子损耗参数记录" annotation (Dialog(tab="损耗"));
  output SI.Voltage ve=pin_ep.v - pin_en.v 
    "励磁电压";
  output SI.Current ie=pin_ep.i "励磁电流";



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
  // 阻尼笼
  Machines.BasicMachines.Components.ElectricalExcitation electricalExcitation(final
      turnsRatio=turnsRatio) annotation (Placement(transformation(
        origin={-70,-50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=180)));
  // 电励磁
  Modelica.Electrical.Analog.Basic.Resistor re(
    final R=Re, 
    final T_ref=TeRef, 
    final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef), 
    final useHeatPort=true) annotation (Placement(transformation(
        origin={-80,10}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  // 电阻
  Modelica.Electrical.Analog.Basic.Inductor lesigma(final L=Lesigma) 
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,-20})));
  // 感应器
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
    "Positive excitation pin" annotation (Placement(transformation(extent= 
           {{-110,70},{-90,50}})));
  // 正激励引脚
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
    "Negative excitation pin" annotation (Placement(transformation(extent= 
           {{-90,-50},{-110,-70}})));
  // 负激励引脚
  Machines.Losses.DCMachines.Brush brush(final brushParameters=brushParameters, 
      final useHeatPort=true) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-80,40})));
  // 刷子
protected
  final parameter Real turnsRatio=sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd* 
      IeOpenCircuit) "Stator current / excitation current";
  // 匝数比
  final parameter SI.Inductance Lesigma=Lmd*turnsRatio^2*3/ 
      2*sigmae/(1 - sigmae);
  // 感应器电感
  Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
      quantity="Power", final unit="W") "阻尼损耗功率";
  // 阻尼笼损耗功率输出
equation
  connect(ir, damperCage.i);
  connect(idq_dr, damperCage.i);
  connect(damperCageLossPower, damperCage.lossPower);
  if not useDamperCage then
    damperCageLossPower = 0;
  end if;
  connect(airGap.spacePhasor_r, damperCage.spacePhasor_r) 
    annotation (Line(points={{10,-10},{10,-30}}, color={0,0,255}));
  connect(airGap.spacePhasor_r, electricalExcitation.spacePhasor_r) 
    annotation (Line(points={{10,-10},{10,-10},{10,-20},{-60,-20},{-60,-40}}, color={0,0,255}));
  connect(electricalExcitation.pin_en, pin_en) annotation (Line(
      points={{-80,-60},{-100,-60}}, color={0,0,255}));
  connect(pin_ep, brush.p) annotation (Line(
      points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
  connect(brush.n, re.p) annotation (Line(
      points={{-80,30},{-80,20}}, color={0,0,255}));
  connect(re.n, lesigma.p) annotation (Line(
      points={{-80,0},{-80,-10}}, color={0,0,255}));
  connect(lesigma.n, electricalExcitation.pin_ep) annotation (Line(
      points={{-80,-30},{-80,-40}}, color={0,0,255}));
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation (Line(
      points={{20,10},{10,10}}, color={0,0,255}));
  connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
      Line(
      points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  connect(re.heatPort, internalThermalPort.heatPortExcitation) 
    annotation (Line(
      points={{-70,10},{-60,10},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0}}));
  connect(airGap.support, internalSupport) annotation (Line(
      points={{-10,0},{-26,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));

    connect(damperCage.heatPort, internalThermalPort.heatPortRotorWinding) 
    annotation (Line(
      points={{-10,-40},{-10,-80},{0,-80},{0,-80}}, color={191,0,0}));
  // 连接阻尼笼的热端口到内部热端口的转子绕组热端口
  annotation (
    defaultComponentName="smee", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
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
<p><strong>具有阻尼笼的三相电励磁同步机模型。</strong><br>
在定子相中直接建模定子的电阻和漏感，然后使用空间矢量变换和转子固定的<em>气隙</em>模型。转子鼠笼的电阻和漏感建模在转子固定坐标系的两个轴上。电励磁通过将励磁电流和电压转换为d轴空间矢量来建模。机器模型考虑以下损耗效应：
</p>

<ul>
<li>在温度相关的定子绕组电阻中的热损耗</li>
<li>在温度相关的励磁绕组电阻中的热损耗</li>
<li>当启用时，温度相关的阻尼笼电阻的热损耗</li>
<li>励磁电路中的刷子损耗</li>
<li>摩擦损耗</li>
<li>铁芯损耗(仅涡流损耗，无磁滞损耗)</li>
<li>漏负荷损耗</li>
</ul>

<p>是否存在阻尼笼可以通过布尔参数useDamperCage(默认值为true)选择。
<br><strong>机器参数的默认值(一个真实的例子)为：</strong><br></p>
<table>
<tr>
<td>极对数p</td>
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
<td>额定频率fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>每相额定电压</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>空载励磁电流<br>
    额定电压和频率</td>
<td>10</td><td>A DC</td>
</tr>
<tr>
<td>暖态励磁电阻</td>
<td>2.5</td><td>Ohm</td>
</tr>
<tr>
<td>每相额定电流</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>额定视在功率</td>
<td>-30000</td><td>VA</td>
</tr>
<tr>
<td>功率因数</td>
<td>-1.0</td><td>感性/容性</td>
</tr>
<tr>
<td>额定励磁电流</td>
<td>19</td><td>A</td>
</tr>
<tr>
<td>无励磁效率</td>
<td>97.1</td><td>%</td>
</tr>
<tr>
<td>额定扭矩</td>
<td>-196.7</td><td>Nm</td>
</tr>
<tr>
<td>额定转速</td>
<td>1500</td><td>rpm</td>
</tr>
<tr>
<td>额定转子角度</td>
<td>-57.23</td><td>度</td>
</tr>
<tr>
<td>定子电阻</td>
<td>0.03</td><td>Ohm每相在参考温度下</td>
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
<td>定子反应电抗Xd</td>
<td>1.6</td><td>Ohm每相在d轴</td>
</tr>
<tr>
<td>给定Kc</td>
<td>0.625</td><td> </td>
</tr>
<tr>
<td>定子反应电抗Xq</td>
<td>1.6</td><td>Ohm每相在q轴</td>
</tr>
<tr>
<td>定子漏反电抗 Xss</td>
<td>0.1</td><td>Ohm每相</td>
</tr>
<tr>
<td>d轴阻尼电阻</td>
<td>0.04</td><td>Ohm在参考温度下</td>
</tr>
<tr>
<td>q轴阻尼电阻</td>
<td>与d轴相同</td><td> </td>
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
<td>d轴阻尼漏电抗 XDds</td>
<td>0.05</td><td>Ohm</td>
</tr>
<tr>
<td>q轴阻尼漏电抗XDqs</td>
<td>与d轴相同</td><td> </td>
</tr>
<tr>
<td>励磁电阻</td>
<td>2.5</td><td>Ohm在参考温度下</td>
</tr>
<tr>
<td>参考温度TeRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>温度系数alpha20e </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>励磁漏感</td>
<td>2.5</td><td>%总励磁电感</td>
</tr>
<tr>
<td>定子运行温度TsOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>阻尼笼运行温度TrOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>励磁运行温度TeOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>这些值给出以下电感：</td>
<td> </td><td> </td>
</tr>
<tr>
<td>d轴主场电感</td>
<td>(Xd - Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>q轴主场电感</td>
<td>(Xq-Xss)/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>定子漏电感每相</td>
<td>Xss/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>d轴阻尼漏电感</td>
<td>XDds/(2*pi*fNominal)</td><td> </td>
</tr>
<tr>
<td>q轴阻尼漏电感</td>
<td>XDqs/(2*pi*fNominal)</td><td> </td>
</tr>
</table>
</html>"));
end SM_ElectricalExcited;