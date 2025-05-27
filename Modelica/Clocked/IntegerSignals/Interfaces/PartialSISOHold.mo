within Modelica.Clocked.IntegerSignals.Interfaces;
partial block PartialSISOHold 
  "用于整数信号零阶保持的基本模块"
  parameter Integer y_start = 0 
    "与输入 u 相关联的时钟第一次滴答声之前输出 y 的值";

  Modelica.Blocks.Interfaces.IntegerInput u(final start=y_start) 
    "时钟、整数输入信号连接器" 
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y 
    "连续时间、整数输出信号连接器" 
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  annotation (
    defaultComponentName="hold1", 
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        initialScale=0.06), 
                     graphics={Line(points={{-60,-40},{-20,-40},{-20,20},{20,20}, 
              {20,60},{60,60},{60,0},{100,0},{100,0},{100,0},{100,0},{120,0}}, 
                                 color={255,128,0}), 
                                                   Line(
          points={{-60,-40},{-60,0},{-100,0}}, 
          color={255,128,0}), 
        Text(
          extent={{-150,-100},{150,-140}}, 
          textString="%y_start", 
          textColor={0,0,0}), 
        Text(
          extent={{-150,130},{150,90}}, 
          textString="%name", 
          textColor={0,0,255})}), 
    Documentation(info="<html>

</html>"));
end PartialSISOHold;