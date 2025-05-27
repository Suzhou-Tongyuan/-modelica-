within Modelica.Electrical.Analog.Examples;
model ResonanceCircuits 
  "利用共振电路生成FMUs(功能仿真单元)的示例"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  parameter SI.Capacitance C=0.01 "电容";
  parameter SI.Inductance L=0.01 "电感";
  final parameter SI.Frequency fRes=1/(2*pi*sqrt(L*C)) "Source frequency";
  parameter Real res=1 "f/fRes的数值";
  parameter SI.Frequency f=res*fRes "源频率";

  Modelica.Electrical.Analog.Sources.SineCurrent current1(I=1, f=f) 
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-90,50})));
  Modelica.Electrical.Analog.Basic.Ground ground1 
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor1(i(fixed=true, start=0), L=L) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-30,50})));
  Modelica.Electrical.Analog.Basic.Conductor conductor1(G=1) 
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={30,50})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor1(v(start=0, fixed=true), C=C) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={90,50})));
  Modelica.Electrical.Analog.Sources.SineVoltage voltage2(V=1, f=f) 
    annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=90, 
        origin={-90,-50})));
  Modelica.Electrical.Analog.Basic.Ground ground2 
    annotation (Placement(
        transformation(extent={{-100,-90},{-80,-70}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor2(i(fixed=true, start=0), L=L) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-30,-40})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=1) 
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={30,-40})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor2(v(start=0, fixed=true), C=C) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={90,-50})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor 
    voltageToCurrentAdaptor1a(use_pder=false,use_fder=false) 
    annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor 
    currentToVoltageAdaptor1a(use_pder=false,use_fder=false) 
    annotation (Placement(transformation(extent={{-40,40},{-60,60}})));
  Modelica.Electrical.Analog.Basic.Ground ground1a 
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor 
    currentToVoltageAdaptor1b(use_pder=false,use_fder=false) 
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor 
    voltageToCurrentAdaptor1b(use_pder=false,use_fder=false) 
    annotation (Placement(transformation(extent={{0,40},{20,60}})));

  Modelica.Electrical.Analog.Basic.Ground ground1b 
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor 
    voltageToCurrentAdaptor1c(use_pder=false,use_fder=false) 
    annotation (Placement(transformation(extent={{60,40},{40,60}})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor 
    currentToVoltageAdaptor1c(use_pder=false,use_fder=false) 
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Electrical.Analog.Basic.Ground ground1c 
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor 
    currentToVoltageAdaptor2a(use_fder=false,use_pder=false) 
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor 
    voltageToCurrentAdaptor2a(use_fder=false,use_pder=false) 
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Electrical.Analog.Basic.Ground ground2a 
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor 
    voltageToCurrentAdaptor2b(use_fder=false,use_pder=false) 
    annotation (Placement(transformation(extent={{0,-60},{-20,-40}})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor 
    currentToVoltageAdaptor2b(use_fder=false,use_pder=false) 
    annotation (Placement(transformation(extent={{20,-60},{0,-40}})));
  Modelica.Electrical.Analog.Basic.Ground ground2b 
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Modelica.Electrical.Analog.Basic.GeneralCurrentToVoltageAdaptor 
    currentToVoltageAdaptor2c(use_fder=false,use_pder=false) 
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Electrical.Analog.Basic.GeneralVoltageToCurrentAdaptor 
    voltageToCurrentAdaptor2c(use_fder=false,use_pder=false) 
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Electrical.Analog.Basic.Ground ground2c 
    annotation (Placement(transformation(extent={{80,-90},{100,-70}})));
equation
  connect(voltage2.n, ground2.p) 
    annotation (Line(points={{-90,-60},{-90,-70}}, color={0,0,255}));
  connect(ground1.p, current1.p) 
    annotation (Line(points={{-90,30},{-90,40}}, color={0,0,255}));
  connect(current1.n, voltageToCurrentAdaptor1a.pin_p) annotation (Line(points={
          {-90,60},{-80,60},{-80,58},{-72,58}}, color={0,0,255}));
  connect(current1.p, voltageToCurrentAdaptor1a.pin_n) annotation (Line(points={
          {-90,40},{-80,40},{-80,42},{-72,42}}, color={0,0,255}));
  connect(currentToVoltageAdaptor1a.p, voltageToCurrentAdaptor1a.p) annotation (
     Line(points={{-53,58},{-60,58},{-60,58},{-67,58}}, color={0,0,127}));
  connect(voltageToCurrentAdaptor1a.f, currentToVoltageAdaptor1a.f) 
    annotation (Line(points={{-67,42},{-53,42}}, color={0,0,127}));
  connect(voltageToCurrentAdaptor1a.fder, currentToVoltageAdaptor1a.fder) 
    annotation (Line(points={{-67,45},{-60.5,45},{-60.5,45},{-53,45}}, color={0, 
          0,127}));
  connect(currentToVoltageAdaptor1a.pin_p, inductor1.p) annotation (Line(points= 
         {{-48,58},{-40,58},{-40,60},{-30,60}}, color={0,0,255}));
  connect(currentToVoltageAdaptor1a.pin_n, inductor1.n) annotation (Line(points= 
         {{-48,42},{-42,42},{-42,40},{-30,40}}, color={0,0,255}));
  connect(inductor1.p, currentToVoltageAdaptor1b.pin_p) annotation (Line(points= 
         {{-30,60},{-20,60},{-20,58},{-12,58}}, color={0,0,255}));
  connect(currentToVoltageAdaptor1b.pin_n, inductor1.n) annotation (Line(points= 
         {{-12,42},{-20,42},{-20,40},{-30,40}}, color={0,0,255}));
  connect(inductor1.n, ground1a.p) 
    annotation (Line(points={{-30,40},{-30,30}}, color={0,0,255}));
  connect(currentToVoltageAdaptor1b.p, voltageToCurrentAdaptor1b.p) 
    annotation (Line(points={{-7,58},{7,58}}, color={0,0,127}));
  connect(currentToVoltageAdaptor1b.fder, voltageToCurrentAdaptor1b.fder) 
    annotation (Line(points={{-7,45},{-0.5,45},{-0.5,45},{7,45}}, color={0,0,127}));
  connect(currentToVoltageAdaptor1b.f, voltageToCurrentAdaptor1b.f) 
    annotation (Line(points={{-7,42},{7,42}}, color={0,0,127}));
  connect(voltageToCurrentAdaptor1b.pin_p, conductor1.p) annotation (Line(
        points={{12,58},{20,58},{20,60},{30,60}}, color={0,0,255}));
  connect(voltageToCurrentAdaptor1b.pin_n, conductor1.n) annotation (Line(
        points={{12,42},{20,42},{20,40},{30,40}}, color={0,0,255}));
  connect(conductor1.n, ground1b.p) 
    annotation (Line(points={{30,40},{30,30}}, color={0,0,255}));
  connect(capacitor1.n, ground1c.p) 
    annotation (Line(points={{90,40},{90,40},{90,30}}, color={0,0,255}));
  connect(conductor1.p, voltageToCurrentAdaptor1c.pin_p) annotation (Line(
        points={{30,60},{40,60},{40,58},{48,58}}, color={0,0,255}));
  connect(conductor1.n, voltageToCurrentAdaptor1c.pin_n) annotation (Line(
        points={{30,40},{40,40},{40,42},{48,42}}, color={0,0,255}));
  connect(voltageToCurrentAdaptor1c.p, currentToVoltageAdaptor1c.p) 
    annotation (Line(points={{53,58},{67,58}}, color={0,0,127}));
  connect(voltageToCurrentAdaptor1c.fder, currentToVoltageAdaptor1c.fder) 
    annotation (Line(points={{53,45},{59.5,45},{59.5,45},{67,45}}, color={0,0,127}));
  connect(voltageToCurrentAdaptor1c.f, currentToVoltageAdaptor1c.f) 
    annotation (Line(points={{53,42},{67,42}}, color={0,0,127}));
  connect(capacitor1.n, currentToVoltageAdaptor1c.pin_n) annotation (Line(
        points={{90,40},{80,40},{80,42},{72,42}}, color={0,0,255}));
  connect(currentToVoltageAdaptor1c.pin_p, capacitor1.p) annotation (Line(
        points={{72,58},{80,58},{80,60},{90,60}}, color={0,0,255}));
  connect(voltage2.p, currentToVoltageAdaptor2a.pin_p) annotation (Line(points={
          {-90,-40},{-80,-40},{-80,-42},{-72,-42}}, color={0,0,255}));
  connect(voltage2.n, currentToVoltageAdaptor2a.pin_n) annotation (Line(points={
          {-90,-60},{-80,-60},{-80,-58},{-72,-58}}, color={0,0,255}));
  connect(voltageToCurrentAdaptor2a.pin_p, inductor2.p) 
    annotation (Line(points={{-48,-42},{-40,-42},{-40,-40}}, color={0,0,255}));
  connect(currentToVoltageAdaptor2a.p, voltageToCurrentAdaptor2a.p) 
    annotation (Line(points={{-67,-42},{-53,-42}}, color={0,0,127}));
  connect(currentToVoltageAdaptor2a.pder, voltageToCurrentAdaptor2a.pder) 
    annotation (Line(points={{-67,-45},{-60.5,-45},{-60.5,-45},{-53,-45}}, 
        color={0,0,127}));
  connect(currentToVoltageAdaptor2a.f, voltageToCurrentAdaptor2a.f) 
    annotation (Line(points={{-67,-58},{-53,-58}}, color={0,0,127}));
  connect(voltageToCurrentAdaptor2b.p, currentToVoltageAdaptor2b.p) 
    annotation (Line(points={{-7,-42},{7,-42}}, color={0,0,127}));
  connect(voltageToCurrentAdaptor2b.pder, currentToVoltageAdaptor2b.pder) 
    annotation (Line(points={{-7,-45},{-0.5,-45},{-0.5,-45},{7,-45}}, color={0,0, 
          127}));
  connect(inductor2.n, voltageToCurrentAdaptor2b.pin_p) 
    annotation (Line(points={{-20,-40},{-20,-42},{-12,-42}}, color={0,0,255}));
  connect(voltageToCurrentAdaptor2a.pin_n, ground2a.p) annotation (Line(points={
          {-48,-58},{-40,-58},{-40,-60},{-30,-60},{-30,-70}}, color={0,0,255}));
  connect(ground2a.p, voltageToCurrentAdaptor2b.pin_n) annotation (Line(points={
          {-30,-70},{-30,-60},{-20,-60},{-20,-58},{-12,-58}}, color={0,0,255}));
  connect(voltageToCurrentAdaptor2b.f, currentToVoltageAdaptor2b.f) annotation (
     Line(points={{-7,-58},{0,-58},{0,-58},{7,-58}}, color={0,0,127}));
  connect(capacitor2.n, ground2c.p) 
    annotation (Line(points={{90,-60},{90,-70},{90,-70}}, color={0,0,255}));
  connect(currentToVoltageAdaptor2b.pin_p, resistor2.p) 
    annotation (Line(points={{12,-42},{20,-42},{20,-40}}, color={0,0,255}));
  connect(currentToVoltageAdaptor2c.pin_p, resistor2.n) 
    annotation (Line(points={{48,-42},{40,-42},{40,-40}}, color={0,0,255}));
  connect(voltageToCurrentAdaptor2c.pin_p, capacitor2.p) annotation (Line(
        points={{72,-42},{80,-42},{80,-40},{90,-40}}, color={0,0,255}));
  connect(capacitor2.n, voltageToCurrentAdaptor2c.pin_n) annotation (Line(
        points={{90,-60},{80,-60},{80,-58},{72,-58}}, color={0,0,255}));
  connect(currentToVoltageAdaptor2c.pin_n, ground2b.p) annotation (Line(points={
          {48,-58},{40,-58},{40,-60},{30,-60},{30,-70}}, color={0,0,255}));
  connect(ground2b.p, currentToVoltageAdaptor2b.pin_n) annotation (Line(points={
          {30,-70},{30,-60},{20,-60},{20,-58},{12,-58}}, color={0,0,255}));
  connect(currentToVoltageAdaptor2c.p, voltageToCurrentAdaptor2c.p) 
    annotation (Line(points={{53,-42},{67,-42}}, color={0,0,127}));
  connect(currentToVoltageAdaptor2c.pder, voltageToCurrentAdaptor2c.pder) 
    annotation (Line(points={{53,-45},{59.5,-45},{59.5,-45},{67,-45}}, color={0, 
          0,127}));
  connect(currentToVoltageAdaptor2c.f, voltageToCurrentAdaptor2c.f) 
    annotation (Line(points={{53,-58},{67,-58}}, color={0,0,127}));
  annotation (experiment(StopTime=1.0, Interval=0.0001), 
                                                      Documentation(info="<html>
<p>这个示例演示了如何通过物理连接器和输入/输出信号之间的适配器来连接并联共振电路和串联共振电路的组件，而不是直接连接。考虑到所需的导数，这些组件可以导出为输入/输出模块。(例如：<a href=\"https://fmi-standard.org\">Functional Mock-up Unit</a>)。
电路中连接这些输入/输出模块长应该会产生与“直接物理连接的电路形式”相同的结果。</p>
<p>请记住，用户应将物理组件分离并通过适配器信号连接时，应该需要放置适当的<a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">接地组件</a>。
</p>
</html>"), 
    Diagram(graphics={Text(
          extent={{-100,90},{100,70}}, 
          textColor={28,108,200}, 
          textString="parallel resonance"), Text(
          extent={{-100,-10},{100,-30}}, 
          textColor={28,108,200}, 
          textString="series resonance")}));
end ResonanceCircuits;