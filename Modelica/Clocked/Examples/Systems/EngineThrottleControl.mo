within Modelica.Clocked.Examples.Systems;
model EngineThrottleControl 
  "与内燃机曲轴角度同步的闭环节气门控制装置"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Step speedRef(
    startTime = 5, 
    offset = 207.34, 
    height = 103.67) 
    annotation(Placement(transformation(extent = {{-90, 6}, {-70, 26}})));
  Utilities.ComponentsThrottleControl.SpeedControl speedControl 
    annotation(Placement(transformation(extent = {{-32, -5}, {0, 25}})));
  RealSignals.Sampler.Sample sample1 
    annotation(Placement(transformation(extent = {{-60, 9}, {-46, 23}})));
  RealSignals.Sampler.Hold hold1(y_start = 8.9) 
    annotation(Placement(transformation(extent = {{8, 4}, {20, 16}})));
  Utilities.ComponentsThrottleControl.Engine engine 
    annotation(Placement(transformation(extent = {{32, -4}, {60, 24}})));
  Modelica.Blocks.Sources.Step step1(
    height = -5, 
    offset = 25, 
    startTime = 2) 
    annotation(Placement(transformation(extent = {{148, 23}, {134, 37}})));
  Modelica.Blocks.Sources.Step step2(
    height = 5, 
    offset = 0, 
    startTime = 8) 
    annotation(Placement(transformation(extent = {{148, -16}, {134, -2}})));
  Modelica.Blocks.Math.Add add(k1 = -1, k2 = -1) 
    annotation(Placement(transformation(extent = {{116, 4}, {104, 16}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport = false) 
    annotation(Placement(transformation(extent = {{90, 0}, {70, 20}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor 
    annotation(Placement(transformation(
    extent = {{-10, -10}, {10, 10}}, 
    rotation = -90, 
    origin = {70, -30})));
  Modelica.Blocks.Continuous.Der derivative 
    annotation(Placement(transformation(extent = {{20, -60}, {0, -40}})));
  RealSignals.Sampler.SampleClocked sample2 
    annotation(Placement(transformation(extent = {{-24, -44}, {-36, -56}})));

equation
  connect(speedRef.y, sample1.u) 
    annotation(Line(
    points = {{-69, 16}, {-61.4, 16}}, 
    color = {0, 0, 127}));
  connect(sample1.y, speedControl.N_des) 
    annotation(Line(
    points = {{-45.3, 16}, {-35.2, 16}}, 
    color = {0, 0, 127}));
  connect(speedControl.Theta, hold1.u) 
    annotation(Line(points = {{1.6, 10}, {6.8, 10}}, color = {0, 0, 127}));
  connect(hold1.y, engine.Theta) 
    annotation(Line(points = {{20.6, 10}, {29.2, 10}}, color = {0, 0, 127}));
  connect(torque.flange, engine.flange_b) 
    annotation(Line(
    points = {{70, 10}, {60, 10}}));
  connect(add.y, torque.tau) 
    annotation(Line(
    points = {{103.4, 10}, {92, 10}}, 
    color = {0, 0, 127}));
  connect(step2.y, add.u2) 
    annotation(Line(
    points = {{133.3, -9}, {128, -9}, {128, 6.4}, {117.2, 6.4}}, 
    color = {0, 0, 127}));
  connect(step1.y, add.u1) 
    annotation(Line(
    points = {{133.3, 30}, {128, 30}, {128, 13.6}, {117.2, 13.6}}, 
    color = {0, 0, 127}));
  connect(engine.flange_b, angleSensor.flange) 
    annotation(Line(
    points = {{60, 10}, {70, 10}, {70, -20}}));
  connect(angleSensor.phi, derivative.u) 
    annotation(Line(
    points = {{70, -41}, {70, -50}, {22, -50}}, 
    color = {0, 0, 127}));
  connect(derivative.y, sample2.u) 
    annotation(Line(
    points = {{-1, -50}, {-22.8, -50}}, 
    color = {0, 0, 127}));
  connect(sample2.y, speedControl.N) 
    annotation(Line(
    points = {{-36.6, -50}, {-50, -50}, {-50, 1}, {-35.2, 1}}, 
    color = {0, 0, 127}));
  connect(sample2.clock, engine.synchronize) 
    annotation(Line(
    points = {{-30, -42.8}, {-30, -20}, {64, -20}, {64, 0}, {61.4, 0}, {61.4, 0.2}}, 
    color = {175, 175, 175}, 
    pattern = LinePattern.Dot, 
    thickness = 0.5));

  annotation(
    Diagram(
    coordinateSystem(
    preserveAspectRatio = true, 
    extent = {{-100, -100}, {160, 100}}), 
    graphics = {
    Rectangle(
    extent = {{100, 60}, {152, -30}}, 
    lineColor = {0, 0, 255}), 
    Text(
    extent = {{100, 60}, {150, 40}}, 
    textColor = {0, 0, 255}, 
    textString = "Load torque")}), 
    experiment(StopTime = 1.1), 
    Documentation(info="<html><p>
本示例展示了如何使用 <code>Modelica.Clocked library</code> 库为非周期性同步采样数据系统建模。 <span style=\"color: rgb(51, 51, 51);\">通过一个闭环节气门控制系统，该系统与内燃机的曲轴角度同步进行演示</span>。 该系统具有以下特性：
</p>
<li>
发动机转速由节气门执行器调节。</li>
<li>
控制器的执行与发动机曲轴角度同步。</li>
<li>
减少了负载扭矩变化等干扰的影响。</li>
<p>
整个系统如下图所示（图层）:<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/EngineThrottleControl_Model.png\" alt=\"EngineThrottleControl_Model.png\" data-href=\"\" style=\"\"/>
</p>
<p>
<code>speedControl</code> 是离散控制系统。 该控制器的边界由<code>sample1</code>、<code>sample2</code>和<code>hold</code>定义。 <span style=\"color: rgb(51, 51, 51); background-color: rgb(245, 246, 248);\">采样是通过发动机内部的传感器进行的，这些传感器观察曲轴角度；每当曲轴旋转 180°，发动机内部会同步调节节气门。相应的同步点作为时钟输出提供，这些输出反过来用于触发外部控制器。因此，速度控制器会在发动机曲轴的每半圈旋转时自动执行，与发动机的内部节气门周期同步。下图展示了发动机的内部设置</span>：<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/Engine_Model.png\" alt=\"Engine_Model.png\" data-href=\"\" style=\"\"/>
</p>
<p>
<code>crankshaftPositionEvent</code>是同步发动机内部节气门循环和外部控制的事件时钟。 它每旋转半圈就会产生一个时钟滴答声，并以<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.Rotational.RotationalClock\" target=\"\">RotationalClock</a>&nbsp; 的形式实现。
</p>
<p>
下图说明了这种旋转时钟的逻辑：<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/RotationalClock_Model.png\" alt=\"RotationalClock_Model.png\" data-href=\"\" style=\"\"/>
</p>
<p>
它记录了上次识别旋转的角度（<code>angular_offset</code>）。 给定 <code>angular_offset</code>，旋转的事件条件为：
</p>
<p>
<code>abs(angle - angular_offset) &gt;= abs(trigger_interval)</code>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">在我们的案例中，</span><code>angle</code><span style=\"color: rgb(51, 51, 51);\"> 是发动机曲轴的位置，</span><code>trigger_interval</code><span style=\"color: rgb(51, 51, 51);\"> 是 180°。最终，</span><code>crankshaftPositionEvent</code><span style=\"color: rgb(51, 51, 51);\"> 对其自身的输入角度进行采样，以考虑一个偏移量，用于决定何时触发时钟脉冲；时钟的事件条件取决于上次从不满足条件到满足条件时状态的变化，即时钟最后一次触发时的状态。</span>
</p>
<p>
<em>这个示例模型基于以下参考文献：</em>
</p>
<p>
Crossley, P.R. and Cook, J. (1991):
</p>
<p>
<strong>A nonlinear engine model for drivetrain system development</strong>.<br> &nbsp; &nbsp; 国际控制会议, 英国爱丁堡, 三月.<br>
</p>
<p>
Simulink&reg; (R2010b) 演示模型 sldemo_enginewc.mdl:
</p>
<p>
<strong>Engine Timing Model with Closed Loop Control</strong>.<br> &nbsp; &nbsp;EngineThrottleControl 示例使用的参数值与 sldemo_enginewc.mdl 演示模型相同，<br> &nbsp; &nbsp;后者随 MathWorks 公司开发的 Simulink&reg; 软件一起提供。<br> &nbsp; &nbsp;因此，可以方便地比较这些模型的仿真结果。<br> &nbsp; <br>
</p>
</html>"));
end EngineThrottleControl;