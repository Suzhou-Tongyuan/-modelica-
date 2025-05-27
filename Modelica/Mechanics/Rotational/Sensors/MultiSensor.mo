within Modelica.Mechanics.Rotational.Sensors;
model MultiSensor 
  "测量两个一维转动接口之间的扭矩、功率以及一维转动接口的绝对角速度的理想传感器"
  extends .Modelica.Mechanics.Rotational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput power(unit="W") 
    "一维转动接口flange_a上的功率作为输出信号" 
    annotation (Placement(transformation(
        origin={-60,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s") 
    "一维转动接口flange_a的绝对角速度作为输出信号" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}}, 
        rotation=270, 
        origin={60,-110})));
  Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m") 
    "一维转动接口flange_a和flange_b上的扭矩（tau = flange_a.tau = -flange_b.tau）作为输出信号" 
    annotation (Placement(transformation(
        origin={0,-110}, 
        extent={{10,-10},{-10,10}}, 
        rotation=90)));
equation
  flange_a.phi = flange_b.phi;
  w = der(flange_a.phi);
  tau = flange_a.tau;
  power = tau*w;
  annotation (
    Documentation(info="<html>
<p>以理想方式测量一维转动接口flange_a的<strong>绝对角速度</strong>、两个一维转动接口之间的<strong>局部扭矩</strong>和<strong>功率</strong>

并将结果分别作为输出信号<strong>w</strong>、<strong>tau</strong>和<strong>power</strong>返回。
</p>
</html>"), 
       Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-60,-100},{-60,-60},{-94,-2}}), 
        Line(points={{0,-100},{0,-70}}, color={0,0,127}), 
        Line(points={{60,-100},{60,-60},{50,-50}}, color={0,0,127}), 
        Text(
          extent={{-100,-60},{-60,-100}}, 
          textColor={64,64,64}, 
          textString="W"), 
        Text(
          extent={{-20,-60},{20,-100}}, 
          textColor={64,64,64}, 
          textString="N.m"), 
        Text(
          extent={{60,-60},{100,-100}}, 
          textColor={64,64,64}, 
          textString="rad/s")}));
end MultiSensor;