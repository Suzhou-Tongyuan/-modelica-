within Modelica.Electrical.Analog.Lines;
model ULine "损耗RC线"
  //extends Interfaces.ThreePol;
  Modelica.Electrical.Analog.Interfaces.Pin p1 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin p2 annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin p3 annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}), 
        iconTransformation(extent={{-10,-110},{10,-90}})));
  SI.Voltage v13;
  SI.Voltage v23;
  SI.Current i1;
  SI.Current i2;
  parameter Real r(
    final min=Modelica.Constants.small, 
    unit="Ohm/m", 
    start=1) "单位电阻";
  parameter Real c(
    final min=Modelica.Constants.small, 
    unit="F/m", 
    start=1) "单位电容";
  parameter SI.Length length(final min=Modelica.Constants.small, 
      start=1) "线路长度";
  parameter Integer N(final min=1, start=1) "聚集段数";
  parameter SI.LinearTemperatureCoefficient alpha=0 
    "电阻的温度因数(R_actual=R*(1+alpha*(heatPort.T-T_ref))";
  parameter Boolean useHeatPort=false "=true,当heatPort=enabled" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  parameter SI.Temperature T=293.15 
    "修正后设备温度，当useHeatPort=false" 
    annotation (Dialog(enable=not useHeatPort));
  parameter SI.Temperature T_ref=300.15 "参考温度";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), 
        iconTransformation(extent={{-108,-110},{-88,-90}})));
protected
   parameter SI.Resistance rm[N + 1]= 
  {if i==1 or i==N + 1 then r*length/(N*2) else r*length/N for i in 1:N+1};
  Modelica.Electrical.Analog.Basic.Resistor R[N + 1](
    R=rm, 
    T_ref=fill(T_ref, N + 1), 
    alpha=fill(alpha, N + 1), 
    useHeatPort=fill(useHeatPort, N + 1), 
    T=fill(T, N + 1));
  Modelica.Electrical.Analog.Basic.Capacitor C[N](C=fill(c*length/(N), N));
equation
  v13 = p1.v - p3.v;
  v23 = p2.v - p3.v;
  i1 = p1.i;
  i2 = p2.i;
  connect(p1, R[1].p);
  for i in 1:N loop
    connect(R[i].n, R[i + 1].p);
  end for;
  for i in 1:N loop
    connect(R[i].n, C[i].p);
  end for;
  for i in 1:N loop
    connect(C[i].n, p3);
  end for;
  connect(R[N + 1].n, p2);
  if useHeatPort then
    for i in 1:N + 1 loop
      connect(heatPort, R[i].heatPort);
    end for;
  end if;
  annotation (defaultComponentName="line", 
    Documentation(info="<html>
<p>如下图所示，Ulined是一个单导线失调RC线路，由连接到参考引脚p3的电抗R和电容C段序列构成。模型的精度取决于聚集段数N。

<br>为了得到一个对称的线模型，首先将电抗R分成两个部分(R1和R_Nplus1)。这两个新电抗的电阻值分别为原电抗的一半。

</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/ULine.png\"
     alt=\"ULine.png\">
</blockquote>
<p>
电容C=c*length/N.
<br>电阻R=r*length/(N+1).
<br>所有电容器和电抗器的每个段值都相同，只有第一个和最后一个电抗器的值不同，它们分别为上述计算值的一半。
</p>
<p>用户可以选择启用一个条件性热端口。如果这样做，ULine可以连接到一个热网络。当参数alpha被设置为大于零的值时，由于其电阻器的作用，ULine会变得对温度敏感。
<code>R_actual=R*(1+alpha*(heatPort.T-T_ref))</code>.</p>
<p>请注意，这与SPICE中的集总线路模型是不同的。</p>
<p><strong>参考文献</strong> [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Johnson1991</a>]</p>
</html>",    revisions="<html>
<dl>
<dt><em>2016</em></dt>
<dd>by Christoph Clauss resistance calculation revised</dd>
<dt><em>1998</em></dt>
<dd>by Christoph Clauss initially implemented</dd>
</dl>
</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,130},{150,90}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Rectangle(
          extent={{-80,80},{80,-80}}, 
          lineColor={0,0,255}, 
          fillPattern=FillPattern.Solid, 
          fillColor={255,255,255}), 
        Line(points={{80,0},{100,0}}, color={0,0,255}), 
        Line(points={{-80,0},{-100,0}}, color={0,0,255}), 
        Line(points={{-40,40},{-40,20}}), 
        Line(points={{40,30},{-40,30}}), 
        Line(points={{40,40},{40,20}}), 
        Line(points={{0,-80},{0,-100}}, color={0,0,255}), 
        Text(
          extent={{-70,-10},{70,-50}}, 
          textString="ULine")}));
end ULine;