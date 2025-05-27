within Modelica.Electrical.QuasiStatic.SinglePhase.Sources;
model FrequencySweepCurrentSource "带有集成频率扫描的电流源"
  extends Interfaces.TwoPin; // 继承两针接口
  import Modelica.Constants.eps; // 导入 Modelica 常量 eps
  SI.Angle gamma(start=0) = pin_p.reference.gamma; // 角度
  parameter SI.Frequency fStart(final min=eps, start=1) "起始扫描频率"; // 起始扫描频率
  parameter SI.Frequency fStop(final min=eps, start=1) "停止扫描频率"; // 停止扫描频率
  parameter SI.Time startTime=0 "频率扫描开始时间"; // 频率扫描开始时间
  parameter SI.Time duration(start=1) "频率扫描持续时间"; // 频率扫描持续时间
  parameter SI.Current I(start=1) "源的有效值电流"; // 源的有效值电流
  parameter SI.Angle phi=0 "源的相位偏移"; // 源的相位偏移
  SI.Frequency f = currentSource.f "实际频率"; // 实际频率
  Modelica.Blocks.Sources.LogFrequencySweep logFrequencySweep(
    final wMin=fStart, 
    final wMax=fStop, 
    final startTime=startTime, 
    final duration=duration) 
    annotation (Placement(transformation(extent={{40,-60},{20,-40}}))); // 对数频率扫描
  VariableCurrentSource currentSource annotation (Placement(transformation(extent={{-20,10},{0,-10}}))); // 可变电流源
  Modelica.ComplexBlocks.Sources.ComplexConstant const(final k= 
        Modelica.ComplexMath.fromPolar(len=I, phi=phi)) 
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}}))); // 复数常数
equation
  connect(logFrequencySweep.y,currentSource. f) annotation (Line(points={{19,-50},{-4,-50},{-4,-12}}, color={0,0,127})); // 连接对数频率扫描输出与电流源频率输入
  connect(pin_p,currentSource. pin_p) annotation (Line(points={{-100,0},{-20,0}}, color={85,170,255})); // 连接引脚 pin_p 与电流源引脚 pin_p
  connect(currentSource.pin_n, pin_n) annotation (Line(points={{0,0},{100,0}}, color={85,170,255})); // 连接电流源负引脚与引脚 pin_n
  connect(const.y, currentSource.I) annotation (Line(points={{-39,-50},{-16,-50},{-16,-12}}, color={85,170,255})); // 连接复数常数输出与电流源电流输入
  annotation (defaultComponentName="currentSource",Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-50,50},{50,-50}}, 
          lineColor={85,170,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-50,0}}, color={85,170,255}), 
        Line(points={{50,0},{90,0}}, color={85,170,255}), 
        Text(
          extent={{150,60},{-150,100}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(
          points={{-44,0},{-32,14},{-20,32},{-12,42},{-6,30},{0,0},{4,-28},{8,-40},{12,-20},{14,2},{16,30},{18,42},{20,28},{24,-32},{26,-40},{28,0}}, 
          color={192,192,192}, 
          smooth=Smooth.Bezier), 
        Polygon(
          points={{90,0},{60,10},{60,-10},{90,0}}, 
          lineColor={85,170,255}, 
          fillColor={85,170,255}, 
          fillPattern=FillPattern.Solid), 
                   Line(points={{0,50},{0,-50}}, color={85,170,255})}), 
    Documentation(info="<html>
<p>该源提供恒定的有效值相位电流 <code>I</code> 和相位角 <code>phi</code>，而频率从
<code>fStart</code> 至 <code>fStop</code> 以 <code>duration</code> 的方式扫描。
频率以对数频率标度的方式扫描，使得频率曲线呈现为线性。</p>

<div><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></div>

</html>"));
end FrequencySweepCurrentSource;