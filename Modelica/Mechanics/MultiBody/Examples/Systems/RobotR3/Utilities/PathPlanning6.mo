within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model PathPlanning6 
  "生成最快运动学运动的参考角度"
  extends Blocks.Icons.Block;

  parameter Integer naxis=6 "驱动轴的数量";
  parameter Modelica.Units.NonSI.Angle_deg angleBegDeg[naxis] = zeros(naxis) 
    "起始角";
  parameter Modelica.Units.NonSI.Angle_deg angleEndDeg[naxis] = ones(naxis) 
    "终止角";
  parameter SI.AngularVelocity speedMax[naxis]=fill(3, naxis) 
    "最大轴速度";
  parameter SI.AngularAcceleration accMax[naxis]=fill(2.5, naxis) 
    "最大轴加速度";
  parameter SI.Time startTime=0 "运动开始时间";
  parameter SI.Time swingTime=0.5 
    "在参考运动静止后，模拟停止前的额外时间";
  final parameter SI.Angle angleBeg[:]=Cv.from_deg(angleBegDeg) 
    "起始角";
  final parameter SI.Angle angleEnd[:]=Cv.from_deg(angleEndDeg) 
    "终止角";
  ControlBus controlBus 
    annotation (Placement(transformation(
        origin={100,0}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  Modelica.Blocks.Sources.KinematicPTP2 path(
    q_end=angleEnd, 
    qd_max=speedMax, 
    qdd_max=accMax, 
    startTime=startTime, 
    q_begin=angleBeg) annotation (Placement(transformation(extent={{-90,-80}, 
            {-70,-60}})));
  PathToAxisControlBus pathToAxis1(nAxis=naxis, axisUsed=1) 
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  PathToAxisControlBus pathToAxis2(nAxis=naxis, axisUsed=2) 
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  PathToAxisControlBus pathToAxis3(nAxis=naxis, axisUsed=3) 
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  PathToAxisControlBus pathToAxis4(nAxis=naxis, axisUsed=4) 
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  PathToAxisControlBus pathToAxis5(nAxis=naxis, axisUsed=5) 
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  PathToAxisControlBus pathToAxis6(nAxis=naxis, axisUsed=6) 
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));

  Blocks.Logical.TerminateSimulation terminateSimulation(condition=time >= path.endTime 
         + swingTime) annotation (Placement(transformation(extent={{-50, 
            -100},{30,-94}})));
equation
  connect(path.q, pathToAxis1.q) annotation (Line(points={{-69,-62}, 
          {-60,-62},{-60,88},{-12,88}}, color={0,0,127}));
  connect(path.qd, pathToAxis1.qd) annotation (Line(points={{-69, 
          -67},{-59,-67},{-59,83},{-12,83}}, color={0,0,127}));
  connect(path.qdd, pathToAxis1.qdd) annotation (Line(points={{-69, 
          -73},{-58,-73},{-58,77},{-12,77}}, color={0,0,127}));
  connect(path.moving, pathToAxis1.moving) annotation (Line(
        points={{-69,-78},{-57,-78},{-57,72},{-12,72}}, color={255,0,255}));
  connect(path.q, pathToAxis2.q) annotation (Line(points={{-69,-62}, 
          {-60,-62},{-60,58},{-12,58}}, color={0,0,127}));
  connect(path.qd, pathToAxis2.qd) annotation (Line(points={{-69, 
          -67},{-59,-67},{-59,53},{-12,53}}, color={0,0,127}));
  connect(path.qdd, pathToAxis2.qdd) annotation (Line(points={{-69, 
          -73},{-58,-73},{-58,47},{-12,47}}, color={0,0,127}));
  connect(path.moving, pathToAxis2.moving) annotation (Line(
        points={{-69,-78},{-57,-78},{-57,42},{-12,42}}, color={255,0,255}));
  connect(path.q, pathToAxis3.q) annotation (Line(points={{-69,-62}, 
          {-60,-62},{-60,28},{-12,28}}, color={0,0,127}));
  connect(path.qd, pathToAxis3.qd) annotation (Line(points={{-69, 
          -67},{-59,-67},{-59,23},{-12,23}}, color={0,0,127}));
  connect(path.qdd, pathToAxis3.qdd) annotation (Line(points={{-69, 
          -73},{-58,-73},{-58,17},{-12,17}}, color={0,0,127}));
  connect(path.moving, pathToAxis3.moving) annotation (Line(
        points={{-69,-78},{-57,-78},{-57,12},{-12,12}}, color={255,0,255}));
  connect(path.q, pathToAxis4.q) annotation (Line(points={{-69,-62}, 
          {-60,-62},{-60,-2},{-12,-2}}, color={0,0,127}));
  connect(path.qd, pathToAxis4.qd) annotation (Line(points={{-69, 
          -67},{-59,-67},{-59,-7},{-12,-7}}, color={0,0,127}));
  connect(path.qdd, pathToAxis4.qdd) annotation (Line(points={{-69, 
          -73},{-58,-73},{-58,-13},{-12,-13}}, color={0,0,127}));
  connect(path.moving, pathToAxis4.moving) annotation (Line(
        points={{-69,-78},{-57,-78},{-57,-18},{-12,-18}}, color={255,0,255}));
  connect(path.q, pathToAxis5.q) annotation (Line(points={{-69,-62}, 
          {-60,-62},{-60,-32},{-12,-32}}, color={0,0,127}));
  connect(path.qd, pathToAxis5.qd) annotation (Line(points={{-69, 
          -67},{-59,-67},{-59,-37},{-12,-37}}, color={0,0,127}));
  connect(path.qdd, pathToAxis5.qdd) annotation (Line(points={{-69, 
          -73},{-58,-73},{-58,-43},{-12,-43}}, color={0,0,127}));
  connect(path.moving, pathToAxis5.moving) annotation (Line(
        points={{-69,-78},{-57,-78},{-57,-48},{-12,-48}}, color={255,0,255}));
  connect(path.q, pathToAxis6.q) annotation (Line(points={{-69,-62}, 
          {-12,-62}}, color={0,0,127}));
  connect(path.qd, pathToAxis6.qd) annotation (Line(points={{-69, 
          -67},{-12,-67}}, color={0,0,127}));
  connect(path.qdd, pathToAxis6.qdd) annotation (Line(points={{-69, 
          -73},{-12,-73}}, color={0,0,127}));
  connect(path.moving, pathToAxis6.moving) annotation (Line(
        points={{-69,-78},{-12,-78}}, color={255,0,255}));
  connect(pathToAxis1.axisControlBus, controlBus.axisControlBus1) annotation (
    Text(
      string="%second", 
      index=1, 
      extent={{6,3},{6,3}}), Line(
      points={{10,80},{80,80},{80,6},{100,6},{100,-0.1},{100.1,-0.1}}, 
      color={255,204,51}, 
      thickness=0.5));
  connect(pathToAxis2.axisControlBus, controlBus.axisControlBus2) annotation (
    Text(
      string="%second", 
      index=1, 
      extent={{6,3},{6,3}}), Line(
      points={{10,50},{70,50},{70,4},{100,4},{100,-0.1},{100.1,-0.1}}, 
      color={255,204,51}, 
      thickness=0.5));
  connect(pathToAxis3.axisControlBus, controlBus.axisControlBus3) annotation (Text(
      string="%second", 
      index=1, 
      extent={{6,3},{6,3}}), Line(
      points={{10,20},{60,20},{60,2},{100,2},{100,-0.1},{100.1,-0.1}}, 
      color={255,204,51}, 
      thickness=0.5));
  connect(pathToAxis4.axisControlBus, controlBus.axisControlBus4) annotation (Text(
      string="%second", 
      index=1, 
      extent={{6,3},{6,3}}), Line(
      points={{10,-10},{60,-10},{60,-0.1},{100.1,-0.1}}, 
      color={255,204,51}, 
      thickness=0.5));
  connect(pathToAxis5.axisControlBus, controlBus.axisControlBus5) annotation (
    Text(
      string="%second", 
      index=1, 
      extent={{6,3},{6,3}}), Line(
      points={{10,-40},{70,-40},{70,-3},{100.1,-3},{100.1,-0.1}}, 
      color={255,204,51}, 
      thickness=0.5));
  connect(pathToAxis6.axisControlBus, controlBus.axisControlBus6) annotation (
    Text(
      string="%second", 
      index=1, 
      extent={{6,3},{6,3}}), Line(
      points={{10,-70},{80,-70},{80,-6},{100,-6},{100,-0.1},{100.1,-0.1}}, 
      color={255,204,51}, 
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,78},{-80,-82}}, color={192,192,192}), 
        Line(points={{-90,0},{82,0}}, color={192,192,192}), 
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-42,55},{29,12}}, 
          textColor={192,192,192}, 
          textString="w"), 
        Line(points={{-80,0},{-41,69},{26,69},{58,0}}), 
        Text(extent={{-70,-44},{84,-68}}, textString="6 axes")}), 
    Documentation(info="<html>
<p>
给定值
</p>
<ul>
<<li>每个轴的起始角度和结束角度</li>

<li>每个轴的最大速度</li> <li>每个轴的最大加速度</li>
</ul>

<p>
这个组件计算在给定约束下的最快运动。这意味着：
</p>

<ol>
<<li>每个轴以最大加速度进行加速，直到达到最大速度。</li>

<li>在可能的情况下，以最大速度进行驱动。</li> <li>以最大加速度的负值进行减速，直到停止。</li>
</ol>

<p>
加速度、匀速和减速阶段是以这样的方式确定的：运动从起始角度开始，并在达到结束角度值时结束。
这个模块的输出是计算得到的角度、角速度和角加速度，这些信息作为参考运动存储在r3机器人的控制总线上。
</p>

</html>"));
end PathPlanning6;