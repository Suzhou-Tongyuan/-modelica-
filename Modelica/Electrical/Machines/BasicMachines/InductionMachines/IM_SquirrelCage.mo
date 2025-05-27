within Modelica.Electrical.Machines.BasicMachines.InductionMachines;
model IM_SquirrelCage 
  "带鼠笼型转子的感应电机"
  extends Machines.Interfaces.PartialBasicInductionMachine(
    final idq_ss = airGap.i_ss, 
    final idq_sr(stateSelect = stateSelect_sr) = airGap.i_sr, 
    final idq_rs = airGap.i_rs, 
    final idq_rr(stateSelect = stateSelect_rr) = airGap.i_rr, redeclare final Machines.Thermal.InductionMachines.ThermalAmbientIMC 
    thermalAmbient(final Tr = TrOperational), redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMC 
    thermalPort, redeclare final Machines.Interfaces.InductionMachines.ThermalPortIMC 
    internalThermalPort, redeclare final Machines.Interfaces.InductionMachines.PowerBalanceIMC 
    powerBalance(final lossPowerRotorWinding = squirrelCageR.LossPower, final
    lossPowerRotorCore = 0), 
    statorCore(final w = statorCoreParameters.wRef));
  output SI.Current ir[2] = squirrelCageR.i 
    "转子笼电流";
  Machines.BasicMachines.Components.AirGapS airGap(
    final p = p, 
    final Lm = Lm, 
    final m = m) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
  parameter StateSelect stateSelect_ss = StateSelect.prefer;
  parameter StateSelect stateSelect_sr = StateSelect.prefer;
  parameter StateSelect stateSelect_rs = StateSelect.prefer;
  parameter StateSelect stateSelect_rr = StateSelect.prefer;
  parameter SI.Inductance Lm(start = 3 * sqrt(1 - 0.0667) / (2 * pi 
    * fsNominal)) "每相定子主磁场电感" 
    annotation(Dialog(tab = "额定电阻和电感"));
  parameter SI.Inductance Lrsigma(start = 3 * (1 - sqrt(1 - 
    0.0667)) / (2 * pi * fsNominal)) 
    "每相转子杂散电感(等效三相绕组)" 
    annotation(Dialog(tab = "额定电阻和电感"));
  parameter SI.Resistance Rr(start = 0.04) 
    "每相转子电阻(等效三相绕组)，在 TRef 时" 
    annotation(Dialog(tab = "额定电阻和电感"));
  parameter SI.Temperature TrRef(start = 293.15) 
    "转子电阻的参考温度" 
    annotation(Dialog(tab = "额定电阻和电感"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start = 0) 
    "20 摄氏度下转子电阻的温度系数" 
    annotation(Dialog(tab = "额定电阻和电感"));
  parameter SI.Temperature TrOperational(start = 293.15) 
    "转子电阻的操作温度" annotation(Dialog(
    group = "操作温度", enable = not useThermalPort));
  Machines.BasicMachines.Components.SquirrelCage squirrelCageR(
    final Lrsigma = Lrsigma, 
    final Rr = Rr, 
    final useHeatPort = true, 
    final T_ref = TrRef, 
    final alpha = Machines.Thermal.convertAlpha(alpha20r, TrRef)) annotation(
    Placement(transformation(
    origin = {0, -40}, 
    extent = {{-10, -10}, {10, 10}}, 
    rotation = 270)));
equation
  connect(airGap.spacePhasor_r, squirrelCageR.spacePhasor_r) 
    annotation(Line(points = {{10, -10}, {10, -30}}, color = {0, 0, 255}));
  connect(airGap.flange, inertiaRotor.flange_a) annotation(Line(
    points = {{10, 0}, {36, 0}, {36, 0}, {70, 0}}));
  connect(lssigma.spacePhasor_b, airGap.spacePhasor_s) annotation(Line(
    points = {{20, 10}, {10, 10}}, color = {0, 0, 255}));
  connect(squirrelCageR.heatPort, internalThermalPort.heatPortRotorWinding) 
    annotation(Line(
    points = {{-10, -40}, {-10, -60}, {0, -60}, {0, -80}}, color = {191, 0, 0}));
  connect(airGap.support, internalSupport) annotation(Line(
    points = {{-10, 0}, {-40, 0}, {-40, -90}, {60, -90}, {60, -100}}));
  annotation(defaultComponentName = "imc", Documentation(info="<html><p>
<strong>带鼠笼型转子的三相感应电机模型。</strong><br> 定子的电阻和杂散电感直接在定子相中建模，然后使用空间矢量变换。 鼠笼型转子的电阻和杂散电感在转子固定坐标系的两个轴中建模。 这两者通过定子固定的 <em>AirGap</em> 模型连接。 该电机模型考虑以下损耗效应：
</p>
<li>
温度相关的定子绕组电阻的热损耗</li>
<li>
温度相关的松鼠笼电阻的热损耗</li>
<li>
摩擦损耗</li>
<li>
铁心损耗(仅涡流损耗，无磁滞损耗)</li>
<li>
杂散负载损耗</li>
<p>
<strong>电机参数的默认值(一个实际例子)为：</strong><br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">极对数p</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">2</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">定子转动惯量</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0.29</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg.m2</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">转子转动惯量</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0.29</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kg.m2</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">额定频率fNominal</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">50</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Hz</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">每相额定电压</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">100</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">V RMS</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">每相额定电流</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">100</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">A RMS</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">额定转矩</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">161.4</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Nm</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">额定转速</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1440.45</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">rpm</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">额定机械输出</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">24.346</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">kW</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">效率</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">92.7</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">%</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">功率因数</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0.875</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">定子电阻</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0.03</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Ohm 每相，参考温度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">参考温度TsRef</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">20</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">℃</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">温度系数alpha20s </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1/K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">转子电阻</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0.04</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Ohm，参考温度</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">参考温度TrRef</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">20</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">℃</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">温度系数alpha20r </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1/K</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">定子电抗Xs</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Ohm 每相</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">转子电抗Xr</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">3</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Ohm</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">总杂散系数sigma</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">0.0667</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">定子操作温度 sOperational</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">20</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">℃</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">转子操作温度TrOperational</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">20</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">℃</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">这些值给出以下电感：</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> </td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">每相定子杂散电感</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Xs * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">转子杂散电感</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">Xr * (1 - sqrt(1-sigma))/(2*pi*fNominal)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> </td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">每相主磁场电感</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">sqrt(Xs*Xr * (1-sigma))/(2*pi*fNominal)</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"> </td></tr></tbody></table><p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end IM_SquirrelCage;