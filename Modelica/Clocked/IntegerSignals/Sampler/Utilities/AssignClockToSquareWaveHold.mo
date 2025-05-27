within Modelica.Clocked.IntegerSignals.Sampler.Utilities;
block AssignClockToSquareWaveHold 
"从时钟整数输入生成布尔连续时间方波信号"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;
  parameter Boolean y_start=false "输出信号的初始值";
  Modelica.Blocks.Interfaces.IntegerInput u 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y 
  "布尔输出信号连接器"     annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), 
        iconTransformation(extent={{100,-10},{120,10}})));
protected
  Boolean y2(start=y_start);
equation
  // 将 u 的时钟与 y2 联系起来的虚拟条件
  y2 = if u > 0 then not previous(y2) else not previous(y2);
  y = hold(y2);
  annotation (
    defaultComponentName="clockToSquareWave", 
    Icon(coordinateSystem(
      preserveAspectRatio=true, 
      extent={{-100,-100},{100,100}}), 
      graphics={
        Polygon(
          points={{-80,88},{-88,66},{-72,66},{-80,88}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,66},{-80,-82}}, color={255,0,255}), 
        Line(points={{-90,-70},{72,-70}}, color={255,0,255}), 
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}}, 
          lineColor={255,0,255}, 
          fillColor={255,0,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(
          extent={{71,7},{85,-7}}, 
          lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
          fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}), 
          fillPattern=FillPattern.Solid), 
        Line(points={{-80,-70},{-40,-70},{-40,44},{0,44}, 
              {0,-70},{40,-70},{40,44},{79,44}})}), 
    Documentation(info="<html>
<p>
该整数信号模块的工作原理与相应的实数信号模块类似（参见 <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold\">RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold</a>）。
</p>
</html>"));
end AssignClockToSquareWaveHold;