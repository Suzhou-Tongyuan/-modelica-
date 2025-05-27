within Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit;
block CriticalDamping 
  "输出经 n 阶滤波器滤波后的输入信号，该滤波器具有临界阻尼"

  import Modelica.Blocks.Types.Init;
  extends Modelica.Blocks.Interfaces.SISO;

  parameter Integer n=2 "过滤器的顺序";
  parameter SI.Frequency f(start=1) "截止频率";
  parameter Boolean normalized = true 
    "= true，如果 f_cut 处的振幅为 3 dB，否则为未修改滤波器";
  output Real x[n](start=zeros(n)) "Filter states";
protected
  parameter Real alpha=if normalized then sqrt(2^(1/n) - 1) else 1.0 
    "归一化滤波器的频率修正系数";
  parameter Real w=2*Modelica.Constants.pi*f/alpha;
equation
  der(x[1]) = (u - x[1])*w;
  for i in 2:n loop
    der(x[i]) = (x[i - 1] - x[i])*w;
  end for;
  y = x[n];
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Line(points={{-80.6897,77.6256},{-80.6897,-90.3744}}, color={192,192, 
              192}), 
        Polygon(
          points={{-79.7044,90.6305},{-87.7044,68.6305},{-71.7044,68.6305},{-79.7044, 
              88.6305},{-79.7044,90.6305}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}), 
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}}, 
          lineColor={192,192,192}, 
          fillColor={192,192,192}, 
          fillPattern=FillPattern.Solid), 
        Text(
          extent={{0,0},{60,-60}}, 
          textColor={192,192,192}, 
          textString="PTn"), 
        Line(points={{-80.7599,-80.5082},{-70.7599,-74.5082},{-56,-60},{-48,-42}, 
              {-42,-18},{-36,4},{-26,20},{-10.7599,34.9018},{-0.759907, 
              38.8218},{9.24009,41.6818},{19.2401,43.7818},{29.2401,45.3118}, 
              {39.2401,46.4318},{49.2401,47.2518},{59.2401,47.8518},{69.2401, 
              48.2918},{79.2401,48.6118}}, color={0,0,127}), 
        Text(
          extent={{-70,94},{26,48}}, 
          textColor={192,192,192}, 
          textString="%n"), 
        Text(
          extent={{8,-106},{8,-146}}, 
          textString="f=%f")}), 
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{40,0},{-40,0}}), 
        Text(
          extent={{-55,55},{55,5}}, 
          textString="1"), 
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}), 
        Line(points={{-100,0},{-60,0}}, color={0,0,255}), 
        Line(points={{60,0},{100,0}}, color={0,0,255}), 
        Text(
          extent={{-54,-6},{44,-56}}, 
          textString="(s/w + 1)"), 
        Text(
          extent={{38,-10},{58,-30}}, 
          textString="n")}), 
    Documentation(info="<html><p>
这个模块定义了输入 u 和输出 y 之间的传递函数， 作为一个具有<em> </em><span style=\"color: rgb(51, 51, 51);\"><em>临界阻尼</em></span> 特性和截止频率 f 的 n 阶滤波器。 它是 <a href=\"modelica://Modelica.Blocks.Continuous.CriticalDamping\" target=\"\">Modelica.Blocks.Continuous.CriticalDamping</a>&nbsp; 模块的一个略微简化版本。 与连续时间分区不同，它并不提供相同的初始化能力， 因为时钟分区的初始化目前使用了不同的方法。
</p>
</html>"));
end CriticalDamping;