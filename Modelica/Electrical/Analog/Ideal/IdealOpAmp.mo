within Modelica.Electrical.Analog.Ideal;
model IdealOpAmp "理想运算放大器(无源元件-零元件对)"
  SI.Voltage v1 "Voltage drop over the left port";
  SI.Voltage v2 "Voltage drop over the right port";
  SI.Current i1 "Current flowing from pos. to neg. pin of the left port";
  SI.Current i2 "Current flowing from pos. to neg. pin of the right port";
  Interfaces.PositivePin p1 "左端口的正极" annotation (
      Placement(transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Interfaces.NegativePin n1 "左端口的负极" annotation (
      Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent={{-110,50},{-90,70}})));
  Interfaces.PositivePin p2 "右端口的正极" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));
  Interfaces.NegativePin n2 "右端口的负极" annotation (
      Placement(transformation(
        origin={0,-100}, 
        extent={{10,-10},{-10,10}}, 
        rotation=270)));
equation
  v1 = p1.v - n1.v;
  v2 = p2.v - n2.v;
  0 = p1.i + n1.i;
  0 = p2.i + n2.i;
  i1 = p1.i;
  i2 = p2.i;
  v1 = 0;
  i1 = 0;
  annotation (defaultComponentName="opAmp", 
    Documentation(info="<html>
<p>理想运算放大器是一个双端口设备。左端口被固定为<em>v1=0</em>且<em>i1=0</em>(这种状态被称为“虚地”)。右端口极为灵活，任何电压<em>v2</em>和任何电流<em>i2</em>都是可以被接受的。
</p>
</html>", 
        revisions="<html>
<ul>

<li><em>1998年</em>
       Christoph Clauss<br>最初实现<br>
       </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{60,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,130},{150,90}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Polygon(
          points={{70,0},{-70,80},{-70,-80},{70,0}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Line(points={{0,-40},{0,-100}}, color={0,0,255}), 
        Line(points={{-100,60},{-70,60}}, color={0,0,255}), 
        Line(points={{-100,-60},{-70,-60}}, color={0,0,255}), 
        Line(points={{70,0},{100,0}}, color={0,0,255}), 
        Line(points={{-60,50},{-40,50}}, color={0,0,255}), 
        Line(points={{-60,-50},{-40,-50}}, color={0,0,255}), 
        Line(points={{-50,-40},{-50,-60}}, color={0,0,255})}));
end IdealOpAmp;