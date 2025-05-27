within Modelica.Thermal.FluidHeatFlow.Components;
model Pipe "可选热交换管"
  extends FluidHeatFlow.BaseClasses.TwoPort;
  extends FluidHeatFlow.BaseClasses.SimpleFriction;

  parameter Boolean useHeatPort = false "= true, 如果HeatPort已开启" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter SI.Length h_g(start=0) 
    "高度差(从flowPort_a到flowPort_b的高差)";
  parameter SI.Acceleration g(final min=0)=Modelica.Constants.g_n "重力加速度";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(T=T_q, Q_flow=Q_flowHeatPort) if useHeatPort 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  SI.HeatFlowRate Q_flowHeatPort "条件热口的热流";
equation
  if not useHeatPort then
    Q_flowHeatPort=0;
  end if;
  // 与FrictionModel耦合
  volumeFlow = V_flow;
  dp = pressureDrop + medium.rho*g*h_g;
  // 与介质进行热交换
  Q_flow = Q_flowHeatPort + Q_friction;
annotation (Documentation(info="<html><p>
具有可选热交换的管道。
</p>
<p>
热力学方程由BaseClass.TwoPort定义。 Q_flow由heatPort定义。Q_flow (useHeatPort=true)或0 (useHeatPort=false)。
</p>
<p>
<strong>注释:</strong> 将参数m(管道内介质质量)设置为零，导致忽略温度瞬态项cv*m*der(T)。
</p>
<p>
<strong>注释:</strong> 在质量流量为零的管道中注入热量会导致温度升高，这由介质质量中的热量存储定义。
</p>
</html>"), 
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100, 
            100}}), graphics={
        Rectangle(
          extent={{-90,20},{90,-20}}, 
          lineColor={255,0,0}, 
          fillColor={0,0,255}, 
          fillPattern=FillPattern.Solid), 
        Polygon(visible=useHeatPort, 
          points={{-10,-90},{-10,-40},{0,-20},{10,-40},{10,-90},{-10,-90}}, 
          lineColor={255,0,0}),           Text(extent={{-150,80},{150,40}}, 
          textString="%name", 
          textColor={0,0,255})}));
end Pipe;