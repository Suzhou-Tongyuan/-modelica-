within Modelica.Electrical.Analog.Basic;
model VariableConductor 
  "理想线性可变电导"
  parameter SI.Temperature T_ref=300.15 "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 
    "电导率的温度系数(G_actual = G/(1 + alpha*(T_heatPort - T_ref))";
  extends Modelica.Electrical.Analog.Interfaces.OnePort;
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Conductance G_actual 
    "Actual conductance = G/(1 + alpha*(T_heatPort - T_ref))";
  Modelica.Blocks.Interfaces.RealInput G(unit="S") annotation (Placement(
        transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "Temperature outside scope of model!");
  G_actual = G/(1 + alpha*(T_heatPort - T_ref));
  i = G_actual*v;
  LossPower = v*i;
  annotation (defaultComponentName="conductor", 
    Documentation(info="<html>
<p>线性导体通过下面式子将分支电压<em>v</em>与分支电流<em>i</em>连接起来

<br><em><strong>i=G*v</strong></em>
<br>电导<em>G</em>是作为输入信号
<br><br><strong>请注意：</strong>
<br>建议电导G信号不要穿过零值。否则，根据周围电路的情况，奇异性的概率会很高。</p>
</html>", 
        revisions="<html>
<ul>
<li><em> 2009/8/7   </em>
     Anton Haumer<br> 添加电阻温度系数<br>
     </li>
<li><em> 2009/3/11   </em>
     Christoph Clauss<br>添加条件热端口<br>
     </li>

<li><em> 2004/6/7   </em>
      Christoph Clauss<br>修改说明文档<br>
     </li>
     
     
<li><em> 2004/6/7</em>
     Anton Haumer<br> 创建<br>
     </li>
</ul>

</html>"), 
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{-90,0},{-70,0}}, color={0,0,255}), 
        Rectangle(
          extent={{-70,30},{70,-30}}, 
          lineColor={0,0,255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{70,0},{90,0}}, color={0,0,255}), 
        Text(
          extent={{-150,90},{150,50}}, 
          textString="%name", 
          textColor={0,0,255})}));
end VariableConductor;