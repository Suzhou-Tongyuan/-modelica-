within Modelica.Clocked.ClockSignals.Sampler;
block SubSample "对输入时钟进行子采样，并将其作为输出时钟"
  parameter Integer factor(min=1) "子取样系数 (>= 1)" annotation(Evaluate=true);

  Clocked.ClockSignals.Interfaces.ClockInput u 
    "时钟输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Clocked.ClockSignals.Interfaces.ClockOutput y 
    "作为输出信号的时钟连接器（y 时钟比 u 时钟慢）" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = subSample(u,factor);

  annotation (
   defaultComponentName="subSample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=false, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Line(
          points={{-100,0},{-80,0},{-80,-60},{60,-60},{60,0},{100,0}}, 
          pattern=LinePattern.Dot, 
          color={95,95,95}),                       Line(
          points={{-80,-60},{-80,0},{-100,0}}, 
          color={95,95,95}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-95,-45},{-65,-75}}, 
          lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{45,15},{75,-15}}, 
          lineColor={95,95,95}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-46,26},{-26,6}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{4,71},{24,51}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-83,-57},{-77,-63}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{57,3},{63,-3}}, 
          lineColor={95,95,95}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-36,-60},{-36,16},{14,16},{14,60},{60,60},{60,0}}, 
          color={175,175,175}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20}, 
              {25,0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}, 
          origin={-75,55}, 
          rotation=-90), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-90},{150,-130}}, 
          textString="%factor", 
          textColor={0,0,0})}), 
    Documentation(info="<html><p>
该模块对输入时钟 u 进行子采样，并将其作为输出时钟 y 提供。
</p>
<p>
更准确地说： 时钟 y 比时钟 u 慢数倍。 时钟 y 的首次激活时间与时钟 u 的首次激活时间重合。 子采样因子由整数参数 <strong>factor</strong> 定义。
</p>
<h4>Example</h4><p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.SubSample\" target=\"\">example</a>&nbsp; 生成一个周期为20毫秒的时钟信号， 然后使用3倍子采样对结果时钟信号进行采样： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/SubSample_Model.png\" alt=\"SubSample_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/SubSample_Result.png\" alt=\"SubSample_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<span style=\"color: rgb(51, 51, 51);\">如图所示，由于子采样，subSample.y 每次选择 periodicClock.y 的第三个值，并且子采样因子 = 3 显示在 subSample 块的图标中。请注意，subSample 块图标中的向下箭头表示时钟 subSample.y 比时钟 subSample.u 更慢。</span>
</p>
<p>
<br>
</p>
</html>"));
end SubSample;