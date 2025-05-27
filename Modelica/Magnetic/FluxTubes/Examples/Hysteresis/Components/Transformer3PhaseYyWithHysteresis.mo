within Modelica.Magnetic.FluxTubes.Examples.Hysteresis.Components;
model Transformer3PhaseYyWithHysteresis 
  "Yy 配置的三相变压器"

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Temp 
    annotation (Placement(transformation(extent={{-166,14},{-154,26}})));

  // Tab: 电气 //Group:初级绕组
  parameter Integer N1=10 "初级匝线" 
    annotation(Dialog(tab="Electrical", group="Primary winding"));
  parameter SI.Length L1(displayUnit="mm") = 1.2*2*(a+b) 
    "平均初级匝线长度" 
    annotation(Dialog(tab="Electrical", group="Primary winding"));
  parameter SI.Length d1(displayUnit="mm") = 0.5e-3 
    "初级匝线直径" 
    annotation(Dialog(tab="Electrical", group="Primary winding"));
  parameter SI.Resistivity rho1 = 1.678e-8 
    "初级绕组电阻率（20 摄氏度时）" 
    annotation(Dialog(tab="Electrical", group="Primary winding"));
  parameter SI.LinearTemperatureCoefficient alpha1 = 0 
    "初级匝数的温度系数" annotation(Dialog(tab="Electrical", group="Primary winding"));

  // Tab: 电气 //Group:次级绕组
  parameter Integer N2=10 "次级匝线" 
     annotation(Dialog(tab="Electrical", group="Secondary winding"));
  parameter SI.Length L2(displayUnit="mm") = L1 
    "平均次级匝线长度" 
    annotation(Dialog(tab="Electrical", group="Secondary winding"));
  parameter SI.Length d2(displayUnit="mm") = d1 
    "次级匝线直径" 
    annotation(Dialog(tab="Electrical", group="Secondary winding"));
  parameter SI.Resistivity rho2 = rho1 
    "次级绕组电阻率（20 摄氏度时）" 
    annotation(Dialog(tab="Electrical", group="Secondary winding"));

  parameter SI.LinearTemperatureCoefficient alpha2 = alpha1 
    "次级匝数的温度系数" annotation(Dialog(tab="Electrical", group="Secondary winding"));

  parameter SI.Length l1(displayUnit="mm") = 40e-3 
    "核心平均长度 l1" annotation (Dialog(tab="Core", group="Geometry", groupImage="modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/Components/Transformer3PhaseYyWithHysteresis/Core_ThreePhase1.png"));
  parameter SI.Length l2(displayUnit="mm") = 60e-3 
    "核心平均长度 l2" annotation (Dialog(tab="Core", group="Geometry"));
  parameter SI.Length a(displayUnit="mm") = 15e-3 "核心高度" annotation (Dialog(tab="Core", group="Geometry"));
  parameter SI.Length b(displayUnit="mm") = 10e-3 "芯材宽度" annotation (Dialog(tab="Core", group="Geometry"));

  parameter FluxTubes.Material.HysteresisEverettParameter.BaseData mat= 
      FluxTubes.Material.HysteresisEverettParameter.BaseData() 
    "核心材料" annotation (Dialog(tab="Core", group="Material"), 
      choicesAllMatching=true);

  output SI.Voltage v1[3] "初级绕组电压降 1-3";
  output SI.Voltage v2[3] "次级绕组电压降 1-3";

  output SI.Resistance R1[3] "初级绕组电阻 1-3";
  output SI.Resistance R2[3] "次级绕组电阻 1-3";

  output SI.Current i1[3] "初级绕组电流 1-3";
  output SI.Current i2[3] "次级绕组电流 1-3";

  output SI.MagneticFluxDensity B[3] 
    "磁芯 1-3 部分的磁通密度";
  output SI.MagneticFlux Phi[3] 
    "通过磁芯 1-3 部分的磁通量";

  output SI.MagneticFieldStrength Hstat[3] 
    "磁场强度的铁磁部分";
  output SI.MagneticFieldStrength Heddy[3] 
    "磁场强度的涡流部分";
  output SI.MagneticFieldStrength H[3] 
    "磁芯总磁场强度";

  //输出 SI.Resistance R1

  parameter Real MagRelStart[3]={0,0,0} 
    "磁芯初始磁化强度(-1…1)" annotation (Dialog(tab="Core", group="Initialization"));
  parameter Boolean MagRelFixed[3] = {false,false,false} "Fixed" annotation (Dialog(tab="Core", group="Initialization"));

  parameter SI.MagneticFieldStrength HStart[3]={0,0,0} 
    "磁芯的初始磁场强度" annotation (Dialog(tab="Core", group="Initialization"));
  parameter Boolean HFixed[3] = {false,false,false} "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

  parameter SI.ElectricCurrent I1Start[3]={0,0,0} 
    "初级绕组的初始电流" annotation (Dialog(tab="Core", group="Initialization"));
  parameter Boolean I1Fixed[3] = {false,false,false} "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

  parameter SI.ElectricCurrent I2Start[3]={0,0,0} 
    "二次绕组初始电流" annotation (Dialog(tab="Core", group="Initialization"));
  parameter Boolean I2Fixed[3] = {false,false,false} "Fixed" annotation (Dialog(tab="Core", group="Initialization"),choices(checkBox=true));

  output SI.Power LossPowerWinding "绕组的损失";
  output SI.Power LossPowerStat "铁磁滞回损耗";
  output SI.Power LossPowerEddy "涡流损耗";

  extends Interfaces.ConditionalHeatPort;
  parameter Boolean EddyCurrents = false "启用涡流" annotation(Dialog(tab="Losses and heat", group="Eddy currents"), choices(checkBox=true));
  parameter SI.Conductivity sigma = mat.sigma 
    "芯材的导电性" annotation (Dialog(tab="Losses and heat", group="Eddy currents", enable=EddyCurrents));
  parameter SI.Length t(displayUnit="mm") = 0.5e-3 
    "层压板厚度" annotation (Dialog(tab="Losses and heat", group="Eddy currents", enable=EddyCurrents));

  parameter SI.Length L_l1=10e-3 "初级绕组泄漏长度" annotation (Dialog(tab="Leakage"));
  parameter SI.Area A_l1=10e-6 
    "主绕组泄漏截面图" annotation (Dialog(tab="Leakage"));
  parameter Real mu_rel1=1 
    "一次泄漏的恒定相对渗透率（要求 >0）" annotation (Dialog(tab="Leakage"));
  parameter SI.Length L_l2=10e-3 
    "次级绕组泄漏截面图" annotation (Dialog(tab="Leakage"));
  parameter SI.Area A_l2=10e-6 "次级绕组泄漏长度" annotation (Dialog(tab="Leakage"));
  parameter Real mu_rel2=1 
    "恒定的二次泄漏相对渗透率（要求 >0）" annotation (Dialog(tab="Leakage"));

  Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core1(
    mat=mat, 
    A=a*b, 
    sigma=sigma, 
    d=t, 
    useHeatPort=false, 
    includeEddyCurrents=EddyCurrents, 
    l=l1 + 2*l2, 
    H(start=HStart[1], fixed=HFixed[1]), 
    MagRel(start=MagRelStart[1], fixed=MagRelFixed[1])) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        origin={-40,114})));
  Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core2(
    mat=mat, 
    A=a*b, 
    sigma=sigma, 
    d=t, 
    useHeatPort=false, 
    includeEddyCurrents=EddyCurrents, 
    l=l2, 
    H(start=HStart[2], fixed=HFixed[2]), 
    MagRel(start=MagRelStart[2], fixed=MagRelFixed[2])) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={10,92})));

  Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core3(
    mat=mat, 
    A=a*b, 
    includeEddyCurrents=EddyCurrents, 
    sigma=sigma, 
    d=t, 
    l=l1 + 2*l2, 
    H(start=HStart[3], fixed=HFixed[3]), 
    MagRel(start=MagRelStart[3], fixed=MagRelFixed[3])) 
    annotation (Placement(transformation(extent={{70,104},{90,124}})));

  Basic.Ground ground 
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));

  Basic.ElectroMagneticConverterWithLeakageInductance winding11(
    N=N1, 
    L=L_l1, 
    A=A_l1, 
    mu_rel=mu_rel1, 
    i(start=I1Start[1], fixed=I1Fixed[1])) annotation (Placement(transformation(extent={{-110,40},{-90,60}})));

  Basic.ElectroMagneticConverterWithLeakageInductance winding12(
    L=L_l1, 
    A=A_l1, 
    mu_rel=mu_rel1, 
    i(start=I1Start[2], fixed=I1Fixed[2]), 
    final N=N1) annotation (Placement(transformation(extent={{-10,40},{10,60}})));

  Basic.ElectroMagneticConverterWithLeakageInductance winding13(
    N=N1, 
    L=L_l1, 
    A=A_l1, 
    mu_rel=mu_rel1, 
    i(start=I1Start[3], fixed=I1Fixed[3])) annotation (Placement(transformation(extent={{110,40},{130,60}})));

   Basic.ElectroMagneticConverterWithLeakageInductance winding21(
    N=N2, 
    L=L_l2, 
    A=A_l2, 
    mu_rel=mu_rel2, 
    i(start=I2Start[1], fixed=I2Fixed[1])) annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));

   Basic.ElectroMagneticConverterWithLeakageInductance winding22(
    N=N2, 
    L=L_l2, 
    A=A_l2, 
    mu_rel=mu_rel2, 
    i(start=I2Start[1], fixed=I2Fixed[1])) annotation (Placement(transformation(extent={{-10,-20},{10,0}})));

  Basic.ElectroMagneticConverterWithLeakageInductance winding23(
    N=N2, 
    L=L_l2, 
    A=A_l2, 
    mu_rel=mu_rel2, 
    i(start=I2Start[1], fixed=I2Fixed[1])) annotation (Placement(transformation(extent={{110,-20},{130,0}})));

  Modelica.Electrical.Analog.Basic.Resistor resistor11(
    R=rho1*N1*L1/(pi/4*d1^2), 
    useHeatPort=true, 
    alpha=alpha1, 
    T_ref=293.15) annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor21(
    R=rho2*N2*L2/(pi/4*d2^2), 
    useHeatPort=true, 
    alpha=alpha2, 
    T_ref=293.15) annotation (Placement(transformation(extent={{-120,-10},{-140,10}})));

  Modelica.Electrical.Analog.Basic.Resistor resistor12(
    R=rho1*N1*L1/(pi/4*d1^2), 
    useHeatPort=true, 
    alpha=alpha1, 
    T_ref=293.15) annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor22(
    R=rho2*N2*L2/(pi/4*d2^2), 
    useHeatPort=true, 
    alpha=alpha2, 
    T_ref=293.15) annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));

  Modelica.Electrical.Analog.Basic.Resistor resistor23(
    R=rho2*N2*L2/(pi/4*d2^2), 
    useHeatPort=true, 
    alpha=alpha2, 
    T_ref=293.15) annotation (Placement(transformation(extent={{100,-10},{80,10}})));

  Modelica.Electrical.Analog.Basic.Resistor resistor13(
    R=rho1*N1*L1/(pi/4*d1^2), 
    useHeatPort=true, 
    alpha=alpha1, 
    T_ref=293.15) annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Shapes.FixedShape.Cuboid leakage(
    nonLinearPermeability=false, 
    mu_rConst=1, 
    l=l2, 
    a=a, 
    b=b/1000) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={32,90})));

  Modelica.Electrical.Analog.Interfaces.PositivePin p1 "初级绕组 1" annotation (Placement(transformation(extent={{-170,50},{-150,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2 "初级绕组 2" annotation (Placement(transformation(extent={{-70,50},{-50,70}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p3 "初级绕组 3" annotation (Placement(transformation(extent={{50,50},{70,70}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 "次级绕组 1" 
    annotation (Placement(transformation(extent={{-170,-10},{-150,10}}), 
        iconTransformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2 "次级绕组 2" 
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}}), 
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n3 "次级绕组 3" 
    annotation (Placement(transformation(extent={{50,-10},{70,10}}), 
        iconTransformation(extent={{90,-70},{110,-50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin starPoint2 "次级绕组的星形点" annotation (Placement(transformation(extent={{-120,-44},{-100,-24}}), iconTransformation(extent={{30,-110},{50,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin starPoint1 "初级绕组的星形点" annotation (Placement(transformation(extent={{-120,20},{-100,40}}), iconTransformation(extent={{-50,-110},{-30,-90}})));

equation
  v1[1] =resistor11.p.v - winding11.n.v;
  v1[2] =resistor12.p.v - winding12.n.v;
  v1[3] =resistor13.p.v - winding13.n.v;
  i1[1] =resistor11.i;
  i1[2] =resistor12.i;
  i1[3] =resistor13.i;
  R1[1] =resistor11.R_actual;
  R1[2] =resistor12.R_actual;
  R1[3] =resistor13.R_actual;

  v2[1] =resistor21.n.v - winding21.n.v;
  v2[2] =resistor21.n.v - winding21.n.v;
  v2[3] =resistor21.n.v - winding21.n.v;
  i2[1] =resistor21.i;
  i2[2] =resistor22.i;
  i2[3] =resistor23.i;
  R2[1] =resistor21.R_actual;
  R2[2] =resistor22.R_actual;
  R2[3] =resistor23.R_actual;

  B[1] =core1.B;
  B[2] =core2.B;
  B[3] =core3.B;

  Phi[1] =core1.Phi;
  Phi[2] =core2.Phi;
  Phi[3] =core3.Phi;

  Hstat[1] =core1.Hstat;
  Hstat[2] =core2.Hstat;
  Hstat[3] =core3.Hstat;
  Heddy[1] =core1.Heddy;
  Heddy[2] =core2.Heddy;
  Heddy[3] =core3.Heddy;
  H[1] =core1.H;
  H[2] =core2.H;
  H[3] =core3.H;

  Temp.T = if useHeatPort then T_heatPort else T;

  LossPowerWinding =resistor11.LossPower + resistor12.LossPower + resistor13.LossPower + resistor21.LossPower + resistor22.LossPower + resistor23.LossPower;
  LossPowerStat =core1.LossPowerStat  +core2.LossPowerStat  +core3.LossPowerStat;
  LossPowerEddy =core1.LossPowerEddy  +core2.LossPowerEddy  +core3.LossPowerEddy;
  LossPower = LossPowerWinding + LossPowerEddy + LossPowerStat;

  connect(winding11.port_n, winding21.port_p) annotation (Line(points={{-90,40},{-90,0}}, color={255,127,0}));
  connect(winding11.p, resistor11.n) annotation (Line(points={{-110,60},{-116,60},{-116,60},{-120,60}}, color={0,0,255}));
  connect(resistor11.p, p1) annotation (Line(points={{-140,60},{-160,60}}, color={0,0,255}));
  connect(winding12.p, resistor12.n) annotation (Line(points={{-10,60},{-16,60},{-16,60},{-20,60}}, color={0,0,255}));
  connect(winding13.p, resistor13.n) annotation (Line(points={{110,60},{104,60},{104,60},{100,60}}, color={0,0,255}));
  connect(winding12.port_p, core2.port_n) annotation (Line(points={{10,60},{10,82}}, color={255,127,0}));
  connect(winding12.port_n, winding22.port_p) annotation (Line(points={{10,40},{10,0}}, color={255,127,0}));
  connect(winding21.port_n, ground.port) annotation (Line(points={{-90,-20},{-90,-60},{10,-60}}, color={255,127,0}));
  connect(ground.port, winding22.port_n) annotation (Line(points={{10,-60},{10,-20}}, color={255,127,0}));
  connect(winding23.port_n, ground.port) annotation (Line(points={{130,-20},{130,-60},{10,-60}}, color={255,127,0}));
  connect(winding23.port_p, winding13.port_n) annotation (Line(points={{130,0},{130,40}}, color={255,127,0}));
  connect(winding13.port_p, core3.port_n) annotation (Line(points={{130,60},{130,114},{90,114}}, color={255,127,0}));
  connect(p2, resistor12.p) annotation (Line(points={{-60,60},{-40,60}}, color={0,0,255}));
  connect(p3, resistor13.p) annotation (Line(points={{60,60},{80,60}}, color={0,0,255}));
  connect(Temp.port, resistor11.heatPort) annotation (Line(points={{-154,20},{-130,20},{-130,50}}, color={191,0,0}));
  connect(resistor12.heatPort, Temp.port) annotation (Line(points={{-30,50},{-30,20},{-154,20}}, color={191,0,0}));
  connect(resistor13.heatPort, Temp.port) annotation (Line(points={{90,50},{90,20},{-154,20}}, color={191,0,0}));
  connect(resistor23.heatPort, Temp.port) annotation (Line(points={{90,-10},{46,-10},{46,20},{-154,20}}, color={191,0,0}));
  connect(resistor22.heatPort, Temp.port) annotation (Line(points={{-30,-10},{-80,-10},{-80,20},{-154,20}}, color={191,0,0}));
  connect(resistor21.heatPort, Temp.port) annotation (Line(points={{-130,-10},{-146,-10},{-146,20},{-154,20}}, color={191,0,0}));
  connect(resistor21.p, winding21.p) annotation (Line(points={{-120,0},{-110,0},{-110,0}}, color={0,0,255}));
  connect(resistor22.p, winding22.p) annotation (Line(points={{-20,0},{-10,0},{-10,0}}, color={0,0,255}));
  connect(resistor23.p, winding23.p) annotation (Line(points={{100,0},{110,0},{110,0}}, color={0,0,255}));
  connect(resistor21.n, n1) annotation (Line(points={{-140,0},{-160,0}}, color={0,0,255}));
  connect(resistor22.n, n2) annotation (Line(points={{-40,0},{-60,0}}, color={0,0,255}));
  connect(resistor23.n, n3) annotation (Line(points={{80,0},{60,0}}, color={0,0,255}));
  connect(leakage.port_n, ground.port) annotation (Line(
      points={{32,80},{32,-60},{10,-60}}, color={255,127,0}));
  connect(winding11.port_p, core1.port_n) annotation (Line(points={{-90,60},{-90,114},{-50,114}}, color={255,127,0}));
  connect(core1.port_p,core2. port_p) annotation (Line(
      points={{-30,114},{10,114},{10,102}}, color={255,127,0}));
  connect(core3.port_p,core1. port_p) annotation (Line(
      points={{70,114},{-30,114}}, color={255,127,0}));
  connect(leakage.port_p,core3. port_p) annotation (Line(
      points={{32,100},{32,114},{70,114}}, color={255,127,0}));

  connect(winding11.n, starPoint1) annotation (Line(points={{-110,40.2},{-110,30}}, color={0,0,255}));
  connect(starPoint1, winding13.n) annotation (Line(points={{-110,30},{110,30},{110,40.2}}, color={0,0,255}));
  connect(starPoint1, winding12.n) annotation (Line(points={{-110,30},{-10,30},{-10,40.2}}, color={0,0,255}));
  connect(winding21.n, starPoint2) annotation (Line(points={{-110,-19.8},{-110,-34}}, color={0,0,255}));
  connect(starPoint2, winding22.n) annotation (Line(points={{-110,-34},{-10,-34},{-10,-19.8}}, color={0,0,255}));
  connect(winding23.n, starPoint2) annotation (Line(points={{110,-19.8},{110,-34},{-110,-34}}, color={0,0,255}));

  annotation (defaultComponentName="transformer", Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-200, 
            -200},{200,200}})),     Icon(graphics={
        Polygon(
          points={{70,60},{50,40},{50,-40},{70,-60},{70,60}}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.VerticalCylinder), 
        Polygon(
          points={{-70,60},{-50,40},{-50,-40},{-70,-60},{-70,60}}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.VerticalCylinder), 
        Rectangle(
          extent={{-74,36},{-46,-36}}, 
          lineColor={128,0,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={128,0,255}), 
        Text(
          extent={{150,130},{-150,90}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Polygon(
          points={{-20,10},{0,-10},{1.22465e-016,-50},{-10,-60},{-20,-60},{-20,10}}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.VerticalCylinder, 
          origin={-60,-40}, 
          rotation=90), 
        Polygon(
          points={{-10,40},{0,50},{10,40},{10,-40},{0,-50},{-10,-40},{-10,40}}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.VerticalCylinder), 
        Polygon(
          points={{-20,-10},{0,10},{0,50},{-10,60},{-20,60},{-20,-10}}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.VerticalCylinder, 
          origin={60,-40}, 
          rotation=90), 
        Polygon(
          points={{20,10},{0,-10},{0,-50},{10,-60},{20,-60},{20,10}}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.VerticalCylinder, 
          origin={-60,40}, 
          rotation=90), 
        Polygon(
          points={{20,-10},{0,10},{0,50},{10,60},{20,60},{20,-10}}, 
          fillColor={255,128,0}, 
          fillPattern=FillPattern.VerticalCylinder, 
          origin={60,40}, 
          rotation=90), 
        Rectangle(
          extent={{-80,26},{-40,-26}}, 
          lineColor={0,128,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={0,128,255}), 
        Rectangle(
          extent={{-14,36},{14,-36}}, 
          lineColor={128,0,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={128,0,255}), 
        Rectangle(
          extent={{-20,26},{20,-26}}, 
          lineColor={0,128,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={0,128,255}), 
        Rectangle(
          extent={{46,36},{74,-36}}, 
          lineColor={128,0,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={128,0,255}), 
        Rectangle(
          extent={{40,26},{80,-26}}, 
          lineColor={0,128,255}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={0,128,255})}), 
    Documentation(info="<html>
<p>
一个简单的模型三相变压器与初级和次级绕组和磁性E-I型铁心。磁芯是用<a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.HysteresisAndMagnets. GenericHystTellinenEverett\">GenericHystTellinenEverett</a>磁通管元件。因此，该模型考虑了静滞和动滞以及初始磁链.
</p>

<table cellspacing=\"0\" cellpadding=\"2\" border=\"0\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Sketch of the modelled transformer with magnetic core, primary and secondary winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/Components/Transformer3PhaseYyWithHysteresis/Core_ThreePhase1.png\">
   </td>
  </tr>
</table>
</html>"));
end Transformer3PhaseYyWithHysteresis;