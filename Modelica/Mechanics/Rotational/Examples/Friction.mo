within Modelica.Mechanics.Rotational.Examples;
model Friction "带离合器和制动器的传动系统"
    import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  parameter SI.Time startTime=0.5 "阶跃开始时间";
  output SI.Torque tMotor=torque.tau "惯性3的驱动扭矩";
  output SI.Torque tClutch=clutch.tau "离合器的摩擦扭矩";
  output SI.Torque tBrake=brake.tau "刹车的摩擦扭矩";
  output SI.Torque tSpring=spring.tau "弹簧扭矩";

  Rotational.Sources.Torque torque(useSupport=true) annotation (Placement(
        transformation(extent={{-90,-10},{-70,10}})));
  Rotational.Components.Inertia inertia3(
    J=1, 
    phi(
      start=0, 
      fixed=true, 
      displayUnit="deg"), 
    w(start=100, 
      fixed=true, 
      displayUnit="rad/s")) annotation (Placement(transformation(extent={{-60, 
            -10},{-40,10}})));
  Rotational.Components.Clutch clutch(fn_max=160) annotation (Placement(
        transformation(extent={{-30,-10},{-10,10}})));
  Rotational.Components.Inertia inertia2(
    J=0.05, 
    phi(start=0, fixed=true), 
    w(start=90, fixed=true)) annotation (Placement(transformation(extent={{
            0,-10},{20,10}})));
  Rotational.Components.SpringDamper spring(c=160, d=1) annotation (
      Placement(transformation(extent={{30,-10},{50,10}})));
  Rotational.Components.Inertia inertia1(
    J=1, 
    phi(start=0, fixed=true), 
    w(start=90, fixed=true)) annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));

  Rotational.Components.Brake brake(fn_max=1600, useSupport=true) 
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(
        transformation(
        origin={-25,35}, 
        extent={{-5,-5},{15,15}}, 
        rotation=270)));
  Modelica.Blocks.Sources.Step step(startTime=startTime) annotation (
      Placement(transformation(
        origin={65,35}, 
        extent={{-5,-5},{15,15}}, 
        rotation=270)));
  Modelica.Blocks.Sources.Step step2(
    height=-1, 
    offset=1, 
    startTime=startTime) annotation (Placement(transformation(extent={{-160, 
            -30},{-140,-10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=200, f=50/pi) 
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}})));
  Rotational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{-10,-30},{10,-10}})));
equation
  connect(torque.flange, inertia3.flange_a) 
    annotation (Line(points={{-70,0},{-70,0},{-60,0}}));
  connect(inertia3.flange_b, clutch.flange_a) 
    annotation (Line(points={{-40,0},{-30,0}}));
  connect(clutch.flange_b, inertia2.flange_a) 
    annotation (Line(points={{-10,0},{0,0}}));
  connect(inertia2.flange_b, spring.flange_a) 
    annotation (Line(points={{20,0},{30,0}}));
  connect(spring.flange_b, brake.flange_a) 
    annotation (Line(points={{50,0},{60,0}}));
  connect(brake.flange_b, inertia1.flange_a) 
    annotation (Line(points={{80,0},{80,0},{90,0}}));
  connect(sine.y, product.u1) annotation (Line(points={{-139,20},{-130,20}, 
          {-130,6},{-122,6}}, color={0,0,127}));
  connect(step2.y, product.u2) annotation (Line(points={{-139,-20},{-130,-20}, 
          {-130,-6},{-126,-6},{-122,-6}}, color={0,0,127}));
  connect(product.y, torque.tau) 
    annotation (Line(points={{-99,0},{-99,0},{-92,0}}, color={0,0,127}));
  connect(const.y, clutch.f_normalized) annotation (Line(points={{-20,19},{
          -20,12.75},{-20,11}}, color={0,0,127}));
  connect(step.y, brake.f_normalized) 
    annotation (Line(points={{70,19},{70,16},{70,11}}, color={0,0,127}));
  connect(torque.support, fixed.flange) 
    annotation (Line(points={{-80,-10},{-80,-20},{0,-20}}));
  connect(brake.support, fixed.flange) 
    annotation (Line(points={{70,-10},{70,-20},{0,-20}}));
  annotation (Documentation(info="<html>
<p>
该传动系统包含一个摩擦型<strong>离合器</strong>和一个<strong>刹车</strong>。
</p>
<p>
使用以下初始值（在模型中已定义）模拟系统1秒：</p>
<blockquote><pre>
inertia1.w =  90 (or brake.w)
inertia2.w =  90
inertia3.w = 100
</pre></blockquote>
<p>绘制输出信号</p>
<blockquote><pre>
tMotor      Torque of motor
tClutch     Torque in clutch
tBrake      Torque in brake
tSpring     Torque in spring
</pre></blockquote>
<p>以及三个惯性组件的绝对角速度（inertia1.w，inertia2.w，inertia3.w）。</p>

</html>"), 
       experiment(StopTime=3.0, Interval=0.001), 
  Diagram(coordinateSystem(extent = {{-170,-100},{120,100}})));
end Friction;