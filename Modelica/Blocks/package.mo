within Modelica;
package Blocks "基本输入/输出控制模块(连续、离散、逻辑、表格)库"

  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  package Examples 
    "用于演示Blocks组件使用方法的示例库"

    extends Modelica.Icons.ExamplesPackage;

    model PID_Controller 
      "演示如何使用Continuous.LimPID控制器"
      extends Modelica.Icons.Example;
      parameter SI.Angle driveAngle = 1.570796326794897 
        "参考转动角度";
      Modelica.Blocks.Continuous.LimPID PI(
        k = 100, 
        Ti = 0.1, 
        yMax = 12, 
        Ni = 0.1, 
        initType = Modelica.Blocks.Types.Init.SteadyState, 
        controllerType = Modelica.Blocks.Types.SimpleController.PI, 
        limiter(u(start = 0)), 
        Td = 0.1) annotation(Placement(transformation(extent = {{-56, -20}, {-36, 0}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        phi(fixed = true, start = 0), 
        J = 1, 
        a(fixed = true, start = 0)) annotation(Placement(transformation(extent = {{2, -20}, 
        {22, 0}})));

      Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(
        transformation(extent = {{-25, -20}, {-5, 0}})));
      Modelica.Mechanics.Rotational.Components.SpringDamper spring(
        c = 1e4, 
        d = 100, 
        stateSelect = StateSelect.prefer, 
        w_rel(fixed = true)) annotation(Placement(transformation(extent = {{32, -20}, 
        {52, 0}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia2(J = 2) annotation(
        Placement(transformation(extent = {{60, -20}, {80, 0}})));
      Modelica.Blocks.Sources.KinematicPTP kinematicPTP(
        startTime = 0.5, 
        deltaq = {driveAngle}, 
        qd_max = {1}, 
        qdd_max = {1}) annotation(Placement(transformation(extent = {{-92, 20}, {-72, 
        40}})));
      Modelica.Blocks.Continuous.Integrator integrator(initType = Modelica.Blocks.Types.Init.InitialState) 
        annotation(Placement(transformation(extent = {{-63, 20}, {-43, 40}})));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(
        Placement(transformation(extent = {{22, -50}, {2, -30}})));
      Modelica.Mechanics.Rotational.Sources.ConstantTorque loadTorque(
        tau_constant = 10, useSupport = false) annotation(Placement(transformation(
        extent = {{98, -15}, {88, -5}})));
    initial equation
      der(spring.w_rel) = 0;

    equation
      connect(spring.flange_b, inertia2.flange_a) 
        annotation(Line(points = {{52, -10}, {60, -10}}));
      connect(inertia1.flange_b, spring.flange_a) 
        annotation(Line(points = {{22, -10}, {32, -10}}));
      connect(torque.flange, inertia1.flange_a) 
        annotation(Line(points = {{-5, -10}, {2, -10}}));
      connect(kinematicPTP.y[1], integrator.u) 
        annotation(Line(points = {{-71, 30}, {-65, 30}}, color = {0, 0, 127}));
      connect(speedSensor.flange, inertia1.flange_b) 
        annotation(Line(points = {{22, -40}, {22, -10}}));
      connect(loadTorque.flange, inertia2.flange_b) 
        annotation(Line(points = {{88, -10}, {80, -10}}));
      connect(PI.y, torque.tau) 
        annotation(Line(points = {{-35, -10}, {-27, -10}}, color = {0, 0, 127}));
      connect(speedSensor.w, PI.u_m) 
        annotation(Line(points = {{1, -40}, {-46, -40}, {-46, -22}}, color = {0, 0, 127}));
      connect(integrator.y, PI.u_s) annotation(Line(points = {{-42, 30}, {-37, 30}, {-37, 
        11}, {-67, 11}, {-67, -10}, {-58, -10}}, color = {0, 0, 127}));
      annotation(
        Diagram(coordinateSystem(
        preserveAspectRatio = true, 
        extent = {{-100, -100}, {100, 100}}), graphics = {
        Rectangle(extent = {{-99, 48}, {-32, 8}}, lineColor = {255, 0, 0}), 
        Text(
        extent = {{-98, 59}, {-31, 51}}, 
        textColor = {255, 0, 0}, 
        textString = "reference speed generation"), 
        Text(
        extent = {{-98, -46}, {-60, -52}}, 
        textColor = {255, 0, 0}, 
        textString = "PI controller"), 
        Line(
        points = {{-76, -44}, {-57, -23}}, 
        color = {255, 0, 0}, 
        arrow = {Arrow.None, Arrow.Filled}), 
        Rectangle(extent = {{-25, 6}, {99, -50}}, lineColor = {255, 0, 0}), 
        Text(
        extent = {{4, 14}, {71, 7}}, 
        textColor = {255, 0, 0}, 
        textString = "plant (simple drive train)")}), 
        experiment(StopTime = 4), 
        Documentation(info = "<html><p>
这是一个由PID控制器控制的简单传动系统:
</p>
<ul><li>
两个模块\"kinematic_PTP\"和\"integrator\"用于生成参考速度 (=恒定加速阶段、恒定速度阶段、恒定减速阶段，直到处于惯性静止状态)。 为检查系统是否处于稳定状态， 参考速度在时间=0.5s之前为零， 然后按照草图轨迹运行。</li>
<li>
控制模块\"PI\"是\"Blocks.Continuous.LimPID\"的一个示例，\"Blocks.Continuous.LimPID\"是一个\"PID\"控制器，其中添加了一些重要的实用功能，如超调补偿。 在这种情况下，控制块被用作\"PI\"控制器。</li>
<li>
控制器的输出是一个驱动惯性电机\"inertia1\"的扭矩。 负载惯性\"inertia2\"通过一个弹簧/阻尼器部件连接。 10Nm的恒定外部扭矩作用在惯性负载上。</li>
</ul><p>
\"PI\"控制器在稳态下初始化(initType=SteadyState)， 驱动器也应在稳态下初始化。 但是，无法在稳态中初始化inertia1， 因为\"der(inertia1.phi)=inertia1.w=0\"是\"PI\"控制器的输入， 它定义积分器状态的导数为零 (=\"PI\"控制器的稳态选项已定义的相同条件)。 此外，还缺少一个初始条件， 因为没有定义inertia1或Inertia2的绝对位置。 本示例中的解决方案是初始化Inertia1的角度和角加速度。
</p>
<p>
下图显示了一次典型模拟的结果：
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/PID_controller.png\" alt=\"PID_controller.png\" data-href=\"\" style=\"\"/><br><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/PID_controller2.png\" alt=\"PID_controller2.png\" data-href=\"\" style=\"\"/>
</p>
<p>
上图显示了参考速度(=integrator.y)和实际速度(=inertia1.w)。 可以看出，由于不存在瞬态， 系统初始化时处于稳定状态。 在恒速阶段结束前，惯性与参考转速保持一致，随后出现偏差。从下图中可以看出其原因： 控制器(PI.y)的输出处于极限值。 由于限制器(PI.limiter.u) 的输入在瞬态阶段后被强制恢复到其极限值， 因此超调补偿的效果很好。
</p>
</html>"    ));
    end PID_Controller;

    model Filter "演示带有各种选项的Continuous.Filter模块"
      extends Modelica.Icons.Example;
      parameter Integer order = 3 "滤波器阶数";
      parameter SI.Frequency f_cut = 2 "截止频率";
      parameter Modelica.Blocks.Types.FilterType filterType = Modelica.Blocks.Types.FilterType.LowPass 
        "滤波器类型(低通/高通)";
      parameter Modelica.Blocks.Types.Init init = Modelica.Blocks.Types.Init.SteadyState 
        "初始化类型(无初始化/稳态初始化/初始状态初始化/初始输出初始化)";
      parameter Boolean normalized = true "如果在f_cut频率处的振幅为-3dB，则为true，否则为未修改的滤波器";

      Modelica.Blocks.Sources.Step step(startTime = 0.1, offset = 0.1) 
        annotation(Placement(transformation(extent = {{-60, 40}, {-40, 60}})));
      Modelica.Blocks.Continuous.Filter CriticalDamping(
        analogFilter = Modelica.Blocks.Types.AnalogFilter.CriticalDamping, 
        normalized = normalized, 
        init = init, 
        filterType = filterType, 
        order = order, 
        f_cut = f_cut, 
        f_min = 0.8 * f_cut) 
        annotation(Placement(transformation(extent = {{-20, 40}, {0, 60}})));
      Modelica.Blocks.Continuous.Filter Bessel(
        normalized = normalized, 
        analogFilter = Modelica.Blocks.Types.AnalogFilter.Bessel, 
        init = init, 
        filterType = filterType, 
        order = order, 
        f_cut = f_cut, 
        f_min = 0.8 * f_cut) 
        annotation(Placement(transformation(extent = {{-20, 0}, {0, 20}})));
      Modelica.Blocks.Continuous.Filter Butterworth(
        normalized = normalized, 
        analogFilter = Modelica.Blocks.Types.AnalogFilter.Butterworth, 
        init = init, 
        filterType = filterType, 
        order = order, 
        f_cut = f_cut, 
        f_min = 0.8 * f_cut) 
        annotation(Placement(transformation(extent = {{-20, -40}, {0, -20}})));
      Modelica.Blocks.Continuous.Filter ChebyshevI(
        normalized = normalized, 
        analogFilter = Modelica.Blocks.Types.AnalogFilter.ChebyshevI, 
        init = init, 
        filterType = filterType, 
        order = order, 
        f_cut = f_cut, 
        f_min = 0.8 * f_cut) 
        annotation(Placement(transformation(extent = {{-20, -80}, {0, -60}})));

    equation
      connect(step.y, CriticalDamping.u) annotation(Line(
        points = {{-39, 50}, {-22, 50}}, color = {0, 0, 127}));
      connect(step.y, Bessel.u) annotation(Line(
        points = {{-39, 50}, {-32, 50}, {-32, 10}, {-22, 10}}, color = {0, 0, 127}));
      connect(Butterworth.u, step.y) annotation(Line(
        points = {{-22, -30}, {-32, -30}, {-32, 50}, {-39, 50}}, color = {0, 0, 127}));
      connect(ChebyshevI.u, step.y) annotation(Line(
        points = {{-22, -70}, {-32, -70}, {-32, 50}, {-39, 50}}, color = {0, 0, 127}));
      annotation(
        experiment(StopTime = 0.9), 
        Documentation(info = "<html><p>
本例演示了 <a href=\"modelica://Modelica.Blocks.Continuous.Filter\" target=\"\">Filter</a> 模块的各种选项。 阶跃输入从0.1秒开始，偏移量为0.1，以演示初始化选项。 该阶跃输入驱动4个参数完全相同的滤波器模块， 唯一不同的是所使用的模拟滤波器类型(临界阻尼、贝塞尔、巴特沃斯、切比雪夫I型)。 所有主要选项均可通过参数设置，然后应用于所有 4 个滤波器。 默认设置使用截止频率为2Hz的3阶低通滤波器， 输出结果如下：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Filter1.png\" alt=\"Filter1.png\" data-href=\"\" style=\"\">
</p>
</html>"    ));
    end Filter;

    model FilterWithDifferentiation 
      "演示如何使用低通滤波器来确定滤波器的导数"
      extends Modelica.Icons.Example;
      parameter SI.Frequency f_cut = 2 "截止频率";

      Modelica.Blocks.Sources.Step step(startTime = 0.1, offset = 0.1) 
        annotation(Placement(transformation(extent = {{-80, 40}, {-60, 60}})));
      Modelica.Blocks.Continuous.Filter Bessel(
        f_cut = f_cut, 
        filterType = Modelica.Blocks.Types.FilterType.LowPass, 
        order = 3, 
        analogFilter = Modelica.Blocks.Types.AnalogFilter.Bessel) 
        annotation(Placement(transformation(extent = {{-40, 40}, {-20, 60}})));

      Continuous.Der der1 
        annotation(Placement(transformation(extent = {{-6, 40}, {14, 60}})));
      Continuous.Der der2 
        annotation(Placement(transformation(extent = {{30, 40}, {50, 60}})));
      Continuous.Der der3 
        annotation(Placement(transformation(extent = {{62, 40}, {82, 60}})));
    equation
      connect(step.y, Bessel.u) annotation(Line(
        points = {{-59, 50}, {-42, 50}}, color = {0, 0, 127}));
      connect(Bessel.y, der1.u) annotation(Line(
        points = {{-19, 50}, {-8, 50}}, color = {0, 0, 127}));
      connect(der1.y, der2.u) annotation(Line(
        points = {{15, 50}, {28, 50}}, color = {0, 0, 127}));
      connect(der2.y, der3.u) annotation(Line(
        points = {{51, 50}, {60, 50}}, color = {0, 0, 127}));
      annotation(
        experiment(StopTime = 0.9), 
        Documentation(info="<html><p>
这个示例表明，<a href=\"modelica://Modelica.Blocks.Continuous.Filter\" target=\"\">Filter</a>&nbsp; 模块<span style=\"color: rgb(51, 51, 51);\">的输出可以对滤波器的阶数进行求导</span>， 这一特性可用于实现逆模型或者“平滑处理”可能存在的不连续控制信号。
</p>
</html>"));
    end FilterWithDifferentiation;

    model FilterWithRiseTime 
      "演示如何使用上升时间而不是截止频率来设置滤波器"
      import Modelica.Constants.pi;
      extends Modelica.Icons.Example;
      parameter Integer order = 2 "滤波器阶数";
      parameter SI.Time riseTime = 2 "到达阶跃输入的时间";

      Continuous.Filter filter_fac5(f_cut = 5 / (2 * pi * riseTime), order = order) 
        annotation(Placement(transformation(extent = {{-20, -20}, {0, 0}})));
      Sources.Step step(startTime = 1) 
        annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
      Continuous.Filter filter_fac4(f_cut = 4 / (2 * pi * riseTime), order = order) 
        annotation(Placement(transformation(extent = {{-20, 20}, {0, 40}})));
      Continuous.Filter filter_fac3(f_cut = 3 / (2 * pi * riseTime), order = order) 
        annotation(Placement(transformation(extent = {{-20, 62}, {0, 82}})));
    equation
      connect(step.y, filter_fac5.u) annotation(Line(
        points = {{-39, 30}, {-30, 30}, {-30, -10}, {-22, -10}}, color = {0, 0, 127}));
      connect(step.y, filter_fac4.u) annotation(Line(
        points = {{-39, 30}, {-22, 30}}, color = {0, 0, 127}));
      connect(step.y, filter_fac3.u) annotation(Line(
        points = {{-39, 30}, {-30, 30}, {-30, 72}, {-22, 72}}, color = {0, 0, 127}));
      annotation(experiment(StopTime = 4), Documentation(info = "<html><p>
滤波器通常通过截止频率进行参数化设置，有时也会使用上升时间。 有时用上升时间来参数化设置滤波器更合理， 即输出达到阶跃输入的最终值所需的时间。这通常通过以下公式来计算：
</p>
<pre><code >f_cut = fac/(2*pi*riseTime);</code></pre><p>
其中，\"fac\"通常取值为3、4或5。 下图展示了这个示例模型的模拟结果 (上升时间为2秒，fac分别取3、4和5)：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/FilterWithRiseTime.png\" alt=\"FilterWithRiseTime.png\" data-href=\"\" style=\"\">
</p>
<p>
由于阶跃信号开始于1秒，而上升时间为2秒， 滤波器输出y将在1+2=3s时达到1，根据\"fac\" 达到这个值的精度会有所不同。可以用以下表格来概括：
</p>

<blockquote><table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr>
   <td>滤波器阶数</td>
   <td>fac因子</td>
   <td>上升时间后达到的步进值的百分比</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">3</td>
   <td align=\"center\">95.1 %</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">4</td>
   <td align=\"center\">98.2 %</td>
</tr>
<tr>
   <td align=\"center\">1</td>
   <td align=\"center\">5</td>
   <td align=\"center\">99.3 %</td>
</tr>

<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">3</td>
   <td align=\"center\">94.7 %</td>
</tr>
<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">4</td>
   <td align=\"center\">98.6 %</td>
</tr>
<tr>
   <td align=\"center\">2</td>
   <td align=\"center\">5</td>
   <td align=\"center\">99.6 %</td>
</tr>
</table></blockquote>

</html>"          ));
    end FilterWithRiseTime;

    model SlewRateLimiter 
      "演示Nonlinear.SlewRateLimiter的使用"
      extends Modelica.Icons.Example;
      parameter SI.Velocity vMax = 2 "最大速度";
      parameter SI.Acceleration aMax = 20 "最大加速度";
      SI.Position s = positionStep.y "参考位置";
      SI.Position sSmoothed = positionSmoothed.y "平滑位置";
      SI.Velocity vLimited = limit_a.y "限制速度";
      SI.Acceleration aLimited = a.y "限制加速度";
      Modelica.Blocks.Sources.Step positionStep(startTime = 0.1) 
        annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
      Modelica.Blocks.Nonlinear.SlewRateLimiter limit_v(
        initType = Modelica.Blocks.Types.Init.InitialOutput, 
        Rising = vMax, 
        y_start = positionStep.offset, 
        Td = 0.0001) 
        annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
      Modelica.Blocks.Continuous.Der v 
        annotation(Placement(transformation(extent = {{-20, -10}, {0, 10}})));
      Modelica.Blocks.Nonlinear.SlewRateLimiter limit_a(
        initType = Modelica.Blocks.Types.Init.InitialOutput, 
        y_start = 0, 
        Rising = 20, 
        Td = 0.0001) 
        annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
      Modelica.Blocks.Continuous.Integrator positionSmoothed(
        k = 1, 
        initType = Modelica.Blocks.Types.Init.InitialOutput, 
        y_start = positionStep.offset) 
        annotation(Placement(transformation(extent = {{50, -10}, {70, 10}})));
      Modelica.Blocks.Continuous.Der a 
        annotation(Placement(transformation(extent = {{50, -40}, {70, -20}})));
    equation
      connect(positionStep.y, limit_v.u) 
        annotation(Line(points = {{-59, 0}, {-52, 0}}, color = {0, 0, 127}));
      connect(limit_v.y, v.u) 
        annotation(Line(points = {{-29, 0}, {-22, 0}}, color = {0, 0, 127}));
      connect(v.y, limit_a.u) 
        annotation(Line(points = {{1, 0}, {8, 0}}, color = {0, 0, 127}));
      connect(limit_a.y, positionSmoothed.u) 
        annotation(Line(points = {{31, 0}, {39.5, 0}, {48, 0}}, color = {0, 0, 127}));
      connect(limit_a.y, a.u) annotation(Line(points = {{31, 0}, {40, 0}, {40, -30}, {48, -30}}, 
        color = {0, 0, 127}));

      annotation(experiment(StopTime = 1.0, Interval = 0.001), Documentation(info = "<html><p>
这个例子演示了如何使用 Nonlinear.SlewRateLimiter 模块来限制位置步进的速度和加速度：
</p>
<ul><li>
源步进模块<code>positionStep</code> 定义一个非物理的位置步进。</li>
<li>
第一个限幅模块<code>limit_v</code>限制速度。</li>
<li>
第一个导数模块<code>v</code>在平滑的位置信号中计算速度。</li>
<li>
第二个限幅模块<code>limit_v</code>用于限制平滑后的速度信号加速度。</li>
<li>
第二个变化率模块<code>a</code>用于从平滑后的速度信号中计算加速度。</li>
<li>
积分模块<code>positionSmoothed</code>从平滑后的速度信号计算平滑后的位置信号。</li>
</ul><p>
一个具有有限速度和有限加速度(即扭矩)的位置控制驱动器能够跟踪平滑的参考位置。
</p>
</html>"      ));
    end SlewRateLimiter;

    model InverseModel "演示反向模型的构造方法"
      extends Modelica.Icons.Example;

      Continuous.FirstOrder firstOrder1(
        k = 1, 
        T = 0.3, 
        initType = Modelica.Blocks.Types.Init.SteadyState) 
        annotation(Placement(transformation(extent = {{20, 20}, {0, 40}})));
      Sources.Sine sine(
        f = 2, 
        offset = 1, 
        startTime = 0.2) 
        annotation(Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
      Math.InverseBlockConstraints inverseBlockConstraints 
        annotation(Placement(transformation(extent = {{-10, 20}, {30, 40}})));
      Continuous.FirstOrder firstOrder2(
        k = 1, 
        T = 0.3, 
        initType = Modelica.Blocks.Types.Init.SteadyState) 
        annotation(Placement(transformation(extent = {{20, -20}, {0, 0}})));
      Math.Feedback feedback 
        annotation(Placement(transformation(extent = {{-40, 0}, {-60, -20}})));
      Continuous.CriticalDamping criticalDamping(n = 1, f = 50 * sine.f) 
        annotation(Placement(transformation(extent = {{-40, 20}, {-20, 40}})));
    equation
      connect(firstOrder1.y, inverseBlockConstraints.u2) annotation(Line(
        points = {{-1, 30}, {-6, 30}}, color = {0, 0, 127}));
      connect(inverseBlockConstraints.y2, firstOrder1.u) annotation(Line(
        points = {{27, 30}, {22, 30}}, color = {0, 0, 127}));
      connect(firstOrder2.y, feedback.u1) annotation(Line(
        points = {{-1, -10}, {-42, -10}}, color = {0, 0, 127}));
      connect(sine.y, criticalDamping.u) annotation(Line(
        points = {{-59, 30}, {-42, 30}}, color = {0, 0, 127}));
      connect(criticalDamping.y, inverseBlockConstraints.u1) annotation(Line(
        points = {{-19, 30}, {-12, 30}}, color = {0, 0, 127}));
      connect(sine.y, feedback.u2) annotation(Line(
        points = {{-59, 30}, {-50, 30}, {-50, -2}}, color = {0, 0, 127}));
      connect(inverseBlockConstraints.y1, firstOrder2.u) annotation(Line(
        points = {{31, 30}, {40, 30}, {40, -10}, {22, -10}}, color = {0, 0, 127}));
      annotation(Documentation(info = "<html><p>
这个示例展示了如何在Modelica中构造一个反向模型 (更多细节请查看 <a href=\"https://www.modelica.org/events/Conference2005/online_proceedings/Session3/Session3c3.pdf\" target=\"\">Looye, Thümmel, Kurze, Otter, Bals: Nonlinear Inverse Models for Control</a>).
</p>
<p>
对于一个线性、单输入、单输出的系统
</p>
<pre><code >y = n(s)/d(s) * u   // 控制模型</code></pre><p>
反向模型的推导通常通过简单地交换分子和分母多项式来实现：
</p>
<pre><code >u = d(s)/n(s) * y   // 反向控制模型</code></pre><p>
如果分母多项式 d(s)的次数高于分子多项式n(s) (这在控制模型中通常是这种情况)， 那么反向模型就不再是适当的，也就是说，它是非因果的。 为了避免这种情况， 一般通过在逆模型的分母中添加足够数量的极点来构建一个近似的反向模型。 这可以解释为对期望的输出信号 y 进行滤波：
</p>
<pre><code >u = d(s)/(n(s)*f(s)) * y  // 带滤波y的反向控制模型</code></pre><p>
在Modelica中，原则上不仅能够构建线性模型的反向模型， 而且可以处理非线性模型， 特别是对于任何Modelica模型。 将通过实例进行解释基本的构建机制：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/InverseModelSchematic.png\" alt=\"InverseModelSchematic.png\" data-href=\"\" style=\"\">
</p>
<p>
这里要对一阶模块\"firstOrder1\"进行反转。 这是通过将其输入和输出与一个Modelica.Blocks.Math.<strong>InverseBlockConstraints</strong>模块连接来完成的。 通过这种连接， 输入和输出被交换。目标是计算 \"firstOrder1\"模块的输入值，使其跟随给定的正弦信号输出。 为此，首先使用一阶滤波器\"CriticalDamping\" 对正弦信号\"sin\"进行滤波，然后将该滤波器的输出连接到\"firstOrder1\"模块的输出 (通过\"InverseBlockConstraints\"模块连接， 因为在框图中两个输出不能直接连接在一起)。
</p>
<p>
为了验证反向运算，计算出的\"firstOrder1\"模块的输入被用作一个相同结构的\"firstOrder2\"模块的输入。 理论上，\"firstOrder2\"的输出应该等于原始的正弦函数。 通过\"feedback\"模块计算两者之间的差异。 由于正弦信号经过滤波，我们不能期望这个差异为零。 滤波器的截止频率越高，两者之间的吻合度就越好。 下图展示了一种典型的模拟结果：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/InverseModel.png\" alt=\"InverseModel.png\" data-href=\"\" style=\"\">
</p>
</html>"    ), experiment(StopTime = 1.0));
    end InverseModel;

    model ShowLogicalSources 
      "演示逻辑源以及其图表动画的使用"
      extends Modelica.Icons.Example;
      Sources.BooleanTable table(table = {2, 4, 6, 8}) annotation(Placement(
        transformation(extent = {{-60, -100}, {-40, -80}})));
      Sources.BooleanConstant const annotation(Placement(transformation(extent = {
        {-60, 60}, {-40, 80}})));
      Sources.BooleanStep step(startTime = 4) annotation(Placement(transformation(
        extent = {{-60, 20}, {-40, 40}})));
      Sources.BooleanPulse pulse(period = 1.5) annotation(Placement(transformation(
        extent = {{-60, -20}, {-40, 0}})));

      Sources.SampleTrigger sample(period = 0.5) annotation(Placement(
        transformation(extent = {{-60, -60}, {-40, -40}})));
      Sources.BooleanExpression booleanExpression(y = pulse.y and step.y) 
        annotation(Placement(transformation(extent = {{20, 20}, {80, 40}})));
      annotation(experiment(StopTime = 10), Documentation(info = "<html>
<p>
这个简单的示例演示了在<a href=\"modelica://Modelica.Blocks.Sources\">Modelica.Blocks.Sources</a> 中的逻辑源，
并展示了它们的图表动画（参见输出连接器附近的“小圆圈”）。
“布尔表达式”源演示了如何在参数菜单中定义一个逻辑表达式，
并引用这一层级模型中可用的变量。
</p>

</html>"  ));
    end ShowLogicalSources;

    model LogicalNetwork1 "演示逻辑模块的使用方法"

      extends Modelica.Icons.Example;
      Sources.BooleanTable table2(table = {1, 3, 5, 7}) annotation(Placement(
        transformation(extent = {{-80, -20}, {-60, 0}})));
      Sources.BooleanTable table1(table = {2, 4, 6, 8}) annotation(Placement(
        transformation(extent = {{-80, 20}, {-60, 40}})));
      Logical.Not Not1 annotation(Placement(transformation(extent = {{-40, -20}, {-20, 
        0}})));

      Logical.And And1 annotation(Placement(transformation(extent = {{0, -20}, {20, 0}})));
      Logical.Or Or1 annotation(Placement(transformation(extent = {{40, 20}, {60, 40}})));
      Logical.Pre Pre1 annotation(Placement(transformation(extent = {{-40, -60}, {-20, 
        -40}})));
    equation

      connect(table2.y, Not1.u) 
        annotation(Line(points = {{-59, -10}, {-42, -10}}, color = {255, 0, 255}));
      connect(And1.y, Or1.u2) annotation(Line(points = {{21, -10}, {28, -10}, {28, 22}, 
        {38, 22}}, color = {255, 0, 255}));
      connect(table1.y, Or1.u1) 
        annotation(Line(points = {{-59, 30}, {38, 30}}, color = {255, 0, 255}));
      connect(Not1.y, And1.u1) 
        annotation(Line(points = {{-19, -10}, {-2, -10}}, color = {255, 0, 255}));
      connect(Pre1.y, And1.u2) annotation(Line(points = {{-19, -50}, {-10, -50}, {-10, 
        -18}, {-2, -18}}, color = {255, 0, 255}));
      connect(Or1.y, Pre1.u) annotation(Line(points = {{61, 30}, {68, 30}, {68, -70}, {-60, 
        -70}, {-60, -50}, {-42, -50}}, color = {255, 0, 255}));

      annotation(experiment(StopTime = 10), Documentation(info = "<html>
<p>
这个示例展示了逻辑模块网络的使用。
请注意，在图表动画中，
输入和输出信号的布尔值是通过靠近连接器的小“圆圈”来可视化的。
如果一个“圆圈”是“白色”的，那么信号为<strong>假</strong>。
如果一个“圆圈”是“绿色”的，那么信号为<strong>真</strong>。
</p>
</html>"    ));
    end LogicalNetwork1;

    model RealNetwork1 "演示如何使用来自Modelica.Blocks.Math的模块"

      extends Modelica.Icons.Example;

      Modelica.Blocks.Math.MultiSum add(nu = 2) 
        annotation(Placement(transformation(extent = {{-14, 64}, {-2, 76}})));
      Sources.Sine sine(amplitude = 3, f = 0.1) 
        annotation(Placement(transformation(extent = {{-96, 60}, {-76, 80}})));
      Sources.Step integerStep(height = 3, startTime = 2) 
        annotation(Placement(transformation(extent = {{-60, 30}, {-40, 50}})));
      Sources.Constant integerConstant(k = 1) 
        annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
      Modelica.Blocks.Interaction.Show.RealValue showValue 
        annotation(Placement(transformation(extent = {{66, 60}, {86, 80}})));
      Math.MultiProduct product(nu = 2) 
        annotation(Placement(transformation(extent = {{6, 24}, {18, 36}})));
      Modelica.Blocks.Interaction.Show.RealValue showValue1(significantDigits = 2) 
        annotation(Placement(transformation(extent = {{64, 20}, {84, 40}})));
      Sources.BooleanPulse booleanPulse1(period = 1) 
        annotation(Placement(transformation(extent = {{-12, -30}, {8, -10}})));
      Math.MultiSwitch multiSwitch(
        nu = 2, 
        expr = {4, 6}, 
        y_default = 2) 
        annotation(Placement(transformation(extent = {{28, -60}, {68, -40}})));
      Sources.BooleanPulse booleanPulse2(period = 2, width = 80) 
        annotation(Placement(transformation(extent = {{-12, -70}, {8, -50}})));
      Modelica.Blocks.Interaction.Show.RealValue showValue3(
        use_numberPort = false, 
        number = multiSwitch.y, 
        significantDigits = 1) 
        annotation(Placement(transformation(extent = {{40, -84}, {60, -64}})));
      Math.LinearDependency linearDependency1(
        y0 = 1, 
        k1 = 2, 
        k2 = 3) annotation(Placement(transformation(extent = {{40, 80}, {60, 100}})));
      Math.MinMax minMax(nu = 2) 
        annotation(Placement(transformation(extent = {{58, -16}, {78, 4}})));
    equation
      connect(booleanPulse1.y, multiSwitch.u[1]) annotation(Line(
        points = {{9, -20}, {18, -20}, {18, -48}, {28, -48}, {28, -48.5}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, multiSwitch.u[2]) annotation(Line(
        points = {{9, -60}, {18, -60}, {18, -52}, {28, -52}, {28, -51.5}}, color = {255, 0, 255}));
      connect(sine.y, add.u[1]) annotation(Line(
        points = {{-75, 70}, {-46.5, 70}, {-46.5, 72.1}, {-14, 72.1}}, color = {0, 0, 127}));
      connect(integerStep.y, add.u[2]) annotation(Line(
        points = {{-39, 40}, {-28, 40}, {-28, 67.9}, {-14, 67.9}}, color = {0, 0, 127}));
      connect(add.y, showValue.numberPort) annotation(Line(
        points = {{-0.98, 70}, {64.5, 70}}, color = {0, 0, 127}));
      connect(integerStep.y, product.u[1]) annotation(Line(
        points = {{-39, 40}, {-20, 40}, {-20, 32.1}, {6, 32.1}}, color = {0, 0, 127}));
      connect(integerConstant.y, product.u[2]) annotation(Line(
        points = {{-39, 0}, {-20, 0}, {-20, 27.9}, {6, 27.9}}, color = {0, 0, 127}));
      connect(product.y, showValue1.numberPort) annotation(Line(
        points = {{19.02, 30}, {62.5, 30}}, color = {0, 0, 127}));
      connect(add.y, linearDependency1.u1) annotation(Line(
        points = {{-0.98, 70}, {20, 70}, {20, 96}, {38, 96}}, color = {0, 0, 127}));
      connect(product.y, linearDependency1.u2) annotation(Line(
        points = {{19.02, 30}, {30, 30}, {30, 84}, {38, 84}}, color = {0, 0, 127}));
      connect(add.y, minMax.u[1]) annotation(Line(
        points = {{-0.98, 70}, {48, 70}, {48, -2.5}, {58, -2.5}}, color = {0, 0, 127}));
      connect(product.y, minMax.u[2]) annotation(Line(
        points = {{19.02, 30}, {40, 30}, {40, -9.5}, {58, -9.5}}, color = {0, 0, 127}));
      annotation(
        experiment(StopTime = 10), 
        Documentation(info = "<html>
<p>
这个示例演示了一个来自<a href=\"modelica://Modelica.Blocks.Math\">Modelica.Blocks.Math</a>的数学实数块组成的网络。
请注意
</p>

<ul>
<li> 在模型的右侧，
存在几个Math.ShowValue模块，
这些模块将各自的实数信号的实际值可视化为一个图形动画。</li>

<li> 输入和输出信号的布尔值通过图示动画中的小“圆圈”进行可视化。
这些小圆圈位于连接器的附近，直观地展示了信号的状态。
如果“圆圈”为“白色”，那么信号为<strong>false</strong>。如果“圆圈”为“绿色”，
那么信号为<strong>true</strong>。</li>
</ul>

</html>"    ));
    end RealNetwork1;

    model IntegerNetwork1 
      "演示如何使用来自Modelica.Blocks.MathInteger的模块"

      extends Modelica.Icons.Example;

      MathInteger.Sum sum(nu = 3) 
        annotation(Placement(transformation(extent = {{-14, 64}, {-2, 76}})));
      Sources.Sine sine(amplitude = 3, f = 0.1) 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}})));
      Math.RealToInteger realToInteger 
        annotation(Placement(transformation(extent = {{-60, 60}, {-40, 80}})));
      Sources.IntegerStep integerStep(height = 3, startTime = 2) 
        annotation(Placement(transformation(extent = {{-60, 30}, {-40, 50}})));
      Sources.IntegerConstant integerConstant(k = 1) 
        annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
      Modelica.Blocks.Interaction.Show.IntegerValue showValue 
        annotation(Placement(transformation(extent = {{40, 60}, {60, 80}})));
      MathInteger.Product product(nu = 2) 
        annotation(Placement(transformation(extent = {{16, 24}, {28, 36}})));
      Modelica.Blocks.Interaction.Show.IntegerValue showValue1 
        annotation(Placement(transformation(extent = {{40, 20}, {60, 40}})));
      MathInteger.TriggeredAdd triggeredAdd(use_reset = false, use_set = false) 
        annotation(Placement(transformation(extent = {{16, -6}, {28, 6}})));
      Sources.BooleanPulse booleanPulse1(period = 1) 
        annotation(Placement(transformation(extent = {{-12, -30}, {8, -10}})));
      Modelica.Blocks.Interaction.Show.IntegerValue showValue2 
        annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
      MathInteger.MultiSwitch multiSwitch1(
        nu = 2, 
        expr = {4, 6}, 
        y_default = 2, 
        use_pre_as_default = false) 
        annotation(Placement(transformation(extent = {{28, -60}, {68, -40}})));
      Sources.BooleanPulse booleanPulse2(period = 2, width = 80) 
        annotation(Placement(transformation(extent = {{-12, -70}, {8, -50}})));
      Modelica.Blocks.Interaction.Show.IntegerValue showValue3(use_numberPort = 
        false, number = multiSwitch1.y) 
        annotation(Placement(transformation(extent = {{40, -84}, {60, -64}})));
    equation
      connect(sine.y, realToInteger.u) annotation(Line(
        points = {{-79, 70}, {-62, 70}}, color = {0, 0, 127}));
      connect(realToInteger.y, sum.u[1]) annotation(Line(
        points = {{-39, 70}, {-32, 70}, {-32, 72}, {-14, 72}, {-14, 72.8}}, color = {255, 127, 0}));
      connect(integerStep.y, sum.u[2]) annotation(Line(
        points = {{-39, 40}, {-28, 40}, {-28, 70}, {-14, 70}}, color = {255, 127, 0}));
      connect(integerConstant.y, sum.u[3]) annotation(Line(
        points = {{-39, 0}, {-22, 0}, {-22, 67.2}, {-14, 67.2}}, color = {255, 127, 0}));
      connect(sum.y, showValue.numberPort) annotation(Line(
        points = {{-1.1, 70}, {38.5, 70}}, color = {255, 127, 0}));
      connect(sum.y, product.u[1]) annotation(Line(
        points = {{-1.1, 70}, {4, 70}, {4, 32.1}, {16, 32.1}}, color = {255, 127, 0}));
      connect(integerStep.y, product.u[2]) annotation(Line(
        points = {{-39, 40}, {-8, 40}, {-8, 27.9}, {16, 27.9}}, color = {255, 127, 0}));
      connect(product.y, showValue1.numberPort) annotation(Line(
        points = {{28.9, 30}, {38.5, 30}}, color = {255, 127, 0}));
      connect(integerConstant.y, triggeredAdd.u) annotation(Line(
        points = {{-39, 0}, {13.6, 0}}, color = {255, 127, 0}));
      connect(booleanPulse1.y, triggeredAdd.trigger) annotation(Line(
        points = {{9, -20}, {18.4, -20}, {18.4, -7.2}}, color = {255, 0, 255}));
      connect(triggeredAdd.y, showValue2.numberPort) annotation(Line(
        points = {{29.2, 0}, {38.5, 0}}, color = {255, 127, 0}));
      connect(booleanPulse1.y, multiSwitch1.u[1]) annotation(Line(
        points = {{9, -20}, {18, -20}, {18, -48}, {28, -48}, {28, -48.5}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, multiSwitch1.u[2]) annotation(Line(
        points = {{9, -60}, {18, -60}, {18, -52}, {28, -52}, {28, -51.5}}, color = {255, 0, 255}));
      annotation(experiment(StopTime = 10), Documentation(info = "<html>
<p>
这个示例演示了一个来自<a href=\"modelica://Modelica.Blocks.MathInteger\">Modelica.Blocks.MathInteger</a>
的整数块组成的网络。请注意
</p>

<ul>
<li> 在模型的右侧，
存在几个MathInteger.ShowValue模块，
这些模块将各自的整数信号的实际值可视化为一个图形动画。</li>

<li> 输入和输出信号的布尔值通过图示动画中的小“圆圈”进行可视化。
这些小圆圈位于连接器的附近，直观地展示了信号的状态。
如果“圆圈”为“白色”，那么信号为<strong>false</strong>。
如果“圆圈”为“绿色”，那么信号为<strong>ture</strong>。</li>

</ul>

</html>"      ));
    end IntegerNetwork1;

    model BooleanNetwork1 
      "演示如何使用来自Modelica.Blocks.MathBoolean的模块"

      extends Modelica.Icons.Example;

      Modelica.Blocks.Interaction.Show.BooleanValue showValue 
        annotation(Placement(transformation(extent = {{-36, 74}, {-16, 94}})));
      MathBoolean.And and1(nu = 3) 
        annotation(Placement(transformation(extent = {{-58, 64}, {-46, 76}})));
      Sources.BooleanPulse booleanPulse1(width = 20, period = 1) 
        annotation(Placement(transformation(extent = {{-100, 60}, {-80, 80}})));
      Sources.BooleanPulse booleanPulse2(period = 1, width = 80) 
        annotation(Placement(transformation(extent = {{-100, -4}, {-80, 16}})));
      Sources.BooleanStep booleanStep(startTime = 1.5) 
        annotation(Placement(transformation(extent = {{-100, 28}, {-80, 48}})));
      MathBoolean.Or or1(nu = 2) 
        annotation(Placement(transformation(extent = {{-28, 62}, {-16, 74}})));
      MathBoolean.Xor xor1(nu = 2) 
        annotation(Placement(transformation(extent = {{-2, 60}, {10, 72}})));
      Modelica.Blocks.Interaction.Show.BooleanValue showValue2 
        annotation(Placement(transformation(extent = {{-2, 74}, {18, 94}})));
      Modelica.Blocks.Interaction.Show.BooleanValue showValue3 
        annotation(Placement(transformation(extent = {{24, 56}, {44, 76}})));
      MathBoolean.Nand nand1(nu = 2) 
        annotation(Placement(transformation(extent = {{22, 40}, {34, 52}})));
      MathBoolean.Nor or2(nu = 2) 
        annotation(Placement(transformation(extent = {{46, 38}, {58, 50}})));
      Modelica.Blocks.Interaction.Show.BooleanValue showValue4 
        annotation(Placement(transformation(extent = {{90, 34}, {110, 54}})));
      MathBoolean.Not nor1 
        annotation(Placement(transformation(extent = {{68, 40}, {76, 48}})));
      MathBoolean.OnDelay onDelay(delayTime = 1) 
        annotation(Placement(transformation(extent = {{-56, -94}, {-48, -86}})));
      MathBoolean.RisingEdge rising 
        annotation(Placement(transformation(extent = {{-56, -15}, {-48, -7}})));
      MathBoolean.MultiSwitch set1(nu = 2, expr = {false, true}) 
        annotation(Placement(transformation(extent = {{-30, -23}, {10, -3}})));
      MathBoolean.FallingEdge falling 
        annotation(Placement(transformation(extent = {{-56, -32}, {-48, -24}})));
      Sources.BooleanTable booleanTable(table = {2, 4, 6, 6.5, 7, 9, 11}) 
        annotation(Placement(transformation(extent = {{-100, -100}, {-80, -80}})));
      MathBoolean.ChangingEdge changing 
        annotation(Placement(transformation(extent = {{-56, -59}, {-48, -51}})));
      MathInteger.TriggeredAdd triggeredAdd 
        annotation(Placement(transformation(extent = {{14, -56}, {26, -44}})));
      Sources.IntegerConstant integerConstant(k = 2) 
        annotation(Placement(transformation(extent = {{-20, -60}, {0, -40}})));
      Modelica.Blocks.Interaction.Show.IntegerValue showValue1 
        annotation(Placement(transformation(extent = {{40, -60}, {60, -40}})));
      Modelica.Blocks.Interaction.Show.BooleanValue showValue5 
        annotation(Placement(transformation(extent = {{24, -23}, {44, -3}})));
      Modelica.Blocks.Interaction.Show.BooleanValue showValue6 
        annotation(Placement(transformation(extent = {{-32, -100}, {-12, -80}})));
      Logical.RSFlipFlop rSFlipFlop 
        annotation(Placement(transformation(extent = {{70, -90}, {90, -70}})));
      Sources.SampleTrigger sampleTriggerSet(period = 0.5, startTime = 0) 
        annotation(Placement(transformation(extent = {{40, -76}, {54, -62}})));
      Sources.SampleTrigger sampleTriggerReset(period = 0.5, startTime = 0.3) 
        annotation(Placement(transformation(extent = {{40, -98}, {54, -84}})));
    equation
      connect(booleanPulse1.y, and1.u[1]) annotation(Line(
        points = {{-79, 70}, {-68, 70}, {-68, 72.8}, {-58, 72.8}}, color = {255, 0, 255}));
      connect(booleanStep.y, and1.u[2]) annotation(Line(
        points = {{-79, 38}, {-64, 38}, {-64, 70}, {-58, 70}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, and1.u[3]) annotation(Line(
        points = {{-79, 6}, {-62, 6}, {-62, 67.2}, {-58, 67.2}}, color = {255, 0, 255}));
      connect(and1.y, or1.u[1]) annotation(Line(
        points = {{-45.1, 70}, {-36.4, 70}, {-36.4, 70.1}, {-28, 70.1}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, or1.u[2]) annotation(Line(
        points = {{-79, 6}, {-40, 6}, {-40, 65.9}, {-28, 65.9}}, color = {255, 0, 255}));
      connect(or1.y, xor1.u[1]) annotation(Line(
        points = {{-15.1, 68}, {-8, 68}, {-8, 68.1}, {-2, 68.1}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, xor1.u[2]) annotation(Line(
        points = {{-79, 6}, {-12, 6}, {-12, 63.9}, {-2, 63.9}}, color = {255, 0, 255}));
      connect(and1.y, showValue.activePort) annotation(Line(
        points = {{-45.1, 70}, {-42, 70}, {-42, 84}, {-37.5, 84}}, color = {255, 0, 255}));
      connect(or1.y, showValue2.activePort) annotation(Line(
        points = {{-15.1, 68}, {-12, 68}, {-12, 84}, {-3.5, 84}}, color = {255, 0, 255}));
      connect(xor1.y, showValue3.activePort) annotation(Line(
        points = {{10.9, 66}, {22.5, 66}}, color = {255, 0, 255}));
      connect(xor1.y, nand1.u[1]) annotation(Line(
        points = {{10.9, 66}, {16, 66}, {16, 48.1}, {22, 48.1}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, nand1.u[2]) annotation(Line(
        points = {{-79, 6}, {16, 6}, {16, 44}, {22, 44}, {22, 43.9}}, color = {255, 0, 255}));
      connect(nand1.y, or2.u[1]) annotation(Line(
        points = {{34.9, 46}, {46, 46}, {46, 46.1}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, or2.u[2]) annotation(Line(
        points = {{-79, 6}, {42, 6}, {42, 41.9}, {46, 41.9}}, color = {255, 0, 255}));
      connect(or2.y, nor1.u) annotation(Line(
        points = {{58.9, 44}, {66.4, 44}}, color = {255, 0, 255}));
      connect(nor1.y, showValue4.activePort) annotation(Line(
        points = {{76.8, 44}, {88.5, 44}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, rising.u) annotation(Line(
        points = {{-79, 6}, {-62, 6}, {-62, -11}, {-57.6, -11}}, color = {255, 0, 255}));
      connect(rising.y, set1.u[1]) annotation(Line(
        points = {{-47.2, -11}, {-38.6, -11}, {-38.6, -11.5}, {-30, -11.5}}, color = {255, 0, 255}));
      connect(falling.y, set1.u[2]) annotation(Line(
        points = {{-47.2, -28}, {-40, -28}, {-40, -14.5}, {-30, -14.5}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, falling.u) annotation(Line(
        points = {{-79, 6}, {-62, 6}, {-62, -28}, {-57.6, -28}}, color = {255, 0, 255}));
      connect(booleanTable.y, onDelay.u) annotation(Line(
        points = {{-79, -90}, {-57.6, -90}}, color = {255, 0, 255}));
      connect(booleanPulse2.y, changing.u) annotation(Line(
        points = {{-79, 6}, {-62, 6}, {-62, -55}, {-57.6, -55}}, color = {255, 0, 255}));
      connect(integerConstant.y, triggeredAdd.u) annotation(Line(
        points = {{1, -50}, {11.6, -50}}, color = {255, 127, 0}));
      connect(changing.y, triggeredAdd.trigger) annotation(Line(
        points = {{-47.2, -55}, {-30, -55}, {-30, -74}, {16.4, -74}, {16.4, -57.2}}, color = {255, 0, 255}));
      connect(triggeredAdd.y, showValue1.numberPort) annotation(Line(
        points = {{27.2, -50}, {38.5, -50}}, color = {255, 127, 0}));
      connect(set1.y, showValue5.activePort) annotation(Line(
        points = {{11, -13}, {22.5, -13}}, color = {255, 0, 255}));
      connect(onDelay.y, showValue6.activePort) annotation(Line(
        points = {{-47.2, -90}, {-33.5, -90}}, color = {255, 0, 255}));
      connect(sampleTriggerSet.y, rSFlipFlop.S) annotation(Line(
        points = {{54.7, -69}, {60, -69}, {60, -74}, {68, -74}}, color = {255, 0, 255}));
      connect(sampleTriggerReset.y, rSFlipFlop.R) annotation(Line(
        points = {{54.7, -91}, {60, -91}, {60, -86}, {68, -86}}, color = {255, 0, 255}));
      annotation(experiment(StopTime = 10), Documentation(info = "<html><p>
这个示例演示了一个来自<a href=\"modelica://Modelica.Blocks.MathBoolean\" target=\"\">Modelica.Blocks.MathBoolean</a>的布尔块组成的网络。
请注意
</p>
<ul><li>
在模型的右侧， 存在几个MathBoolean.ShowValue模块， 这些模块将各自的布尔值可视化为一个图形动画。</li>
<li>
输入和输出信号的布尔值通过图示动画中的小“圆圈”进行可视化。 这些小圆圈位于连接器的附近，直观地展示了信号的状态。 如果“圆圈”为“白色”，那么信号为<strong>false</strong>。 如果“圆圈”为“绿色”，那么信号为<strong>true</strong>。</li>
</ul></html>"      ));
    end BooleanNetwork1;

    model Interaction1 
      "演示如何使用来自Modelica.Blocks.Interaction.Show的模块"

      extends Modelica.Icons.Example;

      Interaction.Show.IntegerValue integerValue 
        annotation(Placement(transformation(extent = {{-40, 20}, {-20, 40}})));
      Sources.IntegerTable integerTable(table = [0, 0; 1, 2; 2, 4; 3, 6; 4, 4; 6, 2]) 
        annotation(Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
      Sources.TimeTable timeTable(table = [0, 0; 1, 2.1; 2, 4.2; 3, 6.3; 4, 4.2; 6,
        2.1; 6, 2.1]) 
        annotation(Placement(transformation(extent = {{-80, 60}, {-60, 80}})));
      Interaction.Show.RealValue realValue 
        annotation(Placement(transformation(extent = {{-40, 60}, {-20, 80}})));
      Sources.BooleanTable booleanTable(table = {1, 2, 3, 4, 5, 6, 7, 8, 9}) 
        annotation(Placement(transformation(extent = {{-80, -20}, {-60, 0}})));
      Interaction.Show.BooleanValue booleanValue 
        annotation(Placement(transformation(extent = {{-40, -20}, {-20, 0}})));
      Sources.RadioButtonSource start(buttonTimeTable = {1, 3}, reset = {stop.on}) 
        annotation(Placement(transformation(extent = {{24, 64}, {36, 76}})));
      Sources.RadioButtonSource stop(buttonTimeTable = {2, 4}, reset = {start.on}) 
        annotation(Placement(transformation(extent = {{48, 64}, {60, 76}})));
    equation
      connect(integerTable.y, integerValue.numberPort) annotation(Line(
        points = {{-59, 30}, {-41.5, 30}}, color = {255, 127, 0}));
      connect(timeTable.y, realValue.numberPort) annotation(Line(
        points = {{-59, 70}, {-41.5, 70}}, color = {0, 0, 127}));
      connect(booleanTable.y, booleanValue.activePort) annotation(Line(
        points = {{-59, -10}, {-41.5, -10}}, color = {255, 0, 255}));
      annotation(experiment(StopTime = 10), Documentation(info="<html><p>
这个示例演示了一个来自<a href=\"modelica://Modelica.Blocks.Interaction\" target=\"\">Modelica.Blocks.Interaction</a>&nbsp;包的模块组成的网络，展示了如何构建图表动画。
</p>
</html>"));
    end Interaction1;

    model BusUsage "演示信号总线的使用方法"
      extends Modelica.Icons.Example;

    public
      Modelica.Blocks.Sources.IntegerStep integerStep(
        height = 1, 
        offset = 2, 
        startTime = 0.5) annotation(Placement(transformation(extent = {{-60, -40}, {-40, 
        -20}})));
      Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 0.5) annotation(
        Placement(transformation(extent = {{-58, 0}, {-38, 20}})));
      Modelica.Blocks.Sources.Sine sine(f = 1) annotation(Placement(
        transformation(extent = {{-60, 40}, {-40, 60}})));

      Modelica.Blocks.Examples.BusUsage_Utilities.Part part annotation(Placement(
        transformation(extent = {{-60, -80}, {-40, -60}})));
      Modelica.Blocks.Math.Gain gain(k = 1) annotation(Placement(transformation(
        extent = {{-40, 70}, {-60, 90}})));
    protected
      BusUsage_Utilities.Interfaces.ControlBus controlBus annotation(Placement(
        transformation(
        origin = {30, 10}, 
        extent = {{-20, 20}, {20, -20}}, 
        rotation = 90)));
    equation

      connect(sine.y, controlBus.realSignal1) annotation(Line(
        points = {{-39, 50}, {12, 50}, {12, 14}, {30, 14}, {30, 10}}, color = {0, 0, 127}));
      connect(booleanStep.y, controlBus.booleanSignal) annotation(Line(
        points = {{-37, 10}, {30, 10}}, color = {255, 0, 255}));
      connect(integerStep.y, controlBus.integerSignal) annotation(Line(
        points = {{-39, -30}, {0, -30}, {0, 6}, {32, 6}, {32, 10}, {30, 10}}, color = {255, 127, 0}));
      connect(part.subControlBus, controlBus.subControlBus) annotation(Line(
        points = {{-40, -70}, {30, -70}, {30, 10}}, 
        color = {255, 204, 51}, 
        thickness = 0.5));
      connect(gain.u, controlBus.realSignal1) annotation(Line(
        points = {{-38, 80}, {20, 80}, {20, 18}, {32, 18}, {32, 10}, {30, 10}}, color = {0, 0, 127}));
      annotation(Documentation(info = "<html><p>
<strong>信号总线概念</strong>
</p>
<p>
在技术系统(如车辆、机器人或卫星)中，各个组件之间会交换许多信号。 在模拟系统中，这些信号通常由输入/输出块的信号连接来模拟。 不幸的是，信号连接结构可能会变得非常复杂， 尤其是对于分层模型。
</p>
<p>
对于实际的技术系统也是如此。 为了降低复杂性并提高灵活性，许多技术系统使用数据总线来在组件之间交换数据。 出于相同的原因，将“信号总线”概念也应用于Modelica模型通常是更好的选择。 这在下面这个模型(Modelica.Blocks.Examples.BusUsage)中得到了展示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage.png\" alt=\"BusUsage.png\" data-href=\"\" style=\"\">
</p>
<ul><li>
“控制总线”连接器实例是一个用于在不同组件之间交换信号的层次化连接器。 它被定义为“可扩展连接器”，这样就<strong>不</strong>需要在中央定义该连接器， 而是由连接到它的信号自动构建。 这意味着连接器的结构可以根据连接它的信号动态扩展 (可见<a href=\"https://specification.modelica.org/v3.4/Ch9.html#expandable-connectors\" target=\"\">Section 9.1.3 (Expandable Connectors) of the Modelica 3.4 specification</a>)。</li>
<li>
输入/输出信号可以直接连接到“控制总线”。</li>
<li>
一个组件，比如“部件”，可以直接连接到“控制总线”， 前提是它有一个总线连接器， 或者“部件”的连接器是一个嵌入在“控制总线”内的子连接器。</li>
</ul><p>
Modelica.Icons提供了控制总线和子控制总线的图标。 在示例<a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces\" target=\"\">Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces</a>中， 总线被定义。“控制总线”和“子控制总线”都是<strong>可扩展</strong>的连接器， 它们本身不定义任何变量。 例如，<a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus#text\" target=\"\">Interfaces.ControlBus</a> 的定义如下：
</p>
<pre><code >expandable connector ControlBus
extends Modelica.Icons.ControlBus;
annotation ();
end ControlBus;</code></pre><p>
注意，连接器中的“图表动画”非常重要， 因为连接器线的颜色和粗细取自连接器类的图标注释中的第一行元素。 在上面的示例中， 定义了一个颜色为总线颜色的小矩形(因此这个矩形不可见)。 因此，当从此连接器的一个实例连接到另一个连接器实例时， 连接线将具有“控制总线”的颜色， 且线条粗细加倍(由于“线条粗细=0.5”)。
</p>
<p>
一个<strong>可扩展</strong>的连接器是一种内容是由连接到该连接器实例的变量构建的连接器。 例如，如果\"sine.y\"连接到了“控制总线”后， 可能会出现一个弹出菜单。<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage2.png\" alt=\"BusUsage2.png\" data-href=\"\" style=\"\"/>
</p>
<p>
\"Add variable/New name\"字段允许用户为\"controlBus\"上的信号定义名称。 当输入\"realSignal1\"作为\"New name\"时，会建立如下形式的连接：<br><br>
</p>
<pre><code >connect(sine.y, controlBus.realSignal1)</code></pre><p>
一个名为\"realSignal1\"的新信号会被创建， 并且“控制总线”中会包含这个信号。Modelica工具可能提供更多的功能，帮助列出连接的可能信号。 因此，在<a href=\"modelica://Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces\" target=\"\">BusUsage_Utilities.Interfaces</a>中， 展示了“控制总线”和“子控制总线”的预期实现。 例如，“内部控制总线”被定义为：
</p>
<pre><code >expandable connector StandardControlBus
extends BusUsage_Utilities.Interfaces.ControlBus;

import Modelica.Units.SI;
SI.AngularVelocity    realSignal1   \"First Real signal\";
SI.Velocity           realSignal2   \"Second Real signal\";
Integer               integerSignal \"Integer signal\";
Boolean               booleanSignal \"Boolean signal\";
StandardSubControlBus subControlBus \"Combined signal\";
end StandardControlBus;</code></pre><p>
因此，当从\"sine.y\"连接到到“控制总线”时， 菜单看起来是不同的:<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/BusUsage3.png\" alt=\"BusUsage3.png\" data-href=\"\" style=\"\"/>
</p>
<p>
注意，即使来自\"Internal.StandardControlBus\"的信号被列出，这些只是潜在的信号。用户仍然可以添加不同的信号名称。
</p>
</html>"      ), experiment(StopTime = 2));
    end BusUsage;

    model Rectifier6pulseFFT "FFT模块示例"
      extends Modelica.Electrical.Machines.Examples.Transformers.Rectifier6pulse;
      Modelica.Blocks.Math.RealFFT realFFT(
        startTime = 0.04, 
        f_max = 2000, 
        f_res = 5, 
        resultFileName = "rectifier6pulseFFTresult.mat") 
        annotation(Placement(
        transformation(
        extent = {{-10, -10}, {10, 10}}, 
        origin = {-40, -20})));
    equation
      connect(currentSensor.i[1], realFFT.u) 
        annotation(Line(points = {{-70, -11}, {-70, -20}, {-52, -20}}, 
        color = {0, 0, 127}));
      annotation(experiment(StopTime = 0.25, Interval = 0.0001), 
        Documentation(info="<html><p>
本示例基于<a href=\"modelica://Modelica.Electrical.Machines.Examples.Transformers.Rectifier6pulse\" target=\"\">6-pulse rectifier example</a>&nbsp; 计算了<a href=\"modelica://Modelica.Blocks.Math.RealFFT\" target=\"\">FFT block</a>&nbsp;的谐波。
</p>
<p>
在初始瞬态稳定后开始采样 - 等待 <code>2 periods = 2/f = 0.04 s = realFFT.startTime</code>。 选择最大频率<code>f_max = 2000 Hz</code>, &nbsp;频率分辨率<code>f_res = 5 Hz</code> (都在<code>realFFT</code>模块中被定义)和 默认过采样因子<code>f_max_factor = 5</code>, 必须获取<code>n = 2*f_max/f_res*f_max_factor = 4000</code> 的采样间隔， 得到的采样间隔为<code>samplePeriod = 1/(n*f_res) = 0.05 ms</code>. 因此，采样周期为<code>n*samplePeriod = 1/f_res = 0.2 s</code>.
</p>
<p>
结果文件\"rectifier6pulseFFTresult.mat\" 可以用来绘出振幅和频率关系图。注意，对于每个频率，有三行输出：一行振幅为零; 一行是计算振幅，一行是振幅为零。因此，第二列(振幅)可以很容易地与第一列(频率)绘制。不出意外，可以看到结果中的谐波是5<sup>th</sup>, 7<sup>th</sup>, 11<sup>th</sup>, 13<sup>th</sup>, 17<sup>th</sup>, 19<sup>th</sup>, 23<sup>th</sup>, 25<sup>th</sup>。
</p>
</html>"));
    end Rectifier6pulseFFT;

    model Rectifier12pulseFFT "FFT模块示例"
      extends Modelica.Electrical.Machines.Examples.Transformers.Rectifier12pulse;
      Modelica.Blocks.Math.RealFFT realFFT(
        startTime = 0.04, 
        f_max = 2000, 
        f_res = 5, 
        resultFileName = "rectifier12pulseFFTresult.mat") 
        annotation(Placement(
        transformation(
        extent = {{-10, -10}, {10, 10}}, 
        origin = {-40, -20})));
    equation
      connect(currentSensor.i[1], realFFT.u) annotation(Line(points = {{-70, -11}, {-70, -20}, {-52, -20}}, 
        color = {0, 0, 127}));
      annotation(experiment(StopTime = 0.25, Interval = 0.0001), 
        Documentation(info = "<html>
<p>
本示例基于<a href=\"modelica://Modelica.Electrical.Machines.Examples.Transformers.Rectifier12pulse\">12-pulse rectifier example</a>
计算了<a href=\"modelica://Modelica.Blocks.Math.RealFFT\">FFT block</a>的谐波。
<p>
在初始瞬态稳定后开始采样-等待
<code>2&nbsp;periods&nbsp;= 2/f&nbsp;= 0.04&nbsp;s&nbsp;= realFFT.startTime</code>.
选择最大频率<code>f_max&nbsp;=&nbsp;2000&nbsp;Hz</code>,
a&nbsp;频率分辨率<code>f_res&nbsp;=&nbsp;5&nbsp;Hz</code>
(都在<code>realFFT</code>模块中被定义)和
默认过采样因子<code>f_max_factor&nbsp;=&nbsp;5</code>,
必须获取<code>n&nbsp;= 2*f_max/f_res*f_max_factor&nbsp;=&nbsp;4000</code>
的采样间隔，
得到的采样间隔为<code>samplePeriod&nbsp;=&nbsp;1/(n*f_res)&nbsp;=&nbsp;0.05&nbsp;ms</code>.
因此，采样周期为<code>n*samplePeriod&nbsp;=&nbsp;1/f_res&nbsp;=&nbsp;0.2&nbsp;s</code>.
</p>
<p>
结果文件\"rectifier12pulseFFTresult.mat\"
可以用来汇出振幅和频率关系图。
注意，对于每个频率，有三行输出:一行振幅为零;
一行是计算振幅，一行是振幅为零。
因此，第二列(振幅)可以很容易地与第一列(频率)绘制。
不出意外，可以看到结果中的谐波是5<sup>th</sup>, 7<sup>th</sup>, 11<sup>th</sup>的。
</p>
</html>"      ));
    end Rectifier12pulseFFT;

    model TotalHarmonicDistortion "电压总谐波失真的计算"
      extends Modelica.Icons.Example;
      parameter SI.Frequency f1 = 50 "基波频率";
      parameter SI.Voltage V1 = 100 "基波均方根电压";
      parameter SI.Voltage V3 = 20 "三次谐波有效值电压";
      final parameter Real THD1 = V3 / V1 "理论上得到的关于基波的THD";
      final parameter Real THDrms = V3 / sqrt(V1 ^ 2 + V3 ^ 2) "理论上得到的相对于均方根的THD";
      Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(extent = {{-50, -60}, {-30, -40}})));
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage3(V = sqrt(2) * V3, f = 3 * f1, 
        startTime = 0.02) annotation(Placement(transformation(
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 270, 
        origin = {-40, 10})));
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage1(V = sqrt(2) * V1, f = f1, 
        startTime = 0.02) annotation(Placement(transformation(
        extent = {{-10, -10}, {10, 10}}, 
        rotation = 270, 
        origin = {-40, -20})));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(Placement(transformation(
        extent = {{-10, 10}, {10, -10}}, 
        rotation = 270)));
      Modelica.Blocks.Math.TotalHarmonicDistortion thd1(f = f1) annotation(Placement(transformation(extent = {{30, 10}, {50, 30}})));
      Modelica.Blocks.Math.TotalHarmonicDistortion thdRMS(f = f1, useFirstHarmonic = false) annotation(Placement(transformation(extent = {{30, -30}, {50, -10}})));
    equation
      connect(voltageSensor.p, sineVoltage3.p) annotation(Line(points = {{0, 10}, {0, 30}, {-40, 30}, {-40, 20}}, color = {0, 0, 255}));
      connect(sineVoltage3.n, sineVoltage1.p) annotation(Line(points = {{-40, 0}, {-40, -10}}, color = {0, 0, 255}));
      connect(sineVoltage1.n, ground.p) annotation(Line(points = {{-40, -30}, {-40, -40}}, color = {0, 0, 255}));
      connect(ground.p, voltageSensor.n) annotation(Line(points = {{-40, -40}, {-40, -30}, {0, -30}, {0, -10}}, color = {0, 0, 255}));
      connect(thd1.u, voltageSensor.v) annotation(Line(points = {{28, 20}, {20, 20}, {20, 0}, {11, 0}}, color = {0, 0, 127}));
      connect(voltageSensor.v, thdRMS.u) annotation(Line(points = {{11, 0}, {20, 0}, {20, -20}, {28, -20}}, color = {0, 0, 127}));
      annotation(experiment(
        StopTime = 0.1, 
        Interval = 0.0001, 
        Tolerance = 1e-06), Documentation(info="<html><p>
本示例比较了基于 <a href=\"modelica://Modelica.Blocks.Math.TotalHarmonicDistortion\" target=\"\">total harmonic distortion (THD)</a>&nbsp; &nbsp;的两个分别相对于基波和相对于总均方根(RMS)结果。 在这个仿真模型中，一个非正弦电压波形由两个电压波叠加而成：
</p>
<li>
基波，RMS电压<code>V1</code>频率<code>f1</code></li>
<li>
三次谐波，RMS电压<code>V3</code>频率<code>3*f1</code></li>
<p>
该模拟模型将数值确定的THD值与理论计算得到的结果进行了比较：
</p>
<li>
比较数值确定的THD值<code>thd1.y</code>和理论值<code>THD1</code>，都是关于基波的， 同时绘制<code>thd1.valid</code>;</li>
<li>
比较数值确定的THD值<code>thdRMS.y</code>和理论值<code>THDrms</code>，都是关于均方根值的， 同时绘制<code>thdRMS.valid</code>;</li>
</html>"));
    end TotalHarmonicDistortion;

    model Modulation "演示调幅和调频"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sine(
        useConstantAmplitude = true, 
        useConstantFrequency = true, 
        constantFrequency = 100, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-10, 60}, {10, 80}})));
      Modelica.Blocks.Sources.Sine amplitude(
        amplitude = 0.5, 
        f = 2, 
        offset = 1) 
        annotation(Placement(transformation(extent = {{-52, 20}, {-32, 40}})));
      Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sinAM(
        useConstantAmplitude = false, 
        useConstantFrequency = true, 
        constantFrequency = 100, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-10, 20}, {10, 40}})));
      Sources.CosineVariableFrequencyAndAmplitude cosAM(
        useConstantAmplitude = false, 
        useConstantFrequency = true, 
        constantFrequency = 100, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-10, -12}, {10, 8}})));
      Modelica.Blocks.Sources.Sine frequency(
        amplitude = 50, 
        f = 2, 
        offset = 100) 
        annotation(Placement(transformation(extent = {{-50, -50}, {-30, -30}})));
      Modelica.Blocks.Sources.SineVariableFrequencyAndAmplitude sinFM(
        useConstantAmplitude = true, 
        useConstantFrequency = false, 
        constantFrequency = 100, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-10, -50}, {10, -30}})));
      Sources.CosineVariableFrequencyAndAmplitude cosFM(
        useConstantAmplitude = true, 
        useConstantFrequency = false, 
        constantFrequency = 100, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-10, -80}, {10, -60}})));
    equation
      connect(amplitude.y, sinAM.amplitude) annotation(Line(points = {{-31, 30}, {-20, 30}, 
        {-20, 36}, {-12, 36}}, color = {0, 0, 127}));
      connect(frequency.y, sinFM.f) annotation(Line(points = {{-29, -40}, {-20, -40}, {-20, 
        -46}, {-12, -46}}, color = {0, 0, 127}));
      connect(amplitude.y, cosAM.amplitude) annotation(Line(points = {{-31, 30}, {-20, 30}, 
        {-20, 4}, {-12, 4}}, color = {0, 0, 127}));
      connect(frequency.y, cosFM.f) annotation(Line(points = {{-29, -40}, {-20, -40}, {-20, 
        -76}, {-12, -76}}, color = {0, 0, 127}));
      annotation(experiment(StopTime = 1.0, Interval = 0.0001), Documentation(info = "<html>
<p>
本示例演示了调幅(AM)和调频(FM)。
</p>
</html>"  ));
    end Modulation;

    model SinCosEncoder "评估正弦编码器"
      extends Modelica.Icons.Example;
      import Modelica.Constants.pi;
      SI.AngularVelocity w = 2 * pi * ramp.y "2*pi*f";
      Sources.Ramp ramp(
        height = 100, 
        duration = 1, 
        offset = 0, 
        startTime = 0) 
        annotation(Placement(transformation(extent = {{-100, -10}, {-80, 10}})));
      Sources.CosineVariableFrequencyAndAmplitude 
        cosB(
        useConstantAmplitude = true, 
        offset = 1.5, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-60, 40}, {-40, 60}})));
      Sources.CosineVariableFrequencyAndAmplitude 
        cosBminus(
        useConstantAmplitude = true, 
        constantAmplitude = -1, 
        offset = 1.5, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-60, 10}, {-40, 30}})));
      Sources.SineVariableFrequencyAndAmplitude sinA(
        useConstantAmplitude = true, 
        offset = 1.5, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-60, -30}, {-40, -10}})));
      Sources.SineVariableFrequencyAndAmplitude sinAminus(
        useConstantAmplitude = true, 
        constantAmplitude = -1, 
        offset = 1.5, 
        phi(fixed = true)) 
        annotation(Placement(transformation(extent = {{-60, -60}, {-40, -40}})));
      Math.Feedback feedbackCos 
        annotation(Placement(transformation(extent = {{-30, 40}, {-10, 60}})));
      Math.Feedback feedbackSin 
        annotation(Placement(transformation(extent = {{-30, -30}, {-10, -10}})));
      Electrical.Machines.SpacePhasors.Blocks.Rotator rotator 
        annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
      Continuous.Integrator integrator(k = 1e6) 
        annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
      Continuous.Der der1 
        annotation(Placement(transformation(extent = {{80, -10}, {100, 10}})));
      Math.WrapAngle wrapAngle(positiveRange = false) 
        annotation(Placement(transformation(extent = {{80, 20}, {100, 40}})));
      Electrical.Machines.SpacePhasors.Blocks.ToPolar toPolar 
        annotation(Placement(transformation(extent = {{10, 20}, {30, 40}})));
    equation
      connect(ramp.y, sinA.f) annotation(Line(points = {{-79, 0}, {-70, 0}, {-70, -26}, {-62, 
        -26}}, color = {0, 0, 127}));
      connect(ramp.y, sinAminus.f) annotation(Line(points = {{-79, 0}, {-70, 0}, {-70, -56}, 
        {-62, -56}}, color = {0, 0, 127}));
      connect(ramp.y, cosBminus.f) annotation(Line(points = {{-79, 0}, {-70, 0}, {-70, 14}, 
        {-62, 14}}, color = {0, 0, 127}));
      connect(ramp.y, cosB.f) annotation(Line(points = {{-79, 0}, {-70, 0}, {-70, 44}, {-62, 
        44}}, color = {0, 0, 127}));
      connect(cosBminus.y, feedbackCos.u2) 
        annotation(Line(points = {{-39, 20}, {-20, 20}, {-20, 42}}, color = {0, 0, 127}));
      connect(cosB.y, feedbackCos.u1) 
        annotation(Line(points = {{-39, 50}, {-28, 50}}, color = {0, 0, 127}));
      connect(sinA.y, feedbackSin.u1) 
        annotation(Line(points = {{-39, -20}, {-28, -20}}, color = {0, 0, 127}));
      connect(sinAminus.y, feedbackSin.u2) 
        annotation(Line(points = {{-39, -50}, {-20, -50}, {-20, -28}}, color = {0, 0, 127}));
      connect(feedbackCos.y, rotator.u[1]) 
        annotation(Line(points = {{-11, 50}, {0, 50}, {0, 0}, {8, 0}}, color = {0, 0, 127}));
      connect(feedbackSin.y, rotator.u[2]) 
        annotation(Line(points = {{-11, -20}, {0, -20}, {0, 0}, {8, 0}}, color = {0, 0, 127}));
      connect(rotator.y[2], integrator.u) 
        annotation(Line(points = {{31, 0}, {38, 0}}, color = {0, 0, 127}));
      connect(integrator.y, rotator.angle) annotation(Line(points = {{61, 0}, {70, 0}, {70, 
        -20}, {20, -20}, {20, -12}}, color = {0, 0, 127}));
      connect(integrator.y, der1.u) 
        annotation(Line(points = {{61, 0}, {78, 0}}, color = {0, 0, 127}));
      connect(integrator.y, wrapAngle.u) 
        annotation(Line(points = {{61, 0}, {70, 0}, {70, 30}, {78, 30}}, color = {0, 0, 127}));
      connect(feedbackCos.y, toPolar.u[1]) 
        annotation(Line(points = {{-11, 50}, {0, 50}, {0, 30}, {8, 30}}, color = {0, 0, 127}));
      connect(feedbackSin.y, toPolar.u[2]) annotation(Line(points = {{-11, -20}, {0, -20}, 
        {0, 30}, {8, 30}}, color = {0, 0, 127}));
      annotation(experiment(StopTime = 1.0, Interval = 5e-05, Tolerance = 1e-05), Documentation(info = "<html>
<p>
本示例演示了正弦-余弦编码器的鲁棒评估。
</p>
<p>
正弦-余弦编码器提供四种路径：
</p>
<ul>
<li>cos</li>
<li>-sin</li>
<li>sin</li>
<li>-cos</li>
</ul>
<p>
所有四种路径都有相同的振幅和相同的偏移振幅。偏移量用于检测路径的偏移。
为了消除偏移，(-sin)从(sin)中减去(-sin)，(-cos)从(cos)中减去(-cos)，得到一个振幅加倍但没有偏移余弦和正弦信号。
</p>
<p>
将cos和sin解释为相量的实部和虚部，可以计算相量的角度(即将直角坐标转换为极坐标)。
如果信号与一些干扰叠加在一起就不是很清晰。
因此相量以一个由控制器获得的角度旋转。控制器的目标是虚部等于零。
得到的角度是连续的，即对角度求导得到2*&pi;*频率。
如果需要，可以将角度定义在区间[-&pi;, +&pi;]内。
</p>
</html>"  ));
    end SinCosEncoder;

    model CompareSincExpSine "比较正弦信号和指数正弦信号"
      extends Modelica.Icons.Example;
      Sources.Sinc sinc(f = 5) 
        annotation(Placement(transformation(extent = {{-10, 20}, {10, 40}})));
      Sources.ExpSine expSine1(f = 5, damping = 5) 
        annotation(Placement(transformation(extent = {{-10, -20}, {10, 0}})));
      Sources.ExpSine expSine2(
        f = 5, 
        phase = Modelica.Constants.pi / 2, 
        damping = 5) 
        annotation(Placement(transformation(extent = {{-10, -60}, {10, -40}})));
      annotation(experiment(StopTime = 1.0, Interval = 0.0001), Documentation(info = "<html>
<p>
比较正弦信号和指数阻尼正弦信号。
</p>
</html>"  ));
    end CompareSincExpSine;
    model VectorOperation "向量运算示例"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Math.VectorAdd vectorAdd(k2 = -1, n = 2) 
        annotation(Placement(transformation(origin = {78, -2}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.MultiVector multiVector(n = 2) 
        annotation(Placement(transformation(origin = {-16, 32}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.DivVector divVector(n = 2) 
        annotation(Placement(transformation(origin = {-16, -36}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table = {{0.0, 0.1, 2}, {1, 0.2, 3}, {2, 0.5, 4}, {3, 0.6, 5}, {4, 1, 6}}) 
        annotation(Placement(transformation(origin = {-62, 52}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant const(k = 2) 
        annotation(Placement(transformation(origin = {-62, 18}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(table = {{0.0, 0.1, 2}, {1, 0.2, 3}, {2, 0.5, 4}, {3, 0.6, 5}, {4, 1, 6}}) 
        annotation(Placement(transformation(origin = {-62, -16}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant const1(k = 2) 
        annotation(Placement(transformation(origin = {-62, -50}, 
        extent = {{-10, -10}, {10, 10}})));
    equation
      connect(combiTimeTable.y, multiVector.u) 
        annotation(Line(origin = {-39, 45}, 
        points = {{-12, 7}, {11, 7}, {11, -7}}, 
        color = {0, 0, 127}));
      connect(const.y, multiVector.k) 
        annotation(Line(origin = {-41, 22}, 
        points = {{-10, -4}, {13, -4}, {13, 4}}, 
        color = {0, 0, 127}));
      connect(combiTimeTable1.y, divVector.u) 
        annotation(Line(origin = {-39, -23}, 
        points = {{-12, 7}, {11, 7}, {11, -7}}, 
        color = {0, 0, 127}));
      connect(const1.y, divVector.k) 
        annotation(Line(origin = {-41, -46}, 
        points = {{-10, -4}, {13, -4}, {13, 4}}, 
        color = {0, 0, 127}));
      connect(divVector.y, vectorAdd.u2) 
        annotation(Line(origin = {9, -15}, 
        points = {{-14, -21}, {57, -21}, {57, 7}}, 
        color = {0, 0, 127}));
      connect(multiVector.y, vectorAdd.u1) 
        annotation(Line(origin = {9, 25}, 
        points = {{-14, 7}, {57, 7}, {57, -21}}, 
        color = {0, 0, 127}));
      annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
        grid = {2, 2})), Documentation(info = "<html><p>
向量的标量乘法和除法，以及向量加法。
</p>
</html>"    ));
    end VectorOperation;
    model StateSpaceComparison "状态空间结果的比较"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Continuous.StateSpace stateSpace(A = [1.1, 1.2; 1.3, 1.4], B = [2.1, 2.2, 2.3; 2.4, 2.5, 2.6], C = [3.1, 3.2; 3.3, 3.4; 3.5, 3.6; 3.7, 3.8]) 
        annotation(Placement(transformation(origin = {48, 34}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Sine sine(f = 2, amplitude = 2) 
        annotation(Placement(transformation(origin = {-50, 58}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Sine sine1(f = 3, amplitude = 3) 
        annotation(Placement(transformation(origin = {-50, -6}, 
        extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Sine sine2(f = 5, amplitude = 5) 
        annotation(Placement(transformation(origin = {-50, -70}, 
        extent = {{-10, -10}, {10, 10}})));
      Continuous.StateSpaceAlg stateSpaceAlg(A = [1.1, 1.2; 1.3, 1.4], B = [2.1, 2.2, 2.3; 2.4, 2.5, 2.6], C = [3.1, 3.2; 3.3, 3.4; 3.5, 3.6; 3.7, 3.8]) 
        annotation(Placement(transformation(origin = {50, -36}, 
        extent = {{-10, -10}, {10, 10}})));
    equation
      connect(sine.y, stateSpace.u[1]) 
        annotation(Line(origin = {-1, 26}, 
        points = {{-38, 32}, {7, 32}, {7, 8}, {37, 8}}, 
        color = {0, 0, 127}));
      connect(sine1.y, stateSpace.u[2]) 
        annotation(Line(origin = {-1, -6}, 
        points = {{-38, 0}, {7, 0}, {7, 40}, {37, 40}}, 
        color = {0, 0, 127}));
      connect(sine2.y, stateSpace.u[3]) 
        annotation(Line(origin = {-1, -38}, 
        points = {{-38, -32}, {7, -32}, {7, 72}, {37, 72}}, 
        color = {0, 0, 127}));
      connect(sine.y, stateSpaceAlg.u[1]) 
        annotation(Line(origin = {0, 11}, 
        points = {{-39, 47}, {6, 47}, {6, -47}, {38, -47}}, 
        color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
      connect(sine1.y, stateSpaceAlg.u[2]) 
        annotation(Line(origin = {0, -21}, 
        points = {{-39, 15}, {6, 15}, {6, -15}, {38, -15}}, 
        color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
      connect(sine2.y, stateSpaceAlg.u[3]) 
        annotation(Line(origin = {0, -53}, 
        points = {{-39, -17}, {6, -17}, {6, 17}, {38, 17}}, 
        color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
      annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
        grid = {2, 2})), Documentation(info = "<html><p>
用于展示在相同条件下状态空间结果的比较。
</p>
</html>"    ));
    end StateSpaceComparison;
    model SlidingModeControllerExample "演示SlidingModeController例子"
     extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Sine sine(f(displayUnit="rad/s")=0.159154943091895) 
        annotation (Placement(transformation(origin={-65.426,17.0032}, 
    extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Discrete.SlidingModeController slidingModeController 
        annotation (Placement(transformation(origin={48.0527,12.9373}, 
    extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Discrete.StateSpace stateSpace2(samplePeriod=0.02,A={{0.9350261039204004, -0.0012501978218847868}, {0.06434277273100981, 0.987845556507753}},B={{1.2004418789482919e-5}, {-0.01883676908762554}},C={{0.21666742645005246, -0.1876990094244411}},D={{0.18632129502699285}}) 
        annotation (Placement(transformation(origin={-12.5677,-33.637}, 
    extent={{10,-10},{-10,10}})));
      Modelica.Blocks.Discrete.TransferFunction transferFunction3(samplePeriod=0.02,b={0.019801326693245},a={1, -0.980198673306755 }) 
        annotation (Placement(transformation(origin={51.0099,-34.0066}, 
    extent={{10,-10},{-10,10}})));
      annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
    grid={2,2})),experiment(Algorithm=Dassl,InlineIntegrator=false,InlineStepSize=false,Interval=0.002,StartTime=0,StopTime=10,Tolerance=0.0001),Documentation(info="<html><p>
SlidingModeController模型的基本测试示例。
</p>
</html>"    ));
      equation
      connect(slidingModeController.r, sine.y) 
      annotation(Line(origin={11.0924,-14.2046}, 
    points={{24.9472,31.097},{-65.5184,31.097},{-65.5184,31.2078}}, 
    color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
      connect(slidingModeController.u, transferFunction3.u) 
      annotation(Line(origin={67.1584,-10.9934}, 
    points={{-8.0905,23.9307},{8.24752,23.9307},{8.24752,-23.0132},{-4.14851,-23.0132}}, 
    color={0,0,127}));
      connect(stateSpace2.u[1], transferFunction3.y) 
      annotation(Line(origin={20.1584,-34.9934}, 
    points={{-20.7261,1.35644},{19.8515,1.35644},{19.8515,0.986799}}, 
    color={0,0,127}));
      connect(stateSpace2.y[1], slidingModeController.y) 
      annotation(Line(origin={-2.84158,-11.9934}, 
    points={{-20.7261,-21.6436},{-38.9274,-21.6436},{-38.9274,20.8647},{38.8811,20.8647}}, 
    color={0,0,127}));
      end SlidingModeControllerExample;
    model TimeSamplerTest"演示TimeSampler例子"
     extends Modelica.Icons.Example;
      Modelica.Blocks.Continuous.TimeSampler timeSampler(useSupport=true) 
        annotation (Placement(transformation(origin={11.7194,14.9155}, 
    extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Sine sine(f(displayUnit="rad/s")=0.159154943091895) 
        annotation (Placement(transformation(origin={-66.0547,14.9156}, 
    extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.ContinuousClock continuousClock 
        annotation (Placement(transformation(origin={-183.514,-34.4324}, 
    extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Logical.Less less 
        annotation (Placement(transformation(origin={-37.4594,-34.4324}, 
    extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Logical.Greater greater 
        annotation (Placement(transformation(origin={-38.5946,-76.054}, 
    extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.Constant const(k=3) 
        annotation (Placement(transformation(origin = {-185.027, -63.5676}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant const1(k=2) 
        annotation (Placement(transformation(origin={-186.162,-110.486}, 
    extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Logical.And and1 
        annotation (Placement(transformation(origin = {9.08108, -46.5405}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Continuous.TimeSampler timeSampler1(useSupport=false) 
        annotation (Placement(transformation(origin={12.1081,62.8108}, 
    extent={{-10,-10},{10,10}})));
      annotation(Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
    grid={2,2})),Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(243, 243, 243);\">演示TimeSampler例子</span>
</p>
</html>"    ));
      equation
      connect(sine.y, timeSampler.u) 
      annotation(Line(origin={-28,14}, 
    points={{-27.0547,0.915598},{27.7194,0.915598},{27.7194,0.9155}}, 
    color={0,0,127}));
      connect(greater.u1, continuousClock.y) 
      annotation(Line(origin={-79,-59}, 
    points={{28.4054,-17.054},{-0.0541892,-17.054},{-0.0541892,24.5676},{-93.514,24.5676}}, 
    color={0,0,127}));
      connect(less.u1, continuousClock.y) 
      annotation(Line(origin={-79,-42}, 
    points={{29.5406,7.5676},{-93.514,7.5676},{-93.514,7.5676}}, 
    color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));
      connect(const1.y, greater.u2) 
      annotation(Line(origin={-114,-97}, 
    points={{-61.1618,-13.4864},{12.7027,-13.4864},{12.7027,12.946},{63.4054,12.946}}, 
    color={0,0,127}));
      connect(const.y, less.u2) 
      annotation(Line(origin={-114,-57}, 
    points={{-60.027,-6.5676},{44.4865,-6.5676},{44.4865,14.5676},{64.5406,14.5676}}, 
    color={0,0,127}));
      connect(and1.u1, less.y) 
      annotation(Line(origin={-15,-40}, 
      points={{12.08108,-6.5405},{4.40541,-6.5405},{4.40541,5.5676},{-11.4594,5.5676}}, 
      color={255,0,255}));
      connect(and1.u2, greater.y) 
      annotation(Line(origin={-15,-65}, 
    points={{12.08108,10.4595},{4.13513,10.4595},{4.13513,-11.054},{-12.5946,-11.054}}, 
    color={255,0,255}));
      connect(and1.y, timeSampler.sampleSupport) 
      annotation(Line(origin={27,-22}, 
    points={{-6.91892,-24.5405},{16.1351,-24.5405},{16.1351,4.03439},{-15.2428,4.03439},{-15.2428,24.8452}}, 
    color={255,0,255}));
      connect(timeSampler1.u, sine.y) 
      annotation(Line(origin={-27,39}, 
    points={{27.1081,23.8108},{-1.18984,23.8108},{-1.18984,-24.0844},{-28.0547,-24.0844}}, 
    color={0,0,127}),__MWORKS(BlockSystem(NamedSignal)));

    end TimeSamplerTest;
    model LookupTable1D "由模型参数定义的一维线性插值表的示例"
      extends Modelica.Icons.Example;
      parameter Real x[:] = linspace(0, 2, 6) * Modelica.Constants.pi;
      parameter Real y[size(x, 1)] = Modelica.Math.sin(x);
      Modelica.Blocks.Sources.Ramp ramp(
        duration = 2, 
        offset = -1, 
        height = 8.3) 
        annotation(Placement(transformation(origin = {-42.439, 0.536585}, 
        extent = {{-10, -10}, {10, 10}})));
      Tables.NTables.LookupTable1D liner(tableDataOnFile = false, breakPoints1 = x, tableData = y, extrapMethod = Tables.Types.ExtrapolationMethod.Linear, breakPointsOnFile = false) 
        annotation(Placement(transformation(origin = {39.561, 0.536585}, 
        extent = {{-10, -10}, {10, 10}})));
    equation
      connect(ramp.y, liner.u) 
        annotation(Line(origin = {-12.939, 10.5366}, 
        points = {{-18.5, -10}, {40.4884, -10}, {40.4884, -10.0406}}, 
        color = {0, 0, 127}));
      annotation(experiment(Algorithm = Dassl, Interval = 0.01, StartTime = 0, StopTime = 1, Tolerance = 0.0001), __MWorks(ResultViewerManager(resultViewers = {
        ResultViewer(name = "Figure1_compare", executeTrigger = executeTrigger.SimulationFinished, commands = {
        CreatePlot(id = 1, position = [881, 66, 600, 400], y = ["hold.y", "nearest.y", "linear.y", "akima.y", "fritsch_butland.y", "steffen.y"], x_display_unit = "s", y_axis = [1, 1, 1, 1, 1, 1], legend_layout = 7, legend_frame = True, fix_time_range_value = 6.95184e-310)})})), 
        Documentation(info = "<html><p>
在这个例子中，演示了一个一维插值表查找，其中表格值和断点数据都由模型参数定义。</p>
</html>"    ));
    end LookupTable1D;
    model LookupTable1D_File "在文件中定义的一维线性插值表的示例"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Ramp ramp(
        duration = 2, 
        offset = -1, 
        height = 8.3) 
        annotation(Placement(transformation(origin = {-50.2439, -0.243902}, 
        extent = {{-10, -10}, {10, 10}})));
      Tables.NTables.LookupTable1D liner(tableDataOnFile = true, extrapMethod = Tables.Types.ExtrapolationMethod.Linear, filePath = loadResource("modelica://Modelica/Resources/Data/Examples/Test.csv"), tableData_col = 2, bp_cols = {1}, breakPointsOnFile = true) 
        annotation(Placement(transformation(origin = {30.9756, -1.02439}, 
        extent = {{-10, -10}, {10, 10}})));
    equation
      connect(ramp.y, liner.u) 
        annotation(Line(origin = {-14.8902, 9.36585}, 
        points = {{-24.3537, -9.60976}, {33.8543, -9.60976}, {33.8543, -10.4308}}, 
        color = {0, 0, 127}));
      annotation(experiment(Algorithm = Dassl, Interval = 0.01, StartTime = 0, StopTime = 1, Tolerance = 0.0001), __MWorks(ResultViewerManager(resultViewers = {
        ResultViewer(name = "Figure1_compare", executeTrigger = executeTrigger.SimulationFinished, commands = {
        CreatePlot(id = 1, position = [881, 66, 600, 400], y = ["hold.y", "nearest.y", "linear.y", "akima.y", "fritsch_butland.y", "steffen.y"], x_display_unit = "s", y_axis = [1, 1, 1, 1, 1, 1], legend_layout = 7, legend_frame = True, fix_time_range_value = 6.95184e-310)})})), 
        Documentation(info = "<html><p>
在这个例子中，演示了一个一维插值表查找，其中表格值和断点数据都在文件中定义。</p>
</html>"    ));
    end LookupTable1D_File;
    model LookupTable2D "由模型参数定义的二维线性插值表的示例"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Ramp ramp(
        duration = 1, 
        offset = 0, 
        height = 2, 
        startTime = 1) 
        annotation(Placement(transformation(origin = {-78.3537, 30.1463}, 
        extent = {{-15.5, -15.5}, {15.5, 15.5}})));
      Modelica.Blocks.Sources.Ramp ramp1(
        duration = 1, 
        offset = 10, 
        height = 0, 
        startTime = 100) 
        annotation(Placement(transformation(origin = {-78.3537, -29.8537}, 
        extent = {{-15.5, -15.5}, {15.5, 15.5}})));
      Tables.NTables.LookupTable2D tY2DTable(breakPoints1 = linspace(0, 2, 3), tableDataOnFile = false, breakPoints2 = linspace(10, 11, 2), tableData = {{11, 14}, {12, 15}, {13, 16}}, extrapMethod = Tables.Types.ExtrapolationMethod.Linear) 
        annotation(Placement(transformation(origin = {43.295, 1.53096}, 
        extent = {{-23.5, -24.5}, {23.5, 24.5}})));
    equation
      connect(ramp.y, tY2DTable.u1) 
        annotation(Line(origin = {-23.8537, 25.1463}, 
        points = {{-37.45, 5}, {-12.4179, 5}, {-12.4179, -13.7856}, {38.70007, -13.7856}}, 
        color = {0, 0, 127}));
      connect(ramp1.y, tY2DTable.u2) 
        annotation(Line(origin = {-23.8537, -14.8537}, 
        points = {{-37.45, -15}, {-13.1795, -15}, {-13.1795, 6.609365}, {38.5769, 6.609365}}, 
        color = {0, 0, 127}));
      annotation(Diagram(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
        grid = {1.0, 1.0})), 
        Icon(coordinateSystem(extent = {{-100.0, -100.0}, {100.0, 100.0}}, 
        preserveAspectRatio = false, 
        grid = {2.0, 2.0})), Documentation(info = "<html><p>
在这个例子中，演示了一个二维插值表查找，其中表格值和断点数据都由模型参数定义。</p>
</html>"    ));
    end LookupTable2D;
    model LookupTable3D "由模型参数定义的三维线性插值表的示例"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Ramp ramp(
        duration = 1, 
        offset = 0, 
        height = 2, 
        startTime = 1) 
        annotation(Placement(transformation(origin = {-40.0, 44.0}, 
        extent = {{-10.0, -10.0}, {10.0, 10.0}})));
      Modelica.Blocks.Sources.Ramp ramp1(
        duration = 1, 
        offset = 10, 
        height = 0, 
        startTime = 100) 
        annotation(Placement(transformation(origin = {-40.0, 0.0}, 
        extent = {{-10.0, -10.0}, {10.0, 10.0}})));
      Modelica.Blocks.Sources.Ramp ramp2(
        duration = 1, 
        offset = 6, 
        height = 0, 
        startTime = 100) 
        annotation(Placement(transformation(origin = {-40.0, -42.0}, 
        extent = {{-10.0, -10.0}, {10.0, 10.0}})));
      Tables.NTables.LookupTable3D tY3DTable(breakPoints1 = linspace(0, 2, 3), breakPoints2 = linspace(10, 11, 2), breakPoints3 = linspace(5, 6, 2), tableDataOnFile = false, tableData = {{{11, 14}, {12, 15}, {13, 16}}, {{17, 20}, {18, 21}, {19, 22}}}, extrapMethod = Tables.Types.ExtrapolationMethod.Linear) 
        annotation(Placement(transformation(origin = {40.0, 0.0}, 
        extent = {{-10.0, -10.0}, {10.0, 10.0}})));
    equation
      connect(tY3DTable.u2, ramp1.y) 
        annotation(Line(origin = {-1, 0}, 
        points = {{28.9675, -0.0314147}, {-28, -0.0314147}, {-28, 0}}, 
        color = {0, 0, 127}));
      connect(ramp.y, tY3DTable.u1) 
        annotation(Line(origin = {-1, 25}, 
        points = {{-28, 19}, {-7.61538, 19}, {-7.61538, -19.0086}, {28.957, -19.0086}}, 
        color = {0, 0, 127}));
      connect(ramp2.y, tY3DTable.u3) 
        annotation(Line(origin = {-1, -24}, 
        points = {{-28, -18}, {-6.75385, -18}, {-6.75385, 18.03086}, {28.9675, 18.03086}}, 
        color = {0, 0, 127}));
      annotation(Documentation(info = "<html><p>
在这个例子中，演示了一个三维插值表查找，其中表格值和断点数据都由模型参数定义。</p>
</html>"    ));
    end LookupTable3D;

    package Noise "用于演示Blocks.Noise包使用的示例库"
      extends Modelica.Icons.ExamplesPackage;

      model UniformNoise 
        "演示UniformNoise模块最基础的用法"
        extends Modelica.Icons.Example;
        output Real uniformNoise2_y = uniformNoise2.y;

        inner Modelica.Blocks.Noise.GlobalSeed globalSeed 
          annotation(Placement(transformation(extent = {{-20, 40}, {0, 60}})));
        Modelica.Blocks.Noise.UniformNoise uniformNoise1(
          samplePeriod = 0.02, 
          y_min = -1, 
          y_max = 3) annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
        Modelica.Blocks.Noise.UniformNoise uniformNoise2(
          samplePeriod = 0.02, y_min = -1, y_max = 3, 
          useAutomaticLocalSeed = false, 
          fixedLocalSeed = 10) 
          annotation(Placement(transformation(extent = {{-60, -20}, {-40, 0}})));
        annotation(experiment(StopTime = 2), Documentation(info = "<html><p>
本示例演示了 <a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\" target=\"\">Noise.UniformNoise</a> 模块的基础用法:
</p>
<ul><li>
<strong>globalSeed</strong>是<a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\" target=\"\">Noise.GlobalSeed</a> 中带有默认选项的模块 (只从子模块Noise拖动)。</li>
<li>
<strong>uniformNoise1</strong>是 <a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\" target=\"\">Noise.UniformNoise</a>的一个示例，该示例的samplePeriod = 0.02s并具有y_min = -1，y_max = 3的均匀分布。</li>
<li>
<strong>uniformNoise2</strong>与uniformNoise1相同，不同之处在于useAutomaticLocalSeed = false，fixedLocalSeed = 10。</li>
</ul><p>
每0.02秒计算一个时间事件，在这段时间内出现一个从-1到3的均匀随机数。 这个随机数保持不变，直到下一个采样瞬间。 模拟结果如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/UniformNoise.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
</html>"                , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                ));
      end UniformNoise;

      model AutomaticSeed 
        "展示了使用 startTime 和自动本地种子生成的均匀噪声"
        extends Modelica.Icons.Example;
        parameter SI.Time startTime = 0.5 "干扰开始时间";
        parameter Real y_off = -1.0 "干扰开始之前的模块输出";

        output Real manualSeed1_y = manualSeed1.y;
        output Real manualSeed2_y = manualSeed2.y;
        output Real manualSeed3_y = manualSeed3.y;

        inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed = false, enableNoise = true) 
          annotation(Placement(transformation(extent = {{60, 60}, {80, 80}})));

        Modelica.Blocks.Noise.UniformNoise automaticSeed1(
          samplePeriod = 0.01, 
          startTime = startTime, 
          y_off = y_off, 
          y_min = -1, y_max = 3) 
          annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
        Modelica.Blocks.Noise.UniformNoise automaticSeed2(
          samplePeriod = 0.01, 
          startTime = startTime, 
          y_off = y_off, y_min = -1, y_max = 3) 
          annotation(Placement(transformation(extent = {{-60, -20}, {-40, 0}})));
        Modelica.Blocks.Noise.UniformNoise automaticSeed3(
          samplePeriod = 0.01, 
          startTime = startTime, 
          y_off = y_off, y_min = -1, y_max = 3) 
          annotation(Placement(transformation(extent = {{-60, -60}, {-40, -40}})));
        Modelica.Blocks.Noise.UniformNoise manualSeed1(
          samplePeriod = 0.01, 
          startTime = startTime, 
          y_off = y_off, 
          useAutomaticLocalSeed = false, 
          fixedLocalSeed = 1, y_min = -1, y_max = 3, 
          enableNoise = true) 
          annotation(Placement(transformation(extent = {{0, 20}, {20, 40}})));
        Modelica.Blocks.Noise.UniformNoise manualSeed2(
          samplePeriod = 0.01, 
          startTime = startTime, 
          y_off = y_off, 
          useAutomaticLocalSeed = false, 
          fixedLocalSeed = 2, y_min = -1, y_max = 3) 
          annotation(Placement(transformation(extent = {{0, -20}, {20, 0}})));
        Modelica.Blocks.Noise.UniformNoise manualSeed3(
          samplePeriod = 0.01, 
          startTime = startTime, 
          y_off = y_off, 
          useAutomaticLocalSeed = false, y_min = -1, y_max = 3, 
          fixedLocalSeed = 3) 
          annotation(Placement(transformation(extent = {{0, -60}, {20, -40}})));
        annotation(experiment(StopTime = 2), Documentation(info="<html><p>
本示例演示了<a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\" target=\"\">UniformNoise</a>&nbsp;模块的<span style=\"color: rgb(51, 51, 51);\">手动和自动种子选择</span>， 同时在startTime=0.5s开始干扰，在此之前输出值y=-1。干扰开始后， 所有干扰模块都会产生频段从y_min=-1到y_max=3,samplePeriod=0.01s的均匀的干扰
</p>
<p>
automaticSeed1、automaticSeed2和automaticSeed3模块使用默认值 选项自动初始化伪随机数生成器。因此，每个模块产生的干扰不同，见下图：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/AutomaticSeed1.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
manualSeed1、manualSeed2和manualSeed3模块使用本地种子的手动选择(useAutomaticLocalSeed=false) 它们使用的fixedLocalSeed分别为1、2和3。同样产生的干扰不同，见下图：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/AutomaticSeed2.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
尝试在manualSeed2模块中设置fixedLocalSeed=1。因此， manualSeed1和manualSeed2将产生完全相同的干扰。
</p>
</html>"    ,revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
      end AutomaticSeed;

      model Distributions 
        "演示不同类型分布的干扰"
        extends Modelica.Icons.Example;
        parameter SI.Period samplePeriod = 0.02 
          "所有模块的采样周期";
        parameter Real y_min = -1 "最小随机值";
        parameter Real y_max = 3 "最大随机值";
        inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed = 
          false) 
          annotation(Placement(transformation(extent = {{40, 60}, {60, 80}})));
        output Real uniformNoise_y = uniformNoise.y;
        output Real truncatedNormalNoise_y = truncatedNormalNoise.y;

        Integer n = if time < 0.5 then 12 else 2;

        Modelica.Blocks.Noise.UniformNoise uniformNoise(
          useAutomaticLocalSeed = false, 
          fixedLocalSeed = 1, 
          samplePeriod = samplePeriod, 
          y_min = y_min, 
          y_max = y_max) 
          annotation(Placement(transformation(extent = {{-60, 70}, {-40, 90}})));
        Modelica.Blocks.Noise.TruncatedNormalNoise truncatedNormalNoise(
          useAutomaticLocalSeed = false, 
          fixedLocalSeed = 1, 
          samplePeriod = samplePeriod, 
          y_min = y_min, 
          y_max = y_max) 
          annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
        annotation(experiment(StopTime = 2), Documentation(info = "<html><p>
本示例演示了可供选择的不同干扰分布方法用于干扰模块。 两个干扰模块都设置为samplePeriod=0.02s，y_min=-1，y_max=3， fixedLocalSeed相同。这意味着为这些模块提供相同的随机数。 但是，根据所选择的分布类型，随机数会进行不同转换 (均匀和截断的正态分布)，因此模块具有不同的输出值。 仿真结果如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/Distributions.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
如图所示，均匀噪声在-1和3之间均匀分布，而截断正态分布的值则更多地集中在均值1附近。
</p>
</html>"          , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"          ));
      end Distributions;

      model UniformNoiseProperties 
        "演示干扰特性均匀分布的计算"
        extends Modelica.Icons.Example;
        parameter Real y_min = 0 "带宽的最小值";
        parameter Real y_max = 6 "带宽的最大值";
        parameter Real pMean = (y_min + y_max) / 2 
          "均匀分布的理论平均值";
        parameter Real var = (y_max - y_min) ^ 2 / 12 
          "均匀分布的理论方差";
        parameter Real std = sqrt(var) 
          "均匀分布的理论标准差";
        inner Modelica.Blocks.Noise.GlobalSeed globalSeed 
          annotation(Placement(transformation(extent = {{80, 60}, {100, 80}})));
        output Real meanError_y = meanError.y;
        output Real sigmaError_y = sigmaError.y;

        Modelica.Blocks.Noise.UniformNoise noise(
          samplePeriod = 0.001, 
          y_min = y_min, 
          y_max = y_max, 
          useAutomaticLocalSeed = false) 
          annotation(Placement(transformation(extent = {{-80, 60}, {-60, 80}})));
        Modelica.Blocks.Math.ContinuousMean mean 
          annotation(Placement(transformation(extent = {{-40, 60}, {-20, 80}})));
        Modelica.Blocks.Math.Variance variance 
          annotation(Placement(transformation(extent = {{-40, 0}, {-20, 20}})));
        Modelica.Blocks.Math.MultiProduct theoreticalVariance(nu = 2) 
          annotation(Placement(transformation(extent = {{28, -36}, {40, -24}})));
        Modelica.Blocks.Math.Feedback meanError 
          annotation(Placement(transformation(extent = {{40, 60}, {60, 80}})));
        Modelica.Blocks.Sources.Constant theoreticalMean(k = pMean) 
          annotation(Placement(transformation(extent = {{-10, 40}, {10, 60}})));
        Modelica.Blocks.Math.Feedback varianceError 
          annotation(Placement(transformation(extent = {{40, 0}, {60, 20}})));
        Modelica.Blocks.Sources.Constant theoreticalSigma(k = std) 
          annotation(Placement(transformation(extent = {{-10, -40}, {10, -20}})));
        Modelica.Blocks.Math.StandardDeviation standardDeviation 
          annotation(Placement(transformation(extent = {{-40, -80}, {-20, -60}})));
        Modelica.Blocks.Math.Feedback sigmaError 
          annotation(Placement(transformation(extent = {{40, -60}, {60, -80}})));
      equation
        connect(noise.y, mean.u) annotation(Line(
          points = {{-59, 70}, {-42, 70}}, color = {0, 0, 127}));
        connect(noise.y, variance.u) annotation(Line(
          points = {{-59, 70}, {-52, 70}, {-52, 10}, {-42, 10}}, color = {0, 0, 127}));
        connect(mean.y, meanError.u1) annotation(Line(
          points = {{-19, 70}, {42, 70}}, color = {0, 0, 127}));
        connect(theoreticalMean.y, meanError.u2) annotation(Line(
          points = {{11, 50}, {50, 50}, {50, 62}}, color = {0, 0, 127}));
        connect(theoreticalSigma.y, theoreticalVariance.u[1]) annotation(Line(
          points = {{11, -30}, {24, -30}, {24, -27.9}, {28, -27.9}}, color = {0, 0, 127}));
        connect(theoreticalSigma.y, theoreticalVariance.u[2]) annotation(Line(
          points = {{11, -30}, {24, -30}, {24, -32.1}, {28, -32.1}}, color = {0, 0, 127}));
        connect(variance.y, varianceError.u1) annotation(Line(
          points = {{-19, 10}, {42, 10}}, color = {0, 0, 127}));
        connect(theoreticalVariance.y, varianceError.u2) annotation(Line(
          points = {{41.02, -30}, {50, -30}, {50, 2}}, color = {0, 0, 127}));
        connect(noise.y, standardDeviation.u) annotation(Line(
          points = {{-59, 70}, {-52, 70}, {-52, -70}, {-42, -70}}, color = {0, 0, 127}));
        connect(standardDeviation.y, sigmaError.u1) annotation(Line(
          points = {{-19, -70}, {42, -70}}, color = {0, 0, 127}));
        connect(theoreticalSigma.y, sigmaError.u2) annotation(Line(
          points = {{11, -30}, {18, -30}, {18, -42}, {50, -42}, {50, -62}}, color = {0, 0, 127}));
        annotation(experiment(StopTime = 20, Interval = 0.4e-2, Tolerance = 1e-009), 
          Documentation(info = "<html><p>
本示例演示了 <a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\" target=\"\">Blocks.Noise.UniformNoise</a> 模块使用<strong>均匀</strong>随机数分布的统计特性干扰模块定义了一个从0到6的代数， 产生干扰的均值和方差是用 <a href=\"modelica://Modelica.Blocks.Math\" target=\"\">Blocks.Math</a> 模块计算的。仿真结果如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/UniformNoiseProperties1.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
在0到6范围内均匀噪声的平均值是3， 方差也是3。 上述仿真结果显示了良好的一致性(经过较短的初始阶段)。 这表明随机数生成器和均匀分布的映射具有良好的统计性能。
</p>
</html>"                , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                ));
      end UniformNoiseProperties;

      model NormalNoiseProperties 
        "演示正态分布干扰的属性计算"
        extends Modelica.Icons.Example;
        parameter Real mu = 3 "正态分布的平均值";
        parameter Real sigma = 1 "正态分布的标准差";
        parameter Real pMean = mu "正态分布的理论平均值";
        parameter Real var = sigma ^ 2 
          "均匀分布的理论方差";
        parameter Real std = sigma 
          "正态分布的理论标准差";
        inner Modelica.Blocks.Noise.GlobalSeed globalSeed 
          annotation(Placement(transformation(extent = {{80, 60}, {100, 80}})));
        output Real meanError_y = meanError.y;
        output Real sigmaError_y = sigmaError.y;

        Modelica.Blocks.Noise.NormalNoise noise(
          samplePeriod = 0.001, 
          mu = mu, 
          sigma = sigma, 
          useAutomaticLocalSeed = false) 
          annotation(Placement(transformation(extent = {{-80, 60}, {-60, 80}})));
        Modelica.Blocks.Math.ContinuousMean mean 
          annotation(Placement(transformation(extent = {{-40, 60}, {-20, 80}})));
        Modelica.Blocks.Math.Variance variance 
          annotation(Placement(transformation(extent = {{-40, 0}, {-20, 20}})));
        Modelica.Blocks.Math.MultiProduct theoreticalVariance(nu = 2) 
          annotation(Placement(transformation(extent = {{28, -36}, {40, -24}})));
        Modelica.Blocks.Math.Feedback meanError 
          annotation(Placement(transformation(extent = {{40, 60}, {60, 80}})));
        Modelica.Blocks.Sources.Constant theoreticalMean(k = pMean) 
          annotation(Placement(transformation(extent = {{-10, 40}, {10, 60}})));
        Modelica.Blocks.Math.Feedback varianceError 
          annotation(Placement(transformation(extent = {{40, 0}, {60, 20}})));
        Modelica.Blocks.Sources.Constant theoreticalSigma(k = std) 
          annotation(Placement(transformation(extent = {{-10, -40}, {10, -20}})));
        Modelica.Blocks.Math.StandardDeviation standardDeviation 
          annotation(Placement(transformation(extent = {{-40, -80}, {-20, -60}})));
        Modelica.Blocks.Math.Feedback sigmaError 
          annotation(Placement(transformation(extent = {{40, -60}, {60, -80}})));
      equation
        connect(noise.y, mean.u) annotation(Line(
          points = {{-59, 70}, {-42, 70}}, color = {0, 0, 127}));
        connect(noise.y, variance.u) annotation(Line(
          points = {{-59, 70}, {-52, 70}, {-52, 10}, {-42, 10}}, color = {0, 0, 127}));
        connect(mean.y, meanError.u1) annotation(Line(
          points = {{-19, 70}, {42, 70}}, color = {0, 0, 127}));
        connect(theoreticalMean.y, meanError.u2) annotation(Line(
          points = {{11, 50}, {50, 50}, {50, 62}}, color = {0, 0, 127}));
        connect(theoreticalSigma.y, theoreticalVariance.u[1]) annotation(Line(
          points = {{11, -30}, {24, -30}, {24, -27.9}, {28, -27.9}}, color = {0, 0, 127}));
        connect(theoreticalSigma.y, theoreticalVariance.u[2]) annotation(Line(
          points = {{11, -30}, {24, -30}, {24, -32.1}, {28, -32.1}}, color = {0, 0, 127}));
        connect(variance.y, varianceError.u1) annotation(Line(
          points = {{-19, 10}, {42, 10}}, color = {0, 0, 127}));
        connect(theoreticalVariance.y, varianceError.u2) annotation(Line(
          points = {{41.02, -30}, {50, -30}, {50, 2}}, color = {0, 0, 127}));
        connect(noise.y, standardDeviation.u) annotation(Line(
          points = {{-59, 70}, {-52, 70}, {-52, -70}, {-42, -70}}, color = {0, 0, 127}));
        connect(standardDeviation.y, sigmaError.u1) annotation(Line(
          points = {{-19, -70}, {42, -70}}, color = {0, 0, 127}));
        connect(theoreticalSigma.y, sigmaError.u2) annotation(Line(
          points = {{11, -30}, {18, -30}, {18, -42}, {50, -42}, {50, -62}}, color = {0, 0, 127}));
        annotation(experiment(StopTime = 20, Interval = 0.4e-2, Tolerance = 1e-009), 
          Documentation(info = "<html><p>
这个例子展示了如何使用<strong>正态</strong>分布的随机数生成器来模拟 <a href=\"modelica://Modelica.Blocks.Noise.NormalNoise\" target=\"\">Blocks.Noise.NormalNoise</a> 模块的统计特性。具体来说，这个例子使用了平均值为3，标准差为1的正态分布。 通过随机生成的干扰，我们可以计算出取自 <a href=\"modelica://Modelica.Blocks.Math\" target=\"\">Blocks.Math</a> 数据模块的平均值和方差。模拟结果如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/NormalNoiseProperties1.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
正态干扰的平均值为mu(这里mu=3)，方差为sigma^2。 上述模拟结果与理论值吻合(短暂的初始阶段除外)， 这表明随机数生成器和将其映射到正态分布的过程具有良好的统计特性。
</p>
</html>"                , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                ));
      end NormalNoiseProperties;

      model Densities 
        "演示如何计算分布密度(=概率密度函数)"
        extends Modelica.Icons.Example;
        output Real uniformDensity_y = uniformDensity.y;
        output Real normalDensity_y = normalDensity.y;
        output Real weibullDensity_y = weibullDensity.y;

        Utilities.UniformDensity 
          uniformDensity(u_min = -4, u_max = 4) 
          annotation(Placement(transformation(extent = {{10, 20}, {30, 40}})));
        Modelica.Blocks.Sources.ContinuousClock clock 
          annotation(Placement(transformation(extent = {{-80, 10}, {-60, 30}})));
        Modelica.Blocks.Sources.Constant const(k = -10) 
          annotation(Placement(transformation(extent = {{-80, -30}, {-60, -10}})));
        Modelica.Blocks.Math.Add add 
          annotation(Placement(transformation(extent = {{-46, -10}, {-26, 10}})));
        Utilities.NormalDensity 
          normalDensity(mu = 0, sigma = 2) 
          annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
        Utilities.WeibullDensity 
          weibullDensity(lambda = 3, k = 1.5) 
          annotation(Placement(transformation(extent = {{10, -40}, {30, -20}})));
      equation
        connect(clock.y, add.u1) annotation(Line(
          points = {{-59, 20}, {-53.5, 20}, {-53.5, 6}, {-48, 6}}, color = {0, 0, 127}));
        connect(const.y, add.u2) annotation(Line(
          points = {{-59, -20}, {-54, -20}, {-54, -6}, {-48, -6}}, color = {0, 0, 127}));
        connect(add.y, uniformDensity.u) annotation(Line(
          points = {{-25, 0}, {-14, 0}, {-14, 30}, {8, 30}}, color = {0, 0, 127}));
        connect(add.y, normalDensity.u) annotation(Line(
          points = {{-25, 0}, {8, 0}}, color = {0, 0, 127}));
        connect(add.y, weibullDensity.u) annotation(Line(
          points = {{-25, 0}, {-14, 0}, {-14, -30}, {8, -30}}, color = {0, 0, 127}));
        annotation(experiment(StopTime = 20, Interval = 2e-2), 
          Documentation(info = "<html><p>
本示例演示了如何计算各种分布的概率密度函数(PDF)。 以下图表显示了对于一致分布、 正态分布和韦伯分布的模拟结果。 模块是沿着其中一个输入所给的密度函数进行输出：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/Densities.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
</html>"                , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                ));
      end Densities;

      model ImpureGenerator 
        "演示使用混入随机数生成器的用法"
        extends Modelica.Icons.Example;
        output Real impureRandom_y = impureRandom.y;

        inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed = 
          false) annotation(Placement(transformation(extent = {{20, 40}, {40, 60}})));

        Utilities.ImpureRandom impureRandom(samplePeriod = 0.01) 
          annotation(Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
        annotation(experiment(StopTime = 2), Documentation(info = "<html><p>
本示例演示了如何使用 <a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\" target=\"\">impureRandom(..)</a> 函数在事件时刻生成随机值。通常情况下， 只有在实现自身的、专门的模块时才需要使用这种方法。 模拟结果如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/ImpureGenerator.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
</html>"                , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                ));
      end ImpureGenerator;

      model ActuatorWithNoise 
        "演示如何在执行器中模拟测量干扰方法"
        extends Modelica.Icons.Example;
        Utilities.Parts.MotorWithCurrentControl motor 
          annotation(Placement(transformation(extent = {{-86, -10}, {-66, 10}})));
        Utilities.Parts.Controller controller 
          annotation(Placement(transformation(extent = {{-60, 40}, {-80, 60}})));
        Modelica.Blocks.Sources.Step speed(startTime = 0.5, height = 50) 
          annotation(Placement(transformation(extent = {{20, 40}, {0, 60}})));
        Modelica.Mechanics.Rotational.Components.Gearbox gearbox(
          lossTable = [0, 0.85, 0.8, 0.1, 0.1], 
          c = 1e6, 
          d = 1e4, 
          ratio = 10, 
          w_rel(fixed = true), 
          b = 0.0017453292519943, 
          phi_rel(fixed = true)) 
          annotation(Placement(transformation(extent = {{-60, -10}, {-40, 10}})));
        Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio = 
          300) annotation(Placement(transformation(extent = {{-32, -10}, {-12, 10}})));
        Modelica.Mechanics.Translational.Components.Mass mass(m = 100) 
          annotation(Placement(transformation(extent = {{50, -10}, {70, 10}})));
        Modelica.Mechanics.Translational.Sources.ConstantForce constantForce(
          f_constant = 10000) annotation(Placement(transformation(
          extent = {{10, -10}, {-10, 10}}, 
          origin = {86, 0})));
        Modelica.Blocks.Nonlinear.SlewRateLimiter slewRateLimiter(Rising = 50) 
          annotation(Placement(transformation(extent = {{-20, 40}, {-40, 60}})));
        Modelica.Mechanics.Translational.Components.Mass rodMass(m = 3) 
          annotation(Placement(transformation(extent = {{-4, -10}, {16, 10}})));
        Modelica.Mechanics.Translational.Components.SpringDamper elastoGap(c = 1e8, d = 
          1e5, 
          v_rel(fixed = true), 
          s_rel(fixed = true)) 
          annotation(Placement(transformation(extent = {{22, -10}, {42, 10}})));
        inner .Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise = true) annotation(Placement(transformation(extent = {{60, 60}, {80, 80}})));
      equation
        connect(controller.y1, motor.iq_rms1) annotation(Line(
          points = {{-81, 50}, {-94, 50}, {-94, 6}, {-88, 6}}, color = {0, 0, 127}));
        connect(motor.phi, controller.positionMeasured) annotation(Line(
          points = {{-71, 8}, {-66, 8}, {-66, 20}, {-50, 20}, {-50, 44}, {-58, 44}}, color = {0, 0, 127}));
        connect(motor.flange, gearbox.flange_a) annotation(Line(
          points = {{-66, 0}, {-60, 0}}));
        connect(gearbox.flange_b, idealGearR2T.flangeR) annotation(Line(
          points = {{-40, 0}, {-32, 0}}));
        connect(constantForce.flange, mass.flange_b) annotation(Line(
          points = {{76, 0}, {70, 0}}, color = {0, 127, 0}));
        connect(speed.y, slewRateLimiter.u) annotation(Line(
          points = {{-1, 50}, {-18, 50}}, color = {0, 0, 127}));
        connect(slewRateLimiter.y, controller.positionReference) annotation(Line(
          points = {{-41, 50}, {-50, 50}, {-50, 56}, {-58, 56}}, color = {0, 0, 127}));
        connect(rodMass.flange_a, idealGearR2T.flangeT) annotation(Line(
          points = {{-4, 0}, {-12, 0}}, color = {0, 127, 0}));
        connect(rodMass.flange_b, elastoGap.flange_a) annotation(Line(
          points = {{16, 0}, {22, 0}}, color = {0, 127, 0}));
        connect(elastoGap.flange_b, mass.flange_a) annotation(Line(
          points = {{42, 0}, {50, 0}}, color = {0, 127, 0}));
        annotation(
          experiment(StopTime = 8, Interval = 0.01, Tolerance = 1e-005), 
          Documentation(info="<html><p>
本示例模拟了一个具有干扰传感器(传感器位于电动机组件中)的执行器。
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/ActuatorNoiseDiagram.png\" alt=\"\" data-href=\"\" style=\"\"/>
</p>
<p>
驱动系统包括一个同步电动机以及一个电流控制器(指电动机)和一个齿轮箱。 齿轮箱通过线性转换模型推动一根杆，杆上柔性连接着另一个负载， 代表实际执行器(指质量)。执行器负载一个定常力。
</p>
<p>
整个驱动系统是通过一个限速速度脉冲命令来驱动的， 该命令通过一个控制器模型进行。在电动机中， 测量杆角度并通过向电动机角度添加增加干扰来模拟该测量信号。
</p>
<p>
下图分别显示了有干扰和没有干扰时，执行器位置和电动机输出扭矩。 由于干扰较弱，其对执行器位置的影响较小， 对电动机扭矩的影响比较明显。
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/ActuatorNoise.png\" alt=\"\" data-href=\"\" style=\"\">
</p>
<p>
注意，可以通过在全局种子组件中设置参数enableNoise=false 可在所有组件中关闭干扰。
</p>
</html>"    ,revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
      end ActuatorWithNoise;

      model DrydenContinuousTurbulence 
        "演示如何使用BandLimitedWhiteNoise块对飞机的风速湍流进行建模(一个简单的低空(<1000英尺)垂直Dryden湍流风速模型)"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;

        parameter SI.Velocity V = 140 * 0.5144 
          "飞机航速(通常为140千节/小时)";
        parameter SI.Velocity sigma = 0.1 * 30 * 0.5144 
          "湍流强度(通常为在20英尺处风的0.1倍，通常为30千节/小时)";
        parameter SI.Length L = 600 * 0.3048 
          "比例长度(等于飞行高度)";

        Modelica.Blocks.Continuous.TransferFunction Hw(b = sigma * sqrt(L / pi / V) * {sqrt(3) * 
          L / V, 1}, a = {L ^ 2 / V ^ 2, 2 * L / V, 1}, 
          initType = Modelica.Blocks.Types.Init.InitialState) 
          "根据MIL-F-8785C的规定，飞机垂直湍流速度可以用以下公式表示" 
          annotation(Placement(transformation(extent = {{-10, 0}, {10, 20}})));
        Modelica.Blocks.Noise.BandLimitedWhiteNoise whiteNoise(samplePeriod = 
          0.005) 
          annotation(Placement(transformation(extent = {{-60, 0}, {-40, 20}})));
        constant SI.Velocity unitVelocity = 1 annotation(HideResult = true);
        Modelica.Blocks.Math.Gain compareToSpeed(k = unitVelocity / V) 
          annotation(Placement(transformation(extent = {{40, 0}, {60, 20}})));
        inner Modelica.Blocks.Noise.GlobalSeed globalSeed 
          annotation(Placement(transformation(extent = {{40, 60}, {60, 80}})));
      equation
        connect(whiteNoise.y, Hw.u) annotation(Line(
          points = {{-39, 10}, {-12, 10}}, color = {0, 0, 127}));
        connect(Hw.y, compareToSpeed.u) annotation(Line(
          points = {{11, 10}, {38, 10}}, color = {0, 0, 127}));
        annotation(experiment(StopTime = 100), 
          Documentation(info = "<html>
<p>
本示例演示了如何使用Modelica模型库中的
<a href=\"modelica://Modelica.Blocks.Noise.BandLimitedWhiteNoise\">BandLimitedWhiteNoise</a>
模块来导入Dryden连续湍流模型。
Dryden连续湍流模型通常用于描述低层次的随机变化的空间湍流风
(可参考<a href=\"https://en.wikipedia.org/wiki/Continuous_gusts\">wikipedia</a>)。
</p>

<h4>Dryden连续湍流模型是用来描述低海拔地带的垂直湍流速度的数学模型</h4>

<p>
Dryden连续湍流模型是通过垂直湍流速度的功率谱密度来定义的：
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/equation-erVWhiWU.png\" alt=\"Phi_w(Omega)=sigma^2*L_w/pi*((1+3*(L_w*Omega)^2)/(1+(L_w*Omega)^2)^2)\"/>
</div>

<p>
谱密度函数使用以下参数来参数化：
</p>

<ul>
<li> Lw是湍流尺度。<br>在低海拔处，它等于飞行高度。</li>
<li> sigma是湍流强度。<br>在低海拔处，它等于20英尺高度处的风速的1/10，对于中度湍流，风速为30节。</li>
<li> Omega是空间频率。<br>湍流模型在空间上被定义，飞机在定义的风场中飞行时会经历湍流。</li>
<li> Omega=s/V将被用于将空间定义转换为时间定义，从而可以转变为状态空间系统。</li>
<li> V是飞机的航速。<br>在低海拔时，大约为150节。</li>
</ul>

<p>
使用频谱分解技术分解并结合飞机的固定航速V，可以设计出一个具体的过滤器，用于垂直湍流情况。
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/equation-W0zl2Gay.png\" alt=\"H_w(s) = sigma*sqrt(L_w/(pi*V)) * ((1 + sqrt(3)*L_w/V*s) / (1+L_w/V*s)^2)\"/>,
</div>

<p>
其中V*(H_w(i Omega/V)*H_w(-i Omega/V)=Phi_w(Omega).
</p>

<h4>过滤器输入</h4>

<p>
输入过滤器的是白噪声，具有正态分布，零均值，以及功率谱密度为1。 
这意味着，对于一个采样时间为1s的情况，它可以通过参数化平均值=0和方差=1 来描述。 
但是，为了考虑采样引入的噪声功率变化，需要将噪声乘以samplePeriod的开方。这在<a href=\"modelica://Modelica.Blocks.Noise.BandLimitedWhiteNoise\">BandLimitedWhiteNoise</a> 模块中会自动完成。
</p>

<h4>示例输出</h4>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/DrydenContinuousTurbulence.png\"/>
</div>

<h4>参考文献</h4>

<ol>
<li>Dryden Wind Turbulence model in US military standard
<a href=\"http://everyspec.com/MIL-SPECS/MIL-SPECS-MIL-F/MIL-F-8785C_5295/\">MIL-F-8785</a>.</li>
</ol>
</html>"                      ));
      end DrydenContinuousTurbulence;

      package Utilities "示例中的工具库"
        extends Modelica.Icons.UtilitiesPackage;

        block UniformDensity "连续均匀分布的密度函数公式"
          import distribution = Modelica.Math.Distributions.Uniform.density;
          extends Modelica.Blocks.Icons.Block;

          parameter Real u_min "u的最小值";
          parameter Real u_max "u的最大值";

          Modelica.Blocks.Interfaces.RealInput u "实数输入信号" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
          Modelica.Blocks.Interfaces.RealOutput y 
            "根据均匀概率密度函数定义输入信号的密度，" 
            annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
        equation
          y = distribution(u, u_min, u_max);

          annotation(Icon(graphics = {
            Polygon(
            points = {{0, 94}, {-8, 72}, {8, 72}, {0, 94}}, 
            lineColor = {192, 192, 192}, 
            fillColor = {192, 192, 192}, 
            fillPattern = FillPattern.Solid), 
            Line(points = {{0, 76}, {0, -72}}, color = {192, 192, 192}), 
            Line(points = {{-86, -82}, {72, -82}}, 
            color = {192, 192, 192}), 
            Polygon(
            points = {{92, -82}, {70, -74}, {70, -90}, {92, -82}}, 
            lineColor = {192, 192, 192}, 
            fillColor = {192, 192, 192}, 
            fillPattern = FillPattern.Solid), 
            Line(points = {{-70, -75.953}, {-66.5, -75.8975}, {-63, -75.7852}, {-59.5, 
            -75.5674}, {-56, -75.1631}, {-52.5, -74.4442}, {-49, -73.2213}, {
            -45.5, -71.2318}, {-42, -68.1385}, {-38.5, -63.5468}, {-35, -57.0467}, 
            {-31.5, -48.2849}, {-28, -37.0617}, {-24.5, -23.4388}, {-21, -7.8318}, 
            {-17.5, 8.9428}, {-14, 25.695}, {-10.5, 40.9771}, {-7, 53.2797}, {
            -3.5, 61.2739}, {0, 64.047}, {3.5, 61.2739}, {7, 53.2797}, {10.5, 
            40.9771}, {14, 25.695}, {17.5, 8.9428}, {21, -7.8318}, {24.5, 
            -23.4388}, {28, -37.0617}, {31.5, -48.2849}, {35, -57.0467}, {38.5, 
            -63.5468}, {42, -68.1385}, {45.5, -71.2318}, {49, -73.2213}, {52.5, 
            -74.4442}, {56, -75.1631}, {59.5, -75.5674}, {63, -75.7852}, {66.5, 
            -75.8975}, {70, -75.953}}, 
            smooth = Smooth.Bezier)}), Documentation(info = "<html><p>
本模块给定输入信号u的均匀分布的概率密度y (有关此密度函数的详细信息，请参见 <a href=\"modelica://Modelica.Math.Distributions.Uniform.density\" target=\"\">Math.Distributions.Uniform.density</a>)
</p>
<p>
本模块在 <a href=\"modelica://Modelica.Blocks.Examples.Noise.Densities\" target=\"\">Examples.Noise.Densities</a> 中演示。
</p>
</html>"            , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"            ));
        end UniformDensity;

        block NormalDensity "正态分布的密度函数公式"
          import distribution = Modelica.Math.Distributions.Normal.density;
          extends Modelica.Blocks.Icons.Block;

          parameter Real mu "正态分布的期望值(平均值)";
          parameter Real sigma "正态分布的标准差";

          Modelica.Blocks.Interfaces.RealInput u "实数输入信号" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
          Modelica.Blocks.Interfaces.RealOutput y 
            "根据正态概率密度函数定义输入信号的密度" 
            annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
        equation
          y = distribution(u, mu, sigma);

          annotation(Icon(graphics = {
            Polygon(
            points = {{0, 94}, {-8, 72}, {8, 72}, {0, 94}}, 
            lineColor = {192, 192, 192}, 
            fillColor = {192, 192, 192}, 
            fillPattern = FillPattern.Solid), 
            Line(points = {{0, 76}, {0, -72}}, color = {192, 192, 192}), 
            Line(points = {{-86, -82}, {72, -82}}, 
            color = {192, 192, 192}), 
            Polygon(
            points = {{92, -82}, {70, -74}, {70, -90}, {92, -82}}, 
            lineColor = {192, 192, 192}, 
            fillColor = {192, 192, 192}, 
            fillPattern = FillPattern.Solid), 
            Line(points = {{-70, -75.953}, {-66.5, -75.8975}, {-63, -75.7852}, {-59.5, 
            -75.5674}, {-56, -75.1631}, {-52.5, -74.4442}, {-49, -73.2213}, {
            -45.5, -71.2318}, {-42, -68.1385}, {-38.5, -63.5468}, {-35, -57.0467}, 
            {-31.5, -48.2849}, {-28, -37.0617}, {-24.5, -23.4388}, {-21, -7.8318}, 
            {-17.5, 8.9428}, {-14, 25.695}, {-10.5, 40.9771}, {-7, 53.2797}, {
            -3.5, 61.2739}, {0, 64.047}, {3.5, 61.2739}, {7, 53.2797}, {10.5, 
            40.9771}, {14, 25.695}, {17.5, 8.9428}, {21, -7.8318}, {24.5, 
            -23.4388}, {28, -37.0617}, {31.5, -48.2849}, {35, -57.0467}, {38.5, 
            -63.5468}, {42, -68.1385}, {45.5, -71.2318}, {49, -73.2213}, {52.5, 
            -74.4442}, {56, -75.1631}, {59.5, -75.5674}, {63, -75.7852}, {66.5, 
            -75.8975}, {70, -75.953}}, 
            smooth = Smooth.Bezier)}), Documentation(info = "<html><p>
本模块给定输入信号u的正态分布的概率密度y (有关此密度函数的详细信息，请参见 <a href=\"modelica://Modelica.Math.Distributions.Normal.density\" target=\"\">Math.Distributions.Normal.density</a>).
</p>
<p>
本模块在 <a href=\"modelica://Modelica.Blocks.Examples.Noise.Densities\" target=\"\">Examples.Noise.Densities</a>中演示。
</p>
</html>"                  , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                  ));
        end NormalDensity;

        block WeibullDensity "韦伯分布的密度函数公式"
          import distribution = Modelica.Math.Distributions.Weibull.density;
          extends Modelica.Blocks.Icons.Block;

          parameter Real lambda(min = 0) 
            "韦伯分布的尺度参数";
          parameter Real k(min = 0) "韦伯分布的形状参数";

          Modelica.Blocks.Interfaces.RealInput u "实数输入信号" annotation(Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
          Modelica.Blocks.Interfaces.RealOutput y 
            "根据韦伯概率密度函数定义输入信号的密度" 
            annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
        equation
          y = distribution(u, lambda, k);

          annotation(Icon(graphics = {
            Polygon(
            points = {{0, 94}, {-8, 72}, {8, 72}, {0, 94}}, 
            lineColor = {192, 192, 192}, 
            fillColor = {192, 192, 192}, 
            fillPattern = FillPattern.Solid), 
            Line(points = {{0, 76}, {0, -72}}, color = {192, 192, 192}), 
            Line(points = {{-86, -82}, {72, -82}}, 
            color = {192, 192, 192}), 
            Polygon(
            points = {{92, -82}, {70, -74}, {70, -90}, {92, -82}}, 
            lineColor = {192, 192, 192}, 
            fillColor = {192, 192, 192}, 
            fillPattern = FillPattern.Solid), 
            Line(points = {{-70, -75.953}, {-66.5, -75.8975}, {-63, -75.7852}, {-59.5, 
            -75.5674}, {-56, -75.1631}, {-52.5, -74.4442}, {-49, -73.2213}, {
            -45.5, -71.2318}, {-42, -68.1385}, {-38.5, -63.5468}, {-35, -57.0467}, 
            {-31.5, -48.2849}, {-28, -37.0617}, {-24.5, -23.4388}, {-21, -7.8318}, 
            {-17.5, 8.9428}, {-14, 25.695}, {-10.5, 40.9771}, {-7, 53.2797}, {
            -3.5, 61.2739}, {0, 64.047}, {3.5, 61.2739}, {7, 53.2797}, {10.5, 
            40.9771}, {14, 25.695}, {17.5, 8.9428}, {21, -7.8318}, {24.5, 
            -23.4388}, {28, -37.0617}, {31.5, -48.2849}, {35, -57.0467}, {38.5, 
            -63.5468}, {42, -68.1385}, {45.5, -71.2318}, {49, -73.2213}, {52.5, 
            -74.4442}, {56, -75.1631}, {59.5, -75.5674}, {63, -75.7852}, {66.5, 
            -75.8975}, {70, -75.953}}, 
            smooth = Smooth.Bezier)}), Documentation(info = "<html><p>
本模块给定输入信号u的韦伯分布的概率密度y (有关此密度函数的详细信息，请参见 <a href=\"modelica://Modelica.Math.Distributions.Weibull.density\" target=\"\">Math.Distributions.Weibull.density</a>)。
</p>
<p>
This block is demonstrated in the example <a href=\"modelica://Modelica.Blocks.Examples.Noise.Densities\" target=\"\">Examples.Noise.Densities</a> .
</p>
</html>"                  , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                  ));
        end WeibullDensity;

        block ImpureRandom 
          "使用非纯随机数生成器生成随机数组"
          extends Modelica.Blocks.Interfaces.SO;

          parameter SI.Period samplePeriod 
            "随机数生成的采样周期";

        protected
          outer Modelica.Blocks.Noise.GlobalSeed globalSeed;

        equation
          when {initial(), sample(samplePeriod, samplePeriod)} then
            y = Modelica.Math.Random.Utilities.impureRandom(globalSeed.id_impure);
          end when;
          annotation(Documentation(info = "<html><p>
本模块演示了如何使用非纯随机数生成器生成一个代数组。并在示例 <a href=\"modelica://Modelica.Blocks.Examples.Noise.ImpureGenerator\" target=\"\">Examples.Noise.ImpureGenerator</a>中演示。
</p>
</html>"                  , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                  ));
        end ImpureRandom;

        package Parts "示例中ActuatorWithNoise(带噪声的执行器)的部件"
          extends Modelica.Icons.Package;

          model MotorWithCurrentControl 
            "具有电流控制器和噪声测量的同步电机"
            extends Modelica.Electrical.Machines.Icons.TransientMachine;
            constant Integer m = 3 "相数";
            parameter SI.Voltage VNominal = 100 
              "每相名义 RMS 电压";
            parameter SI.Frequency fNominal = 50 "标称频率";
            parameter SI.Frequency f = 50 "实际频率";
            parameter SI.Time tRamp = 1 "频率增长";
            parameter SI.Torque TLoad = 181.4 "额定负载扭矩";
            parameter SI.Time tStep = 1.2 "负载转矩阶跃时间";
            parameter SI.Inertia JLoad = 0.29 "载荷转动惯量";

            Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet 
              smpm(
              p = smpmData.p, 
              fsNominal = smpmData.fsNominal, 
              Rs = smpmData.Rs, 
              TsRef = smpmData.TsRef, 
              Lszero = smpmData.Lszero, 
              Lssigma = smpmData.Lssigma, 
              Jr = smpmData.Jr, Js = smpmData.Js, 
              frictionParameters = smpmData.frictionParameters, 
              wMechanical(fixed = true), 
              statorCoreParameters = smpmData.statorCoreParameters, 
              strayLoadParameters = smpmData.strayLoadParameters, 
              VsOpenCircuit = smpmData.VsOpenCircuit, 
              Lmd = smpmData.Lmd, 
              Lmq = smpmData.Lmq, 
              useDamperCage = smpmData.useDamperCage, 
              Lrsigmad = smpmData.Lrsigmad, 
              Lrsigmaq = smpmData.Lrsigmaq, 
              Rrd = smpmData.Rrd, 
              Rrq = smpmData.Rrq, 
              TrRef = smpmData.TrRef, 
              permanentMagnetLossParameters = smpmData.permanentMagnetLossParameters, 
              phiMechanical(fixed = true), 
              TsOperational = 293.15, 
              alpha20s = smpmData.alpha20s, 
              TrOperational = 293.15, 
              alpha20r = smpmData.alpha20r) 
              annotation(Placement(transformation(extent = {{-20, -50}, {0, -30}})));
            Modelica.Electrical.Polyphase.Sources.SignalCurrent signalCurrent(final m = m) 
              annotation(Placement(transformation(
              origin = {-10, 50}, 
              extent = {{-10, 10}, {10, -10}}, 
              rotation = 270)));
            Modelica.Electrical.Polyphase.Basic.Star star(final m = m) 
              annotation(Placement(transformation(extent = {{-10, 80}, {-30, 100}})));
            Modelica.Electrical.Analog.Basic.Ground ground 
              annotation(Placement(transformation(
              origin = {-50, 90}, 
              extent = {{-10, -10}, {10, 10}}, 
              rotation = 270)));
            Modelica.Electrical.Machines.Utilities.DQToThreePhase dqToThreePhase(
              p = smpm.p) 
              annotation(Placement(transformation(extent = {{-50, 40}, {-30, 60}})));
            Modelica.Electrical.Polyphase.Basic.Star starM(final m = m) annotation(Placement(transformation(
              extent = {{-10, -10}, {10, 10}}, 
              rotation = 180, 
              origin = {-60, -10})));
            Modelica.Electrical.Analog.Basic.Ground groundM 
              annotation(Placement(transformation(
              origin = {-80, -28}, 
              extent = {{-10, -10}, {10, 10}}, 
              rotation = 270)));
            Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
              terminalConnection = "Y") annotation(Placement(transformation(extent = {{-20, -30}, 
              {0, -10}})));
            Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p = smpm.p) 
              annotation(Placement(transformation(
              origin = {20, -40}, 
              extent = {{-10, 10}, {10, -10}}, 
              rotation = 270)));
            Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation(
              Placement(transformation(
              extent = {{-10, -10}, {10, 10}}, 
              rotation = 90, 
              origin = {10, 0})));
            Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation(
              Placement(transformation(
              extent = {{10, 10}, {-10, -10}}, 
              rotation = 180, 
              origin = {50, -40})));
            Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(
              Placement(transformation(
              extent = {{-10, -10}, {10, 10}}, 
              rotation = 90, 
              origin = {30, 0})));
            Modelica.Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor 
              annotation(Placement(transformation(
              extent = {{-10, 10}, {10, -10}}, 
              rotation = 180, 
              origin = {-30, -10})));
            Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor 
              annotation(Placement(transformation(
              origin = {-10, 0}, 
              extent = {{-10, -10}, {10, 10}}, 
              rotation = 270)));
            Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J = 0.29) 
              annotation(Placement(transformation(extent = {{70, -50}, {90, -30}})));
            parameter
              Modelica.Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData 
              smpmData(useDamperCage = false) "电机数据" 
              annotation(Placement(transformation(extent = {{-20, -80}, {0, -60}})));
            Modelica.Blocks.Sources.Constant id(k = 0) 
              annotation(Placement(transformation(extent = {{-90, 60}, {-70, 80}})));
            Modelica.Blocks.Interfaces.RealInput iq_rms1 annotation(Placement(
              transformation(extent = {{-140, 40}, {-100, 80}}), iconTransformation(extent = {{-140, 40}, 
              {-100, 80}})));
            Modelica.Mechanics.Rotational.Interfaces.Flange_b flange 
              "右轴法兰" 
              annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
            Modelica.Blocks.Interfaces.RealOutput phi(unit = "rad") 
              "法兰绝对角度作为输出信号" annotation(Placement(
              transformation(
              extent = {{-10, -10}, {10, 10}}, 
              origin = {110, 80}), iconTransformation(extent = {{40, 70}, {60, 90}})));
            output Real phi_motor(unit = "rad", displayUnit = "deg") = angleSensor.phi 
              "旋转位置";
            output Real w(unit = "rad/s") = speedSensor.w "转速";
            Modelica.Blocks.Math.Add addNoise 
              annotation(Placement(transformation(extent = {{60, 70}, {80, 90}})));
            .Modelica.Blocks.Noise.UniformNoise uniformNoise(
              samplePeriod = 1 / 200, 
              y_min = -0.01, 
              y_max = 0.01) annotation(Placement(transformation(extent = {{26, 76}, {46, 96}})));
          equation
            connect(star.pin_n, ground.p) annotation(Line(points = {{-30, 90}, {-40, 90}}, color = {0, 0, 255}));
            connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation(Line(
              points = {{26, -30}, {26, -20}, {-16, -20}, {-16, -30}}, color = {0, 0, 255}));
            connect(rotorDisplacementAngle.plug_p, smpm.plug_sp) annotation(Line(
              points = {{14, -30}, {6, -30}, {-4, -30}}, color = {0, 0, 255}));
            connect(terminalBox.plug_sn, smpm.plug_sn) annotation(Line(
              points = {{-16, -26}, {-16, -30}}, color = {0, 0, 255}));
            connect(terminalBox.plug_sp, smpm.plug_sp) annotation(Line(
              points = {{-4, -26}, {-4, -30}}, color = {0, 0, 255}));
            connect(smpm.flange, rotorDisplacementAngle.flange) annotation(Line(
              points = {{0, -40}, {6, -40}, {10, -40}}));
            connect(signalCurrent.plug_p, star.plug_p) annotation(Line(
              points = {{-10, 60}, {-10, 90}}, color = {0, 0, 255}));
            connect(angleSensor.flange, rotorDisplacementAngle.flange) annotation(Line(
              points = {{10, -10}, {10, -40}}));
            connect(angleSensor.phi, dqToThreePhase.phi) annotation(Line(points = {{10, 11}, 
              {10, 30}, {-40, 30}, {-40, 38}}, color = {0, 0, 127}));
            connect(groundM.p, terminalBox.starpoint) annotation(Line(
              points = {{-70, -28}, {-20, -28}, {-20, -24}}, color = {0, 0, 255}));
            connect(smpm.flange, torqueSensor.flange_a) annotation(Line(
              points = {{0, -40}, {40, -40}}));
            connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply) annotation(
              Line(
              points = {{-20, -10}, {-10, -10}, {-10, -24}}, color = {0, 0, 255}));
            connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation(Line(
              points = {{-50, -10}, {-40, -10}}, color = {0, 0, 255}));
            connect(starM.pin_n, groundM.p) annotation(Line(
              points = {{-70, -10}, {-70, -28}}, color = {0, 0, 255}));
            connect(dqToThreePhase.y, signalCurrent.i) annotation(Line(points = {{
              -29, 50}, {-22, 50}, {-22, 50}}, color = {0, 0, 127}));
            connect(speedSensor.flange, smpm.flange) annotation(Line(
              points = {{30, -10}, {30, -40}, {0, -40}}));
            connect(torqueSensor.flange_b, inertiaLoad.flange_a) annotation(Line(
              points = {{60, -40}, {60, -40}, {70, -40}}));
            connect(signalCurrent.plug_n, currentQuasiRMSSensor.plug_p) annotation(
              Line(
              points = {{-10, 40}, {-10, 10}}, color = {0, 0, 255}));
            connect(currentQuasiRMSSensor.plug_n, voltageQuasiRMSSensor.plug_p) 
              annotation(Line(
              points = {{-10, -10}, {-20, -10}}, color = {0, 0, 255}));
            connect(inertiaLoad.flange_b, flange) annotation(Line(
              points = {{90, -40}, {90, -40}, {90, 0}, {100, 0}}));
            connect(angleSensor.phi, addNoise.u2) annotation(Line(
              points = {{10, 11}, {10, 30}, {50, 30}, {50, 74}, {58, 74}}, color = {0, 0, 127}));
            connect(addNoise.y, phi) annotation(Line(
              points = {{81, 80}, {110, 80}}, color = {0, 0, 127}));
            connect(uniformNoise.y, addNoise.u1) annotation(Line(
              points = {{47, 86}, {58, 86}}, color = {0, 0, 127}));
            connect(id.y, dqToThreePhase.d) annotation(Line(points = {{-69, 70}, {-60, 
              70}, {-60, 56}, {-52, 56}}, color = {0, 0, 127}));
            connect(iq_rms1, dqToThreePhase.q) annotation(Line(points = {{-120, 60}, 
              {-100, 60}, {-100, 44}, {-52, 44}}, color = {0, 0, 127}));
            annotation(
              Documentation(info = "<html>
<p>
具有从静止状态加速惯性方向的二次速度相关负载的定磁同步机、
电流控制器和噪声测量的同步机(±0.01 rad)，
d-和q-轴电流的有效值(在旋转坐标系下)被转换为三相电流，并输入到机器中。
结果表明，扭矩受q-轴电流的影响，
而电动势受d-轴电流的影响。
</p>

<p>
使用了
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>
模型的默认同步机参数。
</p>

<p>
该电机用于
<a href=\"modelica://Modelica.Blocks.Examples.Noise.ActuatorWithNoise\">Examples.Noise.ActuatorWithNoise</a>
示例中。
</p>
</html>"                      , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                      ), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
              100}}), graphics = {Rectangle(
              extent = {{40, 50}, {-100, 100}}, 
              fillColor = {255, 170, 85}, 
              fillPattern = FillPattern.Solid, 
              pattern = LinePattern.None), Text(
              extent = {{-150, 150}, {150, 110}}, 
              textString = "%name", 
              textColor = {0, 0, 255})}));
          end MotorWithCurrentControl;

          model Controller "适用于执行器的简便位置控制器"
            extends Modelica.Blocks.Icons.Block;

            Modelica.Blocks.Continuous.PI speed_PI(k = 10, T = 5e-2, 
              initType = Modelica.Blocks.Types.Init.InitialOutput) 
              annotation(Placement(transformation(extent = {{38, -10}, {58, 10}})));
            Modelica.Blocks.Math.Feedback speedFeedback 
              annotation(Placement(transformation(extent = {{10, -10}, {30, 10}})));
            Modelica.Blocks.Continuous.Derivative positionToSpeed(initType = Modelica.Blocks.Types.Init.InitialOutput, 
              T = 0.01) 
              annotation(Placement(transformation(extent = {{-60, -70}, {-40, -50}})));
            Modelica.Blocks.Interfaces.RealInput positionMeasured 
              "电机的位置信号" 
              annotation(Placement(transformation(extent = {{-140, -80}, {-100, -40}})));
            Modelica.Blocks.Interfaces.RealInput positionReference 
              "参考位置" 
              annotation(Placement(transformation(extent = {{-140, 40}, {-100, 80}})));
            Modelica.Blocks.Interfaces.RealOutput y1 
              "实际输出信号连接器" 
              annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
            Modelica.Blocks.Continuous.PI position_PI(T = 5e-1, k = 3, 
              initType = Modelica.Blocks.Types.Init.InitialState) 
              annotation(Placement(transformation(extent = {{-60, 50}, {-40, 70}})));
            Modelica.Blocks.Math.Feedback positionFeedback 
              annotation(Placement(transformation(extent = {{-90, 50}, {-70, 70}})));
            Modelica.Blocks.Continuous.FirstOrder busdelay(T = 1e-3, initType = Modelica.Blocks.Types.Init.InitialOutput) 
              annotation(Placement(transformation(extent = {{68, -10}, {88, 10}})));
          equation
            connect(speedFeedback.y, speed_PI.u) annotation(Line(
              points = {{29, 0}, {36, 0}}, color = {0, 0, 127}));
            connect(positionFeedback.u2, positionToSpeed.u) annotation(Line(
              points = {{-80, 52}, {-80, -60}, {-62, -60}}, color = {0, 0, 127}));
            connect(positionReference, positionFeedback.u1) annotation(Line(
              points = {{-120, 60}, {-88, 60}}, color = {0, 0, 127}));
            connect(positionFeedback.y, position_PI.u) annotation(Line(
              points = {{-71, 60}, {-62, 60}}, color = {0, 0, 127}));
            connect(position_PI.y, speedFeedback.u1) annotation(Line(
              points = {{-39, 60}, {0, 60}, {0, 0}, {12, 0}}, color = {0, 0, 127}));
            connect(speed_PI.y, busdelay.u) annotation(Line(
              points = {{59, 0}, {66, 0}}, color = {0, 0, 127}));
            connect(y1, busdelay.y) annotation(Line(
              points = {{110, 0}, {89, 0}}, color = {0, 0, 127}));
            connect(positionMeasured, positionToSpeed.u) annotation(Line(
              points = {{-120, -60}, {-62, -60}}, color = {0, 0, 127}));
            connect(positionToSpeed.y, speedFeedback.u2) annotation(Line(
              points = {{-39, -60}, {20, -60}, {20, -8}}, color = {0, 0, 127}));
            annotation(Icon(coordinateSystem(
              preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {
              Text(
              extent = {{-40, 50}, {40, -30}}, 
              textColor = {0, 0, 255}, 
              textString = "PI")}), 
              Documentation(revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                      , info = "<html>
<p>
驱动系统的简便位置控制器。
该控制器用于
<a href=\"modelica://Modelica.Blocks.Examples.Noise.ActuatorWithNoise\">Examples.Noise.ActuatorWithNoise</a>
示例中。
</p>
</html>"                      ));
          end Controller;
          annotation(Documentation(revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>时间</th> <th align=\"left\">描述</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"                          , info = "<html><p>
应用在 执行器示例<a href=\"modelica://Modelica.Blocks.Examples.Noise.ActuatorWithNoise\" target=\"\">Examples.Noise.ActuatorWithNoise</a> 中的部件。
</p>
</html>"                          ));
        end Parts;
        annotation(Documentation(info = "<html><p>
本组件库包含了一组实用的模型，这些模型被作为示例。
</p>
</html>"          , revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
<img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
Initial version implemented by
A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"          ));
      end Utilities;
      annotation(Documentation(info="<html><p>
此包包含多个示例模型，演示了如何使用<a href=\"modelica://Modelica.Blocks.Noise\" target=\"\">Blocks.Noise</a>&nbsp;子库中的模块。
</p>
</html>"    ,revisions = "<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
<td>

<table border=\"0\">
<tr><td>
   <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
   Initial version implemented by
   A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
   <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"    ));
    end Noise;

    package BusUsage_Utilities 
      "用于Modelica.Blocks.Examples.BusUsage的实用模型和连接器"
      extends Modelica.Icons.UtilitiesPackage;
      package Interfaces "专门用于此示例的接口"
        extends Modelica.Icons.InterfacesPackage;

        expandable connector ControlBus 
          "与连接到它的信号相适应的控制总线"
          extends Modelica.Icons.SignalBus;

          SI.AngularVelocity realSignal1 "第一实数信号(角速度)" 
            annotation(HideResult = false);
          SI.Velocity realSignal2 "第二实数信号" 
            annotation(HideResult = false);
          Integer integerSignal "整数信号" annotation(HideResult = false);
          Boolean booleanSignal "布尔值信号" annotation(HideResult = false);
          SubControlBus subControlBus "结合信号" 
            annotation(HideResult = false);
          annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
            -100}, {100, 100}}), graphics = {Rectangle(
            extent = {{-20, 2}, {22, -2}}, 
            lineColor = {255, 204, 51}, 
            lineThickness = 0.5)}), Documentation(info = "<html>
<p>
这个连接器定义了名为控制总线的“可扩展连接器”，它在
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>
示例中被用作总线。注意，此连接器包含“默认”信号，
这些信号可能会在连接中被使用
(连接到此总线的信号的输入/输出因果关系是从连接中确定的)。
</p>
</html>"    ));

        end ControlBus;

        expandable connector SubControlBus 
          "与连接到它的信号相适应的子控制总线"
          extends Modelica.Icons.SignalSubBus;
          Real myRealSignal annotation(HideResult = false);
          Boolean myBooleanSignal annotation(HideResult = false);
          annotation(
            defaultComponentPrefixes = "受保护的", 
            Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {
            100, 100}}), graphics = {Rectangle(
            extent = {{-20, 2}, {22, -2}}, 
            lineColor = {255, 204, 51}, 
            lineThickness = 0.5)}), 
            Documentation(info = "<html>
<p>
这个连接器定义了一个名为子控制总线的“可扩展连接器”，它被用作
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>
示例中的子总线。注意，这是一个可扩展连接器，它有一个“默认”信号集
(信号的输入/输出因果关系是从连接到这个总线的连接器中确定的)。
</p>
</html>"    ));

        end SubControlBus;

        annotation(Documentation(info = "<html>
<p>
该组件包含了
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>
示例所需的总线定义。
</p>
</html>"    ));
      end Interfaces;

      model Part "子控制总线组件"

        Interfaces.SubControlBus subControlBus annotation(Placement(
          transformation(
          origin = {100, 0}, 
          extent = {{-20, -20}, {20, 20}}, 
          rotation = 270)));
        Sources.RealExpression realExpression(y = time) annotation(Placement(
          transformation(extent = {{-6, 0}, {20, 20}})));
        Sources.BooleanExpression booleanExpression(y = time >= 0.5) annotation(
          Placement(transformation(extent = {{-6, -30}, {20, -10}})));
      equation
        connect(realExpression.y, subControlBus.myRealSignal) annotation(Line(
          points = {{21.3, 10}, {88, 10}, {88, 6}, {98, 6}, {98, 0}, {100, 0}}, color = {0, 0, 127}));
        connect(booleanExpression.y, subControlBus.myBooleanSignal) annotation(
          Line(
          points = {{21.3, -20}, {60, -20}, {60, 0}, {100, 0}}, color = {255, 0, 255}));
        annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, 
          -100}, {100, 100}}), graphics = {Rectangle(
          extent = {{-100, 60}, {100, -60}}, 
          fillColor = {159, 159, 223}, 
          fillPattern = FillPattern.Solid, 
          lineColor = {0, 0, 127}), Text(
          extent = {{-106, 124}, {114, 68}}, 
          textString = "%name", 
          textColor = {0, 0, 255})}), Documentation(info = "<html>
<p>
该模型用于在示例<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a>中演示总线的使用。
</p>
</html>"    ));
      end Part;

      annotation(Documentation(info = "<html>
<p>
该组件包包含了
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
示例所需的总线定义。
</p>
</html>"    ));
    end BusUsage_Utilities;

    annotation(Documentation(info = "<html>
<p>
此包包含了一组示例模型，用于演示Blocks包的使用方法。
</p>
</html>"  ));
  end Examples;

  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0, -100.0}, {100.0, 100.0}}), graphics = {
    Rectangle(
    origin = {0.0, 35.1488}, 
    fillColor = {255, 255, 255}, 
    extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), 
    Rectangle(
    origin = {0.0, -34.8512}, 
    fillColor = {255, 255, 255}, 
    extent = {{-30.0, -20.1488}, {30.0, 20.1488}}), 
    Line(
    origin = {-51.25, 0.0}, 
    points = {{21.25, -35.0}, {-13.75, -35.0}, {-13.75, 35.0}, {6.25, 35.0}}), 
    Polygon(
    origin = {-40.0, 35.0}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{10.0, 0.0}, {-5.0, 5.0}, {-5.0, -5.0}}), 
    Line(
    origin = {51.25, 0.0}, 
    points = {{-21.25, 35.0}, {13.75, 35.0}, {13.75, -35.0}, {-6.25, -35.0}}), 
    Polygon(
    origin = {40.0, -35.0}, 
    pattern = LinePattern.None, 
    fillPattern = FillPattern.Solid, 
    points = {{-10.0, 0.0}, {5.0, 5.0}, {5.0, -5.0}})}), Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该库包含用于构建框图的输入/输出模块。</span>
</p>
<p>
<strong>主要作者：</strong>
</p>
<p>
<a href=\"http://www.robotic.dlr.de/Martin.Otter/\" target=\"\">Martin Otter</a>&nbsp; <br><br> &nbsp; &nbsp;Deutsches Zentrum für Luft und Raumfahrt e. V. (DLR)<br><br> &nbsp; &nbsp;Oberpfaffenhofen<br><br> &nbsp; &nbsp;Postfach 1116<br><br> &nbsp; &nbsp;D-82230 Wessling<br><br> &nbsp; &nbsp;email: <a href=\"mailto:Martin.Otter@dlr.de\" target=\"\">Martin.Otter@dlr.de</a>&nbsp; <br>
</p>
<p>
Copyright &copy; 1998-2020，Modelica协会和贡献者
</p>
</html>",revisions = "<html>
<ul>
<li><em>June 23, 2004</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       引入了新的块连接器，并将所有块适配到新的连接器。
       包含了来自ModelicaAdditions.Blocks包的子包Continuous、Discrete、Logical和Nonlinear。
       将ModelicaAdditions.Table子包包含到Modelica.Blocks.Sources中，并且也包含到新的Modelica.Blocks.Tables包中。
       向Blocks.Sources和Blocks.Logical中添加了新的块。
       </li>
<li><em>October 21, 2002</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Christian Schweiger:<br>
       新增子包Examples和其他组件。
       </li>
<li><em>June 20, 2000</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
       Michael Tiller:<br>
       在Blocks.Interfaces.RealInput/RealOutput中引入了一个可替换的信号类型：
<blockquote><pre>
replaceable type SignalType = Real
</pre></blockquote>
       为了使输入/输出块的信号类型可以更改为物理类型，例如：
<blockquote><pre>
Sine sin1(outPort(redeclare type SignalType=Modelica.Units.SI.Torque))
</pre></blockquote>
      </li>
<li><em>Sept. 18, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       重命名为Blocks。新增子包Math和Nonlinear。在子包Interfaces、Continuous和Sources中添加了额外的组件。</li>
<li><em>June 30, 1999</em>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       基于Dieter Moormann和Hilding Elmqvist的现有Dymola库，实现了第一版。</li>
</ul>
</html>"));
end Blocks;