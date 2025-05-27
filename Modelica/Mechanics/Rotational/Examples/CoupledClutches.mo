within Modelica.Mechanics.Rotational.Examples;
model CoupledClutches "具有3个动态耦合离合器的传动系统"
  extends Modelica.Icons.Example;
  parameter SI.Frequency f=0.2 
    "用于调用离合器1的正弦函数的频率";
  parameter SI.Time T2=0.4 "调用离合器2的时间";
  parameter SI.Time T3=0.9 "调用离合器3的时间";


  Rotational.Components.Inertia J1(
    J=1, 
    phi(fixed=true, start=0), 
    w(start=10, fixed=true)) annotation (Placement(transformation(extent={{
            -70,-10},{-50,10}})));
  Rotational.Sources.Torque torque(useSupport=true) annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}})));
  Rotational.Components.Clutch clutch1(peak=1.1, fn_max=20) annotation (
      Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Sine sin1(amplitude=10, f=5) annotation (
      Placement(transformation(extent={{-130,-10},{-110,10}})));
  Modelica.Blocks.Sources.Step step1(startTime=T2) annotation (Placement(
        transformation(
        origin={25,35}, 
        extent={{-5,-5},{15,15}}, 
        rotation=270)));
  Rotational.Components.Inertia J2(
    J=1, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10, 
            -10},{10,10}})));
  Rotational.Components.Clutch clutch2(peak=1.1, fn_max=20) annotation (
      Placement(transformation(extent={{20,-10},{40,10}})));
  Rotational.Components.Inertia J3(
    J=1, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
            50,-10},{70,10}})));
  Rotational.Components.Clutch clutch3(peak=1.1, fn_max=20) annotation (
      Placement(transformation(extent={{80,-10},{100,10}})));
  Rotational.Components.Inertia J4(
    J=1, 
    phi(fixed=true, start=0), 
    w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
            110,-10},{130,10}})));
  Modelica.Blocks.Sources.Sine sin2(
    amplitude=1, 
    f=f, 
    phase=1.570796326794897) annotation (Placement(transformation(
        origin={-35,35}, 
        extent={{-5,-5},{15,15}}, 
        rotation=270)));
  Modelica.Blocks.Sources.Step step2(startTime=T3) annotation (Placement(
        transformation(
        origin={85,35}, 
        extent={{-5,-5},{15,15}}, 
        rotation=270)));
  Rotational.Components.Fixed fixed annotation (Placement(transformation(
          extent={{-100,-30},{-80,-10}})));
equation
  connect(torque.flange, J1.flange_a) 
    annotation (Line(points={{-80,0},{-70,0}}));
  connect(J1.flange_b, clutch1.flange_a) 
    annotation (Line(points={{-50,0},{-40,0}}));
  connect(clutch1.flange_b, J2.flange_a) 
    annotation (Line(points={{-20,0},{-10,0}}));
  connect(J2.flange_b, clutch2.flange_a) 
    annotation (Line(points={{10,0},{10,0},{20,0}}));
  connect(clutch2.flange_b, J3.flange_a) 
    annotation (Line(points={{40,0},{50,0}}));
  connect(J3.flange_b, clutch3.flange_a) 
    annotation (Line(points={{70,0},{80,0}}));
  connect(clutch3.flange_b, J4.flange_a) 
    annotation (Line(points={{100,0},{110,0}}));
  connect(sin1.y, torque.tau) 
    annotation (Line(points={{-109,0},{-102,0}}, color={0,0,127}));
  connect(sin2.y, clutch1.f_normalized) annotation (Line(points={{-30,19},{
          -30,19},{-30,11}}, color={0,0,127}));
  connect(step1.y, clutch2.f_normalized) annotation (Line(points={{30,19},{
          30,19},{30,10},{30,11}}, color={0,0,127}));
  connect(step2.y, clutch3.f_normalized) 
    annotation (Line(points={{90,19},{90,19},{90,11}}, color={0,0,127}));
  connect(fixed.flange, torque.support) annotation (Line(points={{-90,-20}, 
          {-90,-11},{-90,-10}}));
  annotation (
Documentation(info="<html>
<p>此示例演示了如何处理可变结构的传动系统。
传动系统由4个一维转动惯性组件和3个离合器组成，
其中离合器由输入信号控制。
该系统有2^3=8种不同的配置和3^3=27种不同的状态
（每个离合器在相对角速度为零时可能处于正向滑动、反向滑动或锁定模式）。
通过在不同的时间调用离合器，可以研究状态的切换。</p>
<p>将系统模拟1.2秒，初始值如下：<br>
J1.w = 10。</p>
<p>
绘制以下变量：<br>
一维转动惯性组件的角速度（J1.w、J2.w、J3.w、J4.w）、
离合器的摩擦力矩（clutchX.tau）、
离合器的摩擦模式（clutchX.mode），
其中mode = -1/0/+1 表示反向滑动、锁定、正向滑动。
</p>

</html>"), 
    __Dymola_Commands(file= 
          "modelica://Modelica/Resources/Scripts/Dymola/Mechanics/Rotational/CoupledClutches.mos" 
        "模拟和绘图"), 
    experiment(StopTime=1.5, Interval=0.001), 
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100}, 
            {140,100}})));
end CoupledClutches;