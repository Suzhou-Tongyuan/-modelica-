within Modelica.Electrical.Machines.BasicMachines.DCMachines;
model DC_SeriesExcited "串激励线性直流电机"
  extends Machines.Interfaces.PartialBasicDCMachine(
    wNominal(start=1410*2*pi/60), 
    final ViNominal=VaNominal - (Machines.Thermal.convertResistance(
        Ra, 
        TaRef, 
        alpha20a, 
        TaNominal) + Machines.Thermal.convertResistance(
        Re, 
        TeRef, 
        alpha20e, 
        TeNominal))*IaNominal - Machines.Losses.DCMachines.brushVoltageDrop(
        brushParameters, IaNominal), 
    final psi_eNominal=Lme*abs(IaNominal), 
    redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCSE 
      thermalAmbient(final Tse=TeOperational), 
    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE thermalPort, 

    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCSE 
      internalThermalPort, 
    redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCSE 
      powerBalance(final powerSeriesExcitation=ve*ie, final
        lossPowerSeriesExcitation=re.LossPower), 
    core(final w=airGapDC.w));
  parameter SI.Resistance Re(start=0.01) 
    "TeRef处串激励电阻" 
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef(start=293.15) 
    "串激励电阻的参考温度" 
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=0) 
    "串激励电阻的温度系数" 
    annotation (Dialog(tab="Excitation"));
  parameter SI.Inductance Le(start=0.0005) 
    "总磁场励磁电感" 
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0, 
    max=0.99, 
    start=0) "总励磁电感的杂散部分" 
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeNominal(start=293.15) 
    "串激励的额定温度" 
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Temperature TeOperational(start=293.15) 
    "串激励的操作温度" annotation (Dialog(group= 
          "Operational temperatures", enable=not useThermalPort));
  output SI.Voltage ve=pin_ep.v - pin_en.v 
    "磁场励磁电压";
  output SI.Current ie=pin_ep.i "磁场励磁电流";
  Machines.BasicMachines.Components.AirGapDC airGapDC(
    final turnsRatio=turnsRatio, 
    final Le=Lme, 
    final quasiStatic=quasiStatic) annotation (Placement(transformation(extent= 
            {{-10,-10},{10,10}}, rotation=270)));
  Machines.BasicMachines.Components.CompoundDCExcitation compoundDCExcitation(final
      excitationTurnsRatio=1) 
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Electrical.Analog.Basic.Ground groundE 
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Electrical.Analog.Basic.Resistor re(
    final R=Re, 
    final T_ref=TeRef, 
    final alpha=Machines.Thermal.convertAlpha(alpha20e, TeRef), 
    final useHeatPort=true) annotation (Placement(transformation(
        origin={-80,50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Machines.BasicMachines.Components.InductorDC lesigma(final L=Lesigma, final
      quasiStatic=quasiStatic) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,20})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep 
    "正串激励引脚" annotation (Placement(transformation(
          extent={{-110,70},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_en 
    "负串激励引脚" annotation (Placement(transformation(
          extent={{-90,-50},{-110,-70}})));
protected
  final parameter SI.Inductance Lme=Le*(1 - sigmae) 
    "励磁电感的主要部分";
  final parameter SI.Inductance Lesigma=Le*sigmae 
    "励磁电感的杂散部分" annotation (Evaluate=true);
equation
  connect(airGapDC.pin_ap, la.n) annotation (Line(
      points={{10,10},{10,60}}, color={0,0,255}));
  connect(airGapDC.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{70,0},{70,0}}));
  connect(pin_ep, re.p) annotation (Line(
      points={{-100,60},{-80,60}}, color={0,0,255}));
  connect(re.n, lesigma.p) annotation (Line(
      points={{-80,40},{-80,30}}, color={0,0,255}));
  connect(airGapDC.pin_en, compoundDCExcitation.pin_n) annotation (Line(
      points={{-10,-10},{-10,-10}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_p, airGapDC.pin_ep) annotation (Line(
      points={{10,-10},{10,-10}}, color={0,0,255}));
  connect(airGapDC.pin_en, ground.p) annotation (Line(
      points={{-10,-10},{-20,-10}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_sen, pin_en) annotation (Line(
      points={{-10,-30},{-10,-60},{-100,-60}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_sep, lesigma.n) annotation (Line(
      points={{-2,-30},{-2,-40},{-80,-40},{-80,10}}, color={0,0,255}));
  connect(compoundDCExcitation.pin_en, groundE.p) annotation (Line(
      points={{2,-30},{2,-40},{10,-40}}, color={0,0,255}));
  connect(airGapDC.pin_an, brush.p) annotation (Line(
      points={{-10,10},{-10,60}}, color={0,0,255}));
  connect(re.heatPort, internalThermalPort.heatPortSeriesExcitation) 
    annotation (Line(
      points={{-70,50},{-60,50},{-60,40},{50,40},{50,-80},{0,-80}}, color={191,0,0}));
  annotation (
    defaultComponentName="dcse", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-100,-10},{-105,-9},{-109,-5},{-110,0},{-109,5},{-105, 
              9},{-100,10}}, color={0,0,255}), 
        Line(points={{-100,-30},{-105,-29},{-109,-25},{-110,-20},{-109,-15}, 
              {-105,-11},{-100,-10}}, color={0,0,255}), 
        Line(points={{-100,10},{-105,11},{-109,15},{-110,20},{-109,25},{-105, 
              29},{-100,30}}, color={0,0,255}), 
        Line(points={{-100,50},{-100,30}}, color={0,0,255}), 
        Line(points={{-100,-30},{-100,-50}}, color={0,0,255})}), 
    Documentation(info="<html>
<p><strong>串激励直流电机模型。</strong><br>
电枢电阻和电感直接建模后，使用<em>AirGapDC</em>模型。<br>
机器模型考虑以下损耗效应：
</p>

<ul>
<li>电枢绕组电阻的温度依赖性损耗</li>
<li>励磁绕组电阻的温度依赖性损耗</li>
<li>电枢电路的刷子损耗</li>
<li>摩擦损耗</li>
<li>铁芯损耗(仅涡流损耗，无磁滞损耗)</li>
<li>杂散负载损耗</li>
</ul>

<p>不进行饱和建模。<br>
串激励需要由用户的外部电路连接。
<br><strong>机器参数的默认值(一个现实的例子)为：</strong><br></p>
<table>
<tr>
<td>定子的惯性矩</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>转子的惯性矩</td>
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
<td>额定转矩</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>额定速度</td>
<td>1410</td><td>rpm</td>
</tr>
<tr>
<td>额定机械输出</td>
<td>9.4</td><td>kW</td>
</tr>
<tr>
<td>效率</td>
<td>94.0</td><td>%只有电枢</td>
</tr>
<tr>
<td>电枢电阻</td>
<td>0.05</td><td>参考温度下的欧姆</td>
</tr>
<tr>
<td>参考温度TaRef</td>
<td>20</td><td>&deg;C</td>
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
<td>励磁电阻</td>
<td>0.01</td><td>参考温度下的欧姆</td>
</tr>
<tr>
<td>参考温度TeRef</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>温度系数alpha20e</td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>励磁电感</td>
<td>0.0005</td><td>H</td>
</tr>
<tr>
<td>励磁电感的杂散部分</td>
<td>0</td><td> </td>
</tr>
<tr>
<td>电枢额定温度TaNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>串激励额定温度TeNominal</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>电枢操作温度TaOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
<tr>
<td>串激励操作温度TeOperational</td>
<td>20</td><td>&deg;C</td>
</tr>
</table>
电枢电阻和电感包括换向极绕组和补偿绕组的电阻和电感，如果存在的话。<br>
参数额定电枢电压包括串激励的电压降；<br>
但是对于输出，电压被分成：<br>
va=不带串激励电压降的电枢电压<br>
ve=串激励的电压降
</html>"));
end DC_SeriesExcited;