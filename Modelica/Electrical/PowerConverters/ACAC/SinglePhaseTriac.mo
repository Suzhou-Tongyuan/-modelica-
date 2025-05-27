within Modelica.Electrical.PowerConverters.ACAC;
model SinglePhaseTriac "交流三极管"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  SI.Current i=p.i "从引脚 p 流向引脚 n 的电流";
  parameter SI.Resistance Ron(final min=0)=1e-5 
    "正向导通微分电阻（闭合电阻）";
  parameter SI.Conductance Goff(final min=0)=1e-5 
    "反向截止导纳（断开导纳）";
  parameter SI.Voltage Vknee(final min=0)=0 "正向阈值电压";
  parameter Boolean useHeatPort = false "= true，则启用热端口" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Temperature T=293.15 
    "如果 useHeatPort = false，则为固定设备温度" 
    annotation(Dialog(enable=not useHeatPort));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort 
    "条件热端口" 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), 
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.BooleanInput fire1 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.BooleanInput fire2 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}}, 
        rotation=90, 
        origin={60,-120})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor1(
    final Ron=Ron, 
    final Goff=Goff, 
    final Vknee=Vknee, 
    final useHeatPort=useHeatPort, 
    final T=T, 
    off(fixed=true)) 
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor thyristor2(
    final Ron=Ron, 
    final Goff=Goff, 
    final Vknee=Vknee, 
    final useHeatPort=useHeatPort, 
    final T=T, 
    off(fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}}, 
        rotation=180, 
        origin={0,-40})));
equation
  connect(fire1, thyristor1.fire) annotation (Line(points={{-60,-120},{-60,60},{
          10,60},{10,52}}, color={255,0,255}));
  connect(fire2, thyristor2.fire) annotation (Line(points={{60,-120},{60,-60},{-10, 
          -60},{-10,-52}}, color={255,0,255}));
  connect(thyristor1.heatPort, heatPort) annotation (Line(points={{0,30},{-20,30}, 
          {-20,-80},{0,-80},{0,-100}}, color={191,0,0}));
  connect(heatPort, thyristor2.heatPort) annotation (Line(points={{0,-100},{0,-80}, 
          {20,-80},{20,-30},{0,-30}}, color={191,0,0}));
  connect(p, thyristor1.p) 
    annotation (Line(points={{-100,0},{-10,0},{-10,40}}, color={0,0,255}));
  connect(p, thyristor2.n) 
    annotation (Line(points={{-100,0},{-10,0},{-10,-40}}, color={0,0,255}));
  connect(n, thyristor1.n) 
    annotation (Line(points={{100,0},{10,0},{10,40}}, color={0,0,255}));
  connect(n, thyristor2.p) 
    annotation (Line(points={{100,0},{10,0},{10,-40}}, color={0,0,255}));
  annotation (defaultComponentName="triac", 
    Icon(graphics={
        Text(
          extent={{-150,120},{150,80}}, 
          textString="%name", 
          textColor={0,0,255}), 
        Line(points={{-60,-100},{-60,-40},{-40,-30}}, 
                                                    color={255,0,255}), 
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
        Line(points={{90,0},{40,0}}, color={0,0,255}), 
        Line(points={{60,-100},{60,20},{40,30}}, color={255,0,255})}), 
      Documentation(info="<html>
<p>
简化的交流三极管模型，由两个反并联晶闸管构建。
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
<li><code>fire1=true </code> 和 <code>fire2=false</code>：门电流 > 0，触发 <code>thyristor1</code></li>
<li><code>fire1=false</code> 和 <code>fire2=true </code>：门电流 < 0，触发 <code>thyristor2</code></li>
<li><code>fire1=true </code> 和 <code>fire2=true </code>：禁止</li>
</ul>
</html>"));
end SinglePhaseTriac;