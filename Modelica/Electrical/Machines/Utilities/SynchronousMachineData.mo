within Modelica.Electrical.Machines.Utilities;
record SynchronousMachineData 
  "从常见数据表计算机器参数"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  parameter SI.ApparentPower SNominal(start = 30E3) 
    "额定视在功率";
  parameter SI.Voltage VsNominal(start = 100) 
    "每相额定定子电压";
  final parameter SI.Current IsNominal = SNominal / (3 * VsNominal) 
    "每相额定定子电流";
  final parameter SI.Impedance ZReference = VsNominal / IsNominal 
    "参考阻抗";
  parameter SI.Frequency fsNominal(start = 50) 
    "每相额定定子频率";
  final parameter SI.AngularVelocity omega = 2 * pi * fsNominal 
    "每相额定角频率";
  parameter SI.Current IeOpenCircuit(start = 10) 
    "在额定电压和频率下的开路励磁电流";
  parameter Real effectiveStatorTurns = 1 "有效定子匝数";
  final parameter Real turnsRatio = sqrt(2) * VsNominal / (omega * Lmd * 
    IeOpenCircuit) "定子电流 / 励磁电流比";
  parameter Real x0(start = 0.1) 
    "每相定子漏电感(近似为零阻抗)[pu]";
  parameter Real xd(start = 1.6) 
    "每相同步电抗，d轴 [pu]";
  parameter Real xq(start = 1.6) 
    "每相同步电抗，q轴 [pu]";
  parameter Real xdTransient(start = 0.1375) 
    "每相暂态电抗，d轴 [pu]";
  parameter Real xdSubtransient(start = 0.121428571) 
    "每相亚暂态电抗，d轴 [pu]";
  parameter Real xqSubtransient(start = 0.148387097) 
    "每相亚暂态电抗，q轴 [pu]";
  parameter SI.Time Ta(start = 0.014171268) 
    "电枢时间常数";
  parameter SI.Time Td0Transient(start = 0.261177343) 
    "开路场时间常数 Td0'";
  parameter SI.Time Td0Subtransient(start = 0.006963029) 
    "开路亚暂态时间常数 Td0''，d轴";
  parameter SI.Time Tq0Subtransient(start = 0.123345081) 
    "开路亚暂态时间常数 Tq0''，q轴";
  parameter SI.Temperature TsSpecification(start = 293.15) 
    "定子电阻的规格温度" 
    annotation(Dialog(tab = "Material"));
  parameter SI.Temperature TsRef(start = 293.15) 
    "定子电阻的参考温度" 
    annotation(Dialog(tab = "Material"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start = 0) 
    "20°C时定子电阻的温度系数" 
    annotation(Dialog(tab = "Material"));
  parameter SI.Temperature TrSpecification(start = 293.15) 
    "(可选)阻尼笼的规格温度" 
    annotation(Dialog(tab = "Material"));
  parameter SI.Temperature TrRef(start = 293.15) 
    "d-轴和q-轴的阻尼电阻的参考温度" 
    annotation(Dialog(tab = "Material"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start = 0) 
    "d-轴和q-轴的阻尼电阻的温度系数" 
    annotation(Dialog(tab = "Material"));
  parameter SI.Temperature TeSpecification(start = 293.15) 
    "励磁温度的规格温度" 
    annotation(Dialog(tab = "Material"));
  parameter SI.Temperature TeRef(start = 293.15) 
    "励磁电阻的参考温度" 
    annotation(Dialog(tab = "Material"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start = 0) 
    "励磁电阻的温度系数" 
    annotation(Dialog(tab = "Material"));
  final parameter Real xmd = xd - x0 
    "每相主磁电抗，d轴 [pu]";
  final parameter Real xmq = xq - x0 
    "每相主磁电抗，q轴 [pu]";
  final parameter Real xe = xmd ^ 2 / (xd - xdTransient) 
    "励磁电感 [pu]";
  final parameter Real xrd = xmd ^ 2 / (xdTransient - xdSubtransient) * (1 - (xmd / 
    xe)) ^ 2 + xmd ^ 2 / xe "每相阻尼电抗，d轴 [pu]";
  final parameter Real xrq = xmq ^ 2 / (xq - xqSubtransient) 
    "每相阻尼电抗，d轴 [pu]";
  final parameter Real rs = 2 / (1 / xdSubtransient + 1 / xqSubtransient) / (omega * Ta) 
    "规格温度下每相定子电阻 [pu]";
  final parameter Real rrd = (xrd - xmd ^ 2 / xe) / (omega * Td0Subtransient) 
    "规格温度下每相阻尼电阻，d轴 [pu]";
  final parameter Real rrq = xrq / (omega * Tq0Subtransient) 
    "规格温度下每相阻尼电阻，q轴 [pu]";
  final parameter Real re = xe / (omega * Td0Transient) 
    "规格温度下每相励磁电阻 [pu]";
  parameter SI.Resistance Rs = 
    Machines.Thermal.convertResistance(
    rs * ZReference, 
    TsSpecification, 
    alpha20s, 
    TsRef) "在TRef时的每相定子电阻" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter SI.Inductance Lssigma = x0 * ZReference / omega 
    "每相定子漏感" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter SI.Inductance Lmd = xmd * ZReference / omega 
    "d轴上每相主磁感" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter SI.Inductance Lmq = xmq * ZReference / omega 
    "q轴上每相主磁感" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter SI.Inductance Lrsigmad = (xrd - xmd) * ZReference / 
    omega "d轴上阻尼漏感" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter SI.Inductance Lrsigmaq = (xrq - xmq) * ZReference / 
    omega "q轴上阻尼漏感" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter SI.Resistance Rrd = 
    Machines.Thermal.convertResistance(
    rrd * ZReference, 
    TrSpecification, 
    alpha20r, 
    TrRef) "在TRef时的d轴阻尼电阻" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter SI.Resistance Rrq = 
    Machines.Thermal.convertResistance(
    rrq * ZReference, 
    TrSpecification, 
    alpha20r, 
    TrRef) "在TRef时的q轴阻尼电阻" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter SI.Resistance Re = 3 / 2 * turnsRatio ^ 2 * 
    Machines.Thermal.convertResistance(
    re * ZReference, 
    TeSpecification, 
    alpha20e, 
    TeRef) "在TRef时的励磁电阻" 
    annotation(Dialog(tab = "Result", enable = false));
  parameter Real sigmae = 1 - xmd / xe 
    "总励磁电感的漏损比例" 
    annotation(Dialog(tab = "Result", enable = false));
  annotation(
    defaultComponentName = "smeeData", 
    defaultComponentPrefixes = "parameter", 
    Documentation(info = "<html>
<p>根据标准EN 60034-4:2008附录C，从技术描述中通常给定的参数计算<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_ElectricalExcited\">电气励磁同步机(带阻尼)</a>的参数。</p>
</html>"));
end SynchronousMachineData;