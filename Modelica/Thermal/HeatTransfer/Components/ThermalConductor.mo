within Modelica.Thermal.HeatTransfer.Components;
model ThermalConductor 
  "传输热量而不储存热量的集总热元件"
  extends Interfaces.Element1D;
  parameter SI.ThermalConductance G 
    "材料的恒定热导率";

equation
  Q_flow = G*dT;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-90,70},{90,-70}}, 
          pattern=LinePattern.None, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Backward), 
        Line(
          points={{-90,70},{-90,-70}}, 
          thickness=0.5), 
        Line(
          points={{90,70},{90,-70}}, 
          thickness=0.5), 
        Text(
          extent={{-150,120},{150,80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Text(
          extent={{-150,-80},{150,-110}}, 
          textString="G=%G")}), 
    Documentation(info="<html><p>
这是一个描述热量传输而不储存的模型；另请参阅: <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalResistor\" target=\"\">ThermalResistor</a>&nbsp; 。 它可用于复杂的几何形状，其中热导率 G（= 热阻的倒数） 通过测量确定，并假定其在工作范围内恒定不变。如果组件主要由一种材料和规则几何形状组成，则可以计算出热导率 G，例如，可使用以下公式之一计算:
</p>
<li>
<strong>长方体</strong>热导计算（假设热量沿长方体长度方向流动）:</li>
<li>
<strong>圆柱体</strong>热导计算（假设热量从圆柱体内半径流向外半径）：</li>
<p>
<br>
</p>
<pre><code >20 摄氏度时 k 的典型值，单位 W/（m.K）:
  aluminium   220
  concrete      1
  copper      384
  iron         74
  silver      407
  steel        45 .. 15 (V2A)
  wood         0.1 ... 0.2
</code></pre><p>
<br>
</p>
</html>"));
end ThermalConductor;