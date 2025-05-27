within Modelica.Electrical.Analog.Lines;
model TLine2 
  "无损耗传输线(特性阻抗为Z0,工作频率为F,且具有归一化长度NL)"

  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  parameter SI.Resistance Z0(start=1) 
    "特性阻抗";
  parameter SI.Frequency F(start=1) "频率";
  parameter Real NL(start=1) "归一化长度";
protected
  SI.Voltage er;
  SI.Voltage es;
  parameter SI.Time TD=NL/F;
equation
  assert(Z0 > 0, "Z0必须为正");
  assert(NL > 0, "NL必须为正");
  assert(F > 0, "F必须为正");
  i1 = (v1 - es)/Z0;
  i2 = (v2 - er)/Z0;
  es = 2*delay(v2, TD) - delay(er, TD);
  er = 2*delay(v1, TD) - delay(es, TD);
  annotation (defaultComponentName="line", 
    Documentation(info="<html>
<p>具有特性阻抗Z0、频率F和归一化长度NL的无损耗传输线TLine2是一个双端口网络。两个端口分支均由一个阻值等于特性阻抗Z0的电阻和一个考虑了传输延迟的受控电压源组成。
具体查看[<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>]。
假设每米的电阻R'和电导C'均为零。特性阻抗Z0可以从单位长度的电感和电容(分别为L'和C')推导出来，即Z0=sqrt(L'/C')。归一化长度NL等于传输线长度与与频率F对应的波长之比，即传输延迟TD为NL除以F的商。
</p>
<p><strong>参考文献：</strong>
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Branin1967</a>],
   [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Hoefer1985</a>]</p>
</html>",    revisions="<html>
<dl>
<dt><em>1998</em></dt>
<dd>由Joachim Haase创建</dd>
</dl>
</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,150},{150,110}}, 
          textString="%name", 
          textColor={0,0,255}), 
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
          textString="TLine2"), 
        Line(points={{-40,40},{-40,20}}), 
        Line(points={{40,30},{-40,30}}), 
        Line(points={{40,40},{40,20}}), 
        Line(points={{-60,100},{-60,80}}, color={0,0,255}), 
        Line(points={{60,100},{60,80}}, color={0,0,255}), 
        Line(points={{60,-80},{60,-100}}, color={0,0,255}), 
        Line(points={{-60,-80},{-60,-100}}, color={0,0,255})}));
end TLine2;