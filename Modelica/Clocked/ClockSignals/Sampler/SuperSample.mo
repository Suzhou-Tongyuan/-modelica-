within Modelica.Clocked.ClockSignals.Sampler;
block SuperSample 
  "对输入时钟进行超采样，并将其作为输出时钟"
  parameter Integer factor(min=1) "超采样因子 (>= 1)" annotation(Evaluate=true);

  Clocked.ClockSignals.Interfaces.ClockInput u 
    "时钟输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Clocked.ClockSignals.Interfaces.ClockOutput y 
    "连接时钟作为输出信号（y 时钟与 u 时钟的速度相同）" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = superSample(u,factor);

  annotation (
   defaultComponentName="superSample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={Line(points={{-80,-60},{-40,-60},{-40,-60},{0,-60}, 
              {0,-60},{0,-60},{0,80},{40,80},{40,80},{80,80},{80,0},{80,0},{80,0}, 
              {100,0}},          color={95,95,95}, 
          pattern=LinePattern.Dot, 
          thickness=0.5),                          Line(
          points={{-80,-60},{-80,0},{-100,0}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot, 
          thickness=0.5), 
        Ellipse(
          extent={{-95,-45},{-65,-75}}, 
          lineColor={175,175,175}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-83,-57},{-77,-63}}, 
          lineColor={175,175,175}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-15,96},{15,66}}, 
          lineColor={175,175,175}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-3,83},{3,77}}, 
          lineColor={175,175,175}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{65,16},{95,-14}}, 
          lineColor={175,175,175}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{77,3},{83,-3}}, 
          lineColor={175,175,175}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-48,-46},{-18,-76}}, 
          lineColor={175,175,175}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{34,96},{64,66}}, 
          lineColor={175,175,175}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20}, 
              {25,0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}, 
          origin={-43,18}, 
          rotation=90), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-90},{150,-130}}, 
          textString="%factor", 
          textColor={0,0,0})}), 
    Documentation(info="<html><p>
该模块对时钟输入信号 u 进行超采样，并将其作为时钟输出信号 y 提供。
</p>
<p>
更准确地说： 时钟 y 的速度是时钟 u 的数倍。 时钟 y 的首次激活时间与时钟 u 的首次激活时间重合。 超采样因子由整数参数 <strong>factor</strong> 定义。
</p>
<h4>Example</h4><p>
下面的<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.SuperSample\" target=\"\">example</a>&nbsp; 生成了一个周期为 20 毫秒的周期时钟，然后对生成的时钟进行了 3 倍的超采样： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/SuperSample_Model.png\" alt=\"SuperSample_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/SuperSample_Result.png\" alt=\"SuperSample_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<span style=\"color: rgb(51, 51, 51);\">如图所示，superSample 为输出时钟 y 引入了一个额外的因子-1 时钟滴答。超采样因子 = 3 显示在 superSample 块的图标中。请注意，superSample 块图标中的向上箭头表示时钟 superSample.y 比时钟 superSample.u 更快。</span>
</p>
<p>
<br>
</p>
</html>"));
end SuperSample;