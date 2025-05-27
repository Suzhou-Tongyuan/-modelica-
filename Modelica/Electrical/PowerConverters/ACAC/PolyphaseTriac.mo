within Modelica.Electrical.PowerConverters.ACAC;
model PolyphaseTriac "交流三极管"
  extends Modelica.Electrical.Polyphase.Interfaces.TwoPlug;
  parameter SI.Resistance Ron(final min=0)=1e-5 
    "正向导通微分电阻（闭合电阻）";
  parameter SI.Conductance Goff(final min=0)=1e-5 
    "反向截止导纳（断开导纳）";
  parameter SI.Voltage Vknee(final min=0)=0 "正向阈值电压";
  extends Modelica.Electrical.Polyphase.Interfaces.ConditionalHeatPort(final mh=m);
  Modelica.Blocks.Interfaces.BooleanInput fire1[m] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.BooleanInput fire2[m] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={60,-120})));
  Modelica.Electrical.Polyphase.Basic.PlugToPins_p plugToPins_p(final m=m) 
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPins_n plugToPins_n(final m=m) 
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  SinglePhaseTriac triac[m](each useHeatPort=useHeatPort) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p, plugToPins_p.plug_p) 
    annotation (Line(points={{-100,0},{-82,0}}, color={0,0,255}));
  connect(plugToPins_n.plug_n, plug_n) 
    annotation (Line(points={{82,0},{100,0}},               color={0,0,255}));
  connect(triac.heatPort, heatPort) 
    annotation (Line(points={{0,-10},{0,-100}}, color={191,0,0}));
  connect(fire1, triac.fire1) annotation (Line(points={{-60,-120},{-60,-20},{-6, 
          -20},{-6,-12}}, color={255,0,255}));
  connect(fire2, triac.fire2) annotation (Line(points={{60,-120},{60,-20},{6,-20}, 
          {6,-12}}, color={255,0,255}));
  connect(plugToPins_p.pin_p, triac.p) 
    annotation (Line(points={{-78,0},{-10,0}}, color={0,0,255}));
  connect(triac.n, plugToPins_n.pin_n) 
    annotation (Line(points={{10,0},{78,0}}, color={0,0,255}));
  annotation (defaultComponentName="triac", 
    Icon(graphics={
        Text(
          extent={{-150,120},{150,80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-60,-100},{-60,-40},{-40,-30}}, 
                                                    color={255,0,255}), 
        Line(points={{60,-100},{60,20},{40,30}}, color={255,0,255}), 
        Line(points={{-40,-70},{-40,70}}, color={0,0,255}), 
        Line(points={{40,-72},{40,70}}, color={0,0,255}), 
        Polygon(points={{-40,-70},{40,-30},{-40,10},{-40,-70}}, 
                                                             lineColor={0,0, 
              255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(points={{40,-10},{-40,30},{40,70},{40,-10}}, lineColor={0,0, 
              255}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-40,0},{-90,0}}, color={0,0,255}), 
        Line(points={{90,0},{40,0}}, color={0,0,255})}), 
      Documentation(info="<html>
<p>
简化的 <code>m</code>
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">交流三极管</a> 模型，每个由两个反并联晶闸管构成。
<code>thyristor1</code> 在电压的正半波期间必须被触发。
<code>thyristor2</code> 在电压的负半波期间必须被触发。
</p>
<p>
注意：真实的三极管通过正向（<code>thyristor1</code>）的正向门电流触发，通过负向（<code>thyristor2</code>）的负向门电流触发。
当电流降至零时，三极管进入阻止状态。
</p>
<p>
这种行为通过两个触发门 <code>fire1</code> 和 <code>fire2</code> 模拟：
</p>
<ul>
<li><code>fire1=false</code> 和 <code>fire2=false</code>：门电流 = 0，保持阻止状态</li>
<li><code>fire1=true </code> 和 <code>fire2=false</code>：门电流 &gt; 0，触发 <code>thyristor1</code></li>
<li><code>fire1=false</code> 和 <code>fire2=true</code>：门电流 < 0，触发 <code>thyristor2</code></li>
<li><code>fire1=true </code> 和 <code>fire2=true</code>：禁止</li>
</ul>
</html>"));
end PolyphaseTriac;