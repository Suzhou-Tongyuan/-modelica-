within Modelica.ComplexBlocks.ComplexMath;
block Acos "输出输入值的反余弦值"
  extends Interfaces.ComplexSISO;
equation
  y = Modelica.ComplexMath.acos(uInternal);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}}, 
              lineColor={192,192,192}, 
              fillColor={192,192,192}, 
              fillPattern=FillPattern.Solid),Line(points={{-80,80},{-79.2, 
          72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,49.8},{-53.5,37.3},{-30.2, 
          19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},{75.2,-62.2},{77.6,-67.5}, 
          {80,-80}}, color={85,170,255}), 
                     Line(points={{0,-88},{0,68}}, color={
          192,192,192}),Line(points={{-90,-80},{68,-80}}, color={192,192,192}), 
          Polygon(
              points={{90,-80},{68,-72},{68,-88},{90,-80}}, 
              lineColor={192,192,192}, 
              fillColor={192,192,192}, 
              fillPattern=FillPattern.Solid),Text(
              extent={{-86,-14},{-14,-62}}, 
              textColor={192,192,192}, 
              textString="acos")}), 
    Documentation(info="<html>
<p>
这个块根据输入  <code>u</code> 的 <em>反余弦值</em> 计算输出 <code>y</code>。
可选地，当参数 <code>useConjugateInput</code> 为 <code>true</code> 时，
输入 <code>u</code> 可以是处理过的共轭复数。
根据 <code>useConjugateInput</code> 的值，
内部信号 <code>uInternal</code> 可能代表原始的输入信号，
也可能代表共轭复数输入信号。
</p>
<blockquote><pre>
y = <strong>acos</strong>(uInternal);
</pre></blockquote>

<div>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\"
     alt=\"acos.png\">
</div>

</html>"));
end Acos;