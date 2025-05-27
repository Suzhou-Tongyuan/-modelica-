within Modelica.Electrical.QuasiStatic.Machines.Interfaces;
partial model PartialBasicTransformer 
  "三相变压器的部分模型"
  extends Modelica.Electrical.Machines.Icons.QuasiStaticTransformer;
  constant Integer m(min=1) = 3 "相数";
  constant String VectorGroup="Yy00";
  parameter Real n(start=1) 
    "主/次电压（线对线）比";
  parameter SI.Resistance R1(start=5E-3/(if C1 == "D" then 1 
         else 3)) "TRef时每相主绕组电阻" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter SI.Temperature T1Ref(start=293.15) 
    "主绕组电阻的参考温度" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20_1(start=0) 
    "20°C时主绕组电阻的温度系数" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter SI.Inductance L1sigma(start=78E-6/(if C1 == "D" 
         then 1 else 3)) "每相主绕组漏感" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter SI.Resistance R2(start=5E-3/(if C2 == "d" then 1 
         else 3)) "TRef时每相次绕组电阻" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter SI.Temperature T2Ref(start=293.15) 
    "次绕组电阻的参考温度" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20_2(start=0) 
    "20°C时次绕组电阻的温度系数" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter SI.Inductance L2sigma(start=78E-6/(if C2 == "d" 
         then 1 else 3)) "每相次绕组漏感" 
    annotation (Dialog(tab="名义电阻和电感"));
  parameter Boolean useThermalPort=false 
    "启用/禁用（=固定温度）热端口" 
    annotation (Evaluate=true);
  parameter SI.Temperature T1Operational(start=293.15) 
    "主绕组电阻的工作温度" annotation (Dialog(
        group="操作温度", enable=not useThermalPort));
  parameter SI.Temperature T2Operational(start=293.15) 
    "次绕组电阻的工作温度" annotation (Dialog(
        group="操作温度", enable=not useThermalPort));
  output Modelica.Electrical.Machines.Interfaces.PowerBalanceTransformer 
    powerBalance(
    final power1=sum({Modelica.ComplexMath.real(v1[j]* 
        Modelica.ComplexMath.conj(i1[j])) for j in 1:m}), 
    final power2=sum({Modelica.ComplexMath.real(v2[j]* 
        Modelica.ComplexMath.conj(-i2[j])) for j in 1:m}), 
    final lossPower1=-sum(r1.resistor.LossPower), 
    final lossPower2=-sum(r2.resistor.LossPower), 
    final lossPowerCore=0) "功率平衡";
  output SI.ComplexVoltage v1[m]=plug1.pin.v 
    "主电压";
  output SI.ComplexCurrent i1[m]=plug1.pin.i 
    "主电流";
  output SI.ComplexVoltage v2[m]=plug2.pin.v 
    "次电压";
  output SI.ComplexCurrent i2[m]=plug2.pin.i 
    "次电流";
protected
  constant String C1=Modelica.Utilities.Strings.substring(
          VectorGroup, 
          1, 
          1);
  constant String C2=Modelica.Utilities.Strings.substring(
          VectorGroup, 
          2, 
          2);
  parameter Real ni=n*(if C2 == "z" then sqrt(3) else 2)*(if C2 == "d" 
       then 1 else sqrt(3))/(if C1 == "D" then 1 else sqrt(3));
public
  QuasiStatic.Polyphase.Interfaces.PositivePlug plug1(final m=m) "主插头" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  QuasiStatic.Polyphase.Interfaces.NegativePlug plug2(final m=m) 
    "次插头" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  QuasiStatic.Polyphase.Basic.Resistor r1(
    final m=m, 
    final R_ref=fill(R1, m), 
    final T_ref=fill(T1Ref, m), 
    final alpha_ref=fill(Modelica.Electrical.Machines.Thermal.convertAlpha(
        alpha20_1, T1Ref), m), 
    final useHeatPort=true, 
    final T=fill(T1Ref, m)) 
    annotation (Placement(transformation(extent={{-90,10},{-70,-10}})));
  QuasiStatic.Polyphase.Basic.Inductor l1sigma(final m=m, final L=fill(L1sigma, 
        m)) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  QuasiStatic.Polyphase.Basic.Resistor r2(
    final m=m, 
    final R_ref=fill(R2, m), 
    final T_ref=fill(T2Ref, m), 
    final alpha_ref=fill(Modelica.Electrical.Machines.Thermal.convertAlpha(
        alpha20_2, T2Ref), m), 
    final useHeatPort=true, 
    final T=fill(T2Ref, m)) 
    annotation (Placement(transformation(extent={{70,10},{90,-10}})));
  QuasiStatic.Polyphase.Basic.Inductor l2sigma(final m=m, final L=fill(L2sigma, 
        m)) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  QuasiStatic.Machines.BasicMachines.Components.IdealCore core(
    final m=m, 
    final n12=ni, 
    final n13=ni) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Machines.Interfaces.ThermalPortTransformer 
    thermalPort if useThermalPort 
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Machines.Thermal.ThermalAmbientTransformer 
    thermalAmbient(
    final useTemperatureInputs=false, 
    final T1=T1Operational, 
    final T2=T2Operational) if not useThermalPort annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-30,80})));
