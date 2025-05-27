within Modelica.Electrical.Machines.BasicMachines.DCMachines;
model DC_ElectricalExcited 
  "电励磁/分开激励的线性直流电机"
  extends Machines.Interfaces.PartialBasicDCMachine(
    final ViNominal=VaNominal - Machines.Thermal.convertResistance(
        Ra, 
        TaRef, 
        alpha20a, 
        TaNominal)*IaNominal - Machines.Losses.DCMachines.brushVoltageDrop(
        brushParameters, IaNominal), 
    final psi_eNominal=Lme*IeNominal, 
    redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCEE 
      thermalAmbient(final Te=TeOperational), 
    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE thermalPort, 

    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCEE 
      internalThermalPort, 
    redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCEE 
      powerBalance(final powerExcitation=ve*ie, final lossPowerExcitation=re.LossPower), 

    core(final w=airGapDC.w));
  parameter SI.Current IeNominal(start=1) 
    "额定励磁电流" annotation (Dialog(tab="励磁"));
  parameter SI.Resistance Re(start=100) 
    "在TeRef处的励磁电阻" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Temperature TeRef(start=293.15) 
    "励磁电阻的参考温度" 
    annotation (Dialog(tab="励磁"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0) 
    "励磁电阻的温度系数" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Inductance Le(start=1) 
    "总励磁电感" 
    annotation (Dialog(tab="励磁"));
  parameter Real sigmae(
    min=0, 
    max=0.99, 
    start=0) "总励磁电感的漏电分数" 
    annotation (Dialog(tab="励磁"));
  parameter SI.Temperature TeOperational(start=293.15) 
    "操作(分开激励)励磁温度" annotation (Dialog(group= 
         "操作温度", enable=not useThermalPort));
  output SI.Voltage ve=pin_ep.v - pin_en.v 
    "励磁电压";
  output SI.Current ie(start=0) = pin_ep.i 
    "励磁电流";
  Machines.BasicMachines.Components.AirGapDC airGapDC(
    final turnsRatio=turnsRatio, 
    final Le=Lme, 
    final quasiStatic=quasiStatic) annotation (Placement(transformation(extent= 
            {{-10,-10},{10,10}}, rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Machines.BasicMachines.Components.CompoundDCExcitation compoundDCExcitation(final
      excitationTurnsRatio=1) 
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground groundSE 
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Electrical.Analog.Basic.Resistor re(
    final R=Re, 
    final T_ref=TeRef, 
    final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef), 
    final useHeatPort=true) annotation (Placement(transformation(
        origin={-80,50}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Machines.BasicMachines.Components.InductorDC lesigma(final L=Lesigma, final
      quasiStatic=quasiStatic) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,20})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
    "正励磁引脚" annotation (Placement(transformation(extent= 
           {{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
    "负励磁引脚" annotation (Placement(transformation(extent= 
           {{-90,-50},{-110,-70}})));
protected
  final parameter SI.Inductance Lme=Le*(1 - sigmae) 
    "励磁电感的主要部分";
  final parameter SI.Inductance Lesigma=Le*sigmae 
    "励磁电感的漏电部分" annotation (Evaluate=true);
equation
  connect(airGapDC.pin_ap, la.n) annotation (Line(
      points={{10,10},{10,60}}, color={0,0,255}));
  connect(airGapDC.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{35,0},{35,0},{70,0}}));
  connect(re.p, pin_ep) annotation (Line(
      points={{-80,60},{-100,60}}, color={0,0,255}));
  connect(re.n, lesigma.p) annotation (Line(
      points={{-80,40},{-80,30}}, color={0,0,255}));
  connect(ground.p, airGapDC.pin_en) annotation (Line(
      points={{-20,-10},{-10,-10}}, color={0,0,255}));
  connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
      points={{-10,-10},{-10,-10}}, color={0,0,255}));
  connect(airGapDC.pin_ep, compoundDCExcitation.pin_p) annotation (Line(
      points={{10,-10},{10,-10}}, color={0,0,255}));
  connect(groundSE.p, compoundDCExcitation.pin_sen) annotation (Line(
      points={{-20,-30},{-10,-30}}, color={0,0,255}));
  connect(pin_en, compoundDCExcitation.pin_en) annotation (Line(
      points={{-100,-60},{2,-60},{2,-30}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_ep, lesigma.n) annotation (Line(
      points={{10,-29.8},{10,-40},{-80,-40},{-80,10}}, color={0,0,255}));
  connect(airGapDC.pin_an, brush.p) annotation (Line(
      points={{-10,10},{-10,60}}, color={0,0,255}));
  connect(re.heatPort, internalThermalPort.heatPortExcitation) 
    annotation (Line(
      points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  annotation (
    defaultComponentName="dcee", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111, 
              1},{-110,-4}}, color={0,0,255}), 
        Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1}, 
              {-90,-4}}, color={0,0,255}), 
        Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70, 
              -4}}, color={0,0,255}), 
        Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,0,255}), 
        Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0, 
              255})}), 
    Documentation(info="<html>
<p><strong>电励磁/分开激励的直流电机模型。</strong><br>
电枢电阻和电感直接模拟在电枢引脚上，然后使用<em>AirGapDC</em>模型。<br>
模型考虑以下损耗效应：
</p>

<ul>
<li>电枢绕组电阻的温度相关热损耗</li>
<li>励磁绕组电阻的温度相关热损耗</li>
<li>电枢电路中的刷损耗</li>
<li>摩擦损耗</li>
<li>铁心损耗(仅涡流损耗，无磁滞损耗)</li>
<li>额外负载损耗</li>
</ul>

<p>模型未考虑饱和效应。<br>
电枢电路或分开激励由用户的外部电路定义。
<br><strong>电机参数的默认值(一个现实的例子)为：</strong><br></p>
<table>
<tr>
<td>定子的转动惯量</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>转子的转动惯量</td>
<td>0.15</td><td>kg.m2</td>
</tr>
<tr>
<td>额定电枢电压</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>额定电枢电流</td>
<td>100</td><td>A</td>
</tr>
<tr>
<td>额定扭矩</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>额定转速</td>
<td>1425</td><td>rpm</td>
</tr>
<tr>
<td>额定机械输出</td>
<td>9.5</td><td>kW</td>
</tr>
<tr>
<td>效率</td>
<td>95.0</td><td>%仅电枢</td>
</tr>
<tr>
<td>效率</td>
<td>94.06</td><td>%包括励磁</td>
</tr>
<tr>
<td>电枢电阻</td>
<td>0.05</td><td>参考温度下的欧姆</td>
</tr>
<tr>
<td>参考温度TaRef</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>温度系数alpha20a </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>电枢电感</td>
<td>0.0015</td><td>H</td>
</tr>
<tr>
<td>额定励磁电压</td>
<td>100</td><td>V</td>
</tr>
<tr>
<td>额定励磁电流</td>
<td>1</td><td>A</td>
</tr>
<tr>
<td>励磁电阻</td>
<td>100</td><td>参考温度下的欧姆</td>
</tr>
<tr>
<td>参考温度TeRef</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>温度系数alpha20e </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>励磁电感</td>
<td>1</td><td>H</td>
</tr>
<tr>
<td>励磁电感的漏电部分</td>
<td>0</td><td> </td>
</tr>
<tr>
<td>电枢额定温度TaNominal</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>电枢操作温度TaOperational</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>(分开激励)励磁操作温度TeOperational</td>
<td>20</td><td>°C</td>
</tr>
</table>
电枢电阻和电感包括换向极绕组和补偿绕组的电阻和电感。<br>
电枢电流不包括分开激励的励磁电流；在这种情况下，从电网抽取的总电流=电枢电流+励磁电流。
</html>"));
end DC_ElectricalExcited;