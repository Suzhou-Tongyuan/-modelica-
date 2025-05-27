within Modelica.Electrical.Machines.Sensors;
model SinCosResolver "正弦-余弦解析器"
  import Modelica.Constants.pi;
  extends 
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  parameter Integer p(final min=1, start=2) "极对数";
  parameter Real amplitude=1 "信号幅值";
  parameter Real offset=1.5 "信号偏移";
  parameter SI.Angle phi0=-pi/p "初始机械角度";
  Modelica.Blocks.Interfaces.RealOutput y[4] "跟踪信号" 
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
equation
  flange.tau=0;
  y[1] = offset + amplitude*cos(p*(flange.phi - phi_support - phi0));
  y[2] = offset - amplitude*cos(p*(flange.phi - phi_support - phi0));
  y[3] = offset + amplitude*sin(p*(flange.phi - phi_support - phi0));
  y[4] = offset - amplitude*sin(p*(flange.phi - phi_support - phi0));
   annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(extent={{-70,70},{70,-70}}, lineColor={95,95,95}, 
          fillColor={215,215,215}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-70,0},{-100,0}}, color={95,95,95}), 
        Line(points={{100,0},{70,0}}, color={95,95,95}), 
        Text(
          extent={{-150,120},{150,80}}, 
          textColor={0,0,255}, 
          fillColor={255,255,255}, 
          textString="%name"), 
        Ellipse(extent={{-20,20},{20,-20}}, lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4, 
              74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3, 
              59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7, 
              -64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5}, 
              {57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, smooth = Smooth.Bezier), 
        Line(points={{-80,80},{-76.2,79.8},{-70.6,76.6},{-64.9,69.7},{-59.3, 
              59.4},{-52.9,44.1},{-44.83,21.2},{-27.9,-30.8},{-20.7,-50.2},{-14.3, 
              -64.2},{-8.7,-73.1},{-3,-78.4},{2.6,-80},{8.2,-77.6},{13.9,-71.5}, 
              {19.5,-61.9},{25.9,-47.2},{34,-24.8},{42,0}}, smooth=Smooth.Bezier), 
        Line(points={{84,80},{80.2,79.8},{74.6,76.6},{68.9,69.7},{63.3,59.4},{56.9, 
              44.1},{48.83,21.2},{31.9,-30.8},{24.7,-50.2},{18.3,-64.2},{12.7,-73.1}, 
              {7,-78.4},{1.4,-80},{-4.2,-77.6},{-9.9,-71.5},{-15.5,-61.9},{-21.9, 
              -47.2},{-30,-24.8},{-38,0}},                  smooth=Smooth.Bezier)}), 
    Documentation(info="<html>
<p>
简单的正弦-余弦解析器模型，即感知法兰角度<code>phi</code>(相对于可选支撑)，乘以<code>p</code>，提供4个信号：
</p>
<ul>
<li><code>y[1] = offset + amplitude*cos(p*(phi - phi0))</code></li>
<li><code>y[2] = offset - amplitude*cos(p*(phi - phi0))</code></li>
<li><code>y[3] = offset + amplitude*sin(p*(phi - phi0))</code></li>
<li><code>y[4] = offset - amplitude*sin(p*(phi - phi0))</code></li>
</ul>
<p>
因此，正弦和余弦信号每个机械转动周期有<code>p</code>个周期。
添加一个<code>offset</code> &gt; <code>amplitude</code>，可以确定一个跟踪信号的丢失。
从信号中减去其负值，可以去除偏移并获得振幅加倍的余弦和正弦信号。
从这个信号中，可以确定机器一个极对内的角度，用于场面定向控制。
可以使用块<a href=\"modelica://Modelica.Electrical.Machines.Utilities.SinCosEvaluation\">SinCosEvaluation</a>。
</p>
<p>
此模型可用于导出驱动的FMU以在其他环境中开发控制策略。
切换到真实驱动时，可以使用与FMU相同的输入。
</p>
<p>
请注意，<code>phi0</code> 必须设置为使得在轴位 <code>phi0</code> 时，相1的磁链是最大的。
为了感知轴的机械角度，必须设置<code>p=1</code>。
</p>
</html>"));
end SinCosResolver;