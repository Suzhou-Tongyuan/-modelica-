within Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse;
model ThyristorBridge2mPulse_DC_Drive 
  "2*m脉冲可控硅整流桥驱动直流电机"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer m(final min=3) = 3 "相数" annotation(Evaluate=true);
  parameter SI.Voltage Vrms=dcpmData.VaNominal/ 
      Modelica.Electrical.Polyphase.Functions.factorY2DC(m) 
    "有效值供电电压";
  parameter SI.Frequency f=50 "频率";
  parameter SI.ApparentPower SMains=250E3 
    "电源短路视在功率";
  parameter Real lamdaMains=0.1 "电源短路功率因数";
  final parameter SI.Impedance ZMains=Vrms^2/SMains*m 
    "电源短路阻抗";
  final parameter SI.Resistance RMains=ZMains*lamdaMains 
    "电源电阻" annotation (Evaluate=true);
  final parameter SI.Inductance LMains=ZMains*sqrt(1 - 
      lamdaMains^2)/(2*pi*f) "电源电感" 
    annotation (Evaluate=true);
  parameter SI.Inductance Ld=3*dcpmData.La 
    "平滑电感" annotation (Evaluate=true);
  final parameter SI.Torque tauNominal=dcpmData.ViNominal 
      *dcpmData.IaNominal/dcpmData.wNominal "额定转矩";
  output SI.AngularVelocity w(displayUnit="rpm") = dcpm.wMechanical;
  output SI.Torque tau=dcpm.tauShaft;
  Modelica.Electrical.Polyphase.Sources.SineVoltage sinevoltage(
    m=m, 
    final V=fill(sqrt(2)*Vrms, m), 
    f=fill(f, m)) annotation (Placement(transformation(
        origin={-80,0}, 
        extent={{-10,-10},{10,10}}, 
        rotation=-90)));
  PowerConverters.ACDC.ThyristorBridge2mPulse rectifier(useHeatPort=false, m=m) 
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor 
    annotation (Placement(transformation(
        origin={50,10}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Blocks.Math.Mean meanVoltage(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={80,40})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=2*m*f) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        origin={80,10})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor 
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=180, 
        origin={0,-40})));
  Modelica.Blocks.Math.Mean meanCurrent(f=2*m*f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        origin={80,-60})));
  PowerConverters.ACDC.Control.VoltageBridge2mPulse pulse2(
    useConstantFiringAngle=false, 
    useFilter=true, 
    m=m) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}}, 
        rotation=180, 
        origin={-38,-40})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=Ld) annotation (
      Placement(transformation(
        origin={30,-10}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet 
    dcpm(
    VaNominal=dcpmData.VaNominal, 
    IaNominal=dcpmData.IaNominal, 
    wNominal=dcpmData.wNominal, 
    TaNominal=dcpmData.TaNominal, 
    Ra=dcpmData.Ra, 
    TaRef=dcpmData.TaRef, 
    La=dcpmData.La, 
    Jr=dcpmData.Jr, 
    useSupport=false, 
    Js=dcpmData.Js, 
    frictionParameters=dcpmData.frictionParameters, 
    coreParameters=dcpmData.coreParameters, 
    strayLoadParameters=dcpmData.strayLoadParameters, 
    brushParameters=dcpmData.brushParameters, 
    phiMechanical(fixed=true), 
    wMechanical(fixed=true, start=dcpmData.wNominal), 
    TaOperational=293.15, 
    alpha20a=dcpmData.alpha20a, 
    ia(start=0, fixed=true)) annotation (Placement(transformation(
          extent={{10,-90},{30,-70}})));
  parameter
    Modelica.Electrical.Machines.Utilities.ParameterRecords.DcPermanentMagnetData 
    dcpmData "PM励磁直流电机的数据记录" 
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque 
    annotation (Placement(transformation(extent={{60,-90},{40,-70}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=10, 
    startTime=5, 
    height=tauNominal, 
    offset=-tauNominal) 
    annotation (Placement(transformation(extent={{90,-90},{70,-70}})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=270, 
        origin={-38,-70})));
  Modelica.Electrical.Polyphase.Basic.Resistor rMains(m=m, R=fill(
        RMains, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,30})));
  Modelica.Electrical.Polyphase.Basic.Inductor lMains(m=m, L=fill(
        LMains, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-80,60})));
  Modelica.Electrical.Polyphase.Basic.MultiStarResistance earthing(m=m) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-80,-30})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-30,-60},{-10,-40}})));
