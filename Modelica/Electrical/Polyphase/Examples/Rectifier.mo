within Modelica.Electrical.Polyphase.Examples;
model Rectifier "带有多相组件的测试示例"
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Polyphase.Functions.factorY2DC;
  final parameter Integer m=3 "相数" annotation(Evaluate=true);
  parameter SI.Voltage V=100 "星型电压有效值";
  parameter SI.Frequency f=50 "频率";
  parameter SI.Inductance L=0.0001 "线路电感";
  parameter SI.Resistance RL=2 "负载电阻";
  parameter SI.Capacitance C=0.005 "总直流电容";
  parameter SI.Resistance RE=1E6 "接地电阻";
  parameter SI.Resistance Ron=1e-5 "闭合二极管电阻";
  parameter SI.Conductance Goff=1e-5 
    "打开二极管导纳";
  parameter SI.Voltage Vknee=0 "二极管阈值电压";
  final parameter SI.Voltage VDC=factorY2DC(m)*V "估计的平均直流电压";
  final parameter SI.Current IDC=VDC/RL "估计的平均直流电流";
  Sources.SineVoltage sineVoltage(
    m=m, 
    f=fill(f, m), 
    V=sqrt(2)*fill(V, m)) 
                       annotation (Placement(transformation(extent={{10,10},{-10, 
            -10}}, 
        rotation=90, 
        origin={-90,-50})));
  Basic.Star starS(m=m) annotation (Placement(transformation(
        origin={-90,-80}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Basic.Inductor supplyL(m=m, L=fill(L, m)) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-90,-20})));
  Ideal.IdealDiode idealDiode1(
    m=m, 
    Ron=fill(Ron, m), 
    Goff=fill(Goff, m), 
    Vknee=fill(Vknee, m)) annotation (Placement(transformation(
        origin={40,20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Basic.Star star1(m=m) annotation (Placement(transformation(
        origin={40,50}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Ideal.IdealDiode idealDiode2(
    m=m, 
    Ron=fill(Ron, m), 
    Goff=fill(Goff, m), 
    Vknee=fill(Vknee, m)) annotation (Placement(transformation(
        origin={40,-20}, 
        extent={{-10,-10},{10,10}}, 
        rotation=90)));
  Basic.Star star2(m=m) annotation (Placement(transformation(
        origin={40,-50}, 
        extent={{-10,10},{10,-10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor loadR(R=RL) annotation (
      Placement(transformation(
        origin={60,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C) annotation (
      Placement(transformation(
        origin={80,30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C) annotation (
      Placement(transformation(
        origin={80,-30}, 
        extent={{-10,-10},{10,10}}, 
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground groundDC annotation (Placement(
        transformation(extent={{80,-80},{100,-60}})));
  Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor powerSensorSpacePhasor 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-40, 
            0})));
  Sensors.AronSensor aronSensor annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={-12,0})));
  Sensors.PowerSensor powerSensor(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={-70,0})));
  Sensors.ReactivePowerSensor reactivePowerSensor annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={20,0})));
initial equation
  cDC1.v = VDC/2;
  cDC2.v = VDC/2;
//supplyL.i[1:m - 1] = zeros(m - 1) "Y-connection";
  supplyL.i[2]=-IDC;
  supplyL.i[3]= IDC;
equation
  connect(cDC1.n, cDC2.p) 
    annotation (Line(points={{80,20},{80,-20}}, color={0,0,255}));
  connect(cDC1.n, groundDC.p) annotation (Line(points={{80,20},{80,0},{90,0},{90, 
          -60}},     color={0,0,255}));
  connect(starS.plug_p, sineVoltage.plug_n) 
    annotation (Line(points={{-90,-70},{-90,-60}}, 
                                                 color={0,0,255}));
  connect(sineVoltage.plug_p, supplyL.plug_p) 
    annotation (Line(points={{-90,-40},{-90,-30}}, 
                                               color={0,0,255}));
  connect(idealDiode1.plug_n, star1.plug_p) 
    annotation (Line(points={{40,30},{40,40}}, color={0,0,255}));
  connect(idealDiode2.plug_p, star2.plug_p) annotation (Line(points={{40,-30},{40, 
          -40}},              color={0,0,255}));
  connect(star2.pin_n, loadR.n) annotation (Line(points={{40,-60},{60,-60},{60,-10}}, 
                     color={0,0,255}));
  connect(star2.pin_n, cDC2.n) annotation (Line(points={{40,-60},{80,-60},{80,-40}}, 
                    color={0,0,255}));
  connect(star1.pin_n, loadR.p) 
    annotation (Line(points={{40,60},{60,60},{60,10}}, color={0,0,255}));
  connect(star1.pin_n, cDC1.p) 
    annotation (Line(points={{40,60},{80,60},{80,40}}, color={0,0,255}));
  connect(idealDiode1.plug_p, idealDiode2.plug_n) 
    annotation (Line(points={{40,10},{40,-10}}, color={0,0,255}));
  connect(supplyL.plug_n, powerSensor.pc) 
    annotation (Line(points={{-90,-10},{-90,0},{-80,0}}, color={0,0,255}));
  connect(powerSensor.nc, powerSensorSpacePhasor.plug_p) 
    annotation (Line(points={{-60,0},{-50,0}}, color={0,0,255}));
  connect(powerSensorSpacePhasor.plug_ni, aronSensor.plug_p) 
    annotation (Line(points={{-30,0},{-22,0}}, color={0,0,255}));
  connect(aronSensor.plug_n, reactivePowerSensor.plug_p) 
    annotation (Line(points={{-2,0},{10,0}}, color={0,0,255}));
  connect(idealDiode1.plug_p, reactivePowerSensor.plug_n) 
    annotation (Line(points={{40,10},{40,0},{30,0}}, color={0,0,255}));
  connect(powerSensor.pc, powerSensor.pv) 
    annotation (Line(points={{-80,0},{-80,10},{-70,10}}, color={0,0,255}));
  connect(starS.plug_p, powerSensor.nv) 
    annotation (Line(points={{-90,-70},{-70,-70},{-70,-10}}, color={0,0,255}));
  connect(starS.plug_p, powerSensorSpacePhasor.plug_nv) 
    annotation (Line(points={{-90,-70},{-40,-70},{-40,-10}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>
带有多相组件的测试示例：<br>
星形连接的电压源通过线路电抗器供电，带有直流负载的二极管桥式整流器。<br>
使用f=50Hz进行仿真，仿真时长为0.1秒，用户可以在特定界面比较源和直流负载的电压和电流，忽略初始瞬态。<br>
用户也可以比较：由powerSensor、powerSensorSpacePhasor和aronSensor测量的有功功率，
以及由powerSensorSpacePhasor和reactivePowerSensor测量的无功功率。
</p>
</html>"), 
       experiment(StopTime=0.1, Interval=1e-005));
end Rectifier;