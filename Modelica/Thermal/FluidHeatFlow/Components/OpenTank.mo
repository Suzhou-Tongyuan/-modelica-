within Modelica.Thermal.FluidHeatFlow.Components;
model OpenTank "环境压力下的储罐模型"
  extends FluidHeatFlow.BaseClasses.SinglePortBottom(final Exchange=true);

  parameter SI.Area ATank(start=1) "储罐截面";
  parameter SI.Length hTank(start=1) "储罐高度";
  parameter SI.Pressure pAmbient(start=0) "环境压力";
  parameter SI.Acceleration g(final min=0)=Modelica.Constants.g_n "重力加速度";
  parameter Boolean useHeatPort = false "= true, 如果HeatPort已开启" 
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  SI.Mass m "罐内介质质量";
protected
  SI.Enthalpy H "介质的焓";
  SI.HeatFlowRate Q_flow "可选的heatPort的热流";
public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(final T=T, final Q_flow=Q_flow) if useHeatPort 
    "可选端口，用于冷却或加热罐内的介质" 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}), 
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Blocks.Interfaces.RealOutput level(quantity="Length", unit="m", start=0) 
    "罐内介质液位" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=180, 
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealOutput TTank(quantity="Temperature", unit="K", displayUnit="degC") 
    "罐内介质温度" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}}, 
        rotation=180, 
        origin={110,-60})));
equation
  //输出介质温度
  TTank = T;
  //可选的加热/冷却
  if not useHeatPort then
    Q_flow = 0;
  end if;
  //液位检查
  assert(level>=0, "储罐是空的!");
  assert(level<=hTank, "储罐满了!");
  //质量守恒
  m = medium.rho*ATank*level;
  der(m) = flowPort.m_flow;
  //能量守恒
  H = m*h;
  der(H) = flowPort.H_flow + Q_flow;
  //底部压力
  flowPort.p = pAmbient + m*g/ATank;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-80,-60},{80,-100}}, 
          fillColor={170,170,255}, 
          fillPattern=FillPattern.Sphere), 
        Rectangle(
          extent={{-80,0},{80,-80}}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={170,170,255}), 
        Rectangle(
          extent={{-80,80},{80,0}}, 
          fillPattern=FillPattern.VerticalCylinder, 
          fillColor={255,255,255}), 
        Ellipse(
          extent={{-80,100},{80,60}}, 
          fillColor={255,255,255}, 
          fillPattern=FillPattern.Sphere), 
        Ellipse(
          extent={{-80,20},{80,-20}}, 
          fillColor={170,170,255}, 
          fillPattern=FillPattern.Sphere), 
        Line(points={{100,0},{80,0}}, thickness=0.5), 
        Line(points={{100,-60},{80,-60}}, 
                                        color={238,46,47}, 
          thickness=0.5), 
        Ellipse(
          extent={{72,-56},{80,-64}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5, 
          fillColor={238,46,47}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(visible=useHeatPort, 
          extent={{-80,-74},{-68,-86}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5, 
          fillColor={170,170,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(visible=useHeatPort, 
          extent={{-68,-78},{-56,-90}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5, 
          fillColor={170,170,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(visible=useHeatPort, 
          extent={{-56,-82},{-44,-94}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5, 
          fillColor={170,170,255}, 
          fillPattern=FillPattern.Solid), 
        Ellipse(visible=useHeatPort, 
          extent={{-44,-84},{-32,-96}}, 
          lineColor={238,46,47}, 
          lineThickness=0.5, 
          fillColor={170,170,255}, 
          fillPattern=FillPattern.Solid), 
        Line(visible=useHeatPort, 
          points={{-90,-100},{-56,-100},{-56,-88}}, 
          color={238,46,47}, 
          thickness=0.5)}),    Documentation(info="<html><p>
这是一个体积为a *h的开放式水箱的简单模型。测量介质的液位和温度并作为输出提供。
</p>
<p>
注释: 如果液位高度达到0(最小)或h(最大)，则触发断言。
</p>
<p>
注释: 假定flowPort位于底部。因此，在流动端口的压力是ambient pressure + level*rho*g。
</p>
<li>
如果端口的质量流量进入罐内，则液位增加，并应用混合规则来获得罐内介质的温度变化。</li>
<li>
如果端口的质量流量流出油箱，则液位降低; 流出介质的温度由罐内介质的温度决定。</li>
<p>
假定罐内的介质在整个容积内具有相同的温度，即完全混合。
</p>
<p>
通过可选的heatPort，可以冷却或加热罐内的介质。
</p>
</html>"));
end OpenTank;