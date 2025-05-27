within Modelica.Thermal.HeatTransfer.Components;
model Convection 
  "用于热对流的集总热元件(Q_flow = Gc*dT)"
  SI.HeatFlowRate Q_flow "固体 -> 流体的热流速率";
  SI.TemperatureDifference dT "= solid.T - fluid.T";
  Modelica.Blocks.Interfaces.RealInput Gc(unit="W/K") 
    "代表对流热导的信号（单位：[W/K］" 
    annotation (Placement(transformation(
        origin={0,100}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  Interfaces.HeatPort_a solid annotation (Placement(transformation(extent={{
            -110,-10},{-90,10}})));
  Interfaces.HeatPort_b fluid annotation (Placement(transformation(extent={{
            90,-10},{110,10}})));
equation
  dT = solid.T - fluid.T;
  solid.Q_flow = Q_flow;
  fluid.Q_flow = -Q_flow;
  Q_flow = Gc*dT;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-62,80},{98,-80}}, 
          lineColor={255,255,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{-90,80},{-60,-80}}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Backward), 
        Text(
          extent={{-150,-90},{150,-130}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{100,0},{100,0}}, color={0,127,255}), 
        Line(points={{-60,20},{76,20}}, color={191,0,0}), 
        Line(points={{-60,-20},{76,-20}}, color={191,0,0}), 
        Line(points={{-34,80},{-34,-80}}, color={0,127,255}), 
        Line(points={{6,80},{6,-80}}, color={0,127,255}), 
        Line(points={{40,80},{40,-80}}, color={0,127,255}), 
        Line(points={{76,80},{76,-80}}, color={0,127,255}), 
        Line(points={{-34,-80},{-44,-60}}, color={0,127,255}), 
        Line(points={{-34,-80},{-24,-60}}, color={0,127,255}), 
        Line(points={{6,-80},{-4,-60}}, color={0,127,255}), 
        Line(points={{6,-80},{16,-60}}, color={0,127,255}), 
        Line(points={{40,-80},{30,-60}}, color={0,127,255}), 
        Line(points={{40,-80},{50,-60}}, color={0,127,255}), 
        Line(points={{76,-80},{66,-60}}, color={0,127,255}), 
        Line(points={{76,-80},{86,-60}}, color={0,127,255}), 
        Line(points={{56,-30},{76,-20}}, color={191,0,0}), 
        Line(points={{56,-10},{76,-20}}, color={191,0,0}), 
        Line(points={{56,10},{76,20}}, color={191,0,0}), 
        Line(points={{56,30},{76,20}}, color={191,0,0}), 
        Text(
          extent={{22,124},{92,98}}, 
          textString="Gc")}), 
    Documentation(info="<html><p>
这是一种线性热对流模型，例如板与周围空气之间的热传递；另见: <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor\" target=\"\">ConvectiveResistor</a>&nbsp;。通过测量确定对流导热系数 Gc，它可用于复杂的固体几何形状和流体在固体上的流动。 对流热导 Gc。对流的基本构成方程为
</p>
<p>
<br>
</p>
<pre><code >Q_flow = Gc*(solid.T - fluid.T);
Q_flow: 接口 \\\\'solid\\\\' (如平板)
   到接口\\\\'fluid\\\\' (如周围环境)的热流速率
</code></pre><p>
<br>
</p>
<p>
Gc = G.signal[1] 是元件的输入信号，因为 Gc 在实际应用中几乎从来都不是常数。例如，Gc 可能是冷却风扇速度的函数。 简单情况下, Gc 可根据下式计算:
</p>
<p>
<br>
</p>
<pre><code >G = A*h
A: 对流换热面积 (如长方体的周长*长度)
h: 对流换热系数
</code></pre><p>
<br>
</p>
<p>
其中，传热系数 h 是根据流过固体的流体特性计算得出的。实例:
</p>
<p>
<strong>空气冷却设备</strong> (经验性的、非常粗略的近似值，根据 [<a href=\"modelica://Modelica.Thermal.HeatTransfer.UsersGuide.References\" target=\"\">Fischer2017</a>&nbsp;, p. 452]:
</p>
<p>
<br>
</p>
<pre><code >h = 7.8*v^0.78 [W/(m2.K)] (强制对流)
  = 12         [W/(m2.K)] (自由对流)
where
  v: 空气流速 [m/s]
</code></pre><p>
<br>
</p>
<p>
流体以恒定速度沿平板作<strong>层流</strong>流动，其中从平板到流体的热流量（即 solid.Q_flow）保持恒定（基于[Holman2010, p.265]所述）：
</p>
<p>
<br>
</p>
<pre><code >h  = Nu*k/x;
Nu = 0.453*Re^(1/2)*Pr^(1/3);
where
   h  : 传热系数
   Nu : = h*x/k       (努塞尔特数)
   Re : = v*x*rho/mu  (雷诺数)
   Pr : = cp*mu/k     (普朗特数)
   v  : 流体绝对速度
   x  : 距平板前缘的距离
   rho: 流体密度（材料常数）
   mu : 流体动态粘度（材料常数）
   cp : 流体比热容（材料常数）
   k  : 流体热导率（材料常数）
且 h 的方程成立，前提是
   Re &lt; 5e5 and 0.6 &lt; Pr &lt; 50
</code></pre><p>
<br>
</p>
<p>
<br>
</p>
</html>"), 
       Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={
        Line(points={{100,0},{100,0}}, color={0,127,255}), 
        Line(points={{100,0},{100,0}}, color={0,127,255}), 
        Line(points={{100,0},{100,0}}, color={0,127,255})}));
end Convection;