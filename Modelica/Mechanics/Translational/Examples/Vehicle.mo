within Modelica.Mechanics.Translational.Examples;
model Vehicle "具有行驶阻力的一维车辆"
  extends Modelica.Icons.Example;
  import Modelica.Constants.g_n;
  parameter SI.Mass m=100 "车辆质量";
  parameter SI.Length R=0.25 "车轮半径";
  parameter SI.Area A=1 "车辆横截面积";
  parameter Real Cd=0.5 "阻力系数";
  parameter SI.Density rho=1.18 "空气密度";
  parameter SI.Velocity vWind=0 "恒定风速";
  parameter Real Cr=0.01 "滚动阻力系数";
  parameter Real inclination=0 "恒定倾斜度 = tan(angle)";
  parameter SI.Velocity vNom=25/3.5 "额定速度";
  final parameter SI.Force fDrag=Cd*A*rho*(vNom - vWind)^2/2 "阻力" 
    annotation(Dialog(enable=false));
  final parameter SI.Angle alpha=atan(inclination) "倾角" 
    annotation(Dialog(enable=false));
  final parameter SI.Force fRoll=Cr*m*g_n*cos(alpha) "滚动阻力" 
    annotation(Dialog(enable=false));
  final parameter SI.Force fGrav=m*g_n*sin(alpha) "重力阻力" 
  annotation(Dialog(enable=false));
  Components.Vehicle vehicle(
    m=m, 
    J=0, 
    R=R, 
    A=A, 
    Cd=Cd, 
    CrConstant=Cr, 
    vWindConstant=vWind, 
    useInclinationInput=true, 
    s(fixed=true), 
    v(fixed=true)) 
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Components.Vehicle vehicle1(
    m=m, 
    J=0, 
    R=R, 
    A=A, 
    Cd=Cd, 
    CrConstant=Cr, 
    vWindConstant=vWind, 
    useInclinationInput=true, 
    s(fixed=true), 
    v(fixed=true)) 
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Components.Vehicle trailer(
    m=m, 
    J=0, 
    R=R, 
    A=A, 
    Cd=Cd, 
    CrConstant=Cr, 
    vWindConstant=vWind, 
    useInclinationInput=true, 
    s(fixed=false), 
    v(fixed=false)) 
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Mechanics.Translational.Sensors.MultiSensor multiSensor 
    annotation (Placement(transformation(extent={{60,84},{80,64}})));
  Modelica.Blocks.Sources.CombiTimeTable timeTableTorqueInclination(
    table=[0,0,0; 5,0,0; 5,5.6,0; 10.8,5.6,0; 10.8,1,0; 20,1,0; 20,2.8,0.05;
           25,2.8,0.05; 25,1,0; 50,1,0; 50,-5,0; 55,-5,0; 55,0,0; 60,0,0], 
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint) 
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Rotational.Sources.Torque torque 
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Rotational.Sources.Torque torque1 
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.Gain gain(k=(fDrag + fRoll + fGrav)*R) 
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Blocks.Math.Gain gain1(k=2) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, 
        rotation=90, 
        origin={-10,30})));
equation
  connect(timeTableTorqueInclination.y[1], gain.u) 
    annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
  connect(timeTableTorqueInclination.y[2], vehicle.inclination) 
    annotation (Line(points={{-59,0},{-50,0},{-50,-20},{34,-20},{34,-12}}, color={0,0,127}));
  connect(gain.y, torque.tau) 
    annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
  connect(torque.flange, vehicle.flangeR) 
    annotation (Line(points={{20,0},{30,0}}, color={0,0,0}));
  connect(torque1.flange, vehicle1.flangeR) 
    annotation (Line(points={{20,50},{30,50}}, color={0,0,0}));
  connect(vehicle.inclination, vehicle1.inclination) annotation (Line(
        points={{34,-12},{34,-20},{60,-20},{60,30},{34,30},{34,38}}, color= 
          {0,0,127}));
  connect(vehicle1.inclination, trailer.inclination) annotation (Line(points={{34,38},{34,30},{74,30},{74,38}}, color={0,0,127}));
  connect(gain.y, gain1.u) 
    annotation (Line(points={{-19,0},{-10,0},{-10,18}}, color={0,0,127}));
  connect(gain1.y, torque1.tau) 
    annotation (Line(points={{-10,41},{-10,50},{-2,50}}, color={0,0,127}));
  connect(vehicle1.flangeT, multiSensor.flange_a) 
    annotation (Line(points={{50,50},{50,74},{60,74}}, color={0,127,0}));
  connect(multiSensor.flange_b, trailer.flangeT) annotation (Line(points={{80,74},{90,74},{90,50}}, color={0,127,0}));
  annotation (experiment(StopTime=60, Interval=0.01), Documentation(info="<html>
<p>
车辆<code>vehicle</code>和<code>vehicle1</code>受到驱动扭矩的作用做加速或减速运动。
额定扭矩定义为额定速度 <code>vNom</code> 时的驱动阻力之和乘以车轮半径 <code>R</code>。
</p>
<p>
从5秒开始，<code>vehicle</code> 以标称扭矩的倍数加速直到接近标称速度然后以额定扭矩驱动。
在20秒至25秒之间，以5%的倾斜度增加，并临时增加了驱动扭矩到额定扭矩的倍数。
在50秒至55秒之间，将驱动扭矩设置为负值，导致车辆减速。
55秒后，车辆由于驱动阻力而减速。
</p>
<p>
将<code>trailer</code>与数据相同但没有驱动的<code>vehicle1</code>耦合，<code>vehicle1</code> 的驱动扭矩必须翻倍才能达到相同的加速度和速度。
测量两辆车之间的力和功率。
</p>

<h4>注意</h4>
<p>
由于<code>trailer</code>与<code>vehicle1</code>紧密耦合，trailer的初始化必须去除。
</p>
</html>"));
end Vehicle;