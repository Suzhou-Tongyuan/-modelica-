within Modelica.Electrical.Analog.Lines;
model TLine3 
    "特性阻抗为Z0、无损的传输线，信号在此传输线上传播的频率为F"
  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  parameter SI.Resistance Z0(start=1) "自然阻抗";
  parameter SI.Frequency F(start=1) "频率";
protected
  SI.Voltage er;
  SI.Voltage es;
  parameter SI.Time TD=1/F/4;
equation
  assert(Z0 > 0, "Z0必须为正值");
  assert(F > 0, "F必须为正值");
  i1 = (v1 - es)/Z0;
  i2 = (v2 - er)/Z0;
  es = 2*delay(v2, TD) - delay(er, TD);
  er = 2*delay(v1, TD) - delay(es, TD);
  annotation (defaultComponentName="line", 
    Documentation(info="<html>
<p>特性阻抗为Z0且频率为F的无损传输线TLine3是一个双端口系统。两个端口分支都包括一个阻值为特性阻抗Z0的电阻，以及一个考虑传输延迟的可控电压源。
具体查看[<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>]。假设每米的电阻R'和电导C'均为零。特性阻抗Z0可以由单位长度的电感和电容(分别为L'和C')推导得出，即Z0=sqrt(L'/C')。传输线的长度等于对应于频率F的波长的四分之一，即传输延迟为4除以F。在这种情况下，特性阻抗被称为自然阻抗。</p>
<p><strong>参考文献:</strong>
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>],
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Hoefer1985</a>]</p>
</html>",    revisions="<html>
<ul>
<li><em> 1998   </em>
       由Joachim Haase<br>创建<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}}, 
          lineColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          fillColor={255,255,255}), 
        Line(points={{60,-100},{90,-100}}, color={0,0,255}), 
        Line(points={{60,100},{90,100}}, color={0,0,255}), 
        Line(points={{-60,100},{-90,100}}, color={0,0,255}), 
        Line(points={{-60,-100},{-90,-100}}, color={0,0,255}), 
        Text(
          extent={{-70,-10},{70,-50}}, 
          textString="TLine3"), 
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-40,40},{-40,20}}), 
        Line(points={{40,30},{-40,30}}), 
        Line(points={{40,40},{40,20}}), 
        Line(points={{-60,100},{-60,80}}, color={0,0,255}), 
        Line(points={{60,100},{60,80}}, color={0,0,255}), 
        Line(points={{60,-80},{60,-100}}, color={0,0,255}), 
        Line(points={{-60,-80},{-60,-100}}, color={0,0,255})}));
end TLine3;