within Modelica.Electrical.Machines.BasicMachines.Components;
model SquirrelCage "松鼠笼"
  parameter SI.Inductance Lrsigma 
    "每相转换到定子的转子杂散电感";
  parameter SI.Resistance Rr 
    "每相转换到T_ref时定子的转子电阻";
  parameter SI.Temperature T_ref=293.15 
    "参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 
    "在T_ref时电阻的温度系数";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Resistance Rr_actual 
    "实际电阻 = Rr*(1 + alpha*(T_heatPort - T_ref))";
  Machines.Interfaces.SpacePhasor spacePhasor_r 
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  Modelica.Blocks.Interfaces.RealOutput i[2](
    each final quantity="ElectricCurrent", 
    each final unit="A") = -spacePhasor_r.i_ 
    "松鼠笼输出电流";
equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "模型范围外的温度！");
  Rr_actual = Rr*(1 + alpha*(T_heatPort - T_ref));
  spacePhasor_r.v_ = Rr_actual*spacePhasor_r.i_ + Lrsigma*der(
    spacePhasor_r.i_);
  2/3*LossPower = Rr_actual*(spacePhasor_r.i_[1]*spacePhasor_r.i_[1] + 
    spacePhasor_r.i_[2]*spacePhasor_r.i_[2]);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}), graphics={Line(points={{-100,60},{-60, 
          60}}, color={0,0,255}),Line(points={{60,60},{80,60},{80,40}}, 
          color={0,0,255}),Rectangle(
                extent={{60,40},{100,-40}}, 
                lineColor={0,0,255}, 
                fillColor={255,255,255}, 
                fillPattern=FillPattern.Solid),Line(points={{80,-40},{80, 
          -60}}, color={0,0,255}),Line(points={{60,-60},{100,-60}}, color= 
           {0,0,255}),Line(points={{70,-80},{90,-80}}, color={0,0,255}), 
          Line(points={{66,-70},{94,-70}}, color={0,0,255}),Text(
                extent={{-150,-148},{150,-110}}, 
                textColor={0,0,255}, 
                textString="%name"),Line(points={{-100,90},{-100,60}}, 
          color={0,0,255}), 
        Line(
          points={{-60,60},{-59,66},{-52,74},{-38,74},{-31,66},{-30,60}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-30,60},{-29,66},{-22,74},{-8,74},{-1,66},{0,60}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{0,60},{1,66},{8,74},{22,74},{29,66},{30,60}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{30,60},{31,66},{38,74},{52,74},{59,66},{60,60}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier)}), 
                              Documentation(info="<html>
<p>
两轴中的松鼠笼/对称阻尼笼模型。
</p>
<p>
松鼠笼具有一个可选的(条件)HeatPort，可以通过布尔参数useHeatPort启用或禁用。
两个轴的温度相同，两个损耗相加。
两个轴的材料特性alpha相同。
</p>
</html>"));
end SquirrelCage;