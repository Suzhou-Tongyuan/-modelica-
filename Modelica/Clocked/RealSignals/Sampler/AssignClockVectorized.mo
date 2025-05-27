within Modelica.Clocked.RealSignals.Sampler;
block AssignClockVectorized 
  "为时钟实数信号向量分配时钟"

  parameter Integer n(min=1)=1 
    "输入信号向量 u 的大小（= 输出信号向量 y 的大小）";
  Modelica.Blocks.Interfaces.RealInput u[n] 
    "时钟实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[n] 
    "时钟实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
   Clocked.ClockSignals.Interfaces.ClockInput clock annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={0,-120})));
equation
  when clock then
    y = u;
  end when;

  annotation (
   defaultComponentName="assignClock1", 
   Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Text(
          extent={{0,-40},{140,-80}}, 
          textColor={0,0,0}, 
          textString="n=%n"), 
        Line(
          points={{-80,-60},{-40,-60},{-40,0},{0,0},{0,0},{0,0},{0,80},{40,80}, 
              {40,40},{80,40},{80,0},{80,0},{80,0},{100,0}}, 
          color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Line(
          points={{-80,-60},{-80,0},{-106,0}}, 
          color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-90,-50},{-70,-70}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,10},{-30,-10}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-10,90},{10,70}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{30,50},{50,30}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{70,10},{90,-10}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{0,-100},{0,70}}, 
          color={175,175,175}, 
          pattern=LinePattern.Dot, 
          thickness=0.5), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html><p>
<span style=\"color: rgb(51, 51, 51);\">该模块为实数</span><span style=\"color: rgb(51, 51, 51);\"><strong>向量</strong></span><span style=\"color: rgb(51, 51, 51);\">输入信号 u 分配时钟，并将 u 作为向量输出信号 y 提供。</span>
</p>
<h4>Example</h4><p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.AssignClockVectorized\" target=\"\">example</a>&nbsp; 显示了两个离散计数器。 为了以20毫秒的采样周期执行这些计数器， 使用了 AssignClockVectorized 模块。 由于时钟推理，所有模块内的方程都被推导为在由 periodicClock 模块提供的时钟脉冲处激活。 <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockVectorized_Model.png\" alt=\"AssignClockVectorized_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClockVectorized_Result.png\" alt=\"AssignClockVectorized_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
在每个时钟周期（即每20ms）， unitDelay1 模块的输出会增加1， unitDelay2 模块的输出会增加2。 输入和输出的向量大小由参数 <strong>n</strong> =2指定， 这也显示在 assignClock1 模块的图标中。
</p>
<p>
<br>
</p>
</html>"));
end AssignClockVectorized;