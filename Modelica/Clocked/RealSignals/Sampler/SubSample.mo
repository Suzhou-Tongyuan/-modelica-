within Modelica.Clocked.RealSignals.Sampler;
block SubSample 
  "对时钟实数输入信号进行子采样，并将其作为时钟输出信号提供"
  parameter Boolean inferFactor=true 
    "= true，如果推断出子抽样因子"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1 
    "子取样因子 >= 1（如果 inferFactor=true 则忽略）" 
                                                            annotation(Evaluate=true, Dialog(enable=not inferFactor));

  Modelica.Blocks.Interfaces.RealInput u 
    "时钟实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟实数输出信号连接器（y 的时钟比 u 的时钟慢）" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  if inferFactor then
     y = subSample(u);
  else
     y = subSample(u,factor);
  end if;

  annotation (
   defaultComponentName="subSample1", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
        graphics={
        Line(
          points={{-100,0},{-80,0},{-80,-60},{60,-60},{60,0},{100,0}}, 
          pattern=LinePattern.Dot, 
          color={0,0,127}),                        Line(
          points={{-80,-60},{-80,0},{-100,0}}, 
          color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-95,-45},{-65,-75}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{45,15},{75,-15}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-46,-20},{-26,-40}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{4,71},{24,51}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-83,-57},{-77,-63}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{57,3},{63,-3}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Line(
          points={{-36,-60},{-36,-30},{14,-30},{14,60},{60,60},{60,0}}, 
          color={215,215,215}, 
          pattern=LinePattern.Dot), 
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20}, 
              {25,0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}, 
          origin={-51,26}, 
          rotation=-90), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          visible=not inferFactor, 
          extent={{-150,-100},{150,-140}}, 
          textString="%factor", 
          textColor={0,0,0})}), 
    Documentation(info="<html><p>
该模块对时钟实数输入信号 u 进行子采样，并将其作为时钟输出信号 y 提供。
</p>
<p>
更加精确地说：y 的时钟比 u 的时钟慢 factor 倍。 每当 u 的时钟触发 factor 次时，输出 y 返回 u 的值。 y 的时钟第一次触发与 u 的时钟的第一次触发同时发生。 默认情况下，子采样因子是推断的，也就是说，它必须在其他地方定义。 如果参数 <strong>inferFactor</strong> = false，则子采样因子由整数参数 <strong>factor</strong> 定义。
</p>
<h4>Example</h4><p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SubSample\" target=\"\">example</a>&nbsp; 对一个正弦信号进行采样，采样周期为20毫秒，然后以3倍的因子对采样后的信号进行子采样： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SubSample_Model.png\" alt=\"SubSample_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SubSample_Result.png\" alt=\"SubSample_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<span style=\"color: rgb(51, 51, 51);\">如所示，由于子采样，subSample.y 每次选取 sample.y 的第三个值，子采样因子 = 3 显示在 subSample 块的图标中。请注意，subSample 块图标中的下箭头表示 subSample.y 的时钟比 subSample.u 的时钟慢。</span>
</p>
<p>
<br>
</p>
</html>"));
end SubSample;