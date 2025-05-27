within Modelica.Electrical.Analog.Basic;
model Conductor "理想线性电导"
  parameter SI.Conductance G(start=1) 
    "在温度T_ref时的电导";
  parameter SI.Temperature T_ref=300.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 
    "电导的温度因数(G_actual=G_ref/(1+alpha*(T_heatPort-T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Conductance G_actual 
    "实际电导=G_ref/(1+alpha*(T_heatPort-T_ref))";

equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "Temperature outside scope of model!");
  G_actual = G/(1 + alpha*(T_heatPort - T_ref));
  i = G_actual*v;
  LossPower = v*i;
  annotation (
    Documentation(info="<html>
    
<p>线性导体通过公式<em>i=v*G</em>将支路电压<em>v</em>与支路电流<em>i</em>连接起来。电导<em>G</em>可以为正、零或负。</p>
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
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid, 
          lineColor={0,0,255}), 
        Rectangle(extent={{-70,30},{70,-30}}, lineColor={0,0,255}), 
        Line(points={{-90,0},{-70,0}}, color={0,0,255}), 
        Line(points={{70,0},{90,0}}, color={0,0,255}), 
        Line(
          visible=useHeatPort, 
          points={{0,-100},{0,-30}}, 
          color={127,0,0}, 
          pattern=LinePattern.Dot), 
        Text(
          extent={{-150,-40},{150,-80}}, 
          textString="G=%G"), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end Conductor;