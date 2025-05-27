within Modelica.Thermal.FluidHeatFlow.BaseClasses;
partial model SinglePortBottom "底部单接口基类模型"
  parameter FluidHeatFlow.Media.Medium medium=FluidHeatFlow.Media.Medium() 
    "介质" annotation (choicesAllMatching=true);
  parameter SI.Temperature T0(start=293.15, displayUnit="degC") 
    "介质初始温度";
  parameter Boolean T0fixed=false 
    "初始温度估计值或固定值" 
  annotation(choices(checkBox=true));
  output SI.Temperature T_port "flowPort_a 的温度";
  output SI.Temperature T(start=T0, fixed=T0fixed) "介质出口温度";
  FluidHeatFlow.Interfaces.FlowPort_a flowPort(final medium=medium) 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
protected
  constant Boolean Exchange=true "通过流体接口交换介质" 
    annotation(HideResult=true);
  SI.SpecificEnthalpy h "体积比焓";
equation
  T_port=flowPort.h/medium.cp;
  T=h/medium.cp;
  // 质量流量 -> 环境：混合规则
  // 质量流 <- 环境温度：由环境温度定义的能量流
  if Exchange then
    flowPort.H_flow = semiLinear(flowPort.m_flow,flowPort.h,h);
  else
    h=flowPort.h;
  end if;
annotation (Documentation(info="<html><p>
底部单接口基类模型，定义接口处的介质和温度。
</p>
</html>"), 
     Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100}, 
            {100,100}}), graphics={       Text(
          extent={{-150,140},{150,100}}, 
          textColor={0,0,255}, 
          textString="%name")}));
end SinglePortBottom;