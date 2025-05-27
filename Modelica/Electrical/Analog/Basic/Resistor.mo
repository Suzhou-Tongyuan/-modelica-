within Modelica.Electrical.Analog.Basic;
model Resistor "理想线性电阻"
  parameter SI.Resistance R(start=1) 
    "在温度T_ref时的电阻";
  parameter SI.Temperature T_ref=300.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 
    "电阻的温度因数(R_actual=R*(1+alpha*(T_heatPort-T_ref))";

  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Resistance R_actual 
    "实际电阻=R*(1+alpha*(T_heatPort-T_ref))";

equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "Temperature outside scope of model!");
  R_actual = R*(1 + alpha*(T_heatPort - T_ref));
  v = R_actual*i;
  LossPower = v*i;
  annotation (
    Documentation(info="<html>
    
<p>线性电阻通过电流<em>i</em>和分支电压<em>v</em>之间的关系<em>i*R=v</em>连接它们。电阻<em>R</em>允许为正数、零或负数。</p>
</html>", 
        revisions="<html>
<ul>
<li><em> 2009/8/7   </em>
     Anton Haumer<br> 添加电阻温度系数<br>
     </li>
<li><em> 2009/3/11   </em>
     Christoph Clauss<br>添加条件热端口<br>
     </li>
<li><em> 2002   </em>
     Anton Haumer<br> 创建<br>
     </li>
</ul>
</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,0},{-70,0}}, color={0,0,255}), 
        Line(points={{70,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,-40},{150,-80}}, 
          textString="R=%R"), 
        Line(
          visible=useHeatPort, 
          points={{0,-100},{0,-30}}, 
          color={127,0,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end Resistor;