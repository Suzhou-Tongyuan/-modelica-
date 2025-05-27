within Modelica.Electrical.Analog.Ideal;
model IdealizedOpAmpLimited "带限制的理想化运算放大器"
  parameter Real V0 = 15000.0 "零负载放大";
  parameter Boolean useSupply = false 
    "使用供电引脚(否则保持恒定供电)" annotation(Evaluate = true);
  parameter SI.Voltage Vps = +15 "正极电压" 
    annotation(Dialog(enable = not useSupply));
  parameter SI.Voltage Vns = -15 "负极电压" 
    annotation(Dialog(enable = not useSupply));
  parameter Boolean strict = true "= true, if strict limits with noEvent(..)" 
    annotation(Evaluate = true, choices(checkBox = true), Dialog(tab = "Advanced"));
  parameter Modelica.Blocks.Types.LimiterHomotopy homotopyType = Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy "基于同伦初始化的简化模型" 
    annotation(Evaluate = true, Dialog(group = "Initialization"));
  SI.Voltage vps "Positive supply voltage";
  SI.Voltage vns "Negative supply voltage";
  SI.Voltage v_in = in_p.v - in_n.v "Input voltage difference";
  SI.Voltage v_out = out.v "Output voltage to ground";
  SI.Power p_in = in_p.v * in_p.i + in_n.v * in_n.i "Input power";
  SI.Power p_out = out.v * out.i "Output power";
  SI.Power p_s = -(p_in + p_out) "Supply power";
  SI.Current i_s = p_s / (vps - vns) "Supply current";
  Modelica.Electrical.Analog.Interfaces.PositivePin in_p 
    "输入端口的正极" annotation(Placement(transformation(
    extent = {{-90, -70}, {-110, -50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin in_n 
    "输入端口的负极" annotation(Placement(transformation(
    extent = {{-110, 50}, {-90, 70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin out 
    "输出端口的正极" annotation(Placement(transformation(extent = {{
    110, -10}, {90, 10}}), iconTransformation(extent = {{110, -10}, 
    {90, 10}})));
  //optional supply pins
  Modelica.Electrical.Analog.Interfaces.PositivePin s_p(final i = +i_s, final v = 
    vps) if useSupply "可选的正电源引脚" annotation(Placement(
    transformation(extent = {{10, 90}, {-10, 110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin s_n(final i = -i_s, final v = 
    vns) if useSupply "可选的负电源引脚" annotation(Placement(
    transformation(extent = {{-10, -110}, {10, -90}})));
protected
  SI.Voltage simplifiedExpr "Simplified expression for homotopy-based initialization";
equation
  if not useSupply then
    vps = Vps;
    vns = Vns;
  end if;
  in_p.i = 0;
  in_n.i = 0;
  simplifiedExpr = (if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.Linear then V0 * v_in 
    else if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.UpperLimit then vps 
    else if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.LowerLimit then vns 
    else 0);
  if strict then
    if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
      v_out = smooth(0, noEvent(if V0 * v_in > vps then vps else if V0 * v_in < vns then vns else V0 * v_in));
    else
      v_out = homotopy(actual = smooth(0, noEvent(if V0 * v_in > vps then vps else if V0 * v_in < vns then vns else V0 * v_in)), 
        simplified = simplifiedExpr);
    end if;
  else
    if homotopyType == Modelica.Blocks.Types.LimiterHomotopy.NoHomotopy then
      v_out = smooth(0, if V0 * v_in > vps then vps else if V0 * v_in < vns then vns else V0 * v_in);
    else
      v_out = homotopy(actual = smooth(0, if V0 * v_in > vps then vps else if V0 * v_in < vns then vns else V0 * v_in), 
        simplified = simplifiedExpr);
    end if;
  end if;
  annotation(defaultComponentName = "opAmp", 
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 
    100}}), graphics = {
    Line(points = {{60, 0}, {90, 0}}, color = {0, 0, 255}), 
    Text(
    extent = {{-150, 150}, {150, 110}}, 
    textString = "%name", 
    textColor = {0, 0, 255}), 
    Line(points = {{60, 0}, {90, 0}}, color = {0, 0, 255}), 
    Polygon(
    points = {{70, 0}, {-70, 80}, {-70, -80}, {70, 0}}, 
    fillColor = {255, 255, 255}, 
    fillPattern = FillPattern.Solid, 
    lineColor = {0, 0, 255}), 
    Line(points = {{-100, 60}, {-70, 60}}, color = {0, 0, 255}), 
    Line(points = {{-100, -60}, {-70, -60}}, color = {0, 0, 255}), 
    Line(points = {{-60, 50}, {-40, 50}}, color = {0, 0, 255}), 
    Line(points = {{-50, -40}, {-50, -60}}, color = {0, 0, 255}), 
    Line(points = {{-60, -50}, {-40, -50}}, color = {0, 0, 255}), 
    Line(points = {{0, 40}, {0, 100}}, color = {0, 0, 255}, visible = useSupply), 
    Line(points = {{0, -100}, {0, -40}}, color = {0, 0, 255}, visible = useSupply)}), 
    Documentation(info = "<html>
<p>带饱和的理想运算放大器：</p>
<ul>
<li>输入电流为0;</li>
<li>空载放大倍数很高(但不是无穷大);</li>
<li>输出电压被限制在正负电源之间。</li>

</ul>
<p>供电电压由参数Vps和Vns定义，或者由(可选的)引脚s_p和s_n定义。</p>
<p>在第一种情况下，所需的电力是从隐含的内部电源中获取的，在第二种情况下是从外部电源中获取的。</p>
<p>如果对于包含此组件的模型初始化存在问题，您可以设置<strong>homotopyType</strong>参数。<strong>线性</strong>模型在处理负反馈系统时可能有效，但在处理正反馈系统时往往不适用。使用<strong>LowerLimit</strong>(或<strong>UpperLimit</strong>)会给出饱和边界内的固定值，这对正反馈是有效的。但是，如果目的是通过特定的输入初始化输入以获得特定的输出，它是不起作用的。</p>
</html>"));
end IdealizedOpAmpLimited;