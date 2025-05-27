within Modelica.Magnetic.QuasiStatic.FundamentalWave.BaseClasses;
partial model Machine "基本机型"
  constant SI.Angle pi = Modelica.Constants.pi;
  extends Modelica.Electrical.Machines.Icons.QuasiStaticFundamentalWaveMachine;
  parameter Integer m(min=3) = 3 "定子相数" annotation(Evaluate=true);
  // 机械参数
  parameter SI.Inertia Jr(start=0.29) "转子惯性";
  parameter Boolean useSupport=false 
    "启用/禁用（=固定定子）支持" annotation (Evaluate=true);
  parameter SI.Inertia Js(start=Jr) "定子惯性" 
    annotation (Dialog(enable=useSupport));
  parameter Boolean useThermalPort=false 
    "启用/禁用（=固定温度）热敏端口" 
    annotation (Evaluate=true);
  parameter Integer p(min=1, start=2) "极对数（整数）";
  parameter SI.Frequency fsNominal(start=50) 
    "标称频率";
  parameter SI.Temperature TsOperational(start=293.15) 
    "定子电阻的工作温度" annotation (Dialog(
        group="Operational temperatures", enable=not useThermalPort));
  parameter SI.Resistance Rs(start=0.03) 
    "TRef 时每相定子电阻" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TsRef(start=293.15) 
    "定子电阻参考温度" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter
    Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 
    alpha20s(start=0) 
    "20 摄氏度时定子电阻的温度系数" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Real effectiveStatorTurns=1 
    "定子有效匝数";
  parameter SI.Inductance Lssigma(start=3*(1 - sqrt(1 - 
        0.0667))/(2*pi*fsNominal)) "Stator stray inductance per phase" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Magnetic.FundamentalWave.Types.SalientInductance L0(d(start=1), q(
        start=1)) "Salient inductance of an unchorded coil" 
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.Electrical.Machines.Losses.FrictionParameters 
    frictionParameters(wRef=2*pi*fsNominal/p) 
    "摩擦损失参数记录" annotation (Dialog(tab="Losses"));
  parameter Modelica.Electrical.Machines.Losses.CoreParameters 
    statorCoreParameters(
    final m=m, 
    wRef=2*pi*fsNominal/p, 
    VRef(start=100)) 
    "定子铁芯损耗参数记录；所有参数均指定子侧" 
    annotation (Dialog(tab="Losses"));
  parameter Modelica.Electrical.Machines.Losses.StrayLoadParameters 
    strayLoadParameters(IRef(start=100), wRef=2*pi*fsNominal/p) 
    "杂散负载损耗参数记录" annotation (Dialog(tab="Losses"));
  output SI.Angle gammas(start=0) = airGap.gammas 
    "定子参照系角度";
  output SI.Angle gammar(start=0) = airGap.gammar 
    "定子参照系角度";
  output SI.Angle gamma(start=0) = airGap.gamma 
    "定子和转子之间的电角度";
  // 机械量
  output SI.Angle phiMechanical=flange.phi - 
      internalSupport.phi "转子对定子的机械角度";
  output SI.AngularVelocity wMechanical(
    start=0, 
    displayUnit="rev/min") = der(phiMechanical) 
    "转子对定子的机械角速度";
  output SI.Torque tauElectrical=inertiaRotor.flange_a.tau 
    "电磁扭矩";
  output SI.Torque tauShaft=-flange.tau "轴扭矩";
  replaceable output
    Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines 
    powerBalance(
    final powerStator= 
        Modelica.Electrical.QuasiStatic.Polyphase.Functions.activePower(
                                                               vs, 
        is), 
    final powerMechanical=wMechanical*tauShaft, 
    final powerInertiaStator=inertiaStator.J*inertiaStator.a* 
        inertiaStator.w, 
    final powerInertiaRotor=inertiaRotor.J*inertiaRotor.a*inertiaRotor.w, 
    final lossPowerStatorWinding=sum(stator.resistor.resistor.LossPower), 
    final lossPowerStatorCore=stator.core.lossPower, 
    final lossPowerStrayLoad=strayLoad.lossPower, 
    final lossPowerFriction=friction.lossPower) "Power balance";

  // 定子电压和电流
  output SI.ComplexVoltage vs[m]=plug_sp.pin.v - plug_sn.pin.v 
    "复合定子电压";
  SI.Voltage abs_vs[m]=Modelica.ComplexMath.abs(vs) 
    "复定子电压幅值";
  SI.Angle arg_vs[m]=Modelica.ComplexMath.arg(vs) 
    "复定子电压参数";

  output SI.ComplexCurrent is[m]=plug_sp.pin.i 
    "复合定子电流";
  SI.Current abs_is[m]=Modelica.ComplexMath.abs(is) 
    "复定子电流的幅值";
  SI.Angle arg_is[m]=Modelica.ComplexMath.arg(is) 
    "复定子电流参数";

  SI.ActivePower Ps[m]={Modelica.ComplexMath.real(vs[k]* 
      Modelica.ComplexMath.conj(is[k])) for k in 1:m} 
    "有功定子功率";
  SI.ActivePower Ps_total=sum(Ps) 
    "有功定子总功率";
  SI.ReactivePower Qs[m]={Modelica.ComplexMath.imag(vs[k]* 
      Modelica.ComplexMath.conj(is[k])) for k in 1:m} 
    "定子无功功率";
  SI.ReactivePower Qs_total=sum(Qs) 
    "定子总无功功率";
  SI.ApparentPower Ss[m]={Modelica.ComplexMath.abs(vs[k]* 
      Modelica.ComplexMath.conj(is[k])) for k in 1:m} 
    "复合定子视在功率的大小";
  SI.ApparentPower Ss_total=sqrt(Ps_total^2 + Qs_total^2) 
    "定子总复杂视在功率的大小";
  Real pfs[m]={cos(Modelica.ComplexMath.arg(Complex(Ps[k], Qs[k]))) for k in 
          1:m} "定子功率因数";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "轴" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J= 
        Jr) annotation (Placement(transformation(
        origin={80,0}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport 
    "反作用扭矩作用的支撑点" annotation (
      Placement(transformation(extent={{90,-110},{110,-90}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J= 
        Js) annotation (Placement(transformation(
        origin={80,-100}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={70,-90})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.PositivePlug 
    plug_sp(final m=m) "定子正极插头" annotation (Placement(
        transformation(extent={{50,90},{70,110}})));
  Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.NegativePlug 
    plug_sn(final m=m) "定子负极插头" annotation (Placement(
        transformation(extent={{-70,90},{-50,110}})));
  BasicMachines.Components.SymmetricPolyphaseWinding stator(
    final useHeatPort=true, 
    final m=m, 
    final RRef=Rs, 
    final TRef=TsRef, 
    final Lsigma=Lssigma, 
    final effectiveTurns=effectiveStatorTurns, 
    final TOperational=TsOperational, 
    final GcRef=statorCoreParameters.GcRef, 
    final alpha20=alpha20s) 
    "对称定子绕组，包括电阻、零电感和杂散电感以及铁芯损耗" 
    annotation (Placement(transformation(
        origin={0,40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  replaceable
    Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines 
    thermalAmbient(
    final useTemperatureInputs=false, 
    final Ts=TsOperational, 
    final m=m) if not useThermalPort annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-70,-90})));
  replaceable
    Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines 
    thermalPort(final m=m) if useThermalPort 
    "感应机器的热端口" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Magnetic.QuasiStatic.FundamentalWave.Components.Ground groundS 
    "定子磁路接地" 
    annotation (Placement(transformation(extent={{-40,30},{-20,10}})));
  BasicMachines.Components.RotorSaliencyAirGap airGap(final p=p, final L0= 
       L0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Magnetic.QuasiStatic.FundamentalWave.Components.Ground groundR 
    "转子磁路接地" 
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Losses.StrayLoad strayLoad(
    final strayLoadParameters=strayLoadParameters, 
    final useHeatPort=true, 
    final m=m) 
    annotation (Placement(transformation(extent={{60,60},{40,80}})));
  Modelica.Electrical.Machines.Losses.Friction friction(final
      frictionParameters=frictionParameters, final useHeatPort=true) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={90,-30})));
  replaceable
    Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines 
    internalThermalPort(final m=m) 
    annotation (Placement(transformation(extent={{-44,-94},{-36,-86}})));
  Modelica.Mechanics.Rotational.Interfaces.Support internalSupport 
    annotation (Placement(transformation(extent={{56,-104},{64,-96}})));
initial algorithm
  assert(not Modelica.Math.isPowerOf2(m), String(m) + 
    " phases are currently not supported in this version of FundametalWave");

equation
  connect(stator.plug_n, plug_sn) annotation (Line(
      points={{-10,50},{-10,70},{-60,70},{-60,100}}, color={85,170,255}));
  connect(inertiaRotor.flange_b, flange) 
    annotation (Line(points={{90,0},{100,0},{100,0}}));
  connect(internalSupport, inertiaStator.flange_a) annotation (Line(
      points={{60,-100},{70,-100}}));
  connect(internalSupport, fixed.flange) annotation (Line(
      points={{60,-100},{60,-90},{70,-90}}));
  connect(inertiaStator.flange_b, support) annotation (Line(points={{90,-100}, 
          {90,-100},{100,-100}}));
  connect(airGap.flange_a, inertiaRotor.flange_a) annotation (Line(
      points={{10,0},{25,0},{25,0},{40,0},{40,0},{70,0}}));
  connect(airGap.support, internalSupport) annotation (Line(
      points={{-10,0},{-50,0},{-50,-70},{60,-70},{60,-100}}));
  connect(groundR.port_p, airGap.port_rn) annotation (Line(points={{-30,-10}, 
          {-30,-10},{-10,-10}}, color={255,170,85}));
  connect(stator.plug_p, strayLoad.plug_n) annotation (Line(
      points={{10,50},{10,70},{40,70}}, color={85,170,255}));
  connect(plug_sp, strayLoad.plug_p) annotation (Line(
      points={{60,100},{60,94},{60,94},{60,86},{60,86},{60,70}}, color={85,170,255}));
  connect(strayLoad.support, internalSupport) annotation (Line(
      points={{50,60},{50,50},{60,50},{60,-100}}));
  connect(strayLoad.heatPort, internalThermalPort.heatPortStrayLoad) 
    annotation (Line(
      points={{60,60},{60,50},{50,50},{50,-80},{-39.6,-80},{-39.6,-90}}, 
                                                                     color={191,0,0}));
  connect(friction.support, internalSupport) annotation (Line(
      points={{90,-40},{90,-70},{60,-70},{60,-100}}));
  connect(strayLoad.flange, inertiaRotor.flange_b) annotation (Line(
      points={{50,80},{90,80},{90,0}}));
  connect(friction.flange, inertiaRotor.flange_b) annotation (Line(
      points={{90,-20},{90,0}}));
  connect(friction.heatPort, internalThermalPort.heatPortFriction) 
    annotation (Line(
      points={{80,-40},{50,-40},{50,-80},{-40,-80},{-40,-91.6}}, 
                                                               color={191,0,0}));
  connect(groundS.port_p, airGap.port_sp) annotation (Line(
      points={{-30,10},{-10,10}}, color={255,170,85}));
  connect(stator.port_n, airGap.port_sp) annotation (Line(
      points={{-10,30},{-10,10}}, color={255,170,85}));
  connect(stator.port_p, airGap.port_sn) annotation (Line(
      points={{10,30},{10,10}}, color={255,170,85}));
  connect(stator.heatPortWinding, internalThermalPort.heatPortStatorWinding) 
    annotation (Line(
      points={{-10,44},{-40.4,44},{-40.4,-89.2}}, 
                                                color={191,0,0}));
  connect(stator.heatPortCore, internalThermalPort.heatPortStatorCore) 
    annotation (Line(
      points={{-10,36},{-39.6,36},{-39.6,-89.2}}, 
                                                color={191,0,0}));
  connect(thermalAmbient.thermalPort, internalThermalPort) annotation (
      Line(points={{-60,-90},{-50,-90},{-40,-90}}, color={191,0,0}));
  connect(internalThermalPort, thermalPort) annotation (Line(points={{-40, 
          -90},{-20,-90},{0,-90},{0,-100}}, color={191,0,0}));
  annotation (
    Documentation(info="<html>
<p>这种感应机器的局部模型包含所有机器模型的共同要素.</p>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{80,-80},{120,-120}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-50,100},{-20,100},{-20,70}}, color={85,170,255}), 
        Line(points={{50,100},{20,100},{20,70}}, color={85,170,255}), 
        Text(
          extent={{-150,-120},{150,-160}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Line(
          visible=not useSupport, 
          points={{80,-100},{120,-100}}), 
        Line(
          visible=not useSupport, 
          points={{90,-100},{80,-120}}), 
        Line(
          visible=not useSupport, 
          points={{100,-100},{90,-120}}), 
        Line(
          visible=not useSupport, 
          points={{110,-100},{100,-120}}), 
        Line(
          visible=not useSupport, 
          points={{120,-100},{110,-120}})}));
end Machine;