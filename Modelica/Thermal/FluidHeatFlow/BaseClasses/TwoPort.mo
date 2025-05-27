within Modelica.Thermal.FluidHeatFlow.BaseClasses;
partial model TwoPort "两个接口的基类模型"
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
    "组件中的介质" annotation (choicesAllMatching=true);
  parameter SI.Mass m(start=1) "介质质量";
  parameter SI.Temperature T0(start=293.15, displayUnit="degC") 
    "介质初始温度" 
    annotation(Dialog(enable=m>Modelica.Constants.small));
  parameter Boolean T0fixed=false 
    "初始温度估计值或固定值" 
  annotation(choices(checkBox=true),Dialog(enable=m>Modelica.Constants.small));
  parameter Real tapT(final min=0, final max=1)=1 
    "定义热接口在入口和出口温度之间的温度";
  SI.Pressure dp "压降 a->b";
  SI.VolumeFlowRate V_flow(start=0) "体积流量 a->b";
  SI.HeatFlowRate Q_flow "与环境进行热交换";
  output SI.Temperature T(start=T0, fixed=T0fixed) 
    "介质出口温度";
  output SI.Temperature T_a "flowPort_a 的温度";
  output SI.Temperature T_b "flowPort_b 的温度";
  output SI.TemperatureDifference dT 
    "冷却剂在流动方向的温度升高";
  SI.Temperature T_q 
    "与环境热交换有关的温度";
protected
  SI.SpecificEnthalpy h(start=medium.cp*T0) "介质的比焓";
public
  FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=medium) 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=medium) 
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  dp=flowPort_a.p - flowPort_b.p;
  V_flow=flowPort_a.m_flow/medium.rho;
  T_a=flowPort_a.h/medium.cp;
  T_b=flowPort_b.h/medium.cp;
  dT=if noEvent(V_flow>=0) then T-T_a else T_b-T;
  h = medium.cp*T;
  T_q = T  - noEvent(sign(V_flow))*(1 - tapT)*dT;
  // 质量平衡
  flowPort_a.m_flow + flowPort_b.m_flow = 0;
  // 能量平衡
  if m>Modelica.Constants.small then
    flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = m*medium.cv*der(T);
  else
    flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = 0;
  end if;
  // a 处的质量流 a->b 混合规则，b 处的能量流由介质温度定义
  // b 处的质量流 b->a 混合规则，a 处的能量流由介质温度决定
  flowPort_a.H_flow = semiLinear(flowPort_a.m_flow,flowPort_a.h,h);
  flowPort_b.H_flow = semiLinear(flowPort_b.m_flow,flowPort_b.h,h);
annotation (Documentation(info="<html><p>
有两个流体接口的基类模型。
</p>
<p>
与周围环境进行热交换由 Q_flow 定义；设置 Q_flow = 0 表示没有能量交换。
</p>
<p>
将参数 m（管道内介质的质量）设为零，可忽略温度瞬态项 cv*m*der(T).
</p>
<p>
采用混合规则。
</p>
<p>
参数 0 &lt; tapT &lt; 1 定义介质入口和出口温度之间的热接口温度。
</p>
</html>"));
end TwoPort;