initial equation
  lMains.i[1:m - 1] = zeros(m - 1);

equation
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-60},{0,-60},{0,-50}}, color={0,0,127}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{60,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{60,10},{68,10}}, color={0,0,127}));
  connect(rectifier.dc_n, currentSensor.n) annotation (Line(
      points={{-28,-6},{-10,-6},{-10,-40}}, color={0,0,255}));
  connect(rectifier.dc_p, voltagesensor.p) annotation (Line(
      points={{-28,6},{-10,6},{-10,40},{50,40},{50,20}}, color={0,0,255}));
  connect(voltagesensor.n, currentSensor.p) annotation (Line(
      points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
  connect(pulse2.fire_p, rectifier.fire_p) annotation (Line(
      points={{-44,-29},{-44,-12}}, color={255,0,255}));
  connect(pulse2.fire_n, rectifier.fire_n) annotation (Line(
      points={{-32,-29},{-32,-12}}, color={255,0,255}));
  connect(inductor.n, dcpm.pin_ap) annotation (Line(
      points={{30,-20},{30,-70},{26,-70}}, color={0,0,255}));
  connect(torque.flange, dcpm.flange) annotation (Line(
      points={{40,-80},{30,-80}}));
  connect(ramp.y, torque.tau) annotation (Line(
      points={{69,-80},{62,-80}}, color={0,0,127}));
  connect(rectifier.dc_p, inductor.p) annotation (Line(
      points={{-28,6},{-10,6},{-10,40},{30,40},{30,0}}, color={0,0,255}));
  connect(currentSensor.p, dcpm.pin_an) annotation (Line(
      points={{10,-40},{10,-70},{14,-70}}, color={0,0,255}));
  connect(const.y, pulse2.firingAngle) annotation (Line(
      points={{-38,-59},{-38,-52}}, color={0,0,127}));
  connect(rMains.plug_p, sinevoltage.plug_p) annotation (Line(
      points={{-80,20},{-80,10}}, color={0,0,255}));
  connect(lMains.plug_p, rMains.plug_n) annotation (Line(
      points={{-80,50},{-80,40}}, color={0,0,255}));
  connect(lMains.plug_n, rectifier.ac) annotation (Line(
      points={{-80,70},{-60,70},{-60,0},{-48,0}}, color={0,0,255}));
  connect(rectifier.ac, pulse2.ac) annotation (Line(
      points={{-48,0},{-60,0},{-60,-40},{-48,-40}}, color={0,0,255}));
  connect(sinevoltage.plug_n, earthing.plug) annotation (Line(
      points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(rectifier.dc_n, ground.p) annotation (Line(
      points={{-28,-6},{-20,-6},{-20,-40}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=15, 
      Interval=0.0002, 
      Tolerance=1e-006), 
    Documentation(info="<html>
<p>
在这个示例中，一个PM励磁的直流机在额定速度下带有额定转矩启动。在5秒后，载荷转矩在额外的10秒内降至零。在15秒时，机器处于无负载状态。
</p>

<p>绘制电流<code>currentSensor.i</code>、平均电流<code>meanCurrent.y</code>、电压<code>voltageSensor.v</code>和平均电压<code>meanVoltage.v</code>。</p>
</html>"));
end ThyristorBridge2mPulse_DC_Drive;