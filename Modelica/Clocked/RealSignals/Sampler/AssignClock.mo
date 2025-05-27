within Modelica.Clocked.RealSignals.Sampler;
block AssignClock "为时钟实数信号分配时钟"

  Modelica.Blocks.Interfaces.RealInput u 
    "时钟实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
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
                     graphics={Line(points={{-80,-60},{-40,-60},{-40,0},{
              0,0},{0,0},{0,0},{0,80},{40,80},{40,40},{80,40},{80,0},{80, 
              0},{80,0},{100,0}},color={0,0,127}, 
          pattern=LinePattern.Dot),                Line(
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
          points={{0,-100},{0,0}}, 
          color={175,175,175}, 
          pattern=LinePattern.Dot, 
          thickness=0.5), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html><p>
该模块为实数输入信号 u 分配一个时钟，并将 u 作为输出信号 y 提供。
</p>
<h4>Example</h4><p>
<span style=\"color: rgb(51, 51, 51);\">以下</span><a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.AssignClock\" target=\"\">example</a>&nbsp; <span style=\"color: rgb(51, 51, 51);\">展示了一个离散计数器。为了以 20ms 的采样周期执行计数器，使用了 AssignClock 模块。由于时钟推导，模块内的所有方程将在周期时钟模块给定的时钟跳变时被推导为激活。</span><br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClock_Model.png\" alt=\"AssignClock_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/AssignClock_Result.png\" alt=\"AssignClock_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
在每个时钟周期（即每20ms），unitDelay1 模块的输出会递增一次。
</p>
<p>
<br>
</p>
</html>",revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th>Date</th>
      <th>Author</th>
      <th>Company/Institute</th>
      <th>Comment</th>
    </tr>
    <tr>
      <td valign=\"top\">2012-08-20</td>
      <td valign=\"top\">Bernhard Thiele</td>
      <td>DLR, Institute for System Dynamics and Control</td>
      <td valign=\"top\">Initial version</td>
    </tr>
</table>
</html>"));
end AssignClock;