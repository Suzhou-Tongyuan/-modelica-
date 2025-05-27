within Modelica.Clocked.IntegerSignals.Sampler;
block AssignClock "为时钟整数信号分配时钟"
  Modelica.Blocks.Interfaces.IntegerInput u 
    "时钟、整数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y 
    "时钟、整数输出信号连接器" 
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
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}),Line(points={{-80,-60},{-40,-60},{-40,0},{
              0,0},{0,0},{0,0},{0,80},{40,80},{40,40},{80,40},{80,0},{80, 
              0},{80,0},{100,0}},color={255,128,0}, 
          pattern=LinePattern.Dot),                Line(
          points={{-80,-60},{-80,0},{-106,0}}, 
          color={255,128,0}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-90,-50},{-70,-70}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-50,10},{-30,-10}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-10,90},{10,70}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{30,50},{50,30}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{70,10},{90,-10}}, 
          lineColor={255,128,0}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{0,-100},{0,70}}, 
          color={175,175,175}, 
          pattern=LinePattern.Dot, 
          thickness=0.5)}), 
    Documentation(info="<html>
<p>
该整数信号模块的工作原理与相应的实数信号模块类似（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.AssignClock\">RealSignals.Sampler.AssignClock</a>）。
</p>
<p>
与相应的实数信号模块示例类似，该整数信号模块也有一个基本<a href=\"modelica://Modelica.Clocked.Examples.Elementary.IntegerSignals.AssignClock\">example</a>。
</p>
</html>"));
end AssignClock;