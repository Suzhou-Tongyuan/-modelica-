within Modelica.Blocks;
package Continuous "具有内部状态的连续控制模块库"

  import Modelica.Blocks.Interfaces;

  extends Modelica.Icons.Package;

  block Integrator "可选择复位来输出输入信号的积分"
    import Modelica.Blocks.Types.Init;
    parameter Real k(unit = "1") = 1 "积分增益";
    parameter Boolean use_reset = false "=true，当重置端口已启用" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_set = false "=true，当设置端口已启用，重置时需重新初始化值" 
      annotation(Dialog(enable = use_reset), Evaluate = true, HideResult = true, choices(checkBox = true));

    /* InitialState是默认设置，因为它是Modelica2.2中的默认设置，
    因此该设置向后兼容
    */
    parameter Init initType = Init.InitialState 
      "初始化类型(1：无初始化，2：稳态初始化，3/4：初始输出值初始化)" annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real y_start = 0 "输出的初始值或猜测值(=state)" 
      annotation(Dialog(group = "初始化"));
    extends Interfaces.SISO(y(start = y_start));
    Modelica.Blocks.Interfaces.BooleanInput reset if use_reset "复位信号的可选连接器" annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90, 
      origin = {60, -120})));
    Modelica.Blocks.Interfaces.RealInput set if use_reset and use_set "设定信号的可选连接器" annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 270, 
      origin = {60, 120})));
  protected
    Modelica.Blocks.Interfaces.BooleanOutput local_reset annotation(HideResult = true);
    Modelica.Blocks.Interfaces.RealOutput local_set annotation(HideResult = true);

  initial equation
    if initType == Init.SteadyState then
      der(y) = 0;
    elseif initType == Init.InitialState or 
      initType == Init.InitialOutput then
      y = y_start;
    end if;
  equation
    if use_reset then
      connect(reset, local_reset);
      if use_set then
        connect(set, local_set);
      else
        local_set = y_start;
      end if;
      when local_reset then
        reinit(y, local_set);
      end when;
    else
      local_reset = false;
      local_set = 0;
    end if;
    der(y) = k * u;
    annotation(
      Documentation(info="<html><p>
该模块将输出 <strong>y</strong>计算为输入 <strong>u</strong>乘以增益<em>k</em>的 <em>积分</em>：
</p>
<blockquote><pre>
    k
y = - u
    s
</pre></blockquote>

<p>
在稳定状态下初始化积分模块可能比较困难。 这一点将在组件 <a href=\"modelica://Modelica.Blocks.Continuous#info\" target=\"\">Continuous</a>的描述中讨论。
</p>
<p>
如果启用了<em>reset &nbsp;</em>端口，那么只要<em>reset &nbsp;</em>端口出现上升趋势， 输出<strong>y</strong>就会被复位为<em>set </em>或<em>y_start</em> &nbsp;(如果未启用<em>set &nbsp;</em>端口)。
</p>
</html>"  ), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(
      points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
      color = {192, 192, 192}), 
      Polygon(
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
      Line(
      points = {{-90.0, -80.0}, {82.0, -80.0}}, 
      color = {192, 192, 192}), 
      Polygon(
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
      Text(
      textColor = {192, 192, 192}, 
      extent = {{0.0, -70.0}, {60.0, -10.0}}, 
      textString = "I"), 
      Text(
      extent = {{-150.0, -150.0}, {150.0, -110.0}}, 
      textString = "k=%k"), 
      Line(
      points = DynamicSelect({{-80.0, -80.0}, {80.0, 80.0}}, if use_reset then {{-80.0, -80.0}, {60.0, 60.0}, {60.0, -80.0}, {80.0, -60.0}} else {{-80.0, -80.0}, {80.0, 80.0}}), 
      color = {0, 0, 127}), 
      Line(
      visible = use_reset, 
      points = {{60, -100}, {60, -80}}, 
      color = {255, 0, 255}, 
      pattern = LinePattern.Dot), 
      Text(
      visible = use_reset, 
      extent = {{-28, -62}, {94, -86}}, 
      textString = "reset")}));
  end Integrator;

  block LimIntegrator "输出值有限且可选择复位的积分器"
    import Modelica.Blocks.Types.Init;
    parameter Real k(unit = "1") = 1 "积分增益";
    parameter Real outMax(start = 1) "输出上限";
    parameter Real outMin = -outMax "输出下限";
    parameter Boolean use_reset = false "=true，当重置端口已启用" 
      annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Boolean use_set = false "=true，当设置端口已启用，重置时需重新初始化值" 
      annotation(Dialog(enable = use_reset), Evaluate = true, HideResult = true, choices(checkBox = true));
    parameter Init initType = Init.InitialState 
      "初始化类型(1：无初始化，2：稳态初始化，3/4：初始输出值初始化)" 
      annotation(Evaluate = true, Dialog(group = "初始化"));
    parameter Boolean limitsAtInit = true 
      "=false，当初始化过程中忽略了限值(即der(y)=k*u)" 
      annotation(Evaluate = true, Dialog(group = "初始化"));
    parameter Real y_start = 0 
      "输出的初始值或猜测值(必须在限值outMin...outMax范围内)" 
      annotation(Dialog(group = "初始化"));
    parameter Boolean strict = false "=true，当使用noEvent(...)进行严格限制" 
      annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级"));
    extends Interfaces.SISO(y(start = y_start));
    Modelica.Blocks.Interfaces.BooleanInput reset if use_reset "复位信号的可选连接器" annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90, 
      origin = {60, -120})));
    Modelica.Blocks.Interfaces.RealInput set if use_reset and use_set "设定信号的可选连接器" annotation(Placement(
      transformation(
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 270, 
      origin = {60, 120})));
  protected
    Modelica.Blocks.Interfaces.BooleanOutput local_reset annotation(HideResult = true);
    Modelica.Blocks.Interfaces.RealOutput local_set annotation(HideResult = true);

  initial equation
    if initType == Init.SteadyState then
      der(y) = 0;
    elseif initType == Init.InitialState or 
      initType == Init.InitialOutput then
      y = y_start;
    end if;
  equation
    if use_reset then
      connect(reset, local_reset);
      if use_set then
        connect(set, local_set);
      else
        local_set = y_start;
      end if;
      when local_reset then
        reinit(y, if local_set < outMin then outMin else if local_set > outMax then outMax else local_set);
      end when;
    else
      local_reset = false;
      local_set = 0;
    end if;
    if initial() and not limitsAtInit then
      der(y) = k * u;
      assert(y >= outMin - 0.001 * abs(outMax - outMin) and y <= outMax + 0.001 * abs(outMax - outMin), 
        "LimIntegrator: During initialization the limits have been ignored.\n" 
        + "However, the result is that the output y is not within the required limits:\n" 
        + "  y = " + String(y) + ", outMin = " + String(outMin) + ", outMax = " + String(outMax));
    elseif strict then
      der(y) = noEvent(if y < outMin and k * u < 0 or y > outMax and k * u > 0 then 0 else k * u);
    else
      der(y) = if y < outMin and k * u < 0 or y > outMax and k * u > 0 then 0 else k * u;
    end if;
    annotation(
      Documentation(info="<html><p>
该模块将 <strong>y</strong>计算为输入 <strong>u</strong>乘以增益<em>k</em>的<em>积分</em>。 <span style=\"color: rgb(51, 51, 51); background-color: rgb(245, 246, 248);\">如果积分值达到设定的上限或下限，并且输入会导致积分超出该范围，则停止积分。只有当输入将积分值推离边界时，积分才会重新开始</span>。
</p>
<p>
在稳定状态下初始化积分模块可能比较困难。 这一点将在组件 <a href=\"modelica://Modelica.Blocks.Continuous#info\" target=\"\">Continuous</a>&nbsp; 的描述中讨论。
</p>
<p>
如果参数 <strong>limitsAtInit</strong>=<strong>false</strong>， 积分模块的限制将从初始化问题中移除， 从而使方程系统简单得多。 初始化完成后， 通过断言检查输出是否在规定的范围内。 出于向后兼容的原因， 在大多数情况下最好使用<strong>limitsAtInit</strong>=<strong>false</strong>替代<strong>limitsAtInit</strong>=<strong>true</strong>。
</p>
<p>
如果启用了<em>reset &nbsp;</em>端口，那么只要<em>reset &nbsp;</em>端口出现上升趋势， 输出<strong>y</strong>就会复位为<em>set &nbsp;</em>或<em>y_start</em> (如果未启用<em>set &nbsp;</em>端口)。
</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 78}, {-80, -90}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -80}, {82, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(
      points = DynamicSelect({{-80, -80}, {20, 20}, {80, 20}}, if use_reset then {{-80, -80}, {20, 20}, {60, 20}, {60, -80}, {80, -60}} else {{-80, -80}, {20, 20}, {80, 20}}), 
      color = {0, 0, 127}), 
      Text(
      extent = {{0, -10}, {60, -70}}, 
      textColor = {192, 192, 192}, 
      textString = "I"), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "k=%k"), 
      Line(
      visible = strict, 
      points = DynamicSelect({{20, 20}, {80, 20}}, if use_reset then {{20, 20}, {60, 20}} else {{20, 20}, {80, 20}}), 
      color = {255, 0, 0}), 
      Line(
      visible = use_reset, 
      points = {{60, -100}, {60, -80}}, 
      color = {255, 0, 255}, 
      pattern = LinePattern.Dot), 
      Text(
      visible = use_reset, 
      extent = {{-28, -62}, {94, -86}}, 
      textString = "reset")}));
  end LimIntegrator;

  block Derivative "近似导数模块"
    import Modelica.Blocks.Types.Init;
    parameter Real k(unit = "1") = 1 "增益";
    parameter SI.Time T(min = Modelica.Constants.small) = 0.01 
      "时间常数(要求T>0；T=0是理想的导数模块)";
    parameter Init initType = Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real x_start = 0 "状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0 "输出初始值(=state)" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));
    extends Interfaces.SISO;

    output Real x(start = x_start) "模块状态";

  protected
    parameter Boolean zeroGain = abs(k) < Modelica.Constants.eps;
  initial equation
    if initType == Init.SteadyState then
      der(x) = 0;
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      if zeroGain then
        x = u;
      else
        y = y_start;
      end if;
    end if;
  equation
    der(x) = if zeroGain then 0 else (u - x) / T;
    y = if zeroGain then 0 else (k / T) * (u - x);
    annotation(
      Documentation(info="<html><p>
该模块将输入u和输出y之间的传递函数定义为 <em>近似导数 </em>：
</p>
<pre><code >k * s
y = ------------ * u
T * s + 1</code></pre><p>
如果您希望通过更改参数在不同传递函数(一阶、二阶......) 之间轻松切换， 请使用通用模块<strong>TransferFunction</strong>代替， 并使用参数对导数模块进行建模<br> b = {k,0}, a = {T, 1}。
</p>
<p>
当k=0,该模块简化为y=0。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"  ), Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
      Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
      Line(origin = {-24.667, -27.333}, 
      points = {{-55.333, 87.333}, {-19.333, -40.667}, {86.667, -52.667}}, 
      color = {0, 0, 127}, 
      smooth = Smooth.Bezier), 
      Text(textColor = {192, 192, 192}, 
      extent = {{-30.0, 14.0}, {86.0, 60.0}}, 
      textString = "DT1"), 
      Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, 
      textString = "k=%k")}));
  end Derivative;

  block FirstOrder "一阶传递函数模型(=1个极点)"
    import Modelica.Blocks.Types.Init;
    parameter Real k(unit = "1") = 1 "增益";
    parameter SI.Time T(start = 1) "时间常数";
    parameter Init initType = Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3/4：初始输出值初始化)" annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real y_start = 0 "输出(=状态)初始值或猜测值" 
      annotation(Dialog(group = "初始化"));

    extends Interfaces.SISO(y(start = y_start));

  initial equation
    if initType == Init.SteadyState then
      der(y) = 0;
    elseif initType == Init.InitialState or initType == Init.InitialOutput then
      y = y_start;
    end if;
  equation
    der(y) = (k * u - y) / T;
    annotation(
      Documentation(info="<html><p>
这个模块定义了输入u和输出y之间的传递函数，即<em>一阶 </em>系统：
</p>
<pre><code >k
y = ------------ * u
T * s + 1</code></pre><p>
如果你想通过调整参数轻松地在不同的传递函数 (如FirstOrder,SecondOrder等)之间切换， 应使用通用<strong>TransferFunction</strong>，而非特定模型， 并利用参数来构建一个一阶单输入单输出(SISO)系统模型<br> b = {k}, a = {T, 1}。
</p>
<pre><code >Example:
parameter: k = 0.3, T = 0.4
results in:
0.3
y = ----------- * u
0.4 s + 1.0</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"), Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
      Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
      Line(origin = {-26.667, 6.667}, 
      points = {{106.667, 43.333}, {-13.333, 29.333}, {-53.333, -86.667}}, 
      color = {0, 0, 127}, 
      smooth = Smooth.Bezier), 
      Text(textColor = {192, 192, 192}, 
      extent = {{0.0, -60.0}, {60.0, 0.0}}, 
      textString = "PT1"), 
      Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, 
      textString = "T=%T")}));
  end FirstOrder;

  block SecondOrder "二阶传递函数模型(=2个极点)"
    import Modelica.Blocks.Types.Init;
    parameter Real k(unit = "1") = 1 "增益";
    parameter Real w(start = 1) "角频率";
    parameter Real D(start = 1) "阻尼系数";
    parameter Init initType = Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3/4：初始输出值初始化)" annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real y_start = 0 "输出(=状态)初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real yd_start = 0 
      "输出(=状态)导数的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));

    extends Interfaces.SISO(y(start = y_start));
    output Real yd(start = yd_start) "y的导数";

  initial equation
    if initType == Init.SteadyState then
      der(y) = 0;
      der(yd) = 0;
    elseif initType == Init.InitialState or initType == Init.InitialOutput then
      y = y_start;
      yd = yd_start;
    end if;
  equation
    der(y) = yd;
    der(yd) = w * (w * (k * u - y) - 2 * D * yd);
    annotation(
      Documentation(info="<html><p>
这个模型定义了输入u和输出y之间的传递函数，即<em>二阶</em> 系统：
</p>
<pre><code >k
y = --------------------------------- * u
( s / w )^2 + 2*D*( s / w ) + 1</code></pre><p>
如果你想通过调整参数轻松地在不同的传递函数 (如FirstOrder,SecondOrder等)之间切换， 应使用通用模型类<strong>TransferFunction</strong>，而非特定模型， 然后利用参数来构建一个二阶单输入单输出(SISO)系统模型<br> b = {k}, a = {1/w^2, 2*D/w, 1}。
</p>
<pre><code >Example:

parameter: k =  0.3,  w = 0.5,  D = 0.4
results in:
0.3
y = ------------------- * u
4.0 s^2 + 1.6 s + 1</code></pre><p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"), Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
      Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
      Line(origin = {-1.939, -1.816}, 
      points = {{81.939, 36.056}, {65.362, 36.056}, {14.39, -26.199}, {-29.966, 113.485}, {-65.374, -61.217}, {-78.061, -78.184}}, 
      color = {0, 0, 127}, 
      smooth = Smooth.Bezier), 
      Text(textColor = {192, 192, 192}, 
      extent = {{0.0, -70.0}, {60.0, -10.0}}, 
      textString = "PT2"), 
      Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, 
      textString = "w=%w")}));
  end SecondOrder;

  block PI "比例积分控制器"
    import Modelica.Blocks.Types.Init;
    parameter Real k(unit = "1") = 1 "增益";
    parameter SI.Time T(start = 1, min = Modelica.Constants.small) 
      "时间常数(要求T>0)";
    parameter Init initType = Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real x_start = 0 "输出初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0 "输出初始值" 
      annotation(Dialog(enable = initType == Init.SteadyState or initType == Init.InitialOutput, group = 
      "初始化"));

    extends Interfaces.SISO;
    output Real x(start = x_start) "模块状态";

  initial equation
    if initType == Init.SteadyState then
      der(x) = 0;
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      y = y_start;
    end if;
  equation
    der(x) = u / T;
    y = k * (x + u);
    annotation(defaultComponentName = "PI", 
      Documentation(info="<html><p>
这个模型定义了输入u和输出y之间的传递函数， 即<em>PI</em>系统：
</p>
<pre><code >1
y = k * (1 + ---) * u
T*s
T*s + 1
= k * ------- * u
T*s</code></pre><p>
如果你想通过调整参数轻松地在不同的传递函数 (如FirstOrder,SecondOrder等)之间切换， 应使用通用模型类<strong>TransferFunction</strong>，而非特定模型， 然后利用参数来构建一个比例积分(PI)单输入单输出(SISO)系统<br> b = {k*T, k}, a = {T, 0}.
</p>
<pre><code >Example:

parameter: k = 0.3,  T = 0.4

results in:
0.4 s + 1
y = 0.3 ----------- * u
0.4 s</code></pre><p>
由于积分部分的存在， PI组件在稳态时的初始化可能会遇到困难， 这在 <a href=\"modelica://Modelica.Blocks.Continuous#info\" target=\"\">Continuous</a>包的描述中有所论述。
</p>
<p>
<br>
</p>
</html>"), Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 78}, {-80, -90}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -80}, {82, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80.0, -80.0}, {-80.0, -20.0}, {60.0, 80.0}}, color = {0, 0, 127}), 
      Text(
      extent = {{0, 6}, {60, -56}}, 
      textColor = {192, 192, 192}, 
      textString = "PI"), 
      Text(
      extent = {{-150, -150}, {150, -110}}, 
      textString = "T=%T")}));
  end PI;

  block PID "添加描述形式的PID控制器"
    import Modelica.Blocks.Types.Init;
    extends Interfaces.SISO;

    parameter Real k(unit = "1") = 1 "增益";
    parameter SI.Time Ti(min = Modelica.Constants.small, start = 0.5) 
      "积分器时间常数";
    parameter SI.Time Td(min = 0, start = 0.1) 
      "导数模块时间常数";
    parameter Real Nd(min = Modelica.Constants.small) = 10 
      "Nd越高，导数模块越理想";
    parameter Init initType = Init.InitialState 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real xi_start = 0 
      "积分器输出的初始值或猜测值(=积分器状态)" 
      annotation(Dialog(group = "初始化"));
    parameter Real xd_start = 0 
      "导数模块状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0 "初始化输出值" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));
    constant SI.Time unitTime = 1 annotation(HideResult = true);

    Blocks.Math.Gain P(k = 1) "PID控制器的比例部分" 
      annotation(Placement(transformation(extent = {{-60, 60}, {-20, 100}})));
    Blocks.Continuous.Integrator I(k = unitTime / Ti, y_start = xi_start, 
      initType = if initType == Init.SteadyState then 
      Init.SteadyState else 
      if initType == Init.InitialState then 
      Init.InitialState else Init.NoInit) 
      "PID控制器的组成部分" 
      annotation(Placement(transformation(extent = {{-60, -20}, {-20, 20}})));
    Blocks.Continuous.Derivative D(k = Td / unitTime, T = max([Td / Nd, 100 * Modelica.
      Constants.eps]), x_start = xd_start, 
      initType = if initType == Init.SteadyState or 
      initType == Init.InitialOutput then Init.SteadyState else 
      if initType == Init.InitialState then Init.InitialState else 
      Init.NoInit) "Derivative part of PID controller" 
      annotation(Placement(transformation(extent = {{-60, -100}, {-20, -60}})));
    Blocks.Math.Gain Gain(k = k) "PID控制器的增益" 
      annotation(Placement(transformation(extent = {{60, -10}, {80, 10}})));
    Blocks.Math.Add3 Add annotation(Placement(transformation(extent = {{20, -10}, 
      {40, 10}})));
  initial equation
    if initType == Init.InitialOutput then
      y = y_start;
    end if;

  equation
    connect(u, P.u) annotation(Line(points = {{-120, 0}, {-80, 0}, {-80, 80}, {-64, 80}}, color = {0, 0, 127}));
    connect(u, I.u) 
      annotation(Line(points = {{-120, 0}, {-64, 0}}, color = {0, 0, 127}));
    connect(u, D.u) annotation(Line(points = {{-120, 0}, {-80, 0}, {-80, -80}, {-64, -80}}, 
      color = {0, 0, 127}));
    connect(P.y, Add.u1) annotation(Line(points = {{-18, 80}, {0, 80}, {0, 8}, {18, 8}}, color = {0, 0, 127}));
    connect(I.y, Add.u2) 
      annotation(Line(points = {{-18, 0}, {18, 0}}, color = {0, 0, 127}));
    connect(D.y, Add.u3) annotation(Line(points = {{-18, -80}, {0, -80}, {0, -8}, {18, -8}}, 
      color = {0, 0, 127}));
    connect(Add.y, Gain.u) 
      annotation(Line(points = {{41, 0}, {58, 0}}, color = {0, 0, 127}));
    connect(Gain.y, y) 
      annotation(Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
    annotation(defaultComponentName = "PID", 
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
      Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
      Line(points = {{-80, -80}, {-80, -20}, {60, 80}}, color = {0, 0, 127}), 
      Text(textColor = {192, 192, 192}, 
      extent = {{-20.0, -60.0}, {80.0, -20.0}}, 
      textString = "PID"), 
      Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, 
      textString = "Ti=%Ti")}), 
      Documentation(info="<html><p>
这是PID控制器的标准形式。 为了得到更实用的PID控制器， 推荐使用\"LimPID\"模块。
</p>
<p>
PID模块可以通过参数<strong>initType</strong>以不同的方式初始化， 的可能值由 <a href=\"modelica://Modelica.Blocks.Types.Init\" target=\"\">Modelica.Blocks.Types.Init</a> 定义，并可以在其中找到这些值的详细说明。
</p>
<p>
根据initType的设置， PID控制器内部的积分器(I)和微分器(D)将按照以下表格进行初始化：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>initType</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>I.initType</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>D.initType</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>NoInit</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">NoInit</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">NoInit</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>SteadyState</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyState</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyState</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>InitialState</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">InitialState</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">InitialState</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>InitialOutput</strong><br><br>and initial equation: y = y_start</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">NoInit</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyState</td></tr></tbody></table><p>
在许多情况下，最实用的初始条件是<strong>稳态</strong>， 因为这样可以避免初始波动。 如果initType设置为Init.SteadyState， 有时可能会遇到问题。 原因在于积分器的方程：
</p>
<pre><code >der(y) = k*u;</code></pre><p>
在稳态方程\"der(x)=0\"下， 积分器的输入u必须为零。 如果u(直接或间接)由其他初始条件定义， 那么初始化问题就变得<strong>奇异</strong>(即没有解或有无限多个解)。 这在机械系统中很常见， 例如，u可能等于期望速度减去测量速度。 由于速度既是状态又是导数，用零来将它初始化乎是可行的。 然而，如上述情况所示，这在实践中又是不可行的。 解决方法是不要通过代数方程来初始化u或用于计算u的变量。
</p>
</html>"  ));
  end PID;
  block PID_Parallel "并联PID控制器的加法描述形式"
    import Modelica.Blocks.Types.Init;
    extends Modelica.Blocks.Interfaces.SISO;

    parameter Real k(unit = "1") = 1 "增益";
    parameter SI.Time Ti(min = Modelica.Constants.small, start = 0.5) 
      "积分器的时间常数";
    parameter SI.Time Td(min = 0, start = 0.1) 
      "微分块的时间常数";
    parameter Real Nd(min = Modelica.Constants.small) = 10 
      "Nd越高，微分块越理想";
    parameter Init initType = Init.InitialState 
      "初始化类型（1：不初始化，2：稳态，3：初始状态，4：初始输出）" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real xi_start = 0 
      "积分器输出的初始值或猜测值（= 积分器状态）" 
      annotation(Dialog(group = "初始化"));
    parameter Real xd_start = 0 
      "微分块状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0 "输出的初始值" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));
    constant SI.Time unitTime = 1 annotation(HideResult = true);

    Modelica.Blocks.Math.Gain P(k = k) "PID控制器的比例部分" 
      annotation(Placement(transformation(extent = {{-60, 60}, {-20, 100}})));
    Modelica.Blocks.Continuous.Integrator I(k = unitTime / Ti, y_start = xi_start, 
      initType = if initType == Init.SteadyState then 
      Init.SteadyState else 
      if initType == Init.InitialState then 
      Init.InitialState else Init.NoInit) 
      "PID控制器的积分部分" 
      annotation(Placement(transformation(extent = {{-60, -20}, {-20, 20}})));
    Modelica.Blocks.Continuous.Derivative D(k = Td / unitTime, T = max([Td / Nd, 100 * Modelica.
      Constants.eps]), x_start = xd_start, 
      initType = if initType == Init.SteadyState or 
      initType == Init.InitialOutput then Init.SteadyState else 
      if initType == Init.InitialState then Init.InitialState else 
      Init.NoInit) "PID控制器的微分部分" 
      annotation(Placement(transformation(extent = {{-60, -100}, {-20, -60}})));
    Modelica.Blocks.Math.Gain Gain(k = 1) "PID控制器的增益" 
      annotation(Placement(transformation(extent = {{60, -10}, {80, 10}})));
    Modelica.Blocks.Math.Add3 Add annotation(Placement(transformation(extent = {{20, -10}, 
      {40, 10}})));
  initial equation
    if initType == Init.InitialOutput then
      y = y_start;
    end if;

  equation
    connect(u, P.u) annotation(Line(points = {{-120, 0}, {-80, 0}, {-80, 80}, {-64, 80}}, color = {0, 0, 127}));
    connect(u, I.u) 
      annotation(Line(points = {{-120, 0}, {-64, 0}}, color = {0, 0, 127}));
    connect(u, D.u) annotation(Line(points = {{-120, 0}, {-80, 0}, {-80, -80}, {-64, -80}}, 
      color = {0, 0, 127}));
    connect(P.y, Add.u1) annotation(Line(points = {{-18, 80}, {0, 80}, {0, 8}, {18, 8}}, color = {0, 0, 127}));
    connect(I.y, Add.u2) 
      annotation(Line(points = {{-18, 0}, {18, 0}}, color = {0, 0, 127}));
    connect(D.y, Add.u3) annotation(Line(points = {{-18, -80}, {0, -80}, {0, -8}, {18, -8}}, 
      color = {0, 0, 127}));
    connect(Add.y, Gain.u) 
      annotation(Line(points = {{41, 0}, {58, 0}}, color = {0, 0, 127}));
    connect(Gain.y, y) 
      annotation(Line(points = {{81, 0}, {110, 0}}, color = {0, 0, 127}));
    annotation(defaultComponentName = "PID_Parallel", 
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
      Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
      Line(points = {{-80, -80}, {-80, -20}, {60, 80}}, color = {0, 0, 127}), 
      Text(textColor = {192, 192, 192}, 
      extent = {{-20.0, -60.0}, {80.0, -20.0}}, 
      textString = "PID"), 
      Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, 
      textString = "Ti=%Ti")}), 
      Documentation(info = "<html>
<p>
这是教科书版本的PID控制器。
对于更实用的PID控制器，使用
块LimPID。
</p>

<p>
PID块可以通过参数 <strong>initType</strong> 以不同方式初始化。initType的可能
值在<a href=\"modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a> 中定义。
</p>

<p>
根据initType的设置，PID控制器内部的积分器（I）和微分器（D）
块依照下表初始化：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>initType</strong></td>
    <td><strong>I.initType</strong></td>
    <td><strong>D.initType</strong></td></tr>

<tr><td><strong>NoInit</strong></td>
    <td>NoInit</td>
    <td>NoInit</td></tr>

<tr><td><strong>SteadyState</strong></td>
    <td>SteadyState</td>
    <td>SteadyState</td></tr>

<tr><td><strong>InitialState</strong></td>
    <td>InitialState</td>
    <td>InitialState</td></tr>

<tr><td><strong>InitialOutput</strong><br>
        和初始方程：y = y_start</td>
    <td>NoInit</td>
    <td>SteadyState</td></tr>
</table>

<p>
在许多情况下，最有用的初始条件是
<strong>SteadyState</strong>，因为此时不再存在
初始瞬态。如果initType = Init.SteadyState，则在某些
情况下可能会出现困难。原因在于
积分器的方程：
</p>

<blockquote><pre>
<strong>der</strong>(y) = k*u;
</pre></blockquote>

<p>
稳态方程\"der(x)=0\"导致输入u为零。如果输入u已经（直接或间接）由另一个初始条件定义，
则初始化问题是<strong>奇异的</strong>（无解或有无穷多解）。这种情况在机械系统中经常发生，例如，u = desiredSpeed - measuredSpeed，由于速度既是状态也是导数，通常将其初始化为零。
如图所示，这是不可能的。
解决方案是不通过代数方程初始化u或用于计算u的变量。
</p>

</html>"    ));
  end PID_Parallel;
  block PIDs "理想和并联两种选项的PID控制器"
    import Modelica.Blocks.Types.Init;
    extends Modelica.Blocks.Interfaces.SISO;
    parameter String Type = "Parallel" "PID类型" 
      annotation(choices(
      choice = "Ideal", 
      choice = "Parallel"));

    parameter String Mode = "k,Ti,Td,Nd" "设置模式的参数" 
      annotation(choices(
      choice = "k,Ti,Td,Nd", 
      choice = "P,I,D,N"));
    //mode1
    parameter Real k(unit = "1") = 1 "增益" 
      annotation(Dialog(enable = Mode == "k,Ti,Td,Nd", group = "k,Ti,Td,Nd"));
    parameter SI.Time Ti(min = Modelica.Constants.small, start = 0.5) 
      "积分器的时间常数" annotation(Dialog(enable = Mode == "k,Ti,Td,Nd", group = "k,Ti,Td,Nd"));
    parameter SI.Time Td(min = 0, start = 0.1) 
      "微分块的时间常数" annotation(Dialog(enable = Mode == "k,Ti,Td,Nd", group = "k,Ti,Td,Nd"));
    parameter Real Nd(min = Modelica.Constants.small) = 10 
      "Nd越大，微分块越理想" annotation(Dialog(enable = Mode == "k,Ti,Td,Nd", group = "k,Ti,Td,Nd"));
    //mode2  
    parameter Real P(unit = "1") = 1 "增益" 
      annotation(Dialog(enable = Mode == "P,I,D,N", group = "P,I,D,N"));
    parameter Real I(unit = "1", min = Modelica.Constants.small, start = 1) 
      "积分" annotation(Dialog(enable = Mode == "P,I,D,N", group = "P,I,D,N"));
    parameter Real D(unit = "1", min = 0, start = 0) 
      "微分" annotation(Dialog(enable = Mode == "P,I,D,N", group = "P,I,D,N"));
    parameter Real N(min = Modelica.Constants.small) = 100 
      "滤波系数" annotation(Dialog(enable = Mode == "P,I,D,N", group = "P,I,D,N"));

    parameter Init initType = Init.InitialState 
      "初始化类型(1: no init, 2: steady state, 3: initial state, 4: initial output)" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real xi_start = 0 
      "积分器输出的初始值或猜测值(= 积分器状态)" 
      annotation(Dialog(group = "初始化"));
    parameter Real xd_start = 0 
      "微分块状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0 "输出的初始值" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));
    constant SI.Time unitTime = 1 annotation(HideResult = true);
    Modelica.Blocks.Continuous.PID_Parallel PID_Parallel1(k = k, Ti = Ti, Td = Td, Nd = Nd, initType = initType, xi_start = xi_start, xd_start = xi_start, y_start = y_start) if Type == "Parallel" and Mode == "k,Ti,Td,Nd" 
      annotation(Placement(transformation(origin = {0, 40}, 
      extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.PID PID1(k = k, Ti = Ti, Td = Td, Nd = Nd, initType = initType, xi_start = xi_start, xd_start = xi_start, y_start = y_start) if Type == "Ideal" and Mode == "k,Ti,Td,Nd" 
      annotation(Placement(transformation(origin = {0, 80}, 
      extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.PID_Parallel PID_Parallel2(k = P, Ti = unitTime / I, Td = D * unitTime, Nd = D * unitTime * N, initType = initType, xi_start = xi_start, xd_start = xi_start, y_start = y_start) if Type == "Parallel" and Mode == "P,I,D,N" 
      annotation(Placement(transformation(origin = {0, -76}, 
      extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Continuous.PID PID2(k = P, Ti = unitTime / I, Td = D * unitTime, Nd = D * unitTime * N, initType = initType, xi_start = xi_start, xd_start = xi_start, y_start = y_start) if Type == "Ideal" and Mode == "P,I,D,N" 
      annotation(Placement(transformation(origin = {4.44089e-16, -40}, 
      extent = {{-10, -10}, {10, 10}})));
  equation
    connect(u, PID1.u) 
      annotation(Line(origin = {-71, 15}, 
      points = {{-49, -15}, {11, -15}, {11, 65}, {59, 65}}, 
      color = {0, 0, 127}));
    connect(PID1.y, y) 
      annotation(Line(origin = {56, 15}, 
      points = {{-45, 65}, {4, 65}, {4, -15}, {54, -15}}, 
      color = {0, 0, 127}));
    connect(PID_Parallel1.u, u) 
      annotation(Line(origin = {-71, -15}, 
      points = {{59, 55}, {11, 55}, {11, 15}, {-49, 15}}, 
      color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
    connect(PID_Parallel1.y, y) 
      annotation(Line(origin = {56, -15}, 
      points = {{-45, 55}, {4, 55}, {4, 15}, {54, 15}}, 
      color = {0, 0, 127}));
    connect(u, PID2.u) 
      annotation(Line(origin = {-66, -20}, 
      points = {{-54, 20}, {6, 20}, {6, -20}, {54, -20}}, 
      color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
    connect(PID2.y, y) 
      annotation(Line(origin = {61, -20}, 
      points = {{-50, -20}, {-1, -20}, {-1, 20}, {49, 20}}, 
      color = {0, 0, 127}));
    connect(u, PID_Parallel2.u) 
      annotation(Line(origin = {-66, -40}, 
      points = {{-54, 40}, {6, 40}, {6, -36}, {54, -36}}, 
      color = {0, 0, 127}), __MWORKS(BlockSystem(NamedSignal)));
    connect(PID_Parallel2.y, y) 
      annotation(Line(origin = {61, -38}, 
      points = {{-50, -38}, {-1, -38}, {-1, 38}, {49, 38}}, 
      color = {0, 0, 127}));
    annotation(defaultComponentName = "PIDs", 
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 90.0}, {-88.0, 68.0}, {-72.0, 68.0}, {-80.0, 90.0}}), 
      Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
      Line(points = {{-80, -80}, {-80, -20}, {60, 80}}, color = {0, 0, 127}), 
      Text(textColor = {192, 192, 192}, 
      extent = {{-20.0, -60.0}, {80.0, -20.0}}, 
      textString = "PID"), 
      Text(extent = {{-150.0, -150.0}, {150.0, -110.0}}, 
      textString = "Ti=%Ti")}), 
      Documentation(info = "<html>
<p>
这是PID控制器的教材版本。对于更实用的PID控制器，可以使用LimPID块。
</p>

<p>
PID块可以通过参数<strong>initType</strong>进行不同方式的初始化。
initType的可能值在<a href=\"modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a>中定义。
</p>

<p>
根据initType的设置，PID控制器内部的积分(I)块和微分(D)块将按照以下表格进行初始化：
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td><strong>initType</strong></td>
    <td><strong>I.initType</strong></td>
    <td><strong>D.initType</strong></td></tr>

<tr><td><strong>NoInit</strong></td>
    <td>NoInit</td>
    <td>NoInit</td></tr>

<tr><td><strong>SteadyState</strong></td>
    <td>SteadyState</td>
    <td>SteadyState</td></tr>

<tr><td><strong>InitialState</strong></td>
    <td>InitialState</td>
    <td>InitialState</td></tr>

<tr><td><strong>InitialOutput</strong><br>
        and initial equation: y = y_start</td>
    <td>NoInit</td>
    <td>SteadyState</td></tr>
</table>

<p>
在许多情况下，最有用的初始条件是<strong>稳态(SteadyState)</strong>，因为这样初始瞬态将不再存在。
如果initType = Init.SteadyState，那么在某些情况下可能会出现困难。原因在于积分器的方程：
</p>

<blockquote><pre>
<strong>der</strong>(y) = k*u;
</pre></blockquote>

<p>
稳态方程\"der(x) = 0\"导致积分器的输入u为零的条件。
如果输入u已经(直接或间接)由另一个初始条件定义，则初始化问题是<strong>奇异的</strong>(没有解或有无限多解)。
这种情况在机械系统中很常见，例如，u = desiredSpeed - measuredSpeed，由于速度既是状态变量又是导数，将其初始化为零是自然的。
然而，如此设置并不可行。解决方案是不要通过代数方程初始化u或用于计算u的变量。
</p>

</html>"  ), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
      grid = {2, 2}), graphics = {Rectangle(origin = {3, 55}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-85, 41}, {85, -41}}), Text(origin = {45, 21}, 
      lineColor = {0, 0, 0}, 
      extent = {{-43, 7}, {43, -7}}, 
      textString = "参数模式k、Ti、Td、Nd", 
      textStyle = {TextStyle.None}, 
      textColor = {0, 0, 0}, 
      horizontalAlignment = LinePattern.None), Rectangle(origin = {3, -59}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-85, 41}, {85, -41}}), Text(origin = {50, -93}, 
      lineColor = {0, 0, 0}, 
      extent = {{-38, 7}, {38, -7}}, 
      textString = "参数模式P、I、D、N", 
      textStyle = {TextStyle.None}, 
      textColor = {0, 0, 0}, 
      horizontalAlignment = LinePattern.None)}));
  end PIDs;

  block LimPID 
    "P、PI、PD 和 PID 控制器，具有输出限制、抗饱和补偿器、设定点加权和可选的前馈"
    import Modelica.Blocks.Types.Init;
    import Modelica.Blocks.Types.SimpleController;
    extends Modelica.Blocks.Interfaces.SVcontrol;
    output Real controlError = u_s - u_m 
      "控制误差(也叫设定点误差或偏差)";
    parameter .Modelica.Blocks.Types.SimpleController controllerType = 
      .Modelica.Blocks.Types.SimpleController.PID "控制模块类型";
    parameter Real k(min = 0, unit = "1") = 1 "控制模块增益";
    parameter SI.Time Ti(min = Modelica.Constants.small) = 0.5 
      "积分模块的时间常数" annotation(Dialog(enable = 
      controllerType == .Modelica.Blocks.Types.SimpleController.PI or 
      controllerType == .Modelica.Blocks.Types.SimpleController.PID));
    parameter SI.Time Td(min = 0) = 0.1 
      "导数模块的时间常数" annotation(Dialog(enable = 
      controllerType == .Modelica.Blocks.Types.SimpleController.PD or 
      controllerType == .Modelica.Blocks.Types.SimpleController.PID));
    parameter Real yMax(start = 1) "输出上限";
    parameter Real yMin = -yMax "输出下限";
    parameter Real wp(min = 0) = 1 
      "比例模块设定点权重(0..1)";
    parameter Real wd(min = 0) = 0 "导数模块的设定点权重(0..1)" 
      annotation(Dialog(enable = controllerType == .Modelica.Blocks.Types.SimpleController.PD or 
      controllerType == .Modelica.Blocks.Types.SimpleController.PID));
    parameter Real Ni(min = 100 * Modelica.Constants.eps) = 0.9 
      "Ni*Ti为抗缠绕补偿的时间常数" 
      annotation(Dialog(enable = controllerType == .Modelica.Blocks.Types.SimpleController.PI or 
      controllerType == .Modelica.Blocks.Types.SimpleController.PID));
    parameter Real Nd(min = 100 * Modelica.Constants.eps) = 10 
      "Nd越高，导数模块越理想" 
      annotation(Dialog(enable = controllerType == .Modelica.Blocks.Types.SimpleController.PD or 
      controllerType == .Modelica.Blocks.Types.SimpleController.PID));
    parameter Boolean withFeedForward = false "使用前馈输入?" 
      annotation(Evaluate = true, choices(checkBox = true));
    parameter Real kFF = 1 "前馈输入的增益" 
      annotation(Dialog(enable = withFeedForward));
    parameter Init initType = Init.InitialState 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, Dialog(group = "初始化"));
    parameter Real xi_start = 0 
      "积分模块输出的初始值或猜测值(=积分模块状态)" 
      annotation(Dialog(group = "初始化", 
      enable = controllerType == .Modelica.Blocks.Types.SimpleController.PI or 
      controllerType == .Modelica.Blocks.Types.SimpleController.PID));
    parameter Real xd_start = 0 
      "导数模块状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化", 
      enable = controllerType == .Modelica.Blocks.Types.SimpleController.PD or 
      controllerType == Modelica.Blocks.Types.SimpleController.PID));
    parameter Real y_start = 0 "初始化输出值" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));
    parameter Modelica.Blocks.Types.LimiterHomotopy homotopyType = Modelica.Blocks.Types.LimiterHomotopy.Linear 
      "基于同伦初始化的简化" 
      annotation(Evaluate = true, Dialog(group = "初始化"));
    parameter Boolean strict = false "=true，当严格限制noEvent(..)时" 
      annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "高级"));
    constant SI.Time unitTime = 1 annotation(HideResult = true);
    Modelica.Blocks.Interfaces.RealInput u_ff if withFeedForward 
      "可供选择的前馈输入信号连接模块" 
      annotation(Placement(
      transformation(
      origin = {60, -120}, 
      extent = {{20, -20}, {-20, 20}}, 
      rotation = 270)));
    Modelica.Blocks.Math.Add addP(k1 = wp, k2 = -1) 
      annotation(Placement(transformation(extent = {{-80, 40}, {-60, 60}})));
    Modelica.Blocks.Math.Add addD(k1 = wd, k2 = -1) if with_D 
      annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
    Modelica.Blocks.Math.Gain P(k = 1) 
      annotation(Placement(transformation(extent = {{-50, 40}, {-30, 60}})));
    Modelica.Blocks.Continuous.Integrator I(
      k = unitTime / Ti, 
      y_start = xi_start, 
      initType = if initType == Init.SteadyState then Init.SteadyState else if 
      initType == Init.InitialState 
      then Init.InitialState else Init.NoInit) if with_I 
      annotation(Placement(transformation(extent = {{-50, -60}, {-30, -40}})));
    Modelica.Blocks.Continuous.Derivative D(
      k = Td / unitTime, 
      T = max([Td / Nd, 1.e-14]), 
      x_start = xd_start, 
      initType = if initType == Init.SteadyState or initType == Init.InitialOutput 
      then Init.SteadyState else if initType == Init.InitialState then 
      Init.InitialState else Init.NoInit) if with_D 
      annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
    Modelica.Blocks.Math.Gain gainPID(k = k) 
      annotation(Placement(transformation(extent = {{20, -10}, {40, 10}})));
    Modelica.Blocks.Math.Add3 addPID 
      annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
    Modelica.Blocks.Math.Add3 addI(k2 = -1) if with_I 
      annotation(Placement(transformation(extent = {{-80, -60}, {-60, -40}})));
    Modelica.Blocks.Math.Add addSat(k1 = +1, k2 = -1) if with_I annotation(Placement(
      transformation(
      origin = {80, -50}, 
      extent = {{-10, -10}, {10, 10}}, 
      rotation = 270)));
    Modelica.Blocks.Math.Gain gainTrack(k = 1 / (k * Ni)) if with_I 
      annotation(Placement(transformation(extent = {{0, -80}, {-20, -60}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(
      uMax = yMax, 
      uMin = yMin, 
      strict = strict, 
      homotopyType = homotopyType) 
      annotation(Placement(transformation(extent = {{70, -10}, {90, 10}})));
  protected
    parameter Boolean with_I = controllerType == SimpleController.PI or 
      controllerType == SimpleController.PID annotation(Evaluate = true, HideResult = true);
    parameter Boolean with_D = controllerType == SimpleController.PD or 
      controllerType == SimpleController.PID annotation(Evaluate = true, HideResult = true);
  public
    Modelica.Blocks.Sources.Constant Dzero(k = 0) if not with_D 
      annotation(Placement(transformation(extent = {{-40, 20}, {-30, 30}})));
    Modelica.Blocks.Sources.Constant Izero(k = 0) if not with_I 
      annotation(Placement(transformation(extent = {{0, -55}, {-10, -45}})));
    Modelica.Blocks.Sources.Constant FFzero(k = 0) if not withFeedForward 
      annotation(Placement(transformation(extent = {{30, -35}, {40, -25}})));
    Modelica.Blocks.Math.Add addFF(k1 = 1, k2 = kFF) 
      annotation(Placement(transformation(extent = {{48, -6}, {60, 6}})));
  initial equation
    if initType == Init.InitialOutput then
      gainPID.y = y_start;
    end if;
  equation
    if initType == Init.InitialOutput and (y_start < yMin or y_start > yMax) then
      Modelica.Utilities.Streams.error("LimPID：初值y_start (=" + String(y_start) + 
        ")是外层yMin(=" + String(yMin) + ")值和外层yMax(=" + String(yMax) + ")值的极限值");
    end if;

    connect(u_s, addP.u1) annotation(Line(points = {{-120, 0}, {-96, 0}, {-96, 56}, {
      -82, 56}}, color = {0, 0, 127}));
    connect(u_s, addD.u1) annotation(Line(points = {{-120, 0}, {-96, 0}, {-96, 6}, {
      -82, 6}}, color = {0, 0, 127}));
    connect(u_s, addI.u1) annotation(Line(points = {{-120, 0}, {-96, 0}, {-96, -42}, {
      -82, -42}}, color = {0, 0, 127}));
    connect(addP.y, P.u) annotation(Line(points = {{-59, 50}, {-52, 50}}, color = {0, 
      0, 127}));
    connect(addD.y, D.u) 
      annotation(Line(points = {{-59, 0}, {-52, 0}}, color = {0, 0, 127}));
    connect(addI.y, I.u) annotation(Line(points = {{-59, -50}, {-52, -50}}, color = {
      0, 0, 127}));
    connect(P.y, addPID.u1) annotation(Line(points = {{-29, 50}, {-20, 50}, {-20, 8}, {-12, 
      8}}, color = {0, 0, 127}));
    connect(D.y, addPID.u2) 
      annotation(Line(points = {{-29, 0}, {-12, 0}}, color = {0, 0, 127}));
    connect(I.y, addPID.u3) annotation(Line(points = {{-29, -50}, {-20, -50}, {-20, -8}, 
      {-12, -8}}, color = {0, 0, 127}));
    connect(limiter.y, addSat.u1) annotation(Line(points = {{91, 0}, {94, 0}, {94, 
      -20}, {86, -20}, {86, -38}}, color = {0, 0, 127}));
    connect(limiter.y, y) 
      annotation(Line(points = {{91, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(addSat.y, gainTrack.u) annotation(Line(points = {{80, -61}, {80, -70}, {2, -70}}, 
      color = {0, 0, 127}));
    connect(gainTrack.y, addI.u3) annotation(Line(points = {{-21, -70}, {-88, -70}, {-88, 
      -58}, {-82, -58}}, color = {0, 0, 127}));
    connect(u_m, addP.u2) annotation(Line(points = {{0, -120}, {0, -92}, {-92, -92}, {-92, 44}, {-82, 44}}, color = {0, 0, 127}));
    connect(u_m, addD.u2) annotation(Line(points = {{0, -120}, {0, -92}, {-92, -92}, {-92, -6}, {-82, -6}}, color = {0, 0, 127}));
    connect(u_m, addI.u2) annotation(Line(points = {{0, -120}, {0, -92}, {-92, -92}, {-92, -50}, {-82, -50}}, color = {0, 0, 127}));
    connect(Dzero.y, addPID.u2) annotation(Line(points = {{-29.5, 25}, {-24, 25}, {-24, 
      0}, {-12, 0}}, color = {0, 0, 127}));
    connect(Izero.y, addPID.u3) annotation(Line(points = {{-10.5, -50}, {-20, -50}, {-20, 
      -8}, {-12, -8}}, color = {0, 0, 127}));
    connect(addPID.y, gainPID.u) 
      annotation(Line(points = {{11, 0}, {18, 0}}, color = {0, 0, 127}));
    connect(addFF.y, limiter.u) 
      annotation(Line(points = {{60.6, 0}, {68, 0}}, color = {0, 0, 127}));
    connect(gainPID.y, addFF.u1) annotation(Line(points = {{41, 0}, {44, 0}, {44, 3.6}, 
      {46.8, 3.6}}, color = {0, 0, 127}));
    connect(FFzero.y, addFF.u2) annotation(Line(points = {{40.5, -30}, {44, -30}, {44, 
      -3.6}, {46.8, -3.6}}, 
      color = {0, 0, 127}));
    connect(addFF.u2, u_ff) annotation(Line(points = {{46.8, -3.6}, {44, -3.6}, {44, 
      -92}, {60, -92}, {60, -120}}, 
      color = {0, 0, 127}));
    connect(addFF.y, addSat.u2) annotation(Line(points = {{60.6, 0}, {64, 0}, {64, -20}, 
      {74, -20}, {74, -38}}, color = {0, 0, 127}));
    annotation(defaultComponentName = "PID", 
      Icon(coordinateSystem(
      preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), graphics = {
      Line(points = {{-80, 78}, {-80, -90}}, color = {192, 192, 192}), 
      Polygon(
      points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-90, -80}, {82, -80}}, color = {192, 192, 192}), 
      Polygon(
      points = {{90, -80}, {68, -72}, {68, -88}, {90, -80}}, 
      lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid), 
      Line(points = {{-80, -80}, {-80, -20}, {30, 60}, {80, 60}}, color = {0, 0, 127}), 
      Text(
      extent = {{-20, -20}, {80, -60}}, 
      textColor = {192, 192, 192}, 
      textString = "%controllerType"), 
      Line(
      visible = strict, 
      points = {{30, 60}, {81, 60}}, 
      color = {255, 0, 0})}), 
      Diagram(graphics = {Text(
      extent = {{79, -112}, {129, -102}}, 
      textColor = {0, 0, 255}, 
      textString = " (feed-forward)")}), 
      Documentation(info="<html><p>
通过参数<strong>controllerType</strong>任意选择<strong>P</strong>， <strong>PI</strong>，<strong>PD</strong>，或<strong>PID</strong>。 例如，如果选择PI， 则属于D部分的所有组件都将从块中移除(通过条件声明)。 <a href=\"modelica://Modelica.Blocks.Examples.PID_Controller\" target=\"\">Modelica.Blocks.Examples.PID_Controller</a> 示例演示了此控制模块的用法。 并依据以下文献第三章， 描述了PID控制模块设计的几个实际方面：
</p>
<p>
Åström K.J., and Hägglund T.:
</p>
<p>
<strong>PID Controllers: Theory, Design, and Tuning</strong>.<br>Instrument Society of America, 2nd edition, 1995.<br>
</p>
<p>
除了添加<strong>比例、积分</strong>和<strong>导数</strong>以外， 部分控制模块有以下特点:
</p>
<ul><li>
此控制模块输出受限。 如果控制模块处于其极限， 则激活反绕组补偿以驱动积分模块状态为零。</li>
<li>
为了避免测量噪声过度放大， 对导数部分的高频增益进行了限制。</li>
<li>
存在加权设定值， 它允许在比例和导数部分独立于测量的加权设定值。 控制模块会响应加载独立于此设置的干扰和测量噪声 (参数wp, wd)。 但是，设定值的更改将依附于此设置。 例如，如果设定值信号出现在步长信号中， 则将导数部分的设定值权重wd设置为零是有用的。</li>
<li>
可选的前馈。可以添加前馈信号， 要在限制前加入前馈信号。</li>
</ul><p>
控制模块的参数可以通过执行手动命令调整仿真闭环系统 (=控制模块+设备连接在一起) 可以采用以下策略进行：
</p>
<ol><li>
设置一个极限最大值，e.g.,yMax=Modelica.Constants.inf</li>
<li>
选择一个<strong>P</strong>-控制模块， 手动放大参数<strong>k</strong>(控制模块的总增益)， 直到闭环响应无法再被优化。</li>
<li>
选择一个<strong>PI</strong>控制模块， 手动调整参数<strong>k</strong>和<strong>Ti</strong>(积分模块的时间常数)。 Ti的初值可供选择， 使其与p-控制模块发生的振荡的时间常数的顺序一致。 例如，如果在上一步中出现T=10毫秒的振动， 则从Ti=0.01秒开始。</li>
<li>
如果你想让控制回路的反应更快 (但可能对干扰和测量噪声的鲁棒性较低) 选择一个<strong>PID</strong>-控制模块， 手动调整参数<strong>k</strong>，<strong>Ti</strong>，<strong>Td</strong>(导数模块的时间常数)。</li>
<li>
根据您的规格设置来限制yMax和yMin的大小。</li>
<li>
执行模拟，使PID控制模块的输出达到其极限。 调整<strong>Ni</strong>(Ni*Ti是抗绕组补偿的时间常数)， 使限制模块(=limitter.u)的输入足够快地回到其极限。 如果Ni减小，这发生得更快。 如果Ni=无穷大， 则关闭反绕组补偿，控制模块工作不良。</li>
</ol><p>
<strong>初始化</strong>
</p>
<p>
本模块可以用不同的方式初始化 <strong>initType</strong>参数控制的方式。 可能的initType可以在 <a href=\"modelica://Modelica.Blocks.Types.Init\" target=\"\">Modelica.Blocks.Types.Init</a>中定义。
</p>
<p>
根据initType的设置， PID控制模块内部的积分模块(I)和导数模块(D)按下表初始化：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>initType</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>I.initType</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>D.initType</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>NoInit</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">NoInit</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">NoInit</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>SteadyState</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyState</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyState</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>InitialState</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">InitialState</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">InitialState</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>InitialOutput</strong><br><br>and initial equation: y = y_start</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">NoInit</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">SteadyState</td></tr></tbody></table><p>
在许多情况下，最有用的初始化条件是<strong>稳态条件初始化</strong>， 因为此时初始瞬态不再存在。 如果initType=Init.SteadyState， 那么在某些情况下可能会出现困难。 原因在于积分模块方程:
</p>
<pre><code >der(y) = k*u;</code></pre><p>
稳态方程“der(x)=0”使得积分模块的输入值u为零。 如果输入u已经(直接或间接)由另一个初始条件定义， 则初始化问题是<strong>奇异</strong>(无解或无穷多个解)。 这种情况经常发生在机械系统中， 例如，u=期望速度-测量速度， 由于速度既是状态又是导数， 因此将其初始化为零是很自然的。 然而，正如草图所示，这是不可能的。 解决方案是不初始化u_m或通过代数方程计算u_m的变量。
</p>
<p>
当处于初始状态初始化时， 基于同伦的初始化通过在求解过程开始时使用简化的模型来帮助求解器收敛。有不同的选项可用。
</p>
<ul><li>
<strong>homotopyType=线性(默认)</strong>：简化模型消除了限制，使其成为线性模型。 如果您知道控制模块在稳定状态下不会饱和，则使用此方法。</li>
<li>
<strong>homotopyType=上限</strong>: 如果事先已知控制器将被卡在最大限制值yMax， 这个选项假设y=yMax作为一个简化的模型。</li>
<li>
<strong>homotopyType=下限</strong>: 如果事先已知控制器将被卡在最小限制值yMin， 这个选项假设y=yMin作为一个简化的模型。</li>
<li>
<strong>homotopyType=非线性</strong>: 这个选项没有进行任何简化， 并在整个同态变换过程中保持限制模块处于激活状态。 如果在初始化时无法确定控制模块是否已经被饱和， 并且需要在整个同态变换过程中强制执行输出限制，请使用这个选项。</li>
</ul></html>"    ));
  end LimPID;

  block TransferFunction "线性传递函数"
    import Modelica.Blocks.Types.Init;
    extends Interfaces.SISO;

    parameter Real b[:] = {1} 
      "传递函数的分子系数(比如，2*s+3写为{2,3})";
    parameter Real a[:] = {1} 
      "传递函数的分母系数(比如，5*s+6写为{5,6})";
    parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, Dialog(group = 
      "初始化"));
    parameter Real x_start[size(a, 1) - 1] = zeros(nx) 
      "状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0 
      "输出的初始值(y的导数为0到nx-1阶导数)" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));
    output Real x[size(a, 1) - 1](start = x_start) 
      "依据控制模块规范形式的传递函数状态";
  protected
    parameter Integer na = size(a, 1) "传递函数分母大小";
    parameter Integer nb = size(b, 1) "传递函数分子大小";
    parameter Integer nx = size(a, 1) - 1;
    parameter Real bb[:] = vector([zeros(max(0, na - nb), 1); b]);
    parameter Real d = bb[1] / a[1];
    parameter Real a_end = if a[end] > 100 * Modelica.Constants.eps * sqrt(a * a) then a[end] else 1.0;
    Real x_scaled[size(x, 1)] "缩放向量x";

  initial equation
    if initType == Init.SteadyState then
      der(x_scaled) = zeros(nx);
    elseif initType == Init.InitialState then
      x_scaled = x_start * a_end;
    elseif initType == Init.InitialOutput then
      y = y_start;
      der(x_scaled[2:nx]) = zeros(nx - 1);
    end if;
  equation
    assert(size(b, 1) <= size(a, 1), "传递函数选取不合适");
    if nx == 0 then
      y = d * u;
    else
      der(x_scaled[1]) = (-a[2:na] * x_scaled + a_end * u) / a[1];
      der(x_scaled[2:nx]) = x_scaled[1:nx - 1];
      y = ((bb[2:na] - d * a[2:na]) * x_scaled) / a_end + d * u;
      x = x_scaled / a_end;
    end if;
    annotation(
      Documentation(info="<html><p>
这个模块定义输入u和输出y之间的传递函数为(nb = b的维数，na = a的维数)：
</p>
<blockquote><pre>
        b[1]*s^[nb-1] + b[2]*s^[nb-2] + ... + b[nb]
y(s) = --------------------------------------------- * u(s)
        a[1]*s^[na-1] + a[2]*s^[na-2] + ... + a[na]
</pre></blockquote>
<p>
状态变量<strong>x</strong>是根据<strong>控制器正则</strong>形式定义的。
在内部，向量<strong>x</strong>被缩放以提高数值计算的精度(在Modelica标准库版本3.0之前的版本中，<strong>x</strong>未被缩放)。
这种缩放对于该模块的外部是不可见的，因为作为输出信号提供的是未缩放的向量<strong>x</strong>，
并且起始值是相对于未缩放的向量<strong>x</strong>而言的。
可以通过<strong>x_start</strong>参数来设置状态变量<strong>x</strong>的初始值。
</p>
<p>
示例：
</p>
<blockquote><pre>
TransferFunction g(b = {2,4}, a = {1,3});
</pre></blockquote>
<p>
得到传递函数如下：
</p>
<blockquote><pre>
     2*s + 4
y = --------- * u
      s + 3
</pre></blockquote>
</html>"  ), 
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 0.0}, {80.0, 0.0}}, 
      color = {0, 0, 127}), 
      Text(textColor = {0, 0, 127}, 
      extent = {{-90.0, 10.0}, {90.0, 90.0}}, 
      textString = "b(s)"), 
      Text(textColor = {0, 0, 127}, 
      extent = {{-90.0, -90.0}, {90.0, -10.0}}, 
      textString = "a(s)")}));
  end TransferFunction;
  block StateSpaceAlg "线性状态空间系统算法版本"
    import Modelica.Blocks.Types.Init;
    parameter Real A[:,size(A, 1)] = [1, 0; 0, 1] 
      "状态空间模型的矩阵 A (例如，A=[1, 0; 0, 1])";
    parameter Real B[size(A, 1),:] = [1; 1] 
      "状态空间模型的矩阵 B (例如，B=[1; 1])";
    parameter Real C[:,size(A, 1)] = [1, 1] 
      "状态空间模型的矩阵 C (例如，C=[1, 1])";
    parameter Real D[size(C, 1),size(B, 2)] = zeros(size(C, 1), size(B, 2)) 
      "状态空间模型的矩阵 D";
    parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit 
      "初始化类型 (1: 无初始化, 2: 稳态, 3: 初始状态, 4: 初始输出)" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real x_start[nx] = zeros(nx) "状态的初始或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start[ny] = zeros(ny) 
      "输出的初始值（如果可能，剩余状态处于稳态）" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));
    extends Modelica.Blocks.Interfaces.MIMO(final nin = size(B, 2), final nout = size(C, 1));
    output Real x[size(A, 1)](start = x_start) "状态向量";

  protected
    parameter Integer nx = size(A, 1) "状态数量";
    parameter Integer ny = size(C, 1) "输出数量";
  initial equation
    if initType == Init.SteadyState then
      der(x) = zeros(nx);
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      x = Modelica.Math.Matrices.equalityLeastSquares(A, -Internal.Filter.Utilities.AxFn(B, u), C, y_start - Internal.Filter.Utilities.AxFn(D, u));
    end if;
  equation
    der(x) = Internal.Filter.Utilities.AxFn(A, x) + Internal.Filter.Utilities.AxFn(B, u);
    y = Internal.Filter.Utilities.AxFn(C, x) + Internal.Filter.Utilities.AxFn(D, u);
    annotation(
      Documentation(info = "<html>
<p>
<b>注意</b>: 由于浮点数不是结合的， 
与 Modelica.Blocks.Continuous.StateSpace 相比，
数值结果存在微小差异。

而这个版本应该更准确。
</p>
<p>
状态空间模块定义了
输入 u 和输出
y 之间的关系
以状态空间的形式表示：
</p>
<blockquote><pre>
der(x) = A * x + B * u
y  = C * x + D * u
</pre></blockquote>
<p>
输入是长度为 nu 的向量，输出是长度为 ny 的向量，nx 是状态的数量。因此
</p>
<blockquote><pre>
A 的维度为: A(nx,nx),
B 的维度为: B(nx,nu),
C 的维度为: C(ny,nx),
D 的维度为: D(ny,nu)
</pre></blockquote>
<p>
示例：
</p>
<blockquote><pre>
parameter: A = [0.12, 2;3, 1.5]
parameter: B = [2, 7;3, 1]
parameter: C = [0.1, 2]
parameter: D = zeros(ny,nu)

将产生以下方程：
[der(x[1])]   [0.12  2.00] [x[1]]   [2.0  7.0] [u[1]]
[         ] = [          ]*[    ] + [        ]*[    ]
[der(x[2])]   [3.00  1.50] [x[2]]   [0.1  2.0] [u[2]]
                       [x[1]]            [u[1]]
 y[1]   = [0.1  2.0] * [    ] + [0  0] * [    ]
                       [x[2]]            [u[2]]
</pre></blockquote>
</html>"    ), Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Text(extent = {{-90, 10}, {-10, 90}}, 
      textString = "A", 
      textColor = {0, 0, 127}), 
      Text(extent = {{10, 10}, {90, 90}}, 
      textString = "B", 
      textColor = {0, 0, 127}), 
      Text(extent = {{-90, -10}, {-10, -90}}, 
      textString = "C", 
      textColor = {0, 0, 127}), 
      Text(extent = {{10, -10}, {90, -90}}, 
      textString = "D", 
      textColor = {0, 0, 127}), 
      Line(points = {{0, -90}, {0, 90}}, 
      color = {192, 192, 192}), 
      Line(points = {{-90, 0}, {90, 0}}, 
      color = {192, 192, 192})}));
  end StateSpaceAlg;
  block TransferFunctionDia "线性传递函数，动态图标显示"
    import Modelica.Blocks.Types.Init;
    extends Interfaces.SISO;

    parameter Real b[:] = {1} 
      "传递函数的分子系数(比如，2*s+3写为{2,3})";
    parameter Real a[:] = {1} 
      "传递函数的分母系数(比如，5*s+6写为{5,6})";
    parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, Dialog(group = 
      "初始化"));
    parameter Real x_start[size(a, 1) - 1] = zeros(nx) 
      "状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0 
      "输出的初始值(y的导数为0到nx-1阶导数)" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));
    output Real x[size(a, 1) - 1](start = x_start) 
      "依据控制模块规范形式的传递函数状态";
  protected
    parameter Integer na = size(a, 1) "传递函数分母大小";
    parameter Integer nb = size(b, 1) "传递函数分子大小";
    parameter Integer nx = size(a, 1) - 1;
    parameter Real bb[:] = vector([zeros(max(0, na - nb), 1); b]);
    parameter Real d = bb[1] / a[1];
    parameter Real a_end = if a[end] > 100 * Modelica.Constants.eps * sqrt(a * a) then a[end] else 1.0;
    Real x_scaled[size(x, 1)] "缩放向量x";

  initial equation
    if initType == Init.SteadyState then
      der(x_scaled) = zeros(nx);
    elseif initType == Init.InitialState then
      x_scaled = x_start * a_end;
    elseif initType == Init.InitialOutput then
      y = y_start;
      der(x_scaled[2:nx]) = zeros(nx - 1);
    end if;
  equation
    assert(size(b, 1) <= size(a, 1), "传递函数选取不合适");
    if nx == 0 then
      y = d * u;
    else
      der(x_scaled[1]) = (-a[2:na] * x_scaled + a_end * u) / a[1];
      der(x_scaled[2:nx]) = x_scaled[1:nx - 1];
      y = ((bb[2:na] - d * a[2:na]) * x_scaled) / a_end + d * u;
      x = x_scaled / a_end;
    end if;
    annotation(Documentation(info = "<html><p>
这个模块定义输入u和输出y之间的传递函数为(nb = b的维数，na = a的维数)：
</p>
<blockquote><pre>
        b[1]*s^[nb-1] + b[2]*s^[nb-2] + ... + b[nb]
y(s) = --------------------------------------------- * u(s)
        a[1]*s^[na-1] + a[2]*s^[na-2] + ... + a[na]
</pre></blockquote>
<p>
状态变量<strong>x</strong>是根据<strong>控制器正则</strong>形式定义的。
在内部，向量<strong>x</strong>被缩放以提高数值计算的精度(在Modelica标准库版本3.0之前的版本中，<strong>x</strong>未被缩放)。
这种缩放对于该模块的外部是不可见的，因为作为输出信号提供的是未缩放的向量<strong>x</strong>，
并且起始值是相对于未缩放的向量<strong>x</strong>而言的。
可以通过<strong>x_start</strong>参数来设置状态变量<strong>x</strong>的初始值。
</p>
<p>
示例：
</p>
<blockquote><pre>
TransferFunction g(b = {2,4}, a = {1,3});
</pre></blockquote>
<p>
得到传递函数如下：
</p>
<blockquote><pre>
     2*s + 4
y = --------- * u
      s + 3
</pre></blockquote>
</html>"  ), 
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
      grid = {2, 2}), graphics = {Line(origin = {0, 0}, 
      points = {{-80, 0}, {80, 0}}, 
      color = {0, 0, 127}), Text(origin = {0, 30}, 
      lineColor = {0, 0, 127}, 
      extent = {{-90, -20}, {90, 20}}, 
      textString = "%{b(polynomial)}", 
      textStyle = {TextStyle.None}, 
      textColor = {0, 0, 127}), Text(origin = {0, -30}, 
      lineColor = {0, 0, 127}, 
      extent = {{-90, -20}, {90, 20}}, 
      textString = "%{a(polynomial)}", 
      textStyle = {TextStyle.None}, 
      textColor = {0, 0, 127})}), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, 
      grid = {2, 2})) );
  end TransferFunctionDia;

  block StateSpace "线性状态空间系统"
    import Modelica.Blocks.Types.Init;
    parameter Real A[:,size(A, 1)] = [1, 0; 0, 1] 
      "状态空间模型的矩阵A(比如，A=[1,0;0,1])";
    parameter Real B[size(A, 1),:] = [1; 1] 
      "状态空间模型的矩阵B(比如，B=[1;1])";
    parameter Real C[:,size(A, 1)] = [1, 1] 
      "状态空间模型的矩阵C(比如，C=[1,1])";
    parameter Real D[size(C, 1),size(B, 2)] = zeros(size(C, 1), size(B, 2)) 
      "状态空间模型的矩阵D";
    parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real x_start[nx] = zeros(nx) "状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start[ny] = zeros(ny) 
      "输出的初始值(剩余状态尽可能保持稳定)" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));

    extends Interfaces.MIMO(final nin = size(B, 2), final nout = size(C, 1));
    output Real x[size(A, 1)](start = x_start) "状态向量";

  protected
    parameter Integer nx = size(A, 1) "状态数";
    parameter Integer ny = size(C, 1) "输出数";
  initial equation
    if initType == Init.SteadyState then
      der(x) = zeros(nx);
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      x = Modelica.Math.Matrices.equalityLeastSquares(A, -B * u, C, y_start - D * u);
    end if;
  equation
    der(x) = A * x + B * u;
    y = C * x + D * u;
    annotation(
      Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51); background-color: rgb(245, 246, 248);\">状态空间模块定义了输入 u 和输出 y 之间的状态空间形式的关系</span>:
