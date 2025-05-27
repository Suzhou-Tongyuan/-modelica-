within Modelica.Clocked.RealSignals.Sampler;
block SuperSampleInterpolated 
  "对时钟实数输入信号进行超采样，并将其线性插值为时钟输出信号（也称为插值器）"

  parameter Boolean inferFactor=true 
    "= true，如果推断出超采样因子"  annotation(Evaluate=true, choices(checkBox=true));
  parameter Integer factor(min=1)=1 
    "超采样因子 >= 1（如果 inferFactor=true 则忽略）" 
                                                annotation(Evaluate=true, Dialog(enable=not inferFactor));
  Modelica.Blocks.Interfaces.RealInput u 
    "时钟实数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y 
    "时钟实数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Real uu(start=0.0);
  Real u_super;
  Real u_pre;
  Real u_preSuper;
  Integer usedFactor = if inferFactor then integer( (superSample(interval(u))/interval(u_super)) + 0.5) else factor;
  Integer ticks(start=0);
  Boolean first(start=true);
equation
  when Clock() then  // clock of u
     uu = u;
     first = false;
     u_pre = if previous(first) then u else previous(uu);
  end when;

  when Clock() then  // clock of y
     if inferFactor then
        u_super = superSample(u);
     else
        u_super = superSample(u,factor);
     end if;
     u_preSuper = superSample(u_pre);
     ticks = if previous(ticks) < usedFactor then previous(ticks) + 1 else 1;
     y = u_preSuper + ticks/usedFactor*(u_super - u_preSuper);
  end when;

  annotation (
   defaultComponentName="superSampleIpo1", 
   Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={
        Line(
          points={{-100,0},{-40,0},{-40,-60},{16,-60},{16,0},{74,0},{74,80},{110, 
              80},{110,80},{110,80},{110,80},{120,80}}, 
          color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Ellipse(
          extent={{-55,-43},{-25,-73}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{59,94},{89,64}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-2,16},{28,-14}}, 
          lineColor={0,0,127}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-89,-51},{-71,-69}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{7,88},{25,70}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Polygon(
          points={{25,0},{5,20},{5,10},{-25,10},{-25,-10},{5,-10},{5,-20}, 
              {25,0}}, 
          fillColor={95,95,95}, 
          fillPattern=FillPattern.Solid, 
          lineColor={95,95,95}, 
          origin={-61,46}, 
          rotation=90), 
        Text(
          visible=not inferFactor, 
          extent={{-150,-100},{150,-140}}, 
          textString="%factor", 
          textColor={0,0,0}), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html><p style=\"text-align: start;\">该模块对时钟驱动的实数输入信号 u 进行超采样，并在 u 值之间进行线性插值，作为时钟驱动的输出信号 y。
</p>
<p style=\"text-align: start;\">更准确地说：y 的时钟比 u 的时钟快 factor 倍。在 y 时钟的每个跳变时，y 的值被设置为 u 的上一个可用值之间的线性插值值。y 时钟的第一次激活与 u 时钟的第一次激活同时发生。默认情况下，超采样因子是由系统推导的，即它必须在其他地方定义。如果参数 <strong>inferFactor </strong>= false，则超采样因子由整数参数 <strong>factor </strong>来定义。
</p>
<p style=\"text-align: start;\">对于控制应用，这个模块更适合作为 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SuperSample\" target=\"\">SuperSample</a>&nbsp; &nbsp;模块使用，因为它不会引入“振荡”现象。
</p>
<h4>Example</h4><p>
以下<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SuperSampleInterpolated\" target=\"\">example</a>&nbsp; &nbsp;使用周期为20毫秒的定时时钟对正弦信号进行采样，然后对所得到的时钟信号进行3倍超采样，并进行线性插值处理： <br>
</p>
<table style=\"width: auto;\"><tbody><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"50\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SuperSampleInterpolated_Model.png\" alt=\"SuperSampleInterpolated_Model.png\" data-href=\"\" style=\"\"/></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SuperSampleInterpolated_Result.png\" alt=\"SuperSampleInterpolated_Result.png\" data-href=\"\" style=\"\"/></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">model</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">simulation result</td></tr></tbody></table><p>
<span style=\"color: rgb(51, 51, 51);\">如所示，block superSampleIpo 为输出 y 引入了 3 个额外的时钟跳变，并在这些时钟跳变时确定值，从而对输入 u 的最后两个可用值进行线性插值。超采样因子 = 3 显示在 superSampleIpo 块的图标中。请注意，SuperSampleInterpolation 块图标中的上箭头表示 superSampleIpo.y 的时钟比 superSampleIpo.u 的时钟快。</span>
</p>
<p>
<br>
</p>
<p>
<br>
</p>
</html>"));
end SuperSampleInterpolated;