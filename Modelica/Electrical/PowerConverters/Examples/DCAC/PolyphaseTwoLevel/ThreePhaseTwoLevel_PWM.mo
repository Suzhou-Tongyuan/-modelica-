within Modelica.Electrical.PowerConverters.Examples.DCAC.PolyphaseTwoLevel;
model ThreePhaseTwoLevel_PWM "脉宽调制方法测试"
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Polyphase.Functions.factorY2DC;
  import Modelica.Constants.pi;
  parameter Real RMS=1 "参考RMS值 Y";
  Modelica.Blocks.Sources.Cosine cosine(f=2, 
    phase=0, 
    amplitude=RMS*sqrt(2)) 
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=cosine.amplitude, 
    f=cosine.f, 
    phase=cosine.phase) 
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  PowerConverters.DCAC.Control.PWM pwm(uMax=sqrt(2*3), f=100) 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  PowerConverters.DCAC.Polyphase2Level multiPhase2Level 
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcPos(V=pwm.uMax/2) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-40,70})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage dcNeg(V=pwm.uMax/2) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-40,30})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=270, 
        origin={-50,50})));
  Modelica.Electrical.Polyphase.Sensors.PotentialSensor potentialSensor 
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Harmonic harmonic(f=cosine.f, k=1) 
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToSpacePhasor toSpacePhasor 
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.Rotator rotator 
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Sources.Constant const(k=cosine.f) 
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=2*pi) 
    annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
  Modelica.Blocks.Continuous.Filter filter[2](
    each init=Modelica.Blocks.Types.Init.InitialOutput, 
    each analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping, 
    y_start={cosine.amplitude,cosine.phase}, 
    each order=2, 
    each f_cut=0.5*cosine.f) 
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Modelica.Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar 
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
equation
  connect(pwm.fire_p, multiPhase2Level.fire_p) 
    annotation (Line(points={{-29,6},{-6,6},{-6,38}}, color={255,0,255}));
  connect(pwm.fire_n, multiPhase2Level.fire_n) 
    annotation (Line(points={{-29,-6},{6,-6},{6,38}}, color={255,0,255}));
  connect(dcNeg.n, multiPhase2Level.dc_n) annotation (Line(points={{-40,20}, 
          {-20,20},{-20,44},{-10,44}}, 
                           color={0,0,255}));
  connect(dcPos.p, multiPhase2Level.dc_p) annotation (Line(points={{-40,80}, 
          {-20,80},{-20,56},{-10,56}}, 
                           color={0,0,255}));
  connect(dcPos.n, ground.p) 
    annotation (Line(points={{-40,60},{-40,50}}, color={0,0,255}));
  connect(ground.p, dcNeg.p) 
    annotation (Line(points={{-40,50},{-40,40}}, color={0,0,255}));
  connect(cosine.y, pwm.u[1]) annotation (Line(points={{-69,20},{-60,20},{-60, 
          -1},{-52,-1}}, color={0,0,127}));
  connect(sine.y, pwm.u[2]) annotation (Line(points={{-69,-20},{-60,-20},{-60, 
          1},{-52,1}}, color={0,0,127}));
  connect(multiPhase2Level.ac, potentialSensor.plug_p) 
    annotation (Line(points={{10,50},{20,50}}, color={0,0,255}));
  connect(toSpacePhasor.y, rotator.u) 
    annotation (Line(points={{-9,-40},{-2,-40}},   color={0,0,127}));
  connect(potentialSensor.phi, toSpacePhasor.u) annotation (Line(points={{41,50}, 
          {50,50},{50,-20},{-40,-20},{-40,-40},{-32,-40}}, color={0,0,127}));
  connect(const.y, integrator.u) 
    annotation (Line(points={{-39,-70},{-32,-70}}, color={0,0,127}));
  connect(integrator.y, rotator.angle) 
    annotation (Line(points={{-9,-70},{10,-70},{10,-52}},color={0,0,127}));
  connect(potentialSensor.phi[1], harmonic.u) 
    annotation (Line(points={{41,50},{58,50}}, color={0,0,127}));
  connect(rotator.y, filter.u) 
    annotation (Line(points={{21,-40},{28,-40}}, color={0,0,127}));
  connect(filter.y, toPolar.u) 
    annotation (Line(points={{51,-40},{58,-40}}, color={0,0,127}));
  annotation (experiment(
      StopTime=2, 
      Interval=0.001, 
      Tolerance=1e-05), 
    Documentation(info="<html>
<p>
应用长度为 &radic;2*RMS 和频率为 2 Hz 的参考空间矢量（由实部 = cosine 和虚部 = sine 组成）。
将得到的开关模式应用于带有100 Hz 开关频率的三相二级桥，由 DC 电压 = &radic;2*&radic;3*1 提供，
其中 1 是从端到中性的理论最大电压。
测量相对于 DC 电压中点的结果电压。
</p>
<p>
计算这些电压中第一个的第一个谐波的 RMS。
请注意，第一个谐波的值在第一个周期后有效（即0.5秒）。
</p>
<p>
此外，将这三个电压转换为相应的空间矢量。
请注意，零分量不为零，表示中性相对于 DC 电压中点的偏移。
</p>
<p>
将空间矢量旋转到以 2*&pi;*2 Hz 旋转的坐标系。
为了抑制开关的影响，对旋转后的矢量的实部和虚部进行滤波。
计算旋转和滤波后矢量的极坐标表示。
</p>
<p>
请注意，滤波器的稳定时间取决于滤波器参数。
</p>
</html>"));
end ThreePhaseTwoLevel_PWM;