</p>
<pre><code >der(x) = A * x + B * u
y  = C * x + D * u</code></pre><p>
输入值是一个长度为nu的向量，输出值是一个长度为ny的向量， 而nx是状态的数量。因此
</p>
<pre><code >A has the dimension: A(nx,nx),
B has the dimension: B(nx,nu),
C has the dimension: C(ny,nx),
D has the dimension: D(ny,nu)</code></pre><p>
示例:
</p>
<pre><code >parameter: A = [0.12, 2;3, 1.5]
parameter: B = [2, 7;3, 1]
parameter: C = [0.1, 2]
parameter: D = zeros(ny,nu)

results in the following equations:
[der(x[1])]   [0.12  2.00] [x[1]]   [2.0  7.0] [u[1]]
[         ] = [          ]*[    ] + [        ]*[    ]
[der(x[2])]   [3.00  1.50] [x[2]]   [0.1  2.0] [u[2]]
[x[1]]            [u[1]]
y[1]   = [0.1  2.0] * [    ] + [0  0] * [    ]
[x[2]]            [u[2]]</code></pre><p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"), Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100, -100}, {100, 100}}), 
      graphics = {
      Text(extent = {{-90, 10}, {-10, 90}}, 
      textString = "A", 
      textColor = {0, 0, 127}), 
      Text(extent = {{10, 10}, {90, 90}}, 
      textString = "B", 
      textColor = {0, 0, 127}), 
      Text(extent = {{-90, -10}, {-10, -90}}, 
      textString = "C", 
      textColor = {0, 0, 127}), 
      Text(extent = {{10, -10}, {90, -90}}, 
      textString = "D", 
      textColor = {0, 0, 127}), 
      Line(points = {{0, -90}, {0, 90}}, 
      color = {192, 192, 192}), 
      Line(points = {{-90, 0}, {90, 0}}, 
      color = {192, 192, 192})}));
  end StateSpace;

  block Der "输入的导数(=解析微分)"
    extends Interfaces.SISO;

  equation
    y = der(u);
    annotation(defaultComponentName = "der1", 
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), 
      graphics = {Text(
      extent = {{-96, 28}, {94, -24}}, 
      textString = "der()", 
      textColor = {0, 0, 127})}), 
      Documentation(info = "<html>
<p>
定义输出值y是输入值u的导数。
注意，Modelica.Blocks.Continuous.Derivative模块以近似的方式计算导数，
而本模块则精确地计算导数。
这就要求如果模型中尚未包含u的导数，
Modelica翻译器必须对输入值u进行求导。
如果模型中没有预先计算好的u的导数，本模块需要在编译时由翻译器处理。
</p>
</html>"));
  end Der;

  block LowpassButterworth 
    "输出通过任意阶低通Butterworth滤波器滤波的输入信号"

    import Modelica.Blocks.Types.Init;
    import Modelica.Constants.pi;

    extends Modelica.Blocks.Interfaces.SISO;

    parameter Integer n(min = 1) = 2 "滤波器阶数";
    parameter SI.Frequency f(start = 1) "截止频率";
    parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real x1_start[m] = zeros(m) 
      "状态1的初始值或猜测值(der(x1)=x2)" 
      annotation(Dialog(group = "初始化"));
    parameter Real x2_start[m] = zeros(m) "状态2的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real xr_start = 0.0 
      "奇数阶低通Butterworth滤波器的实数极点的初始值或猜测值，否则为空值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0.0 
      "输出的初始值是可能稳态下的状态值。)" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));

    output Real x1[m](start = x1_start) 
      "二阶滤波器的状态1(der(x1) = x2)";
    output Real x2[m](start = x2_start) "二阶滤波器的状态2";
    output Real xr(start = xr_start) 
      "实数极点状态下的奇数阶，否则为空值";
  protected
    parameter Integer m = integer(n / 2);
    parameter Boolean evenOrder = 2 * m == n;
    parameter Real w = 2 * pi * f;
    Real z[m + 1];
    Real polereal[m];
    Real poleimag[m];
    Real realpol;
    Real k2[m];
    Real D[m];
    Real w0[m];
    Real k1;
    Real T;
  initial equation
    if initType == Init.SteadyState then
      der(x1) = zeros(m);
      der(x2) = zeros(m);
      if not evenOrder then
        der(xr) = 0.0;
      end if;
    elseif initType == Init.InitialState then
      x1 = x1_start;
      x2 = x2_start;
      if not evenOrder then
        xr = xr_start;
      end if;
    elseif initType == Init.InitialOutput then
      y = y_start;
      der(x1) = zeros(m);
      if evenOrder then
        if m > 1 then
          der(x2[1:m - 1]) = zeros(m - 1);
        end if;
      else
        der(x1) = zeros(m);
      end if;
    end if;
  equation
    k2 = ones(m);
    k1 = 1;
    z[1] = u;

    // 计算滤波器参数
    for i in 1:m loop
      // 原型低通的极点
      polereal[i] = Modelica.Math.cos(pi / 2 + pi / n * (i - 0.5));
      poleimag[i] = Modelica.Math.sin(pi / 2 + pi / n * (i - 0.5));
      // 二阶滤波器系数的缩放和计算
      w0[i] = (polereal[i] ^ 2 + poleimag[i] ^ 2) * w;
      D[i] = -polereal[i] / w0[i] * w;
    end for;
    realpol = 1 * w;
    T = 1 / realpol;

    // 计算二阶滤波器
    for i in 1:m loop
      der(x1[i]) = x2[i];
      der(x2[i]) = k2[i] * w0[i] ^ 2 * z[i] - 2 * D[i] * w0[i] * x2[i] - w0[i] ^ 2 * x1[i];
      z[i + 1] = x1[i];
    end for;

    // 必要时计算一阶滤波器
    if evenOrder then
      // 偶数阶
      xr = 0;
      y = z[m + 1];
    else
      // 非偶数阶
      der(xr) = (k1 * z[m + 1] - xr) / T;
      y = xr;
    end if;
    annotation(
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 78.0}, {-80.0, -90.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-79.5584, 91.817}, {-87.5584, 69.817}, {-71.5584, 69.817}, {-79.5584, 91.817}}), 
      Line(origin = {-1.939, -1.816}, 
      points = {{81.939, 36.056}, {65.362, 36.056}, {14.39, -26.199}, {-29.966, 113.485}, {-65.374, -61.217}, {-78.061, -78.184}}, 
      color = {0, 0, 127}, 
      smooth = Smooth.Bezier), 
      Line(points = {{-90.9779, -80.7697}, {81.0221, -80.7697}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{91.3375, -79.8233}, {69.3375, -71.8233}, {69.3375, -87.8233}, {91.3375, -79.8233}}), 
      Text(textColor = {192, 192, 192}, 
      extent = {{-45.1735, -68.0}, {92.0, -11.47}}, 
      textString = "LowpassButterworthFilter"), 
      Text(extent = {{8.0, -146.0}, {8.0, -106.0}}, 
      textString = "f=%f"), 
      Text(textColor = {192, 192, 192}, 
      extent = {{-2.0, 48.0}, {94.0, 94.0}}, 
      textString = "%n")}), 
      Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该模块定义了输入 u 和输出 y 之间的传递函数为具有巴特沃斯特性和截止频率 f 的 n 阶低通滤波器。它通过一系列二阶滤波器和一个一阶滤波器实现。巴特沃斯滤波器的特点是，在截止频率 f 处的幅度为 1/sqrt(2) (= 3 dB)，即它们始终是“归一化”的。不同阶数的巴特沃斯滤波器的阶跃响应如下一图所示：</span>
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/Butterworth.png\" alt=\"Butterworth.png\" data-href=\"\" style=\"\">
</p>
<p>
如果希望在模拟开始时避免瞬态响应， 滤波器应在稳态条件下初始化(例如，可以使用以下选项： initType=Modelica.Blocks.Types.Init.SteadyState)。
</p>
</html>"));
  end LowpassButterworth;

  block CriticalDamping  "输出经过n阶临界阻尼滤波器滤波的输入信号"
    import Modelica.Blocks.Types.Init;
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Integer n = 2 "滤波器阶数";
    parameter SI.Frequency f(start = 1) "截止频率";
    parameter Boolean normalized = true 
      "如果截止频率处的振幅为3dB，则输出true；否则输出未修改滤波器";
    parameter Modelica.Blocks.Types.Init initType = Modelica.Blocks.Types.Init.NoInit 
      "初始化类型(1：无初始化，2：稳态初始化，3：初始状态初始化，4：初始输出值初始化)" 
      annotation(Evaluate = true, 
      Dialog(group = "初始化"));
    parameter Real x_start[n] = zeros(n) "状态的初始值或猜测值" 
      annotation(Dialog(group = "初始化"));
    parameter Real y_start = 0.0 
      "输出初始值(其余状态为稳态)" 
      annotation(Dialog(enable = initType == Init.InitialOutput, group = 
      "初始化"));

    output Real x[n](start = x_start) "滤波器隐状态变量";
  protected
    parameter Real alpha = if normalized then sqrt(2 ^ (1 / n) - 1) else 1.0 
      "归一化滤波器的频率校正系数";
    parameter Real w = 2 * Modelica.Constants.pi * f / alpha;
  initial equation
    if initType == Init.SteadyState then
      der(x) = zeros(n);
    elseif initType == Init.InitialState then
      x = x_start;
    elseif initType == Init.InitialOutput then
      y = y_start;
      der(x[1:n - 1]) = zeros(n - 1);
    end if;
  equation
    der(x[1]) = (u - x[1]) * w;
    for i in 2:n loop
      der(x[i]) = (x[i - 1] - x[i]) * w;
    end for;
    y = x[n];
    annotation(
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.6897, 77.6256}, {-80.6897, -90.3744}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-79.7044, 90.6305}, {-87.7044, 68.6305}, {-71.7044, 68.6305}, {-79.7044, 90.6305}}), 
      Line(points = {{-90.0, -80.0}, {82.0, -80.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -80.0}, {68.0, -72.0}, {68.0, -88.0}, {90.0, -80.0}}), 
      Text(textColor = {192, 192, 192}, 
      extent = {{0.0, -60.0}, {60.0, 0.0}}, 
      textString = "PTn"), 
      Line(origin = {-17.976, -6.521}, 
      points = {{96.962, 55.158}, {16.42, 50.489}, {-18.988, 18.583}, {-32.024, -53.479}, {-62.024, -73.479}}, 
      color = {0, 0, 127}, 
      smooth = Smooth.Bezier), 
      Text(textColor = {192, 192, 192}, 
      extent = {{-70.0, 48.0}, {26.0, 94.0}}, 
      textString = "%n"), 
      Text(extent = {{8.0, -146.0}, {8.0, -106.0}}, 
      textString = "f=%f")}), 
      Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该模块定义了输入 u 和输出 y 之间的传递函数为具有临界阻尼特性和截止频率 f 的 n 阶滤波器。它通过一系列一阶滤波器实现。此滤波器类型特别适用于滤波逆模型的输入，因为该滤波器不会引入任何暂态响应。</span>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">如果参数 </span><span style=\"color: rgb(51, 51, 51);\"><strong>normalized =</strong></span><span style=\"color: rgb(51, 51, 51);\"> </span><span style=\"color: rgb(51, 51, 51);\"><strong>true</strong></span><span style=\"color: rgb(51, 51, 51);\">（默认值），则滤波器经过归一化处理，使得滤波器传递函数在截止频率 f 处的幅度为 1/sqrt(2) (= 3 dB)。否则，滤波器不进行归一化处理，即保持原样。归一化滤波器通常在应用中更为有效，因为不同阶数的滤波器可以“比较”，而非归一化滤波器通常在更改滤波器阶数时需要调整截止频率。下面显示了滤波器阶跃响应的图形。请注意，在 Modelica 标准库 3.0 版本之前，CriticalDamping 滤波器仅提供非归一化形式。</span>
