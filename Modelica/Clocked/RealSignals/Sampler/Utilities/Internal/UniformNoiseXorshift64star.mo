within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
block UniformNoiseXorshift64star 
  "基于xorshift64*随机数生成器添加带限均匀噪声"
  extends Clocked.RealSignals.Interfaces.PartialNoise;
  parameter Real noiseMax=0.1 "噪声带宽的上限";
  parameter Real noiseMin=-noiseMax "噪声带宽的下限";

  parameter Integer globalSeed = 30020 "初始化随机数生成器的全局种子";
  // 具有暴露状态的随机数生成器
  parameter Integer localSeed = 614657 "初始化随机数生成器的局部种子";
  output Real r64(start=0) "通过Xorshift64star生成的随机数";
protected
  discrete Integer state64[2](start=Modelica.Math.Random.Generators.Xorshift64star.initialState(localSeed, globalSeed));

equation
  (r64, state64) = Modelica.Math.Random.Generators.Xorshift64star.random(previous(state64));
  y = u + noiseMin + (noiseMax - noiseMin)*r64;

  annotation (Documentation(info="<html>
<p>该模块向时钟化的实数输入信号添加在noiseMin&nbsp;&hellip;&nbsp;noiseMax范围内均匀分布的噪声，并提供该总和作为时钟化的实数输出信号。</p>
<p>
它基于xorshift64*算法。
更多细节，请参阅
<a href=\"modelica://Modelica.Math.Random.Generators.Xorshift64star\">Xorshift64star</a>的文档。
</p>
<h4>示例</h4>
<p>
以下
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.UniformNoiseXorshift64star\">示例</a>
以20毫秒周期的时钟对零信号进行采样，并在范围-0.1&nbsp;&hellip;&nbsp;0.1内添加噪声：<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UniformNoiseXorshift64star_Model.png\" alt=\"UniformNoiseXorshift64star_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/UniformNoiseXorshift64star_Result.png\" alt=\"UniformNoiseXorshift64star_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">模型</td>
    <td align=\"center\">仿真结果</td>
   </tr>
</table>
</html>"), 
    Icon(graphics={
        Polygon(
          points={{-81,90},{-89,68},{-73,68},{-81,90}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-74,92},{90,68}}, 
          textColor={175,175,175}, 
          textString="%noiseMax"), 
        Line(points={{-81,78},{-81,-90}}, color={192,192,192}), 
        Line(points={{-89,62},{85,62}}, color={175,175,175}), 
        Line(points={{-81,-17},{-67,-17},{-67,-1},{-59,-1},{-59,-49},{
              -51,-49},{-51,-27},{-43,-27},{-43,57},{-35,57},{-35,25}}, 
                                                               color={0,0, 
              127}, 
          pattern=LinePattern.Dot), 
        Line(points={{-35,25},{-35,-35},{-25,-35},{-25,-17},{-15,-17},{
              -15,-45},{-5,-45},{-5,37},{1,37},{1,51},{7,51},{7,-5},{17, 
              -5},{17,7},{23,7},{23,-23},{33,-23},{33,49},{43,49},{43, 
              15},{51,15},{51,-51},{61,-51}}, 
            color={0,0,127}, 
          pattern=LinePattern.Dot), 
        Line(points={{-90,-23},{82,-23}}, color={192,192,192}), 
        Polygon(
          points={{91,-22},{69,-14},{69,-30},{91,-22}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,-54},{84,-54}}, color={175,175,175}), 
        Ellipse(
          extent={{-84,-13},{-78,-19}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-70,3},{-64,-3}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-62,-47},{-56,-53}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-54,-23},{-48,-29}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-46,59},{-40,53}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-38,-33},{-32,-39}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-28,-15},{-22,-21}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-18,-41},{-12,-47}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-8,39},{-2,33}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{-2,53},{4,47}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{4,-1},{10,-7}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{14,9},{20,3}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{20,-19},{26,-25}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{30,53},{36,47}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{40,19},{46,13}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{48,-47},{54,-53}}, 
          lineColor={0,0,127}, 
          fillColor={0,0,127}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{-80,-62},{98,-84}}, 
          textColor={175,175,175}, 
          textString="%noiseMin")}));
end UniformNoiseXorshift64star;