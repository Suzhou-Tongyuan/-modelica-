within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3;
model OneAxis 
  "带简单负载的机器人单轴模型(控制器、电机、齿轮箱)"

  extends Modelica.Icons.Example;
  parameter SI.Mass mLoad(min=0)=15 "负载质量";
  parameter Real kp=5 "轴位置控制器的增益";
  parameter Real ks=0.5 "轴速度控制器的增益";
  parameter SI.Time Ts=0.05 
    "轴速度控制器积分器的时间常数";
  parameter Modelica.Units.NonSI.Angle_deg startAngle = 0 "轴的起始角度";
  parameter Modelica.Units.NonSI.Angle_deg endAngle = 120 "轴的结束角度";

  parameter SI.Time swingTime=0.5 
    "参考运动静止后，在停止模拟前额外增加的时间";
  parameter SI.AngularVelocity refSpeedMax=3 "最大参考速度";
  parameter SI.AngularAcceleration refAccMax=10 
    "最大参考加速度";

  Utilities.AxisType1 axis(
    w=5500, 
    ratio=210, 
    c=8, 
    cd=0.01, 
    Rv0=0.5, 
    Rv1=(0.1/130), 
    kp=kp, 
    ks=ks, 
    Ts=Ts) annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia load(J=1.3*mLoad) 
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Utilities.PathPlanning1 pathPlanning(
    swingTime=swingTime, 
    angleBegDeg=startAngle, 
    angleEndDeg=endAngle, 
    speedMax=refSpeedMax, 
    accMax=refAccMax) annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
protected
  Utilities.ControlBus controlBus annotation (Placement(transformation(extent={{-32,10},{8,50}})));
equation
  connect(axis.flange, load.flange_a) 
    annotation (Line(
      points={{40,10},{60,10}}, 
      color={0,0,0}));
  connect(pathPlanning.controlBus, controlBus) annotation (Line(
      points={{-40,10},{-15,10},{-15,28},{-12,28},{-12,30}}, 
      color={255,204,51}, 
      thickness=0.5));
  connect(controlBus.axisControlBus1, axis.axisControlBus) annotation (
    Text(
      string="%first", 
      index=-1, 
      extent={{-6,3},{-6,3}}), Line(
      points={{-11.9,30.1},{-11.9,29},{-9,29},{-9,10},{20,10}}, 
      color={255,204,51}, 
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
使用这个模型，我们可以检查r3机器人的一个轴。其机械结构被简单的负载惯量所替代。
</p>
</html>"),    experiment(StopTime=1.6), 
    __Dymola_Commands(file="modelica://Modelica/Resources/Scripts/Dymola/Mechanics/MultiBody/Examples/Systems/oneAxisPlot.mos" 
        "Plot result"));
end OneAxis;