protected
  Modelica.Electrical.Machines.Interfaces.ThermalPortTransformer 
    internalThermalPort 
    annotation (Placement(transformation(extent={{-4,76},{4,84}})));
equation
  connect(r1.plug_n, l1sigma.plug_p) 
    annotation (Line(points={{-70,0},{-70,0}}, color={85,170,255}));
  connect(l2sigma.plug_n, r2.plug_p) 
    annotation (Line(points={{70,0},{70,0}}, color={85,170,255}));
  connect(plug1, r1.plug_p) 
    annotation (Line(points={{-100,0},{-90,0}}, color={85,170,255}));
  connect(r2.plug_n, plug2) 
    annotation (Line(points={{90,0},{100,0}}, color={85,170,255}));
  connect(thermalPort, internalThermalPort) annotation (Line(
      points={{0,100},{0,80}}, color={191,0,0}));
  connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
      points={{-20,80},{0,80}}, color={191,0,0}));
  connect(r1.heatPort, internalThermalPort.heatPort1) annotation (Line(
      points={{-80,10},{-80,60},{-0.4,60},{-0.4,80.8}}, color={191,0,0}));
  connect(r2.heatPort, internalThermalPort.heatPort2) annotation (Line(
      points={{80,10},{80,60},{-0.4,60},{-0.4,79.2}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Text(
          extent={{150,-60},{-150,-100}}, 
          textString="%VectorGroup"), Text(
          extent={{150,100},{-150,60}}, 
          textColor={0,0,255}, 
          textString="%name")}), Documentation(info="<html>
三相变压器的部分模型，包含主次电阻和漏感，以及铁芯。
主绕组和次绕组的电路布局（矢量组）必须定义。
<br><strong>变压器参数的默认值（一个实际的例子）如下：</strong><br>
<table>
<tr>
<td>变比 n</td>
<td>1</td><td> </td>
</tr>
<tr>
<td>名义频率 fNominal</td>
<td>50</td><td>Hz</td>
</tr>
<tr>
<td>每相名义电压</td>
<td>100</td><td>V RMS</td>
</tr>
<tr>
<td>每相名义电流</td>
<td>100</td><td>A RMS</td>
</tr>
<tr>
<td>名义视在功率</td>
<td>30</td><td>kVA</td>
</tr>
<tr>
<td>主电阻 R1</td>
<td>0.005</td><td>参考温度下每相的欧姆数</td>
</tr>
<tr>
<td>参考温度 T1Ref</td>
<td>20</td><td>℃</td>
</tr>
<tr>
<td>温度系数 alpha20_1 </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>主漏感 L1sigma</td>
<td>78E-6</td><td>每相的亨利数</td>
</tr>
<tr>
<td>次电阻 R2</td>
<td>0.005</td><td>参考温度下每相的欧姆数</td>
</tr>
<tr>
<td>参考温度 T2Ref</td>
<td>20</td><td>℃</td>
</tr>
<tr>
<td>温度系数 alpha20_2 </td>
<td>0</td><td>1/K</td>
</tr>
<tr>
<td>次漏感 L2sigma</td>
<td>78E-6</td><td>每相的亨利数</td>
</tr>
<tr>
<td>主电阻工作温度 T1Operational</td>
<td>20</td><td>℃</td>
</tr>
<tr>
<td>次电阻工作温度 T2Operational</td>
<td>20</td><td>℃</td>
</tr>
<tr>
<td>这些值给出以下操作参数：</td>
<td> </td><td> </td>
</tr>
<tr>
<td>名义电压降</td>
<td>0.05</td><td>标幺值</td>
</tr>
<tr>
<td>名义铜损耗</td>
<td>300</td><td>W</td>
</tr>
</table>
</html>"));
end PartialBasicTransformer;