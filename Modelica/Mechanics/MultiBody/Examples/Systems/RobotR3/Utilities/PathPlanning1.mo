within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model PathPlanning1 
  "生成最快运动学运动的参考角度"
  extends Blocks.Icons.Block;

  parameter Modelica.Units.NonSI.Angle_deg angleBegDeg = 0 "起始角";
  parameter Modelica.Units.NonSI.Angle_deg angleEndDeg = 1 "终止角";
  parameter SI.AngularVelocity speedMax = 3 "轴的最大速度";
  parameter SI.AngularAcceleration accMax = 2.5 "轴的最大加速度";
  parameter SI.Time startTime=0 "运动开始时间";
  parameter SI.Time swingTime=0.5 
    "参考运动静止后，模拟停止前的额外时间";
  final parameter SI.Angle angleBeg=Cv.from_deg(angleBegDeg) "Start angles";
  final parameter SI.Angle angleEnd=Cv.from_deg(angleEndDeg) "End angles";
  ControlBus controlBus 
    annotation (Placement(transformation(
        origin={100,0}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  Modelica.Blocks.Sources.KinematicPTP2 path(
    q_end={angleEnd}, 
    qd_max={speedMax}, 
    qdd_max={accMax}, 
    startTime=startTime, 
    q_begin={angleBeg}) 
                      annotation (Placement(transformation(extent={{-50,-10}, 
            {-30,10}})));
  PathToAxisControlBus pathToAxis1(final nAxis=1, final axisUsed=1) 
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));

  Blocks.Logical.TerminateSimulation terminateSimulation(condition=time >= path.endTime 
         + swingTime) annotation (Placement(transformation(extent={{-50,-30}, 
            {30,-24}})));
equation
  connect(path.q, pathToAxis1.q) annotation (Line(points={{-29,8},{
          -2,8}}, color={0,0,127}));
  connect(path.qd, pathToAxis1.qd) annotation (Line(points={{-29,3}, 
          {-2,3}}, color={0,0,127}));
  connect(path.qdd, pathToAxis1.qdd) annotation (Line(points={{-29, 
          -3},{-2,-3}}, color={0,0,127}));
  connect(path.moving, pathToAxis1.moving) annotation (Line(
        points={{-29,-8},{-2,-8}}, color={255,0,255}));
  connect(pathToAxis1.axisControlBus, controlBus.axisControlBus1) annotation (
    Text(
      string="%second", 
      index=1, 
      extent={{6,3},{6,3}}), Line(
      points={{20,0},{60,0},{60,-0.1},{100.1,-0.1}}, 
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
        Text(extent={{-70,-44},{84,-68}}, textString="1 axis")}), 
    Documentation(info="<html>
<p>
已知
</p>
<ul>
<<li>轴的起始角度和结束角度</li>

<li>轴的最大速度</li> <li>轴的最大加速度</li>
</ul>

<p>
这个组件计算在给定约束下的最快运动。这意味着：
</p>

<ol>
<li> 轴以最大加速度进行加速，直到达到最大速度。</li>

<li> 在可能的情况下，以最大速度进行驱动。</li> <li> 以最大加速度的负值进行减速，直到停止。</li>
</ol>

<p>
加速、匀速和减速阶段是以这样的方式确定的：运动从起始角度开始，
并在达到结束角度值时结束。该模块的输出是计算得到的角度、角速度和角加速度，
这些信息作为参考运动存储在r3机器人的控制总线上。
</p>

</html>"));
end PathPlanning1;