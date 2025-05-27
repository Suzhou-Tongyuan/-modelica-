within Modelica.Electrical.Analog.Sources;
model SignalVoltage 
  "使用输入信号作为电压源的通用电压源"

  extends Modelica.Electrical.Analog.Icons.VoltageSource;
  Interfaces.PositivePin p annotation (Placement(transformation(extent={{-110, 
            -10},{-90,10}})));
  Interfaces.NegativePin n annotation (Placement(transformation(extent={{110, 
            -10},{90,10}})));
  Modelica.Blocks.Interfaces.RealInput v(unit="V") 
    "引脚p和n之间的电压(=p.v-n.v)作为输入信号" annotation (
      Placement(transformation(
        origin={0,120}, 
        extent={{-20,-20},{20,20}}, 
        rotation=270)));
  SI.Current i "Current flowing from pin p to pin n";
equation
  v = p.v - n.v;
  0 = p.i + n.i;
  i = p.i;
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
                            Line(points={{-109,20},{-84, 
          20}}, color={160,160,164}),Polygon(
            points={{-94,23},{-84,20},{-94,17},{-94,23}}, 
            lineColor={160,160,164}, 
            fillColor={160,160,164}, 
            fillPattern=FillPattern.Solid),Line(points={{91,20},{116,20}}, 
          color={160,160,164}),Text(
            extent={{-109,25},{-89,45}}, 
            textColor={160,160,164}, 
            textString="i"),Polygon(
            points={{106,23},{116,20},{106,17},{106,23}}, 
            lineColor={160,160,164}, 
            fillColor={160,160,164}, 
            fillPattern=FillPattern.Solid),Text(
            extent={{91,45},{111,25}}, 
            textColor={160,160,164}, 
            textString="i"),Line(points={{-119,-5},{-119,5}}, color={160,160,164}), 
          Line(points={{-124,0},{-114,0}}, color={160,160,164}),Line(
          points={{116,0},{126,0}}, color={160,160,164})}), 
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       Martin Otter<br>创建<br>
       </li>
</ul>
</html>", 
        info="<html>
<p>信号电压源是一个将实值信号转换为源电压的无参数转换器。它不考虑其他效应。输入的实值信号需要由库中的组件提供。它可以看作是电压传感器的“反面”，即它不是测量电压，而是生成电压以响应输入信号。
</p>

</html>"));
end SignalVoltage;