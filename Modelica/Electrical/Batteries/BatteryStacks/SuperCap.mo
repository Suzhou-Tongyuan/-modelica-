within Modelica.Electrical.Batteries.BatteryStacks;
model SuperCap "超级电容器的简单模型"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  SI.Current i = p.i "进入超级电容器的电流";
  parameter SI.Voltage Vnom "额定电压";
  parameter SI.Voltage V0=Vnom "初始电压";
  parameter SI.Capacitance C "电容";
  parameter SI.ElectricCharge Qnom=C*Vnom "额定电荷";
  parameter SI.Resistance Rs "串联电阻";
  parameter SI.Temperature T_ref=293.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 "在 T_ref 温度下的电阻温度系数";
  parameter SI.Current Idis=0 "额定电压下的自放电电流" 
    annotation(Evaluate=true);
  extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
  Modelica.Electrical.Analog.Basic.Resistor resistor(
    final R=Rs, 
    final T_ref=T_ref, 
    final alpha=alpha, 
    final useHeatPort=true) 
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Electrical.Analog.Basic.Conductor conductor(
    final G=Idis/Vnom, 
    T_ref=293.15, 
    final useHeatPort=true) 
    annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(v(start=V0, fixed=true), final C=C) 
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
equation
  connect(p, resistor.p) 
    annotation (Line(points={{-100,0},{-50,0}}, color={0,0,255}));
  connect(resistor.n, capacitor.p) 
    annotation (Line(points={{-30,0},{30,0}}, color={0,0,255}));
  connect(capacitor.n, n) 
    annotation (Line(points={{50,0},{100,0}}, color={0,0,255}));
  connect(capacitor.p, conductor.p) 
    annotation (Line(points={{30,0},{30,-30},{30,-30}}, color={0,0,255}));
  connect(capacitor.n, conductor.n) 
    annotation (Line(points={{50,0},{50,-30}}, color={0,0,255}));
  connect(internalHeatPort, conductor.heatPort) annotation (Line(points={{0,-80}, 
          {0,-60},{40,-60},{40,-40}}, color={191,0,0}));
  connect(internalHeatPort, resistor.heatPort) annotation (Line(points={{0,-80}, 
          {0,-60},{-40,-60},{-40,-10}}, color={191,0,0}));
  annotation (Icon(graphics={
        Text(
          extent={{-150,60},{150,100}}, 
          textColor={0,0,255}, 
          textString="%name"), 
        Text(
          extent={{-150,-90},{150,-50}}, 
          textColor={0,0,0}, 
          textString="C=%C"), 
        Rectangle(
          extent={{-20,40},{-10,-40}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Rectangle(
          extent={{10,40},{20,-40}}, 
          lineColor={0,0,255}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-20,0}}, color={0,0,255}), 
        Line(points={{20,0},{90,0}}, color={0,0,255})}), Documentation(info="<html>
<p>
这是一个超级电容器的简单模型，包括：
</p>
<ul>
<li>理想电容</li>
<li>串联电阻</li>
<li>自放电导体</li>
</ul>
<h4>注意</h4>
<p>
未包含对充电过高、放电过低甚至反向充电的限制。
</p>
</html>"));
end SuperCap;