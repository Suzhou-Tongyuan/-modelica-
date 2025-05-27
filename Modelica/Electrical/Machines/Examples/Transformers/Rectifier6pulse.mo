within Modelica.Electrical.Machines.Examples.Transformers;
model Rectifier6pulse "带1个变压器的6脉冲整流器"
  extends Modelica.Icons.Example;
  constant Integer m=3 "相数";
  parameter SI.Voltage V=100*sqrt(2/3) 
    "星形电压的幅值";
  parameter SI.Frequency f=50 "频率";
  parameter SI.Resistance RL=0.4 "负载电阻";
  parameter SI.Capacitance C=0.005 "总直流电容";
  parameter SI.Voltage VC0=sqrt(3)*V 
    "电容的初始电压";
  Modelica.Electrical.Polyphase.Sources.SineVoltage source(
    m=m, 
    V=fill(V, m), 
    f=fill(f, m)) annotation (Placement(transformation(
        origin={-90,-10}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Polyphase.Basic.Star starAC(m=m) annotation (
      Placement(transformation(
        origin={-90,-40}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundAC annotation (Placement(
        transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor(m=m) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode1(
    m=m, 
    Ron=fill(1e-5, m), 
    Goff=fill(1e-5, m), 
    Vknee=fill(0, m)) annotation (Placement(transformation(
        origin={-20,60}, 
        extent={{-10,10},{10,-10}}, 
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star1(m=m) annotation (
      Placement(transformation(
        origin={0,70}, 
        extent={{10,10},{-10,-10}}, 
        rotation=180)));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode diode2(
    m=m, 
    Ron=fill(1e-5, m), 
    Goff=fill(1e-5, m), 
    Vknee=fill(0, m)) annotation (Placement(transformation(
        origin={-20,20}, 
        extent={{-10,10},{10,-10}}, 
        rotation=90)));
  Modelica.Electrical.Polyphase.Basic.Star star2(m=m) annotation (
      Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Electrical.Analog.Basic.Resistor load(R=RL) annotation (
      Placement(transformation(
        origin={50,0}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C, v(start=VC0/2)) 
    annotation (Placement(transformation(
        origin={70,20}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C, v(start=VC0/2)) 
    annotation (Placement(transformation(
        origin={70,-20}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundDC annotation (Placement(
        transformation(extent={{80,-20},{100,0}})));
  parameter Machines.Utilities.TransformerData transformerData1(
    C1=Modelica.Utilities.Strings.substring(
        transformer1.VectorGroup, 
        1, 
        1), 
    C2=Modelica.Utilities.Strings.substring(
        transformer1.VectorGroup, 
        2, 
        2), 
    f=50, 
    V1=100, 
    V2=100, 
    SNominal=30E3, 
    v_sc=0.05, 
    P_sc=300) "变压器1的数据" 
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Machines.BasicMachines.Transformers.Dy.Dy01 transformer1(
    n=transformerData1.n, 
    R1=transformerData1.R1, 
    L1sigma=transformerData1.L1sigma, 
    R2=transformerData1.R2, 
    L2sigma=transformerData1.L2sigma, 
    T1Ref=293.15, 
    alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero, 
    T2Ref=293.15, 
    alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero, 
    T1Operational=293.15, 
    T2Operational=293.15) 
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));

initial equation
  cDC1.v = VC0/2;
  cDC2.v = VC0/2;
  transformer1.i2[1:2] = zeros(2);
equation
  connect(cDC1.n, cDC2.p) 
    annotation (Line(points={{70,10},{70,-10}}, color={0,0,255}));
  connect(cDC1.n, groundDC.p) 
    annotation (Line(points={{70,10},{70,0},{90,0}}, color={0,0,255}));
  connect(starAC.plug_p, source.plug_n) 
    annotation (Line(points={{-90,-30},{-90,-20}}, color={0,0,255}));
  connect(diode1.plug_n, star1.plug_p) 
    annotation (Line(points={{-20,70},{-10,70}}, color={0,0,255}));
  connect(diode2.plug_p, star2.plug_p) 
    annotation (Line(points={{-20,10},{-10,10}}, color={0,0,255}));
  connect(diode2.plug_n, diode1.plug_p) 
    annotation (Line(points={{-20,30},{-20,50}}, color={0,0,255}));
  connect(starAC.pin_n, groundAC.p) 
    annotation (Line(points={{-90,-50},{-90,-60}}, color={0,0,255}));
  connect(source.plug_p, currentSensor.plug_p) 
    annotation (Line(points={{-90,0},{-85,0},{-80,0}}, color={0,0,255}));
  connect(load.p, cDC1.p) 
    annotation (Line(points={{50,10},{50,30},{70,30}}, color={0,0,255}));
  connect(load.n, cDC2.n) annotation (Line(points={{50,-10},{50,-30},{70, 
          -30}}, color={0,0,255}));
  connect(star1.pin_n, cDC1.p) 
    annotation (Line(points={{10,70},{70,70},{70,30}}, color={0,0,255}));
  connect(star2.pin_n, cDC2.n) annotation (Line(points={{10,10},{20,10},{
          20,-70},{70,-70},{70,-30}}, color={0,0,255}));
  connect(transformer1.plug1, currentSensor.plug_n) annotation (Line(
      points={{-50,40},{-60,40},{-60,0}}, color={0,0,255}));
  connect(transformer1.plug2, diode1.plug_p) annotation (Line(
      points={{-30,40},{-20,40},{-20,50}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>带多相组件的测试示例：</p>
<p>星形连接的电压源通过一个变压器馈入带有直流负载的二极管桥整流器。</p>
<p>仿真时f=50 Hz，仿真周期为0.1秒(5个周期)，忽略初始瞬态。仿真结束后，用户可以比较源和直流负载的电压和电流。</p>
</html>"), 
     experiment(StopTime=0.1, Interval=1E-4, Tolerance=1E-6));
end Rectifier6pulse;