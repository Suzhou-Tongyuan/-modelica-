within Modelica.Electrical.Machines.BasicMachines.DCMachines;
model DC_PermanentMagnet "永磁直流电机"
  extends Machines.Interfaces.PartialBasicDCMachine(
    final ViNominal=VaNominal - Machines.Thermal.convertResistance(
        Ra, 
        TaRef, 
        alpha20a, 
        TaNominal)*IaNominal - Machines.Losses.DCMachines.brushVoltageDrop(
        brushParameters, IaNominal), 
    final psi_eNominal=Lme*IeNominal, 
    redeclare final Machines.Thermal.DCMachines.ThermalAmbientDCPM 
      thermalAmbient(final Tpm=TpmOperational), 
    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM thermalPort, 

    redeclare final Machines.Interfaces.DCMachines.ThermalPortDCPM 
      internalThermalPort, 
    redeclare final Machines.Interfaces.DCMachines.PowerBalanceDCPM 
      powerBalance(final lossPowerPermanentMagnet=0), 
    core(final w=airGapDC.w));
  final parameter SI.Temperature TpmOperational=293.15 
    "永磁体的工作温度" 
    annotation (Dialog(group="操作温度"));
  Machines.BasicMachines.Components.AirGapDC airGapDC(
    final turnsRatio=turnsRatio, 
    final Le=Lme, 
    final quasiStatic=quasiStatic) annotation (Placement(transformation(extent= 
            {{-10,-10},{10,10}}, rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground eGround annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-20,-30})));
  Modelica.Electrical.Analog.Sources.ConstantCurrent ie(I=IeNominal) 
    annotation (Placement(transformation(
        origin={0,-40}, 
        extent={{-10,-10},{10,10}})));
protected
  constant SI.Inductance Lme=1 
    "励磁电感";
  constant SI.Current IeNominal=1 
    "等效励磁电流";
equation
  connect(eGround.p, ie.p) annotation (Line(points={{-10,-30},{-10,-30},{
          -10,-40}}, color={0,0,255}));
  connect(airGapDC.pin_ep, ie.n) 
    annotation (Line(points={{10,-10},{10,-40}}, color={0,0,255}));
  connect(airGapDC.pin_en, eGround.p) annotation (Line(points={{-10,-10}, 
          {-10,-20},{-10,-30}}, color={0,0,255}));
  connect(airGapDC.pin_ap, la.n) annotation (Line(
      points={{10,10},{10,60}}, color={0,0,255}));
  connect(airGapDC.support, internalSupport) annotation (Line(
      points={{-10,0},{-40,0},{-40,-90},{60,-90},{60,-100}}));
  connect(airGapDC.flange, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{36,0},{36,0},{70,0}}));
  connect(airGapDC.pin_an, brush.p) annotation (Line(
      points={{-10,10},{-10,60}}, color={0,0,255}));
  annotation (
    defaultComponentName="dcpm", 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
          extent={{-130,10},{-100,-10}}, 
          fillColor={0,255,0}, 
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-100,10},{-70,-10}}, 
          fillColor={255,0,0}, 
          fillPattern=FillPattern.Solid)}), 
    Documentation(info="<html>
<p><strong>永磁直流电机模型。</strong><br>
电枢电阻和电感直接建模在电枢引脚上，然后使用<em>AirGapDC</em>模型。永磁激励通过恒定的等效励磁电流馈入AirGapDC进行建模。该电机模型考虑以下损耗效应：
</p>

<ul>
<li>电枢绕组电阻的温度相关热损耗</li>
<li>电枢回路中的刷子损耗</li>
<li>摩擦损耗</li>
<li>铁芯损耗(仅涡流损耗，没有磁滞损耗)</li>
<li>漏电损耗</li>
</ul>

<p>不建模饱和效应。
<br><strong>电机参数的默认值(一个现实的例子)如下：</strong><br></p>
<table>
<tr>
<td>定子惯性矩</td>
<td>0.29</td><td>kg.m2</td>
</tr>
<tr>
<td>转子惯性矩</td>
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
<td>额定转速</td>
<td>1425</td><td>rpm</td>
</tr>
<tr>
<td>额定扭矩</td>
<td>63.66</td><td>Nm</td>
</tr>
<tr>
<td>额定机械输出</td>
<td>9.5</td><td>kW</td>
</tr>
<tr>
<td>效率</td>
<td>95.0</td><td>%</td>
</tr>
<tr>
<td>电枢电阻</td>
<td>0.05</td><td>在参考温度下的欧姆</td>
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
<td>电枢额定温度TaNominal</td>
<td>20</td><td>°C</td>
</tr>
<tr>
<td>电枢工作温度TaOperational</td>
<td>20</td><td>°C</td>
</tr>
</table>
电枢电阻和电感包括换向极绕组和补偿绕组的电阻和电感。
</html>"));
end DC_PermanentMagnet;