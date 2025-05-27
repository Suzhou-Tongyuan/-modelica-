within Modelica.Electrical.Analog.Lines;
model OLine "有损传输线"
  Modelica.Electrical.Analog.Interfaces.Pin p1 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin p2 annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin p3 annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}})));
  SI.Voltage v13;
  SI.Voltage v23;
  SI.Current i1;
  SI.Current i2;
  parameter Real r(
    final min=Modelica.Constants.small, 
    unit="Ohm/m", 
    start=1) "每米电阻";
  parameter Real l(
    final min=Modelica.Constants.small, 
    unit="H/m", 
    start=1) "每米电感";
  parameter Real g(
    final min=Modelica.Constants.small, 
    unit="S/m", 
    start=1) "每米电导";
  parameter Real c(
    final min=Modelica.Constants.small, 
    unit="F/m", 
    start=1) "每米电容";
  parameter SI.Length length(final min=Modelica.Constants.small, 
      start=1) "线长";
  parameter Integer N(final min=1, start=1) "分段数";
  parameter SI.LinearTemperatureCoefficient alpha_R=0 
    "电阻的温度系数 (R_actual = R*(1 + alpha*(heatPort.T - T_ref))";
  parameter SI.LinearTemperatureCoefficient alpha_G=0 
    "电导的温度系数 (G_actual = G/(1 + alpha*(heatPort.T - T_ref))";
  parameter Boolean useHeatPort=false "= true，如果启用了热端口" 
    annotation (
    Evaluate=true, 
    HideResult=true, 
    choices(checkBox=true));
  parameter SI.Temperature T=293.15 
    "如果未启用热端口，则设备的固定温度" 
    annotation (Dialog(enable=not useHeatPort));
  parameter SI.Temperature T_ref=300.15 "参考温度";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), 
        iconTransformation(extent={{-110,-110},{-90,-90}})));
protected
  parameter SI.Resistance rm[N + 1]= 
  {if i==1 or i==N + 1 then r*length/(N*2) else r*length/N for i in 1:N+1};
  Modelica.Electrical.Analog.Basic.Resistor R[N + 1](
    R=rm, 
    T_ref=fill(T_ref, N + 1), 
    alpha=fill(alpha_R, N + 1), 
    useHeatPort=fill(useHeatPort, N + 1), 
    T=fill(T, N + 1));
  parameter SI.Inductance lm[N + 1]= 
  {if i==1 or i==N + 1 then l*length/(N*2) else l*length/N for i in 1:N+1};
  Modelica.Electrical.Analog.Basic.Inductor L[N + 1](L=lm);
  Modelica.Electrical.Analog.Basic.Capacitor C[N](C=fill(c*length/(N), N));
  Modelica.Electrical.Analog.Basic.Conductor G[N](
    G=fill(g*length/(N), N), 
    T_ref=fill(T_ref, N), 
    alpha=fill(alpha_G, N), 
    useHeatPort=fill(useHeatPort, N), 
    T=fill(T, N));
equation
  v13 = p1.v - p3.v;
  v23 = p2.v - p3.v;
  i1 = p1.i;
  i2 = p2.i;
  connect(p1, R[1].p);
  for i in 1:N loop
    connect(R[i].n, L[i].p);
    connect(L[i].n, C[i].p);
    connect(L[i].n, G[i].p);
    connect(C[i].n, p3);
    connect(G[i].n, p3);
    connect(L[i].n, R[i + 1].p);
  end for;
  connect(R[N + 1].n, L[N + 1].p);
  connect(L[N + 1].n, p2);
  if useHeatPort then
    for i in 1:N + 1 loop
      connect(heatPort, R[i].heatPort);
    end for;
    for i in 1:N loop
      connect(heatPort, G[i].heatPort);
    end for;
  end if;
  annotation (defaultComponentName="line", 
    Documentation(info="<html><p>
如同下图所示，有损传输线OLine是一根单导体有损传输线，由连续放置的电阻和电感元件 (分别在同轴线上) 以及连接在参考脚p3上的导体和电容元件组成。该模型的精度取决于选择的拆分段数N。
</p>
<p>
为了获得对称的线路模型，首先将首个阻抗和电感分为两部分(R1和R_Nplus1，L1和L_Nplus1）。这两个新的阻抗和电感的阻值分别为原来阻抗的一半，电导的阻值也是原来电导的一半。 
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/Analog/OLine.png\" alt=\"OLine.png\" data-href=\"\" style=\"\"/>
</p>
<p>
电容C=c*length/N. <br>电导G=g*length/N. <br>电阻R=r*length/(N+1). <br>电感L=l*length/(N+1). <br>对所有电容元件、导体、电阻元件和电感元件来说，它们每个分段的值都是相同的，只有第一个和最后一个电阻元件和电感元件的值不同，它们的值只有上述计算出的其他元件值的一半。
</p>
<p>
用户有可能启用可选的热门端口(conditional heatpor)。如果这样做，那么OLine可以连接到一个热传递网络。当参数alpha设置为大于零的值时，由于其电阻的电阻值会因温度变化而变化，因此OLine会变得温度敏感。 其中电阻<code>R_actual = R*(1 + alpha*(heatPort.T - T_ref))</code>电导为<code> (G_actual = G/(1 + alpha*(heatPort.T - T_ref))。</code>
</p>
<p>
请注意，这与SPICE中的集总线路模型是不同的。
</p>
<p>
<strong>参考文献：</strong> [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\" target=\"\">Johnson1991</a>&nbsp;]
</p>
</html>",revisions="<html>
<ul>
<li><em> 2016   </em>
       由Christoph Clauss<br>修改了电阻和电感的计算方法<br>
       </li>
<li><em> 1998   </em>
       由Christoph Clauss<br>创建br>
       </li></ul>
</html>"), 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{0,-80},{0,-90}}, color={0,0,255}), 
        Line(points={{80,0},{90,0}}, color={0,0,255}), 
        Line(points={{-80,0},{-90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,130},{150,90}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{40,30},{-40,30}}), 
        Line(points={{-40,40},{-40,20}}), 
        Line(points={{40,40},{40,20}})}));
end OLine;