</p>
<p>
当在模拟开始时应避免突变， 那么滤波器应该在稳定状态下初始化(例如，使用 initType=Modelica.Blocks.Types.Init.SteadyState).
</p>
<p>
临界阻尼滤波器定义为
</p>
<p>
<br>
</p>
<pre><code >α = if normalized then sqrt(2^(1/n) - 1) else 1 // frequency correction factor
ω = 2*π*f/α
        1
y = ------------- * u
   (s/w + 1)^n

</code></pre><p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/CriticalDampingNormalized.png\" alt=\"CriticalDampingNormalized.png\" data-href=\"\" style=\"\"/>
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/CriticalDampingNonNormalized.png\" alt=\"CriticalDampingNonNormalized.png\" data-href=\"\" style=\"\"/>
</p>
</html>"  ));
  end CriticalDamping;

  block Filter 
    "连续的低通、高通、带通或带阻IIR滤波器的类型是分别为临界阻尼、贝塞尔、巴特沃斯和切比雪夫"
    import Modelica.Blocks.Continuous.Internal;

    extends Modelica.Blocks.Interfaces.SISO;

    parameter Modelica.Blocks.Types.AnalogFilter analogFilter = Modelica.Blocks.Types.AnalogFilter.CriticalDamping 
      "模拟滤波器特性(临界阻尼/贝塞尔/巴特沃斯/切比雪夫)";
    parameter Modelica.Blocks.Types.FilterType filterType = Modelica.Blocks.Types.FilterType.LowPass 
      "滤波器类型(低通/高通/带通/带阻)";
    parameter Integer order(min = 1) = 2 "滤波器阶数";
    parameter SI.Frequency f_cut "截止频率";
    parameter Real gain = 1.0 
      "增益(=零频率响应的振幅)";
    parameter Real A_ripple(unit = "dB") = 0.5 
      "切比雪夫滤波器的通带波纹(否则不使用)；要求大于0" 
      annotation(Dialog(enable = analogFilter == Modelica.Blocks.Types.AnalogFilter.ChebyshevI));
    parameter SI.Frequency f_min = 0 
      "带通/带阻滤波器的频带范围是f_min(增益为-3dB)到f_cut(增益为-3dB)" 
      annotation(Dialog(enable = filterType == Modelica.Blocks.Types.FilterType.BandPass or 
      filterType == Modelica.Blocks.Types.FilterType.BandStop));
    parameter Boolean normalized = true 
      "如果在f_cut频率处的振幅为-3dB，则为true，否则保持滤波器不变";
    parameter Modelica.Blocks.Types.Init init = Modelica.Blocks.Types.Init.SteadyState 
      "初始化类型(无初始化/稳态初始化/初始状态初始化/初始输出值初始化)" 
      annotation(Evaluate = true, Dialog(tab = "高级"));
    final parameter Integer nx = if filterType == Modelica.Blocks.Types.FilterType.LowPass or 
      filterType == Modelica.Blocks.Types.FilterType.HighPass then 
      order else 2 * order;
    parameter Real x_start[nx] = zeros(nx) "状态的初始值或猜测值" 
      annotation(Dialog(tab = "高级"));
    parameter Real y_start = 0 "输出值初始化" 
      annotation(Dialog(tab = "高级"));
    parameter Real u_nominal = 1.0 
      "输入的标称值(用于缩放状态)" 
      annotation(Dialog(tab = "高级"));
    Modelica.Blocks.Interfaces.RealOutput x[nx] "滤波器状态";

  protected
    parameter Integer ncr = if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then 
      order else mod(order, 2);
    parameter Integer nc0 = if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then 
      0 else integer(order / 2);
    parameter Integer na = if filterType == Modelica.Blocks.Types.FilterType.BandPass or 
      filterType == Modelica.Blocks.Types.FilterType.BandStop then order else 
      if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then 
      0 else integer(order / 2);
    parameter Integer nr = if filterType == Modelica.Blocks.Types.FilterType.BandPass or 
      filterType == Modelica.Blocks.Types.FilterType.BandStop then 0 else 
      if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then 
      order else mod(order, 2);

    // 原型基滤波器系数(w_cut=1rad/s的低通滤波器)
    parameter Real cr[ncr](each fixed = false);
    parameter Real c0[nc0](each fixed = false);
    parameter Real c1[nc0](each fixed = false);

    // 微分方程的系数
    parameter Real r[nr](each fixed = false);
    parameter Real a[na](each fixed = false);
    parameter Real b[na](each fixed = false);
    parameter Real ku[na](each fixed = false);
    parameter Real k1[if filterType == Modelica.Blocks.Types.FilterType.LowPass then 0 else na](
      each fixed = false);
    parameter Real k2[if filterType == Modelica.Blocks.Types.FilterType.LowPass then 0 else na](
      each fixed = false);

    // 辅助变量
    Real uu[na + nr + 1];

  initial equation
    if analogFilter == Modelica.Blocks.Types.AnalogFilter.CriticalDamping then
      cr = Internal.Filter.base.CriticalDamping(order, normalized);
    elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.Bessel then
      (cr,c0,c1) = Internal.Filter.base.Bessel(order, normalized);
    elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.Butterworth then
      (cr,c0,c1) = Internal.Filter.base.Butterworth(order, normalized);
    elseif analogFilter == Modelica.Blocks.Types.AnalogFilter.ChebyshevI then
      (cr,c0,c1) = Internal.Filter.base.ChebyshevI(order, A_ripple, normalized);
    end if;

    if filterType == Modelica.Blocks.Types.FilterType.LowPass then
      (r,a,b,ku) = Internal.Filter.roots.lowPass(cr, c0, c1, f_cut);
    elseif filterType == Modelica.Blocks.Types.FilterType.HighPass then
      (r,a,b,ku,k1,k2) = Internal.Filter.roots.highPass(cr, c0, c1, f_cut);
    elseif filterType == Modelica.Blocks.Types.FilterType.BandPass then
      (a,b,ku,k1,k2) = Internal.Filter.roots.bandPass(cr, c0, c1, f_min, f_cut);
    elseif filterType == Modelica.Blocks.Types.FilterType.BandStop then
      (a,b,ku,k1,k2) = Internal.Filter.roots.bandStop(cr, c0, c1, f_min, f_cut);
    end if;

    if init == Modelica.Blocks.Types.Init.InitialState then
      x = x_start;
    elseif init == Modelica.Blocks.Types.Init.SteadyState then
      der(x) = zeros(nx);
    elseif init == Modelica.Blocks.Types.Init.InitialOutput then
      y = y_start;
      if nx > 1 then
        der(x[1:nx - 1]) = zeros(nx - 1);
      end if;
    end if;

  equation
    assert(u_nominal > 0, "要求u_nominal>0");
    assert(filterType == Modelica.Blocks.Types.FilterType.LowPass or 
      filterType == Modelica.Blocks.Types.FilterType.HighPass or 
      f_min > 0, "f_min > 0 required for band pass and band stop filter");
    assert(A_ripple > 0, "要求A_ripple>0");
    assert(f_cut > 0, "要求f_cut>0");

    /* 所有滤波器都有相同的基本微分方程:
    实数极点：
    der(x) = r*x - r*u
    复共轭极点：
    der(x1) = a*x1 - b*x2 + ku*u;
    der(x2) = b*x1 + a*x2;
    */
    uu[1] = u / u_nominal;
    for i in 1:nr loop
      der(x[i]) = r[i] * (x[i] - uu[i]);
    end for;
    for i in 1:na loop
      der(x[nr + 2 * i - 1]) = a[i] * x[nr + 2 * i - 1] - b[i] * x[nr + 2 * i] + ku[i] * uu[nr + i];
      der(x[nr + 2 * i]) = b[i] * x[nr + 2 * i - 1] + a[i] * x[nr + 2 * i];
    end for;

    // 对于不同的滤波器类型，输出方程是不同的
    if filterType == Modelica.Blocks.Types.FilterType.LowPass then
      /* 低通滤波器
      实数极点             ：  y = x
      复共轭极点：  y = x2
      */
      for i in 1:nr loop
        uu[i + 1] = x[i];
      end for;
      for i in 1:na loop
        uu[nr + i + 1] = x[nr + 2 * i];
      end for;

    elseif filterType == Modelica.Blocks.Types.FilterType.HighPass then
      /* 高通滤波器
      实数极点             ：  y = -x + u;
      复共轭极点：  y = k1*x1 + k2*x2 + u;
      */
      for i in 1:nr loop
        uu[i + 1] = -x[i] + uu[i];
      end for;
      for i in 1:na loop
        uu[nr + i + 1] = k1[i] * x[nr + 2 * i - 1] + k2[i] * x[nr + 2 * i] + uu[nr + i];
      end for;

    elseif filterType == Modelica.Blocks.Types.FilterType.BandPass then
      /* 带通滤波器
      复共轭极点：  y = k1*x1 + k2*x2;
      */
      for i in 1:na loop
        uu[nr + i + 1] = k1[i] * x[nr + 2 * i - 1] + k2[i] * x[nr + 2 * i];
      end for;

    elseif filterType == Modelica.Blocks.Types.FilterType.BandStop then
      /* 带通滤波器
      复共轭极点：  y = k1*x1 + k2*x2 + u;
      */
      for i in 1:na loop
        uu[nr + i + 1] = k1[i] * x[nr + 2 * i - 1] + k2[i] * x[nr + 2 * i] + uu[nr + i];
      end for;

    else
      assert(false, "滤波器类型(= " + String(filterType) + ")未知");
      uu = zeros(na + nr + 1);
    end if;

    y = (gain * u_nominal) * uu[nr + na + 1];

    annotation(
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Line(points = {{-80.0, 80.0}, {-80.0, -88.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{-80.0, 92.0}, {-88.0, 70.0}, {-72.0, 70.0}, {-80.0, 92.0}}), 
      Line(points = {{-90.0, -78.0}, {82.0, -78.0}}, 
      color = {192, 192, 192}), 
      Polygon(lineColor = {192, 192, 192}, 
      fillColor = {192, 192, 192}, 
      fillPattern = FillPattern.Solid, 
      points = {{90.0, -78.0}, {68.0, -70.0}, {68.0, -86.0}, {90.0, -78.0}}), 
      Text(textColor = {192, 192, 192}, 
      extent = {{-66.0, 52.0}, {88.0, 90.0}}, 
      textString = "%order"), 
      Text(
      extent = {{-138.0, -140.0}, {162.0, -110.0}}, 
      textString = "f_cut=%f_cut"), 
      Rectangle(lineColor = {160, 160, 164}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Backward, 
      extent = {{-80.0, -78.0}, {22.0, 10.0}}), 
      Line(origin = {3.333, -6.667}, points = {{-83.333, 34.667}, {24.667, 34.667}, {42.667, -71.333}}, color = {0, 0, 127}, smooth = Smooth.Bezier)}), 
      Documentation(info = "<html><p>
本模块可模拟各种类型的过滤器：<strong>低通、高通、带通和带阻滤波器</strong>
</p>
<p>
使用不同的滤波器特性：<strong>临界阻尼、贝塞尔、巴特沃斯、切比雪夫I类滤波器</strong>
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">默认情况下，滤波器块在</span><span style=\"color: rgb(51, 51, 51);\"><strong>稳态</strong></span><span style=\"color: rgb(51, 51, 51);\">下初始化，以避免开始时出现不必要的振荡。在特殊情况下，可能需要在“高级”选项卡下选择其他初始化选项。</span>
</p>
<p>
下图显示了4种支持的低通滤波器的典型频率响应：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/LowPassOrder4Filters.png\" alt=\"LowPassOrder4Filters.png\" data-href=\"\" style=\"\">
</p>
<p>
下图显示了相同低通滤波器的阶跃响应， 从初始输入=0.2的稳态初始滤波器开始：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/LowPassOrder4FiltersStepResponse.png\" alt=\"LowPassOrder4FiltersStepResponse.png\" data-href=\"\" style=\"\">
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">显然，频率响应在一定程度上给出了滤波器特性错误的印象：尽管巴特沃斯（Butterworth）和切比雪夫（Chebyshev）滤波器的幅度比临界阻尼（CriticalDamping）和贝塞尔（Bessel）滤波器明显陡峭，但后者的阶跃响应要好得多。这意味着，例如，如果滤波器主要用于使非线性逆模型可实现，则应选择临界阻尼或贝塞尔滤波器。</span>
</p>
<p>
4种支持的高通滤波器类型的典型频率响应如下图所示：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/HighPassOrder4Filters.png\" alt=\"HighPassOrder4Filters.png\" data-href=\"\" style=\"\">
</p>
<p>
下图显示了这些高通滤波器的相应阶跃响应：
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/HighPassOrder4FiltersStepResponse.png\" alt=\"HighPassOrder4FiltersStepResponse.png\" data-href=\"\" style=\"\">
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">所有滤波器都提供</span><span style=\"color: rgb(51, 51, 51);\"><strong>归一化</strong></span><span style=\"color: rgb(51, 51, 51);\">（默认）和非归一化形式。在归一化形式中，滤波器传递函数在截止频率 f_cut 处的幅度为 -3 dB (= 10^(-3/20) = 0.70794..)。请注意，在将此函数中的滤波器与其他软件系统进行比较时，必须适当选择“归一化”设置。例如，MATLAB 的信号处理工具箱提供的是非归一化形式的滤波器，因此，只有在设置为 normalized = </span><span style=\"color: rgb(51, 51, 51);\"><strong>false </strong></span><span style=\"color: rgb(51, 51, 51);\">时，比较才有意义。归一化滤波器通常更适合应用，因为不同阶数的滤波器可以“比较”，而非归一化滤波器通常在更改滤波器阶数时需要调整截止频率。请参见通过 1、2、3 阶 CriticalDamping 滤波器比较“归一化”和“非归一化”滤波器的示例：</span>
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/CriticalDampingNormalized.png\" alt=\"CriticalDampingNormalized.png\" data-href=\"\" style=\"\">
</p>
<p style=\"text-align: center;\"><img src=\"modelica://Modelica/Resources/Images/Blocks/Continuous/CriticalDampingNonNormalized.png\" alt=\"CriticalDampingNonNormalized.png\" data-href=\"\" style=\"\">
</p>
<h4>实施情况</h4><p>
滤波器是以下述可靠方式实现的：
</p>
<ol><li>
根据所需的模拟滤波器和相应的归一化， 构建出截止角频率为1rad/s的低通滤波器原型。</li>
<li>
通过对拉普拉斯变量\"s\"的转换， 将该低通滤波器原型转换为所需的滤波器类型和所需的截止频率f_cut。</li>
<li>
利用传递函数的“特征值”表示法， 将得到的一阶和二阶传递函数以状态空间的形式实现： &nbsp;该模块从输入到输出的直流增益为1， 选择的状态是按照输入的顺序排列的 (如果\"u\"是按照“一阶”的顺序排列的，那么状态也是按照“一阶”的顺序排列的)。 在“高级”选项卡中，可以给出输入的名义值。 如果选择得当，状态是按照“一阶”的顺序排列的，那么步长控制总是合适的。</li>
</ol><h4>References</h4><p>
Tietze U., and Schenk C. (2002):
</p>
<p>
<strong>Halbleiter-Schaltungstechnik</strong>.<br>Springer Verlag, 12. Auflage, pp. 815-852.
</p>
</html>"  , revisions = "<html>
<dl>
<dt><strong>Main Author:</strong></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>,
DLR Oberpfaffenhofen.</dd>
</dl>

<h4>Acknowledgement</h4>

<p>
The development of this block was partially funded by BMBF within the
<a href=\"http://www.eurosyslib.com/\">ITEA2 EUROSYSLIB</a>
project.
</p>

</html>"  ) );
  end Filter;
  model TimeSampler "根据仿真时间进行输入信号保持。"

    extends Modelica.Blocks.Interfaces.SISO;

    parameter Real TL(start = 1) "执行判断 time > TL";
    parameter Real TH(start = 2) "执行判断 time <= TH";
    parameter Boolean useSupport(start = false) = false "使用外部给定逻辑值" annotation(Evaluate = true, choices(checkBox = true));

    Modelica.Blocks.Interfaces.BooleanInput sampleSupport if useSupport 
      annotation(Placement(transformation(origin = {0.378379, -120.703}, 
      extent = {{-20, -20}, {20, 20}}, 
      rotation = 90)));

  protected
    Boolean sampleEnable(start = false);
    Real x(start = 0) "状态变量，用于存储保持的值";

  equation
    sampleEnable = if useSupport then sampleSupport else if TL < time and time <= TH then true else false;

    when sampleEnable then
      x = u;
    end when;

    y = if sampleEnable then x else u;

    annotation(
      Icon(
      coordinateSystem(preserveAspectRatio = true, 
      extent = {{-100.0, -100.0}, {100.0, 100.0}}), 
      graphics = {
      Ellipse(lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{25.0, -10.0}, {45.0, 10.0}}), 
      Line(points = {{-100.0, 0.0}, {-45.0, 0.0}}, 
      color = {0, 0, 127}), 
      Line(points = {{45.0, 0.0}, {100.0, 0.0}}, 
      color = {0, 0, 127}), 
      Line(points = {{-35.0, 0.0}, {30.0, 35.0}}, 
      color = {0, 0, 127}), 
      Ellipse(lineColor = {0, 0, 127}, 
      fillColor = {255, 255, 255}, 
      fillPattern = FillPattern.Solid, 
      extent = {{-45.0, -10.0}, {-25.0, 10.0}})}) );

  end TimeSampler;

  package Internal 
    "用户不应直接使用的内部实用功能和程序模块"
    extends Modelica.Icons.InternalPackage;
    package Filter 
      "不应直接使用的过滤器内部实用功能"
      extends Modelica.Icons.InternalPackage;
      package base 
        "截止频率为1rad/s的原型低通滤波器(其他滤波器由这些基本滤波器变换而来)"
        extends Modelica.Icons.InternalPackage;
        function CriticalDamping 
          "返回CriticalDamping过滤器(=低通滤波器，w_cut=1rad/s)的基本滤波器系数"
          extends Modelica.Icons.Function;

          input Integer order(min = 1) "滤波器阶数";
          input Boolean normalized = true 
            "=true，当f_cut处的振幅=-3db，否则不修改滤波器";

          output Real cr[order] "实极点系数";
        protected
          Real alpha = 1.0 "频率修正系数";
          Real alpha2 "= alpha*alpha";
          Real den1[order] 
            "[p]一阶多项式分母系数(a*p+1)";
          Real den2[0,2] 
            "[p^2，p]二阶多项式分母系数(b*p^2+a*p+1)";
          Real c0[0] "共轭复极时的s^0项系数";
          Real c1[0] "共轭复极时的s^1项系数";
          annotation();
        algorithm
          if normalized then
            // alpha := sqrt(2^(1/order) - 1);
            alpha := sqrt(10 ^ (3 / 10 / order) - 1);
          else
            alpha := 1.0;
          end if;

          for i in 1:order loop
            den1[i] := alpha;
          end for;

          // 确定s的最大幂等于1的多项式
          (cr,c0,c1) := 
            Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
            den1, den2);
        end CriticalDamping;

        function Bessel 
          "返回贝塞尔滤波器的基滤波器系数(=低通滤波器，w_cut=1rad/s)"
          extends Modelica.Icons.Function;

          input Integer order(min = 1) "滤波器系数";
          input Boolean normalized = true 
            "=true，当f_cut处的振幅=-3db，否则不修改滤波器";

          output Real cr[mod(order, 2)] "实极点系数";
          output Real c0[integer(order / 2)] 
            "共轭复极时的s^0项系数";
          output Real c1[integer(order / 2)] 
            "共轭复极时的s^1项系数";
        protected
          Real alpha = 1.0 "频率修正系数";
          Real alpha2 "= alpha*alpha";
          Real den1[size(cr, 1)] 
            "[p]一阶多项式分母系数(a*p+1)";
          Real den2[size(c0, 1),2] 
            "[p^2，p]二阶多项式分母系数(b*p^2+a*p+1)";
          annotation();
        algorithm
          (den1,den2,alpha) := 
            Modelica.Blocks.Continuous.Internal.Filter.Utilities.BesselBaseCoefficients(
            order);
          if not normalized then
            alpha2 := alpha * alpha;
            for i in 1:size(c0, 1) loop
              den2[i,1] := den2[i,1] * alpha2;
              den2[i,2] := den2[i,2] * alpha;
            end for;
            if size(cr, 1) == 1 then
              den1[1] := den1[1] * alpha;
            end if;
          end if;

          // 确定s的最大幂等于1的多项式
          (cr,c0,c1) := 
            Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
            den1, den2);
        end Bessel;

        function Butterworth 
          "返回巴特沃斯滤波器的基础滤波器系数（= 截止频率 w_cut = 1 rad/s 的低通滤波器）"
          import Modelica.Constants.pi;
          extends Modelica.Icons.Function;

          input Integer order(min = 1) "滤波器阶数";
          input Boolean normalized = true 
            "=true，当f_cut处的振幅=-3db，否则不修改滤波器";

          output Real cr[mod(order, 2)] "实极点系数";
          output Real c0[integer(order / 2)] 
            "共轭复极时的s^0项系数";
          output Real c1[integer(order / 2)] 
            "共轭复极时的s^1项系数";
        protected
          Real alpha = 1.0 "频率修正系数";
          Real alpha2 "= alpha*alpha";
          Real den1[size(cr, 1)] 
            "[p]一阶多项式分母系数(a*p+1)";
          Real den2[size(c0, 1),2] 
            "[p^2，p]二阶多项式分母系数(b*p^2+a*p+1)";
          annotation(Documentation(info="<html><p>
<br>
</p>
</html>"  ));
        algorithm
          for i in 1:size(c0, 1) loop
            den2[i,1] := 1.0;
            den2[i,2] := -2 * Modelica.Math.cos(pi * (0.5 + (i - 0.5) / order));
          end for;
          if size(cr, 1) == 1 then
            den1[1] := 1.0;
          end if;

          /* 对滤波器传递函数进行
          \"new(p)= alpha*p\"
          的变换，使滤波器传递函数在截止频率处的幅值为-3db
          */
          /*
          如果归一化，则
          alpha := Internal.normalizationFactor(den1, den2);
          alpha2 := alpha*alpha;
          for i in 1:size(c0, 1) loop
          den2[i, 1] := den2[i, 1]*alpha2;
          den2[i, 2] := den2[i, 2]*alpha;
          end for;
          if size(cr,1) == 1 then
          den1[1] := den1[1]*alpha;
          end if;
          end if;
          */

          // 求s的最高次幂等于1的多项式
          (cr
        ,



              c0
        ,



                 c1) := 
            Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
            den1, den2);
        end Butterworth;

        function ChebyshevI 
          "返回切比雪夫I型滤波器的基滤波器系数(=w_cut=1rad/s的低通滤波器)"
          import Modelica.Math.asinh;
          import Modelica.Constants.pi;

          extends Modelica.Icons.Function;

          input Integer order(min = 1) "滤波器阶数";
          input Real A_ripple = 0.5 "通带纹波[dB]";
          input Boolean normalized = true 
            "=true，当f_cut处的振幅=-3db，否则不修改滤波器";

          output Real cr[mod(order, 2)] "实极点系数";
          output Real c0[integer(order / 2)] 
            "共轭复极时的s^0项系数";
          output Real c1[integer(order / 2)] 
            "共轭复极时的s^1项系数";
        protected
          Real epsilon;
          Real fac;
          Real alpha = 1.0 "频率修正系数";
          Real alpha2 "= alpha*alpha";
          Real den1[size(cr, 1)] 
            "[p]分母一阶多项式系数(a*p+1)";
          Real den2[size(c0, 1),2] 
            "[p^2,p]分母二阶多项式系数(b*p^2+a*p+1)";
          annotation(Documentation(info="<html><p>
<br>
</p>
</html>"                    ));
        algorithm
          epsilon := sqrt(10 ^ (A_ripple / 10) - 1);
          fac := asinh(1 / epsilon) / order;

          den1 := fill(1 / sinh(fac), size(den1, 1));
          if size(cr, 1) == 0 then
            for i in 1:size(c0, 1) loop
              den2[i,1] := 1 / (cosh(fac) ^ 2 - cos((2 * i - 1) * pi / (2 * order)) ^ 2);
              den2[i,2] := 2 * den2[i,1] * sinh(fac) * cos((2 * i - 1) * pi / (2 * order));
            end for;
          else
            for i in 1:size(c0, 1) loop
              den2[i,1] := 1 / (cosh(fac) ^ 2 - cos(i * pi / order) ^ 2);
              den2[i,2] := 2 * den2[i,1] * sinh(fac) * cos(i * pi / order);
            end for;
          end if;

          /* 对滤波器传递函数进行
          \"new(p)= alpha*p\"
          的变换，使滤波器传递函数在截止频率处的幅值为-3db
          */
          if normalized then
            alpha := 
              Modelica.Blocks.Continuous.Internal.Filter.Utilities.normalizationFactor(
              den1, den2);
            alpha2 := alpha * alpha;
            for i in 1:size(c0, 1) loop
              den2[i,1] := den2[i,1] * alpha2;
              den2[i,2] := den2[i,2] * alpha;
            end for;
            den1 := den1 * alpha;
          end if;

          // 求s的最高次幂等于1的多项式
          (cr,c0,c1) := 
            Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
            den1, den2);
        end ChebyshevI;
        annotation();
      end base;

      package coefficients "滤波器系数"
        extends Modelica.Icons.InternalPackage;
        function lowPass 
          "返回给定截止频率下的低通滤波器系数"
          import Modelica.Constants.pi;
          extends Modelica.Icons.Function;

          input Real cr_in[:] "实极点系数";
          input Real c0_in[:] 
            "共轭复极时的s^0项系数";
          input Real c1_in[size(c0_in, 1)] 
            "共轭复极时的s^1项系数";
          input SI.Frequency f_cut "截止频率";

          output Real cr[size(cr_in, 1)] "实极点系数";
          output Real c0[size(c0_in, 1)] 
            "共轭复极时的s^0项系数";
          output Real c1[size(c0_in, 1)] 
            "共轭复极时的s^1项系数";

        protected
          SI.AngularVelocity w_cut = 2 * pi * f_cut 
            "截止角频率";
          Real w_cut2 = w_cut * w_cut;
          annotation();

        algorithm
          assert(f_cut > 0, "截止频率f_cut必须为正");

          /* 根据变换new(s) = s/w_cut改变滤波器系数
          s + cr           -> (s/w) + cr              = (s + w*cr)/w
          s^2 + c1*s + c0  -> (s/w)^2 + c1*(s/w) + c0 = (s^2 + (c1*w)*s + (c0*w^2))/w^2
          */
          cr := w_cut * cr_in;
          c1 := w_cut * c1_in;
          c0 := w_cut2 * c0_in;

        end lowPass;

        function highPass 
          "返回给定截止频率下的高通滤波器系数"
          import Modelica.Constants.pi;
          extends Modelica.Icons.Function;

          input Real cr_in[:] "实极点系数";
          input Real c0_in[:] 
            "共轭复极时的s^0项系数";
          input Real c1_in[size(c0_in, 1)] 
            "共轭复极时的s^1项系数";
          input SI.Frequency f_cut "截止频率";

          output Real cr[size(cr_in, 1)] "实极点系数";
          output Real c0[size(c0_in, 1)] 
            "共轭复极时的s^0项系数";
          output Real c1[size(c0_in, 1)] 
            "共轭复极时的s^1项系数";

        protected
          SI.AngularVelocity w_cut = 2 * pi * f_cut 
            "截止角频率";
          Real w_cut2 = w_cut * w_cut;
          annotation();

        algorithm
          assert(f_cut > 0, "截止频率f_cut必须为正");

          /* 根据变换new(s) = 1/s改变滤波器系数
          1/(s + cr)          -> 1/(1/s + cr)                = (1/cr)*s / (s + (1/cr))
          1/(s^2 + c1*s + c0) -> 1/((1/s)^2 + c1*(1/s) + c0) = (1/c0)*s^2 / (s^2 + (c1/c0)*s + 1/c0)
          
          检查变换根是否也是共轭复数：
          c0 - c1^2/4 > 0  -> (1/c0) - (c1/c0)^2 / 4
          = (c0 - c1^2/4) / c0^2 > 0
          因此，可以保证根保持共轭复数
          
          根据变换new(s) = s/w_cut改变滤波器系数
          s + 1/cr                -> (s/w) + 1/cr                   = (s + w/cr)/w
          s^2 + (c1/c0)*s + 1/c0  -> (s/w)^2 + (c1/c0)*(s/w) + 1/c0 = (s^2 + (w*c1/c0)*s + (w^2/c0))/w^2
          */
          for i in 1:size(cr_in, 1) loop
            cr[i] := w_cut / cr_in[i];
          end for;

          for i in 1:size(c0_in, 1) loop
            c0[i] := w_cut2 / c0_in[i];
            c1[i] := w_cut * c1_in[i] / c0_in[i];
          end for;

        end highPass;

        function bandPass 
          "返回给定截止频率下的带通滤波器系数"
          import Modelica.Constants.pi;
          extends Modelica.Icons.Function;

          input Real cr_in[:] "实极点系数";
          input Real c0_in[:] 
            "共轭复极时的s^0项系数";
          input Real c1_in[size(c0_in, 1)] 
            "共轭复极时的s^1项系数";
          input SI.Frequency f_min 
            "带通滤波器的频带为f_min(A=-3db)...f_max(A=-3db)";
          input SI.Frequency f_max "最大频带频率";

          output Real cr[0] "实极点系数";
          output Real c0[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "共轭复极时的s^0项系数";
          output Real c1[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "共轭复极时的s^1项系数";
          output Real cn "PT2项的分母系数";
        protected
          SI.Frequency f0 = sqrt(f_min * f_max);
          SI.AngularVelocity w_cut = 2 * pi * f0 
            "截止角频率";
          Real w_band = (f_max - f_min) / f0;
          Real w_cut2 = w_cut * w_cut;
          Real c;
          Real alpha;
          Integer j;
          annotation(Documentation(info="<html><p>
<br>
</p>
</html>"                    ));
        algorithm
          assert(f_min > 0 and f_min < f_max, "频带频率f_min和f_max错误");

          /* 带通滤波器由低通滤波器通过变换
          new(s) = (s + 1/s)/w得出   (w = w_band = (f_max - f_min)/sqrt(f_max*f_min) )
          
          1/(s + cr)         -> 1/((s/w + 1/s/w) + cr)
          = w*s / (s^2 + cr*w*s + 1)
          
          1/(s^2 + c1*s + c0) -> 1/( (s+1/s)^2/w^2 + c1*(s + 1/s)/w + c0 )
          = 1 /( ( s^2 + 1/s^2 + 2)/w^2 + (s + 1/s)*c1/w + c0 )
          = w^2*s^2 / (s^4 + 2*s^2 + 1 + (s^3 + s)*c1*w + c0*w^2*s^2)
          = w^2*s^2 / (s^4 + c1*w*s^3 + (2+c0*w^2)*s^2 + c1*w*s + 1)
          
          假设PT2的描述如下：
          = w^2*s^2 /( (s^2 + s*(c/alpha) + 1/alpha^2)*
          (s^2 + s*(c*alpha) + alpha^2) )
          = w^2*s^2 / ( s^4 + c*(alpha + 1/alpha)*s^3
          + (alpha^2 + 1/alpha^2 + c^2)*s^2
          + c*(alpha + 1/alpha)*s + 1 )
          
          并且：
          c*(alpha + 1/alpha) = c1*w       -> c = c1*w / (alpha + 1/alpha)
          = c1*w*alpha/(1+alpha^2)
          alpha^2 + 1/alpha^2 + c^2 = 2+c0*w^2 -> equation to determine alpha
          alpha^4 + 1 + c1^2*w^2*alpha^4/(1+alpha^2)^2 = (2+c0*w^2)*alpha^2
          or z = alpha^2
          z^2 + c^1^2*w^2*z^2/(1+z)^2 - (2+c0*w^2)*z + 1 = 0
          
          检查根是否保持共轭复数
          c0 - (c1/2)^2 > 0:    1/alpha^2 - (c/alpha)^2/4
          = 1/alpha^2*(1 - c^2/4)    -> not possible to figure this out
          
          然后，根据变换new(s) = s/w_cut改变滤波器系数
          w_band*s/(s^2 + c1*s + c0)  -> w_band*(s/w)/((s/w)^2 + c1*(s/w) + c0 =
          (w_band/w)*s/(s^2 + (c1*w)*s + (c0*w^2))/w^2) =
          (w_band*w)*s/(s^2 + (c1*w)*s + (c0*w^2))
          */
          for i in 1:size(cr_in, 1) loop
            c1[i] := w_cut * cr_in[i] * w_band;
            c0[i] := w_cut2;
          end for;

          for i in 1:size(c1_in, 1) loop
            alpha := 
              Modelica.Blocks.Continuous.Internal.Filter.Utilities.bandPassAlpha(
              c1_in[i], 
              c0_in[i], 
              w_band);
            c := c1_in[i] * w_band / (alpha + 1 / alpha);
            j := size(cr_in, 1) + 2 * i - 1;
            c1[j] := w_cut * c / alpha;
            c1[j + 1] := w_cut * c * alpha;
            c0[j] := w_cut2 / alpha ^ 2;
            c0[j + 1] := w_cut2 * alpha ^ 2;
          end for;

          cn := w_band * w_cut;

        end bandPass;

        function bandStop 
          "返回给定截止频率下的带截止滤波器系数"
          import Modelica.Constants.pi;
          extends Modelica.Icons.Function;

          input Real cr_in[:] "实极点系数";
          input Real c0_in[:] 
            "共轭复极时的s^0项系数";
          input Real c1_in[size(c0_in, 1)] 
            "共轭复极时的s^1项系数";
          input SI.Frequency f_min 
            "带阻滤波器的频带为f_min(A=-3db)...f_max(A=-3db)";
          input SI.Frequency f_max "最大频带频率";

          output Real cr[0] "实极点系数";
          output Real c0[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "共轭复极时的s^0项系数";
          output Real c1[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "共轭复极时的s^1项系数";
        protected
          SI.Frequency f0 = sqrt(f_min * f_max);
          SI.AngularVelocity w_cut = 2 * pi * f0 
            "截止角频率";
          Real w_band = (f_max - f_min) / f0;
          Real w_cut2 = w_cut * w_cut;
          Real c;
          Real ww;
          Real alpha;
          Integer j;
          annotation(Documentation(info="<html><p>
<br>
</p>
</html>"                    ));
        algorithm
          assert(f_min > 0 and f_min < f_max, "频带频率f_min和f_max错误");

          /* 带通滤波器由低通滤波器通过变换new(s) = (s + 1/s)/w得出   (w = w_band = (f_max - f_min)/sqrt(f_max*f_min) )
          
          1/(s + cr)         -> 1/((s/w + 1/s/w) + cr)
          = w*s / (s^2 + cr*w*s + 1)
          
          1/(s^2 + c1*s + c0) -> 1/( (s+1/s)^2/w^2 + c1*(s + 1/s)/w + c0 )
          = 1 /( ( s^2 + 1/s^2 + 2)/w^2 + (s + 1/s)*c1/w + c0 )
          = w^2*s^2 / (s^4 + 2*s^2 + 1 + (s^3 + s)*c1*w + c0*w^2*s^2)
          = w^2*s^2 / (s^4 + c1*w*s^3 + (2+c0*w^2)*s^2 + c1*w*s + 1)
          
          假设PT2的描述如下：
          = w^2*s^2 /( (s^2 + s*(c/alpha) + 1/alpha^2)*
          (s^2 + s*(c*alpha) + alpha^2) )
          = w^2*s^2 / ( s^4 + c*(alpha + 1/alpha)*s^3
          + (alpha^2 + 1/alpha^2 + c^2)*s^2
          + c*(alpha + 1/alpha)*s + 1 )
          
          并且：
          c*(alpha + 1/alpha) = c1*w       -> c = c1*w / (alpha + 1/alpha)
          = c1*w*alpha/(1+alpha^2)
          alpha^2 + 1/alpha^2 + c^2 = 2+c0*w^2 -> equation to determine alpha
          alpha^4 + 1 + c1^2*w^2*alpha^4/(1+alpha^2)^2 = (2+c0*w^2)*alpha^2
          or z = alpha^2
          z^2 + c^1^2*w^2*z^2/(1+z)^2 - (2+c0*w^2)*z + 1 = 0
          
          带阻滤波器由低通滤波器通过变换 new(s) = w/( (s + 1/s) )得出   (w = w_band = (f_max - f_min)/sqrt(f_max*f_min) )
          
          cr/(s + cr)         -> 1/(( w/(s + 1/s) ) + cr)
          = (s^2 + 1) / (s^2 + (w/cr)*s + 1)
          
          c0/(s^2 + c1*s + c0) -> c0/( w^2/(s + 1/s)^2 + c1*w/(s + 1/s) + c0 )
          = c0*(s^2 + 1)^2 / (s^4 + c1*w*s^3/c0 + (2+w^2/b)*s^2 + c1*w*s/c0 + 1)
          
          假设PT2的描述如下：
          = c0*(s^2 + 1)^2 / ( (s^2 + s*(c/alpha) + 1/alpha^2)*
          (s^2 + s*(c*alpha) + alpha^2) )
          = c0*(s^2 + 1)^2 / (  s^4 + c*(alpha + 1/alpha)*s^3
          + (alpha^2 + 1/alpha^2 + c^2)*s^2
          + c*(alpha + 1/alpha)*p + 1 )
          
          并且：
          c*(alpha + 1/alpha) = c1*w/b         -> c = c1*w/(c0*(alpha + 1/alpha))
          alpha^2 + 1/alpha^2 + c^2 = 2+w^2/c0 -> equation to determine alpha
          alpha^4 + 1 + (c1*w/c0*alpha^2)^2/(1+alpha^2)^2 = (2+w^2/c0)*alpha^2
          or z = alpha^2
          z^2 + (c1*w/c0*z)^2/(1+z)^2 - (2+w^2/c0)*z + 1 = 0
          
          相同地：  ww = w/c0
          z^2 + (c1*ww*z)^2/(1+z)^2 - (2+c0*ww)*z + 1 = 0  -> same equation as for BandPass
          
          然后，根据转化new(s) = s/w_cut改变滤波器阶数
          c0*(s^2+1)(s^2 + c1*s + c0)  -> c0*((s/w)^2 + 1) / ((s/w)^2 + c1*(s/w) + c0 =
          c0/w^2*(s^2 + w^2) / (s^2 + (c1*w)*s + (c0*w^2))/w^2) =
          (s^2 + c0*w^2) / (s^2 + (c1*w)*s + (c0*w^2))
          */
          for i in 1:size(cr_in, 1) loop
            c1[i] := w_cut * w_band / cr_in[i];
            c0[i] := w_cut2;
          end for;

          for i in 1:size(c1_in, 1) loop
            ww := w_band / c0_in[i];
            alpha := 
              Modelica.Blocks.Continuous.Internal.Filter.Utilities.bandPassAlpha(
              c1_in[i], 
              c0_in[i], 
              ww);
            c := c1_in[i] * ww / (alpha + 1 / alpha);
            j := size(cr_in, 1) + 2 * i - 1;
            c1[j] := w_cut * c / alpha;
            c1[j + 1] := w_cut * c * alpha;
            c0[j] := w_cut2 / alpha ^ 2;
            c0[j + 1] := w_cut2 * alpha ^ 2;
          end for;

        end bandStop;
        annotation();
      end coefficients;

      package roots "根据模块实现的需要，返回滤波器的根和增益"
        extends Modelica.Icons.InternalPackage;
        function lowPass 
          "根据给定的截止频率，按模块需要返回低通滤波器根数"
          extends Modelica.Icons.Function;

          input Real cr_in[:] "基准滤波器的实极点系数";
          input Real c0_in[:] 
            "共轭复极时的s^0项系数";
          input Real c1_in[size(c0_in, 1)] 
            "共轭复极时的s^1项系数";
          input SI.Frequency f_cut "截止频率";

          output Real r[size(cr_in, 1)] "实特征值";
          output Real a[size(c0_in, 1)] 
            "复共轭特征值的实部";
          output Real b[size(c0_in, 1)] 
            "复共轭特征值的虚部";
          output Real ku[size(c0_in, 1)] "输入增益";
        protected
          Real c0[size(c0_in, 1)];
          Real c1[size(c0_in, 1)];
          Real cr[size(cr_in, 1)];
        algorithm
          // 获取f_cut处的低通滤波器系数
          (cr,c0,c1) := coefficients.lowPass(cr_in, c0_in, c1_in, f_cut);

          // 将系数转换为根系数
          for i in 1:size(cr_in, 1) loop
            r[i] := -cr[i];
          end for;

          for i in 1:size(c0_in, 1) loop
            a[i] := -c1[i] / 2;
            b[i] := sqrt(c0[i] - a[i] * a[i]);
            ku[i] := c0[i] / b[i];
          end for;

          annotation(Documentation(info = "<html>

<p>
目标是以如下形式实现滤波器功能:
</p>

<blockquote><pre>
//实极点：
der(x) = r*x - r*u
y  = x

// 复共轭极点：
der(x1) = a*x1 - b*x2 + ku*u;
der(x2) = b*x1 + a*x2;
y  = x2;

ku = (a^2 + b^2)/b
</pre></blockquote>
<p>
这种表示法具有如下传递函数：
</p>
<blockquote><pre>
// 实极点
s*y = r*y - r*u
或
(s-r)*y = -r*u
或
y = -r/(s-r)*u

比较系数
y = cr/(s + cr)*u  ->  r = -cr      // r是实特征值

// 复共轭极点
s*x2 =  a*x2 + b*x1
s*x1 = -b*x2 + a*x1 + ku*u
or
(s-a)*x2               = b*x1  ->  x2 = b/(s-a)*x1
(s + b^2/(s-a) - a)*x1 = ku*u  ->  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                     ->  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
or
x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
= b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
y  = x2

比较系数
y = c0/(s^2 + c1*s + c0)*u  ->  a  = -c1/2
                      b  = sqrt(c0 - a^2)
                      ku = c0/b
                         = (a^2 + b^2)/b

比较特征值
(s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
表明：
a：实部特征值
b：虚部特征值

时间趋于无限时:
y(s=0) = x2(s=0) = 1
x1(s=0) = -ku*a/(a^2 + b^2)*u
       = -(a/b)*u
</pre></blockquote>

</html>"        ));
        end lowPass;

        function highPass 
          "根据给定的截止频率，按需要返回模块的高通滤波器根数"
          extends Modelica.Icons.Function;

          input Real cr_in[:] "基准滤波器的实极点系数";
          input Real c0_in[:] 
            "共轭复极时的s^0项系数";
          input Real c1_in[size(c0_in, 1)] 
            "共轭复极时的s^1项系数";
          input SI.Frequency f_cut "截止频率";

          output Real r[size(cr_in, 1)] "实特征值";
          output Real a[size(c0_in, 1)] 
            "复共轭特征值的实部";
          output Real b[size(c0_in, 1)] 
            "复共轭特征值的虚部";
          output Real ku[size(c0_in, 1)] "输入项的增益";
          output Real k1[size(c0_in, 1)] "y=k1*x1+k2*x+u的增益";
          output Real k2[size(c0_in, 1)] "y=k1*x1+k2*x+u的增益";
        protected
          Real c0[size(c0_in, 1)];
          Real c1[size(c0_in, 1)];
          Real cr[size(cr_in, 1)];
          Real ba2;
        algorithm
          // 在f_cut处获取高通滤波器系数
          (cr,c0,c1) := coefficients.highPass(cr_in, c0_in, c1_in, f_cut);

          // 将系数转换为根
          for i in 1:size(cr_in, 1) loop
            r[i] := -cr[i];
          end for;

          for i in 1:size(c0_in, 1) loop
            a[i] := -c1[i] / 2;
            b[i] := sqrt(c0[i] - a[i] * a[i]);
            ku[i] := c0[i] / b[i];
            k1[i] := 2 * a[i] / ku[i];
            ba2 := (b[i] / a[i]) ^ 2;
            k2[i] := (1 - ba2) / (1 + ba2);
          end for;

          annotation(Documentation(info="<html><p>
目标是以如下形式实现滤波器：
</p>
<p>
<br>
</p>
<pre><code >// 实极点
der(x) = r*x - r*u
y  = -x + u

// 复共轭极点
der(x1) = a*x1 - b*x2 + ku*u;
der(x2) = b*x1 + a*x2;
y  = k1*x1 + k2*x2 + u;

ku = (a^2 + b^2)/b
k1 = 2*a/ku
k2 = (a^2 - b^2) / (b*ku)
= (a^2 - b^2) / (a^2 + b^2)
= (1 - (b/a)^2) / (1 + (b/a)^2)
</code></pre><p>
<br>
</p>
<p>
这种表示法具有如下传递函数
</p>
<p>
<br>
</p>
<pre><code >// 实极点
s*x = r*x - r*u
or
(s-r)*x = -r*u   -&gt; x = -r/(s-r)*u
or
y = r/(s-r)*u + (s-r)/(s-r)*u
= (r+s-r)/(s-r)*u
= s/(s-r)*u

// 比较系数
y = s/(s + cr)*u  -&gt;  r = -cr      // r是实特征值

// 复共轭极点
s*x2 =  a*x2 + b*x1
s*x1 = -b*x2 + a*x1 + ku*u
or
(s-a)*x2               = b*x1  -&gt;  x2 = b/(s-a)*x1
(s + b^2/(s-a) - a)*x1 = ku*u  -&gt;  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                     -&gt;  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
或
x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
= b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
y  = k1*x1 + k2*x2 + u
= (k1*ku*(s-a) + k2*b*ku +  s^2 - 2*a*s + a^2 + b^2) /
(s^2 - 2*a*s + a^2 + b^2)*u
= (s^2 + (k1*ku - 2*a)*s + k2*b*ku - k1*ku*a + a^2 + b^2) /
(s^2 - 2*a*s + a^2 + b^2)*u
= (s^2 + (2*a-2*a)*s + a^2 - b^2 - 2*a^2 + a^2 + b^2) /
(s^2 - 2*a*s + a^2 + b^2)*u
= s^2 / (s^2 - 2*a*s + a^2 + b^2)*u

// 比较系数
y = s^2/(s^2 + c1*s + c0)*u  -&gt;  a = -c1/2
                       b = sqrt(c0 - a^2)

// 比较特征值
(s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
// shows that:
//   a：实部特征值
//   b：虚部特征值
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"  ));
        end highPass;

        function bandPass 
          "根据给定的截止频率，按需要返回模块的带通滤波器根数"
          extends Modelica.Icons.Function;

          input Real cr_in[:] "基准滤波器的实极点系数";
          input Real c0_in[:] 
            "共轭复极时的基准滤波器s^0项的系数";
          input Real c1_in[size(c0_in, 1)] 
            "共轭复极时的基准滤波器s^1项的系数";
          input SI.Frequency f_min 
            "带通滤波器的频带为f_min(A=-3db)...f_max(A=-3db)";
          input SI.Frequency f_max "最大频带频率";

          output Real a[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "复共轭特征值的实部";
          output Real b[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "复共轭特征值的虚部";
          output Real ku[size(cr_in, 1) + 2 * size(c0_in, 1)] "输入项的增益";
          output Real k1[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "y=k1*x1+k2*x的增益";
          output Real k2[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "y=k1*x1+k2*x的增益";
        protected
          Real cr[0];
          Real c0[size(a, 1)];
          Real c1[size(a, 1)];
          Real cn;
          Real bb;
        algorithm
          // 获取f_cut处的带通滤波器系数
          (cr,c0,c1,cn) := coefficients.bandPass(cr_in, c0_in, c1_in, f_min, f_max);

          // 将系数转换为根
          for i in 1:size(a, 1) loop
            a[i] := -c1[i] / 2;
            bb := c0[i] - a[i] * a[i];
            assert(bb >= 0, "\n不能使用带通滤波器，因为变换的结果是\n" + 
              "系统没有共轭复极\n" + 
              "尝试使用其他模拟滤波器进行带通\n");
            b[i] := sqrt(bb);
            ku[i] := c0[i] / b[i];
            k1[i] := cn / ku[i];
            k2[i] := cn * a[i] / (b[i] * ku[i]);
          end for;

          annotation(Documentation(info = "<html>

<p>
目标是以如下形式实现滤波器：
</p>

<blockquote><pre>
// 复共轭极点
der(x1) = a*x1 - b*x2 + ku*u;
der(x2) = b*x1 + a*x2;
y  = k1*x1 + k2*x2;

ku = (a^2 + b^2)/b
k1 = cn/ku
k2 = cn*a/(b*ku)
</pre></blockquote>
<p>
这种表示法具有如下传递函数
</p>
<blockquote><pre>
// 复共轭极点
s*x2 =  a*x2 + b*x1
s*x1 = -b*x2 + a*x1 + ku*u
或
(s-a)*x2               = b*x1  ->  x2 = b/(s-a)*x1
(s + b^2/(s-a) - a)*x1 = ku*u  ->  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                     ->  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
或
x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
= b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
y  = k1*x1 + k2*x2
= (k1*ku*(s-a) + k2*b*ku) / (s^2 - 2*a*s + a^2 + b^2)*u
= (k1*ku*s + k2*b*ku - k1*ku*a) / (s^2 - 2*a*s + a^2 + b^2)*u
= (cn*s + cn*a - cn*a) / (s^2 - 2*a*s + a^2 + b^2)*u
= cn*s / (s^2 - 2*a*s + a^2 + b^2)*u

比较系数
y = cn*s / (s^2 + c1*s + c0)*u  ->  a = -c1/2
                          b = sqrt(c0 - a^2)

比较特征值
(s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
如下:
a：实部特征值
b：虚部特征值
</pre></blockquote>

</html>"                ));
        end bandPass;

        function bandStop 
          "根据给定的截止频率，按需要返回模块的带阻滤波器根数"
          extends Modelica.Icons.Function;

          input Real cr_in[:] "基准滤波器的实极点系数";
          input Real c0_in[:] 
            "共轭复极时的基准滤波器s^0项的系数";
          input Real c1_in[size(c0_in, 1)] 
            "共轭复极时的基准滤波器s^1项的系数";
          input SI.Frequency f_min 
            "带阻滤波器的频带为f_min(A=-3db)...f_max(A=-3db)";
          input SI.Frequency f_max "最大频带频率";

          output Real a[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "复共轭特征值的实部";
          output Real b[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "复共轭特征值的虚部";
          output Real ku[size(cr_in, 1) + 2 * size(c0_in, 1)] "输入项增益";
          output Real k1[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "y=k1*x1+k2*x的增益";
          output Real k2[size(cr_in, 1) + 2 * size(c0_in, 1)] 
            "y=k1*x1+k2*x的增益";
        protected
          Real cr[0];
          Real c0[size(a, 1)];
          Real c1[size(a, 1)];
          Real cn;
          Real bb;
        algorithm
          // 获取f_cut处的带阻滤波器系数
          (cr,c0,c1) := coefficients.bandStop(cr_in, c0_in, c1_in, f_min, f_max);

          // 将系数转换为根
          for i in 1:size(a, 1) loop
            a[i] := -c1[i] / 2;
            bb := c0[i] - a[i] * a[i];
            assert(bb >= 0, "\n不可能使用带阻滤波器，因为变换的结果是\n" + 
              "没有共轭复极的系统\n" + 
              "尝试使用另一个模拟滤波器作为带阻滤波器\n");
            b[i] := sqrt(bb);
            ku[i] := c0[i] / b[i];
            k1[i] := 2 * a[i] / ku[i];
            k2[i] := (c0[i] + a[i] ^ 2 - b[i] ^ 2) / (b[i] * ku[i]);
          end for;

          annotation(Documentation(info = "<html>

<p>
目标是以如下形式实现过滤器：
</p>

<blockquote><pre>
// 复共轭极点
der(x1) = a*x1 - b*x2 + ku*u;
der(x2) = b*x1 + a*x2;
y  = k1*x1 + k2*x2 + u;

ku = (a^2 + b^2)/b
k1 = 2*a/ku
k2 = (c0 + a^2 - b^2)/(b*ku)
</pre></blockquote>
<p>
这种表示法具有如下传递函数
</p>
<blockquote><pre>
// 复共轭极点
s*x2 =  a*x2 + b*x1
s*x1 = -b*x2 + a*x1 + ku*u
或
(s-a)*x2               = b*x1  ->  x2 = b/(s-a)*x1
(s + b^2/(s-a) - a)*x1 = ku*u  ->  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                     ->  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
或
x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
= b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
y  = k1*x1 + k2*x2 + u
= (k1*ku*(s-a) + k2*b*ku + s^2 - 2*a*s + a^2 + b^2) / (s^2 - 2*a*s + a^2 + b^2)*u
= (s^2 + (k1*ku-2*a)*s + k2*b*ku - k1*ku*a + a^2 + b^2) / (s^2 - 2*a*s + a^2 + b^2)*u
= (s^2 + c0 + a^2 - b^2 - 2*a^2 + a^2 + b^2) / (s^2 - 2*a*s + a^2 + b^2)*u
= (s^2 + c0) / (s^2 - 2*a*s + a^2 + b^2)*u

比较系数
y = (s^2 + c0) / (s^2 + c1*s + c0)*u  ->  a = -c1/2
                                b = sqrt(c0 - a^2)

比较特征值
(s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
如下
a：特征值实部
b：特征值虚部
</pre></blockquote>

</html>"                        ));
        end bandStop;
        annotation(Documentation(info="<html><p>
<br>
</p>
</html>"                ));
      end roots;

      package Utilities "用于滤波计算的实用功能"
        extends Modelica.Icons.InternalPackage;
        function BesselBaseCoefficients 
          "归一化低通贝塞尔滤波器的返回系数(=截止频率为1rad/s时的增益降低3dB)"
          extends Modelica.Icons.Function;

          import Modelica.Utilities.Streams;
          input Integer order "1...41范围内滤波器的阶次";
          output Real c1[mod(order, 2)] 
            "[p]贝塞尔分母多项式系数(a*p+1)";
          output Real c2[integer(order / 2),2] 
            "[p^2,p]贝塞尔分母多项式系数(b2*p^2+b1*p+1)";
          output Real alpha "归一化系数";
        algorithm
          if order == 1 then
            alpha := 1.002377293007601;
            c1[1] := 0.9976283451109835;
          elseif order == 2 then
            alpha := 0.7356641785819585;
            c2[1,1] := 0.6159132201783791;
            c2[1,2] := 1.359315879600889;
          elseif order == 3 then
            alpha := 0.5704770156982642;
            c1[1] := 0.7548574865985343;
            c2[1,1] := 0.4756958028827457;
            c2[1,2] := 0.9980615136104388;
          elseif order == 4 then
            alpha := 0.4737978580281427;
            c2[1,1] := 0.4873729247240677;
            c2[1,2] := 1.337564170455762;
            c2[2,1] := 0.3877724315741958;
            c2[2,2] := 0.7730405590839861;
          elseif order == 5 then
            alpha := 0.4126226974763408;
            c1[1] := 0.6645723262620757;
            c2[1,1] := 0.4115231900614016;
            c2[1,2] := 1.138349926728708;
            c2[2,1] := 0.3234938702877912;
            c2[2,2] := 0.6205992985771313;
          elseif order == 6 then
            alpha := 0.3705098000736233;
            c2[1,1] := 0.3874508649098960;
            c2[1,2] := 1.219740879520741;
            c2[2,1] := 0.3493298843155746;
            c2[2,2] := 0.9670265529381365;
            c2[3,1] := 0.2747419229514599;
            c2[3,2] := 0.5122165075105700;
          elseif order == 7 then
            alpha := 0.3393452623586350;
            c1[1] := 0.5927147125821412;
            c2[1,1] := 0.3383379423919174;
            c2[1,2] := 1.092630816438030;
            c2[2,1] := 0.3001025788696046;
            c2[2,2] := 0.8289928256598656;
            c2[3,1] := 0.2372867471539579;
            c2[3,2] := 0.4325128641920154;
          elseif order == 8 then
            alpha := 0.3150267393795002;
            c2[1,1] := 0.3151115975207653;
            c2[1,2] := 1.109403015460190;
            c2[2,1] := 0.2969344839572762;
            c2[2,2] := 0.9737455812222699;
            c2[3,1] := 0.2612545921889538;
            c2[3,2] := 0.7190394712068573;
            c2[4,1] := 0.2080523342974281;
            c2[4,2] := 0.3721456473047434;
          elseif order == 9 then
            alpha := 0.2953310177184124;
            c1[1] := 0.5377196679501422;
            c2[1,1] := 0.2824689124281034;
            c2[1,2] := 1.022646191567475;
            c2[2,1] := 0.2626824161383468;
            c2[2,2] := 0.8695626454762596;
            c2[3,1] := 0.2302781917677917;
            c2[3,2] := 0.6309047553448520;
            c2[4,1] := 0.1847991729757028;
            c2[4,2] := 0.3251978031287202;
          elseif order == 10 then
            alpha := 0.2789426890619463;
            c2[1,1] := 0.2640769908255582;
            c2[1,2] := 1.019788132875305;
            c2[2,1] := 0.2540802639216947;
            c2[2,2] := 0.9377020417760623;
            c2[3,1] := 0.2343577229427963;
            c2[3,2] := 0.7802229808216112;
            c2[4,1] := 0.2052193139338624;
            c2[4,2] := 0.5594176813008133;
            c2[5,1] := 0.1659546953748916;
            c2[5,2] := 0.2878349616233292;
          elseif order == 11 then
            alpha := 0.2650227766037203;
            c1[1] := 0.4950265498954191;
            c2[1,1] := 0.2411858478546218;
            c2[1,2] := 0.9567800996387417;
            c2[2,1] := 0.2296849355380925;
            c2[2,2] := 0.8592523717113126;
            c2[3,1] := 0.2107851705677406;
            c2[3,2] := 0.7040216048898129;
            c2[4,1] := 0.1846461385164021;
            c2[4,2] := 0.5006729207276717;
            c2[5,1] := 0.1504217970817433;
            c2[5,2] := 0.2575070491320295;
          elseif order == 12 then
            alpha := 0.2530051198547209;
            c2[1,1] := 0.2268294941204543;
            c2[1,2] := 0.9473116570034053;
            c2[2,1] := 0.2207657387793729;
            c2[2,2] := 0.8933728946287606;
            c2[3,1] := 0.2087600700376653;
            c2[3,2] := 0.7886236252756229;
            c2[4,1] := 0.1909959101492760;
            c2[4,2] := 0.6389263649257017;
            c2[5,1] := 0.1675208146048472;
            c2[5,2] := 0.4517847275162215;
            c2[6,1] := 0.1374257286372761;
            c2[6,2] := 0.2324699157474680;
          elseif order == 13 then
            alpha := 0.2424910397561007;
            c1[1] := 0.4608848369928040;
            c2[1,1] := 0.2099813050274780;
            c2[1,2] := 0.8992478823790660;
            c2[2,1] := 0.2027250423101359;
            c2[2,2] := 0.8328117484224146;
            c2[3,1] := 0.1907635894058731;
            c2[3,2] := 0.7257379204691213;
            c2[4,1] := 0.1742280397887686;
            c2[4,2] := 0.5830640944868014;
            c2[5,1] := 0.1530858190490478;
            c2[5,2] := 0.4106192089751885;
            c2[6,1] := 0.1264090712880446;
            c2[6,2] := 0.2114980230156001;
          elseif order == 14 then
            alpha := 0.2331902368695848;
            c2[1,1] := 0.1986162311411235;
            c2[1,2] := 0.8876961808055535;
            c2[2,1] := 0.1946683341271615;
            c2[2,2] := 0.8500754229171967;
            c2[3,1] := 0.1868331332895056;
            c2[3,2] := 0.7764629313723603;
            c2[4,1] := 0.1752118757862992;
            c2[4,2] := 0.6699720402924552;
            c2[5,1] := 0.1598906457908402;
            c2[5,2] := 0.5348446712848934;
            c2[6,1] := 0.1407810153019944;
            c2[6,2] := 0.3755841316563539;
            c2[7,1] := 0.1169627966707339;
            c2[7,2] := 0.1937088226304455;
          elseif order == 15 then
            alpha := 0.2248854870552422;
            c1[1] := 0.4328492272335646;
            c2[1,1] := 0.1857292591004588;
            c2[1,2] := 0.8496337061962563;
            c2[2,1] := 0.1808644178280136;
            c2[2,2] := 0.8020517898136011;
            c2[3,1] := 0.1728264404199081;
            c2[3,2] := 0.7247449729331105;
            c2[4,1] := 0.1616970125901954;
            c2[4,2] := 0.6205369315943097;
            c2[5,1] := 0.1475257264578426;
            c2[5,2] := 0.4929612162355906;
            c2[6,1] := 0.1301861023357119;
            c2[6,2] := 0.3454770708040735;
            c2[7,1] := 0.1087810777120188;
            c2[7,2] := 0.1784526655428406;
          elseif order == 16 then
            alpha := 0.2174105053474761;
            c2[1,1] := 0.1765637967473151;
            c2[1,2] := 0.8377453068635511;
            c2[2,1] := 0.1738525357503125;
            c2[2,2] := 0.8102988957433199;
            c2[3,1] := 0.1684627004613343;
            c2[3,2] := 0.7563265923413258;
            c2[4,1] := 0.1604519074815815;
            c2[4,2] := 0.6776082294687619;
            c2[5,1] := 0.1498828607802206;
            c2[5,2] := 0.5766417034027680;
            c2[6,1] := 0.1367764717792823;
            c2[6,2] := 0.4563528264410489;
            c2[7,1] := 0.1209810465419295;
            c2[7,2] := 0.3193782657322374;
            c2[8,1] := 0.1016312648007554;
            c2[8,2] := 0.1652419227369036;
          elseif order == 17 then
            alpha := 0.2106355148193306;
            c1[1] := 0.4093223608497299;
            c2[1,1] := 0.1664014345826274;
            c2[1,2] := 0.8067173752345952;
            c2[2,1] := 0.1629839591538256;
            c2[2,2] := 0.7712924931447541;
            c2[3,1] := 0.1573277802512491;
            c2[3,2] := 0.7134213666303411;
            c2[4,1] := 0.1494828185148637;
            c2[4,2] := 0.6347841731714884;
            c2[5,1] := 0.1394948812681826;
            c2[5,2] := 0.5375594414619047;
            c2[6,1] := 0.1273627583380806;
            c2[6,2] := 0.4241608926375478;
            c2[7,1] := 0.1129187258461290;
            c2[7,2] := 0.2965752009703245;
            c2[8,1] := 0.9533357359908857e-1;
            c2[8,2] := 0.1537041700889585;
          elseif order == 18 then
            alpha := 0.2044575288651841;
            c2[1,1] := 0.1588768571976356;
            c2[1,2] := 0.7951914263212913;
            c2[2,1] := 0.1569357024981854;
            c2[2,2] := 0.7744529690772538;
            c2[3,1] := 0.1530722206358810;
            c2[3,2] := 0.7335304425992080;
            c2[4,1] := 0.1473206710524167;
            c2[4,2] := 0.6735038935387268;
            c2[5,1] := 0.1397225420331520;
            c2[5,2] := 0.5959151542621590;
            c2[6,1] := 0.1303092459809849;
            c2[6,2] := 0.5026483447894845;
            c2[7,1] := 0.1190627367060072;
            c2[7,2] := 0.3956893824587150;
            c2[8,1] := 0.1058058030798994;
            c2[8,2] := 0.2765091830730650;
            c2[9,1] := 0.8974708108800873e-1;
            c2[9,2] := 0.1435505288284833;
          elseif order == 19 then
            alpha := 0.1987936248083529;
            c1[1] := 0.3892259966869526;
            c2[1,1] := 0.1506640012172225;
            c2[1,2] := 0.7693121733774260;
            c2[2,1] := 0.1481728062796673;
            c2[2,2] := 0.7421133586741549;
            c2[3,1] := 0.1440444668388838;
            c2[3,2] := 0.6975075386214800;
            c2[4,1] := 0.1383101628540374;
            c2[4,2] := 0.6365464378910025;
            c2[5,1] := 0.1310032283190998;
            c2[5,2] := 0.5606211948462122;
            c2[6,1] := 0.1221431166405330;
            c2[6,2] := 0.4713530424221445;
            c2[7,1] := 0.1116991161103884;
            c2[7,2] := 0.3703717538617073;
            c2[8,1] := 0.9948917351196349e-1;
            c2[8,2] := 0.2587371155559744;
            c2[9,1] := 0.8475989238107367e-1;
            c2[9,2] := 0.1345537894555993;
          elseif order == 20 then
            alpha := 0.1935761760416219;
            c2[1,1] := 0.1443871348337404;
            c2[1,2] := 0.7584165598446141;
            c2[2,1] := 0.1429501891353184;
            c2[2,2] := 0.7423000962318863;
            c2[3,1] := 0.1400877384920004;
            c2[3,2] := 0.7104185332215555;
            c2[4,1] := 0.1358210369491446;
            c2[4,2] := 0.6634599783272630;
            c2[5,1] := 0.1301773703034290;
            c2[5,2] := 0.6024175491895959;
            c2[6,1] := 0.1231826501439148;
            c2[6,2] := 0.5285332736326852;
            c2[7,1] := 0.1148465498575254;
            c2[7,2] := 0.4431977385498628;
            c2[8,1] := 0.1051289462376788;
            c2[8,2] := 0.3477444062821162;
            c2[9,1] := 0.9384622797485121e-1;
            c2[9,2] := 0.2429038300327729;
            c2[10,1] := 0.8028211612831444e-1;
            c2[10,2] := 0.1265329974009533;
          elseif order == 21 then
            alpha := 0.1887494014766075;
            c1[1] := 0.3718070668941645;
            c2[1,1] := 0.1376151928386445;
            c2[1,2] := 0.7364290859445481;
            c2[2,1] := 0.1357438914390695;
            c2[2,2] := 0.7150167318935022;
            c2[3,1] := 0.1326398453462415;
            c2[3,2] := 0.6798001808470175;
            c2[4,1] := 0.1283231214897678;
            c2[4,2] := 0.6314663440439816;
            c2[5,1] := 0.1228169159777534;
            c2[5,2] := 0.5709353626166905;
            c2[6,1] := 0.1161406100773184;
            c2[6,2] := 0.4993087153571335;
            c2[7,1] := 0.1082959649233524;
            c2[7,2] := 0.4177766148584385;
            c2[8,1] := 0.9923596957485723e-1;
            c2[8,2] := 0.3274257287232124;
            c2[9,1] := 0.8877776108724853e-1;
            c2[9,2] := 0.2287218166767916;
            c2[10,1] := 0.7624076527736326e-1;
            c2[10,2] := 0.1193423971506988;
          elseif order == 22 then
            alpha := 0.1842668221199706;
            c2[1,1] := 0.1323053462701543;
            c2[1,2] := 0.7262446126765204;
            c2[2,1] := 0.1312121721769772;
            c2[2,2] := 0.7134286088450949;
            c2[3,1] := 0.1290330911166814;
            c2[3,2] := 0.6880287870435514;
            c2[4,1] := 0.1257817990372067;
            c2[4,2] := 0.6505015800059301;
            c2[5,1] := 0.1214765261983008;
            c2[5,2] := 0.6015107185211451;
            c2[6,1] := 0.1161365140967959;
            c2[6,2] := 0.5418983553698413;
            c2[7,1] := 0.1097755171533100;
            c2[7,2] := 0.4726370779831614;
            c2[8,1] := 0.1023889478519956;
            c2[8,2] := 0.3947439506537486;
            c2[9,1] := 0.9392485861253800e-1;
            c2[9,2] := 0.3090996703083202;
            c2[10,1] := 0.8420273775456455e-1;
            c2[10,2] := 0.2159561978556017;
            c2[11,1] := 0.7257600023938262e-1;
            c2[11,2] := 0.1128633732721116;
          elseif order == 23 then
            alpha := 0.1800893554453722;
            c1[1] := 0.3565232673929280;
            c2[1,1] := 0.1266275171652706;
            c2[1,2] := 0.7072778066734162;
            c2[2,1] := 0.1251865227648538;
            c2[2,2] := 0.6900676345785905;
            c2[3,1] := 0.1227944815236645;
            c2[3,2] := 0.6617011100576023;
            c2[4,1] := 0.1194647013077667;
            c2[4,2] := 0.6226432315773119;
            c2[5,1] := 0.1152132989252356;
            c2[5,2] := 0.5735222810625359;
            c2[6,1] := 0.1100558598478487;
            c2[6,2] := 0.5151027978024605;
            c2[7,1] := 0.1040013558214886;
            c2[7,2] := 0.4482410942032739;
            c2[8,1] := 0.9704014176512626e-1;
            c2[8,2] := 0.3738049984631116;
            c2[9,1] := 0.8911683905758054e-1;
            c2[9,2] := 0.2925028692588410;
            c2[10,1] := 0.8005438265072295e-1;
            c2[10,2] := 0.2044134600278901;
            c2[11,1] := 0.6923832296800832e-1;
            c2[11,2] := 0.1069984887283394;
          elseif order == 24 then
            alpha := 0.1761838665838427;
            c2[1,1] := 0.1220804912720132;
            c2[1,2] := 0.6978026874156063;
            c2[2,1] := 0.1212296762358897;
            c2[2,2] := 0.6874139794926736;
            c2[3,1] := 0.1195328372961027;
            c2[3,2] := 0.6667954259551859;
            c2[4,1] := 0.1169990987333593;
            c2[4,2] := 0.6362602049901176;
            c2[5,1] := 0.1136409040480130;
            c2[5,2] := 0.5962662188435553;
            c2[6,1] := 0.1094722001757955;
            c2[6,2] := 0.5474001634109253;
            c2[7,1] := 0.1045052832229087;
            c2[7,2] := 0.4903523180249535;
            c2[8,1] := 0.9874509806025907e-1;
            c2[8,2] := 0.4258751523524645;
            c2[9,1] := 0.9217799943472177e-1;
            c2[9,2] := 0.3547079765396403;
            c2[10,1] := 0.8474633796250476e-1;
            c2[10,2] := 0.2774145482392767;
            c2[11,1] := 0.7627722381240495e-1;
            c2[11,2] := 0.1939329108084139;
            c2[12,1] := 0.6618645465422745e-1;
            c2[12,2] := 0.1016670147947242;
          elseif order == 25 then
            alpha := 0.1725220521949266;
            c1[1] := 0.3429735385896000;
            c2[1,1] := 0.1172525033170618;
            c2[1,2] := 0.6812327932576614;
            c2[2,1] := 0.1161194585333535;
            c2[2,2] := 0.6671566071153211;
            c2[3,1] := 0.1142375145794466;
            c2[3,2] := 0.6439167855053158;
            c2[4,1] := 0.1116157454252308;
            c2[4,2] := 0.6118378416180135;
            c2[5,1] := 0.1082654809459177;
            c2[5,2] := 0.5713609763370088;
            c2[6,1] := 0.1041985674230918;
            c2[6,2] := 0.5230289949762722;
            c2[7,1] := 0.9942439308123559e-1;
            c2[7,2] := 0.4674627926041906;
            c2[8,1] := 0.9394453593830893e-1;
            c2[8,2] := 0.4053226688298811;
            c2[9,1] := 0.8774221237222533e-1;
            c2[9,2] := 0.3372372276379071;
            c2[10,1] := 0.8075839512216483e-1;
            c2[10,2] := 0.2636485508005428;
            c2[11,1] := 0.7282483286646764e-1;
            c2[11,2] := 0.1843801345273085;
            c2[12,1] := 0.6338571166846652e-1;
            c2[12,2] := 0.9680153764737715e-1;
          elseif order == 26 then
            alpha := 0.1690795702796737;
            c2[1,1] := 0.1133168695796030;
            c2[1,2] := 0.6724297955493932;
            c2[2,1] := 0.1126417845769961;
            c2[2,2] := 0.6638709519790540;
            c2[3,1] := 0.1112948749545606;
            c2[3,2] := 0.6468652038763624;
            c2[4,1] := 0.1092823986944244;
            c2[4,2] := 0.6216337070799265;
            c2[5,1] := 0.1066130386697976;
            c2[5,2] := 0.5885011413992190;
            c2[6,1] := 0.1032969057045413;
            c2[6,2] := 0.5478864278297548;
            c2[7,1] := 0.9934388184210715e-1;
            c2[7,2] := 0.5002885306054287;
            c2[8,1] := 0.9476081523436283e-1;
            c2[8,2] := 0.4462644847551711;
            c2[9,1] := 0.8954648464575577e-1;
            c2[9,2] := 0.3863930785049522;
            c2[10,1] := 0.8368166847159917e-1;
            c2[10,2] := 0.3212074592527143;
            c2[11,1] := 0.7710664731701103e-1;
            c2[11,2] := 0.2510470347119383;
            c2[12,1] := 0.6965807988411425e-1;
            c2[12,2] := 0.1756419294111342;
            c2[13,1] := 0.6080674930548766e-1;
            c2[13,2] := 0.9234535279274277e-1;
          elseif order == 27 then
            alpha := 0.1658353543067995;
            c1[1] := 0.3308543720638957;
            c2[1,1] := 0.1091618578712746;
            c2[1,2] := 0.6577977071169651;
            c2[2,1] := 0.1082549561495043;
            c2[2,2] := 0.6461121666520275;
            c2[3,1] := 0.1067479247890451;
            c2[3,2] := 0.6267937760991321;
            c2[4,1] := 0.1046471079537577;
            c2[4,2] := 0.6000750116745808;
            c2[5,1] := 0.1019605976654259;
            c2[5,2] := 0.5662734183049320;
            c2[6,1] := 0.9869726954433709e-1;
            c2[6,2] := 0.5257827234948534;
            c2[7,1] := 0.9486520934132483e-1;
            c2[7,2] := 0.4790595019077763;
            c2[8,1] := 0.9046906518775348e-1;
            c2[8,2] := 0.4266025862147336;
            c2[9,1] := 0.8550529998276152e-1;
            c2[9,2] := 0.3689188223512328;
            c2[10,1] := 0.7995282239306020e-1;
            c2[10,2] := 0.3064589322702932;
            c2[11,1] := 0.7375174596252882e-1;
            c2[11,2] := 0.2394754504667310;
            c2[12,1] := 0.6674377263329041e-1;
            c2[12,2] := 0.1676223546666024;
            c2[13,1] := 0.5842458027529246e-1;
            c2[13,2] := 0.8825044329219431e-1;
          elseif order == 28 then
            alpha := 0.1627710671942929;
            c2[1,1] := 0.1057232656113488;
            c2[1,2] := 0.6496161226860832;
            c2[2,1] := 0.1051786825724864;
            c2[2,2] := 0.6424661279909941;
            c2[3,1] := 0.1040917964935006;
            c2[3,2] := 0.6282470268918791;
            c2[4,1] := 0.1024670101953951;
            c2[4,2] := 0.6071189030701136;
            c2[5,1] := 0.1003105109519892;
            c2[5,2] := 0.5793175191747016;
            c2[6,1] := 0.9762969425430802e-1;
            c2[6,2] := 0.5451486608855443;
            c2[7,1] := 0.9443223803058400e-1;
            c2[7,2] := 0.5049796971628137;
            c2[8,1] := 0.9072460982036488e-1;
            c2[8,2] := 0.4592270546572523;
            c2[9,1] := 0.8650956423253280e-1;
            c2[9,2] := 0.4083368605952977;
            c2[10,1] := 0.8178165740374893e-1;
            c2[10,2] := 0.3527525188880655;
            c2[11,1] := 0.7651838885868020e-1;
            c2[11,2] := 0.2928534570013572;
            c2[12,1] := 0.7066010532447490e-1;
            c2[12,2] := 0.2288185204390681;
            c2[13,1] := 0.6405358596145789e-1;
            c2[13,2] := 0.1602396172588190;
            c2[14,1] := 0.5621780070227172e-1;
            c2[14,2] := 0.8447589564915071e-1;
          elseif order == 29 then
            alpha := 0.1598706626277596;
            c1[1] := 0.3199314513011623;
            c2[1,1] := 0.1021101032532951;
            c2[1,2] := 0.6365758882240111;
            c2[2,1] := 0.1013729819392774;
            c2[2,2] := 0.6267495975736321;
            c2[3,1] := 0.1001476175660628;
            c2[3,2] := 0.6104876178266819;
            c2[4,1] := 0.9843854640428316e-1;
            c2[4,2] := 0.5879603139195113;
            c2[5,1] := 0.9625164534591696e-1;
            c2[5,2] := 0.5594012291050210;
            c2[6,1] := 0.9359356960417668e-1;
            c2[6,2] := 0.5251016150410664;
            c2[7,1] := 0.9047086748649986e-1;
            c2[7,2] := 0.4854024475590397;
            c2[8,1] := 0.8688856407189167e-1;
            c2[8,2] := 0.4406826457109709;
            c2[9,1] := 0.8284779224069856e-1;
            c2[9,2] := 0.3913408089298914;
            c2[10,1] := 0.7834154620997181e-1;
            c2[10,2] := 0.3377643999400627;
            c2[11,1] := 0.7334628941928766e-1;
            c2[11,2] := 0.2802710651919946;
            c2[12,1] := 0.6780290487362146e-1;
            c2[12,2] := 0.2189770008083379;
            c2[13,1] := 0.6156321231528423e-1;
            c2[13,2] := 0.1534235999306070;
            c2[14,1] := 0.5416797446761512e-1;
            c2[14,2] := 0.8098664736760292e-1;
          elseif order == 30 then
            alpha := 0.1571200296252450;
            c2[1,1] := 0.9908074847842124e-1;
            c2[1,2] := 0.6289618807831557;
            c2[2,1] := 0.9863509708328196e-1;
            c2[2,2] := 0.6229164525571278;
            c2[3,1] := 0.9774542692037148e-1;
            c2[3,2] := 0.6108853364240036;
            c2[4,1] := 0.9641490581986484e-1;
            c2[4,2] := 0.5929869253412513;
            c2[5,1] := 0.9464802912225441e-1;
            c2[5,2] := 0.5693960175547550;
            c2[6,1] := 0.9245027206218041e-1;
            c2[6,2] := 0.5403402396359503;
            c2[7,1] := 0.8982754584112941e-1;
            c2[7,2] := 0.5060948065875106;
            c2[8,1] := 0.8678535291732599e-1;
            c2[8,2] := 0.4669749797983789;
            c2[9,1] := 0.8332744242052199e-1;
            c2[9,2] := 0.4233249626334694;
            c2[10,1] := 0.7945356393775309e-1;
            c2[10,2] := 0.3755006094498054;
            c2[11,1] := 0.7515543969833788e-1;
            c2[11,2] := 0.3238400339292700;
            c2[12,1] := 0.7040879901685638e-1;
            c2[12,2] := 0.2686072427439079;
            c2[13,1] := 0.6515528854010540e-1;
            c2[13,2] := 0.2098650589782619;
            c2[14,1] := 0.5925168237177876e-1;
            c2[14,2] := 0.1471138832654873;
            c2[15,1] := 0.5225913954211672e-1;
            c2[15,2] := 0.7775248839507864e-1;
          elseif order == 31 then
            alpha := 0.1545067022920929;
            c1[1] := 0.3100206996451866;
            c2[1,1] := 0.9591020358831668e-1;
            c2[1,2] := 0.6172474793293396;
            c2[2,1] := 0.9530301275601203e-1;
            c2[2,2] := 0.6088916323460413;
            c2[3,1] := 0.9429332655402368e-1;
            c2[3,2] := 0.5950511595503025;
            c2[4,1] := 0.9288445429894548e-1;
            c2[4,2] := 0.5758534119053522;
            c2[5,1] := 0.9108073420087422e-1;
            c2[5,2] := 0.5514734636081183;
            c2[6,1] := 0.8888719137536870e-1;
            c2[6,2] := 0.5221306199481831;
            c2[7,1] := 0.8630901440239650e-1;
            c2[7,2] := 0.4880834248148061;
            c2[8,1] := 0.8335074993373294e-1;
            c2[8,2] := 0.4496225358496770;
            c2[9,1] := 0.8001502494376102e-1;
            c2[9,2] := 0.4070602306679052;
            c2[10,1] := 0.7630041338037624e-1;
            c2[10,2] := 0.3607139804818122;
            c2[11,1] := 0.7219760885744920e-1;
            c2[11,2] := 0.3108783301229550;
            c2[12,1] := 0.6768185077153345e-1;
            c2[12,2] := 0.2577706252514497;
            c2[13,1] := 0.6269571766328638e-1;
            c2[13,2] := 0.2014081375889921;
            c2[14,1] := 0.5710081766945065e-1;
            c2[14,2] := 0.1412581515841926;
            c2[15,1] := 0.5047740914807019e-1;
            c2[15,2] := 0.7474725873250158e-1;
          elseif order == 32 then
            alpha := 0.1520196210848210;
            c2[1,1] := 0.9322163554339406e-1;
            c2[1,2] := 0.6101488690506050;
            c2[2,1] := 0.9285233997694042e-1;
            c2[2,2] := 0.6049832320721264;
            c2[3,1] := 0.9211494244473163e-1;
            c2[3,2] := 0.5946969295569034;
            c2[4,1] := 0.9101176786042449e-1;
            c2[4,2] := 0.5793791854364477;
            c2[5,1] := 0.8954614071360517e-1;
            c2[5,2] := 0.5591619969234026;
            c2[6,1] := 0.8772216763680164e-1;
            c2[6,2] := 0.5342177994699602;
            c2[7,1] := 0.8554440426912734e-1;
            c2[7,2] := 0.5047560942986598;
            c2[8,1] := 0.8301735302045588e-1;
            c2[8,2] := 0.4710187048140929;
            c2[9,1] := 0.8014469519188161e-1;
            c2[9,2] := 0.4332730387207936;
            c2[10,1] := 0.7692807528893225e-1;
            c2[10,2] := 0.3918021436411035;
            c2[11,1] := 0.7336507157284898e-1;
            c2[11,2] := 0.3468890521471250;
            c2[12,1] := 0.6944555312763458e-1;
            c2[12,2] := 0.2987898029050460;
            c2[13,1] := 0.6514446669420571e-1;
            c2[13,2] := 0.2476810747407199;
            c2[14,1] := 0.6040544477732702e-1;
            c2[14,2] := 0.1935412053397663;
            c2[15,1] := 0.5509478650672775e-1;
            c2[15,2] := 0.1358108994174911;
            c2[16,1] := 0.4881064725720192e-1;
            c2[16,2] := 0.7194819894416505e-1;
          elseif order == 33 then
            alpha := 0.1496489351138032;
            c1[1] := 0.3009752799176432;
            c2[1,1] := 0.9041725460994505e-1;
            c2[1,2] := 0.5995521047364046;
            c2[2,1] := 0.8991117804113002e-1;
            c2[2,2] := 0.5923764112099496;
            c2[3,1] := 0.8906941547422532e-1;
            c2[3,2] := 0.5804822013853129;
            c2[4,1] := 0.8789442491445575e-1;
            c2[4,2] := 0.5639663528946501;
            c2[5,1] := 0.8638945831033775e-1;
            c2[5,2] := 0.5429623519607796;
            c2[6,1] := 0.8455834602616358e-1;
            c2[6,2] := 0.5176379938389326;
            c2[7,1] := 0.8240517431382334e-1;
            c2[7,2] := 0.4881921474066189;
            c2[8,1] := 0.7993380417355076e-1;
            c2[8,2] := 0.4548502528082586;
            c2[9,1] := 0.7714713890732801e-1;
            c2[9,2] := 0.4178579388038483;
            c2[10,1] := 0.7404596598181127e-1;
            c2[10,2] := 0.3774715722484659;
            c2[11,1] := 0.7062702339160462e-1;
            c2[11,2] := 0.3339432938810453;
            c2[12,1] := 0.6687952672391507e-1;
            c2[12,2] := 0.2874950693388235;
            c2[13,1] := 0.6277828912909767e-1;
            c2[13,2] := 0.2382680702894708;
            c2[14,1] := 0.5826808305383988e-1;
            c2[14,2] := 0.1862073169968455;
            c2[15,1] := 0.5321974125363517e-1;
            c2[15,2] := 0.1307323751236313;
            c2[16,1] := 0.4724820282032780e-1;
            c2[16,2] := 0.6933542082177094e-1;
          elseif order == 34 then
            alpha := 0.1473858373968463;
            c2[1,1] := 0.8801537152275983e-1;
            c2[1,2] := 0.5929204288972172;
            c2[2,1] := 0.8770594341007476e-1;
            c2[2,2] := 0.5884653382247518;
            c2[3,1] := 0.8708797598072095e-1;
            c2[3,2] := 0.5795895850253119;
            c2[4,1] := 0.8616320590689187e-1;
            c2[4,2] := 0.5663615383647170;
            c2[5,1] := 0.8493413175570858e-1;
            c2[5,2] := 0.5488825092350877;
            c2[6,1] := 0.8340387368687513e-1;
            c2[6,2] := 0.5272851839324592;
            c2[7,1] := 0.8157596213131521e-1;
            c2[7,2] := 0.5017313864372913;
            c2[8,1] := 0.7945402670834270e-1;
            c2[8,2] := 0.4724089864574216;
            c2[9,1] := 0.7704133559556429e-1;
            c2[9,2] := 0.4395276256463053;
            c2[10,1] := 0.7434009635219704e-1;
            c2[10,2] := 0.4033126590648964;
            c2[11,1] := 0.7135035113853376e-1;
            c2[11,2] := 0.3639961488919042;
            c2[12,1] := 0.6806813160738834e-1;
            c2[12,2] := 0.3218025212900124;
            c2[13,1] := 0.6448214312000864e-1;
            c2[13,2] := 0.2769235521088158;
            c2[14,1] := 0.6056719318430530e-1;
            c2[14,2] := 0.2294693573271038;
            c2[15,1] := 0.5626925196925040e-1;
            c2[15,2] := 0.1793564218840015;
            c2[16,1] := 0.5146352031547277e-1;
            c2[16,2] := 0.1259877129326412;
            c2[17,1] := 0.4578069074410591e-1;
            c2[17,2] := 0.6689147319568768e-1;
          elseif order == 35 then
            alpha := 0.1452224267615486;
            c1[1] := 0.2926764667564367;
            c2[1,1] := 0.8551731299267280e-1;
            c2[1,2] := 0.5832758214629523;
            c2[2,1] := 0.8509109732853060e-1;
            c2[2,2] := 0.5770596582643844;
            c2[3,1] := 0.8438201446671953e-1;
            c2[3,2] := 0.5667497616665494;
            c2[4,1] := 0.8339191981579831e-1;
            c2[4,2] := 0.5524209816238369;
            c2[5,1] := 0.8212328610083385e-1;
            c2[5,2] := 0.5341766459916322;
            c2[6,1] := 0.8057906332198853e-1;
            c2[6,2] := 0.5121470053512750;
            c2[7,1] := 0.7876247299954955e-1;
            c2[7,2] := 0.4864870722254752;
            c2[8,1] := 0.7667670879950268e-1;
            c2[8,2] := 0.4573736721705665;
            c2[9,1] := 0.7432449556218945e-1;
            c2[9,2] := 0.4250013835198991;
            c2[10,1] := 0.7170742126011575e-1;
            c2[10,2] := 0.3895767735915445;
            c2[11,1] := 0.6882488171701314e-1;
            c2[11,2] := 0.3513097926737368;
            c2[12,1] := 0.6567231746957568e-1;
            c2[12,2] := 0.3103999917596611;
            c2[13,1] := 0.6223804362223595e-1;
            c2[13,2] := 0.2670123611280899;
            c2[14,1] := 0.5849696460782910e-1;
            c2[14,2] := 0.2212298104867592;
            c2[15,1] := 0.5439628409499822e-1;
            c2[15,2] := 0.1729443731341637;
            c2[16,1] := 0.4981540179136920e-1;
            c2[16,2] := 0.1215462157134930;
            c2[17,1] := 0.4439981033536435e-1;
            c2[17,2] := 0.6460098363520967e-1;
          elseif order == 36 then
            alpha := 0.1431515914458580;
            c2[1,1] := 0.8335881847130301e-1;
            c2[1,2] := 0.5770670512160201;
            c2[2,1] := 0.8309698922852212e-1;
            c2[2,2] := 0.5731929100172432;
            c2[3,1] := 0.8257400347039723e-1;
            c2[3,2] := 0.5654713811993058;
            c2[4,1] := 0.8179117911600136e-1;
            c2[4,2] := 0.5539556343603020;
            c2[5,1] := 0.8075042173126963e-1;
            c2[5,2] := 0.5387245649546684;
            c2[6,1] := 0.7945413151258206e-1;
            c2[6,2] := 0.5198817177723069;
            c2[7,1] := 0.7790506514288866e-1;
            c2[7,2] := 0.4975537629595409;
            c2[8,1] := 0.7610613635339480e-1;
            c2[8,2] := 0.4718884193866789;
            c2[9,1] := 0.7406012816626425e-1;
            c2[9,2] := 0.4430516443136726;
            c2[10,1] := 0.7176927060205631e-1;
            c2[10,2] := 0.4112237708115829;
            c2[11,1] := 0.6923460172504251e-1;
            c2[11,2] := 0.3765940116389730;
            c2[12,1] := 0.6645495833489556e-1;
            c2[12,2] := 0.3393522147815403;
            c2[13,1] := 0.6342528888937094e-1;
            c2[13,2] := 0.2996755899575573;
            c2[14,1] := 0.6013361864949449e-1;
            c2[14,2] := 0.2577053294053830;
            c2[15,1] := 0.5655503081322404e-1;
            c2[15,2] := 0.2135004731531631;
            c2[16,1] := 0.5263798119559069e-1;
            c2[16,2] := 0.1669320999865636;
            c2[17,1] := 0.4826589873626196e-1;
            c2[17,2] := 0.1173807590715484;
            c2[18,1] := 0.4309819397289806e-1;
            c2[18,2] := 0.6245036108880222e-1;
          elseif order == 37 then
            alpha := 0.1411669104782917;
            c1[1] := 0.2850271036215707;
            c2[1,1] := 0.8111958235023328e-1;
            c2[1,2] := 0.5682412610563970;
            c2[2,1] := 0.8075727567979578e-1;
            c2[2,2] := 0.5628142923227016;
            c2[3,1] := 0.8015440554413301e-1;
            c2[3,2] := 0.5538087696879930;
            c2[4,1] := 0.7931239302677386e-1;
            c2[4,2] := 0.5412833323304460;
            c2[5,1] := 0.7823314328639347e-1;
            c2[5,2] := 0.5253190555393968;
            c2[6,1] := 0.7691895211595101e-1;
            c2[6,2] := 0.5060183741977191;
            c2[7,1] := 0.7537237072011853e-1;
            c2[7,2] := 0.4835036020049034;
            c2[8,1] := 0.7359601294804538e-1;
            c2[8,2] := 0.4579149413954837;
            c2[9,1] := 0.7159227884849299e-1;
            c2[9,2] := 0.4294078049978829;
            c2[10,1] := 0.6936295002846032e-1;
            c2[10,2] := 0.3981491350382047;
            c2[11,1] := 0.6690857785828917e-1;
            c2[11,2] := 0.3643121502867948;
            c2[12,1] := 0.6422751692085542e-1;
            c2[12,2] := 0.3280684291406284;
            c2[13,1] := 0.6131430866206096e-1;
            c2[13,2] := 0.2895750997170303;
            c2[14,1] := 0.5815677249570920e-1;
            c2[14,2] := 0.2489521814805720;
            c2[15,1] := 0.5473023527947980e-1;
            c2[15,2] := 0.2062377435955363;
            c2[16,1] := 0.5098441033167034e-1;
            c2[16,2] := 0.1612849131645336;
            c2[17,1] := 0.4680658811093562e-1;
            c2[17,2] := 0.1134672937045305;
            c2[18,1] := 0.4186928031694695e-1;
            c2[18,2] := 0.6042754777339966e-1;
          elseif order == 38 then
            alpha := 0.1392625697140030;
            c2[1,1] := 0.7916943373658329e-1;
            c2[1,2] := 0.5624158631591745;
            c2[2,1] := 0.7894592250257840e-1;
            c2[2,2] := 0.5590219398777304;
            c2[3,1] := 0.7849941672384930e-1;
            c2[3,2] := 0.5522551628416841;
            c2[4,1] := 0.7783093084875645e-1;
            c2[4,2] := 0.5421574325808380;
            c2[5,1] := 0.7694193770482690e-1;
            c2[5,2] := 0.5287909941093643;
            c2[6,1] := 0.7583430534712885e-1;
            c2[6,2] := 0.5122376814029880;
            c2[7,1] := 0.7451020436122948e-1;
            c2[7,2] := 0.4925978555548549;
            c2[8,1] := 0.7297197617673508e-1;
            c2[8,2] := 0.4699889739625235;
            c2[9,1] := 0.7122194706992953e-1;
            c2[9,2] := 0.4445436860615774;
            c2[10,1] := 0.6926216260386816e-1;
            c2[10,2] := 0.4164072786327193;
            c2[11,1] := 0.6709399961255503e-1;
            c2[11,2] := 0.3857341621868851;
            c2[12,1] := 0.6471757977022456e-1;
            c2[12,2] := 0.3526828388476838;
            c2[13,1] := 0.6213084287116965e-1;
            c2[13,2] := 0.3174082831364342;
            c2[14,1] := 0.5932799638550641e-1;
            c2[14,2] := 0.2800495563550299;
            c2[15,1] := 0.5629672408524944e-1;
            c2[15,2] := 0.2407078154782509;
            c2[16,1] := 0.5301264751544952e-1;
            c2[16,2] := 0.1994026830553859;
            c2[17,1] := 0.4942673259817896e-1;
            c2[17,2] := 0.1559719194038917;
            c2[18,1] := 0.4542996716979947e-1;
            c2[18,2] := 0.1097844277878470;
            c2[19,1] := 0.4070720755433961e-1;
            c2[19,2] := 0.5852181110523043e-1;
          elseif order == 39 then
            alpha := 0.1374332900196804;
            c1[1] := 0.2779468246419593;
            c2[1,1] := 0.7715084161825772e-1;
            c2[1,2] := 0.5543001331300056;
            c2[2,1] := 0.7684028301163326e-1;
            c2[2,2] := 0.5495289890712267;
            c2[3,1] := 0.7632343924866024e-1;
            c2[3,2] := 0.5416083298429741;
            c2[4,1] := 0.7560141319808483e-1;
            c2[4,2] := 0.5305846713929198;
            c2[5,1] := 0.7467569064745969e-1;
            c2[5,2] := 0.5165224112570647;
            c2[6,1] := 0.7354807648551346e-1;
            c2[6,2] := 0.4995030679271456;
            c2[7,1] := 0.7222060351121389e-1;
            c2[7,2] := 0.4796242430956156;
            c2[8,1] := 0.7069540462458585e-1;
            c2[8,2] := 0.4569982440368368;
            c2[9,1] := 0.6897453353492381e-1;
            c2[9,2] := 0.4317502624832354;
            c2[10,1] := 0.6705970959388781e-1;
            c2[10,2] := 0.4040159353969854;
            c2[11,1] := 0.6495194541066725e-1;
            c2[11,2] := 0.3739379843169939;
            c2[12,1] := 0.6265098412417610e-1;
            c2[12,2] := 0.3416613843816217;
            c2[13,1] := 0.6015440984955930e-1;
            c2[13,2] := 0.3073260166338746;
            c2[14,1] := 0.5745615876877304e-1;
            c2[14,2] := 0.2710546723961181;
            c2[15,1] := 0.5454383762391338e-1;
            c2[15,2] := 0.2329316824061170;
            c2[16,1] := 0.5139340231935751e-1;
            c2[16,2] := 0.1929604256043231;
            c2[17,1] := 0.4795705862458131e-1;
            c2[17,2] := 0.1509655259246037;
            c2[18,1] := 0.4412933231935506e-1;
            c2[18,2] := 0.1063130748962878;
            c2[19,1] := 0.3960672309405603e-1;
            c2[19,2] := 0.5672356837211527e-1;
          elseif order == 40 then
            alpha := 0.1356742655825434;
            c2[1,1] := 0.7538038374294594e-1;
            c2[1,2] := 0.5488228264329617;
            c2[2,1] := 0.7518806529402738e-1;
            c2[2,2] := 0.5458297722483311;
            c2[3,1] := 0.7480383050347119e-1;
            c2[3,2] := 0.5398604576730540;
            c2[4,1] := 0.7422847031965465e-1;
            c2[4,2] := 0.5309482987446206;
            c2[5,1] := 0.7346313704205006e-1;
            c2[5,2] := 0.5191429845322307;
            c2[6,1] := 0.7250930053201402e-1;
            c2[6,2] := 0.5045099368431007;
            c2[7,1] := 0.7136868456879621e-1;
            c2[7,2] := 0.4871295553902607;
            c2[8,1] := 0.7004317764946634e-1;
            c2[8,2] := 0.4670962098860498;
            c2[9,1] := 0.6853470921527828e-1;
            c2[9,2] := 0.4445169164956202;
            c2[10,1] := 0.6684507689945471e-1;
            c2[10,2] := 0.4195095960479698;
            c2[11,1] := 0.6497570123412630e-1;
            c2[11,2] := 0.3922007419030645;
            c2[12,1] := 0.6292726794917847e-1;
            c2[12,2] := 0.3627221993494397;
            c2[13,1] := 0.6069918741663154e-1;
            c2[13,2] := 0.3312065181294388;
            c2[14,1] := 0.5828873983769410e-1;
            c2[14,2] := 0.2977798532686911;
            c2[15,1] := 0.5568964389813015e-1;
            c2[15,2] := 0.2625503293999835;
            c2[16,1] := 0.5288947816690705e-1;
            c2[16,2] := 0.2255872486520188;
            c2[17,1] := 0.4986456327645859e-1;
            c2[17,2] := 0.1868796731919594;
            c2[18,1] := 0.4656832613054458e-1;
            c2[18,2] := 0.1462410193532463;
            c2[19,1] := 0.4289867647614935e-1;
            c2[19,2] := 0.1030361558710747;
            c2[20,1] := 0.3856310684054106e-1;
            c2[20,2] := 0.5502423832293889e-1;
          elseif order == 41 then
            alpha := 0.1339811106984253;
            c1[1] := 0.2713685065531391;
            c2[1,1] := 0.7355140275160984e-1;
            c2[1,2] := 0.5413274778282860;
            c2[2,1] := 0.7328319082267173e-1;
            c2[2,2] := 0.5371064088294270;
            c2[3,1] := 0.7283676160772547e-1;
            c2[3,2] := 0.5300963437270770;
            c2[4,1] := 0.7221298133014343e-1;
            c2[4,2] := 0.5203345998371490;
            c2[5,1] := 0.7141302173623395e-1;
            c2[5,2] := 0.5078728971879841;
            c2[6,1] := 0.7043831559982149e-1;
            c2[6,2] := 0.4927768111819803;
            c2[7,1] := 0.6929049381827268e-1;
            c2[7,2] := 0.4751250308594139;
            c2[8,1] := 0.6797129849758392e-1;
            c2[8,2] := 0.4550083840638406;
            c2[9,1] := 0.6648246325101609e-1;
            c2[9,2] := 0.4325285673076087;
            c2[10,1] := 0.6482554675958526e-1;
            c2[10,2] := 0.4077964789091151;
            c2[11,1] := 0.6300169683004558e-1;
            c2[11,2] := 0.3809299858742483;
            c2[12,1] := 0.6101130648543355e-1;
            c2[12,2] := 0.3520508315700898;
            c2[13,1] := 0.5885349417435808e-1;
            c2[13,2] := 0.3212801560701271;
            c2[14,1] := 0.5652528148656809e-1;
            c2[14,2] := 0.2887316252774887;
            c2[15,1] := 0.5402021575818373e-1;
            c2[15,2] := 0.2545001287790888;
            c2[16,1] := 0.5132588802608274e-1;
            c2[16,2] := 0.2186415296842951;
            c2[17,1] := 0.4841900639702602e-1;
            c2[17,2] := 0.1811322622296060;
            c2[18,1] := 0.4525419574485134e-1;
            c2[18,2] := 0.1417762065404688;
            c2[19,1] := 0.4173260173087802e-1;
            c2[19,2] := 0.9993834530966510e-1;
            c2[20,1] := 0.3757210572966463e-1;
            c2[20,2] := 0.5341611499960143e-1;
          else
            Streams.error("输入参数顺序(= " + String(order) + 
              ")不在1...41的范围内");
          end if;

          annotation(Documentation(info="<html><p>
<em>n</em>阶贝塞尔滤波器的传递函数H(p)式为
</p>
<pre><code >Bn(0)
H(p) = -------
Bn(p)</code></pre><p>
分母多项式为
</p>
<pre><code >n             n  (2n - k)!       p^k
Bn(p) = sum c_k*p^k = sum ----------- * -------   (1)
k=0           k=0 (n - k)!k!    2^(n-k)</code></pre><p>
分子为
</p>
<pre><code >(2n)!     1
Bn(0) = c_0 = ------- * ---- .                    (2)
n!      2^n</code></pre><p>
虽然系数c_k是整数， 但由于系数随阶数n快速增长 (阶数n=20和阶数n=40的c_0分别约为0.3e24和0.8e59)， 因此不宜以未定义因子形式使用多项式。
</p>
<p>
因此，多项式Bn(p)被因子化为一阶和二阶多项式， 其实数系数与零点和极点表示法相对应，并在本库中使用。
</p>
<p>
该函数返回通过归一化传递函数因式分解得到的系数。
</p>
<pre><code >H\\\\\\'(p\\\\\\') = H(p),  p\\\\\\' = p/w0</code></pre><p>
以及
</p>
<pre><code >alpha = 1/w0</code></pre><p>
频率w0切点的倒数， 此时传递函数的增益降低3dB。
</p>
<p>
系数和截止频率均以符号方式计算， 最终通过高精度计算进行评估。 计算结果以实数形式存储在该函数中。
</p>
<h4>归一化贝塞尔滤波器系数的计算</h4><p>
等式
</p>
<pre><code >abs(H(j*w0)) = abs(Bn(0)/Bn(j*w0)) = 10^(-3/20)</code></pre><p>
在必须满足截止频率w=w0的要求基础上，从而得出
</p>
<pre><code >[Re(Bn(j*w0))]^2 + [Im(Bn(j*w0))]^2 - (Bn(0)^2)*10^(3/10) = 0</code></pre><p>
对于每个阶n，它都有一个实数解w0。 先用符号计算， 然后用根据(1)和(2)计算出的高精确值系数c_k进行评估。
</p>
<p>
有了w0， 就可以通过计算分母多项式的零点来计算因式分解多项式的系数
</p>
<pre><code >n
Bn(p) = sum w0^k*c_k*(p/w0)^k
k=0</code></pre><p>
<span style=\"color: rgb(51, 51, 51);\">归一化传递函数 H\\'(p\\') 的系数。如果 n 为偶数，则存在 n/2 对共轭复数零点（β ± j*γ）；如果 n 为奇数，则额外存在一个实数零点（α）。最后，得到多项式的系数 a、b1_k 和 b2_k</span>
</p>
<pre><code >a*p + 1,  n is odd</code></pre><p>
和
</p>
<pre><code >b2_k*p^2 + b1_k*p + 1,   k = 1,... div(n,2)</code></pre><p>
结果来自
</p>
<pre><code >a = -1/alpha</code></pre><p>
和
</p>
<pre><code >b2_k = 1/(beta_k^2 + gamma_k^2) b1_k = -2*beta_k/(beta_k^2 + gamma_k^2)</code></pre><p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"  ));
        end BesselBaseCoefficients;

        function toHighestPowerOne 
          "将滤波器转换为s的最大幂等于1的形式"
          extends Modelica.Icons.Function;

          input Real den1[:] "[s]多项式系数(den1[i]*s+1)";
          input Real den2[:,2] 
            "[s^2,s]多项式系数(den2[i,1]*s^2+den2[i,2]*s+1)";
          output Real cr[size(den1, 1)] 
            "[s^0]多项式系数cr[i]*(s+1/cr[i])";
          output Real c0[size(den2, 1)] 
            "[s^0]多项式系数(s^2+(den2[i,2]/den2[i,1])*s+(1/den2[i,1]))";
          output Real c1[size(den2, 1)] 
            "[s^1]多项式系数(s^2+(den2[i,2]/den2[i,1])*s+(1/den2[i,1]))";
          annotation();
        algorithm
          for i in 1:size(den1, 1) loop
            cr[i] := 1 / den1[i];
          end for;

          for i in 1:size(den2, 1) loop
            c1[i] := den2[i,2] / den2[i,1];
            c0[i] := 1 / den2[i,1];
          end for;
        end toHighestPowerOne;

        function normalizationFactor 
          "计算低通滤波器的修正系数，使截止频率处的振幅为-3db(=10^(-3/20)=0.70794...)"
          extends Modelica.Icons.Function;

          import Modelica.Utilities.Streams;

          input Real c1[:] 
            "[p]多项式分母系数(c1[i}*p+1)";
          input Real c2[:,2] 
            "[p^2,p]多项式分母系数(c2[i,1]*p^2+c2[i,2]*p+1)";
          output Real alpha "修正系数(用alpha*p代替p)";
        protected
          Real alpha_min;
          Real alpha_max;

        public
          function normalizationResidue 
            "修正系数计算的残差"
            extends Modelica.Icons.Function;
            input Real c1[:] 
              "[p]多项式分母系数(c1[i]*p+1)";
            input Real c2[:,2] 
              "[p^2,p]多项式分母系数(c2[i,1]*p^2+c2[i,2]*p+1)";
            input Real alpha;
            output Real residue;
          protected
            constant Real beta = 10 ^ (-3 / 20) 
              "所需的-3db振幅，即-3db=20*log(beta)";
            Real cc1;
            Real cc2;
            Real p;
            Real alpha2 = alpha * alpha;
            Real alpha4 = alpha2 * alpha2;
            Real A2 = 1.0;
            annotation();
          algorithm
            assert(size(c1, 1) <= 1, "内部错误2(不应发生)");
            if size(c1, 1) == 1 then
              cc1 := c1[1] * c1[1];
              p := 1 + cc1 * alpha2;
              A2 := A2 * p;
            end if;
            for i in 1:size(c2, 1) loop
              cc1 := c2[i,2] * c2[i,2] - 2 * c2[i,1];
              cc2 := c2[i,1] * c2[i,1];
              p := 1 + cc1 * alpha2 + cc2 * alpha4;
              A2 := A2 * p;
            end for;
            residue := 1 / sqrt(A2) - beta;
          end normalizationResidue;

        protected
          function findInterval "查找根的区间"
            extends Modelica.Icons.Function;
            input Real c1[:] 
              "[p]多项式分母系数(a*p+1)";
            input Real c2[:,2] 
              "[p^2,p]多项式分母系数(b*p^2+a*p+1)";
            output Real alpha_min;
            output Real alpha_max;
          protected
            Real alpha = 1.0;
            Real residue;
            annotation();
          algorithm
            alpha_min := 0;
            residue := normalizationResidue(c1, c2, alpha);
            if residue < 0 then
              alpha_max := alpha;
            else
              while residue >= 0 loop
                alpha := 1.1 * alpha;
                residue := normalizationResidue(c1, c2, alpha);
              end while;
              alpha_max := alpha;
            end if;
          end findInterval;

        public
          function solveOneNonlinearEquation 
            "Solve f(u) = 0;f(u_min)和f(u_max)的符号必须不同"
            extends Modelica.Icons.Function;
            import Modelica.Utilities.Streams.error;

            input Real c1[:] 
              "[p]多项式分母系数(c1[i]*p+1)";
            input Real c2[:,2] 
              "[p^2,p]多项式分母系数(c2[i,1]*p^2+c2[i,2]*p+1)";
            input Real u_min "搜索区间的下限";
            input Real u_max "搜索区间的上限";
            input Real tolerance = 100 * Modelica.Constants.eps 
              "解的相对容差u";
            output Real u "使f(u)=0的自变量值";

          protected
            constant Real eps = Modelica.Constants.eps "机器精度";
            Real a = u_min "当前最优最小间隔值";
            Real b = u_max "当前最优最大间隔值";
            Real c "中间点a<=c<=b";
            Real d;
            Real e "b-a";
            Real m;
            Real s;
            Real p;
            Real q;
            Real r;
            Real tol;
            Real fa "=f(a)";
            Real fb "=f(b)";
            Real fc;
            Boolean found = false;
          algorithm
            // 检查f(u_min)和f(u_max)的符号是否不同
            fa := normalizationResidue(c1, c2, u_min);
            fb := normalizationResidue(c1, c2, u_max);
            fc := fb;
            if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
              error(
                "求解OneNonlinearEquation(..)的参数u_min和u_max\n" + 
                "不括弧单一非线性方程的根：\n" + 
                "  u_min  = " + String(u_min) + "\n" + "  u_max  = " + String(u_max) 
                + "\n" + "  fa = f(u_min) = " + String(fa) + "\n" + 
                "  fb = f(u_max) = " + String(fb) + "\n" + 
                "fa和fb的符号必须相反，而事实并非如此");
            end if;

            // 初始化变量
            c := a;
            fc := fa;
            e := b - a;
            d := e;

            // 搜索环路
            while not found loop
              if abs(fc) < abs(fb) then
                a := b;
                b := c;
                c := a;
                fa := fb;
                fb := fc;
                fc := fa;
              end if;

              tol := 2 * eps * abs(b) + tolerance;
              m := (c - b) / 2;

              if abs(m) <= tol or fb == 0.0 then
                // 找到根(区间足够小)
                found := true;
                u := b;
              else
                // 确定是否需要分段
                if abs(e) < tol or abs(fa) <= abs(fb) then
                  e := m;
                  d := e;
                else
                  s := fb / fa;
                  if a == c then
                    // 线性插值
                    p := 2 * m * s;
                    q := 1 - s;
                  else
                    // 逆二次插值
                    q := fa / fc;
                    r := fb / fc;
                    p := s * (2 * m * q * (q - r) - (b - a) * (r - 1));
                    q := (q - 1) * (r - 1) * (s - 1);
                  end if;

                  if p > 0 then
                    q := -q;
                  else
                    p := -p;
                  end if;

                  s := e;
                  e := d;
                  if 2 * p < 3 * m * q - abs(tol * q) and p < abs(0.5 * s * q) then
                    // 插值成功
                    d := p / q;
                  else
                    // 使用bi-section
                    e := m;
                    d := e;
                  end if;
                end if;

                // 最优猜测值定义为"a"
                a := b;
                fa := fb;
                b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
                fb := normalizationResidue(c1, c2, b);

                if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
                  // 初始化变量
                  c := a;
                  fc := fa;
                  e := b - a;
                  d := e;
                end if;
              end if;
            end while;

            annotation(Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该函数以可靠的方式求解</span><span style=\"color: rgb(51, 51, 51);\"><strong>一个非线性代数方程</strong></span><span style=\"color: rgb(51, 51, 51);\"> \"y = f(u)\" 中的</span><span style=\"color: rgb(51, 51, 51);\"><strong>未知数 </strong></span><span style=\"color: rgb(51, 51, 51);\">\"u\"。它是用于此目的的最佳数值算法之一。作为输入，需要给定非线性函数 f(u)，以及包含解的区间 u_min 和 u_max，即 \"f(u_min)\" 和 \"f(u_max)\" 必须具有不同的符号。如果可能，通过反向二次插值来计算一个更小的区间（通过最后三个点的二次多项式插值并计算零点）。如果反向二次插值失败，则使用二分法，该方法始终将区间减少一半。反向二次插值法具有超线性收敛性。这大致与全局收敛的牛顿法的收敛速度相同，但无需计算非线性函数的导数。该求解器函数是将 Algol 60 程序 \"zero\" 直接映射到 Modelica 的实现，来源于：</span>
</p>
<p>
 Brent R.P.:
</p>
<p>
<strong>无导数的最小化算法</strong>.<br>Prentice Hall, 1973, pp. 58-59.
</p>
</html>"  ));
          end solveOneNonlinearEquation;
          annotation();

        algorithm
          // 找出alpha的区间
          (alpha_min,alpha_max) := findInterval(c1, c2);

          // 计算alpha，使abs(G(p))=-3db
          alpha := solveOneNonlinearEquation(
            c1, 
            c2, 
            alpha_min, 
            alpha_max);
        end normalizationFactor;

        encapsulated function bandPassAlpha "带通返回值alpha"
          extends Modelica.Icons.Function;

          import Modelica;
          input Real a "s^1系数";
          input Real b "s^0系数";
          input Modelica.Units.SI.AngularVelocity w 
            "带宽角频率";
          output Real alpha "基于Alpha的带通";

        protected
          Real alpha_min;
          Real alpha_max;
          Real z_min;
          Real z_max;
          Real z;

          function residue "非线性方程的残差"
            extends Modelica.Icons.Function;
            input Real a;
            input Real b;
            input Real w;
            input Real z;
            output Real res;
            annotation();
          algorithm
            res := z ^ 2 + (a * w * z / (1 + z)) ^ 2 - (2 + b * w ^ 2) * z + 1;
          end residue;

        public
          function solveOneNonlinearEquation 
            "Solve f(u) = 0;f(u_min)和f(u_max)必须有不同的符号"
            extends Modelica.Icons.Function;
            import Modelica.Utilities.Streams.error;

            input Real aa;
            input Real bb;
            input Real ww;
            input Real u_min "搜索区间的下限";
            input Real u_max "搜索区间的上限";
            input Real tolerance = 100 * Modelica.Constants.eps 
              "解的相对容差u";
            output Real u "使f(u)=0的自变量值";

          protected
            constant Real eps = Modelica.Constants.eps "机器精度";
            Real a = u_min "当前最佳最小间隔值";
            Real b = u_max "当前最佳最大间隔值";
            Real c "中间点a<=c<=b";
            Real d;
            Real e "b-a";
            Real m;
            Real s;
            Real p;
            Real q;
            Real r;
            Real tol;
            Real fa "=f(a)";
            Real fb "=f(b)";
            Real fc;
            Boolean found = false;
          algorithm
            // 检查f(u_min)和f(u_max)的符号是否不同
            fa := residue(aa, bb, ww, u_min);
            fb := residue(aa, bb, ww, u_max);
            fc := fb;
            if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
              error(
                "求解OneNonlinearEquation(..)的参数u_min和u_max\n" + 
                "不括弧单一非线性方程的根\n" + 
                "  u_min  = " + String(u_min) + "\n" + "  u_max  = " + String(u_max) 
                + "\n" + "  fa = f(u_min) = " + String(fa) + "\n" + 
                "  fb = f(u_max) = " + String(fb) + "\n" + 
                "fa和fb的符号必须相反，而事实并非如此");
            end if;

            // 参数初始化
            c := a;
            fc := fa;
            e := b - a;
            d := e;

            // 搜索环路
            while not found loop
              if abs(fc) < abs(fb) then
                a := b;
                b := c;
                c := a;
                fa := fb;
                fb := fc;
                fc := fa;
              end if;

              tol := 2 * eps * abs(b) + tolerance;
              m := (c - b) / 2;

              if abs(m) <= tol or fb == 0.0 then
                // 找到根(区间足够小)
                found := true;
                u := b;
              else
                // 确定是否需要分段
                if abs(e) < tol or abs(fa) <= abs(fb) then
                  e := m;
                  d := e;
                else
                  s := fb / fa;
                  if a == c then
                    // 线性插值
                    p := 2 * m * s;
                    q := 1 - s;
                  else
                    // 逆二次插值
                    q := fa / fc;
                    r := fb / fc;
                    p := s * (2 * m * q * (q - r) - (b - a) * (r - 1));
                    q := (q - 1) * (r - 1) * (s - 1);
                  end if;

                  if p > 0 then
                    q := -q;
                  else
                    p := -p;
                  end if;

                  s := e;
                  e := d;
                  if 2 * p < 3 * m * q - abs(tol * q) and p < abs(0.5 * s * q) then
                    // 插值成功
                    d := p / q;
                  else
                    // 使用bi-section
                    e := m;
                    d := e;
                  end if;
                end if;

                // 最优猜测值定义为\"a\"
                a := b;
                fa := fb;
                b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
                fb := residue(aa, bb, ww, b);

                if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
                  // 参数初始化
                  c := a;
                  fc := fa;
                  e := b - a;
                  d := e;
                end if;
              end if;
            end while;

            annotation(Documentation(info="<html><p>
该函数以可靠的方式求解<strong>一个非线性代数方程</strong> \"y = f(u)\" 中的<strong>未知数</strong> \"u\"。它是用于此目的的最佳数值算法之一。作为输入，需要给定非线性函数 f(u)，以及包含解的区间 u_min 和 u_max，即 \"f(u_min)\" 和 \"f(u_max)\" 必须具有不同的符号。如果可能，通过反向二次插值来计算一个更小的区间（通过最后三个点的二次多项式插值并计算零点）。如果反向二次插值失败，则使用二分法，该方法始终将区间减少一半。反向二次插值法具有超线性收敛性。这大致与全局收敛的牛顿法的收敛速度相同，但无需计算非线性函数的导数。该求解器函数是将 Algol 60 程序 \"zero\" 直接映射到 Modelica 的实现，来源于：
</p>
<p>
 Brent R.P.:
</p>
<p>
<strong>导数最小化算法</strong>.<br>Prentice Hall, 1973, pp. 58-59.
</p>
</html>"  ));
          end solveOneNonlinearEquation;

        algorithm
          assert(a ^ 2 / 4 - b <= 0, "无法计算带通变换");
          z := solveOneNonlinearEquation(a, b, w, 0, 1);
          alpha := sqrt(z);

          annotation(Documentation(info="<html><p>
带宽为\"w\"的带通由低通确定
</p>
<pre><code >1/(p^2 + a*p + b)</code></pre><p>
随着变换
</p>
<pre><code >new(p) = (p + 1/p)/w</code></pre><p>
由此得出以下推导
</p>
<pre><code >1/(p^2 + a*p + b) -&gt; 1/( (p+1/p)^2/w^2 + a*(p + 1/p)/w + b )
= 1 /( ( p^2 + 1/p^2 + 2)/w^2 + (p + 1/p)*a/w + b )
= w^2*p^2 / (p^4 + 2*p^2 + 1 + (p^3 + p)a*w + b*w^2*p^2)
= w^2*p^2 / (p^4 + a*w*p^3 + (2+b*w^2)*p^2 + a*w*p + 1)</code></pre><p>
由于数字原因，这个4阶传递函数将被拆分为两个各为2阶的传递函数。 可以用下面的公式表示四阶多项式 (未知数为\"c\"和\"alpha\")：
</p>
<pre><code >g(p) = w^2*p^2 / ( (p*alpha)^2 + c*(p*alpha) + 1) * ( (p/alpha)^2 + c*(p/alpha) + 1)
= w^2*p^2 / ( p^4 + c*(alpha + 1/alpha)*p^3 + (alpha^2 + 1/alpha^2 + c^2)*p^2
+ c*(alpha + 1/alpha)*p + 1 )</code></pre><p>
比较系数
</p>
<pre><code >c*(alpha + 1/alpha) = a*w           -&gt; c = a*w / (alpha + 1/alpha)
alpha^2 + 1/alpha^2 + c^2 = 2+b*w^2 -&gt; 确定alpha的方程

alpha^4 + 1 + a^2*w^2*alpha^4/(1+alpha^2)^2 = (2+b*w^2)*alpha^2
or z = alpha^2
z^2 + a^2*w^2*z^2/(1+z)^2 - (2+b*w^2)*z + 1 = 0</code></pre><p>
因此，必须求解最后一个方程的\"z\" (基本意味着要计算一个四阶多项式的实零)：
</p>
<pre><code >solve: 0 = f(z)  = z^2 + a^2*w^2*z^2/(1+z)^2 - (2+b*w^2)*z + 1  for \"z\"
f(0)  = 1  &gt; 0
f(1)  = 1 + a^2*w^2/4 - (2+b*w^2) + 1
= (a^2/4 - b)*w^2  &lt; 0
// 因为b-a^2/4&gt;0是对复共轭极点的要求
-&gt; 0 &lt; z &lt; 1</code></pre><p>
该函数计算该方程的解，并返回\"alpha = sqrt(z)\";
</p>
<p>
<br>
</p>
</html>"  ));
        end bandPassAlpha;
        function AxFn "y = A * x"
          extends Modelica.Icons.Function;
          input Real A[:,:];
          input Real x[size(A, 2)];
          output Real y[size(A, 1)];
          annotation();
        algorithm
          y := zeros(size(A, 1));  // Don't try to optimize it
                    y := A * x;
                  end AxFn;
        annotation();
        end Utilities;
      annotation();
      end Filter;
    annotation();
    end Internal;
  annotation(
    Documentation(info="<html><p>
本组件包含由微分方程描述的基本<strong>连续</strong>输入/输出模块。
</p>
<p>
本组件中的所有模块都可以通过参数<strong>initType</strong>控制的不同方式进行初始化。 initType的可能取值在 <a href=\"modelica://Modelica.Blocks.Types.Init\" target=\"\">Modelica.Blocks.Types.Init</a>&nbsp; &nbsp;中定义：
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>名称</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>描述</strong></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Init.NoInit</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">无初始化(在固定值=false时，将起始值用作猜测值)</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Init.SteadyState</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">稳态初始化(状态导数为零)</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Init.InitialState</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">初始状态初始化</td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><strong>Init.InitialOutput</strong></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">初始输出值初始化(如果可能，还包括稳定状态)</td></tr></tbody></table><p>
出于向后兼容的原因， 所有模块的默认值都是<strong>Init.NoInit</strong>， 但Integrator和LimIntegrator除外， 它们的默认值都是<strong>Init.InitialState</strong>(这是Modelica标准库2.2版中定义的初始化)。
</p>
<p>
<span style=\"color: rgb(51, 51, 51);\">在许多情况下，最有用的初始条件是</span><span style=\"color: rgb(51, 51, 51);\"><strong> Init.SteadyState</strong></span><span style=\"color: rgb(51, 51, 51);\">，因为这样初始瞬态就不再存在。缺点是，结合非线性系统时，会出现非线性代数方程，如果没有为迭代变量提供合适的猜测值（即，start 值设置为 fixed=false），这些方程可能难以求解。然而，仅仅将来自连续块库的线性模块初始化为 </span><span style=\"color: rgb(51, 51, 51);\"><strong>SteadyState</strong></span><span style=\"color: rgb(51, 51, 51);\"> 通常已经很有用。这是没有问题的，因为只会出现线性代数方程。如果设置为 Init.NoInit，则状态的起始值会被解释为猜测值，并以 fixed=</span><span style=\"color: rgb(51, 51, 51);\"><strong>false</strong></span><span style=\"color: rgb(51, 51, 51);\"> 的方式传播到状态中。</span>
</p>
<p>
注意，对于包含积分模块 (积分模块、LimIntegrator、PI、PID、LimPID)的程序模块， 使用Init.SteadyState进行初始化通常比较困难。 这是由于积分器的基本方程所致：
</p>
<pre><code >initial equation
der(y) = 0;   // Init.SteadyState
equation
der(y) = k*u;</code></pre><p>
稳态方程的条件是积分器的输入为零。 如果输入u已经(直接或间接)由另一个初始条件定义， 那么初始化问题就是<strong>奇异</strong>的(无解或无穷多解)。 这种情况经常出现在机械系统中， 例如，u=desiredSpeed-measuredSpeed， 由于速度既是状态也是导数， 因此它总是由Init.InitialState或Init.SteadyState初始化定义。
</p>
<p>
在这种情况下， 必须为积分模块选择<strong>Init.NoInit</strong>， 并为积分模块连接的系统添加额外的初始方程。 例如，对于由PI控制组件控制的一维转动惯量， 有用的初始条件是惯量的<strong>角度</strong>、<strong>速度</strong>和<strong>加速度</strong>为零。
</p>
<p>
<br>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"), Icon(graphics = {Line(
    origin = {0.061, 4.184}, 
    points = {{81.939, 36.056}, {65.362, 36.056}, {14.39, -26.199}, {-29.966, 
    113.485}, {-65.374, -61.217}, {-78.061, -78.184}}, 
    color = {95, 95, 95}, 
    smooth = Smooth.Bezier)}));
end Continuous;