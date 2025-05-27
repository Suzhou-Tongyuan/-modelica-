within Modelica.Electrical.Machines.BasicMachines.Components;
model DamperCage "阻尼笼"
  parameter SI.Inductance Lrsigmad 
    "每相转换到定子的d轴阻尼杂散电感";
  parameter SI.Inductance Lrsigmaq 
    "每相转换到定子的q轴阻尼杂散电感";
  parameter SI.Resistance Rrd 
    "每相转换到T_ref时定子的d轴阻尼电阻";
  parameter SI.Resistance Rrq 
    "每相转换到T_ref时定子的q轴阻尼电阻";
  parameter SI.Temperature T_ref=293.15 
    "d-轴和q-轴阻尼电阻的参考温度";
  parameter SI.LinearTemperatureCoefficient alpha=0 
    "在T_ref时d-轴和q-轴阻尼电阻的温度系数";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
  SI.Resistance Rrd_actual 
    "实际电阻 = Rrd*(1 + alpha*(T_heatPort - T_ref))";
  SI.Resistance Rrq_actual 
    "实际电阻 = Rrq*(1 + alpha*(T_heatPort - T_ref))";
  Modelica.Blocks.Interfaces.RealOutput i[2](
    each final quantity="ElectricCurrent", 
    each final unit="A") = -spacePhasor_r.i_ "阻尼输出电流";
  Modelica.Blocks.Interfaces.RealOutput lossPower(
    final quantity="Power", 
    final unit="W") = LossPower "阻尼损耗";
  Machines.Interfaces.SpacePhasor spacePhasor_r 
    annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
equation
  assert((1 + alpha*(T_heatPort - T_ref)) >= Modelica.Constants.eps, 
    "模型范围外的温度！");
  Rrd_actual = Rrd*(1 + alpha*(T_heatPort - T_ref));
  Rrq_actual = Rrq*(1 + alpha*(T_heatPort - T_ref));
  spacePhasor_r.v_[1] = Rrd_actual*spacePhasor_r.i_[1] + Lrsigmad*der(
    spacePhasor_r.i_[1]);
  spacePhasor_r.v_[2] = Rrq_actual*spacePhasor_r.i_[2] + Lrsigmaq*der(
    spacePhasor_r.i_[2]);
  2/3*LossPower = Rrd_actual*spacePhasor_r.i_[1]*spacePhasor_r.i_[1] + 
    Rrq_actual*spacePhasor_r.i_[2]*spacePhasor_r.i_[2];
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100, 
            -100},{100,100}}, 
        grid={2,2}), graphics={
        Line(points={{60,60},{100,60}}, color={0,0,255}), 
        Line(points={{70,40},{90,40}}, color={0,0,255}), 
        Line(points={{66,50},{94,50}}, color={0,0,255}), 
        Line(points={{-80,0},{-80,-20}}, color={0,0,255}), 
        Rectangle(extent={{20,90},{60,70}}, lineColor={0,0,255}), 
        Line(points={{60,80},{80,80},{80,60}}, color={0,0,255}), 
        Line(points={{-100,90},{-100,80},{-60,80}}, color={0,0,255}), 
        Line(points={{-100,90},{-100,80},{-80,80},{-80,60}}, color={0,0,255}), 
        Line(points={{0,80},{20,80}}, color={0,0,255}), 
        Rectangle(extent={{-90,-20},{-70,-60}}, lineColor={0,0,255}), 
        Line(points={{-100,-80},{-60,-80}}, color={0,0,255}), 
        Line(points={{-90,-100},{-70,-100}}, color={0,0,255}), 
        Line(points={{-94,-90},{-66,-90}}, color={0,0,255}), 
        Line(points={{-80,-60},{-80,-80}}, color={0,0,255}), 
        Line(
          points={{-60,80},{-59,85},{-54,90},{-46,90},{-41,85},{-40,80}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-40,80},{-39,85},{-34,90},{-26,90},{-21,85},{-20,80}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-20,80},{-19,85},{-14,90},{-6,90},{-1,85},{0,80}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier), 
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-85,50}, 
          rotation=90), 
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-85,30}, 
          rotation=90), 
        Line(
          points={{-10,-5},{-9,0},{-4,5},{4,5},{9,0},{10,-5}}, 
          color={0,0,255}, 
          smooth=Smooth.Bezier, 
          origin={-85,10}, 
          rotation=90),                                     Text(
                extent={{-150,-148},{150,-110}}, 
                textColor={0,0,255}, 
                textString="%name")}), 
                          Documentation(info="<html>
<p>
两轴中的不对称阻尼笼模型。
</p>
<p>
阻尼笼具有一个可选的(条件)HeatPort，
可以通过布尔参数useHeatPort启用或禁用。
两个轴的温度相同，两个损耗相加。
alpha的材料特性可以分别设置在d轴和q轴，
尽管两个电阻的参考温度相同。
</p>
</html>"));
end DamperCage;